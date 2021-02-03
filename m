Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E836C30D02A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 01:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhBCAKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 19:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231381AbhBCAKf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 19:10:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30F0064F61;
        Wed,  3 Feb 2021 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612310994;
        bh=IyFff5HKKoZo9RfKCAvlVyVIufom9G9RHPEvnI7B8Ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IGW4jwwYqZK5m814diEeAx77Vr4cF3B4sQdJZ4fHMhNEgEg3oBcK9Yi4JWZYm0CPl
         ShKkknjEtG1Tr96DM3klUwELlY4/S1k66rr4KIdhDjt+/E2D9b0dP54uoHTGlKWVas
         AK+FGAYNnjJkg1RFkbdHzp65KfAX+9B16KBzxVU6lv52suu3aN2cdCmmYouEhkGWz6
         KtGSgCofq4BGiZpnhvFm6HRnljcgYuz2PF7vwDydwBtMv3dizfTmjzRiV2NhU4oTn/
         sZvtGOVaW2yKDLPdgH1Kn7txIgQjPLIq4zk+lvCPiRtCugG54/i5R2++cXdi7tpwiU
         vMdNCbYJg5BhA==
Date:   Tue, 2 Feb 2021 18:09:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI/VPD: Improve handling binary sysfs attribute
Message-ID: <20210203000952.GA151813@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f527283c-3e4e-5574-e917-519a6cc0e8b9@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 07, 2021 at 10:48:55PM +0100, Heiner Kallweit wrote:
> Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
> there's nothing that keeps us from using a static attribute.
> This allows to significantly simplify the code.

I love this!  A few comments below.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c | 42 +++++++++++-------------------------------
>  1 file changed, 11 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index a3fd09105..9ef8f400e 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -21,7 +21,6 @@ struct pci_vpd_ops {
>  
>  struct pci_vpd {
>  	const struct pci_vpd_ops *ops;
> -	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
>  	struct mutex	lock;
>  	unsigned int	len;
>  	u16		flag;
> @@ -397,57 +396,38 @@ void pci_vpd_release(struct pci_dev *dev)
>  	kfree(dev->vpd);
>  }
>  
> -static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
> -			     struct bin_attribute *bin_attr, char *buf,
> -			     loff_t off, size_t count)
> +static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
> +			struct bin_attribute *bin_attr, char *buf,
> +			loff_t off, size_t count)
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>  
>  	return pci_read_vpd(dev, off, count, buf);
>  }
>  
> -static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
> -			      struct bin_attribute *bin_attr, char *buf,
> -			      loff_t off, size_t count)
> +static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *buf,
> +			 loff_t off, size_t count)
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>  
>  	return pci_write_vpd(dev, off, count, buf);
>  }
>  
> +static const BIN_ATTR_RW(vpd, 0);

Wow, I'm surprised that there are only 50ish uses of BIN_ATTR_*():
s390/crypto, w1/slaves/..., and a few other places.  It always makes
me wonder when we're one of a small number of callers.  Seems OK
though.

>  void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev)
>  {
> -	int retval;
> -	struct bin_attribute *attr;
> -
>  	if (!dev->vpd)
>  		return;
>  
> -	attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
> -	if (!attr)
> -		return;
> -
> -	sysfs_bin_attr_init(attr);
> -	attr->size = 0;
> -	attr->attr.name = "vpd";
> -	attr->attr.mode = S_IRUSR | S_IWUSR;
> -	attr->read = read_vpd_attr;
> -	attr->write = write_vpd_attr;
> -	retval = sysfs_create_bin_file(&dev->dev.kobj, attr);
> -	if (retval) {
> -		kfree(attr);
> -		return;
> -	}
> -
> -	dev->vpd->attr = attr;

Above is awesome.  Also maybe confirms that we could remove the
"attr->size = 0" assignment in the previous patch?

> +	if (sysfs_create_bin_file(&dev->dev.kobj, &bin_attr_vpd))
> +		pci_warn(dev, "can't create VPD sysfs file\n");

Not sure we need this.  Can't we use the .is_visible() thing and an
attribute group to get rid of the explicit sysfs_create_bin_file()?

>  }
>  
>  void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev)
>  {
> -	if (dev->vpd && dev->vpd->attr) {
> -		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
> -		kfree(dev->vpd->attr);
> -	}
> +	sysfs_remove_bin_file(&dev->dev.kobj, &bin_attr_vpd);
>  }
>  
>  int pci_vpd_find_tag(const u8 *buf, unsigned int off, unsigned int len, u8 rdt)
> -- 
> 2.30.0
> 
> 
