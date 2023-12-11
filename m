Return-Path: <linux-pci+bounces-747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37780C590
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 11:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CA9281848
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDCB1D545;
	Mon, 11 Dec 2023 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSeGrvRn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A60EB7
	for <linux-pci@vger.kernel.org>; Mon, 11 Dec 2023 02:04:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c4846847eso6458845e9.1
        for <linux-pci@vger.kernel.org>; Mon, 11 Dec 2023 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702289078; x=1702893878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDYzYjg4W65ME6TOcbpcncJ0InbxR0OV1YB0ej6DADE=;
        b=aSeGrvRnrPAKGZAlT7MjMNw4Xs42UQvDbCzPF4Pei2HlvbnNQTgikgTd0e5nVj/hO5
         3idjDIAWhFodv+YyM9VGMRBEUtE7tn4WvrBb+KUDxutOwunmZz/HLiPULTS+gJjGbZJc
         Vo0cRh7LZHyB/Rh9M2SQTCcrdcgF4Tdoen/wKpIKsn8ZToe6wUqkZDO6RhQlOcvkGNS9
         Uo5WBqMf9td1cNAYKlqMn2/BuUPq4N0lPozZ8fEpxT/SJXJdWnTuFEOa+14TrE3AHnyO
         8C/qhYPfI49SDShF0HxmYV9zxO8uN4fjopY0m2ECnuTrXtu60EbwUl8zgZ9pYMII0aIc
         MNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289078; x=1702893878;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDYzYjg4W65ME6TOcbpcncJ0InbxR0OV1YB0ej6DADE=;
        b=TvDQ7qsQNA/NNdNpJRByGVjFN928TpLXqGBRJmwmYin9AvP+igA1fGXkKrrSj441gd
         /vf6fb0GVkElBgSou0ZQchg13XKCEVDr1yPHG7Oji6oyjb5q2co+P8bbpj53JJvuu9+K
         eBK06iBdRvWnK4eJHnVVtQsefCWisMzDXQqGQfr60EPTnsuKeaWJFm2EcWBxOH09f6FF
         dBXpcEWKiNm8z2h72W+8BSUKb8vymYmoWxHrH+2Ar4ptnmg+fbPvHrTG5pqVWasKp2gf
         KCtkgeYY2YgFd7HJZNlVMzw5e8Ok5Al/m6knCck1FGoIER5SfgLUiJWG0JN5uQFYzOCi
         s6OQ==
X-Gm-Message-State: AOJu0YwJoxUqgn03Njc9ZgEuvWyzGXPvpNeZjl4kGWSOI6MGjHd66/E4
	CTa0l8pqflpHdF06wEAfTx7rRA==
X-Google-Smtp-Source: AGHT+IE0dV7BSy46sVt4u21TlIr/PdsH70TJr1heJ6rIZjNGvDu3Jgo5EbbsUC7CpoZ+1PWUdEOwRw==
X-Received: by 2002:a05:600c:1503:b0:40c:3624:fc40 with SMTP id b3-20020a05600c150300b0040c3624fc40mr2239056wmg.15.1702289078660;
        Mon, 11 Dec 2023 02:04:38 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b004076f522058sm14781799wms.0.2023.12.11.02.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:04:38 -0800 (PST)
Message-ID: <68a12f8b-3941-4555-a2a8-3f4f3409d8fd@linaro.org>
Date: Mon, 11 Dec 2023 11:04:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: qcom: correct clocks for SC8180x
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
 <20231208105155.36097-2-krzysztof.kozlowski@linaro.org>
 <7f890553-5278-4bc3-9f72-a5a60d9596ea@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7f890553-5278-4bc3-9f72-a5a60d9596ea@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2023 18:38, Konrad Dybcio wrote:
> On 8.12.2023 11:51, Krzysztof Kozlowski wrote:
>> PCI node in Qualcomm SC8180x DTS has 8 clocks:
>>
>>   sc8180x-primus.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
>>     ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
> [...]
> 
>> +          items:
>> +            - const: pipe # PIPE clock
>> +            - const: aux # Auxiliary clock
>> +            - const: cfg # Configuration clock
>> +            - const: bus_master # Master AXI clock
>> +            - const: bus_slave # Slave AXI clock
>> +            - const: slave_q2a # Slave Q2A clock
>> +            - const: ref # REFERENCE clock
>> +            - const: tbu # PCIe TBU clock
> Are we sure this one is actually necessary? Or is it just for the
> SMMU debug peripheral? [1] Would be nice to test if it works
> normally (unused clk shutdown / forced shutdown of this one might
> be necessary in case it's on from XBL) and during a PCIe-related
> SMMU fault.

I did not validate whether the list is actually correct with datasheets,
but aligned it to DTS. I don't have the hardware to test.

Best regards,
Krzysztof


