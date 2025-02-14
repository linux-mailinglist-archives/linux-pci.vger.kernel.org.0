Return-Path: <linux-pci+bounces-21477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF47A3625A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1986161BB9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CC267388;
	Fri, 14 Feb 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8ujkg42"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF15267382;
	Fri, 14 Feb 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548546; cv=none; b=ttceddPJ3RhcQuh9ZbvDZ3ScXtuaecMO44ah5+MMv6hvRSa2PzpqydnoAkzUSAY3pN0qIArzN5AafudzSRYjHjndKsPVGktT5KXJ9UdUOE62tBSe3PJRoWlq+OB7Yc1KmuynpUlXaDMFYcwVNBQ8WRQXSlJziTMbDgtP+yF74GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548546; c=relaxed/simple;
	bh=LlVze+kxKmlHWCECDwA3PL6Dfqv4CqLXlK6+rWbnHB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyuVnQh3dPcyTdOsOJXU0O6uaLU0a9TiVf473nRy9G25oyQOZo239HBo9kvj6GjE2MDK2U/QYaQ8nuTTM+y72kYqT7YhoZ1B/xQf6ovGibsZ+6CTvqdQTnfgp40ommjzMMWHMRwhgzrJarx1lNNSqOStwSuqTU7ivkhFf/HQv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8ujkg42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A871C4CED1;
	Fri, 14 Feb 2025 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548544;
	bh=LlVze+kxKmlHWCECDwA3PL6Dfqv4CqLXlK6+rWbnHB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8ujkg42rDbkAuU1sBoQ9Kv/wIKbO72nJ+oygvzvZikFgEi/v+auOXdb5vplXB6we
	 DfG03k4mP1snl1V3IS7/duCej8wYsO76C+Cyn07LZ7xtscWwvGH6UcQqize8a70T8Y
	 /2hlqeaMErss4ZfBAvfDz6CpN7W3ErLoUC4QicO09gI/voz4sNbA8CYWdVes+VFtcj
	 9Vt2vs+A2KDFYFLQZOR0HCtmF7x3IuZ14uRuvwm52OG7vMYp/SOX4tRb8O2wsyMenj
	 xyalrkKRDDUR9LhcROWDpQgerA4838/qjKD8kNFEJb62UGyq9A2lWTRpy6bsBNh1gV
	 jFiMa/mjBoBNQ==
Date: Fri, 14 Feb 2025 21:25:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Message-ID: <20250214155536.ap7mjvutnuledkki@thinkpad>
References: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
 <20250212055059.346452-3-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212055059.346452-3-thippeswamy.havalige@amd.com>

On Wed, Feb 12, 2025 at 11:20:59AM +0530, Thippeswamy Havalige wrote:
> The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> incorporate the Coherency and PCIe Gen5 Module, specifically the
> Next-Generation Compact Module (CPM5NC).
> 
> The integrated CPM5NC block, along with the built-in bridge, can function
> as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> configuration.
> 
> Bridge errors are managed using a specific interrupt line designed for
> CPM5N. Intx interrupt support is not available.
> 
> Currently in this patch Bridge errors support is not added.

s/patch/commit,

> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v2:
> - Update commit message.
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 85 ++++++++++++++----------
>  1 file changed, 51 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..c26ba662efd7 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -84,6 +84,7 @@ enum xilinx_cpm_version {
>  	CPM,
>  	CPM5,
>  	CPM5_HOST1,
> +	CPM5NC_HOST,
>  };
>  
>  /**
> @@ -483,31 +484,33 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  	else
>  		dev_info(port->dev, "PCIe Link is DOWN\n");
>  
> -	/* Disable all interrupts */
> -	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> -		   XILINX_CPM_PCIE_REG_IMR);
> -
> -	/* Clear pending interrupts */
> -	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> -		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> -		   XILINX_CPM_PCIE_REG_IDR);
> -
> -	/*
> -	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> -	 * CPM SLCR block.
> -	 */
> -	writel(variant->ir_misc_value,
> -	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> +	if (variant->version != CPM5NC_HOST) {

How about,

	if (variant->version != CPM5NC_HOST)
		return;

Btw, what is the reason to skip these register settings for this controller?
Especially the 'Bridge enable bit'.

> +		/* Disable all interrupts */
> +		pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> +			   XILINX_CPM_PCIE_REG_IMR);
> +
> +		/* Clear pending interrupts */
> +		pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> +			   XILINX_CPM_PCIE_IMR_ALL_MASK,
> +			   XILINX_CPM_PCIE_REG_IDR);
> +
> +		/*
> +		 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> +		 * CPM SLCR block.

Please make use of 80 column width.

> +		 */
> +		writel(variant->ir_misc_value,
> +		       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> +
> +		if (variant->ir_enable) {

nit: you don't need braces here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

