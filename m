Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0484C4F922
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2019 01:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFVXzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jun 2019 19:55:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40046 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfFVXzd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jun 2019 19:55:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so5106911pgj.7
        for <linux-pci@vger.kernel.org>; Sat, 22 Jun 2019 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3bEg7tE3LCvs51bZFU8hL64WpaxzSnEzzhtxUahhJLM=;
        b=AoUwkh0o43CR+WC1VzzIFHLq6vtUq9rAZtfDw7G5Yz01nILDLsxREnyAd51JJGasTh
         j/lCWA4XdY4tk3MVC39hiYfb5346QwAIeaFX54tFbeIKsfEe7yWj2dtmBZ0bRD+pc1K5
         Re0BRBb+wZYQevLhiNV9ou2H098odnm0I5hb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3bEg7tE3LCvs51bZFU8hL64WpaxzSnEzzhtxUahhJLM=;
        b=AGqVxIcRpT9b6rVEba9wUKLUCgAvvJyEGgR4vJACI9NI6Ubbio1QhcLA/HU15Uqkka
         adZKoMaDFHX9uhMwdtMU8yzHQZuwnoQA2WQot+RHxZ0iCEb9fT20Tb2XBKzLDb72qsaW
         OFF/umAImUuVDNK2GTqH9NAfcJsBLjIBgLemSQuMa3nzOJqzkqb4ZZ61fhv9NKPgCQBO
         1Kl5P4NLx9n8z+ln9eXj9UOpgf2s0IKW+7tCndXxva6Re1eqd8p+0D+GiG++W2ChFlo/
         x2c1zLKJ8cT5wxpa7a8nsi8JJtlz+DN+WqMYMKMUwUBnb5s/EZTjZTx/EMH+w/gVeWr0
         VAbg==
X-Gm-Message-State: APjAAAW5GjOqsa9i2G4eGBshnWo+PecQfh6O47tL4osx9aswjCOdhoWa
        /WiL9NejluGmH3vjtrXpxVBTNg==
X-Google-Smtp-Source: APXvYqye2PLO0y+a/KfsV9ADnpsHKoN8Skrc8dCeRTd0mKKjTe7MOc4MRXlaeD6ytlpnwlaKy+2IhQ==
X-Received: by 2002:a17:90a:32ec:: with SMTP id l99mr15724891pjb.44.1561247732596;
        Sat, 22 Jun 2019 16:55:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f2sm5721443pgs.83.2019.06.22.16.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:55:31 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:55:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V34 11/29] PCI: Lock down BAR access when the kernel is
 locked down
Message-ID: <201906221655.3076CBD3@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-12-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-12-matthewgarrett@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:40PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> Any hardware that can potentially generate DMA has to be locked down in
> order to avoid it being possible for an attacker to modify kernel code,
> allowing them to circumvent disabled module loading or module signing.
> Default to paranoid - in future we can potentially relax this for
> sufficiently IOMMU-isolated devices.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pci-sysfs.c      | 16 ++++++++++++++++
>  drivers/pci/proc.c           | 14 ++++++++++++--
>  drivers/pci/syscall.c        |  4 +++-
>  include/linux/security.h     |  1 +
>  security/lockdown/lockdown.c |  1 +
>  5 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 25794c27c7a4..e1011efb5a31 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -903,6 +903,11 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
>  	unsigned int size = count;
>  	loff_t init_off = off;
>  	u8 *data = (u8 *) buf;
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;
>  
>  	if (off > dev->cfg_size)
>  		return 0;
> @@ -1165,6 +1170,11 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
>  	int bar = (unsigned long)attr->private;
>  	enum pci_mmap_state mmap_type;
>  	struct resource *res = &pdev->resource[bar];
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;
>  
>  	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
>  		return -EINVAL;
> @@ -1241,6 +1251,12 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
>  				     struct bin_attribute *attr, char *buf,
>  				     loff_t off, size_t count)
>  {
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;
> +
>  	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
>  }
>  
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 6fa1627ce08d..a72258d70407 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -13,6 +13,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/capability.h>
>  #include <linux/uaccess.h>
> +#include <linux/security.h>
>  #include <asm/byteorder.h>
>  #include "pci.h"
>  
> @@ -115,7 +116,11 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  	struct pci_dev *dev = PDE_DATA(ino);
>  	int pos = *ppos;
>  	int size = dev->cfg_size;
> -	int cnt;
> +	int cnt, ret;
> +
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;
>  
>  	if (pos >= size)
>  		return 0;
> @@ -196,6 +201,10 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
>  #endif /* HAVE_PCI_MMAP */
>  	int ret = 0;
>  
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;
> +
>  	switch (cmd) {
>  	case PCIIOC_CONTROLLER:
>  		ret = pci_domain_nr(dev->bus);
> @@ -237,7 +246,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
>  	struct pci_filp_private *fpriv = file->private_data;
>  	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
>  
> -	if (!capable(CAP_SYS_RAWIO))
> +	if (!capable(CAP_SYS_RAWIO) ||
> +	    security_locked_down(LOCKDOWN_PCI_ACCESS))
>  		return -EPERM;
>  
>  	if (fpriv->mmap_state == pci_mmap_io) {
> diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
> index d96626c614f5..31e39558d49d 100644
> --- a/drivers/pci/syscall.c
> +++ b/drivers/pci/syscall.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/pci.h>
> +#include <linux/security.h>
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
>  #include "pci.h"
> @@ -90,7 +91,8 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
>  	u32 dword;
>  	int err = 0;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!capable(CAP_SYS_ADMIN) ||
> +	    security_locked_down(LOCKDOWN_PCI_ACCESS))
>  		return -EPERM;
>  
>  	dev = pci_get_domain_bus_and_slot(0, bus, dfn);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a051f21a1144..1b849f10dec6 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -86,6 +86,7 @@ enum lockdown_reason {
>  	LOCKDOWN_DEV_MEM,
>  	LOCKDOWN_KEXEC,
>  	LOCKDOWN_HIBERNATION,
> +	LOCKDOWN_PCI_ACCESS,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index ce5b3da9bd09..e2ee8a16b94c 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -22,6 +22,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
>  	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
>  	[LOCKDOWN_HIBERNATION] = "hibernation",
> +	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
