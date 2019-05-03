Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538C31341C
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfECToX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 15:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfECToX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 May 2019 15:44:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14A22075E;
        Fri,  3 May 2019 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556912662;
        bh=BV9NRMwOAHVq0GZvRJ5UWT6w9ChUdtT+M3RTCm5jnXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z34rQpvz3wyYCf80v84Z9+AJoaCIYE0bTyFJAwxopffwZy0XYtqDHq13J8Y5R/gqV
         Pf8v/vMpI56ygdgWxW7aRCNkEtHLHNLkWWNgGplXJDe7IQZ0tfBX5OEm2/htksK2LN
         suDl+uKfLMhgdedEYBbLPNd/g0NGPjpSHBuiE/Sk=
Date:   Fri, 3 May 2019 14:44:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 2/9] PCI/DPC: Prefix dmesg logs with PCIe service name
Message-ID: <20190503194420.GB180403@google.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-3-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-3-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 10:59:39PM -0500, Frederick Lawler wrote:
> Prefix dmesg logs with PCIe service name.

The important thing about this patch is not so much that it adds a
prefix (actually, it basically *moves* the prefix from the driver name
("dpc") to being part of the messages ("DPC:")), but that it changes
the logging from being associated with the pcie_device to the pci_dev.
I think the message change will be something like this (which I would
include in the commit log):

  - dpc 0000:80:10.0:pcie008: DPC error containment capabilities: ...
  + pcieport 0000:80:10.0: DPC: error containment capabilities: ...

with a subject like:

  PCI/DPC: Log messages with pci_dev, not pcie_device

The above example assumes you drop the extra "DPC" as Keith suggested,
which I think I agree with.  Otherwise we'd have:

  + pcieport 0000:80:10.0: DPC: DPC error containment capabilities: ...

which is a little redundant.

You could even include a link like:

Link: https://lore.kernel.org/lkml/20190308180149.GD214730@google.com

> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/pcie/dpc.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 7b77754a82de..934391c91c23 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -6,6 +6,8 @@
>   * Copyright (C) 2016 Intel Corp.
>   */
>  
> +#define dev_fmt(fmt) "DPC: " fmt
> +
>  #include <linux/aer.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> @@ -100,7 +102,6 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>  {
>  	unsigned long timeout = jiffies + HZ;
>  	struct pci_dev *pdev = dpc->dev->port;
> -	struct device *dev = &dpc->dev->device;
>  	u16 cap = dpc->cap_pos, status;
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> @@ -110,7 +111,7 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>  		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>  	}
>  	if (status & PCI_EXP_DPC_RP_BUSY) {
> -		dev_warn(dev, "DPC root port still busy\n");
> +		pci_warn(pdev, "DPC root port still busy\n");
>  		return -EBUSY;
>  	}
>  	return 0;
> @@ -148,7 +149,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  
>  static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  {
> -	struct device *dev = &dpc->dev->device;
>  	struct pci_dev *pdev = dpc->dev->port;
>  	u16 cap = dpc->cap_pos, dpc_status, first_error;
>  	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
> @@ -156,13 +156,13 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
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
> @@ -171,7 +171,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  
>  	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
>  		if ((status & ~mask) & (1 << i))
> -			dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
> +			pci_err(pdev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
>  				first_error == i ? " (First)" : "");
>  	}
>  
> @@ -185,18 +185,18 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
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
> @@ -229,18 +229,17 @@ static irqreturn_t dpc_handler(int irq, void *context)
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
> @@ -307,7 +306,7 @@ static int dpc_probe(struct pcie_device *dev)
>  					   dpc_handler, IRQF_SHARED,
>  					   "pcie-dpc", dpc);
>  	if (status) {
> -		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
> +		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
>  			 status);
>  		return status;
>  	}
> @@ -319,7 +318,7 @@ static int dpc_probe(struct pcie_device *dev)
>  	if (dpc->rp_extensions) {
>  		dpc->rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
>  		if (dpc->rp_log_size < 4 || dpc->rp_log_size > 9) {
> -			dev_err(device, "RP PIO log size %u is invalid\n",
> +			pci_err(pdev, "RP PIO log size %u is invalid\n",
>  				dpc->rp_log_size);
>  			dpc->rp_log_size = 0;
>  		}
> @@ -328,11 +327,11 @@ static int dpc_probe(struct pcie_device *dev)
>  	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>  
> -	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
> -		cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
> -		FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
> -		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
> -		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
> +	pci_info(pdev, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
> +		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
> +		 FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
> +		 FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
> +		 FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
>  
>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16));
>  	return status;
> -- 
> 2.17.1
> 
