Return-Path: <linux-pci+bounces-16481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9C9C47C5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 22:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9BB1F21610
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C41BD4E2;
	Mon, 11 Nov 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="D7PDnCrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70BD1BD4F8;
	Mon, 11 Nov 2024 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359306; cv=none; b=Hek0HgEWUtzo8c3J8UiGT5Zer1kGjrHVHdQJ1ixXQ0BFwvbVHbaCJC060DQogO59ehz0xytHmywv/4lEROo7U0RJS7nrIn2MH7rZF8hWqbWc9lZmrM5jlX0uq61TtjdONnY50amT0ZZadVI6LaJz/rmZl+1DT7Tu2oFrjlGLUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359306; c=relaxed/simple;
	bh=3XGWYD+pmj9aMM6MyakiMKBU/YsmeWAjZC5Fkn7/HUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDvG5bQy66oC9u+mjXM3v3Z4AymbCkovRw4IEuhN+4NGv95GpO1ek1Yu3+h1AJ19JXItbf7CEviW+lB4zOzb2Jus4wEH50FVKngSeCTRCI8bar0m1IsgLpNsmKw7AXbpyGij0+S6sjQFfcxkCScSPhBaHc+U92veRqNZKg+NZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=D7PDnCrH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731359301;
	bh=3XGWYD+pmj9aMM6MyakiMKBU/YsmeWAjZC5Fkn7/HUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7PDnCrH1DrQF54eri64ZAbVugSJvJ12/8ePMEZts4O7kGvQA5iQ1Qcfk3kIvPMD3
	 jhxTMaAlVSDE+P7RievLTxox1LdP8SwgGB4VITBX/AEoe8jvtyYOH8t3IQuwe4Xgkj
	 bO67Tt5/wHBGo+Ak0hAtze9ylYXXIcFJE3dMseEM=
Date: Mon, 11 Nov 2024 22:08:20 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Leon Romanovsky <leonro@nvidia.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>, 
	Aditya Prabhune <aprabhune@nvidia.com>, Hannes Reinecke <hare@suse.de>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Arun Easi <aeasi@marvell.com>, 
	Jonathan Chocron <jonnyc@amazon.com>, Bert Kenward <bkenward@solarflare.com>, 
	Matt Carlson <mcarlson@broadcom.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	Jean Delvare <jdelvare@suse.de>, Alex Williamson <alex.williamson@redhat.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <b4193ba9-f988-4d30-8e17-23a2b9ee9a64@t-8ch.de>
References: <cover.1731005223.git.leonro@nvidia.com>
 <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>

On 2024-11-07 20:56:56+0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The Vital Product Data (VPD) attribute is not readable by regular
> user without root permissions. Such restriction is not really needed
> for many devices in the world, as data presented in that VPD is not
> sensitive and access to the HW is safe and tested.
> 
> This change aligns the permissions of the VPD attribute to be accessible
> for read by all users, while write being restricted to root only.
> 
> For the driver, there is a need to opt-in in order to allow this
> functionality.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/vpd.c   | 9 ++++++++-
>  include/linux/pci.h | 7 ++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index e4300f5f304f..7c70930abaa0 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -156,6 +156,7 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  			    void *arg, bool check_size)
>  {
>  	struct pci_vpd *vpd = &dev->vpd;
> +	struct pci_driver *drv;
>  	unsigned int max_len;
>  	int ret = 0;
>  	loff_t end = pos + count;
> @@ -167,6 +168,12 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  	if (pos < 0)
>  		return -EINVAL;
>  
> +	if (!capable(CAP_SYS_ADMIN)) {
> +		drv = to_pci_driver(dev->dev.driver);
> +		if (!drv || !drv->downgrade_vpd_read)
> +			return -EPERM;
> +	}

If you move the check into vpd_attr_is_visible() then the sysfs core
will enforce the permissions and it's obvious for the user if they can
or can't read/write the file.

> +
>  	max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
>  
>  	if (pos >= max_len)
> @@ -317,7 +324,7 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
>  
>  	return ret;
>  }
> -static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
> +static BIN_ATTR_RW(vpd, 0);
>  
>  static struct bin_attribute *vpd_attrs[] = {
>  	&bin_attr_vpd,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..b8fed74e742e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -943,6 +943,10 @@ struct module;
>   *		how to manage the DMA themselves and set this flag so that
>   *		the IOMMU layer will allow them to setup and manage their
>   *		own I/O address space.
> + * @downgrade_vpd_read: Device doesn't require root permissions from the users
> + *              to read VPD information. The driver doesn't expose any sensitive
> + *              information through that interface and safe to be accessed by
> + *              unprivileged users.
>   */
>  struct pci_driver {
>  	const char		*name;
> @@ -960,7 +964,8 @@ struct pci_driver {
>  	const struct attribute_group **dev_groups;
>  	struct device_driver	driver;
>  	struct pci_dynids	dynids;
> -	bool driver_managed_dma;
> +	bool driver_managed_dma : 1;
> +	bool downgrade_vpd_read : 1;
>  };
>  
>  #define to_pci_driver(__drv)	\
> -- 
> 2.47.0
> 

