Return-Path: <linux-pci+bounces-19558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF4A064B7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 19:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135787A0FE9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29851FFC55;
	Wed,  8 Jan 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdNeJgKR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534E2594BE;
	Wed,  8 Jan 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361461; cv=none; b=VFskiq30auvfrnWpET/lm3dmBsmSgekJytNQYlhtEQsyZcXg4AtrDWoX/BhfI+aMAeRxuOFD9zxWZAh7iyZI8+TEWoUh5aKj8F6+CZrFsGTY34yRlXjrIJ+QCbBjZWO5osV+r8Uo7aMdQVLq19hBwZVt+jUeuuPaNBrPGRAL4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361461; c=relaxed/simple;
	bh=ZwPabJmUBlQdjA4Q9xEJG0lrsvVhEOBQqWFC2bJVvUE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E1AwRG1mYShaVyexbj1YwXgm+LfP8qARll6a1VwZO0siPQ5LE+J7eEmMZLPqTqntfxj4jFzdOoNIbRfwxdenQpMw8EMBRW5FcgI8ohtTl8zGrYxrPNVlzoIex8n/efOzxHUqxMQJxb3PU8xa9vXI45mQ/1XchdgI/V6RdX/YkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdNeJgKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000B5C4CEDF;
	Wed,  8 Jan 2025 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736361461;
	bh=ZwPabJmUBlQdjA4Q9xEJG0lrsvVhEOBQqWFC2bJVvUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OdNeJgKRLL1xit0MG5xzh5wgrLKF7AEfkRB2dWUrIdQnY/7R/Os24zsb9Q1KhK+cS
	 udT5v9EDqEXheOYBBrpgCnChLlM8Oqg/yQCyy7bzKcwDDdG5UM0i+I+Uv/LmGDU+o4
	 3ca6ztI3F05bjFgiMMa1jfSOWuAlXElbpBIMxarbfn1o2ZWNxfRhOwRcS2MFlOx60O
	 pLC0woi/EVenTfrRSqI7H67Ipo29G4SuaVeCnGGaJNnTlc4c6/dzyoF+tthDUkGX0g
	 ay3AiyhKXxaEY61gGUzH4d8dMKuSkjyDYhTdoI24BSCV4OaZ/ecOllDEVOxsn7zMb0
	 yOi4aCaOlrJew==
Date: Wed, 8 Jan 2025 12:37:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, matthew.gerlach@altera.com
Subject: Re: [PATCH v3 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
Message-ID: <20250108183739.GA222166@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108165909.3344354-4-matthew.gerlach@linux.intel.com>

On Wed, Jan 08, 2025 at 10:59:07AM -0600, Matthew Gerlach wrote:
> Add the base device tree for support of the PCIe Root Port
> for the Agilex family of chips.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v3:
>  - Remove accepted patches from patch set.
> 
> v2:
>  - Rename node to fix schema check error.
> ---
>  .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> new file mode 100644
> index 000000000000..50f131f5791b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2024, Intel Corporation
> + */
> +&soc0 {
> +	aglx_hps_bridges: fpga-bus@80000000 {
> +		compatible = "simple-bus";
> +		reg = <0x80000000 0x20200000>,
> +		      <0xf9000000 0x00100000>;
> +		reg-names = "axi_h2f", "axi_h2f_lw";
> +		#address-cells = <0x2>;
> +		#size-cells = <0x1>;
> +		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
> +			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
> +			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
> +			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
> +			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
> +			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
> +
> +		pcie_0_pcie_aglx: pcie@200000000 {
> +			reg = <0x00000000 0x10000000 0x10000000>,
> +			      <0x00000001 0x00010000 0x00008000>,
> +			      <0x00000000 0x20000000 0x00200000>;
> +			reg-names = "Txs", "Cra", "Hip";
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 0x14 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <0x1>;
> +			device_type = "pci";
> +			bus-range = <0x0000000 0x000000ff>;

I don't think this bus-range is needed since
pci_parse_request_of_pci_ranges() defaults to 00-ff when bus-range is
absent.

