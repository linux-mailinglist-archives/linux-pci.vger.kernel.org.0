Return-Path: <linux-pci+bounces-1602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40945821FDD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B250D283B50
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379EFEADC;
	Tue,  2 Jan 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPZKEdcZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEA1548D
	for <linux-pci@vger.kernel.org>; Tue,  2 Jan 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55692ad81e3so845106a12.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Jan 2024 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704215019; x=1704819819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXy+piCF6laRl4RirosdnXKxrWevr0U2OrR6U+dUeHM=;
        b=SPZKEdcZ7W8C9T+9a65+bg4mv0Lrh3YhW45sLhSY+YWNU+VuuethT0wZLxtKwXPZ4r
         MbkxHwdrzXJP47ipl2bq1zCK0Ac9WgfzbhQoGmQ+WibVKME0lcG4vKCm9CqlmFVWCsV2
         V6L5fNS8jCWKxbQ6qhIK2gLkCIAdO71aYjx/tnhTOR6xSUc2lLlxg/TRABdDHste10Wq
         j1waizz5JVKa9605qePYb+gESvPPqi+SmDgKgQrjABzFwHoNfsgN4aJooJZFId+JZJWq
         b1c09dBHBU9jtlY6U7XvYdOf9QV0HKcWGSaLACo2VMf7DywDXfIYi/v0wuMbVCkKccO5
         DyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215019; x=1704819819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXy+piCF6laRl4RirosdnXKxrWevr0U2OrR6U+dUeHM=;
        b=NnA83CKjEqpfObRPIq026TrM2XiRLi2Dvi3sQl902WgZARHeS+2OfiGlz0291Qfv9u
         1MD+rMSNljlsfskNEgWEKq2A+HmV2kHRougkLUqHNMVjTRGuzARmdmLPajmbMS9Rhbm0
         WYjF9eCdFUaWSBqkMWEXob3d5JR+sTRV8l3uR0nVmQH6lpVXQ14XAsVt3pu5r8ve19w8
         BaNWg5TrVovXIRJLWokOd7MU7RDZMiXmcvhcUSk+1UMtSiXFH2kG/fX7Xan2rLln9YZ0
         OvF8gjx4KNd6NA11J4Y0GVD/lmGs5phWM1rJceKZnN8Tcy3Jzfo8WuKe9FZ/aMFZNwPL
         D0Yw==
X-Gm-Message-State: AOJu0YyZA9Ot99YKYo4ZZp7SeOidVlXqpG2aY2VQJW34Q3b4nVaPTp4o
	fD7G0rij12vq2OXQQiQZ50htJG8gLCEOUw==
X-Google-Smtp-Source: AGHT+IE0rCUtRWDEA2A9NkB46vryE752x23H6ZV2iEco2BKL9wfkDZNRGtiJD0FyJyJqlqzOhx09eg==
X-Received: by 2002:a50:d65d:0:b0:553:f8be:9754 with SMTP id c29-20020a50d65d000000b00553f8be9754mr10257514edj.50.1704215018842;
        Tue, 02 Jan 2024 09:03:38 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b00553830eb2fcsm15987959edb.64.2024.01.02.09.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 09:03:38 -0800 (PST)
Message-ID: <07b20408-4b45-48c3-9356-730a7a827743@linaro.org>
Date: Tue, 2 Jan 2024 18:03:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: qcom: Reshuffle reset logic in 2_7_0 .init
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Andrew Murray <amurray@thegoodpenguin.co.uk>, Vinod Koul <vkoul@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
 <20231227-topic-8280_pcie-v1-1-095491baf9e4@linaro.org>
 <ZY7R581pgn3uO6kk@hovoldconsulting.com>
 <fa0fbadc-a7c3-4bea-bed7-0006db0616dc@linaro.org>
 <ZY7l828-mSGXVwrk@hovoldconsulting.com>
 <598ede70-bc01-4137-b68b-981c3d420735@linaro.org>
 <ZZPiwk1pbhLyfthB@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZZPiwk1pbhLyfthB@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2.01.2024 11:17, Johan Hovold wrote:
> On Sat, Dec 30, 2023 at 02:16:18AM +0100, Konrad Dybcio wrote:
>> On 29.12.2023 16:29, Johan Hovold wrote:
>>> [ Again, please remember to add a newline before you inline comments to
>>> make you replies readable. ]
>>>
>>> On Fri, Dec 29, 2023 at 04:01:27PM +0100, Konrad Dybcio wrote:
>>>> On 29.12.2023 15:04, Johan Hovold wrote:
>>>>> On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
>>>>>> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
>>>>>> AUX_CLK will be stuck at 'off'.
>>>>>
>>>>> No, this path is exercised on every boot without the aux clock ever
>>>>> being stuck at off. So something is clearly missing in this description.
>>>
>>>> That's likely because the hardware has been initialized and not cleanly
>>>> shut down by your bootloader. When you reset it, or your bootloader
>>>> wasn't so kind, you need to start initialization from scratch.
>>>
>>> What does that even mean? I'm telling you that this reset is asserted on
>>> each boot, on all sc8280xp platforms I have access to, and never have I
>>> seen the aux clk stuck at off.
>>>
>>> So clearly your claim above is too broad and the commit message is
>>> incorrect or incomplete.
>>
>> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
>> index 0b7801971dc1..6650bd6af5e3 100644
>> --- a/drivers/clk/qcom/gcc-sc8280xp.c
>> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
>> @@ -7566,6 +7566,18 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
>>         if (ret)
>>                 goto err_put_rpm;
>>  
>> +       int val;
>> +       regmap_read(regmap, 0xa0000, &val);
>> +       pr_err("GCC_PCIE_3A_BCR = 0x%x\n", val);
>> +       regmap_read(regmap, 0xa00f0, &val);
>> +       pr_err("GCC_PCIE_3A_LINK_DOWN_BCR = 0x%x\n", val);
>> +       regmap_read(regmap, 0xa00fc, &val);
>> +       pr_err("GCC_PCIE_3A_NOCSR_COM_PHY_BCR = 0x%x\n", val);
>> +       regmap_read(regmap, 0xa00e0, &val);
>> +       pr_err("GCC_PCIE_3A_PHY_BCR = 0x%x\n", val);
>> +       regmap_read(regmap, 0xa00e4, &val);
>> +       pr_err("GCC_PCIE_3A_PHY_NOCSR_COM_PHY_BCR = 0x%x\n", val);
>> +
>>         pm_runtime_put(&pdev->dev);
>>  
>>         return 0;
>>
>>
>> [root@sc8280xp-crd ~]# dmesg | grep BCR
>> [    2.500245] GCC_PCIE_3A_BCR = 0x0
>> [    2.500250] GCC_PCIE_3A_LINK_DOWN_BCR = 0x0
>> [    2.500253] GCC_PCIE_3A_NOCSR_COM_PHY_BCR = 0x0
>> [    2.500255] GCC_PCIE_3A_PHY_BCR = 0x0
>> [    2.500257] GCC_PCIE_3A_PHY_NOCSR_COM_PHY_BCR = 0x0
>>
>>
>> 0 meaning "not asserted".
> 
> We're clearly talking past each other. When I'm saying reset is asserted
> on each boot, I'm referring to reset being asserted in
> qcom_pcie_init_2_7_0(), whereas you appear to be referring to whether
> the reset has been left asserted by the bootloader when the driver
> probes.

OK, "boot" meant "booting the device" to me, not the PCIe controller.

> 
> I understand what you meant to say now, but I think you should rephrase:
> 
> 	At least on SC8280XP, if the PCIe reset is asserted, the
> 	corresponding AUX_CLK will be stuck at 'off'.
> 
> because as it stands, it sounds like the problem happens when the driver
> asserts reset.

Does this sound good?

"At least on SC8280XP, trying to enable the AUX_CLK associated with
a PCIe host fails if the corresponding PCIe reset is asserted."

> 
>> PCIE3A is used for WLAN on the CRD, btw.
> 
> You meant to say WWAN (modem).

Right :)

> 
>>>>>> Assert the reset (which may end up being a NOP if it was previously
>>>>>> asserted) and de-assert it back *before* turning on the clocks to avoid
>>>>>> such cases.
>>>>>>
>>>>>> In addition to that, in case the clock bulk enable fails, assert the
>>>>>> RC reset back, as the hardware is in an unknown state at best.
>>>>>
>>>>> This is arguably a separate change, and not necessarily one that is
>>>>> correct either
>>>
>>>> If the clock enable fails, the PCIe hw is not in reset state, ergo it
>>>> may be doing "something", and that "something" would eat non-zero power.
>>>> It's just cleaning up after yourself.
>>>
>>> How can it do something without power and clocks?
>>
>> Fair point.
>>
>> As far as power goes, the RC hangs off CX, which is on whenever the
>> system is not in power collapse. As for clocks, at least parts of it
>> use the crystal oscillator, not sure if directly.
>>
>>> And leaving reset
>>> asserted for non-powered devices is generally not a good idea.
>>
>> Depends on the hw.
> 
> That's why I said "generally".

I'll try to get a proper answer for this, or otherwise see if there's
any change in power draw / functionality.

Konrad

