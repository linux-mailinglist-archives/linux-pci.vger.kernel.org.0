Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60481D7F4A
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 18:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgERQza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 12:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgERQza (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 12:55:30 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4753420758;
        Mon, 18 May 2020 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589820929;
        bh=hOnNpB2qeCDBq2inKpYVvV8PTplmaY610Cbw/Rt4B0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2IR8oKxn7phJd0hwLTfzPJamN+EniZqn1TGqZqqkrvkx6tBZ9r6mNmpD8Be50yzcy
         h8FhB6ce7+wl1A64dpYiJY+GJPH5NHzM1qkhbNr3TyqHvWtBPP+1nLOwN9lQTCuSrr
         v7MMKGReiWL/AlZKk661urAZSH9985qTuOUmJVAc=
Date:   Mon, 18 May 2020 11:55:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] PCI: Add helpers to enable/disable CXL.mem and
 CXL.cache
Message-ID: <20200518165527.GA935823@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518163523.1225643-4-sean.v.kelley@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 18, 2020 at 09:35:23AM -0700, Sean V Kelley wrote:
> With these helpers, a device driver can enable/disable access to
> CXL.mem and CXL.cache. Note that the device driver is responsible for
> managing the memory area.
> 
> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
> ---
>  drivers/pci/cxl.c | 93 ++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/pci/pci.h |  8 ++++
>  2 files changed, 96 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 4437ca69ad33..0d0a1b82ea98 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -24,6 +24,88 @@
>  #define PCI_CXL_HDM_COUNT(reg)		(((reg) & (3 << 4)) >> 4)
>  #define PCI_CXL_VIRAL			BIT(14)
>  
> +#define PCI_CXL_CONFIG_LOCK		BIT(0)
> +
> +static void pci_cxl_unlock(struct pci_dev *dev)
> +{
> +	int pos = dev->cxl_cap;
> +	u16 lock;
> +
> +	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);
> +	lock &= ~PCI_CXL_CONFIG_LOCK;
> +	pci_write_config_word(dev, pos + PCI_CXL_LOCK, lock);
> +}
> +
> +static void pci_cxl_lock(struct pci_dev *dev)
> +{
> +	int pos = dev->cxl_cap;
> +	u16 lock;
> +
> +	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);
> +	lock |= PCI_CXL_CONFIG_LOCK;
> +	pci_write_config_word(dev, pos + PCI_CXL_LOCK, lock);
> +}

Maybe a tiny comment about what PCI_CXL_CONFIG_LOCK does?  I guess
these functions don't enforce mutual exclusion (as I first expected a
"lock" function to do); they're simply telling the device to accept
CTRL changes or something?

> +static int pci_cxl_enable_disable_feature(struct pci_dev *dev, int enable,
> +					  u16 feature)
> +{
> +	int pos = dev->cxl_cap;
> +	int ret;
> +	u16 reg;
> +
> +	if (!dev->cxl_cap)
> +		return -EINVAL;

"pos"

"pos" is the typical name for things like this, but sometimes I think
the code would be more descriptive if we used things like "cxl",
"aer", etc.

> +
> +	/* Only for PCIe */
> +	if (!pci_is_pcie(dev))
> +		return -EINVAL;

Probably not necessary here.  We already checked it in pci_cxi_init().

> +	/* Only for Device 0 Function 0, Root Complex Integrated Endpoints */
> +	if (dev->devfn != 0 || (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END))
> +		return -EINVAL;
> +
> +	pci_cxl_unlock(dev);
> +	ret = pci_read_config_word(dev, pos + PCI_CXL_CTRL, &reg);
> +	if (ret)
> +		goto lock;
> +
> +	if (enable)
> +		reg |= feature;
> +	else
> +		reg &= ~feature;
> +
> +	ret = pci_write_config_word(dev, pos + PCI_CXL_CTRL, reg);
> +
> +lock:
> +	pci_cxl_lock(dev);
> +
> +	return ret;
> +}
> +
> +int pci_cxl_mem_enable(struct pci_dev *dev)
> +{
> +	return pci_cxl_enable_disable_feature(dev, true, PCI_CXL_MEM);
> +}
> +EXPORT_SYMBOL_GPL(pci_cxl_mem_enable);
> +
> +void pci_cxl_mem_disable(struct pci_dev *dev)
> +{
> +	pci_cxl_enable_disable_feature(dev, false, PCI_CXL_MEM);
> +}
> +EXPORT_SYMBOL_GPL(pci_cxl_mem_disable);
> +
> +int pci_cxl_cache_enable(struct pci_dev *dev)
> +{
> +	return pci_cxl_enable_disable_feature(dev, true, PCI_CXL_CACHE);
> +}
> +EXPORT_SYMBOL_GPL(pci_cxl_cache_enable);
> +
> +void pci_cxl_cache_disable(struct pci_dev *dev)
> +{
> +	pci_cxl_enable_disable_feature(dev, false, PCI_CXL_CACHE);
> +}
> +EXPORT_SYMBOL_GPL(pci_cxl_cache_disable);
> +
>  /*
>   * pci_find_cxl_capability - Identify and return offset to Vendor-Specific
>   * capabilities.
> @@ -73,11 +155,6 @@ void pci_cxl_init(struct pci_dev *dev)
>  	dev->cxl_cap = pos;
>  
>  	pci_read_config_word(dev, pos + PCI_CXL_CAP, &cap);
> -	pci_read_config_word(dev, pos + PCI_CXL_CTRL, &ctrl);
> -	pci_read_config_word(dev, pos + PCI_CXL_STS, &status);
> -	pci_read_config_word(dev, pos + PCI_CXL_CTRL2, &ctrl2);
> -	pci_read_config_word(dev, pos + PCI_CXL_STS2, &status2);
> -	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);
>  
>  	pci_info(dev, "CXL: Cache%c IO%c Mem%c Viral%c HDMCount %d\n",
>  		FLAG(cap, PCI_CXL_CACHE),
> @@ -86,6 +163,12 @@ void pci_cxl_init(struct pci_dev *dev)
>  		FLAG(cap, PCI_CXL_VIRAL),
>  		PCI_CXL_HDM_COUNT(cap));
>  
> +	pci_read_config_word(dev, pos + PCI_CXL_CTRL, &ctrl);
> +	pci_read_config_word(dev, pos + PCI_CXL_STS, &status);
> +	pci_read_config_word(dev, pos + PCI_CXL_CTRL2, &ctrl2);
> +	pci_read_config_word(dev, pos + PCI_CXL_STS2, &status2);
> +	pci_read_config_word(dev, pos + PCI_CXL_LOCK, &lock);

This looks like it's just moving these reads around and isn't actually
related to this patch.  Put them where you want them in the first
place so the move doesn't clutter this patch.

>  	pci_info(dev, "CXL: cap ctrl status ctrl2 status2 lock\n");
>  	pci_info(dev, "CXL: %04x %04x %04x %04x %04x %04x\n",
>  		 cap, ctrl, status, ctrl2, status2, lock);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d9905e2dee95..6336e16565ac 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -472,8 +472,16 @@ static inline void pci_restore_ats_state(struct pci_dev *dev) { }
>  #ifdef CONFIG_PCI_CXL
>  /* Compute eXpress Link */
>  void pci_cxl_init(struct pci_dev *dev);
> +int pci_cxl_mem_enable(struct pci_dev *dev);
> +void pci_cxl_mem_disable(struct pci_dev *dev);
> +int pci_cxl_cache_enable(struct pci_dev *dev);
> +void pci_cxl_cache_disable(struct pci_dev *dev);
>  #else
>  static inline void pci_cxl_init(struct pci_dev *dev) { }
> +static inline int pci_cxl_mem_enable(struct pci_dev *dev) {}
> +static inline void pci_cxl_mem_disable(struct pci_dev *dev) {}
> +static inline int pci_cxl_cache_enable(struct pci_dev *dev) {}
> +static inline void pci_cxl_cache_disable(struct pci_dev *dev) {}

The stubs in this file aren't completely consistent, but you can be at
least locally consistent by including a space between the "{ }".

>  #endif
>  
>  #ifdef CONFIG_PCI_PRI
> -- 
> 2.26.2
> 
