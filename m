Return-Path: <linux-pci+bounces-20705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B21A277AA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 17:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BEB18819F2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B568215780;
	Tue,  4 Feb 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt3Zq2GM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D2C215777;
	Tue,  4 Feb 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688280; cv=none; b=Ddwi3C7PxZG26rw56GSQkGyx1vdLgHN8h19RES2d15dQMZpIY3ik+7QSAIdHp1pVrhec1CpQOqj9HFgooC3NCtdOFPp/g1qjLna7cWABAba8+ismevAunIqS9BdGRchjxJG6KtpjOBMg3LdIcX3Gyw0BjxHs42NX4TyIBKpZaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688280; c=relaxed/simple;
	bh=Biy0JnOWSWQBDWmGR2lav0imxqRaoSXR9BdZU5MTFho=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NYQ962OEL1xTfZhEyHBvAOT7vvOG4bMns6Y22i6A+xxuf8mEOtq0SXOY7wuLSEeSzqUodho3Kmsk6u7bH/7UJDTKE6oY8lcyyoE28Jd923fwDQUvbXW58c1hpnLFjc7N3FV+uhPtpUA7dUQn/2Ve2vMzewLVHeatW4wBiPXecEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vt3Zq2GM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738688279; x=1770224279;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Biy0JnOWSWQBDWmGR2lav0imxqRaoSXR9BdZU5MTFho=;
  b=Vt3Zq2GMqUhaMhHszKlI9estNEBb+r5+rxoiezyyNAtbqKpEyqglGKwD
   YUhFRSeqUS79WWYHAXeI//IrGA6agn3I97nISau0+SwwkWH4UrVrZTdvA
   2pHHuvUTqaD6GQgw3Q98RFrsbmeNK78l8hZgiLPNGoVreD53iXj6rXWsp
   HRy7T6E1mHIBtn4RrBmxcdQJsm0TFZ84ukReN1edLXPrvyS6FUyOLS2QJ
   OplXYWTQ2ECwy28JXKiTHB0Q5TNhv0GSK2tSkwN9G1lni9hr0GwCjedJ/
   D5k3yBkIsn94yf61PuVLbs8+mgjOmax7fKuYp36dL8p2Uqmg5O2vrMCoA
   A==;
X-CSE-ConnectionGUID: P/0aEag3SvOodi/iwZGLYg==
X-CSE-MsgGUID: HTDwR48dR5GPB94BCwBnjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39332389"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39332389"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 08:57:58 -0800
X-CSE-ConnectionGUID: NslJsm7MQaWBBf38XlG9dA==
X-CSE-MsgGUID: uh5eORzRRvaGSwG3mjBXsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110824518"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 08:57:57 -0800
Date: Tue, 4 Feb 2025 08:57:57 -0800 (PST)
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
In-Reply-To: <eb77eec0-7d51-46a0-b5c6-83c68316ef32@kernel.org>
Message-ID: <4d9b5ca4-bebc-93c3-7d25-14d12899cab6@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-5-matthew.gerlach@linux.intel.com> <58f7925c-dbed-4a5e-8e7d-095bef197931@kernel.org> <319e9f53-6910-a144-8752-4bcc47b7cba@linux.intel.com>
 <eb77eec0-7d51-46a0-b5c6-83c68316ef32@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Thu, 30 Jan 2025, Krzysztof Kozlowski wrote:

> On 29/01/2025 23:54, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Wed, 29 Jan 2025, Krzysztof Kozlowski wrote:
>>
>>> On 27/01/2025 18:35, Matthew Gerlach wrote:
>>>> Add a device tree enabling PCIe Root Port support on
>>>> an Agilex F-series Development Kit which has the
>>>> P-tile variant PCIe IP.
>>>
>>> Please wrap commit message according to Linux coding style / submission
>>> process (neither too early nor over the limit):
>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>>
>> Thank you for the pointer. I will fix the commit message accordingly.
>>
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> ---
>>>> v3:
>>>>  - Remove accepted patches from patch set.
>>>> ---
>>>>  arch/arm64/boot/dts/intel/Makefile               |  1 +
>>>>  .../socfpga_agilex7f_socdk_pcie_root_port.dts    | 16 ++++++++++++++++
>>>>  2 files changed, 17 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
>>>> index d39cfb723f5b..737e81c3c3f7 100644
>>>> --- a/arch/arm64/boot/dts/intel/Makefile
>>>> +++ b/arch/arm64/boot/dts/intel/Makefile
>>>> @@ -2,6 +2,7 @@
>>>>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>>>>  				socfpga_agilex_socdk.dtb \
>>>>  				socfpga_agilex_socdk_nand.dtb \
>>>> +				socfpga_agilex7f_socdk_pcie_root_port.dtb \
>>>>  				socfpga_agilex5_socdk.dtb \
>>>>  				socfpga_n5x_socdk.dtb
>>>>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
>>>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>>>> new file mode 100644
>>>> index 000000000000..76a989ba6a44
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>>>> @@ -0,0 +1,16 @@
>>>> +// SPDX-License-Identifier:     GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2024, Intel Corporation
>>>> + */
>>>> +
>>>> +#include "socfpga_agilex_socdk.dts"
>
>
> Nope, you cannot include a board in other board.

Ok, I understand.

>
>>>> +#include "socfpga_agilex_pcie_root_port.dtsi"
>>>> +
>>>
>>> Missing board compatible, missing bindings.
>>
>> The model and compatible bindings are inherited from socfpga_agilex_socdk.dts.
>
> Then this is the same board, so entire DTS should be removed and instead
> merged into parent DTS. There is no such thing as "inherit" of an
> compatible.

It is the same physical board, but the image programmed into the FPGA is 
different in so far as the PCIe IP is connected and enabled. This 
different FPGA image allows for a PCIe End Point to be plugged in. Is this 
difference enough for it be considered and different board?

>
>>
>>>
>>>> +&pcie_0_pcie_aglx {
>>>> +	status = "okay";
>>>> +	compatible = "altr,pcie-root-port-3.0-p-tile";
>>>
>>> Why do you define the compatible here, not in DTSI? This is highly
>>> unusual and confusing. Also, compatible is never the last property, but
>>> opposite.
>>
>> The current DTSI supports all three variants of the PCI hardware in the
>> Agilex family, referred to as P-Tile, F-Tile, and R-Tile. This particular
>> board has an Agilex chip with the P-Tile variant of the PCI hardware.
>
> And devices are not compatible? If they have common part in the DTSI, I
> would expect that. This is really unusual stuff and needs proper
> justifications, not just "DTSI support something". DTSI represents SoC
> and SoC either has p-tile or something else. It does not have a "wildcard".

Unfortunately, the P-Tile, F-Tile, and R-Tile are not compatible. A small 
number of registers have different offsets.

>
> It's the same with that earlier simple-bus. You wrote DTS which does not
> represent real hardware.
>
>>
>> I will move the compatible property to be the first property.
>>
>>>
>>> Plus:
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings. After that,
>>> run also `scripts/checkpatch.pl --strict` and (probably) fix more
>>> warnings. Some warnings can be ignored, especially from --strict run,
>>> but the code here looks like it needs a fix. Feel free to get in touch
>>> if the warning is not clear.
>>
>> The only warning I see from scripts/checkpatch.pl --strict is "added,
>> moved or deleted file(s), does MAINTAINERS need updating?". The directory,
>> arch/arm64/boot/dts/intel/, is already mentioned in the MAINTAINERS file.
>> Do I need to do anything to resolve this?
>
> My mistake, I missed the first patch and assumed checkpatch will
> complain about this compatible.
>
>>
>>>
>>> It does not look like you tested the DTS against bindings. Please run
>>> `make dtbs_check W=1` (see
>>> Documentation/devicetree/bindings/writing-schema.rst or
>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>> for instructions).
>>> Maybe you need to update your dtschema and yamllint. Don't rely on
>>> distro packages for dtschema and be sure you are using the latest
>>> released dtschema.
>>
>> The dtschema check failures are inherited from socfpga_agilex_socdk.dts.
>
> New errors are not inherited from DTS/DTSI. Anyway, you cannot include
> other DTS. DTS is final board. You do not include C files in C code in
> Linux kernel.
>
>> Rob Herring's bot indicates that "Ultimately, it is up to the platform
>> maintainer whether these warnings are acceptable or not." Is this
>> applicable here? Is the correct way to fix the existing dtschema check
>> warnings is with their own patches, rather than adding to this PCIe Root
>> Port patchset?
>
> Any new warning is on you and for example with that simple-bus, you
> brought new ones.

I now see the new warnings that I introduced, and they will be fixed.

>
> Best regards,
> Krzysztof
>

Thanks for the feedback,
Matthew Gerlach

