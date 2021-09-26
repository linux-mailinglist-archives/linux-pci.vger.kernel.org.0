Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912C8418AEF
	for <lists+linux-pci@lfdr.de>; Sun, 26 Sep 2021 22:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhIZUWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Sep 2021 16:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhIZUWG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Sep 2021 16:22:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B0E260EE4;
        Sun, 26 Sep 2021 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632687629;
        bh=fYActKnvqIC6C0UMKyCJGxHn3OhDINtVGdhnfr6ur2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=abhuI3VQ1tNOuIx30bg2goY/rh+objBay00QU0OCi7QRGPpuWR7v3cky/PY3MVt2Y
         sUYZ5GkYphogzHYIVsoUKQgLzSM1GPo+7Awvq7wQHJq6GLMUj6lZH3ZHDUoCa5i411
         83mtA43kqeWKoIr7wFLgqC+zsGVeJD5kMxMPpBE68AGp2Cu5+7gqyoJttu5WP3p9/F
         h48sLNA/9m97XuHeB4xlShmTHk9W42yV4EP3yRAKadaJQ0f1S6UvEPPKmIv62+D3K+
         ZbkIMuUtzNgxfDofh+jJyuqcuO6I0gwX2qFsWx3EpnxanF7DDCPt7DCSgTjTjdZIEq
         DFJPJJCalmw/g==
Date:   Sun, 26 Sep 2021 15:20:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhenneng Li <lizhenneng@kylinos.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: add write attribute for boot_vga
Message-ID: <20210926202027.GA588220@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926071539.636644-1-lizhenneng@kylinos.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 26, 2021 at 03:15:39PM +0800, Zhenneng Li wrote:
> Add writing attribute for boot_vga sys node,
> so we can config default video display
> output dynamically when there are two video
> cards on a machine.
> 
> Xorg server will determine running on which
> video card based on boot_vga node's value.

When you repost this, please take a look at the git commit log history
and make yours similar.  Specifically, the subject should start with a
capital letter, and the body should be rewrapped to fill 75
characters.

Please contrast this with the existing VGA arbiter.  See
Documentation/gpu/vgaarbiter.rst.  It sounds like this may overlap
with the VGA arbiter functionality, so this should explain why we need
both and how they interact.

> Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> ---
>  drivers/pci/pci-sysfs.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7bbf2673c7f2..a6ba19ce7adb 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -664,7 +664,29 @@ static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
>  			  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
>  			     IORESOURCE_ROM_SHADOW));
>  }
> -static DEVICE_ATTR_RO(boot_vga);
> +
> +static ssize_t boot_vga_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_dev *vga_dev = vga_default_device();
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val != 1)
> +		return -EINVAL;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (pdev != vga_dev)
> +		vga_set_default_device(pdev);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(boot_vga);
>  
>  static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
>  			       struct bin_attribute *bin_attr, char *buf,
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
