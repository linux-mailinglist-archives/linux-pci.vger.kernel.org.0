Return-Path: <linux-pci+bounces-31310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F3AF6337
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A2917FA69
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294592DE6FC;
	Wed,  2 Jul 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSWjnN8h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A22DE6EC;
	Wed,  2 Jul 2025 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487659; cv=none; b=l9lysCYJoeeInY0zhVU2tbPN4hCzZfg2lozmDPVs74pv7zPkTSPwpcegguGUzAjV4r92rP+u+TRIFTvVUnjaVlqS9wDZD6SWyRDSuecjhgRenvsXidQwHBjPCoi+r8wFqq05VnA0nEqOBJMflSzK5uAHKu7Ap+IXiXs1CRDw3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487659; c=relaxed/simple;
	bh=p8+ho/iuGtz7wYytGhE0ZMgKY2Ai4EwQDlMxghb5mJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbGctu0DpxLYgD16fPIrSu4oxQJsHb5pSGK6yOXzQmtbiBlLs0HO9ToNSqxt6541GJuagVG4a+3p1tZyVAbnXVcNhr9d7cjIbzEm7Dx0amuFvgu36tok5rKXnRzavuFMiII92EMpFLvzf9QSvT5CVWmlsFAfsAgJdUEsYrLIJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSWjnN8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8267C4CEEE;
	Wed,  2 Jul 2025 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751487658;
	bh=p8+ho/iuGtz7wYytGhE0ZMgKY2Ai4EwQDlMxghb5mJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VSWjnN8hFnQgSxHvrY4Kl9FDdgNVfBrYF2vTmQYgFP27/GifPlh40IuTsuFRxOFEL
	 O0OiBwC6Y12aeUWmtRTR8qgAr4INzSNziJQkfHMK4CMGzIDWOLwcqESDmORW2GmgNN
	 +XQt8l2R0xr4czrWKu8ZO7+y1WZN5BjhLDRCHk6OcDl7PCYwNc16QFKzGmsB43rIbf
	 uR+PwE6RmhWuF55Bl90uZZX1UiUpithVQqMzMOu6khkS8RPNdzELYVukTP6Z2gKx8D
	 syaC/xN3psfmGnqsjtn0HceZOYaPaXeJaAQ1sJtbMWjVsCkOw2UfVh4Lh9pRW1S/uj
	 xDpv2cAAcfZZw==
Message-ID: <225ea9f2-dce7-498c-a2a4-5b40471b8e2a@kernel.org>
Date: Wed, 2 Jul 2025 22:20:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] dt-bindings: pci: cadence: Extend compatible for
 new RP configuration
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 Hans Zhang <hans.zhang@cixtech.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "fugang.duan@cixtech.com" <fugang.duan@cixtech.com>,
 "guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>,
 "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
 "cix-kernel-upstream@cixtech.com" <cix-kernel-upstream@cixtech.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-2-hans.zhang@cixtech.com>
 <20250630-heretic-space-bullfrog-d6b212@krzk-bin>
 <afeda0c7-1959-4501-b85b-5685698dc432@cixtech.com>
 <CH2PPF4D26F8E1CC95F84FFBB099955A065A246A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <31415739-88cd-4350-9fd4-04b99b29be89@kernel.org>
 <CH2PPF4D26F8E1C590A00940496AAC9ED75A241A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CH2PPF4D26F8E1C590A00940496AAC9ED75A241A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2025 13:56, Manikandan Karunakaran Pillai wrote:
> 
>>>> On 2025/6/30 15:30, Krzysztof Kozlowski wrote:
>>>>> EXTERNAL EMAIL
>>>>>
>>>>> On Mon, Jun 30, 2025 at 12:15:48PM +0800, hans.zhang@cixtech.com
>> wrote:
>>>>>> From: Manikandan K Pillai <mpillai@cadence.com>
>>>>>>
>>>>>> Document the compatible property for HPA (High Performance
>>>> Architecture)
>>>>>> PCIe controller RP configuration.
>>>>>
>>>>> I don't see Conor's comment addressed:
>>>>>
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-
>>>> devicetree/20250424-elm-magma-
>>>> b791798477ab@spud/__;!!EHscmS1ygiU1lA!Bo-
>>>>
>> ayMVqCWXSbSgFpsBZzgk1ADft8pqRQbuOeAhIuAjz0zI015s4dmzxgaWKycqKMn
>>>> 1cejS8kKZvjF5xDAse$
>>>>>
>>>>> You cannot just send someone's work and bypassing the review feedback.
>>>
>>> I thought the comment was implicitly addressed when the device drivers
>> were separated out based on other review comments in this patch.
>>> To make it more clear, in the next patch I will add the following description
>> for the dt-binding patch
>>>
>>> "The High performance architecture is different from legacy architecture
>> controller in design of register banks,
>>> register definitions, hardware sequences of initialization and is considered as
>> a different device due to the
>>> large number of changes required in the device driver and hence adding a
>> new compatible."
>> That's still vague. Anyway this does not address other concern that the
>> generic compatible is discouraged and we expect specific compatibles. We
>> already said that and what? You send the same patch.
>>
>> So no, don't send the same patch.
> 
> 
> Hi Kryzsztof,
> 
> Are you suggesting to create new file for both RC and EP for HPA host like:
> cdns,cdns-pcie-hpa-host.yaml
> cdns,cdns-pcie-hpa-ep.yaml
> And during the commit log, explain why you need to create a new file for HPA, and not use the legacy one.

No, there was no such suggestions in any previous or current
discussions. IIRC, this was simply rejected previously. I consider this
rejected still, with the same arguments: you should use specific SoC
compatibles. The generic compatible alone is rather legacy approach and
we have been commenting on this sooooo many times.



Best regards,
Krzysztof

