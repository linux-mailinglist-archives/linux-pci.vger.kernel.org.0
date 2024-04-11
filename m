Return-Path: <linux-pci+bounces-6151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD108A1F37
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 21:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF131C2451C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D79C205E3E;
	Thu, 11 Apr 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ql4Lf75Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616B3E470
	for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2024 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862588; cv=none; b=qW1ERg5PT0Wh7Bvd0s13iWjkhC/8GrzQWmLhpihGRabavGHoy0vzchCPsIsgCXH/vJxfbJcTtGwFOmY567qNFp6EqKKekX2sPNAAUyS9su22pwObYfvn65CJFjjEMQ520R4UXtxA/Zm2688s8LH2tYQzR6uAgKev3bn+dpGi8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862588; c=relaxed/simple;
	bh=cavp+LCNLjYxo6Suwi+ERHyAc4fJGNXh1VhWah1icVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQuUM5UwqMOHF6syCnBZT5ObIoysQPk7bk2qPrYn4td2oAkvEFYJ5GrCdb/sawvJv63Z/3HsJzDhClKuU96kd3scPJujtXwQECD8AkxGu+jXG5mCGxjXPmxBXQ9v70l4D6AyuOC59vohFaF0CnT6UgmcPcmpwUqb77hlwS2hBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ql4Lf75Z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3454fbdd88aso71571f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2024 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712862585; x=1713467385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bot4p4qlJzYz0f8yI25gEfAhoAL7UL+ZFzOhOHx9Urw=;
        b=Ql4Lf75ZAGEvXrVG8OXV+eJ2Cx/NY9M9TMOPrMMYp/b7hqc4BQGKFvVi7+Bn7H4jVz
         JWi9AGIhKpBf3DTgcrMQiIfJq6/aPEAW3S/ho50PLW2IEGPykzyoNBzHTaPiqRsOgFZi
         p9RNPcxqIdZOOPJAf8VRLYyAkYAyt3c34p47LeOeU1YaCE4PJYZn8oJTrEtRxqvbBNBx
         b1+w2OUxJH5H2Mp3pytz8QwIR47fw9b6cBeV+/Yf+u4sG0pfg7IrPuWLE6PAu6RipqJv
         q/Cx3Q8y36ePVSwY9NS41pgnTUY10qcWxAPCrk++j2gOfSudMVHFPq60kN2UXbJX0jHR
         +kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862585; x=1713467385;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bot4p4qlJzYz0f8yI25gEfAhoAL7UL+ZFzOhOHx9Urw=;
        b=YdmPyN5l1XwpKpuun7JGjTnIHXx8uIgI18jcuxLQF1ibdCOc6qVOkjsxp2bYaprkcA
         PyybvEEjqSpafeM16nYQx04Qc7T51j6AdOuN5NMiXvsFfnvB4jvoqqTMBqyJrwtZRbyt
         f2kZoCnccx0+YcRuAv0DijoyTNrcl/Z9sB8ZMOLj52xyrOBdjJFWckcSvqVN1qDnfNwD
         YPxMYWwEMo7L+ZwuYcbZvhRgEb33Wqt4blv+p+/6Q2ZVBGyyGuXrz4v50CoroTEJHeG6
         U/BKXGj8xi7U76OpZurTmJ1cTHleef3UA2VX5XMRQWyP2rWtEQviLyMW1yGa82MPCb8g
         lxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOX94Qfw59xw29VBdNZnp9j6/0KW0JD3Ga5idkpYyOnRRiKrj3ulfKllTYpNtbVWAMzn/T/T3PpP7lWhFpw6HOoYUuKhJF640U
X-Gm-Message-State: AOJu0Ywr5eH0numgqawvtEObOqpw0zPor9e65mBBmJAnIzhAn+4pShpL
	JL6283QkaJ28HA53yWaZR0LFoI08r2KTw2cSQHZStuhoRd5KNkBdM5O4Womc0vk=
X-Google-Smtp-Source: AGHT+IHZUOS5brHa+g2Cz4HV010NylLE8FMAZeToMRc2tDxi39AIESJYbq0cm/SDQ8sFrPU3mNk+qg==
X-Received: by 2002:a05:6000:11c2:b0:343:878d:d691 with SMTP id i2-20020a05600011c200b00343878dd691mr284875wrx.47.1712862584830;
        Thu, 11 Apr 2024 12:09:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d16-20020adff2d0000000b003418364032asm2405193wrp.112.2024.04.11.12.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:09:44 -0700 (PDT)
Message-ID: <dcf612e6-cfe6-4a4d-8001-2e9912534807@linaro.org>
Date: Thu, 11 Apr 2024 21:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: PCI: qcom: Add IPQ9574 PCIe
 controller
To: mr.nuke.me@gmail.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-4-mr.nuke.me@gmail.com>
 <dbee301e-2e31-4db0-877a-96c972ea4bca@linaro.org>
 <bcb03c7d-f566-11cc-21e2-47e5c5a0776a@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <bcb03c7d-f566-11cc-21e2-47e5c5a0776a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 20:00, mr.nuke.me@gmail.com wrote:
> 
> 
> On 4/9/24 15:08, Krzysztof Kozlowski wrote:
>> On 09/04/2024 21:08, Alexandru Gagniuc wrote:
>>> IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
>>> The only difference is that the "iface" clock is not required.
>>> Document this difference along with the compatible string.
>>>
>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>> ---
>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 34 +++++++++++++++++++
>>>   1 file changed, 34 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> index cf9a6910b542..1915bea580d3 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> @@ -26,6 +26,7 @@ properties:
>>>             - qcom,pcie-ipq8064-v2
>>>             - qcom,pcie-ipq8074
>>>             - qcom,pcie-ipq8074-gen3
>>> +          - qcom,pcie-ipq9574
>>>             - qcom,pcie-msm8996
>>>             - qcom,pcie-qcs404
>>>             - qcom,pcie-sdm845
>>> @@ -397,6 +398,37 @@ allOf:
>>>               - const: axi_m_sticky # AXI Master Sticky reset
>>>               - const: axi_s_sticky # AXI Slave Sticky reset
>>>   
>>
>> Where do you constrain the reg?
> 
> I didn't realize that was also required -- the make checks should have 
> picked this up too? I might be invoking the tests incorrectly.
> 
> I should add the ipq9574 in the same list as ipq8074-gen3 and ipq6018, 
> correct?

If you add new variant, look at existing compatibles where they appear.
If there is a if: constraining compatibles, then it's a hint you should
do the same for your device. So yes, you must constrain all properties
which are made flexible in top-level properties.

Best regards,
Krzysztof


