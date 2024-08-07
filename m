Return-Path: <linux-pci+bounces-11464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49794B359
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 01:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8353283CB6
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 23:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93651509A5;
	Wed,  7 Aug 2024 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+P4ivrD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D63364A0;
	Wed,  7 Aug 2024 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071820; cv=none; b=iUz9tUiHT0BYrR7xSx9LWKOxA+UqV6S3kEO0lcKC8PALtMcYUITCsWaZIDiNV5nU5aHylt9oOR4LrvnthJez1JW3mn6BKL8aYV06XuTm1NAxPEzJ23VxRzCrYnvoUEUiB2jI1AtH24UHELbUklYa/2majxxH84ugnZvq/vmtwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071820; c=relaxed/simple;
	bh=P3OD7e9Qje8qnMS5j94aG1CfmYSlIKmYRVHNf+kg/vk=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JInuNyIg0R/n2H5Mvps7hP2eZ/bOd21j+YRaRCI2lok9MDXU8wTQpQXRncZ0homv2BD8U+pXMMb6aUiB2crHTWBmT+UkjJDtQ6caghyqRt00PiLw2bw4laLHapGxnAp7Zww5J5Nn4bsY59AzpMLhct3m5YNX6DLB3heUUa9awYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+P4ivrD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723071819; x=1754607819;
  h=date:from:to:subject:in-reply-to:message-id:references:
   mime-version;
  bh=P3OD7e9Qje8qnMS5j94aG1CfmYSlIKmYRVHNf+kg/vk=;
  b=Y+P4ivrDbmMCxTc7IkLJv1kpTGiLRB2QYZEpQKLdCppBsBVXvMmqchMD
   7t1QhTDO9vSTL/U3azoyJa+UG7D3HkBd1INgMV/ben89ZEm1XsimpwUQF
   YoAl42QI9lmBvo7O/TeU5j2epbnjwB6z9WRt0UVYdrvPp2C+D0eZK786S
   xS0o8Q+U+0wF4k/9/KMjba1plFsma3d/5rDyt+3EGbWC8bJvrM5xbUjL3
   bXTPN0l7qv5ZGgXAHqu3GeGKfYQmjGg4WQseVKFle3BIE6XDvvurPA7Js
   MB+ByoyMEaQv2SCidJkvsKRBqiFJui+cO/7PJ+4oCAhc2DcDKA8eIwDWO
   A==;
X-CSE-ConnectionGUID: gt96VjVWSaqEyt+iV/wHdw==
X-CSE-MsgGUID: jNgubI7dR/CMMPsfCbTSvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32315609"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32315609"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:03:38 -0700
X-CSE-ConnectionGUID: PYiX59MsRRW4SIzy5XDkbw==
X-CSE-MsgGUID: 3gJ80cnjRhuX7fnOZEz0Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56938865"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:03:38 -0700
Date: Wed, 7 Aug 2024 16:03:36 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
To: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org, 
    joyce.ooi@intel.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: agilex: add dtsi for PCIe Root Port
In-Reply-To: <20240731143946.3478057-6-matthew.gerlach@linux.intel.com>
Message-ID: <f792d181-4fa2-cbab-5d2d-2e219b137651@linux.intel.com>
References: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com> <20240731143946.3478057-6-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 31 Jul 2024, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add the base device tree for support of the PCIe Root Port
> for the Agilex family of chips.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
> 1 file changed, 55 insertions(+)
> create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
>
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> new file mode 100644
> index 000000000000..510dcd1c2913
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2024, Intel Corporation
> + */
> +&soc0 {
> +	aglx_hps_bridges: bridge@80000000 {
The node name, bridge@80000000, causing the following CHECK_DTBS error:

nodename:0: 'bridge@80000000' does not match 
'^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#

I will change the node name to fpga-bus@80000000 in v2.

Matthew Gerlach

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
> +			ranges = <0x82000000 0x00000000 0x00100000 0x00000000 0x10000000 0x00000000 0x0ff00000>;
> +			msi-parent = <&pcie_0_msi_irq>;
> +			#address-cells = <0x3>;
> +			#size-cells = <0x2>;
> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_0_pcie_aglx 0 0 0 0x1>,
> +					<0x0 0x0 0x0 0x2 &pcie_0_pcie_aglx 0 0 0 0x2>,
> +					<0x0 0x0 0x0 0x3 &pcie_0_pcie_aglx 0 0 0 0x3>,
> +					<0x0 0x0 0x0 0x4 &pcie_0_pcie_aglx 0 0 0 0x4>;
> +			status = "disabled";
> +		};
> +
> +		pcie_0_msi_irq: msi@10008080 {
> +			compatible = "altr,msi-1.0";
> +			reg = <0x00000001 0x00018080 0x00000010>,
> +			      <0x00000001 0x00018000 0x00000080>;
> +			reg-names = "csr", "vector_slave";
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_SPI 0x13 IRQ_TYPE_LEVEL_HIGH>;
> +			msi-controller;
> +			num-vectors = <0x20>;
> +			status = "disabled";
> +		};
> +	};
> +};
> -- 
> 2.34.1
>
>

