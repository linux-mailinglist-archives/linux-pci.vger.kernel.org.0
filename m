Return-Path: <linux-pci+bounces-5630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37888977C3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 20:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F5D2875E4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D712153597;
	Wed,  3 Apr 2024 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae15G2wK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D215357D;
	Wed,  3 Apr 2024 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167526; cv=none; b=or+QKFOXWkfV9nHnL83eS6KstS6PQQqlaxXNAoAkqQmbe3DcgkYNfPetsm4o8t/hr4R/lVNfRqoS5fKdOLxS0dmg3Tw5Jei9k8bZPfnvFSxhNBOKQ88TheJhktd6rd9HEiLAbPLa0vWVGRSHVtBcgFnyj4FUatTN2oHCW0iqtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167526; c=relaxed/simple;
	bh=yzV8gvMbMG9aYQ19MBzqxr4amKzhod3/glCMw4VGUZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSv9ihzXp+9HPsOhWBzP7ZAqAKVHf/c4V2hKp9cqxndwa0WP3xmzT/1lOf3sIdzN2+govJbdjxcxtKvHqGqXv42SJgOY2clU4zwoqeM2hXCWr2EqHmczzKvBZvPiYXMdQiP6XXZKprzIhflK7ZcybDvNUGcv1vBBfsp1DaZrJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae15G2wK; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-229661f57cbso70050fac.1;
        Wed, 03 Apr 2024 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167524; x=1712772324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZ75uqyXcKd8R5Pz7Ws9tVG0bayyM9hJ1Z1pvbSQndY=;
        b=Ae15G2wK/YEC5vvYpf5FwQ/xNHB/FDO57tazsJYrpr+3JucPRuVBzAx2QQDyIJ6knf
         hVn4YJr+jG9UKaNC4thE5A3TPrXg75PgSqEfYyaqNdMa2yxW5hU4AeGlhtoLCQ2xW09N
         V5n2TdP8fe2OV9Zb9mQlT6lbG433DDg2KCM9Z9KPskRmEV5xy7qsWa6wXo0FdLkWYP+Y
         BahQJvOPjRuHQDpWszrY5zLUPr/mrV582COYrQWqQ6IgqnYX7xE1B5vlC2WE5qx9hPPa
         1clp9ErbkLzfPCXnRDr4rh4RM/EDOBW5lUkdGVxZdi/cNA2dWz5/1QpKdi7ogGcKSzmj
         t3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167524; x=1712772324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ75uqyXcKd8R5Pz7Ws9tVG0bayyM9hJ1Z1pvbSQndY=;
        b=lWJylmC9Y3HHD9KCaNpToIP0B38y59bK3eDBj+r6v8sdWkRNKaNle9ZKSUTG06kmc8
         5QLkOf/I/5YRQsGOojY+ROQlow0xg96vhn6r/FMbImPRKgwMyZmJv0gS+QbGlnH2qKHF
         EQ3sEoRQWp+k/tf8jLK2NQ4n5S5kd4a73zZidSziK5xlXT21EoZ7s84C2zCn4Obgpu6t
         Rt18P1zQn2DrOhQO9xIfW2ffvaQiPdMaLAxK/S3u9X7W+hM0JUPQH+b5qlmCWf7OfZGm
         FYXpfG1jEucu/BX14GBklTw2/Ir8c7G5oYJdMA/bz0JUcVihYNE/cNjkmTul9XDYTVwH
         +gqg==
X-Forwarded-Encrypted: i=1; AJvYcCXLOq92sWpzuAoX794TV7Cnod+VvRG8k1XCOXth/UTbPUyuTaBjggdSmmqGytaNQn4oYIwk7+Ng6XLqV8wPziVvJxeVcc7oJpez+yWud1PuUyJMDfJXaoT4Rv+Hw6cHGcvIQ/oznfFcW+f5SHoq47K3skOEzKbtx75uJMSK8w+oYU8k3DLOx4kaq6u3n4mLj4KLwu6hMlHvPLdkUVPNz96v/kU=
X-Gm-Message-State: AOJu0YxItEXlZBQyJAtKbuRRFojbeYlWK4WTpi52tJfyB5LWPXhGXaiO
	zEfjwMrq7D+1kiWE+2zWAqmMXOIxUGSd1/Jy1DO9A1W/ex4angmm
X-Google-Smtp-Source: AGHT+IEtjndM4TcXGUt3GAQI11LA8n53NRmJwToTDskQZ/GbUK0jGW4KyyBCURII9akrd7cabDnLTA==
X-Received: by 2002:a05:6870:5d85:b0:22a:b3cd:1d7e with SMTP id fu5-20020a0568705d8500b0022ab3cd1d7emr82627oab.27.1712167523575;
        Wed, 03 Apr 2024 11:05:23 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id hi27-20020a056870c99b00b0022e9bd70567sm317220oab.31.2024.04.03.11.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 11:05:23 -0700 (PDT)
Message-ID: <d35c96ca-24af-fbad-74fe-ad85a433caa2@gmail.com>
Date: Wed, 3 Apr 2024 13:05:22 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/7] dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: ansuelsmth@gmail.com, robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
 <20240402192555.1955204-3-mr.nuke.me@gmail.com>
 <bad88189-cf70-4200-9fa3-650ea923b4b8@linaro.org>
From: mr.nuke.me@gmail.com
In-Reply-To: <bad88189-cf70-4200-9fa3-650ea923b4b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/24 02:14, Krzysztof Kozlowski wrote:
> On 02/04/2024 21:25, Alexandru Gagniuc wrote:
>> IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
>> The only difference is that the "iface" clock is not required.
>> Document this difference along with the compatible string.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 32 +++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index cf9a6910b542..6eb29547c18e 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -26,6 +26,7 @@ properties:
>>             - qcom,pcie-ipq8064-v2
>>             - qcom,pcie-ipq8074
>>             - qcom,pcie-ipq8074-gen3
>> +          - qcom,pcie-ipq9574
>>             - qcom,pcie-msm8996
>>             - qcom,pcie-qcs404
>>             - qcom,pcie-sdm845
>> @@ -383,6 +384,35 @@ allOf:
>>               - const: axi_s # AXI Slave clock
>>               - const: axi_bridge # AXI bridge clock
>>               - const: rchng
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pcie-ipq9574
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 4
>> +          maxItems: 4
>> +        clock-names:
>> +          items:
>> +            - const: axi_m # AXI Master clock
>> +            - const: axi_s # AXI Slave clock
>> +            - const: axi_bridge # AXI bridge clock
>> +            - const: rchng
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pcie-ipq6018
>> +              - qcom,pcie-ipq8074-gen3
>> +              - qcom,pcie-ipq9574
>> +    then:
> 
> Do not introduce inconsistent style. All if:then: define both clocks and
> resets, right? And after your patch not anymore?
> 
I kept the resets in one place because they are the same cross the ipq* 
variants.

Do I understand correctly that you wish me to split up the resets as well?

     if ipq8074 ipq6018
         clocks
         resets

     if ipq9754
         clocks
         resets

Alex

> Best regards,
> Krzysztof
> 

