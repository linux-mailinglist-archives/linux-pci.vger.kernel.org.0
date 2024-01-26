Return-Path: <linux-pci+bounces-2568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EEA83D615
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 10:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209F41F27C8F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30291BDE3;
	Fri, 26 Jan 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSzqCaaZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3B1401F
	for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258907; cv=none; b=gvdsH7i/hKAzdtzKXOk2V1YXL1q5WHmqh7B7F86BPl3eMCW+woIKp8eSlGVgBbrp3u16MNVReED0deKh3TkjD/vl1EnXWj+x+WVVA+YWZi38MD2wAoceJwoGq9Ynguz/duDgVEeXm/dwdxnEj1wfik71scdA85FMdAJDmHRwkXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258907; c=relaxed/simple;
	bh=VS5Ni5maj31JArPqZY1vs9pBolpnXuzegBBwM4lLN28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eU5y6xvTv6TXbiEXsVKfGJ9lQcITR4G62ZRFUusoBghgEn8GOPf5gL98gaAAO28ST73of5+H4P0R6KE7ANozi8TkDNu2T64dkfv3fElBktdDV6pywyWWk6wjz7NIRrA0qvloYPntGTicmV+YylDa5rX+k7HTgY8I5En8dFegYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iSzqCaaZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-338aca547d9so167790f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 00:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706258904; x=1706863704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n6wRtkPjuUrJjlFMUMqH+6j6lsvanycmt3XDtafzhRg=;
        b=iSzqCaaZk3Q+Gt2sOZ+gzwPF0rgLRUAFmVzIM/V5gBZQ/E/KUzK4aLJ0GwK13qscX0
         Z49BGBeHmY1iO4cTHpPD7w7H+y3buhgKVl5YKw2GTvlMRwYEiBbqp9Ja1+YE6VOhDSoX
         zqT/9Dfg+oVDj2pjUy1n7ByP0mUUf+oW5iMLakEc3KdbIb4rIv5s/serg67LfsAVJw9C
         CblcjhKAQQv/u/ST1oNLfyjMpk/k9B98M+7Y9RzsZ7vBDDGJpWjlreN1QKhagWcaYCNg
         Q/rxXvZym2MsUg1s4KP3m9anKpDL39VnKmZWpYkc7IO8m1TJLUU+cr3yTUBVO0DYXEnD
         nXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258904; x=1706863704;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6wRtkPjuUrJjlFMUMqH+6j6lsvanycmt3XDtafzhRg=;
        b=OSE66084y3cWDFgVKTEepbg/v8+7l0AiQT6862FafuqI1PDM+r7TX6bOxZV44xaNHv
         d+xwRLxUjM3qYO5MfPWhUq+oq2PJ/y6smHSqMERKTGDRScPyDMHt8TyHD0uXg0Qs0L2o
         LCuInAJZ9ItN3WgDOBoYowoxaFJIs6oUbHGVX9XmaHm4ErByv9bWPrYTJbtGA5RYmHCj
         UYhetQHsbclAdW3HyaxMlV6Jf/108KQByBmMrms82UjXhqeCqph3t2oPOuagB0B+x3W+
         DNGSo116sl1C1vfLW/2ajK47Bll6HIhM/43J8abXxt8FfSsXTudji6C1ZBd92A6PztMf
         FaRA==
X-Gm-Message-State: AOJu0Yyp0Kz8XWWkCtHnbr+v+8g/SoP9Sd/7SPGj/oTGmwX90DFGRqRI
	HjN5S58ODwTXM1aKWj3+Z+zcoRqorrvm8OQMM8NsDCI5ffE8B+bg4Br+eRODJrM=
X-Google-Smtp-Source: AGHT+IEwQsLrUSRj8yMQZRrM3TJrxtGnaUPwFw8asQJYI5gX43nSMwhRCTMymhgu1XArH0UM/lj1QA==
X-Received: by 2002:adf:e581:0:b0:337:bc89:c11a with SMTP id l1-20020adfe581000000b00337bc89c11amr398266wrm.239.1706258904145;
        Fri, 26 Jan 2024 00:48:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id gx3-20020a170906f1c300b00a19b7362dcfsm382645ejb.139.2024.01.26.00.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 00:48:23 -0800 (PST)
Message-ID: <ddaae46e-e081-4bff-9a36-44499584cb08@linaro.org>
Date: Fri, 26 Jan 2024 09:48:22 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to
 dedicated schema
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84sk?=
 =?UTF-8?Q?i?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org>
 <20240125-dt-bindings-pci-qcom-split-v2-2-6b58efd91a7a@linaro.org>
 <170623813219.6729.5150130088127136653.robh@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <170623813219.6729.5150130088127136653.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 04:02, Rob Herring wrote:
> 
> On Thu, 25 Jan 2024 14:03:25 +0100, Krzysztof Kozlowski wrote:
>> Move SM8450 PCIe devices from qcom,pcie.yaml binding to a dedicated file
>> to make reviewing easier.
>>
>> This creates equivalent schema file, except:
>>  - Missing required compatible which is actually redundant.
>>  - Expecting eight MSI interrupts, instead of only one, which was
>>    incomplete hardware description.
>>
>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 175 +++++++++++++++++++++
>>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  67 --------
>>  2 files changed, 175 insertions(+), 67 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.example.dtb: pcie@1c00000: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'max-link-speed', 'msi-map', 'msi-map-mask', 'num-lanes', 'perst-gpios', 'phy-names', 'phys', 'power-domains', 'ranges', 'wake-gpios' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sm8450.yaml#

I thought that's error coming from dtschema about msi-map, but in fact I
removed a bit too much in this binding when dropping if:then:.

I'll fix in v3.

Best regards,
Krzysztof


