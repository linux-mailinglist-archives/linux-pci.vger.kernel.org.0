Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D87D34F401
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 00:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhC3WIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 18:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhC3WHh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 18:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78680619B1;
        Tue, 30 Mar 2021 22:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617142056;
        bh=BO674U5zLO3sqPQDxI9cGvCDv1KBc4MxQJo5IOr0148=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ly2+TV9SlDULtpl+afoRBW7zUmsVMYdRyNINMHDa4wZgX6TrLVQ/9n/P7WAZG+7fS
         qvtAXPCtUgLKLgXmOI2IVVJDHuyiOWcMNaz2YVCFnJG49c/n+CDLuhKbR0WS/V4+TG
         wG8qwyKPWvHOHKt8uc1Ot4Osyceeb6KeDHMZAAdlbIT3IC/hzEaF+LFCgATpY6Rpkz
         yOMT5MOgpaZk0+Maj9Fmx6mpU7YXhb3PqDo2fWb1GGqfZWrKja6LW7U/jeDt1fV6kb
         534XZtetZSkQg35eTpPA4RQhR22WL8Zk9U1uYwVJi1Qv1KwtaN426WfiYruH+P53L8
         vjjWKTVU09vbQ==
Date:   Tue, 30 Mar 2021 17:07:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RESEND] PCI/VPD: Remove pci_set_vpd_size
Message-ID: <20210330220735.GA1322162@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47d86e52-9bcf-7da7-1edb-0d988a7a82ab@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 12, 2021 at 11:02:47AM +0100, Heiner Kallweit wrote:
> 24a1720a0841 ("cxgb4: collect serial config version from register")
> removed the only usage of pci_set_vpd_size(). If a device needs to
> override the auto-detected VPD size, then this can be done using a
> PCI quirk, like it's done for Chelsio devices. There's no need to
> allow drivers to change the VPD size. So let's remove
> pci_set_vpd_size().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/vpd for v5.13, thanks!

> ---
> - Referenced commit just landed in linux-next via the netdev tree.
> - Uups, had the list on bcc instead of cc.
> ---
>  drivers/pci/vpd.c   | 47 +++++++--------------------------------------
>  include/linux/pci.h |  1 -
>  2 files changed, 7 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 4cf0d77ca..d1cbc5e64 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -16,7 +16,6 @@
>  struct pci_vpd_ops {
>  	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
>  	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
> -	int (*set_size)(struct pci_dev *dev, size_t len);
>  };
>  
>  struct pci_vpd {
> @@ -59,19 +58,6 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
>  }
>  EXPORT_SYMBOL(pci_write_vpd);
>  
> -/**
> - * pci_set_vpd_size - Set size of Vital Product Data space
> - * @dev:	pci device struct
> - * @len:	size of vpd space
> - */
> -int pci_set_vpd_size(struct pci_dev *dev, size_t len)
> -{
> -	if (!dev->vpd || !dev->vpd->ops)
> -		return -ENODEV;
> -	return dev->vpd->ops->set_size(dev, len);
> -}
> -EXPORT_SYMBOL(pci_set_vpd_size);
> -
>  #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
>  
>  /**
> @@ -296,23 +282,19 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  	return ret ? ret : count;
>  }
>  
> -static int pci_vpd_set_size(struct pci_dev *dev, size_t len)
> +static void pci_vpd_set_size(struct pci_dev *dev, size_t len)
>  {
>  	struct pci_vpd *vpd = dev->vpd;
>  
> -	if (len == 0 || len > PCI_VPD_MAX_SIZE)
> -		return -EIO;
> -
> -	vpd->valid = 1;
> -	vpd->len = len;
> -
> -	return 0;
> +	if (vpd && len && len <= PCI_VPD_MAX_SIZE) {
> +		vpd->valid = 1;
> +		vpd->len = len;
> +	}
>  }
>  
>  static const struct pci_vpd_ops pci_vpd_ops = {
>  	.read = pci_vpd_read,
>  	.write = pci_vpd_write,
> -	.set_size = pci_vpd_set_size,
>  };
>  
>  static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
> @@ -345,24 +327,9 @@ static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
>  	return ret;
>  }
>  
> -static int pci_vpd_f0_set_size(struct pci_dev *dev, size_t len)
> -{
> -	struct pci_dev *tdev = pci_get_slot(dev->bus,
> -					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> -	int ret;
> -
> -	if (!tdev)
> -		return -ENODEV;
> -
> -	ret = pci_set_vpd_size(tdev, len);
> -	pci_dev_put(tdev);
> -	return ret;
> -}
> -
>  static const struct pci_vpd_ops pci_vpd_f0_ops = {
>  	.read = pci_vpd_f0_read,
>  	.write = pci_vpd_f0_write,
> -	.set_size = pci_vpd_f0_set_size,
>  };
>  
>  int pci_vpd_init(struct pci_dev *dev)
> @@ -528,9 +495,9 @@ static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
>  	 * limits.
>  	 */
>  	if (chip == 0x0 && prod >= 0x20)
> -		pci_set_vpd_size(dev, 8192);
> +		pci_vpd_set_size(dev, 8192);
>  	else if (chip >= 0x4 && func < 0x8)
> -		pci_set_vpd_size(dev, 2048);
> +		pci_vpd_set_size(dev, 2048);
>  }
>  
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97..edadc62ae 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1302,7 +1302,6 @@ void pci_unlock_rescan_remove(void);
>  /* Vital Product Data routines */
>  ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
>  ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
> -int pci_set_vpd_size(struct pci_dev *dev, size_t len);
>  
>  /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
>  resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
> -- 
> 2.30.0
> 
