Return-Path: <linux-pci+bounces-1623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99164822CBF
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 13:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FAF1F23F1E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 12:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069118EB6;
	Wed,  3 Jan 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ld+M1dXX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8D18EA7
	for <linux-pci@vger.kernel.org>; Wed,  3 Jan 2024 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e80d40a41so8168714e87.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Jan 2024 04:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704283875; x=1704888675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdQroxQMY0CAUOnPN6Lq2UpzoiJXdM4zW7jMQqGjKoE=;
        b=Ld+M1dXXwqU3eUMoG9Ozy3h4+qXPYbc7wNV0+VT+ASNVL65jb4oNTsmaV+xNgTooTT
         RHuVacO09sxC1NOLGwH7MtCzsM6hMmyGAv9bgYRC4mZnc+iz5fbnUvKUCNwNPGd8ko5L
         8NY46TVOPZWaGJI3FTM3yfRmmebliZVP4T8EsRkfW0WFx181Ao544Zy24z1CPFwpCdRo
         sXyJvPXYb4MT+47rEmhpefFi4/NmziL7lJoBGDhTXbLRSPtFoS7GGd1cJO/2qzmCaJBZ
         udIuYjfex0K7Z6y3bSTdICEMyBw/r7tFNQC9qRJI/udtfHSwpxC0FwP9VCuYa+1m28BA
         iTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283875; x=1704888675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdQroxQMY0CAUOnPN6Lq2UpzoiJXdM4zW7jMQqGjKoE=;
        b=bszlzZE+bqc3ZMiDrguFd19qDyUlTPbO+INq/YD77DMLfCDzbqxC6jy+fwTIDynxlc
         XioZaCSV03a/kZFo3OMBaKcSmjJYa/EaD7xFC7cjtlg7PkPCO1IDQUumWTA6oyzGLL3T
         qIIE+tstCNsd0uCwxYFQJjyOXK5Mn9iQzEYakfCd3ME7cOEG4/P5eNJtObIetN9OeJfo
         r65ERUms5ODN5NWhq34WefWxukdd6r3SNirxJfkv1tCy5DciCLTeb/QWxJT/cd6OpmFJ
         NnW3hyJc6oPjddYd6DN1hBcE6Mw+HhQbsJnUHc3zZkR8LOUgGChPoiHB83R42vXRHkse
         yEYQ==
X-Gm-Message-State: AOJu0Yzu0Ay0naFPKGeXf75X4HK88jzXjnp+TqIOOe1zwmBJa3Ffy6zL
	MIjso8zD9MuuGQa6ZyGpvwGxp3xldoZb8A==
X-Google-Smtp-Source: AGHT+IEJSmiIDd0Av6b4r0cslbTQQe+UZVinCqcUaPpwIlxKD7Xx0P4Jnagz+XySJEieo1EnbH/LGg==
X-Received: by 2002:ac2:4433:0:b0:50e:a6f8:aacf with SMTP id w19-20020ac24433000000b0050ea6f8aacfmr374443lfl.14.1704283875144;
        Wed, 03 Jan 2024 04:11:15 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id xo3-20020a170907bb8300b00a2534aebc21sm12620285ejc.40.2024.01.03.04.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 04:11:14 -0800 (PST)
Message-ID: <bd75f372-8ffe-415f-9464-3b78fd92e3f9@linaro.org>
Date: Wed, 3 Jan 2024 13:11:12 +0100
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
 <07b20408-4b45-48c3-9356-730a7a827743@linaro.org>
 <ZZU5jqJ14HscR1Ed@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZZU5jqJ14HscR1Ed@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3.01.2024 11:40, Johan Hovold wrote:
> On Tue, Jan 02, 2024 at 06:03:36PM +0100, Konrad Dybcio wrote:
>> On 2.01.2024 11:17, Johan Hovold wrote:
>>> On Sat, Dec 30, 2023 at 02:16:18AM +0100, Konrad Dybcio wrote:
>>>> On 29.12.2023 16:29, Johan Hovold wrote:
>>>>> On Fri, Dec 29, 2023 at 04:01:27PM +0100, Konrad Dybcio wrote:
>>>>>> On 29.12.2023 15:04, Johan Hovold wrote:
>>>>>>> On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
>>>>>>>> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
>>>>>>>> AUX_CLK will be stuck at 'off'.
>>>>>>>
>>>>>>> No, this path is exercised on every boot without the aux clock ever
>>>>>>> being stuck at off. So something is clearly missing in this description.
>>>>>
>>>>>> That's likely because the hardware has been initialized and not cleanly
>>>>>> shut down by your bootloader. When you reset it, or your bootloader
>>>>>> wasn't so kind, you need to start initialization from scratch.
>>>>>
>>>>> What does that even mean? I'm telling you that this reset is asserted on
>>>>> each boot, on all sc8280xp platforms I have access to, and never have I
>>>>> seen the aux clk stuck at off.
>>>>>
>>>>> So clearly your claim above is too broad and the commit message is
>>>>> incorrect or incomplete.
> 
>>> We're clearly talking past each other. When I'm saying reset is asserted
>>> on each boot, I'm referring to reset being asserted in
>>> qcom_pcie_init_2_7_0(), whereas you appear to be referring to whether
>>> the reset has been left asserted by the bootloader when the driver
>>> probes.
>>
>> OK, "boot" meant "booting the device" to me, not the PCIe controller.
> 
> Still not getting across to you apparently.
> 
> Again, the code in question is exercised on every boot and not once have
> I seen a stuck clock due to reset being asserted *in*
> qcom_pcie_init_2_7_0().
> 
> Now that's not what you were trying to describe as you were thinking of
> reset having been left asserted *before* the driver probes (or before
> qcom_pcie_init_2_7_0() is called).
> 
> See? Do you understand now what I was trying to say and why my
> misinterpretation of your terse commit message lead me to claim that it
> was clearly false?

No, my response was an acknowledgement of having understood you. Maybe
it's a direct translation of some Polish idiom that's not obvious to
others, but I definitely tried to say that "we were talking about
different things, I had been previously thinking of something else,
but now we're on the same page".


> 
>>> I understand what you meant to say now, but I think you should rephrase:
>>>
>>> 	At least on SC8280XP, if the PCIe reset is asserted, the
>>> 	corresponding AUX_CLK will be stuck at 'off'.
>>>
>>> because as it stands, it sounds like the problem happens when the driver
>>> asserts reset.
>>
>> Does this sound good?
>>
>> "At least on SC8280XP, trying to enable the AUX_CLK associated with
>> a PCIe host fails if the corresponding PCIe reset is asserted."
> 
> Yes, but you need to also say something about how this would happen, for
> example, your hypothetical bootloader leaving it asserted and your actual
> motivation for this change which is that it appears to be needed after
> suspend. 
> 
> A commit message should be clear and self-contained and not force
> reviewers to have to try to interpret what it means and guess what the
> motivation for the change really is.

Got it

Konrad

