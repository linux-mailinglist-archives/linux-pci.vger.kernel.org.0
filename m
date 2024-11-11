Return-Path: <linux-pci+bounces-16478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB309C4716
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97050B2C254
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA41B140D;
	Mon, 11 Nov 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fadq8Ssa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FCB1AD5D8;
	Mon, 11 Nov 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357666; cv=none; b=Cf6wIxiEt2Wg8+dnMjcWVamlGBK2KONwrpqlc7dvmowTRn2uwZBnQdxC2fO6i4Uw//NcOBepMN14woZr1yhMJq2qWwjdJsXxUmAbKGaprKgKgZha2uZpzAkJ0ww1R+ho0grTj8g5p3mm7t97uixlM0WTTuZZg4TYuepEsFM8mNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357666; c=relaxed/simple;
	bh=PZaCN9EPbcxDm/Qe14VyzI6oXNbmlunaeGU2DgI/vbw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YGiG1yEtrIyM6v0p10Iyl193OdF+59ub9TcnTLPDJ/A3QMiHKY6IDF01O2I36mDowMbHJq56S6kPeI4e8VLGWpKc3UBYA0Kn4aswHDFH9y9Rabf1gWJHHc1MsVlmsPhhOwVMRTeNnu+z/d4eetvGbeRpEh1uk6L9K1i3IieVBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fadq8Ssa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F634C4CECF;
	Mon, 11 Nov 2024 20:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357665;
	bh=PZaCN9EPbcxDm/Qe14VyzI6oXNbmlunaeGU2DgI/vbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fadq8SsatNNa8beqtst3Wmd9WWa0zD8pa70OmBHd4IaIBfrI6TcTwSaDeX2RcUuVl
	 NAywBadU8GdGP6nCM83Fg0WryPN8VMSVRgUAM3QDzwfMVhUMWPoyun5q3MmnXLq0Qq
	 zQLPPZ8W2Jpdklhb/5niCu3iFDj+4FVVskAmVwsURfBAqxS2vMPOiMknXtzAXyLw+1
	 yzbMgZsD960kpgQEPWWlaqpRQIS9QWtfOhQnqIv5xT0AdlngVBtPkLJxdkSh2irrEF
	 GqTycp11XGNvm6jFMRKk+xA4RmvANwl3zw67jJgaBgw/KukWHbeseBv+Qn3GBZ2Fqt
	 x8QsQ0gooK36g==
Date: Mon, 11 Nov 2024 14:41:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241111204104.GA1817395@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>

On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
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

I don't think the use case is very strong (and not included at all
here).

If we do need to do this, I think it's a property of the device, not
the driver.

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

