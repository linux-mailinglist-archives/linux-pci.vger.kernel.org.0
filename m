Return-Path: <linux-pci+bounces-683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F3280A301
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF15B20B4B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDD51C289;
	Fri,  8 Dec 2023 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8LaE5n+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E7F199C
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 04:18:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c9116d05fso2781184a12.3
        for <linux-pci@vger.kernel.org>; Fri, 08 Dec 2023 04:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702037880; x=1702642680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgne8jfuv4ytpfcfNboMQl6PQ6PgOyvGX4p3ndjzRIU=;
        b=x8LaE5n+jgW4jQluoChfkLj2gG4ajnmV7mP2zrLjAvtDFaI42WUpsVeLyeBwNud9nv
         n72dWN+Owxa30ayEhi/bYKhxumn+mLRhHB+QBvNpnfmlUrTKXNaV99zJw4DSuA4wSwG/
         iByRh13cByD9UTUkGH67JdXdLm6XVfaaPD5D8ua/yXmWJidyKnmFMpsNv8IrW/zaJmxN
         gAJQlgoglw3AZHFIIkX9FjtZpBZX6MngCd627MqHsz7kvT+nYOSmyPKPKL2QsKmGV74U
         uZKUm6Kv243XmQpvYuQ1hSIjMozVVebes5cpRd4NevAZJ5xJhHiVYxCL9GMxUfg+nsBT
         FeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702037880; x=1702642680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgne8jfuv4ytpfcfNboMQl6PQ6PgOyvGX4p3ndjzRIU=;
        b=kfXmACu0R7MzkZ2LM7ep6L2cDpCM9+bl/HQ0q7Cb7fKC/VZaUasbbOK85rFZy0s4dq
         j9VLFJKWNK6Nzmgidz0PoZIMIJTHJv1Ggz0X2eDIckXFgsMmofKzSWyNiepYvbGdFs0A
         +cQyYwY0E3vor859uH3VxvF2BTbfVniD1N8D0kvvJiTglhSkeWHNwwsvaEQKSYLgQZZ5
         D7kjniMyV+V+f+z9oQKjfnfEFpId9gVAtBPuaHnbdojCH5vvIntMvjHs3Hl7UVvRYaLs
         rBp9AnLiR5YFQwy2GxweoMsTD3NTcbptVY4tpUTJhztv0rc1xS3IlGGimzgz7qaQiz95
         nzhA==
X-Gm-Message-State: AOJu0YyyVp7n5oGasH4+K+uNGE/U4z8uvWkUZp4tn9gulpNDVBa1nqGQ
	13TqS4lIynwAT6ChiTzaahhTUg==
X-Google-Smtp-Source: AGHT+IE5mm9M0WWE4uEledG8cubJBa0sU3xgeZ/S2appl4lxKPZsg4b42mDhYcH+wYRiHysvOmUfsw==
X-Received: by 2002:a50:c2ca:0:b0:54c:4837:9fe1 with SMTP id u10-20020a50c2ca000000b0054c48379fe1mr8018edf.56.1702037880419;
        Fri, 08 Dec 2023 04:18:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id o29-20020a509b1d000000b0054ca1d90410sm790428edi.85.2023.12.08.04.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 04:18:00 -0800 (PST)
Message-ID: <cbf0b9a6-2752-4ab5-ab21-af28e87fc1e6@linaro.org>
Date: Fri, 8 Dec 2023 13:17:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: qcom: correct clocks for SM8150
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
 <20231208105155.36097-3-krzysztof.kozlowski@linaro.org>
 <CAA8EJpqKM45=6R0fHjDjNWfZpR-QxRoJo-ioB-t-WT188jpqnA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJpqKM45=6R0fHjDjNWfZpR-QxRoJo-ioB-t-WT188jpqnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/12/2023 12:09, Dmitry Baryshkov wrote:
> On Fri, 8 Dec 2023 at 12:52, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> PCI node in Qualcomm SM8150 should have exactly 8 clocks, including the
>> ref clock.
>>
>> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Please take the patch via PCI tree.
>>
>> Changes in v3:
>> 1. New patch: Split from sc8180x change.
>> 2. Add refclk as explained here:
>>    https://lore.kernel.org/all/20231121065440.GB3315@thinkpad/
>> ---
>>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 5214bf7a9045..a93ab3b54066 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -559,6 +559,32 @@ allOf:
>>            contains:
>>              enum:
>>                - qcom,pcie-sm8150
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 8
>> +          maxItems: 8
>> +        clock-names:
>> +          items:
>> +            - const: pipe # PIPE clock
>> +            - const: aux # Auxiliary clock
>> +            - const: cfg # Configuration clock
>> +            - const: bus_master # Master AXI clock
>> +            - const: bus_slave # Slave AXI clock
>> +            - const: slave_q2a # Slave Q2A clock
>> +            - const: tbu # PCIe TBU clock
>> +            - const: ref # REFERENCE clock
> 
> Can we change the order of the tbu and ref clocks and fold this into
> the sc810x case?

I prefer not, because this is an ABI-concern and we are supposed to keep
things stable.

Best regards,
Krzysztof


