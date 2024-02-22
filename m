Return-Path: <linux-pci+bounces-3877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1BF85FAF3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 15:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EAB1F226A9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411141468F8;
	Thu, 22 Feb 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XirS5Pf4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF381419A4
	for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611566; cv=none; b=LSMATSJQxSObgvHEI4IY0xpmhxirgMJqegc2rXscTulQb60h46t+35xAqnjP8ony4jwyJaYkRDQz6Fr+QrdszN8R3s8YqQZhOVU4/zj/T3rO7bv2KUUIZLdOLb4otoACiuzASYidpAwgNKp4rVCfGFZUEDCIcByA1jFfS0wOdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611566; c=relaxed/simple;
	bh=C0jXR/wOaXK91vPaSRCqLalbs4qTbCnbKaYgnICuX98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpUMgbnmvOIWqmr/MiuDgcQXd6blqN2bHGGhyqNL3MZilcyC4RUWuwEpwC7JmBVF07IcoLrkgTxRjquc42s4i9ZiM3uXsa4hiFYFXo9amDLg6vwH1l2ZAF2NtIqtsgPxBswrxOaqPTF8L0+Ds7fl5NKKcp0V+3gXalSd+Ha23GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XirS5Pf4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so2696888a12.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 06:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708611562; x=1709216362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NuMH8xbITSo37FxxbokylDYVuCho33Aas0q9MzrhiK4=;
        b=XirS5Pf4/edbFJ1MdLB4REkAdQSNzPDpSzSzogjb08yBMaBwYwlZPcK87ZnEAlOKVC
         D8U2TVovRHUfaNDpWkW6x6b79O1z8VFJ8h2OMQ4Yhhf7u7A/xVsqKPtOQtDAfkkHcUez
         6HCk9IMfBgYcPSGIJaagAGWr1AZL6sYhlbC9Ne0fZee7fCAh/CHooMGHc4/8RQdvfA2b
         kI80A/VwLAzhkvpw9bTABHMU4JYMwxTN95jBhax0EqrmNOWJTXOlhlxn0X1xJ1pB0evh
         qLcTaaQJRsKUVu4SYQZis2U5OQ6GBxFBHJvbCJcI7dxpenDuna0IVe6QRYfrPnzqqd2m
         HOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708611562; x=1709216362;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuMH8xbITSo37FxxbokylDYVuCho33Aas0q9MzrhiK4=;
        b=v34+mwYx1OUDwkC4lmuMiJg55/dgRDuZpfvOxJ4aqAvZqPvnfSkM1YemGwDSK6MeYT
         Pzohspp5oCJnDBINtIMLnfXK0vTrXNiCysEPj7+3GPPFp8wYAUebb8WmnmHpVz5lOmBT
         FxwtBTPfKhbia26ODwsnyjNjcxDt9WxW8cG9EkP+Kke4EVrMtHFt1yYK8euNt1EiTn0t
         MmiPiF/JsQoqDTUCY18NaHYxUcK/P+ZyU+mvvY6OjRsgCWmBFvhuWzdOubPRji3YZ0RC
         5Y8savCMeirtjepV3IELVgL63iAFHcUKWamkC5ZIiTC0IcXYF+wSDnnSZYdqAYcF6jjA
         9gKw==
X-Forwarded-Encrypted: i=1; AJvYcCXwru4cRtcdM4Vd2r9oHls/u7e3PGB1HuciFYoY8FizxiSyJCzQcfFnEFcm8Zplf5gbeZjDKeE7Yu2OsxXl9TbT5P44cXlZkNZi
X-Gm-Message-State: AOJu0Yz4uSM4STjUTpzUe5jdBn4GzzSliHvb80PoVlleuXbL+oi6LS96
	UByxX4vSM2XYcJ/pkJUmqtELeAeNsLd6pEHHs2zAGo2XRf+z20mCVTie1m1bovo=
X-Google-Smtp-Source: AGHT+IFds60gRlEf9WM8O8nVamNVIVQzzN7qSdjditE7rhdkhecxbgKiq5xU74wx+MexlDqlZQXbFA==
X-Received: by 2002:a05:6402:2cb:b0:564:7074:7431 with SMTP id b11-20020a05640202cb00b0056470747431mr7755571edx.14.1708611562520;
        Thu, 22 Feb 2024 06:19:22 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id et5-20020a056402378500b00561c666991csm5497992edb.73.2024.02.22.06.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:19:22 -0800 (PST)
Message-ID: <73dce65e-e066-4df9-b0ba-bc04c1d28068@linaro.org>
Date: Thu, 22 Feb 2024 15:19:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: qcom: Add global irq support for
 SA8775p
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 root <root@hu-msarkar-hyd.qualcomm.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, jingoohan1@gmail.com,
 gustavo.pimentel@synopsys.com, manivannan.sadhasivam@linaro.org,
 conor+dt@kernel.org, quic_nitegupt@quicinc.com
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
 quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
 quic_vbadigan@quicinc.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
 <20240221140405.28532-2-root@hu-msarkar-hyd.qualcomm.com>
 <08ca89da-d6a1-440c-8347-f2e31222bede@linaro.org>
 <a0677780-d013-44f7-94bf-ea7e23aab019@linaro.org>
 <88d8fea5-2b11-4d01-816c-dbe822ac8d19@linaro.org>
 <51ffdd0f-d3a1-7f19-2033-264baf71394e@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <51ffdd0f-d3a1-7f19-2033-264baf71394e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 14:46, Mrinmay Sarkar wrote:
> 
> On 2/21/2024 8:03 PM, Krzysztof Kozlowski wrote:
>> On 21/02/2024 15:31, Konrad Dybcio wrote:
>>> On 21.02.2024 15:28, Krzysztof Kozlowski wrote:
>>>> On 21/02/2024 15:04, root wrote:
>>>>> From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>>>
>>>>> Add global interrupt support in dt-bindings for SA8775p RC platform.
>>>> What is this global interrupt? Why wasn't it there before?
>>>>
>>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>>> ---
>>>>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++--
>>>>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> index a93ab3b54066..d86fb63a2d2c 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>>>> @@ -63,7 +63,7 @@ properties:
>>>>>   
>>>>>     interrupt-names:
>>>>>       minItems: 1
>>>>> -    maxItems: 8
>>>>> +    maxItems: 9
>>>>>   
>>>>>     iommu-map:
>>>>>       minItems: 1
>>>>> @@ -873,8 +873,30 @@ allOf:
>>>>>           compatible:
>>>>>             contains:
>>>>>               enum:
>>>>> -              - qcom,pcie-msm8996
>>>>>                 - qcom,pcie-sa8775p
>>>>> +    then:
>>>>> +      oneOf:
>>>> No need, drop.
>>> Moreover, I think this global irq should be present on all qc platforms
>> Heh, this will anyway conflict with my series:
>> https://lore.kernel.org/all/90a50ab4-a513-48af-b13a-bba082e49540@linaro.org/
>>
>> https://lore.kernel.org/all/20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org/
> 
> Thanks for sharing the series. will make change top of your series on v2.

In general: no need, whoever gets applied first, is lucky :)

Anyway they could be applied today.

Best regards,
Krzysztof


