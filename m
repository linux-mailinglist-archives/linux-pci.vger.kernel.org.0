Return-Path: <linux-pci+bounces-36799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52263B9743E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 21:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE2F1889118
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B283D2DAFC4;
	Tue, 23 Sep 2025 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+bSPE6m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836B51D5146;
	Tue, 23 Sep 2025 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654153; cv=none; b=c/Xd3zOIX6dwknkwY+FcNq8sdQSFkydFyBLEGLAeJGCIFJKti8i0iOnWtOJ7elvjdqWBOQq2Np2zaBaVbp7ZAN+ikB2+lZSRd2yNF6GWIlYHfD77HxN9lmkVbpgrLoA/TDAoxQrm2WX7g9A+0AiNS8ieJdLiO2iPeP08Uvw+TYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654153; c=relaxed/simple;
	bh=LV33iPLSDG1tCcsSWNRhPuvny3ml8/FBH9uZJIGBaM8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZaNT26Drg+Xj/9WqjhTi3CJw0R+keH2GBKXpxq+yW31sonHQDTMxFb7L0ACyo6aDWLv5MjGXamTeCQem2yk6MFIHvxbg2Arq4JA6i0PnZndsUsa6csw1CKS0M0Cx1bgvWbwRlkWpl0N4zMq713Msjwmdkf14a8mpIf8qju165NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+bSPE6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35482C4CEF5;
	Tue, 23 Sep 2025 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654153;
	bh=LV33iPLSDG1tCcsSWNRhPuvny3ml8/FBH9uZJIGBaM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W+bSPE6mq+aeOvROdlX7UJAfxUJysHpH4OQYisWgniaW0HjZ73LieV8iMjxpjnZ6P
	 Q03icIvrmFfOy66SVzfLN/OnMxNbNu2mkpkhML18CzHzHRFzmEl/tq0yCezgjhQztb
	 h7zEeocTMJj6d+J7wr/rUb0HAZTKF2Q8F+pyl2tUWJr+GpVX/EvY9z3jNyh+g8gdpU
	 yzi3tVme5eOlNnY2o5O7xOet2P6tTeDVA0s/k6FyW55n+HBE8eEbG6/0FzT20BWgQw
	 spCtlm/cXPm0xNtvzQuXxgkPbAJ7A/fKG2mQ+OOndXKJusLiVxBdkltEL1Ejmu29Ea
	 zH3CUvSc/rRXQ==
Date: Tue, 23 Sep 2025 14:02:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org, Ethan Zhao <etzhao1900@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <20250923190231.GA2052830@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>

[+cc Ethan, Andrey]

On Wed, Aug 20, 2025 at 10:26:08AM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> max_link_speed, max_link_width, current_link_speed, current_link_width,
> secondary_bus_number, and subordinate_bus_number all access config
> registers, but they don't check the runtime PM state. If the device is
> in D3cold, we may see -EINVAL or even bogus values.
> 
> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> rest of the similar sysfs attributes.

Protecting the config reads seems right to me.

If the device is in D3cold, a config read will result in a Completion
Timeout.  On most x86 platforms that's "fine" and merely results in ~0
data.  But that's merely convention, not a PCIe spec requirement.

I think it's a potential issue with PCIe controllers used on arm64 and
might result in an SError or synchronous abort from which we don't
recover well.  I'd love to hear actual experience about how reading
"current_link_speed" works on a device in D3cold in an arm64 system.

As Ethan and Andrey pointed out, we could skip max_link_speed_show()
because pcie_get_speed_cap() already uses a cached value and doesn't
do a config access.

max_link_width_show() is similar and also comes from PCI_EXP_LNKCAP
but is not currently cached, so I think we do need that one.  Worth a
comment to explain the non-obvious difference.

PCI_EXP_LNKCAP is ostensibly read-only and could conceivably be
cached, but the ASPM exit latencies can change based on the Common
Clock Configuration.

> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..160df897dc5e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t ret;
> +
> +	pci_config_pm_runtime_get(pdev);
>  
> -	return sysfs_emit(buf, "%s\n",
> -			  pci_speed_string(pcie_get_speed_cap(pdev)));
> +	ret = sysfs_emit(buf, "%s\n",
> +			 pci_speed_string(pcie_get_speed_cap(pdev)));
> +
> +	pci_config_pm_runtime_put(pdev);
> +
> +	return ret;
>  }
>  static DEVICE_ATTR_RO(max_link_speed);
>  
> @@ -201,8 +208,15 @@ static ssize_t max_link_width_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t ret;
> +
> +	pci_config_pm_runtime_get(pdev);
> +
> +	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
>  
> -	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
> +	pci_config_pm_runtime_put(pdev);
> +
> +	return ret;
>  }
>  static DEVICE_ATTR_RO(max_link_width);
>  
> @@ -214,7 +228,10 @@ static ssize_t current_link_speed_show(struct device *dev,
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
> @@ -231,7 +248,10 @@ static ssize_t current_link_width_show(struct device *dev,
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
> @@ -247,7 +267,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
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
> @@ -263,7 +286,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
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
> 2.51.0.rc1.193.gad69d77794-goog
> 

