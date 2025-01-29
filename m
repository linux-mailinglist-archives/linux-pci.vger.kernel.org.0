Return-Path: <linux-pci+bounces-20553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DCEA22466
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 20:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA3A7A252C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917FD1E230E;
	Wed, 29 Jan 2025 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQvfKY6X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493C194089;
	Wed, 29 Jan 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738177828; cv=none; b=nxGTpMvevMdk8qD/ORANEi9aMgK+kVSxBNyx/XNPwWgcEWEkr2BOOhpk3z0iYy/S0da6jAz5LK0JQEU6/m7VprlGW62p3LFFfarrrEO5DKfgri/OK29qna1E6cWVw2rhPGpGY3Nd3PyiU9G2Lpm51TkXHVpNWpvx7tnvqImkN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738177828; c=relaxed/simple;
	bh=pDJT/TKUWRAmXBXIuDw4BDddlfkMuvJPlo9R+NELlp8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gYFhr1Ns6askdyeWNgZ2vOI0Mc/HcppvQx1NyJ9dAVXLad/qcnbv05n8Dp2LPAT8UlDRhh/jtQkxcDvU+mhtpLuL+/pYi+VHtTzi7ryX+HTo+4bigyGFPf0tXTGQBFHUzvT1gVkItkUFnq3EQr3VL1C1uRr16KIDyjPK6uADrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQvfKY6X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738177827; x=1769713827;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pDJT/TKUWRAmXBXIuDw4BDddlfkMuvJPlo9R+NELlp8=;
  b=AQvfKY6XkNRDMXMCPPOBDDWtTCm3S73tbHMyD/msKvFRoBW8nqrqJNQv
   i7qbJKzZPc7VQEdwYVb9suDoDqcba87i8robIh6s88Hu3UJkyNi5VMUYr
   NonWb/OQxdNnAEWFrK8vmzr1LAiIUbvQa+UkDC2zAlmGd0/RCcA/QlJSB
   hZ4OcRSeKgXNLOK3rNEjueiQlIQOC4rulYVzY6eDR5yzaSb331WcebVt9
   jWPUnIZTm7JKJR7jDfO0V8PAPyumpUhnNzFE0siu4TgLnPkv/H03670Px
   OcHgOoFW7VvuqWQybLexvkHy1AnIDs5YFlChCcFCqV4oxUxeoiCpP1Nyd
   w==;
X-CSE-ConnectionGUID: SjqnJKqkTWmgmpops9q4Gw==
X-CSE-MsgGUID: KuItY+agTmC20DWNAgsRKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37908327"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="37908327"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 11:10:26 -0800
X-CSE-ConnectionGUID: xdEwhwgaTL6S825S8aaRzQ==
X-CSE-MsgGUID: cZP5KuC5SHSX+jUyWw9C1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109700817"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 11:10:25 -0800
Date: Wed, 29 Jan 2025 11:10:25 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v5 2/5] arm64: dts: agilex: add soc0 label
In-Reply-To: <c3bb46ce-d79c-4d57-93ba-90bdeb98658f@kernel.org>
Message-ID: <622cfc1-28ea-8455-1372-4d4f76c7b613@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-3-matthew.gerlach@linux.intel.com> <c3bb46ce-d79c-4d57-93ba-90bdeb98658f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 29 Jan 2025, Krzysztof Kozlowski wrote:

> On 27/01/2025 18:35, Matthew Gerlach wrote:
>> Add a label to the soc@0 device tree node.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v3:
>>  - Remove accepted patches from patch set.
>> ---
>>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>> index 1235ba5a9865..144fe74e929e 100644
>> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>> @@ -152,7 +152,7 @@ usbphy0: usbphy {
>>  		compatible = "usb-nop-xceiv";
>>  	};
>>
>> -	soc@0 {
>> +	soc0: soc@0 {
> This shouldn't be a separate commit, really. It serves no purpose to
> just add the label. Just like you do not add just a define in a driver
> without its user. Label like this itself is pointless. It's useful for
> something, so this should be squashed.

I will squash this label change with the user of the lable.

Thanks for the review,
Matthew Gerlach

>
> Best regards,
> Krzysztof
>

