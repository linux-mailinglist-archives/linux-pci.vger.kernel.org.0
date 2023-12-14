Return-Path: <linux-pci+bounces-1006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE68139D1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 19:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7748A1C20B93
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9668B6A;
	Thu, 14 Dec 2023 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVqJ7OoX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8626B10A
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 10:19:27 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50e04354de0so4923562e87.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577966; x=1703182766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tz5zZ7XIhwY6/jPHZIwEJj6SU1xu1mLTCKyQZuGvubA=;
        b=mVqJ7OoXorBTSHC1C3WvAANP/QMRPfPY+/CNl9lcad0WJFfG5R/pGboc0eJhFcG7dn
         UgtpBFLALm5/rwO0N60QzcY1ECsXs2FQ8yi7lDSdAsubvgR4fZ+5f24oXocK7VJ/E3fU
         6AM6ZqwtpkGxhRudj7tkNcBWHV2Pk9xCaaA5Q9vsMBIOfhvJlCsGGQmkWs6JluBeBldt
         ILiCYQQ7LUJiTWlL91LfNAodHWgHJwqrjcnDNr7TmF/QQh4NolgPHRnCzkLm3fxt3X0B
         5Mwrp29LFzpxCqntdEQFVe2BxBjc3zVM/xfisGJkmAInbNJ8PzxuxWFLfKh2Gmryb0mz
         q7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577966; x=1703182766;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz5zZ7XIhwY6/jPHZIwEJj6SU1xu1mLTCKyQZuGvubA=;
        b=btmZcvRk9dgtEq3i/4lab5PZCjEyPYGqJP+sojYXDzJ4bsFUds45J0Oh4smp+qBNrW
         EM4mBgirYKs0gYm59CBNcTeFcWZ6HzR2C2kmkjBzuH5g0hmIq87Gvrkr+Lp33JCOuXfb
         nRV2KUgdLp/JTqkeJLLab4HwOst9b/T4V5gwDpLsrlkO8RpYBp6wQukXjMfGmrqJXllj
         ssb+oDSH54skIHwjjbeeChQikTovxYYsVdsM1dQrPzZdkKaHXHuBYjd6NjBeFRPJKa1d
         D99ehp/8r4mdVgdn0Fx3fQflJlLha9FJInmyhlZo2blpg3zeIL/DAzj+8CLaoZUoAXRt
         dkAQ==
X-Gm-Message-State: AOJu0Yz7e31wPyCjiInraSflcLdVtegIAxSw94d5LYHfYMrX7aS4vGC2
	izehQhzIhvFa+zTr5Es9eqJJmA==
X-Google-Smtp-Source: AGHT+IEd5rUmE9vj32IaKUVYaG62tPWwUyOBhODyj7oW0ZYA15iE8Fd2X6aaVro/u0c/wMRU9t2dwQ==
X-Received: by 2002:a05:6512:1294:b0:50e:19f3:9615 with SMTP id u20-20020a056512129400b0050e19f39615mr705537lfs.39.1702577965691;
        Thu, 14 Dec 2023 10:19:25 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512105000b0050d1a0e7129sm1659686lfb.291.2023.12.14.10.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:19:25 -0800 (PST)
Message-ID: <718fb4a7-9a1c-4e4d-8c36-935b766499cb@linaro.org>
Date: Thu, 14 Dec 2023 19:19:23 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: qcom: correct clocks for SC8180x
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
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
 <68a12f8b-3941-4555-a2a8-3f4f3409d8fd@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <68a12f8b-3941-4555-a2a8-3f4f3409d8fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 12/11/23 11:04, Krzysztof Kozlowski wrote:
> On 09/12/2023 18:38, Konrad Dybcio wrote:
>> On 8.12.2023 11:51, Krzysztof Kozlowski wrote:
>>> PCI node in Qualcomm SC8180x DTS has 8 clocks:
>>>
>>>    sc8180x-primus.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
>>>      ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>> [...]
>>
>>> +          items:
>>> +            - const: pipe # PIPE clock
>>> +            - const: aux # Auxiliary clock
>>> +            - const: cfg # Configuration clock
>>> +            - const: bus_master # Master AXI clock
>>> +            - const: bus_slave # Slave AXI clock
>>> +            - const: slave_q2a # Slave Q2A clock
>>> +            - const: ref # REFERENCE clock
>>> +            - const: tbu # PCIe TBU clock
>> Are we sure this one is actually necessary? Or is it just for the
>> SMMU debug peripheral? [1] Would be nice to test if it works
>> normally (unused clk shutdown / forced shutdown of this one might
>> be necessary in case it's on from XBL) and during a PCIe-related
>> SMMU fault.
> 
> I did not validate whether the list is actually correct with datasheets,
> but aligned it to DTS. I don't have the hardware to test.
While I can't test suspend yet, the PCIe itself works fine
without these clocks. Mani, can we get rid of it?

Konrad

