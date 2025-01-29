Return-Path: <linux-pci+bounces-20554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39293A224A3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 20:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876D916331E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9727A1E25E3;
	Wed, 29 Jan 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IS8xWVKP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85593158A09;
	Wed, 29 Jan 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179763; cv=none; b=mC6om1BLO6OeHFSz49aSjV+q3uvlKMxbN8KaABKuyH4Yajpd/vLiIempvIEr6Hpauhy694FM0174NObTS1X+5keOKcQaNgGpSnHHot83kb7Ucj3JfANHZryS6d0eIxbYM5ycebmy9n5rcobobQG27mDOU5trro2118ORsiEGRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179763; c=relaxed/simple;
	bh=GDxeWC0pz54R53GYZVvg2mQ4xWwjvwvXLwRqtgT3Fy0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vCBjVvYcD+Z3TYSrLuksi0fInFwJm6q0t1tRN+J0o1q2D4oGVhULIbcxBDmemzwkUPGqD3WU8nXoPOsS76yCtQpeLcoSJK6Pm2YZKu1dDspE/Sox0KyA0/zVpafmFBQrf6ck5p/nna0yaw3niiGLfJJ8Bwt/Tz6VjaV+CT4FVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IS8xWVKP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738179762; x=1769715762;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GDxeWC0pz54R53GYZVvg2mQ4xWwjvwvXLwRqtgT3Fy0=;
  b=IS8xWVKPFLQQTQxeJLMiaQ7zmgN+CTRucSL74dcue8LHH5t7TYir/CjO
   ESvQ96xuiwjioIAKI2T+pgKYIE9qwB9B9bkrFj2w8r2O5Z0GR//ksd/FA
   HVFZFJPup/w7qb/rVjNi7d+XyLC1ZNlsLD0+ux8dqzlNAlOWctPIRuDQi
   4QnfS75HXAawBQCUh8pWlpajbDmNLRxSXvLOJcTSYDfSZl7UW2SP8bVBc
   TgXDBxm4QIny2IMElPtmTB/qujJ68wxJymXklF1d7izmDbxq6zb8YuQFE
   kfh1P9UQ1DAv/MpqrODFXIGaiQ9WwiWecCiAvfud+7KMGRtX+dbarcy7S
   g==;
X-CSE-ConnectionGUID: dUI8Wie0S2yHYIUNfdSI4w==
X-CSE-MsgGUID: a+TijuzPSSiDtbJoBtW9vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="42373092"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="42373092"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 11:42:41 -0800
X-CSE-ConnectionGUID: Aqq/Ed9vR+eJE/p0Ihiiww==
X-CSE-MsgGUID: WXWWZZguRxmLx2S2nrCsFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="114156340"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 11:42:40 -0800
Date: Wed, 29 Jan 2025 11:42:40 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
In-Reply-To: <ea614dc5-ad24-4795-b9ba-fa682eda428f@kernel.org>
Message-ID: <22cb714e-db76-b07-8572-2f70f6848369@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-4-matthew.gerlach@linux.intel.com> <ea614dc5-ad24-4795-b9ba-fa682eda428f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 29 Jan 2025, Krzysztof Kozlowski wrote:

> On 27/01/2025 18:35, Matthew Gerlach wrote:
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
>
> Odd spaces in SPDX tag.

Yes, there should only be one space.

>
>> +/*
>> + * Copyright (C) 2024, Intel Corporation
>> + */
>> +&soc0 {
>> +	aglx_hps_bridges: fpga-bus@80000000 {
>> +		compatible = "simple-bus";
>> +		reg = <0x80000000 0x20200000>,
>> +		      <0xf9000000 0x00100000>;
>> +		reg-names = "axi_h2f", "axi_h2f_lw";
>
> Where is this binding defined?

The bindings for these reg-names are not currently defined anywhere, but 
they are also referenced in the following:
     Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
     arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
I am not exactly sure where the right place is to define them, maybe
Documentation/devicetree/bindings/arm/intel,socfpga.yaml. On the other 
hand, no code references these names; so it might make sense to just 
remove them.

>
>> +		#address-cells = <0x2>;
>> +		#size-cells = <0x1>;
>
> These two are not hex.

I will change all #address-cells and #size-cell to decimal.

>
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
>
> Where is this binding defined?

Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml

>
>
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <GIC_SPI 0x14 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <0x1>;
>> +			device_type = "pci";
>> +			bus-range = <0x0000000 0x000000ff>;
>> +			ranges = <0x82000000 0x00000000 0x00100000 0x00000000 0x10000000 0x00000000 0x0ff00000>;
>> +			msi-parent = <&pcie_0_msi_irq>;
>> +			#address-cells = <0x3>;
>> +			#size-cells = <0x2>;
>
> Same problem for all cells.
>
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
>
> That's decimal. Value is for humans and we count numbers in decimal.

I will change num-vectors to decimal.

Thanks for the review,
Matthew Gerlach

>
>
>
> Best regards,
> Krzysztof
>

