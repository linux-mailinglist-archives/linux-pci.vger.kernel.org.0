Return-Path: <linux-pci+bounces-20630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A8A24B83
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D6C162F62
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FEE7E105;
	Sat,  1 Feb 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UR/9SWNi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3AA2BAF4;
	Sat,  1 Feb 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738437174; cv=none; b=OgX+D2z01P+RZjXWGCnLy9qi0ujjOk6aP6Rw71bhL3kSgLRdVKiStyeo5tyerD7xC/UlHj6JlbXgeU29v/iaTUtYoHKNV7i44W3CaMmFZyWm2+PwzqpIh3VbGGZRuUoohb774dMg3dTTDeK2ahXS81o+M849+qyFeTuu8Y8BoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738437174; c=relaxed/simple;
	bh=0QBqcNKzY+SzopvrW4jWa8UfPfe7MKUSyO4YO4sZ7WA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T6NqvY0i59QM/JIrhyymWg+pYWgUi2xppCE61mq/SpNe/Tahh/tCo7sPNBS9YWzl/ctQeO0Db+ROioa6qrL5axONEnXgJTqdZCEcYjFAkIUiPvcDhWmOFZ2qw65pemBQzgEQQZTshy02+/Vzfs9seT1Nldo2dDCN9NSCw20TY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UR/9SWNi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738437173; x=1769973173;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0QBqcNKzY+SzopvrW4jWa8UfPfe7MKUSyO4YO4sZ7WA=;
  b=UR/9SWNilDTDmzl4pIW6TyJoARnLFHbiCOe/MuPzSWYdu8jlvVENBixf
   AFup+AWLFVddUsjCQFyB+DeyEydrNgl9LrCQDCP4KtEWkp3IUOTJsLUIR
   371Efuvtejyibt6LS/7OOjcDZ16DgamKuixjZX5Vq/mf1q25eOaH7Miy6
   jsHn3AV/smb1d9hHCxNDChess/hyHmBFaW0LR2ffNSVoQNVynZ58QMceV
   UtVCSuzqZLN5x46CsQ74Kcgk7fwdezvntZjqzO5iecjhBDrTOWYo2+QBF
   a2zEA4HNluEYCE+kXO9DnKdRrTNYQuq+4ISc1RHnTHIQWt65o1tSi0GqK
   A==;
X-CSE-ConnectionGUID: OFEzObQZS+Gl/ZRjtFHQEg==
X-CSE-MsgGUID: AkquYbtOQbWpf8MU0rbNMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11333"; a="61451874"
X-IronPort-AV: E=Sophos;i="6.13,252,1732608000"; 
   d="scan'208";a="61451874"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 11:12:52 -0800
X-CSE-ConnectionGUID: zxXLNLOvQP+skVgiWe8S3g==
X-CSE-MsgGUID: M9OVu734TNeiEA/md8FO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147115919"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 11:12:50 -0800
Date: Sat, 1 Feb 2025 11:12:51 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
In-Reply-To: <40a3dced-defe-412d-b5b2-efcc9619d172@kernel.org>
Message-ID: <7c802294-97f6-3e9-4028-686484a525c5@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-4-matthew.gerlach@linux.intel.com> <ea614dc5-ad24-4795-b9ba-fa682eda428f@kernel.org> <22cb714e-db76-b07-8572-2f70f6848369@linux.intel.com>
 <40a3dced-defe-412d-b5b2-efcc9619d172@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Thu, 30 Jan 2025, Krzysztof Kozlowski wrote:

> On 29/01/2025 20:42, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Wed, 29 Jan 2025, Krzysztof Kozlowski wrote:
>>
>>> On 27/01/2025 18:35, Matthew Gerlach wrote:
>>>> Add the base device tree for support of the PCIe Root Port
>>>> for the Agilex family of chips.
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> ---
>>>> v3:
>>>>  - Remove accepted patches from patch set.
>>>>
>>>> v2:
>>>>  - Rename node to fix schema check error.
>>>> ---
>>>>  .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
>>>>  1 file changed, 55 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
>>>> new file mode 100644
>>>> index 000000000000..50f131f5791b
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
>>>> @@ -0,0 +1,55 @@
>>>> +// SPDX-License-Identifier:     GPL-2.0
>>>
>>> Odd spaces in SPDX tag.
>>
>> Yes, there should only be one space.
>>
>>>
>>>> +/*
>>>> + * Copyright (C) 2024, Intel Corporation
>>>> + */
>>>> +&soc0 {
>>>> +	aglx_hps_bridges: fpga-bus@80000000 {
>>>> +		compatible = "simple-bus";
>>>> +		reg = <0x80000000 0x20200000>,
>>>> +		      <0xf9000000 0x00100000>;
>>>> +		reg-names = "axi_h2f", "axi_h2f_lw";
>>>
>>> Where is this binding defined?
>>
>> The bindings for these reg-names are not currently defined anywhere, but
>
> Then you cannot use them.
>
>> they are also referenced in the following:
>>      Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>>      arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>> I am not exactly sure where the right place is to define them, maybe
>> Documentation/devicetree/bindings/arm/intel,socfpga.yaml. On the other
>> hand, no code references these names; so it might make sense to just
>> remove them.
>
> In general: nowhere, because simple bus does not have such properties.
> It's not about reg-names only - you cannot have reg. You just did not
> define here simple-bus.

I understand. I will remove reg and reg-names.

>
> Best regards,
> Krzysztof
>

Thanks for the review,
Matthew Gerlach

