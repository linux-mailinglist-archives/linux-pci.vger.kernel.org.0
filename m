Return-Path: <linux-pci+bounces-21771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B4DA3ABDF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD6D188BAD3
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9851D958E;
	Tue, 18 Feb 2025 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gw30W8cF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7731B6CEC;
	Tue, 18 Feb 2025 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918458; cv=none; b=Vrhe6HsKhDjMJ0YFYWzhIuizEOMKeaIf8X6SocuUjlI5sJT5WW+pmXEbxJ7thNyd7OqNhfsKXXqYFBpj0cQMxXu8az7R6M1JsZ1TEHesfFYApUZIcuarHXPBsua/XMLvk+BoYokJGr1iZUo08NdS1P5N37le2h/jpUWueCc0Jw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918458; c=relaxed/simple;
	bh=RO3b7hVEQCx2e2z3TwZF1cWDw0VO09iMKEkxTQpz/0o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rlBMiFqPN0WZmzPP8VgKWHfXDGSotMbad0cAKAWPV/G3lWQocF0JKJJFgHG1eGBX+x51Vfxq4hyF9B+kFohG83+J061v+tqpl03svkTFUcnM+YTHY7SMW5UbhH+Fmy9o4J7dmSUKr9xAfitGPmvTqqnMh3zwVAr6XAntXelQQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gw30W8cF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739918457; x=1771454457;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RO3b7hVEQCx2e2z3TwZF1cWDw0VO09iMKEkxTQpz/0o=;
  b=Gw30W8cFLuMgRwHv6ApF7yP/1Wzg6M0Xvm6Rw8kHE6BXtQ37xTxcSCqF
   ZELO+qb6aOLhmlm/BlQdr+rKcCWpZc+WNgrumUV8l9HU8eb0YL/eiSlrd
   QNRhPHsJI6CiVR3e4mSbTY5XaYKU9QwR0eUEWZW1NeUVMEB7syGDwhKUH
   /68hn3yO73OxyLQRujb2+2yFOmvb5yr1rWmiyqGswvt5hL84k9pzgTZKv
   xoD64W0TPcuQebzp7+gSJeM6+k3rM6/2GOhxrFGFYi5qaOZGXd8v/i7AQ
   dX0DDOEABVuE5mfLbePj9U0GfonLBLTA5RU0jcqutHzcCZ0KYLCF3jQjJ
   w==;
X-CSE-ConnectionGUID: NdAvAfq3Q7OyZQAXmSNMcw==
X-CSE-MsgGUID: onmd2RybS2qjvEg2k6NOgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51257041"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="51257041"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 14:40:56 -0800
X-CSE-ConnectionGUID: 2KQSNDjWQYOEKoPzPBkyQg==
X-CSE-MsgGUID: 6DA2bOcGSK6gH0tIqfgGew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119474723"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 14:40:48 -0800
Date: Tue, 18 Feb 2025 14:40:47 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v7 6/7] arm64: dts: agilex: add dts enabling PCIe Root
 Port
In-Reply-To: <20250216-super-goose-of-realization-b9efaf@krzk-bin>
Message-ID: <f8fc27eb-6d9a-cd2c-4114-3149e7234ee5@linux.intel.com>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com> <20250215155359.321513-7-matthew.gerlach@linux.intel.com> <20250216-super-goose-of-realization-b9efaf@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Sun, 16 Feb 2025, Krzysztof Kozlowski wrote:

> On Sat, Feb 15, 2025 at 09:53:58AM -0600, Matthew Gerlach wrote:
>> Add a device tree enabling PCIe Root Port support on an Agilex F-series
>> Development Kit which has the P-tile variant of the PCIe IP.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v7:
>>  - Create and use appropriate board compatibility and use of model.
>>
>> v6:
>>  - Fix SPDX header.
>>  - Make compatible property first.
>>  - Fix comment line wrapping.
>>  - Don't include .dts.
>>
>> v3:
>>  - Remove accepted patches from patch set.
>> ---
>>  arch/arm64/boot/dts/intel/Makefile            |   1 +
>>  .../socfpga_agilex7f_socdk_pcie_root_port.dts | 147 ++++++++++++++++++
>>  2 files changed, 148 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>>
>> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
>> index d39cfb723f5b..737e81c3c3f7 100644
>> --- a/arch/arm64/boot/dts/intel/Makefile
>> +++ b/arch/arm64/boot/dts/intel/Makefile
>> @@ -2,6 +2,7 @@
>>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>>  				socfpga_agilex_socdk.dtb \
>>  				socfpga_agilex_socdk_nand.dtb \
>> +				socfpga_agilex7f_socdk_pcie_root_port.dtb \
>>  				socfpga_agilex5_socdk.dtb \
>>  				socfpga_n5x_socdk.dtb
>>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>> new file mode 100644
>> index 000000000000..19b14f88e32d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024, Intel Corporation
>> + */
>> +#include "socfpga_agilex.dtsi"
>> +#include "socfpga_agilex_pcie_root_port.dtsi"
>> +
>> +/ {
>> +	model = "SoCFPGA Agilex SoCDK";
>> +	compatible = "intel,socfpga-agilex7f-socdk-pcie-root-port", "intel,socfpga-agilex";
>
> So that's different SoC (Agilex F series)? Why isn't this expressed in
What was formally known as Agilex is now more precisely referred Agilex 7 
F series, Agilex 7 I series, or Agilex 7 M series. Yes, this should me 
reflected in the compatibles.

> compatibles? Is it different or the same board? If different, why
> "root-port" in board name? Is this how the product is named?

"root-port" refers to a particular board combined with a specific FPGA 
image and possibly a daughter card and cables. I am not sure that FPGA 
image specific DTS or DTSI should be in the kernel tree.

>
> Best regards,
> Krzysztof
>
>

Thanks for the feedback,
Matthew Gerlach

