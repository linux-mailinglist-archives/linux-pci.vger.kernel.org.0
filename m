Return-Path: <linux-pci+bounces-13527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD49866DD
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 21:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D931F25397
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB613E043;
	Wed, 25 Sep 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldQm7a9n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DEF1EEE9;
	Wed, 25 Sep 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292512; cv=none; b=EXTsASDN14KAiOCR3HicnzaogdfOhcNZfy/A42iudJ22qCeMwc2D+eU+g6EZNnJ47bUf7pEmdmkUoXH7DLeA477HksPCi124Ov1jiKErbHLwxtif3fqwKE/BZzP+/G//++q8QI9uYPVW6372xIgBbAxkprn0C076IAWTt9kXEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292512; c=relaxed/simple;
	bh=BHY5b/7aCxpIbeg6RwISb63xJhM+TyHwNQ3PeO7u430=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaEjU5lSfpSaGcz9u46NM8or91Brpyom9bH4yQc87w4GFy12S9qxtw42RfTyJ6d/A7LEIurZpxPm9+yYsyXNWMyP1Ag6TinkE+WhzQhZQQOs4sGgw/f/SrRveF8ICnMK+HERlshEWedCy56pyx29pSD61BHDbjeKe3bub+X64aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldQm7a9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF91C4CEC3;
	Wed, 25 Sep 2024 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727292511;
	bh=BHY5b/7aCxpIbeg6RwISb63xJhM+TyHwNQ3PeO7u430=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ldQm7a9nP9Ya10copiq24onxV9Q5DcpKS5L3W6NNsjffFf+0h30C+CnvIfCFOuSpz
	 tgtoyo/dZYX7qsxhvnHlDzMpMvHTQLhefWWwnN8CAOWxn4b4lr8tmz0SPRdyhSJDKN
	 3r2hEe9aggCQC4AQveofbQFRH6+KQHIaJ5bYpJ5TJgoUVxKnPD+6lpUwLKsUY4WvWw
	 l4CIGMt70xsdmnt2QT/thKhl4/0epZfwekVMbj0fc1CxklWSHtBr8triSnsD/dcJ3r
	 BxcdUH5BL/rF70QOSWeKbouszufKDeGlWkkAbSyMX3TqKSbktslBR8CzB1erRLRRFA
	 0TIYiSPg0pdtg==
Message-ID: <acb6f417-d8ad-4b73-9752-d30da34b204a@kernel.org>
Date: Wed, 25 Sep 2024 21:28:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
 kwilczynski@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
 robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
 s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@pengutronix.de, imx@lists.linux.dev
References: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
 <1727245477-15961-2-git-send-email-hongxing.zhu@nxp.com>
 <vtrxj3r4wy6htxyl44rzjyao4zso6z2idexkvxrh3cg4wazcdc@gffmfu22jiyh>
 <ZvQ+YGqqwAUW+FaD@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZvQ+YGqqwAUW+FaD@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2024 18:46, Frank Li wrote:
> On Wed, Sep 25, 2024 at 09:50:06AM +0200, Krzysztof Kozlowski wrote:
>> On Wed, Sep 25, 2024 at 02:24:29PM +0800, Richard Zhu wrote:
>>> Previous reference clock of i.MX95 is on when system boot to kernel. But
>>> boot firmware change the behavor, it is off when boot. So it needs be turn
>>> on when it is used. Also it needs be turn off/on when suspend and resume.
>>
>> That's an old platform... How come that you changed bootloader just now?
>> Like 7 or 8 years after?
> 
> It is new platform, which just publish in this year. Old platform reference
> clock was controlled in PCI module, so needn't export to DT. So we have
> not realized it when start i.MX95 work.

Indeed, I missed that it is i.MX95, not i.MX6q.

> 
>>
>> For the future: you should document all clock inputs, not only ones
>> needed for given bootloader...
> 
> Understand.

Sorry, in case of early upstreaming it's understandable.

> 
>>
>>>
>>> Add one ref clock for i.MX95 PCIe. Increase clocks' maxItems to 5 and keep
>>> the same restriction with other compatible string.
>>
>> <form letter>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC (and consider --no-git-fallback argument). It might
>> happen, that command when run on an older kernel, gives you outdated
>> entries. Therefore please be sure you base your patches on recent Linux
>> kernel.
>>
>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>> people, so fix your workflow. Tools might also fail if you work on some
>> ancient tree (don't, instead use mainline) or work on fork of kernel
>> (don't, instead use mainline). Just use b4 and everything should be
>> fine, although remember about  if you added new
>> patches to the patchset.
>> </form letter>
>>
>> and I was wondering why I cannot find this and previous thread in my
>> inbox... So please stop developing on two year old kernels (and before
>> you say "I do not", well, then fix way how you use tools).
>>
>>
>>>
>>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>>> ---
>>>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  4 +--
>>>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 ++++++++++++++++---
>>>  2 files changed, 23 insertions(+), 6 deletions(-)
>>>
>>
>> You missed to update ep binding.
> 
> So far, EP don't need reference clock. PCIe standard require host provide
> 100MHz reference clock to EP side. But EP side can choose use itself's
> clock or reference clock from PCIe bus. Currently i.MX95 only support clock
> from internal PLL when work as EP mode.

But this patch allowed certain existing variants in EP to have 5 clocks.
You missed to update EP binding...

Best regards,
Krzysztof


