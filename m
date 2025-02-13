Return-Path: <linux-pci+bounces-21367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DCA34C18
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBB168D37
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34BF211A36;
	Thu, 13 Feb 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVjQkhFH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA6204684;
	Thu, 13 Feb 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468256; cv=none; b=oztXc6CxW7Pm+q++AH72r2vUSNAfgmXm3I6RogfUYzT3Tw3TW3jYKRdZDLIhfvujHSOWaGi89d8XFx4gB7c4hip/twZxFodPZZSRLXUDqe5V/1ErGFJ4cVRgClP0bSZNAKh1EAOelZunL7PMeH6wje0C5LSzCiqO2M2pKskgwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468256; c=relaxed/simple;
	bh=Kag1yQsukjTOP+S5Jjyl/xScN3/K1pOC6cQmUcAjDkI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jy3zVQxKZzWO/IK5V2ze+ajO3Hcihn4rJxDhQycPquU6netcX/3TyR6008xOBAcH5UlUvPTJ9ED9YzSACAF+pyfdrVcvv3VTpGDnPgaRLXVAqclj2F4QYq+UPKwaWV6vrTSC2/kubKFFmfqLB37Jbu8HUqnR1eMHr+Wu8xfGv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVjQkhFH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739468255; x=1771004255;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Kag1yQsukjTOP+S5Jjyl/xScN3/K1pOC6cQmUcAjDkI=;
  b=JVjQkhFHOzmKXwr6jbYjevnxj6zsSpgGuNFia3zje2Ik9oALIwWeMQpl
   3tcI5tWcajN/77S1g+tita1Ov6BOQWXj/2kZDFxv9f/xGqAScMjgklyT1
   OhsqCdMd1MC0N3ZZ+Tt+28fEd4x6bsn+CW4YI3FtOe6G8JfLK3UHabHsU
   l3zufgdZSIC9Tl5xLCLt4ilHAgWIuKEOFWQEhbJ0ru+slMW+3IPmXwfWg
   Rs5Casq61833QepjCOdGh41VEWpmVAjQrlQFP5nc4f7l719ESUjKFnrLc
   PkbA02H3Ghiv3z7dRweisSZrZV431F55+8AHZ5vvheYNQc3xuYos93Z1w
   g==;
X-CSE-ConnectionGUID: wp5JQYCWTJebTRL3ivTeow==
X-CSE-MsgGUID: 8g/infmpQpqrA9FXAvWlSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40449831"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40449831"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:37:34 -0800
X-CSE-ConnectionGUID: x4aqHW16SCmMS8G5LPToIQ==
X-CSE-MsgGUID: hKz1t8f0ReqqU7j3y875Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150385334"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:37:34 -0800
Date: Thu, 13 Feb 2025 09:37:33 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v6 2/7] arm64: dts: agilex: Fix fixed-clock schema
 warnings
In-Reply-To: <8bf87b59-fe80-4bb5-a558-bff35d876e67@kernel.org>
Message-ID: <d6b453b-5819-d663-7cc1-6ef154c5d965@linux.intel.com>
References: <20250211151725.4133582-1-matthew.gerlach@linux.intel.com> <20250211151725.4133582-3-matthew.gerlach@linux.intel.com> <8bf87b59-fe80-4bb5-a558-bff35d876e67@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 12 Feb 2025, Krzysztof Kozlowski wrote:

> On 11/02/2025 16:17, Matthew Gerlach wrote:
>> Add required clock-frequency property to fixed-clock nodes
>> to fix schema check warnings.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v6:
>>  - New patch to series.
>> ---
>>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>> index 1235ba5a9865..42cb24cfa6da 100644
>> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>> @@ -114,21 +114,25 @@ clocks {
>>  		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
>>  			#clock-cells = <0>;
>>  			compatible = "fixed-clock";
>> +			clock-frequency = <0>;
>
> That's not a correct frequency. You silence some error by introducing
> incorrect properties. That's wrong.

A clock-frequency of 0 seems valid for a clock that is disabled or not 
used on a particular board. I chose this approach because it already has 
widespread usage in the kernel:

 	grep 'clock-frequency = <0>' arch/arm64/boot/dts/*/*.dtsi | wc -l
 	198

>
> Don't fix the warnings just to silence them, while keeping actual errors
> still in the code.

I actually want to fix the existing warnings, but it seems appropriate to 
only address the existing warnings that are related to this patch set of 
adding PCIe Root Port support to the Agilex family of chips. This patch 
set requires touching the file, socfpga_agilex.dtsi; so I fixed the 
warnings I thought were in this file. I believe the other warnings need to 
be fixed by converting text binding descriptions to yaml or by touching 
files unrelated to this patch set.

Setting the value of the status property to "disabled" also silences the 
particular fixed-clock, but I didn't see any other usage by a fixed-clock. 
What do suggest is the best way to handle this warning?

>
> Best regards,
> Krzysztof
>

Thanks for the feedback,
Matthew Gerlach

