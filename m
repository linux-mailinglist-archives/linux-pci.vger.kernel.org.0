Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0220A63F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406936AbgFYT6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 15:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406569AbgFYT6X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 15:58:23 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDD7206A5;
        Thu, 25 Jun 2020 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593115102;
        bh=dyLST9MuMknNIoJ/bqqmhoGtr5xNyhepxCilwqcM8SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ci/khozqAkODT0b/ot6jPxeLDGfu4ewXRK7AQ5RfkDCNt9yCc1pYARcThxjciXm0c
         FwmoZc6DO1oSrMA/grTLbu24uAZGIkrxgw56+OKb2cBKbKc2t9TpVzpGfwGrwUtfLV
         ZR12ilC829DG03iSM7DJRQyMI8tYh/asmFzCNx2c=
Date:   Thu, 25 Jun 2020 14:58:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Message-ID: <20200625195820.GA2701690@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625162450.5419-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas]

On Thu, Jun 25, 2020 at 12:24:49PM -0400, Jon Derrick wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> The VMD domain does not subscribe to ACPI, and so does not operate on
> it's irqdomain fwnode. It was freeing the handle after allocation of the
> domain. As of 181e9d4efaf6a (irqdomain: Make __irq_domain_add() less
> OF-dependent), the fwnode is put during irq_domain_remove causing a page
> fault. This patch keeps VMD's fwnode allocated through the lifetime of
> the VMD irqdomain.
> 
> Fixes: ae904cafd59d ("PCI/vmd: Create named irq domain")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> Hi Lorenzo, Bjorn,
> 
> Please take this patch for v5.8 fixes. It fixes an issue during VMD
> unload.

I tentatively applied this to for-linus for v5.8.

But I would like to clarify the commit log.  It says this fixes
Thomas' ae904cafd59d ("PCI/vmd: Create named irq domain").  That
appeared in v4.13, which suggests that this patch should be backported
to v4.13 and later.

But it's not clear to me that ae904cafd59d is actually broken, since
the log also says the problem appeared after 181e9d4efaf6 ("irqdomain:
Make __irq_domain_add() less OF-dependent"), which we just merged for
v5.8-rc1.

And obviously, freeing the fwnode doesn't *cause* a page fault.  A
use-after-free might cause a fault, but it's not clear where that
happens.  I guess fwnode is used in the interval between:

  vmd_enable_domain
    pci_msi_create_irq_domain

  ...        <-- fwnode used here somewhere

  vmd_remove
    vmd_cleanup_srcu
      irq_domain_free_fwnode

But I can't tell how 181e9d4efaf6a and/or ae904cafd59d are related to
that.

>  drivers/pci/controller/vmd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e386d4eac407..ebec0a6e77ed 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -546,9 +546,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
>  						    x86_vector_domain);
> -	irq_domain_free_fwnode(fn);
> -	if (!vmd->irq_domain)
> +	if (!vmd->irq_domain) {
> +		irq_domain_free_fwnode(fn);
>  		return -ENODEV;
> +	}
>  
>  	pci_add_resource(&resources, &vmd->resources[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
> @@ -559,6 +560,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	if (!vmd->bus) {
>  		pci_free_resource_list(&resources);
>  		irq_domain_remove(vmd->irq_domain);
> +		irq_domain_free_fwnode(fn);
>  		return -ENODEV;
>  	}
>  
> @@ -672,6 +674,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
>  static void vmd_remove(struct pci_dev *dev)
>  {
>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
> +	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
>  
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_stop_root_bus(vmd->bus);
> @@ -679,6 +682,7 @@ static void vmd_remove(struct pci_dev *dev)
>  	vmd_cleanup_srcu(vmd);
>  	vmd_detach_resources(vmd);
>  	irq_domain_remove(vmd->irq_domain);
> +	irq_domain_free_fwnode(fn);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.18.1
> 
