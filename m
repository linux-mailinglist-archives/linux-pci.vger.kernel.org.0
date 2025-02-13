Return-Path: <linux-pci+bounces-21376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827CA34CEE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91D9163C02
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAC26982E;
	Thu, 13 Feb 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFlcFson"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF2245030;
	Thu, 13 Feb 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469803; cv=none; b=VKWVB5ukkQSqM1kmNI/D4u/EWkWCXtXQWKFiVTGmL8/ZDej+o4HuDjMMcboNWHqoR9EjG4vQY/YHGWppj+g4Pj/6IuQpT2dhIUfRrM1N/V8Rh1GsPJ/kSmis6nKLJQC0nAFfWSB9rJ1EOZ7RXconx0n/5b2nNQqSLc0ZXJ7u+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469803; c=relaxed/simple;
	bh=WbXwHDiWR7XWg4WjQ4/T8ldzDcjVVx3R4v88F9Z6gJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1V9iOpXXzXVDXSsRHlWIqCx/AXz6RqY5BozS7LQDpclPY4vutcTmGfDs1uKRKN7abVSpGbBEs9tNK3A4R0A7gEwJ1CicnbEVwWEKf8RdG1AVct1TKmYtbEKvgZM5UPiGDBYKJpRAn5vUTW+vi3uAP3CJ9dm+hPGbk7gnpkwGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFlcFson; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC902C4CED1;
	Thu, 13 Feb 2025 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469802;
	bh=WbXwHDiWR7XWg4WjQ4/T8ldzDcjVVx3R4v88F9Z6gJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JFlcFsonbuTOSnOfR4qSEuNbP6OqQO4MkCgmkJkU3qk/lFWl4DcL9Ny7+hL5pGItP
	 X8euWWBe+4vkvZ28rziKTnwiAN6h635psymMpbkwRtULAQulnND73pl1GQ0SEOLw+C
	 bMyAgJM5CI6DnWYEqTMaRqqnyTOVWJthiT3yj0D3KTJ11oN0uKvQaP1eLSHQXp//sT
	 x90CYDFiKV6X3Nbgav+6OERLLLgqLuZxAL1XgCN6K07OvJ3s1v8T36rfjAL06pX26I
	 STTI/G/uteVexNzLyPLhM66cveAjEv+pRL9cAmHIazhxI4itpUtiWCaqBx8fK/eWWw
	 BHRgRHaw2a2YQ==
Message-ID: <e45c47bb-2c69-42b3-9c2d-7ec789f94cc5@kernel.org>
Date: Thu, 13 Feb 2025 19:03:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] arm64: dts: agilex: Fix fixed-clock schema
 warnings
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, matthew.gerlach@altera.com,
 peter.colberg@altera.com
References: <20250211151725.4133582-1-matthew.gerlach@linux.intel.com>
 <20250211151725.4133582-3-matthew.gerlach@linux.intel.com>
 <8bf87b59-fe80-4bb5-a558-bff35d876e67@kernel.org>
 <d6b453b-5819-d663-7cc1-6ef154c5d965@linux.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <d6b453b-5819-d663-7cc1-6ef154c5d965@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 18:37, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Wed, 12 Feb 2025, Krzysztof Kozlowski wrote:
> 
>> On 11/02/2025 16:17, Matthew Gerlach wrote:
>>> Add required clock-frequency property to fixed-clock nodes
>>> to fix schema check warnings.
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> ---
>>> v6:
>>>  - New patch to series.
>>> ---
>>>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>>> index 1235ba5a9865..42cb24cfa6da 100644
>>> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
>>> @@ -114,21 +114,25 @@ clocks {
>>>  		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
>>>  			#clock-cells = <0>;
>>>  			compatible = "fixed-clock";
>>> +			clock-frequency = <0>;
>>
>> That's not a correct frequency. You silence some error by introducing
>> incorrect properties. That's wrong.
> 
> A clock-frequency of 0 seems valid for a clock that is disabled or not 
> used on a particular board. I chose this approach because it already has 
> widespread usage in the kernel:
> 
>  	grep 'clock-frequency = <0>' arch/arm64/boot/dts/*/*.dtsi | wc -l
>  	198

If the clock is not there, it should be removed or disabled. Otherwise
what is the point of setting here clock frequency=0? To silence some
warning. Why is there warning in the first place?


> 
>>
>> Don't fix the warnings just to silence them, while keeping actual errors
>> still in the code.
> 
> I actually want to fix the existing warnings, but it seems appropriate to 
> only address the existing warnings that are related to this patch set of 
> adding PCIe Root Port support to the Agilex family of chips. This patch 
> set requires touching the file, socfpga_agilex.dtsi; so I fixed the 
> warnings I thought were in this file. I believe the other warnings need to 
> be fixed by converting text binding descriptions to yaml or by touching 
> files unrelated to this patch set.
> 
> Setting the value of the status property to "disabled" also silences the 
> particular fixed-clock, but I didn't see any other usage by a fixed-clock. 
> What do suggest is the best way to handle this warning?

DTSI and DTS represent actual hardware, so common DTSI should not have
clocks which do not exist. Such clocks should be in DTS or some other
common DTSI file, depending on how the hardware is organized.

Instead of fixing the warning, look at the cause - what is wrong in DTSI
in this hardware description.

Best regards,
Krzysztof

