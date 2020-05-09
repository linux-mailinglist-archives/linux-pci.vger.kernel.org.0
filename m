Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63F61CBF1B
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEIIeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 04:34:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59872 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbgEIIeh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 May 2020 04:34:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9DB68CB884DC8E8DFBE3;
        Sat,  9 May 2020 16:34:33 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 16:34:23 +0800
Subject: Re: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery
To:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <12115.1588207324@famine>
From:   Yicong Yang <yangyicong@hisilicon.com>
CC:     liudongdong 00290354 <liudongdong3@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Message-ID: <c919a16f-0487-ffe2-1953-9587a6416a10@hisilicon.com>
Date:   Sat, 9 May 2020 16:34:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <12115.1588207324@famine>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ +cc dongdong as we met the issue ]

Hi,

The regression happened with our intel 82599 network adaptor. A DPC event
happened on the device, recovery returns successful but the device is
not enabled. As we only reset link, but don't call driver specific
handler(mmio enable/slot reset).

If we met an error with IO blocked, the logic should be:
1. try to reset link
2. broadcast report_frozen_detected on the bus
3. do what drivers suggest(mmio enable/slot reset)

Currently only step 1 is performed, and returns directly. I tried the
patch below and it solves the issues. The differences from Jay's one
is that it merge the return value to the status and it match the logic
I mentioned above.

Regards,
Yicong

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f5..6f8870c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -164,12 +164,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
        pci_dbg(dev, "broadcast error_detected message\n");
        if (state == pci_channel_io_frozen) {
-               pci_walk_bus(bus, report_frozen_detected, &status);
                status = reset_link(dev);
                if (status != PCI_ERS_RESULT_RECOVERED) {
                        pci_warn(dev, "link reset failed\n");
                        goto failed;
                }
+               pci_walk_bus(bus, report_frozen_detected, &status);
        } else {
                pci_walk_bus(bus, report_normal_detected, &status);
        }

On 2020/4/30 8:42, Jay Vosburgh wrote:
> 	Commit 6d2c89441571 ("PCI/ERR: Update error status after
> reset_link()"), introduced a regression, as pcie_do_recovery will
> discard the status result from report_frozen_detected.  This can cause a
> failure to recover if _NEED_RESET is returned by report_frozen_detected
> and report_slot_reset is not invoked.
>
> 	Such an event can be induced for testing purposes by reducing
> the Max_Payload_Size of a PCIe bridge to less than that of a device
> downstream from the bridge, and then initating I/O through the device,
> resulting in oversize transactions.  In the presence of DPC, this
> results in a containment event and attempted reset and recovery via
> pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not invoked,
> and the device does not recover.
>
> 	Inspection shows a similar path is plausible for a return of
> _CAN_RECOVER and the invocation of report_mmio_enabled.
>
> 	Resolve this by preserving the result of report_frozen_detected if
> reset_link does not return _DISCONNECT.
>
> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>
> ---
>  drivers/pci/pcie/err.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..e4274562f3a0 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -164,10 +164,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
> +		pci_ers_result_t status2;
> +
>  		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		/* preserve status from report_frozen_detected to
> +		 * insure report_mmio_enabled or report_slot_reset are
> +		 * invoked even if reset_link returns _RECOVERED.
> +		 */
> +		status2 = reset_link(dev);
> +		if (status2 != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(dev, "link reset failed\n");
> +			status = status2;
>  			goto failed;
>  		}
>  	} else {

