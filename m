Return-Path: <linux-pci+bounces-20628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B663A24B61
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 19:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E429B1640A8
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F1E1CAA84;
	Sat,  1 Feb 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMe2V8sB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3681CAA68;
	Sat,  1 Feb 2025 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738433242; cv=none; b=stfRkkKC0DVClLpRti2QdiXMCPcI6Fu5wLD3hdU9Ybv+se2baO6lPWllU0a3p/CEfdO09cXuOhlnfmowP+lM2K9NBdmWjOj/KQ1w/F5lQkgQ8q4i946ZYawZ9ClpV/gWeUfZSIHnmPLXh5nl4QdkrqrdrCAp37r5nisI0StsJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738433242; c=relaxed/simple;
	bh=QNjg3ckstEEe8MylKQY/66Zc4nhJCM5qeaytIXE5Ikw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cRA4MSf38jiE67rrwEMx0mtTmdmM3iRB4ZcC3FCaOUXH5WE7ktucHwu/S6dcvaO/0QA/CxlND+wL6Hoi49M+OBvSzgfWmDwNnx31MfaAIakSdODP2Cprie/ehqfHEHApPKtnT420QdKrqj9Nc11nycnUyn3Xg0+F4ZGLznUvjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMe2V8sB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738433241; x=1769969241;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QNjg3ckstEEe8MylKQY/66Zc4nhJCM5qeaytIXE5Ikw=;
  b=ZMe2V8sB/4Xxxv/RH1rk5UUyJ9qLOnJ1bx5TaLemL4yzsFeHqx9oNOmc
   kHnvTPU2WK9hGn+nfH5GId1JegSYm5nxcCgZQ+CIKrbaakcmfRfz2MbO9
   L8Pf9gxvMPqP5iBtbinyg5+wRsuE+2+P6f1PwqK715lGZ9S/lAsx/Qa9m
   65Bb8DSQWb0F0iJWhhlsckqKQarbceTnZkdySb6LbrAtWbaKUyEIh4dUv
   OAp3Y9OXSfC+NAtyho5zIxsMyoUWG6QcYXIXAGFtjcPOkahkX/pZpiT9x
   UAR0rcanBexTNf/IqtxHQvX0PdzSg8xNcR2ABvOcPywo7AIr/5k5HDcbd
   w==;
X-CSE-ConnectionGUID: OOttOwsmTn2E5p3KXiu68w==
X-CSE-MsgGUID: 82O3ECdVTk+L+2UM+SdisQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11333"; a="61450125"
X-IronPort-AV: E=Sophos;i="6.13,252,1732608000"; 
   d="scan'208";a="61450125"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 10:07:20 -0800
X-CSE-ConnectionGUID: m2JodxUcQdu2VuJbrdAcFA==
X-CSE-MsgGUID: KV7B0kQXT4+nYjN0w365YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133160352"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 10:07:20 -0800
Date: Sat, 1 Feb 2025 10:07:19 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Frank Li <Frank.li@nxp.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
In-Reply-To: <Z5qS1NKSRn8pSqg1@lizhi-Precision-Tower-5810>
Message-ID: <41edda71-de9d-e4e0-ef62-83e98f753e@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-4-matthew.gerlach@linux.intel.com> <Z5qS1NKSRn8pSqg1@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 29 Jan 2025, Frank Li wrote:

> On Mon, Jan 27, 2025 at 11:35:48AM -0600, Matthew Gerlach wrote:
>> Add the base device tree for support of the PCIe Root Port
>> for the Agilex family of chips.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v3:
>>  - Remove accepted patches from patch set.
>>
>> v2:
>>  - Rename node to fix schema check error.
>> ---
>>  .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
>> new file mode 100644
>> index 000000000000..50f131f5791b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier:     GPL-2.0
>> +/*
>> + * Copyright (C) 2024, Intel Corporation
>> + */
>> +&soc0 {
>> +	aglx_hps_bridges: fpga-bus@80000000 {
>> +		compatible = "simple-bus";
>> +		reg = <0x80000000 0x20200000>,
>> +		      <0xf9000000 0x00100000>;
>> +		reg-names = "axi_h2f", "axi_h2f_lw";
>> +		#address-cells = <0x2>;
>> +		#size-cells = <0x1>;
>> +		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
>> +			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
>> +			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
>> +			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
>> +			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
>> +			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
>> +
>> +		pcie_0_pcie_aglx: pcie@200000000 {
>> +			reg = <0x00000000 0x10000000 0x10000000>,
>> +			      <0x00000001 0x00010000 0x00008000>,
>> +			      <0x00000000 0x20000000 0x00200000>;
>> +			reg-names = "Txs", "Cra", "Hip";
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <GIC_SPI 0x14 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <0x1>;
>> +			device_type = "pci";
>> +			bus-range = <0x0000000 0x000000ff>;
>> +			ranges = <0x82000000 0x00000000 0x00100000 0x00000000 0x10000000 0x00000000 0x0ff00000>;
>
> This convert to pci address 0x0010_0000..0x1000_0000 from parent bus address
> 0x1000_0000..0x1ff0_0000
>
> aglx_hps_bridges bridge convert 0x90100000..0xa000_0000 (cpu address) to
> 0x1000_0000..0x1ff0_0000 according to ranges[1](second entry).
>
> Just want to confirm that "0x1000_0000..0x1ff0_0000" is actually reflect
> hardware behavior.

As far as I know, these conversions reflect the actual hardware behavior, 
but I will investigate further to confirm.

>
> On going a thread
> https://lore.kernel.org/linux-pci/Z5pfiJyXB3NtGSfe@lizhi-Precision-Tower-5810/T/#t
>
> Try to clean up all cpu_addr_fixup() or similar fixup() in pci root complex
> drivers, but which require dtsi reflect the real hardware behavior.
>
> In most current pci driver, even "0x1000_0000..0x1ff0_0000" is wrong, it
> still work by drivers' fixup. If dts correct descript hardware, these
> fixup can be removed.

The current driver, drivers/pci/controller/pcie-altera.c, does not have 
any cpu_addr_fix(); so I think the dts is properly describing the 
hardware, but I will continue to investigate and follow the thread
to clean the fixups.

>
> best regards
> Frank

Thanks for the feedback,
Matthew Gerlach

>
>> +			msi-parent = <&pcie_0_msi_irq>;
>> +			#address-cells = <0x3>;
>> +			#size-cells = <0x2>;
>> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>> +			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_0_pcie_aglx 0 0 0 0x1>,
>> +					<0x0 0x0 0x0 0x2 &pcie_0_pcie_aglx 0 0 0 0x2>,
>> +					<0x0 0x0 0x0 0x3 &pcie_0_pcie_aglx 0 0 0 0x3>,
>> +					<0x0 0x0 0x0 0x4 &pcie_0_pcie_aglx 0 0 0 0x4>;
>> +			status = "disabled";
>> +		};
>> +
>> +		pcie_0_msi_irq: msi@10008080 {
>> +			compatible = "altr,msi-1.0";
>> +			reg = <0x00000001 0x00018080 0x00000010>,
>> +			      <0x00000001 0x00018000 0x00000080>;
>> +			reg-names = "csr", "vector_slave";
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <GIC_SPI 0x13 IRQ_TYPE_LEVEL_HIGH>;
>> +			msi-controller;
>> +			num-vectors = <0x20>;
>> +			status = "disabled";
>> +		};
>> +	};
>> +};
>> --
>> 2.34.1
>>
>

