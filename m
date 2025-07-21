Return-Path: <linux-pci+bounces-32635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF303B0C0C9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245A83B8E26
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117E2877E0;
	Mon, 21 Jul 2025 09:57:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D36E55B
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091871; cv=none; b=X1RfM7JjnCWk31FYhAdCOrQu3jOU3kiaZv2hnXmDozie6vth9l6MFRIccEWW/iK+5CItKQuxor5CxM/0Zdx1lzwLKR6CCw23dyA4oLtMNfcEj0S60jZ9+ZxjWTba6Cu0LJt+SM2NtDKUXUlEILTki9gKPd1oa8ZB8BrRJW3ZD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091871; c=relaxed/simple;
	bh=bADEepJmVsUW8YksOdCA7AvaT2erx4SUwrWpaZ40BaY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQnJHEW29k4ji1gn6D/1zt02zGwvH2Uoxhb4CEZI+tQN+ZMqXcQ2dSQes5K0NqoT+UlwbG0O2sSnsk6pWqd2Jz1L1M5a4cIK1PilR0Rgp30u76QCe+xER3w93NmxUXivPRPoZXTUkK9D77+ASqMubHoilnQbe0S26wJ7vZonT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4blwlS2Rpvz6L5WP;
	Mon, 21 Jul 2025 17:56:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AEE88140417;
	Mon, 21 Jul 2025 17:57:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 11:57:46 +0200
Date: Mon, 21 Jul 2025 10:57:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mario Limonciello <superm1@kernel.org>
CC: <mario.limonciello@amd.com>, <bhelgaas@google.com>, Stephen Rothwell
	<sfr@canb.auug.org.au>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Adjust visibility of boot_display attribute
 instead of creation
Message-ID: <20250721105744.000046bc@huawei.com>
In-Reply-To: <20250720151551.735348-1-superm1@kernel.org>
References: <20250720151551.735348-1-superm1@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 20 Jul 2025 10:15:08 -0500
Mario Limonciello <superm1@kernel.org> wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> There is a desire to avoid creating new sysfs files late, so instead
> of dynamically deciding to create the boot_display attribute, make
> it static and use sysfs_update_group() to adjust visibility on the
> applicable devices.
> 
> This also fixes a compilation warning when compiled without
> CONFIG_VIDEO on sparc.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Leaving aside the 'where to call it' discussions, a few bits of feedback on the
code. See inline.


> ---
> v2:
>  * Change to sysfs_update_group() instead
> ---
>  drivers/pci/pci-sysfs.c | 59 +++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6b1a0ae254d3a..462a90d13eb87 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1059,37 +1059,6 @@ void pci_remove_legacy_files(struct pci_bus *b)
>  }
>  #endif /* HAVE_PCI_LEGACY */
>  
> -/**
> - * pci_create_boot_display_file - create a file in sysfs for @dev
> - * @pdev: dev in question
> - *
> - * Creates a file `boot_display` in sysfs for the PCI device @pdev
> - * if it is the boot display device.
> - */
> -static int pci_create_boot_display_file(struct pci_dev *pdev)
> -{
> -#ifdef CONFIG_VIDEO
> -	if (video_is_primary_device(&pdev->dev))
> -		return sysfs_create_file(&pdev->dev.kobj, &dev_attr_boot_display.attr);
> -#endif
> -	return 0;
> -}
> -
> -/**
> - * pci_remove_boot_display_file - remove the boot display file for @dev
> - * @pdev: dev in question
> - *
> - * Removes the file `boot_display` in sysfs for the PCI device @pdev
> - * if it is the boot display device.
> - */
> -static void pci_remove_boot_display_file(struct pci_dev *pdev)
> -{
> -#ifdef CONFIG_VIDEO
> -	if (video_is_primary_device(&pdev->dev))
> -		sysfs_remove_file(&pdev->dev.kobj, &dev_attr_boot_display.attr);
> -#endif
> -}
> -
>  #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
>  /**
>   * pci_mmap_resource - map a PCI resource into user memory space
> @@ -1691,6 +1660,29 @@ static const struct attribute_group pci_dev_resource_resize_group = {
>  	.is_visible = resource_resize_is_visible,
>  };
>  
> +static struct attribute *pci_display_attrs[] = {
> +	&dev_attr_boot_display.attr,
> +	NULL,

Trivial but I'd drop the comma after the NULL. It's at terminating entry and
we don't want it to be easy to add stuff after it!

> +};
> +
> +static umode_t pci_boot_display_visible(struct kobject *kobj,
> +					struct attribute *a, int n)
> +{
> +#ifdef CONFIG_VIDEO
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (a == &dev_attr_boot_display.attr && video_is_primary_device(&pdev->dev))
Is video_is_primary_device() stubbed out on !CONFIG_VIDEO?

There seems to be a stub in include/asm-generic/video.h

If it always is, drop the ifdef guards whilst you are here as the compiler
can see that and remove the code anyway.


> +		return a->mode;
> +#endif
> +	return 0;
> +}
> +
> +static const struct attribute_group pci_display_attr_group = {
> +	.attrs = pci_display_attrs,
> +	.is_visible = pci_boot_display_visible,
> +};
> +
>  int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  {
>  	int retval;
> @@ -1698,7 +1690,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>  	if (!sysfs_initialized)
>  		return -EACCES;
>  
> -	retval = pci_create_boot_display_file(pdev);
> +	retval = sysfs_update_group(&pdev->dev.kobj, &pci_display_attr_group);
>  	if (retval)
>  		return retval;
>  
> @@ -1716,7 +1708,6 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
>  	if (!sysfs_initialized)
>  		return;
>  
> -	pci_remove_boot_display_file(pdev);
>  	pci_remove_resource_files(pdev);
>  }
>  
> @@ -1755,7 +1746,6 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>  
>  	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
>  		return a->mode;
> -
Unrelated change.

>  	return 0;
>  }
>  
> @@ -1845,6 +1835,7 @@ static const struct attribute_group pcie_dev_attr_group = {
>  
>  const struct attribute_group *pci_dev_attr_groups[] = {
>  	&pci_dev_attr_group,
> +	&pci_display_attr_group,
>  	&pci_dev_hp_attr_group,
>  #ifdef CONFIG_PCI_IOV
>  	&sriov_pf_dev_attr_group,


