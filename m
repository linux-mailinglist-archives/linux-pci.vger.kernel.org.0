Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A583E9AAC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 00:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhHKWBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 18:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232166AbhHKWBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 18:01:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9113E60F11;
        Wed, 11 Aug 2021 22:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628719248;
        bh=q4yFbBS07Jh1QjiI3/dx4PrL9nVJzTZYIvw3zW3oL+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U/0GdvOLVVIPB0A32MChchNIB8rK+CQGuZW4Ez8D2/p7cpLcAHJszQBt/NngRjjVQ
         ohrz3O94NOSSEXRlpng6en3hY6D1SJ0PXglUEU5fJ25Hpt0ca5oes8G97MQcZTa7JO
         kIKldq+aKaGPXChX5DHpB6m1CJz/T2rmkrnOt9QRL9wIjblUVBJIjYHd8XdyjFx2tm
         ZKF8oFF5HLSwpnrA6z/8z2IYuwn334fC9I663KX1GG3tYt2i8o5/ECWo+HqgZ0WPo4
         b82cXBGmUr84NTxpeKu4JspEJE6rxCXb3OW5AxM32slG/lHB/10am2EyxiRgvaII4A
         t+RGy+8XZkHUw==
Date:   Wed, 11 Aug 2021 17:00:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Mark D Rustad <mark.d.rustad@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/6] PCI/VPD: Remove struct pci_vpd_ops
Message-ID: <20210811220047.GA2407168@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2532a41-df8b-860f-461f-d5c066c819d0@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mark, Alex D, Jesse, Alex W]

On Sun, Aug 08, 2021 at 07:20:05PM +0200, Heiner Kallweit wrote:
> Code can be significantly simplified by removing struct pci_vpd_ops and
> avoiding the indirect calls.

I really like this patch.

Nothing to do with *this* patch, but I have a little heartburn about
the "access somebody else's VPD" approach.

I think the beginning of this was Mark's post [1].  IIUC, there are
Intel multifunction NICs that share some VPD hardware between
functions, and concurrent accesses to VPD of different functions
doesn't work correctly.

I'm pretty sure this is a defect per spec, because PCIe r5.0, sec
7.9.19 doesn't say anything about having to treat VPD on
multi-function devices specially.

The current solution is for all Intel multi-function NICs to redirect
VPD access to function 0.  That single-threads VPD access across all
the functions because we hold function 0's vpd->lock mutex while
reading or writing.

But I think we still have the problem that this implicit sharing of
function 0's VPD opens a channel between functions: if functions are
assigned to different VMs, the VMs can communicate by reading and
writing VPD.

So I wonder if we should just disallow VPD access for these NICs
except on function 0.  There was a little bit of discussion in that
direction at [2].

[1] https://lore.kernel.org/linux-pci/20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com/
[2] https://lore.kernel.org/linux-pci/20150519160158.00002cd6@unknown/

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c | 90 ++++++++++++++++++-----------------------------
>  1 file changed, 34 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index e87f299ee..6a0d617b2 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -13,13 +13,7 @@
>  
>  /* VPD access through PCI 2.2+ VPD capability */
>  
> -struct pci_vpd_ops {
> -	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
> -	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
> -};
> -
>  struct pci_vpd {
> -	const struct pci_vpd_ops *ops;
>  	struct mutex	lock;
>  	unsigned int	len;
>  	u8		cap;
> @@ -123,11 +117,16 @@ static int pci_vpd_wait(struct pci_dev *dev, bool set)
>  static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  			    void *arg)
>  {
> -	struct pci_vpd *vpd = dev->vpd;
> +	struct pci_vpd *vpd;
>  	int ret = 0;
>  	loff_t end = pos + count;
>  	u8 *buf = arg;
>  
> +	if (!dev || !dev->vpd)
> +		return -ENODEV;
> +
> +	vpd = dev->vpd;
> +
>  	if (pos < 0)
>  		return -EINVAL;
>  
> @@ -189,11 +188,16 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  			     const void *arg)
>  {
> -	struct pci_vpd *vpd = dev->vpd;
> +	struct pci_vpd *vpd;
>  	const u8 *buf = arg;
>  	loff_t end = pos + count;
>  	int ret = 0;
>  
> +	if (!dev || !dev->vpd)
> +		return -ENODEV;
> +
> +	vpd = dev->vpd;
> +
>  	if (pos < 0 || (pos & 3) || (count & 3))
>  		return -EINVAL;
>  
> @@ -238,44 +242,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  	return ret ? ret : count;
>  }
>  
> -static const struct pci_vpd_ops pci_vpd_ops = {
> -	.read = pci_vpd_read,
> -	.write = pci_vpd_write,
> -};
> -
> -static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
> -			       void *arg)
> -{
> -	struct pci_dev *tdev = pci_get_func0_dev(dev);
> -	ssize_t ret;
> -
> -	if (!tdev)
> -		return -ENODEV;
> -
> -	ret = pci_read_vpd(tdev, pos, count, arg);
> -	pci_dev_put(tdev);
> -	return ret;
> -}
> -
> -static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
> -				const void *arg)
> -{
> -	struct pci_dev *tdev = pci_get_func0_dev(dev);
> -	ssize_t ret;
> -
> -	if (!tdev)
> -		return -ENODEV;
> -
> -	ret = pci_write_vpd(tdev, pos, count, arg);
> -	pci_dev_put(tdev);
> -	return ret;
> -}
> -
> -static const struct pci_vpd_ops pci_vpd_f0_ops = {
> -	.read = pci_vpd_f0_read,
> -	.write = pci_vpd_f0_write,
> -};
> -
>  void pci_vpd_init(struct pci_dev *dev)
>  {
>  	struct pci_vpd *vpd;
> @@ -290,10 +256,6 @@ void pci_vpd_init(struct pci_dev *dev)
>  		return;
>  
>  	vpd->len = PCI_VPD_MAX_SIZE;
> -	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
> -		vpd->ops = &pci_vpd_f0_ops;
> -	else
> -		vpd->ops = &pci_vpd_ops;
>  	mutex_init(&vpd->lock);
>  	vpd->cap = cap;
>  	vpd->valid = 0;
> @@ -388,9 +350,17 @@ EXPORT_SYMBOL_GPL(pci_vpd_find_info_keyword);
>   */
>  ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
>  {
> -	if (!dev->vpd || !dev->vpd->ops)
> -		return -ENODEV;
> -	return dev->vpd->ops->read(dev, pos, count, buf);
> +	ssize_t ret;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> +		dev = pci_get_func0_dev(dev);
> +		ret = pci_vpd_read(dev, pos, count, buf);
> +		pci_dev_put(dev);
> +	} else {
> +		ret = pci_vpd_read(dev, pos, count, buf);
> +	}
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(pci_read_vpd);
>  
> @@ -403,9 +373,17 @@ EXPORT_SYMBOL(pci_read_vpd);
>   */
>  ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf)
>  {
> -	if (!dev->vpd || !dev->vpd->ops)
> -		return -ENODEV;
> -	return dev->vpd->ops->write(dev, pos, count, buf);
> +	ssize_t ret;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
> +		dev = pci_get_func0_dev(dev);
> +		ret = pci_vpd_write(dev, pos, count, buf);
> +		pci_dev_put(dev);
> +	} else {
> +		ret = pci_vpd_write(dev, pos, count, buf);
> +	}
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(pci_write_vpd);
>  
> -- 
> 2.32.0
> 
> 
