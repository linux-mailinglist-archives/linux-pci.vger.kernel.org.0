Return-Path: <linux-pci+bounces-43248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1F5CCA7A0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36F373028EED
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28BA2874FA;
	Thu, 18 Dec 2025 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN0nRUnz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A42C11EE;
	Thu, 18 Dec 2025 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039505; cv=none; b=UnCknD3pUOYaaHPwStQ5R+xEsmCwtBDS4BbTeYWwKyI7Z+10lHYP7/RYi/ayfhaoSLbY+y7R2lNQr4GJNrVT2Uo99xZLYZ38BgmwZSbz8tVRMmPPeqKMxRv5HOmM4uS1gzWQ8tJ1tQeXAkyQQc0u1AF4oeN2QdVEbtH5i4gDIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039505; c=relaxed/simple;
	bh=jIIsAgV707w+wph+MuLWBcstO2UnR5c+xSvzRWm55ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1nyIGeS/ldsvjz7JTFw2bo0DLex8RpK8pYrYRqslgRYfWq9pBnlg19b8HtiE8ocV/FZk0fWs59LuzGdidfGMNJYTkMKD5KYpjGNUIp2O7Sftlozr7vPqYt4/ZgLyo3NNDdG/aKG698SjRkPv5u21lGXWUK0g+PfS8VcnWep3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN0nRUnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFBEC4CEFB;
	Thu, 18 Dec 2025 06:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766039505;
	bh=jIIsAgV707w+wph+MuLWBcstO2UnR5c+xSvzRWm55ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nN0nRUnzjXRF+Yd5Pxrvhcqx6+u6FdcIHJF0pNPqITH5Lm82cKQj9gY8Lplx78wjl
	 ofXoDahmHKe+W+8rKly+8bYAjnDF6MLYzjtRDkVE5auxMZPlP9Z72yqAl1bCB4hme1
	 GEpU+u8YOiQPkGc6kYSqYZe9HAw4oxEpaXwTXqck6oeyN8QIwJfy5zGM6dBrfs8p8U
	 SAY4JPLirHpI5OtUNvzFce2yMtO4lw0gsu/Sza21Q7PRjo9ubaanISHyjruzi7/mBf
	 PeE19jNW/+TyuntbNt/yVaV2ksofsHTD3onLDCp8d5NEmTh832bC2lAPTddoQZ/mXl
	 eH8wy69xUmqrA==
Date: Thu, 18 Dec 2025 12:01:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
Message-ID: <hsfa7kxvhrjcth3pabsrid2bzzjch7thu2uxggrg32tt54ipaq@lj7nbweoaj35>
References: <20251105134701.182795-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105134701.182795-1-18255117159@163.com>

On Wed, Nov 05, 2025 at 09:47:01PM +0800, Hans Zhang wrote:
> The existing code restricted max-link-speed to values 1~4 (Gen1~Gen4),
> but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
> While DT binding validation already checks this property, the code-level
> validation in of_pci_get_max_link_speed still lags behind, needing an
> update to accommodate newer PCIe generations.
> 
> Hardcoded literals in such validation logic create maintainability
> challenges, as they are difficult to track and update when adding
> support for future PCIe link speeds.  To address this, a helper function
> pcie_max_supported_link_speed() is added in drivers/pci/pci.h, which
> calculates the maximum supported link speed generation using existing
> PCIe capability macros (PCI_EXP_LNKCAP_SLS_*). This ensures alignment
> with the kernel's generic PCIe link speed definitions and avoids
> standalone hardcoded values.
> 
> The previous hardcoded "4" in the validation check is replaced with a
> call to this helper function, eliminating the need to modify this specific
> code path when extending support for future PCIe generations.

How can you not modify this function when PCIe 7.0 gets added? It still requires
an update.

I'd prefer to just drop the check altogether as the callers already have checks
on their own.

- Mani

> The
> implementation maintains full backward compatibility with existing
> configurations, while enabling seamless extension for newer link
> speeds, future updates will only require updating the relevant PCI
> capability macros without changing the validation logic here.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/of.c  | 3 ++-
>  drivers/pci/pci.h | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..de1fe6b9ba6a 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -890,7 +890,8 @@ int of_pci_get_max_link_speed(struct device_node *node)
>  	u32 max_link_speed;
>  
>  	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> +	    max_link_speed == 0 ||
> +	    max_link_speed > pcie_max_supported_link_speed())
>  		return -EINVAL;
>  
>  	return max_link_speed;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4492b809094b..2f0f319e80ce 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -548,6 +548,11 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>  	return -EINVAL;
>  }
>  
> +static inline int pcie_max_supported_link_speed(void)
> +{
> +	return PCI_EXP_LNKCAP_SLS_64_0GB - PCI_EXP_LNKCAP_SLS_2_5GB + 1;
> +}
> +
>  u8 pcie_get_supported_speeds(struct pci_dev *dev);
>  const char *pci_speed_string(enum pci_bus_speed speed);
>  void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

