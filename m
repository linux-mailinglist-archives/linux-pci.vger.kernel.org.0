Return-Path: <linux-pci+bounces-21975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A93A3F134
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 11:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254EA3AB7BA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01B201246;
	Fri, 21 Feb 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wifdL6lk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3584204694
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132007; cv=none; b=DNxyushnEDP+73Pylc846VD9wHgJluUV1rqbhlcp+kS0TtZckVkJiWpSmQrLgfI5hSYdw9MD9XxCNe6D97f9yRsnBYExRtoGPn1TQbbLT5RPssIoGsgzc6i1o9QKFXiYpyBu+z/d6MozrzAWJp1rDKGbD1Opsv3XKIcw65envm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132007; c=relaxed/simple;
	bh=+bqvsqplc0ix2nD9cIkceoFFGaEb8J9OFFWRXYVz0Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hfg40ue+JM2hlitWRLyu1opnQfS2V7feepPID/b/ocoYzJ8wOAF8KKUVr3sWfy8cvxPjLgQvxugqy+2NRD1V+PhoxB9FlsHqSHepHJvgjzIliXgp59v32xuVk6J6JDU6RVN4oZXmvUJITi49ju5qH8Cj75FvSXKCrfz2OkdRBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wifdL6lk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5debb4aef2eso280397a12.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 02:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740132003; x=1740736803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xJWFyO2a6/QdicebMQYJMnjza8WWQ4TTI6mk3gJi0oU=;
        b=wifdL6lkRK/LeJodFdSkKFeuDB0brsATVxeMKwM4Un6H8k68oRGoizt1gYEh+Bjqm2
         DvOxVNU0a2liSFEwlvkNp1PWLICLNGHEkJupED8tzfk7SJAl8+IpYuWL50evOMNsAaZn
         WlbcxKPeSpCUWsYPjAt/CLTTsKm/P1nZGY4RnmDfpOgeN3hEbUnARAR3nlJYgycYUGi0
         AvPqoJxovMHysyd5oHbP3N26EeOP0BXKYFFWIJwHwcUxyA9dHIxNH/g6O76EnCmuibfM
         SeQVXFHjWFDOLl2Qc5mSZNjyBVTkKf7z+06M1yMigzlZ7wI5F8YBHnFLLcT1yePlmkp2
         XYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132003; x=1740736803;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJWFyO2a6/QdicebMQYJMnjza8WWQ4TTI6mk3gJi0oU=;
        b=XgJworvMSidqyE4nbr85BC2SHwjNGhamVVpkCKCFGivv1yTlb4cPi8VaVOdC8xnPU1
         hhO9ePPDngMZOJHOTUr+ZaDst93blPTf8sxrrzzUDOlfjyB32TzZB200PUKjN3ZsX0U+
         l1thdUc4CqaMiQfnse2k2g6URyqfUH4Cxv8UNJhiF59RPfLN0E6xcbIpQlXR4+p6KeV+
         PlnMHX0XzHM9jJ1Q02U+68ZYnGdkjkyVBur5IYJw81jyiabbKIX0Ub2YT+a5khq+SErV
         5TdjS0nnFCMIs2YdF5nQwGjnUqZkTZUnVADtTFhAMBZEnzwIwjbdlY46E708KPX3dooo
         ecQg==
X-Forwarded-Encrypted: i=1; AJvYcCVPmaUtMBHRSOSiKpPlLuzqg9FXRMkw9SMJATXpXzC0EY7SGB16yIo9hVNURWrMWYlHPANzbajUTkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCn92gSMTZexN8DvOiYhtf/WEJPigwrHWxTitHUKhgP22AKXOw
	RIzcJ774nAzqnKjY9++XqDHGe4LvL0AeAIRlSEROd0UuKa61ruDg2ckWIBcXUbc=
X-Gm-Gg: ASbGncvkiq48tBvE1DtP4UGLFvXFTuuIwf/iQih80w4pIm8wKEl3qu8f69ylwszd7sl
	mNNGJCswNC6HOf2lzXwW+FwsqeoQcuE/NEHqotakHPxzqASwRUdaSeRNwr5cRqY1xavdxB0A/Hd
	8JPHSadnaKu1IUuWuKQhDiUWPqRsNScAfo9xux8pCOh9HVFiLLFkUIJkKdCToXFvRxnDFCvYt2c
	HiA2lVa6uE3gNZGi7bx3npd2AGgN5zlm9TeHGtfG57te2lvlCsMZZol6nckBEdxhrwyW5LLrX4u
	4bml7kwCtF7r1L5F4YDKA+OSWYHolzWSWouNMTI1CDHQEheDHASrJEpLGJ7GEz5A4TPcAXFu0Wt
	hagMD
X-Google-Smtp-Source: AGHT+IH7qiTw3apgnrhqU/bLzLhb/NQ5sAnmLAR2GEvnO67FFYvNkxIa/eQDBY1qL2i6u2CP7HcXwg==
X-Received: by 2002:a05:6402:27cf:b0:5e0:8275:e9dd with SMTP id 4fb4d7f45d1cf-5e0b7252e4fmr745151a12.10.1740132003314;
        Fri, 21 Feb 2025 02:00:03 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4687sm13513289a12.22.2025.02.21.01.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:00:01 -0800 (PST)
Message-ID: <4f95cce5-53b2-4eb9-be28-6136eb89dcaa@linaro.org>
Date: Fri, 21 Feb 2025 10:59:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: qcom-ep: add SAR2130P compatible
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
 <20250221-sar2130p-pci-v2-3-cc87590ffbeb@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250221-sar2130p-pci-v2-3-cc87590ffbeb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2025 04:06, Dmitry Baryshkov wrote:
>    qcom,perst-regs:
>      description: Reference to a syscon representing TCSR followed by the two
> @@ -129,6 +130,45 @@ required:
>  
>  allOf:
>    - $ref: pci-ep.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sar2130p-pcie-ep
> +    then:
> +      properties:
> +        reg:


minItems: 7

> +          maxItems: 7
> +        reg-names:


minItems: 7


> +          maxItems: 7
> +        clocks:
> +          items:
> +            - description: PCIe Auxiliary clock
> +            - description: PCIe CFG AHB clock
> +            - description: PCIe Master AXI clock
> +            - description: PCIe Slave AXI clock
> +            - description: PCIe Slave Q2A AXI clock
> +            - description: PCIe DDRSS SF TBU clock
> +            - description: PCIe AGGRE NOC AXI clock
> +            - description: PCIe CFG NOC AXI clock
> +            - description: PCIe QMIP AHB clock
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg
> +            - const: bus_master
> +            - const: bus_slave
> +            - const: slave_q2a
> +            - const: ddrss_sf_tbu
> +            - const: aggre_noc_axi
> +            - const: cnoc_sf_axi
> +            - const: qmip_pcie_ahb
> +        interrupts:


minItems: 3

> +          maxItems: 3
> +        interrupt-names:


minItems: 3

> +          maxItems: 3
> +
>    - if:
>        properties:
>          compatible:
> 


Best regards,
Krzysztof

