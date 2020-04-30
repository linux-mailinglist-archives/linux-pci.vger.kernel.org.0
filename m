Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC931BED7B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 03:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD3BPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 21:15:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:44154 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgD3BPe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 21:15:34 -0400
IronPort-SDR: vwk/ZkgrTLVWsfhR5vSmFcUjbP3TRo8auIXMWLOMXjaGTjgA7dFejBOwzZaQHpltuxbRvEcZGo
 NP6CQfchQaBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 18:15:33 -0700
IronPort-SDR: Lz6dwKrXX4kXbgy2YxPZXMCWA2X5hHq37SO7ePIAandywsyfhi5wgDT5/7n8HututjPp1qjgYV
 oX2EKGcWDohQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="432765667"
Received: from stamimi-mobl2.amr.corp.intel.com (HELO [10.254.111.80]) ([10.254.111.80])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2020 18:15:33 -0700
Subject: Re: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery
To:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
References: <12115.1588207324@famine>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <18897ceb-2263-1101-ae43-918a66794e14@linux.intel.com>
Date:   Wed, 29 Apr 2020 18:15:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <12115.1588207324@famine>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/29/20 5:42 PM, Jay Vosburgh wrote:
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

I think this issue is related to the issue discussed in following
thread (DPC non-hotplug support).

https://lkml.org/lkml/2020/3/28/328

If my assumption is correct, you are dealing with devices which are
not hotplug capable. If the devices are hotplug capable then you don't
need to proceed to report_slot_reset(), since hotplug handler will
remove/re-enumerate the devices correctly.

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
>   drivers/pci/pcie/err.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..e4274562f3a0 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -164,10 +164,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   
>   	pci_dbg(dev, "broadcast error_detected message\n");
>   	if (state == pci_channel_io_frozen) {
> +		pci_ers_result_t status2;
> +
>   		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		/* preserve status from report_frozen_detected to
> +		 * insure report_mmio_enabled or report_slot_reset are
> +		 * invoked even if reset_link returns _RECOVERED.
> +		 */
> +		status2 = reset_link(dev);
> +		if (status2 != PCI_ERS_RESULT_RECOVERED) {
>   			pci_warn(dev, "link reset failed\n");
> +			status = status2;
>   			goto failed;
>   		}
>   	} else {
> 
