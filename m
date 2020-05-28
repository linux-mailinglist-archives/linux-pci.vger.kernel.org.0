Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812711E6D7D
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 23:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436547AbgE1VSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 17:18:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:61069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436543AbgE1VSn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 17:18:43 -0400
IronPort-SDR: BC49y7K5BgYLTB0PeyRL5FEzNMFM674uOqPUmJoo5GOQoHQnabDEY6cZE45lSblC38aaRGYCbG
 Q6KCJOWBQDCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 14:18:42 -0700
IronPort-SDR: 4AScpdRfM/Qz6G0HI8poSM3B9H5Mqkq5vrBTOmecqUhhBSB1772DdFAAsj45uU0XmppsLIFVUS
 1ihVdZLx2rfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="311045002"
Received: from vvhadaga-mobl.amr.corp.intel.com (HELO [10.254.98.146]) ([10.254.98.146])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 14:18:42 -0700
Subject: Re: [PATCH] PCI: ERR: Don't override the status returned by
 error_detect()
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com
References: <20200527083130.4137-1-Zhiqiang.Hou@nxp.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <84a2bc7e-7556-96ff-6cd5-988d432ad8e3@linux.intel.com>
Date:   Thu, 28 May 2020 14:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527083130.4137-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/27/20 1:31 AM, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> overrode the 'status' returned by the error_detect() call back function,
> which is depended on by the next step. This overriding makes the Endpoint
> driver's required info (kept in the var status) lost, so it results in the
> fatal errors' recovery failed and then kernel panic.
Can you explain why updating status affects the recovery ?
> 
> In the e1000e case, the error logs:
> pcieport 0002:00:00.0: AER: Uncorrected (Fatal) error received: 0002:01:00.0
> e1000e 0002:01:00.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent ID)
> pcieport 0002:00:00.0: AER: Root Port link has been reset
As per above commit log, it looks like link is reset correctly.
> SError Interrupt on CPU0, code 0xbf000002 -- SError
> CPU: 0 PID: 111 Comm: irq/76-aerdrv Not tainted 5.7.0-rc7-next-20200526 #8
> Hardware name: LS1046A RDB Board (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO BTYPE=--)
> pc : __pci_enable_msix_range+0x4c8/0x5b8
> lr : __pci_enable_msix_range+0x480/0x5b8
> sp : ffff80001116bb30
> x29: ffff80001116bb30 x28: 0000000000000003
> x27: 0000000000000003 x26: 0000000000000000
> x25: ffff00097243e0a8 x24: 0000000000000001
> x23: ffff00097243e2d8 x22: 0000000000000000
> x21: 0000000000000003 x20: ffff00095bd46080
> x19: ffff00097243e000 x18: ffffffffffffffff
> x17: 0000000000000000 x16: 0000000000000000
> x15: ffffb958fa0e9948 x14: ffff00095bd46303
> x13: ffff00095bd46302 x12: 0000000000000038
> x11: 0000000000000040 x10: ffffb958fa101e68
> x9 : ffffb958fa101e60 x8 : 0000000000000908
> x7 : 0000000000000908 x6 : ffff800011600000
> x5 : ffff00095bd46800 x4 : ffff00096e7f6080
> x3 : 0000000000000000 x2 : 0000000000000000
> x1 : 0000000000000000 x0 : 0000000000000000
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 0 PID: 111 Comm: irq/76-aerdrv Not tainted 5.7.0-rc7-next-20200526 #8
> 
> I think it's the expected result that "if the initial value of error
> status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER
> then even after successful recovery (using reset_link()) pcie_do_recovery()
> will report the recovery result as failure" which is described in
> commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()").
> 
> Refer to the Documentation/PCI/pci-error-recovery.rst.
> As the error_detect() is mandatory callback if the pci_err_handlers is
> implemented, if it return the PCI_ERS_RESULT_DISCONNECT, it means the
> driver doesn't want to recover at all;
> For the case PCI_ERS_RESULT_NO_AER_DRIVER, if the pci_err_handlers is not
> implemented, the failure is more expected.
> 
> Fixes: commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>   drivers/pci/pcie/err.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..84f72342259c 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -165,8 +165,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	pci_dbg(dev, "broadcast error_detected message\n");
>   	if (state == pci_channel_io_frozen) {
>   		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
>   			pci_warn(dev, "link reset failed\n");
>   			goto failed;
>   		}
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
