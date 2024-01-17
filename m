Return-Path: <linux-pci+bounces-2277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55DC83049B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E44C1F28267
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9F1DFC8;
	Wed, 17 Jan 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XO9zSIJB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39721DDF4
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491320; cv=none; b=VVeBhdJtnZRaCzmaaaeVZb05bzBihFvxNXZMLF4nkb7VMHt6IrZdFS6AfCphAJ665y78Qiq7rUS4voTOjyeFEZSU6wQBLARRRlTe4xHdm7NmFUcLR2j08VH0C9+jSHPc9GiTb04/N+AGH6yQJ5XU1yWsp+FvzQFo7eEvLO//mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491320; c=relaxed/simple;
	bh=YvnE0tgu3tnWmlLfR8V0knLnnT3s+OFdNtIP8Nl7BSQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=gowG4+/Yn1w+K3POCkvwbNbjHXXe9g4/dwkxWwQ3IhMG1z+dnFfYLhv5VYQmfm2TzKQN2FCUhB5IXPeO8LJRHVg41Lri8tM6NgXOC+j09EKqYdcD1RGrC1rF9GKsJEeo35jqbGAyJ8KZnbUJig3xFzsM5cPSyQQ6aAOyj8RuaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XO9zSIJB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26f73732c5so1260139966b.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 03:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705491316; x=1706096116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbIBjFiFH5yDh0HhLK3UGcy7VFKvaKpcUGjHaOiByR0=;
        b=XO9zSIJBSDL9Z5pmg9lhvBeB3H4ZJrQDAhP7ih5JSdxW7Ug9EVrF2hyiApb7Z4OBLb
         7DWMRG8pMkdrChLaJytshjBg8M5LkZxz7OfKtg89WwkNcVnWfl9xQbp36IiQ597Y9xVo
         5KdECtWq+hwINziUs8gYSksxIjQ2ttA5tTq+x7ZelEx/ecKpMy3Sb1fPs+wzLgHpK3cV
         6Xd4OVKnH0C3fC1iOIuoNRqasKUVsgmHkEIgC8/4BPcewB1gLHm86oLUdwnKq1gUgQl4
         mR2PXqzEa8p9hp1uQfeaDYfP8R8h5Yk7RPO+haBbK/vfbVII8FynHZiFuhqp5QGJVENL
         TKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705491316; x=1706096116;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbIBjFiFH5yDh0HhLK3UGcy7VFKvaKpcUGjHaOiByR0=;
        b=R3ghr92EVhiz2PcnLYK1nf/YnynWSxg2lTWO+kYWhOH99b2JcgyZbl3VTcWUffoaeA
         LcwiPdUq6WDw3zu3GH8vz0pk7Z3dDprVf9tDXYbNzssfaMdQO4PaKEEbDMpUCdLvX7zj
         IxwkasM4+h3YIVC2M9gobLYglMKeSPLcgBjdnN7MWR+mOwoyHWvu32xIrLH75+foL4in
         YpM2rpWKvrc5CFuqG9mPAwIxcbfnqQjlMZlapk4FoNojw213JBSya2MXYdNa0Q/Ph0BE
         DSp4k+Vec9HFus7qCF6dm2umFjWuXqqsXNPLffchI2DlmlDa0MC1hyS8EJan9yfysZVU
         nj5A==
X-Gm-Message-State: AOJu0Yy94SIZowZO7qLJhMivd5u3JhTyUiiybnN5IlrmkPc2eDyvmquo
	BatH3GaCKk57U0t5BppzU0wGaP0Y+lOZnQ==
X-Google-Smtp-Source: AGHT+IHTB8IRed+Asgm7WfeEi6gWE+AtvGk2R/qB9BE3/IP1M9rF4ZvqyZ0wYVD4mzBQt+8ij37FlQ==
X-Received: by 2002:a17:906:f914:b0:a2e:884a:4124 with SMTP id lc20-20020a170906f91400b00a2e884a4124mr1228699ejb.24.1705491315674;
        Wed, 17 Jan 2024 03:35:15 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090607d700b00a233efe6aa7sm7672931ejc.51.2024.01.17.03.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 03:35:15 -0800 (PST)
Message-ID: <6119a057-0ed9-46f0-9232-3839d7d4b2e6@linaro.org>
Date: Wed, 17 Jan 2024 12:35:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: PCI: ti,j721e-pci-host: Add support for
 J722S SoC
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, afd@ti.com, srk@ti.com
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-4-s-vadapalli@ti.com>
 <c2c7c1fb-af71-4a5d-9e35-13f6066a2ed6@linaro.org>
 <a34eb14b-9944-476a-8b86-e8bb77bcad82@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a34eb14b-9944-476a-8b86-e8bb77bcad82@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 12:24, Siddharth Vadapalli wrote:
> 
> 
> On 17/01/24 16:06, Krzysztof Kozlowski wrote:
>> On 17/01/2024 11:25, Siddharth Vadapalli wrote:
>>> TI's J722S SoC has one instance of a Gen3 Single Lane PCIe controller.
>>> The controller on J722S SoC is similar to the one present on TI's AM64
>>> SoC, with the difference being that the controller on AM64 SoC supports
>>> up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.
>>>
>>> Update the bindings with a new compatible for J722S SoC and enforce checks
>>> for "num-lanes" and "max-link-speed".
>>>
>>> Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/sprujb3
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>> index 005546dc8bd4..b7648f7e73c9 100644
>>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>> @@ -14,6 +14,7 @@ properties:
>>>    compatible:
>>>      oneOf:
>>>        - const: ti,j721e-pcie-host
>>> +      - const: ti,j722s-pcie-host
>>>        - const: ti,j784s4-pcie-host
>>>        - description: PCIe controller in AM64
>>>          items:
>>> @@ -134,6 +135,18 @@ allOf:
>>>            minimum: 1
>>>            maximum: 4
>>>  
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          items:
>>
>> enum
>>
>>> +            - const: ti,j722s-pcie-host
>>> +    then:
>>> +      properties:
>>> +        max-link-speed:
>>> +          const: 3
>>> +        num-lanes:
>>> +          const: 1
>>
>> Similarly to previous patch: What is the point of all this? You have
>> direct mapping compatible-property, so encode these in the drivers.
> 
> Ok. I will drop patches 1 and 2 of this series and only post v2 of this patch
> for adding a new compatible for J722S SoC without any checks for
> "max-link-speed" or "num-lanes" for the new compatible.

Without driver change? So how does it solve my comment. I want to move
all these unnecessary properties to the driver.

Best regards,
Krzysztof


