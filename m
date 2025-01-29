Return-Path: <linux-pci+bounces-20559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0DA2267B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 23:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C81B161BD3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 22:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736C1AF0BF;
	Wed, 29 Jan 2025 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqUmt5a1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221B199EBB;
	Wed, 29 Jan 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738191262; cv=none; b=Hp/seXTI0CdEauFSRpInvL56CjLsYAypn29yM+MovmErdoCMbE5KlqSuR/sQmAIdniwDK91KgJngM4fYOnIB50rq0uTo9MpvngW9EnwfDGwrellzDN2RSoRFnxQQfZ1sg1ya0cYbBkFuRNtnEDXsuXo9DoZqHRDsMrc+7UZWPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738191262; c=relaxed/simple;
	bh=0GiNQekHdUNA2y6dcTt32YRSoavfN1TedMBkibNu9/o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iEFncvIDY7gyO9jJEGM8PZxMi1pkXVNcubDplCZlDaNePKN9kKA2qQQsrdEXZEjszqsi9Nx4wkNW/nZUFJDbNBba5bT6wCbo1VznmE5rSWYGymowmlOPJOiOT/vhZvQJYJQM4RfdnF+wTIsLKIn3t0bP2tRKNIyIw+fV4qBcDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqUmt5a1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738191261; x=1769727261;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0GiNQekHdUNA2y6dcTt32YRSoavfN1TedMBkibNu9/o=;
  b=GqUmt5a1d6BC0Xr71eSwgn8zjr6GPlz3lXIFiU9Z5M/VPWEuSTyZWsPn
   E3Rhksx1ZBh8KDnGYQxBj5V+nA1eRroPWZBL3kZ1QxAmnHufDvjw9ut7L
   vRbVBJ7vGtRidxL7QoVZME+NjHLlqYV/mTmmyQHhQ0XjaTaxSTwTPZUdc
   NB5EqsIDs+vTAY857K6MknzVuJtHCBeFi7Qw8PhTpB6x0B/T7rYmSUlhE
   TewSCcszdDR+o8UtD1hmfZFNNf0vslBQKRpFaDwmc9HgOuiXCTztq/LC9
   3YRZqAQj5uZCDZJZx5RSuOZjtGZBH3jjAknjdxJS+bQAO9MkY57ERfkax
   Q==;
X-CSE-ConnectionGUID: +WgODY/JR36K44HS7mrX7A==
X-CSE-MsgGUID: R2nbCBnLTnunkICznQE48g==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38866491"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38866491"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 14:54:21 -0800
X-CSE-ConnectionGUID: T/I/jvI3QZSoMZBs0HqnOw==
X-CSE-MsgGUID: /kwW0rF3RyCon6JaIzFPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="108969351"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 14:54:20 -0800
Date: Wed, 29 Jan 2025 14:54:19 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v5 4/5] arm64: dts: agilex: add dts enabling PCIe Root
 Port
In-Reply-To: <58f7925c-dbed-4a5e-8e7d-095bef197931@kernel.org>
Message-ID: <319e9f53-6910-a144-8752-4bcc47b7cba@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-5-matthew.gerlach@linux.intel.com> <58f7925c-dbed-4a5e-8e7d-095bef197931@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII



On Wed, 29 Jan 2025, Krzysztof Kozlowski wrote:

> On 27/01/2025 18:35, Matthew Gerlach wrote:
>> Add a device tree enabling PCIe Root Port support on
>> an Agilex F-series Development Kit which has the
>> P-tile variant PCIe IP.
>
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>
Thank you for the pointer. I will fix the commit message accordingly.

>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v3:
>>  - Remove accepted patches from patch set.
>> ---
>>  arch/arm64/boot/dts/intel/Makefile               |  1 +
>>  .../socfpga_agilex7f_socdk_pcie_root_port.dts    | 16 ++++++++++++++++
>>  2 files changed, 17 insertions(+)
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
>> index 000000000000..76a989ba6a44
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier:     GPL-2.0
>> +/*
>> + * Copyright (C) 2024, Intel Corporation
>> + */
>> +
>> +#include "socfpga_agilex_socdk.dts"
>> +#include "socfpga_agilex_pcie_root_port.dtsi"
>> +
>
> Missing board compatible, missing bindings.

The model and compatible bindings are inherited from socfpga_agilex_socdk.dts.

>
>> +&pcie_0_pcie_aglx {
>> +	status = "okay";
>> +	compatible = "altr,pcie-root-port-3.0-p-tile";
>
> Why do you define the compatible here, not in DTSI? This is highly
> unusual and confusing. Also, compatible is never the last property, but
> opposite.

The current DTSI supports all three variants of the PCI hardware in the 
Agilex family, referred to as P-Tile, F-Tile, and R-Tile. This particular 
board has an Agilex chip with the P-Tile variant of the PCI hardware.

I will move the compatible property to be the first property.

>
> Plus:
>
> Please run scripts/checkpatch.pl and fix reported warnings. After that,
> run also `scripts/checkpatch.pl --strict` and (probably) fix more
> warnings. Some warnings can be ignored, especially from --strict run,
> but the code here looks like it needs a fix. Feel free to get in touch
> if the warning is not clear.

The only warning I see from scripts/checkpatch.pl --strict is "added, 
moved or deleted file(s), does MAINTAINERS need updating?". The directory, 
arch/arm64/boot/dts/intel/, is already mentioned in the MAINTAINERS file. 
Do I need to do anything to resolve this?

>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.

The dtschema check failures are inherited from socfpga_agilex_socdk.dts.
Rob Herring's bot indicates that "Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not." Is this 
applicable here? Is the correct way to fix the existing dtschema check 
warnings is with their own patches, rather than adding to this PCIe Root 
Port patchset?

Thanks for the review,
Matthew Gerlach

>
>
>
> Best regards,
> Krzysztof
>

