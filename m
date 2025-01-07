Return-Path: <linux-pci+bounces-19385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB7A038EC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 08:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A61885D35
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1C41DEFD8;
	Tue,  7 Jan 2025 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWqIeLmq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C3154BE2;
	Tue,  7 Jan 2025 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235578; cv=none; b=QnOqCZK9nDSx3wVGp6nMhgePmRIHpE9idBfIu9xtWAps2lXAuk1qKAgcgJ5DNstBhf/Xs53B3aPFRNLvlciox1nynRroHkexvfQV+j7FVVdZ4+6f5bsQmODqv4rUCdwha5jmpN26JfxPuw/DKR91jK1lOO0fD3f8p6ttfVNSQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235578; c=relaxed/simple;
	bh=pdOg6pQVabUnWRXDjf2S2sinPTFgzNzHGzdPbLsARCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+v7+nNAgNIGxiwv2vKJGYP6DYug6CoNZDvOPMelVwguNwKKoudi9dTof3A/JNvpVm0OX5UUhoB9gP9ji664+BParN3dRAS7UHtUGBVAbTWB1wxyMFH02/vVCi0Q2nlPVT5PlwDFBrukSZNMgmWhF/EQnDpQVcghMMKlGK+84pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWqIeLmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B432EC4CED6;
	Tue,  7 Jan 2025 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736235578;
	bh=pdOg6pQVabUnWRXDjf2S2sinPTFgzNzHGzdPbLsARCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tWqIeLmq/schcCGXmWU4ONMqdYjUejHaF8jEEoNsVIWw7YBVLp3+UO/A+1pDd+gmh
	 fRiba10lS31nsNxlvoQ87Svxa2CzLLgysiU1geiTvo7XjrknUO5S06LLQ02jqx/wB1
	 bZCpY78h2ksQLV4WivqoHWtKSWOdKBkKJkfEqbJfK5pjCE+Ohn0jBHvPtmXpD7djDn
	 QyEg8IXqKv1ZPop7r7f1aYGV/hfZHMnU+46oLgc+fLluY+2daPyregTSVC3JCEtO9b
	 9FBNyIZ3VSxDsyhG9Ij/PNNQku1qSskshx7X9UgPploM8wES/jOR49Zi4XsgA1/3DT
	 N/b+cQh8spXOw==
Message-ID: <336b4eff-9d77-47ac-be26-2f73e30a5766@kernel.org>
Date: Tue, 7 Jan 2025 08:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] dt-bindings: PCI: dw: rockchip: Add rk3576 support
To: Kever Yang <kever.yang@rock-chips.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, heiko@sntech.de,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Simon Xue <xxm@rock-chips.com>,
 linux-rockchip@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20241223110637.3697974-1-kever.yang@rock-chips.com>
 <20241223110637.3697974-3-kever.yang@rock-chips.com>
 <173495701750.480868.16123444058526675248.robh@kernel.org>
 <7d94ec48-5dfb-4daf-b32b-504271afb374@rock-chips.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <7d94ec48-5dfb-4daf-b32b-504271afb374@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2025 08:24, Kever Yang wrote:
> Hi Rob,
> 
> On 2024/12/23 20:30, Rob Herring (Arm) wrote:
>> On Mon, 23 Dec 2024 19:06:32 +0800, Kever Yang wrote:
>>> rk3576 is using dwc controller, with msi interrupt directly to gic instead
>>> of to gic its, so
>>> - no its suport is required and the 'msi-map' is not need anymore,
>>> - a new 'msi' interrupt is needed.
>>>
>>> Signed-off-by: Kever Yang<kever.yang@rock-chips.com>
>>> ---
>>>
>>> Changes in v3:
>>> - Fix dtb check broken on rk3588
>>> - Update commit message
>>>
>>> Changes in v2:
>>> - remove required 'msi-map'
>>> - add interrupt name 'msi'
>>>
>>>   .../devicetree/bindings/pci/rockchip-dw-pcie-common.yaml      | 4 +++-
>>>   Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml   | 4 +---
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>> ./Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml:85:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> Sorry, I'm not so good at the yaml grammar, I will fix it in next version.
> 
> But when I run the make dt_binding_check, I can't find this warning in 
> my side, maybe the tool has version required?


Read the full instruction (it is there on purpose, to avoid trivial
questions):

> 
> 
> Thanks,
> - Kever
>>
>> dtschema/dtc warnings/errors:
>>
>> doc reference errors (make refcheckdocs):
>>
>> Seehttps://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241223110637.3697974-3-kever.yang@rock-chips.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade


Down to here. All above is fine on your side?



Best regards,
Krzysztof

