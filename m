Return-Path: <linux-pci+bounces-36889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FEFB9B967
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680B67A26CE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA9424DCEF;
	Wed, 24 Sep 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2LDnpd4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B019C546;
	Wed, 24 Sep 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740739; cv=none; b=IYQcDWXyy74usA0Fe21amO45OyHysrImJe7tP37Z6tUDmj4rQgJMASBIqLD/gBaO9WVnWd5qhrJWVe6SjPcwZceBsmSixJL27osK/bF+ZEKRZxirfHOwS7sfXvM5eEEC5+KKKvPEGs0NgjLSeBkmShX1Vw1Rpz++ylK+dRUk/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740739; c=relaxed/simple;
	bh=M1mxGbbckg8qR97+HGVkyqNUuMJBbv43CfnA5Cf+OxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KISXYNrfcxSZSCavsaP2vqsCq84K7bHcleDhfIYr6xshkPnDq8Hy9Wd8xZv4ywf86v+cPEQeuQrwpzp68UyBLxgZGOxzYYkE1uqrhZuYDpAnW4CjJhpIIvfNukcP4fjc1A7+xTi4bVI+fiZVnD8Srqh2+abQFeVaebvbmbnTHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2LDnpd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6BDC4CEE7;
	Wed, 24 Sep 2025 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758740738;
	bh=M1mxGbbckg8qR97+HGVkyqNUuMJBbv43CfnA5Cf+OxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=B2LDnpd4mhQMVJZpa6WYJ8l/CTjOZ+68iZKaQDLzvap2W2F9Tjo5yN9IP3jKiop2T
	 8fk4IUXfY+cYgQVE2ElzbO5zfF0sppcnVre4yhhdsdK5FuWvv7AUluMxIyPgzp5qjJ
	 /pQVQddfqMbcQG37ju7wuwEqA4uYCPgJ4jzTIsAwo1qQEQzs8TpKCcmZZ/nstXP5bZ
	 UfVDXdYSfr2Zr9qWGMnId/3aYv5VFXXX0A3rMFkG7DmOaFn6YJ4bSZUHWxXahmeyLS
	 D52ZOlx92lVEQL4cIxldA4GYjnDES0elvBjRFs5e4C7tlOdXJ/ZWPjuQOrTZ33i14g
	 Splf1ebAC19Vg==
Date: Wed, 24 Sep 2025 14:05:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ethan Zhao <etzhao1900@gmail.com>, linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <20250924190537.GA2129023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924095711.v2.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>

On Wed, Sep 24, 2025 at 09:57:11AM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> max_link_width, current_link_speed, current_link_width,
> secondary_bus_number, and subordinate_bus_number all access config
> registers, but they don't check the runtime PM state. If the device is
> in D3cold or a parent bridge is suspended, we may see -EINVAL, bogus
> values, or worse, depending on implementation details.
> 
> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> rest of the similar sysfs attributes.
> 
> Notably, max_link_speed does not access config registers; it returns a
> cached value [1]. So it needs no changes.
> 
> [1] Caching was added to pcie_get_speed_cap() in v6.13 via commit
>     d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds").
> 
> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied to pci/pm for v 6.18, thanks!

> ---
> 
> Changes in v2:
>  * Don't touch max_link_speed; it's cached, so we don't actually touch
>    the hardware
>  * Improve commit message
> 
>  drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index f28fdf6dfa02..af74cf02bb90 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -209,8 +209,14 @@ static ssize_t max_link_width_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t ret;
>  
> -	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
> +	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
> +	pci_config_pm_runtime_get(pdev);
> +	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
> +	pci_config_pm_runtime_put(pdev);
> +
> +	return ret;
>  }
>  static DEVICE_ATTR_RO(max_link_width);
>  
> @@ -222,7 +228,10 @@ static ssize_t current_link_speed_show(struct device *dev,
>  	int err;
>  	enum pci_bus_speed speed;
>  
> +	pci_config_pm_runtime_get(pci_dev);
>  	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>  	if (err)
>  		return -EINVAL;
>  
> @@ -239,7 +248,10 @@ static ssize_t current_link_width_show(struct device *dev,
>  	u16 linkstat;
>  	int err;
>  
> +	pci_config_pm_runtime_get(pci_dev);
>  	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>  	if (err)
>  		return -EINVAL;
>  
> @@ -255,7 +267,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
>  	u8 sec_bus;
>  	int err;
>  
> +	pci_config_pm_runtime_get(pci_dev);
>  	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>  	if (err)
>  		return -EINVAL;
>  
> @@ -271,7 +286,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
>  	u8 sub_bus;
>  	int err;
>  
> +	pci_config_pm_runtime_get(pci_dev);
>  	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>  	if (err)
>  		return -EINVAL;
>  
> -- 
> 2.51.0.536.g15c5d4f767-goog
> 

