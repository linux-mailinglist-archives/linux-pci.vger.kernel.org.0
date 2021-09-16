Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43B40E5A2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245622AbhIPRN0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 13:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350539AbhIPRLW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 13:11:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D20A61B4F;
        Thu, 16 Sep 2021 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631810277;
        bh=xHw2IsddA05zwge0IIPYU87cx7/lezcngaOiXWY6cJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cj8IXlDlTeFbyNUaf+ZMuWYnZaJIHz/Ce5d4hIH6yDewYGC8vifIwazuuAX4GoM+V
         lCWLxehY+1XhCvUGnMM4oqhmpVIxtzZGQzNdif/oAkyl51JNHtTnLGscjY90y0LfUB
         yO3uGKxFss9m7uja0BltRIEO1etgA13QxzSB2FejOOZPGHuraP61th2HIXYDB0fRnf
         lp3Zl2dLQlJ+UPhwr1lmmmpBrYMCOzrJbllK4Tm8wE9LG//fvr/lC5AMRqRC7ebrW/
         4UBR7y/fJ0yZBOxBV/E1qKxhAuvBnvJUf9KggrA+aSD4zbZO6cAnUZAbSn4OuF5FcH
         KpnTEZ3tXVIAw==
Date:   Thu, 16 Sep 2021 11:37:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, alexander.deucher@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH] vgaarb: Use ACPI HID name to find integrated GPU
Message-ID: <20210916163755.GA1620802@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519135723.525997-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Huacai, linux-pci]

On Wed, May 19, 2021 at 09:57:23PM +0800, Kai-Heng Feng wrote:
> Commit 3d42f1ddc47a ("vgaarb: Keep adding VGA device in queue") assumes
> the first device is an integrated GPU. However, on AMD platforms an
> integrated GPU can have higher PCI device number than a discrete GPU.
> 
> Integrated GPU on ACPI platform generally has _DOD and _DOS method, so
> use that as predicate to find integrated GPU. If the new strategy
> doesn't work, fallback to use the first device as boot VGA.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/vga/vgaarb.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 5180c5687ee5..949fde433ea2 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -50,6 +50,7 @@
>  #include <linux/screen_info.h>
>  #include <linux/vt.h>
>  #include <linux/console.h>
> +#include <linux/acpi.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -1450,9 +1451,23 @@ static struct miscdevice vga_arb_device = {
>  	MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
>  };
>  
> +#if defined(CONFIG_ACPI)
> +static bool vga_arb_integrated_gpu(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
> +}
> +#else
> +static bool vga_arb_integrated_gpu(struct device *dev)
> +{
> +	return false;
> +}
> +#endif
> +
>  static void __init vga_arb_select_default_device(void)
>  {
> -	struct pci_dev *pdev;
> +	struct pci_dev *pdev, *found = NULL;
>  	struct vga_device *vgadev;
>  
>  #if defined(CONFIG_X86) || defined(CONFIG_IA64)
> @@ -1505,20 +1520,26 @@ static void __init vga_arb_select_default_device(void)
>  #endif
>  
>  	if (!vga_default_device()) {
> -		list_for_each_entry(vgadev, &vga_list, list) {
> +		list_for_each_entry_reverse(vgadev, &vga_list, list) {

Hi Kai-Heng, do you remember why you changed the order of this list
traversal?

I guess the list_add_tail() in vga_arbiter_add_pci_device() means
vga_list is generally ordered with small device numbers first and
large ones last.

So you pick the integrated GPU with the largest device number.  Are
there systems with more than one integrated GPU?  If so, I would
naively expect that in the absence of an indication otherwise, we'd
want the one with the *smallest* device number.

>  			struct device *dev = &vgadev->pdev->dev;
>  			u16 cmd;
>  
>  			pdev = vgadev->pdev;
>  			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>  			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
> -				vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
> -				vga_set_default_device(pdev);
> -				break;
> +				found = pdev;
> +				if (vga_arb_integrated_gpu(dev))
> +					break;
>  			}
>  		}
>  	}
>  
> +	if (found) {
> +		vgaarb_info(&found->dev, "setting as boot device (VGA legacy resources not available)\n");
> +		vga_set_default_device(found);
> +		return;
> +	}
> +
>  	if (!vga_default_device()) {
>  		vgadev = list_first_entry_or_null(&vga_list,
>  						  struct vga_device, list);
> -- 
> 2.31.1
> 
