Return-Path: <linux-pci+bounces-25654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12F2A85352
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 07:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B814C0C25
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 05:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569FC26FD98;
	Fri, 11 Apr 2025 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyuopvgl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2CA1E835B;
	Fri, 11 Apr 2025 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744350021; cv=none; b=QXorlH+9iAa0yz45BH5kHia/ZpWR4u3TF+x6RU6TLEvcIHfugdyQ3L4z1oXwVGnIFKQtHTRhsEGO3pRsxmvN5ie5Z5cTL+0s4Ems8qTQcEgEMx00aFrr6j0mvvEbaoBJ93I/csc2g3yVtsGLLPm2sthBiocsOuFKyWzJkjikJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744350021; c=relaxed/simple;
	bh=L/ry8rQ/aDpAD17dfQ3ss9Ide6yUCwBZGLqo1qCBJKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJfZSAqnKfrDzERUn0WXe7Ngny3UzoFk3Ogwy5HpQqT8OAWxlfvtf3DIeJdBUw+vX/XE2uK3Yd9V9CGM9AzIpWTyKPV7f/y90gcY4oVF2/SQRHDuhLMq55+MpgEw6gU8NjkHvtVWKVP43S64oxZCGAXh1D0bhTKdh89ZnrE61Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyuopvgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E7BC4CEE2;
	Fri, 11 Apr 2025 05:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744350019;
	bh=L/ry8rQ/aDpAD17dfQ3ss9Ide6yUCwBZGLqo1qCBJKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyuopvglMuGIQXEhLXv29ihZWYov/LQ0kqWr3pLsXyvSUdqc8GOXpLv8zR+YVdQlC
	 oZShkGG+wYl93QzukDX2xPzyGwydNpjKi9xSgD0oqFdPTvJFkoxM4hbLT2bi7Bx/fX
	 34YQ3OVGAufUaWfoUlKVR1PzWczGtZpPi7ZcF1wgv6qqsBsxuaomMZ2fQIR5489Tm0
	 VnvXOAxtcdZQLbd4MYZ8/dW/2CG5/CaIwfIyrONWCrg+unAidXxD8++4aGzl0klBNn
	 7cyZb8p2lIXwY7tK3QqMjO5ElQdbvLYeM9xQb2sYlIYvnM3VkJhYKqkLjK03D0sOX0
	 hctWJMuw+O5Ow==
Date: Fri, 11 Apr 2025 07:40:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <Z_irPjqUrDdAaF_T@ryzen>
References: <20250128044244.2766334-1-vidyas@nvidia.com>
 <20250410194552.944818-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410194552.944818-1-vidyas@nvidia.com>

On Fri, Apr 11, 2025 at 01:15:52AM +0530, Vidya Sagar wrote:
> Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> check, allowing the PCIe controller to be built on Tegra platforms
> beyond Tegra194. Additionally, ensure compatibility by requiring
> ARM64 or COMPILE_TEST.
> 
> Link: https://patchwork.kernel.org/project/linux-pci/patch/20250128044244.2766334-1-vidyas@nvidia.com/
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v2:
> * Addressed review comments from Niklas Cassel and Manivannan Sadhasivam
> 
>  drivers/pci/controller/dwc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d9f0386396ed..815b6e0d6a0c 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -226,7 +226,7 @@ config PCIE_TEGRA194
>  
>  config PCIE_TEGRA194_HOST
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select PHY_TEGRA194_P2U
> @@ -241,7 +241,7 @@ config PCIE_TEGRA194_HOST
>  
>  config PCIE_TEGRA194_EP
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	select PHY_TEGRA194_P2U
> -- 
> 2.25.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

