Return-Path: <linux-pci+bounces-19574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4AA068FF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 23:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F83A75F7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2757C204C0B;
	Wed,  8 Jan 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCMDMUeb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC82046AA;
	Wed,  8 Jan 2025 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376838; cv=none; b=UbMS9/0vC6moeH/ivfp1uxhtO77novG+sRr0OhG93QfKbtxu0VbmnZsqzF8umwcmvczew3CO90xChMTUoq+7QPlJcVeMFsRPOadqF/iJSamf0RIkmryTBITNzdV0QnUoitmR6HGa7U8sBINxTMARj2Cg8DGvbVINnWC8draSJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376838; c=relaxed/simple;
	bh=nrbf/0s9qIBgFAh36LroJUzXgKF26iNjLFDrtg1CJz4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a8hNIYbefDK4VUq120QacczbuhRiP5CRAIdN/wm/NVJARFvYU7jmzzYnJ7f4dwOEjyVV60Qo2zDcb53dMrFG6lFEcdghv2Y0OV1gFtFjWhSl6iEI3ajrprEN68uBnU2egnHfQ4jjDjgYrBF/Z5YoP+0FEr0+sQjxG6OrXHm5sKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCMDMUeb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736376836; x=1767912836;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nrbf/0s9qIBgFAh36LroJUzXgKF26iNjLFDrtg1CJz4=;
  b=FCMDMUebdYH851HroSRXxLTTLH5aRmCkTSX6m5tn2Nf95t7oatL9U48H
   UKFDSvocbrgO13cHgg4uEaKlYtIO/0cq+BzY9OGAMtSx/SVHixUJvuABu
   qnE9S4xSPUvVetLPPeHXfZhZChdQaNLk+/GHyESDw3c8z8S+TAwwzApmp
   1GGHvo/bzK2uZUnmpe48jaidg8X8QsuNkKA7B7WjO8MarFdMKsoQ5vP3c
   wKnTJQaw9DnvVGyqkXzIupkyrZCeJRpDAcVTYRtGfqOmFUUKruWzZWnh9
   vb8c7F9T1uXiuNwM8oBgN3tvdr/tX0azVmY8fJ6QRaeTpY3oUbCI3uqdC
   g==;
X-CSE-ConnectionGUID: AXmHkgRfRP6jbvjZe69IeA==
X-CSE-MsgGUID: Deqd/oJgRPWgo1NlIi/m2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36317336"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="36317336"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:53:56 -0800
X-CSE-ConnectionGUID: Gnjdy6tFSlSTx9A1VlbMjQ==
X-CSE-MsgGUID: WjZ589A4RY6X8i/d1U0onw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134120510"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:53:55 -0800
Date: Wed, 8 Jan 2025 14:53:50 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com
Subject: Re: [PATCH v3 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
In-Reply-To: <20250108183739.GA222166@bhelgaas>
Message-ID: <90879a6-979b-9b7f-1df8-44e8e1b7a23@linux.intel.com>
References: <20250108183739.GA222166@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 8 Jan 2025, Bjorn Helgaas wrote:

> On Wed, Jan 08, 2025 at 10:59:07AM -0600, Matthew Gerlach wrote:
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
>
> I don't think this bus-range is needed since
> pci_parse_request_of_pci_ranges() defaults to 00-ff when bus-range is
> absent.
>

Yes, pci_parse_request_of_pci_ranges() does default to using 00-ff when 
the bus-range property is absent. Removing the bus-range property does 
result in an extra kernel message at startup:
     No bus range found for ...,using [bus 00-ff].

If the extra kernel message is not a problem, then removing the bus-range 
property does result in a smaller device tree.

Matthew Gerlach

