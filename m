Return-Path: <linux-pci+bounces-5913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D289D240
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 08:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B60B0B211FA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 06:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2F86EB7B;
	Tue,  9 Apr 2024 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSXbEWYr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687266EB72
	for <linux-pci@vger.kernel.org>; Tue,  9 Apr 2024 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643694; cv=none; b=QTuRNu/Sc9ETUGtRiTgcBVrkicbmc51e1n2BMVw8pdS+ij1CQhH8SdHChjPjWkozKF0EyT2cAUUHbzacqEDcI64ywVydELPsnSSEb9osVX7mRx+b0m7MLzuk1nesbJErW62qiz7d1aq3ApvIKXfbs3vHz1Ft4Qyjzsoz4ZtHgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643694; c=relaxed/simple;
	bh=v9h+JP1Ozokz8XPYOl0mt/0NsHPHIP7jqB4A5A1C9zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmZxGZpV8OXxDNeEW/wYBCazTsSWUORsJpfWwocZhbULrbfLAoy4GmCFkIgp40RAtGaTKlF4+pMiTlcFDNISFQpJtmMKlf1JkXVBgtSIGrztX2Xi0LhfNBJy96a6OOAjctMUeHQkkJ0tyEUk1q/B2/G8eNZ+9ag/28g+KAf54O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rSXbEWYr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51b008b3aeso350114766b.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712643691; x=1713248491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lWIkOPg5L5xz5mlCTwXEDmQlLjcIkDaN5r93XlgAMzg=;
        b=rSXbEWYr2OUT+tYefJvPPiHWVkL+6/XAJ6w//81YpPJbev/rpwlh7qeqlsc2297FDC
         SusKtBtV+R/rRWy7078bKvgvn5FRCON1MsQ85u9+MU/tqF4Iom8C+3T51QY0Nxg3UivQ
         HPzzBgiGm0+GN3hI6psM7CvO+UTq7rbRkjfEtbNTyzwUMwNoWUj4VLmxNMoR4FQmp9iA
         8c4ySO3Znnq7pd60/gQO8bDf7+vK1KsVK8whFMWuE4CW8WWvjuaJEsdeGL+W1AYeF78I
         bbI/5FrKWjHl4VROUkyZKbm1QJYGTwkMIAsVxDc9goImcgMzdzOjO11JjCxGHOrRcph/
         FoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643691; x=1713248491;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWIkOPg5L5xz5mlCTwXEDmQlLjcIkDaN5r93XlgAMzg=;
        b=dxHagLDJO7Iw9mQSAQYGZTEp8ykY1pR+ocFI8+7QvMhD8m81xSZbXzOdNjTwoOSUvn
         qm01ePFmzBEFvB1ACXZnDbtcvucEXnPqUFZIIVHz8Q1NYhpAdUbXNxaBYYBN7x1kazIk
         VQSH90EwSk4FLVOdCwlGjqBsbMnw4D4/M9OCUP2qyfj2QG5T6Onx+Mq1T6wPmRluEVMC
         /0tbuz8oxbLf5u4CVvmeT7tLgdDRdydqqWwc1+kMvP4Sqb7gOMFNvYOFIY7TbIbvxP13
         aR0G4GbDuKtrIVixoe4TG6qKaDRSSqQehjS32t4Yk6OogNPSeYOZtAQXG3WBy2ZX32z2
         nLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9gZqF9BmOrlsi+v62VFYujGpoEn2AaGB3roFj7qm3kGtQNR5txFIueH9xPPCU2rFZX1dZsBn+OJsZQO2TP5qKkYup5/bT5sv7
X-Gm-Message-State: AOJu0YyAMvw2KtgW1ITMffrOJIvcszLTGvKocoQyv2LPcPP5dP/ySg/h
	ZxbqZ+DW1wPwhf0eiCjrc8jW38a0IR2oMSmOFGXHwLBLPvSx/3X+1QuRGuUJJYQ0e5dQLVlRI0p
	D
X-Google-Smtp-Source: AGHT+IGpUblUe93xBBOxtCJ75jLMiz7UMH7MBTTDilSV4N7xThGFaUK51PfxCOlL++NMt09sjfHW3g==
X-Received: by 2002:a17:906:528c:b0:a4d:fcc9:905c with SMTP id c12-20020a170906528c00b00a4dfcc9905cmr8096858ejm.20.1712643690564;
        Mon, 08 Apr 2024 23:21:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090634cc00b00a46f95f5849sm5229179ejb.106.2024.04.08.23.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 23:21:29 -0700 (PDT)
Message-ID: <ce17f2dc-decf-4509-969e-e23bdef42eb9@linaro.org>
Date: Tue, 9 Apr 2024 08:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] dt-bindings: pcie: Document QCOM PCIE ECAM
 compatible root complex
To: Mayank Rana <quic_mrana@quicinc.com>, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 andersson@kernel.org, manivannan.sadhasivam@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
 quic_nkela@quicinc.com, quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
 quic_nitegupt@quicinc.com
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <1712257884-23841-2-git-send-email-quic_mrana@quicinc.com>
 <51b02d02-0e20-49df-ad13-e3dbe3c3214f@linaro.org>
 <1d6911e2-d0ec-4cb0-b417-af5001a4f8a3@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1d6911e2-d0ec-4cb0-b417-af5001a4f8a3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 21:09, Mayank Rana wrote:
>>> +  Firmware configures PCIe controller in RC mode with static iATU window mappings
>>> +  of configuration space for entire supported bus range in ECAM compatible mode.
>>> +
>>> +maintainers:
>>> +  - Mayank Rana <quic_mrana@quicinc.com>
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/pci/pci-bus.yaml#
>>> +  - $ref: /schemas/power-domain/power-domain-consumer.yaml
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,pcie-ecam-rc
>>
>> No, this must have SoC specific compatibles.
> This driver is proposed to work with any PCIe controller supported ECAM 
> functionality on Qualcomm platform
> where firmware running on other VM/processor is controlling PCIe PHY and 
> controller for PCIe link up functionality.
> Do you still suggest to have SoC specific compatibles here ?

What does the writing-bindings document say? Why this is different than
all other bindings?

>>> +
>>> +  reg:
>>> +    minItems: 1
>>
>> maxItems instead
>>
>>> +    description: ECAM address space starting from root port till supported bus range
>>> +
>>> +  interrupts:
>>> +    minItems: 1
>>> +    maxItems: 8
>>
>> This is way too unspecific.
> will review and update.
>>> +
>>> +  ranges:
>>> +    minItems: 2
>>> +    maxItems: 3
>>
>> Why variable?
> It depends on how ECAM configured to support 32-bit and 64-bit based 
> prefetch address space.
> So there are different combination of prefetch (32-bit or 64-bit or 
> both) and non-prefetch (32-bit), and IO address space available. hence 
> kept it as variable with based on required use case and address space 
> availability.

Really? So same device has it configured once for 32 once for 64-bit
address space? Randomly?

Best regards,
Krzysztof


