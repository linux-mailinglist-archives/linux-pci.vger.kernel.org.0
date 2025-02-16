Return-Path: <linux-pci+bounces-21560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0240A37410
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B9D7A1F26
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AE18DB1E;
	Sun, 16 Feb 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehPrG1AO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146214D43D;
	Sun, 16 Feb 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739707263; cv=none; b=rN77nJcylHCVujQF9Cs7IvU0LyjtXFd+1U1GjX0tjmk1e1zCbfWZmJvWxzF9AgsvLVLYgh2ImOX0ahr3wr8+3MTEM13NDj/bujC7e1MZRkj8dLdtqQZQHc+wi7oPuWAXwn5UZ8OOQiYJyzPiPecnfq7zq7gJqcRZ3d+DkUjih6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739707263; c=relaxed/simple;
	bh=5W1uAmsGSKQLf1hDu/WDeFfWE+IKAp36u+Tvg/TZu0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRPWp9mLA3M9amV7uvO7nl9X0ReMVeQ8wr2fzlKRwbC68ZYCMxoc1quNMfYXxJUbXSwiDW0I7gQFRltMgKTu6UETvcMmvPy0oRUjlw6VaTA7dHK2ciIdnlU1UcLYGpCxNGnMm4NmGbKcpe93RvUKVE1ndoqRiO1QgFW72FEqP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehPrG1AO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41834C4CEDD;
	Sun, 16 Feb 2025 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739707263;
	bh=5W1uAmsGSKQLf1hDu/WDeFfWE+IKAp36u+Tvg/TZu0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehPrG1AOSMu5y7xd03v8rgzgyG/CEHpaIaN5b1fIYzapjt53rVhsL+pMQT9B1RG/n
	 l00f3J93yEq6pi/n4eAYV6R5MZPF76R2pqf9AoMT1CCzqzIjahYoa05uLOeJ5tDSxI
	 zntCLAiMKB4zdHUa+gPpDQFuBelVBthULzShIS9knoneM9FmQazWSntACX+V+Vuoq6
	 cmfmmCTVZ4sW1UhZM2wZ4tjGAyPeh2uwYglS9A+1C+3bO8XitgxAWndBnIiE2BR59d
	 6ImiNG/S1Tl0/YjyEzgEEsXZqe77rIENYR9xnm6JfL6nwrhWCDzRBKgtktpjnNKTAI
	 ZfZfl/sk9TyZQ==
Date: Sun, 16 Feb 2025 13:00:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
	peter.colberg@altera.com
Subject: Re: [PATCH v7 6/7] arm64: dts: agilex: add dts enabling PCIe Root
 Port
Message-ID: <20250216-super-goose-of-realization-b9efaf@krzk-bin>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
 <20250215155359.321513-7-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250215155359.321513-7-matthew.gerlach@linux.intel.com>

On Sat, Feb 15, 2025 at 09:53:58AM -0600, Matthew Gerlach wrote:
> Add a device tree enabling PCIe Root Port support on an Agilex F-series
> Development Kit which has the P-tile variant of the PCIe IP.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v7:
>  - Create and use appropriate board compatibility and use of model.
> 
> v6:
>  - Fix SPDX header.
>  - Make compatible property first.
>  - Fix comment line wrapping.
>  - Don't include .dts.
> 
> v3:
>  - Remove accepted patches from patch set.
> ---
>  arch/arm64/boot/dts/intel/Makefile            |   1 +
>  .../socfpga_agilex7f_socdk_pcie_root_port.dts | 147 ++++++++++++++++++
>  2 files changed, 148 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
> 
> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
> index d39cfb723f5b..737e81c3c3f7 100644
> --- a/arch/arm64/boot/dts/intel/Makefile
> +++ b/arch/arm64/boot/dts/intel/Makefile
> @@ -2,6 +2,7 @@
>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>  				socfpga_agilex_socdk.dtb \
>  				socfpga_agilex_socdk_nand.dtb \
> +				socfpga_agilex7f_socdk_pcie_root_port.dtb \
>  				socfpga_agilex5_socdk.dtb \
>  				socfpga_n5x_socdk.dtb
>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
> new file mode 100644
> index 000000000000..19b14f88e32d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024, Intel Corporation
> + */
> +#include "socfpga_agilex.dtsi"
> +#include "socfpga_agilex_pcie_root_port.dtsi"
> +
> +/ {
> +	model = "SoCFPGA Agilex SoCDK";
> +	compatible = "intel,socfpga-agilex7f-socdk-pcie-root-port", "intel,socfpga-agilex";

So that's different SoC (Agilex F series)? Why isn't this expressed in
compatibles? Is it different or the same board? If different, why
"root-port" in board name? Is this how the product is named?

Best regards,
Krzysztof


