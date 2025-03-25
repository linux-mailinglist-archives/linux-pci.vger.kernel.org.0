Return-Path: <linux-pci+bounces-24613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D058CA6E9E7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 07:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417BA188E234
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EEB21D59A;
	Tue, 25 Mar 2025 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7EJYNqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B851FDE2B;
	Tue, 25 Mar 2025 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885861; cv=none; b=RkENguuryeEVTHsCsESkpWJ+ZKgaLX0gKFJjMal+NoxZ9yvOtgSjr8hiCkW1pUoiciND4ZPkVV2atS04Trf87iXFrz63MeTAEZCdr4y28qyUCFbd5YT36himIvVt3twgBUTP3x6ncUh5RNTDYgm8poWLv4mqdR6AcLXiuaedeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885861; c=relaxed/simple;
	bh=mrWlhzsP7VDMDRI5lyXvbZor6lg91zVdS93Hng4hwgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZS8gu7A6cRsANDZdh0cC0+2pe0Mb1/Y//t0V5hhytytU1b1HeyeY27iISBVIcNzOq3pVrK9KBbbgPJ3/DNxEgohM0ux1RnF/3ki2Y85v75oCeFC5SOEUHr8qzTap96JSZgtQm3L+oCSMPtB38aoCIBMxKrDLNluYHc6UoB6aPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7EJYNqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B104CC4CEE8;
	Tue, 25 Mar 2025 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742885860;
	bh=mrWlhzsP7VDMDRI5lyXvbZor6lg91zVdS93Hng4hwgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L7EJYNqJKfdBFuhoZKL92j0J4Pdqtpzopv4La/f1KF3oauogtQ0ZxPD6liMHvoU24
	 BKj7XLVaFdXaGetaIUzSrhWqOeNZBBMuKhvRp8dDO9gLVas6e4M+u/JWHEiq3SsFHC
	 alqfJkiKJYAWSJjg75tZQ5Om93n6AmaFjir28kG19dTb4MGfx4rbmOe2KfHB2AARTL
	 uqwCL9e/70pH3xjpMBq84o0R7mz7zzEocsEKQsMCKjD9LBQ/8bb1zWTEHIvPDJTnnO
	 76mTPNCUQN80TMVswNUUeDImvldfTDybrRheMJBe2a63M4aT2iGlqN9j1rCw9v5Ffh
	 G2VKv6YFONZ3A==
Message-ID: <53eb9d35-2b7c-4742-af18-e7b0fb1cdcfe@kernel.org>
Date: Tue, 25 Mar 2025 07:57:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: pci: cadence: Add property "hpa" for
 PCIe controllers
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com" <kw@linux.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Milind Parab <mparab@cadence.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250324082335.2566055-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CE4E18E9CC5B8DAF724DCA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <60af2ed4-91a9-434b-b1f6-a87218aba381@kernel.org>
 <DS0PR07MB10492F672DEACE769F97C609BA2A72@DS0PR07MB10492.namprd07.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <DS0PR07MB10492F672DEACE769F97C609BA2A72@DS0PR07MB10492.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2025 04:16, Manikandan Karunakaran Pillai wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Monday, March 24, 2025 9:29 PM
>> To: Manikandan Karunakaran Pillai <mpillai@cadence.com>;
>> lpieralisi@kernel.org; manivannan.sadhasivam@linaro.org;
>> bhelgaas@google.com; kw@linux.com; robh@kernel.org;
>> devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>> Subject: Re: [PATCH 1/6] dt-bindings: pci: cadence: Add property "hpa" for PCIe
>> controllers
>>
>> EXTERNAL MAIL
>>
>>
>> On 24/03/2025 10:08, Manikandan Karunakaran Pillai wrote:
>>> Document the newly added property "hpa" for Cadence PCIe controllers
>>> in Documentation/devicetree/bindings/pci/ for Root Port and Endpoint
>>> configurations
>>
>> Drop the path, pointless.
> Ok
>>
>>>
>>
>> Please run scripts/checkpatch.pl on the patches and fix reported warnings.
>> After that, run also 'scripts/checkpatch.pl --strict' on the patches and
>> (probably) fix more warnings. Some warnings can be ignored, especially from -
>> -strict run, but the code here looks like it needs a fix. Feel free to get in touch if
>> the warning is not clear.
>>
> 
> The scripts/checkpatch.pl has been run  with and without --strict. With the --strict option
> 4 checks are generated on 1 patch(patch 0002 of the series), which can be ignored. There are 
> no code fixes required for these checks. The rest of the 'scripts/checkpatch.pl' 
> is clean.

No, it's not. The patch has obvious style violations.


> 
>> <form letter>
>> Please use scripts/get_maintainers.pl to get a list of necessary people and lists
>> to CC (and consider --no-git-fallback argument, so you will not CC people just
>> because they made one commit years ago). It might happen, that command
>> when run on an older kernel, gives you outdated entries. Therefore please be
>> sure you base your patches on recent Linux kernel.
> 
> Ok
> 
>>
>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of people, so
>> fix your workflow. Tools might also fail if you work on some ancient tree (don't,
>> instead use mainline) or work on fork of kernel (don't, instead use mainline).
>> Just use b4 and everything should be fine, although remember about `b4 prep
>> --auto-to-cc` if you added new patches to the patchset.
>> </form letter>
>>
> I used an earlier list generated. Will take care to generate the list on latest tree.

That's not the correct process. Why would you Cc maintainers from 10
years ago?


Best regards,
Krzysztof

