Return-Path: <linux-pci+bounces-2267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F848303F3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B82BB22A24
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1C91C6BA;
	Wed, 17 Jan 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ri0WhxQv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5E14AA8
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488840; cv=none; b=oXpJLulAL3Usv6Zb/ho0hTPUtD6Xh6u9IkOCswHJXuAgQ0Z9G9Kj5O8MsZ8wnOhdPcbe+UDqSn5v4sr3L2VaAfODDDnq/30pAngRyBF+SZ9wYIrdzTN6KR22r9c1bmVc2ZsmlwcNWLXGwI5vcuGsq12dOwJsOzrmePl2cCBbmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488840; c=relaxed/simple;
	bh=KjhNZ8+fWl254kviZY6+sEbXk9RKty3yOVamx6dSXu4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=eDPEqcb6q5zg6AQWhvoDbJ0SomJTeRjce/yDr1jaSSzEbbn5u9kRoSRxSgfH2IQm9Cj6IgVdvSE/wm+PSl5UtE/mfwGRLISxJDuc8+iFuPigX5yTRJp/2wL0NopwLzRvn+HXITTydtl7CcolXMnPwdkQNKHBWBWmeSSyo9tLNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ri0WhxQv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55969c01168so4297752a12.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 02:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705488835; x=1706093635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qo8eGWPWRkX/4JThm1Lo2hklyFCe76/3hkhcrBEPdhg=;
        b=Ri0WhxQv6o6jUyntrCe/v0zVNLiSPGfBdptIoTqdIAMPlLyHYyvES//55hnNfv+Z9H
         P9sTPQL48Zc38M1n2tRcMF2TpK13y5LAhoRY34EkaAyPXZRyO8M5P70Yrgu4d6E9N/xV
         skB30LduA8gM6lTgZd23jcooPAgXDdNrSTbvc2Uoz5gTke2w5keYkISNWisXeJMWcx3h
         RknJ78MYGuEvrQxr3t/CQGHzcLktwjFpfUCmwdqsmmS6adHP8dQfMOWUlofzY0pJNuxX
         bS4Gjmx+OkgP+fVl4WkzCpMy/u/BJZD9tmFe6E6UnRWwqqNqtZ/nERi4pgVWvugDtRS7
         FV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705488835; x=1706093635;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo8eGWPWRkX/4JThm1Lo2hklyFCe76/3hkhcrBEPdhg=;
        b=TGk3Ozog3ShpuGTCs0W+CS75QlodxaoWlPxhlbrXguD0QwT6sU7t7V9z6QcPN42455
         JQjZOWfyIDLjwN62dkyi/AqMrMh1uX2S5Wf/LjX932toBBzrNJbrmLEru9ancioBDpWL
         OKy/+f8kGodcHspW4I4kOgfilwz43FE/VJTGDXlMTlX9h6kH8TIz4quo9voK+RhHe72Q
         WR3Unfz7XNQKBc6MZcFXfbnvDDN4EU8YfHr+okiOe+rusG0L84+wK/hUCEa3odInfZk0
         ybrE+Yf8gHUpa7fRLUgmXRq/EGiPXon/UdgRhiFmGowUBrFp6P0PF8WI8QvWeRdmVL8V
         stsA==
X-Gm-Message-State: AOJu0Yx2hGUJ943YWaCyh5/oemiM5a7JgurcYpEkFkZy0QwvBwCayKFF
	soKHXzskoGZJhSNXqmO8zHwWjVJQgWTMlA==
X-Google-Smtp-Source: AGHT+IEsjGUMOVB6JCi8pfFJ0atoqzMLYvj0dJD4f+ZuDyiGP7oOQugPXRhs1ZPq6vyYUEWxMOly0g==
X-Received: by 2002:a17:906:2f8b:b0:a28:b34d:8694 with SMTP id w11-20020a1709062f8b00b00a28b34d8694mr554688eji.62.1705488835207;
        Wed, 17 Jan 2024 02:53:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090619ca00b00a2ed233c313sm591699ejd.168.2024.01.17.02.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 02:53:54 -0800 (PST)
Message-ID: <bd3e809f-5d97-428f-9387-a2475c4f0d7d@linaro.org>
Date: Wed, 17 Jan 2024 11:53:53 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: PCI: ti,j721e-pci-*: Fix check for
 num-lanes
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, afd@ti.com, srk@ti.com
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-2-s-vadapalli@ti.com>
 <28fd561a-7c13-48dc-9995-230dc758f257@linaro.org>
 <a25ea57b-4529-4a4c-9e0b-ccd85b0457d6@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a25ea57b-4529-4a4c-9e0b-ccd85b0457d6@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 11:47, Siddharth Vadapalli wrote:
> Hello Krzysztof,
> 
> On 17/01/24 16:04, Krzysztof Kozlowski wrote:
>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>> The existing implementation for validating the "num-lanes" property
>>> based on the compatible(s) doesn't enforce it. Fix it by updating the
>>> checks to handle both single-compatible and multi-compatible cases.
>>>
>>> Fixes: b3ba0f6e82cb ("dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes")
>>> Fixes: adc14d44d7cb ("dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings")
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 26 ++++++++++++++-----
>>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 26 ++++++++++++++-----
>>>  2 files changed, 38 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>> index 97f2579ea908..278e0892f8ac 100644
>>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>> @@ -68,8 +68,9 @@ allOf:
>>>    - if:
>>>        properties:
>>>          compatible:
>>
>> Missing contains:, instead of your change.
> 
> I did try the "contains" approach before determining that the implementation in
> this patch is more suitable. Please consider the following:
> 
> For AM64 SoC the primary compatible is "ti,am64-pcie-ep" and fallback compatible
> is "ti,j721e-pcie-ep". For J7200 SoC the primary compatible is
> "ti,j7200-pcie-ep" while the fallback compatible is again "ti,j721e-pcie-ep".
> 
> Therefore, the device-tree nodes for AM64 and J7200 look like:
> 
> AM64:
>     compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
>     ...
>     num-lanes = 1;
> 
> J7200:
>     compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
>     ...
>     num-lanes = 4;
> 
> This implies that when the check for "num-lanes" is performed on the device-tree
> node for PCIe in J7200, the fallback compatible of "ti,j721e-pcie-ep" within the
> AM64's "compatible: contains:" check will match the schema and it will check the
> existing "num-lanes" being described as "const: 1" against the value in J7200's
> PCIe node resulting in a warning. 

What warning? What did you put to contains?

> Therefore, using "contains" will result in
> errors if the check has to be performed for device-tree nodes with fallback
> compatibles. The "items" based approach I have used in this patch ensures that
> the schema matches *only* when both the primary and fallback compatible are
> present in the device-tree node.

Long message, but I don't understand it. Why this binding is different
than all others which rely on contains?

>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          items:
>>> +            - const: ti,j784s4-pcie-ep
>>
>> Why? Previous code was correct.
> 
> Though I used "patience diff", for some reason the addition of
> "ti,j721e-pcie-ep" in the check has been treated as the removal of
> "ti,j784s4-pcie-ep" first followed by adding the same later for generating the
> diff in this patch. The diff above is equivalent to the addition of:

No, why do you change existing code? It is correct.


Best regards,
Krzysztof


