Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC71613408
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 21:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfECTb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 15:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfECTb6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 May 2019 15:31:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B19D2075C;
        Fri,  3 May 2019 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556911917;
        bh=8X8KDRCZFJIepA6RhYMI2HzfxrLSDFRfqaOavuqL6uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wkYZLMPnjLtT3C3csz9USu8shMpJf+8alN4lrHQZfNbi9uPX83zjrOW5deIfVmZ4N
         z8EafpcLZC6AVJNXjBQRBulPTWtohge5nMA7N7ugZXqr2qeu8XSJAvtkpEi+4qElWC
         87edOm/1jWqS8AYX5hEjHLuCLpXl6PsbV1+nrDsg=
Date:   Fri, 3 May 2019 14:31:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 1/9] PCI/AER: Cleanup dmesg logs
Message-ID: <20190503193154.GA180403@google.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-2-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-2-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 10:59:38PM -0500, Frederick Lawler wrote:
> Cleanup dmesg logs.

To specific, I think you did this:

  - Drop the kzalloc() failure message because those failures are logged
    elsewhere.

  - Convert other printk(KERN_DEBUG) to pci_info() or dev_err() as
    appropriate because printk(KERN_DEBUG) is ugly and don't match the
    other logging.  These could have been converted to pci_dbg() or
    dev_dbg() instead, but that would make them depend on
    CONFIG_DYNAMIC_DEBUG or DEBUG, and these messages are important enough
    that we always want them.

I think the summary (subject line) is something like:

  PCI/AER: Convert printk(KERN_DEBUG) to pci_info() or dev_err()

> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/pcie/aer.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f8fc2114ad39..82eb45335b6f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -964,8 +964,8 @@ static bool find_source_device(struct pci_dev *parent,
>  	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>  
>  	if (!e_info->error_dev_num) {
> -		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
> -			   e_info->id);
> +		pci_info(parent, "can't find device of ID%04x\n",
> +			 e_info->id);
>  		return false;
>  	}
>  	return true;
> @@ -1380,7 +1380,6 @@ static int aer_probe(struct pcie_device *dev)
>  
>  	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
>  	if (!rpc) {
> -		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
>  		return -ENOMEM;
>  	}
>  	rpc->rpd = dev->port;
> @@ -1389,8 +1388,8 @@ static int aer_probe(struct pcie_device *dev)
>  	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
>  					   IRQF_SHARED, "aerdrv", dev);
>  	if (status) {
> -		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
> -			   dev->irq);
> +		dev_err(device, "request AER IRQ %d failed\n",
> +			dev->irq);
>  		return status;
>  	}
>  
> @@ -1419,7 +1418,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
>  
>  	rc = pci_bus_error_reset(dev);
> -	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
> +	pci_info(dev, "Root Port link has been reset\n");
>  
>  	/* Clear Root Error Status */
>  	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> -- 
> 2.17.1
> 
