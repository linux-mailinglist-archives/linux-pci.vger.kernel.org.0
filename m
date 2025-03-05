Return-Path: <linux-pci+bounces-22981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B9AA503D1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A977116D178
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228724EF7D;
	Wed,  5 Mar 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwT0lA9T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFE24A056
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189869; cv=none; b=p4p7zZwc+mUEB88sUGHSdBBMM+w8eF+rAB1uMg2S+beaj39lmbkjcgt/ntVXvGob0ECqFqEC3fL8qK4+jeW5Qfa1bRTn4r0QCMd6yhhGKcb2HA/KdYw0BYQj72JX0DkFoipwM5tvxCCAzqRpkYQDUiDg4XPXXJ+rgvBAdQwnaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189869; c=relaxed/simple;
	bh=qyovL3t3nampgSx7zd2BTKgPZ/HHjV3pms4IM7w1F6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EH9vV4lQfZQplZDcE6GcbiN1/zKSTDkyfLD3LP7SjcfBquHsguqh+F+RclmFR/Ke9YO48+bx+ujk5MihVK3yfW0XghIuw5WIDWxZGDENQkAHhXpmPKJOIP+ALLj6aiq7HIr74DQJTB+dwDgjg2EGsQgxHyOdg+T4t4juLtrQzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwT0lA9T; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390e0f7b272so553706f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 07:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741189864; x=1741794664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vxVKB76bLrKcTnL2OLZ+yJMwzvP1Wr7E1CqkYn0gh48=;
        b=ZwT0lA9TY0Nffx/lmbaRzM+zsDJEmO2ZTVBykwh4F0VdVLNZaijrBoO8DEuJbJC9JZ
         /J5uTVGAbJqTJaom2Sr2jMLbc/usqttzFn+AviiSUWPlxk/ywzJp236ybmvb9766zwEy
         HbBd3v2D481q6nYd1N/pYKSuwz3oSjLXaIy5JtXj+KjtpyaQk9i2aY/HHTtGfgpj3+oB
         zr7mit8BpeInIbFOEokyyGFJWHTyuFI5ratFOJASEhffw372VA4V5MU0aTiMYMPIMpzq
         9ivZxkBZ1g4of5wqF3DomGjorvBhoAlQ0+Y0AL98jxrGNbEWr3DzA6LwNY0nryHAWgNl
         4nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741189864; x=1741794664;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxVKB76bLrKcTnL2OLZ+yJMwzvP1Wr7E1CqkYn0gh48=;
        b=ruoHSVsqMBNB0OwGQnoZ/y+ykZYCpbainmiqiuRFK+ZeSLaF0nsx6wNUGDNXHaJqD/
         kXCu+NC+S2gmv7LBOwyZUN/ZmhWcAzJKd6ILbkaz5dMAE4pJ97cByHvbIHB1AW+wM9jM
         hfXGAslCWdgH18BYK+bkxSMmiELqRuij5fl3YFDXCzyZkuF5m7mLqf9HvFzoPLISnqm5
         qh1u3oMlWqwsupXyQnnx8YTUwYSH2DmYhEoFT7w11Htw1h878saEOqSeCIImkPZd1j1A
         SU3ICmDyNpyM0F+fXGo5OgeeErKzcY1qHRNEtOYiE9comT6u63IIvgFT5cW7Rhk8w6Gr
         zrZw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ny/wmOOSv0jxUPJR0VqDNxtOMT3YbmQJdJZEqmKq9t60UWvr6UFJjLr5+V0LBNXwIu1HOdCYXzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTo56Dw9YPQ1MPtWgJs+vReryKFS1mOqH/6YYZ3jidfDdpHmr
	9LmTWlbLS1dODOfv+hhReqKfronxP/GusxR24fMbG7+pXYVFyyCtOcWfl13WQ/Q=
X-Gm-Gg: ASbGnctx8Uc8uCluLD5jlTBb2fVGMd6vbeuyZ90IkoGmVQbwN59GUIATFrEKEK6qPjJ
	yIr1xL8MAUBgT4n06Wh3nI3cWpYfI1E1bYnZfhKglhsdLh2xyK6Otxo9JEx8/YiOgE5Oq6jnnqG
	3sFXSl3uPnandXK0QA10nNnxDduBGuTBytAu82sQyfNUThCLi65Wg3pp7pXbCv9UjKla0IDsPyi
	INx44Fa//2gf/9EZoD9YN+ErOhn8k5D6lSm06gewYwsIRBOYOXl5igcNIVJ2eAgXoEdDiLEkMBM
	NBVXjLXuiM10UaEMFXbL2ojmVyjC6qB2NlLAnJ2IPQterEy7EFONz+B+J7akk9aA
X-Google-Smtp-Source: AGHT+IHKh69jaNhVoQk0+PTameUSMgr6FbV84ntJ4ya5Ipe9aPo8QOqJhhHdKjEvy7a7Wzt6DhcrRg==
X-Received: by 2002:a05:6000:1a86:b0:390:e005:65c4 with SMTP id ffacd0b85a97d-3911f727385mr1121477f8f.3.1741189864104;
        Wed, 05 Mar 2025 07:51:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844adfsm21524277f8f.62.2025.03.05.07.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:51:03 -0800 (PST)
Message-ID: <a95b4c01-9d8c-49eb-8242-93ae411caec0@linaro.org>
Date: Wed, 5 Mar 2025 16:51:01 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
To: George Moussalem <george.moussalem@outlook.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
 andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, kishon@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org,
 robimarko@gmail.com, vkoul@kernel.org
Cc: quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883E7167E44F92DBC29FF3C9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DS7PR19MB8883E7167E44F92DBC29FF3C9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2025 14:41, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Nope, that's not a correct chain. Apply it yourself and check results.

> 
> Add support for the PCIe controller on the Qualcomm
> IPQ5108 SoC to the bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Also not really correct. I did not provide tag to Nitheesh patch. How
the tag was added there? b4?

> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 

...

> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: sleep # Sleep reset
> +            - const: sticky # Core sticky reset
> +            - const: axi_m # AXI master reset
> +            - const: axi_s # AXI slave reset
> +            - const: ahb # AHB reset
> +            - const: axi_m_sticky # AXI master sticky reset
> +            - const: axi_s_sticky # AXI slave sticky reset
> +        interrupts:
> +          minItems: 8
> +        interrupt-names:
> +          minItems: 8

Why is this flexible?

> +          items:
> +            - const: msi0
> +            - const: msi1
> +            - const: msi2
> +            - const: msi3
> +            - const: msi4
> +            - const: msi5
> +            - const: msi6
> +            - const: msi7
> +            - const: global
> +
Best regards,
Krzysztof

