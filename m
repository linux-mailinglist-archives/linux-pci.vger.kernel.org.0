Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB6969A9
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 21:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfHTTpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 15:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730430AbfHTTpV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 15:45:21 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846EE22D6D;
        Tue, 20 Aug 2019 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566330320;
        bh=0ggGjOsUcb59Tr0imE8XyQ4wEcykqwE4QvRpMHpyosU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0++gU6WxHMpi4+4jgGTwuivcwrv0Ihiv8gGjnITs7uc7vDQR2GuOGdB45AqOZFcz
         9jf+cPhMPKhvh/eXR1+5cIhYEjsWUkOINKc/GKdnfTyP5xfgZEaleN7tWYY42vjbgd
         U+HdsD4wp+DrpWFCRDcTJ4zCtZ9ZuU0r+ECAZiHY=
Date:   Tue, 20 Aug 2019 14:45:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V40 11/29] PCI: Lock down BAR access when the kernel is
 locked down
Message-ID: <20190820194514.GC14450@google.com>
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-12-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820001805.241928-12-matthewgarrett@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 19, 2019 at 05:17:47PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> Any hardware that can potentially generate DMA has to be locked down in
> order to avoid it being possible for an attacker to modify kernel code,
> allowing them to circumvent disabled module loading or module signing.
> Default to paranoid - in future we can potentially relax this for
> sufficiently IOMMU-isolated devices.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> cc: linux-pci@vger.kernel.org
> Signed-off-by: James Morris <jmorris@namei.org>

Since I've acked this and it's 11/29, I've been assuming you intend
to merge the whole series together.  But the fact that it's up to V40
makes me wonder if you're waiting for me to merge this one.  Just let
me know either way.

> ---
>  drivers/pci/pci-sysfs.c      | 16 ++++++++++++++++
>  drivers/pci/proc.c           | 14 ++++++++++++--
>  drivers/pci/syscall.c        |  4 +++-
>  include/linux/security.h     |  1 +
>  security/lockdown/lockdown.c |  1 +
>  5 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d27475e39b2..ec103a7e13fc 100644
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
> @@ -1164,6 +1169,11 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
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
> @@ -1240,6 +1250,12 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
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
> index 445b51db75b0..e29b0d5ced62 100644
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
> @@ -238,7 +247,8 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
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
> index 80ac7fb27aa9..2b763f0ee352 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -107,6 +107,7 @@ enum lockdown_reason {
>  	LOCKDOWN_DEV_MEM,
>  	LOCKDOWN_KEXEC,
>  	LOCKDOWN_HIBERNATION,
> +	LOCKDOWN_PCI_ACCESS,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 3462f7edcaac..410e90eda848 100644
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
> 2.23.0.rc1.153.gdeed80330f-goog
> 
