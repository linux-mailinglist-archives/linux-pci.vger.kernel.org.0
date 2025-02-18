Return-Path: <linux-pci+bounces-21774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D17A3AC04
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EC23B132E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A6F1CF5E2;
	Tue, 18 Feb 2025 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJzIFiv7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A82862B7;
	Tue, 18 Feb 2025 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919090; cv=none; b=KqoutcO4CS3xt5lq9ppSPpba1PwxRnYIm2G/NtIbrIYTzi70nhPA6j5blfgGDFMBstS1iEcztJfEi7ikjOE2tOpbyNiYrV7Jyc0Ltc1nDOzWD5dr3cp/MOrM7xyEjIDWI38sSNTn45EFmk63OM6Zcy3QMQ+gAXPZrUPWE+oSM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919090; c=relaxed/simple;
	bh=41Ju47sY0lMfM/I4sXVYmijlHz2g9fuRqHfzZwSEb2c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LMHz0P5HM5IIufXEPGLg7e3atsIoG3VAK9Fz0gBOaNFoRePoPJEmBzfWAu4hpFhlK924saJWM1GAbI2YZwg59FsL7jxBoJedb426pPM8wZhNKcSc/+hlIq/Q15XYiJK1EKWgoYppMjtwA9BUoGZpmghUXVS1n2E2P/sFxBXDPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJzIFiv7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739919088; x=1771455088;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=41Ju47sY0lMfM/I4sXVYmijlHz2g9fuRqHfzZwSEb2c=;
  b=IJzIFiv7JQEHBFbnOA+aNIrs77a8XzirojFdkZKS7dT3Xnj0rmeQM4uZ
   6vQ0osmmVjfxTneEnvw/Dl4gXdrZ6xPI4MxGQU6vwNUUrh2ETG8n4N3iX
   1OeqOfz2GJlXR46tGtmNjd1pToeiG3oYDzKvKR7vM9e7agk2g9yvdUYVg
   zhCy9Bp2akFnehAWuuS/aZ3LqTZwTHXPvbFknqXAyL916jg3rUkwvhfsh
   ZGAwWeSmjlAQBbV0UVYM+585ZdlJNHe9Ek6gNYcg76hVYUT6fDXzHmA/k
   v1UDdOz2+nmlUzeW7KsvsxeZnvhSKmiwl5WHNCb/41JKJYm69ajRPrtdP
   w==;
X-CSE-ConnectionGUID: Q4MrmnkQSbKNlOLLheLdCw==
X-CSE-MsgGUID: cknWGdK5R1ulu9jYirWzUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44556748"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44556748"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 14:51:28 -0800
X-CSE-ConnectionGUID: SGqeKsewS3S1PEGd7PS0eg==
X-CSE-MsgGUID: qBLaGenvS024Odg4vAPM9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119642688"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 14:51:26 -0800
Date: Tue, 18 Feb 2025 14:51:27 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v7 2/7] dt-bindings: intel: document Agilex PCIe Root
 Port
In-Reply-To: <3894efe9-fb8a-4a6f-bc50-ed54b6f7614d@kernel.org>
Message-ID: <21475024-ba4e-6842-d760-3efe4cab9819@linux.intel.com>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com> <20250215155359.321513-3-matthew.gerlach@linux.intel.com> <20250216-ubiquitous-agile-spoonbill-cf12ab@krzk-bin> <dcd28035-6ba8-5d67-daa3-26812c4fc99d@linux.intel.com>
 <3894efe9-fb8a-4a6f-bc50-ed54b6f7614d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Tue, 18 Feb 2025, Krzysztof Kozlowski wrote:

> On 17/02/2025 16:47, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Sun, 16 Feb 2025, Krzysztof Kozlowski wrote:
>>
>>> On Sat, Feb 15, 2025 at 09:53:54AM -0600, Matthew Gerlach wrote:
>>>> The Agilex7f devkit can support PCIe End Points with the appropriate
>>>> daughter card.
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> ---
>>>> v7:
>>>>  - New patch to series.
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>>> index 2ee0c740eb56..0da5810c9510 100644
>>>> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>>> @@ -20,6 +20,7 @@ properties:
>>>>                - intel,n5x-socdk
>>>>                - intel,socfpga-agilex-n6000
>>>>                - intel,socfpga-agilex-socdk
>>>> +              - intel,socfpga-agilex7f-socdk-pcie-root-port
>>>
>>> Compatible should represent the board, so what is here exactly the
>>> board? 7f? Agilex7f? socdk? Or is it standard agilex-socdk but with some
>>> things attached?
>>
>> The board is the Agilex 7 FPGA F-Series Transceiver-Soc Development Kit:
>> https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agf014.html
>
> Isn't Agilex7 a SoC? I don't see it in the list of compatibles.
There are actually 3 different variants of the Agilex7 SoC.
>
>>
>> There is not a single, standard agilex-socdk board. There are currently
>> three variants. In addition to the F-Series socdk, there are I-Series and
>> M-Series devkits:
>> https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agi027.html
>> https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/agm039.html
>
> Pages above show distinctive names for the boards, so I am confused why
> they are not used.

Yes, the distinctive names of the boards should be used:
               - intel,socfpga-agilex7f-socdk
               - intel,socfpga-agilex7i-socdk
               - intel,socfpga-agilex7m-socdk
>
>
>
> Best regards,
> Krzysztof
>

Thanks for the feedback,
Matthew Gerlach

