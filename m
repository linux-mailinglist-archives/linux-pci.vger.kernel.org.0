Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE7DA02
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 02:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfD2ADC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Apr 2019 20:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfD2ADB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Apr 2019 20:03:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F28A2067D;
        Mon, 29 Apr 2019 00:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556496180;
        bh=SNV29roq9n8ljonHOEXZwnXV/kdpfxya7VGch726Yo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jW5mHxZv43Xy7FveF+EnKDoBhcUdHg1GcKsULyynlvt53L5CbercGug4jqciQfpOw
         +YKtVSM1cJLikNcVM7t6e4cskgp0gKHj8rl+FhEcMHJhNxqs8ENU52ZNBTDtK4gFFQ
         dtz+mGianchZyt5i1o/sIBiVHAc4AuixdSzmEAt4=
Date:   Sun, 28 Apr 2019 19:02:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     fred@fredlawl.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH 1/4] PCI: Replace dev_*() printk wrappers with pci_*()
 printk wrappers
Message-ID: <20190429000258.GK14616@google.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-2-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427191304.32502-2-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 27, 2019 at 02:13:01PM -0500, fred@fredlawl.com wrote:
> From: Frederick Lawler <fred@fredlawl.com>
> 
> Replace remaining instances of dev_*() printk wrappers with pci_*()
> printk wrappers. No functional change intended.
> 
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/pcie/aer.c        | 13 ++++++-------
>  drivers/pci/pcie/aer_inject.c |  4 ++--
>  drivers/pci/pcie/dpc.c        | 27 ++++++++++++---------------
>  3 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f8fc2114ad39..224d878a28b4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -964,8 +964,7 @@ static bool find_source_device(struct pci_dev *parent,
>  	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>  
>  	if (!e_info->error_dev_num) {
> -		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
> -			   e_info->id);
> +		pci_dbg(parent, "can't find device of ID%04x\n", e_info->id);

I don't like dev_dbg() and pci_dbg() because the behavior depends on
CONFIG_DYNAMIC_DEBUG, DEBUG, etc.

They may be fine for development, but for production, I want to be
able to users for "a complete dmesg log".  I don't want to have to ask
them to "please rebuild your kernel with CONFIG_DYNAMIC_DEBUG=n and
boot with 'dyndbg=xxx'"

For that reason I prefer the "pci_printk(KERN_DEBUG)" because that
output always goes to the dmesg log.

But "pci_printk(KERN_DEBUG)" is definitely ugly.  I think the way to
fix that is to convert it to "pci_info()" instead.

>  		return false;
>  	}
>  	return true;
> @@ -1377,10 +1376,11 @@ static int aer_probe(struct pcie_device *dev)
>  	int status;
>  	struct aer_rpc *rpc;
>  	struct device *device = &dev->device;
> +	struct pci_dev *pdev = dev->port;
>  
>  	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
>  	if (!rpc) {
> -		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
> +		pci_dbg(pdev, "alloc AER rpc failed\n");

This hunk converts from using the pcie_device to the pci_dev, so it
belongs in a different patch.

>  		return -ENOMEM;
>  	}
>  	rpc->rpd = dev->port;
> @@ -1389,13 +1389,12 @@ static int aer_probe(struct pcie_device *dev)
>  	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
>  					   IRQF_SHARED, "aerdrv", dev);
>  	if (status) {
> -		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
> -			   dev->irq);
> +		pci_dbg(pdev, "request AER IRQ %d failed\n", dev->irq);
>  		return status;

This one also.

>  	}
>  
>  	aer_enable_rootport(rpc);
> -	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
> +	pci_info(pdev, "AER enabled with IRQ %d\n", dev->irq);

And this, and many others below.  *This* patch should only convert

  - pci_printk(KERN_DEBUG, pdev, ...)
  + pci_info(pdev, ...)

and

  - dev_printk(KERN_DEBUG, pcie_dev, ...)
  + dev_info(pcie_dev, ...)

>  	return 0;
>  }
>  
> @@ -1419,7 +1418,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
>  
>  	rc = pci_bus_error_reset(dev);
> -	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
> +	pci_dbg(dev, "Root Port link has been reset\n");
>  
>  	/* Clear Root Error Status */
>  	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 95d4759664b3..610b617ae600 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -460,12 +460,12 @@ static int aer_inject(struct aer_error_inj *einj)
>  	if (device) {
>  		edev = to_pcie_device(device);
>  		if (!get_service_data(edev)) {
> -			dev_warn(&edev->device,
> +			pci_warn(edev->port,
>  				 "aer_inject: AER service is not initialized\n");
>  			ret = -EPROTONOSUPPORT;
>  			goto out_put;
>  		}
> -		dev_info(&edev->device,
> +		pci_info(edev->port,
>  			 "aer_inject: Injecting errors %08x/%08x into device %s\n",
>  			 einj->cor_status, einj->uncor_status, pci_name(dev));
>  		local_irq_disable();
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 7b77754a82de..72659286191b 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -100,7 +100,6 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>  {
>  	unsigned long timeout = jiffies + HZ;
>  	struct pci_dev *pdev = dpc->dev->port;
> -	struct device *dev = &dpc->dev->device;
>  	u16 cap = dpc->cap_pos, status;
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> @@ -110,7 +109,7 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>  		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>  	}
>  	if (status & PCI_EXP_DPC_RP_BUSY) {
> -		dev_warn(dev, "DPC root port still busy\n");
> +		pci_warn(pdev, "DPC root port still busy\n");
>  		return -EBUSY;
>  	}
>  	return 0;
> @@ -148,7 +147,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  
>  static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  {
> -	struct device *dev = &dpc->dev->device;
>  	struct pci_dev *pdev = dpc->dev->port;
>  	u16 cap = dpc->cap_pos, dpc_status, first_error;
>  	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
> @@ -156,13 +154,13 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, &status);
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK, &mask);
> -	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
> +	pci_err(pdev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
>  		status, mask);
>  
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY, &sev);
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR, &syserr);
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION, &exc);
> -	dev_err(dev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
> +	pci_err(pdev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
>  		sev, syserr, exc);
>  
>  	/* Get First Error Pointer */
> @@ -171,7 +169,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  
>  	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
>  		if ((status & ~mask) & (1 << i))
> -			dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
> +			pci_err(pdev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
>  				first_error == i ? " (First)" : "");
>  	}
>  
> @@ -185,18 +183,18 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  			      &dw2);
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
>  			      &dw3);
> -	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
> +	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
>  		dw0, dw1, dw2, dw3);
>  
>  	if (dpc->rp_log_size < 5)
>  		goto clear_status;
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
> -	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", log);
> +	pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
>  
>  	for (i = 0; i < dpc->rp_log_size - 5; i++) {
>  		pci_read_config_dword(pdev,
>  			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
> -		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
> +		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
>  	}
>   clear_status:
>  	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
> @@ -229,18 +227,17 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  	struct aer_err_info info;
>  	struct dpc_dev *dpc = context;
>  	struct pci_dev *pdev = dpc->dev->port;
> -	struct device *dev = &dpc->dev->device;
>  	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
>  
> -	dev_info(dev, "DPC containment event, status:%#06x source:%#06x\n",
> +	pci_info(pdev, "DPC containment event, status:%#06x source:%#06x\n",
>  		 status, source);
>  
>  	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
>  	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
> -	dev_warn(dev, "DPC %s detected\n",
> +	pci_warn(pdev, "DPC %s detected\n",
>  		 (reason == 0) ? "unmasked uncorrectable error" :
>  		 (reason == 1) ? "ERR_NONFATAL" :
>  		 (reason == 2) ? "ERR_FATAL" :
> @@ -307,7 +304,7 @@ static int dpc_probe(struct pcie_device *dev)
>  					   dpc_handler, IRQF_SHARED,
>  					   "pcie-dpc", dpc);
>  	if (status) {
> -		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
> +		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
>  			 status);
>  		return status;
>  	}
> @@ -319,7 +316,7 @@ static int dpc_probe(struct pcie_device *dev)
>  	if (dpc->rp_extensions) {
>  		dpc->rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
>  		if (dpc->rp_log_size < 4 || dpc->rp_log_size > 9) {
> -			dev_err(device, "RP PIO log size %u is invalid\n",
> +			pci_err(pdev, "RP PIO log size %u is invalid\n",
>  				dpc->rp_log_size);
>  			dpc->rp_log_size = 0;
>  		}
> @@ -328,7 +325,7 @@ static int dpc_probe(struct pcie_device *dev)
>  	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>  
> -	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
> +	pci_info(pdev, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
>  		cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
>  		FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
>  		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
> -- 
> 2.17.1
> 
