Return-Path: <linux-pci+bounces-1551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC6820012
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 16:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6695284651
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406DF11CBD;
	Fri, 29 Dec 2023 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuDvjIx/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08211C8B
	for <linux-pci@vger.kernel.org>; Fri, 29 Dec 2023 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5555b8de81fso2488005a12.1
        for <linux-pci@vger.kernel.org>; Fri, 29 Dec 2023 07:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703862091; x=1704466891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJGAbTsJuV5c3Gk6VGVnHrcLGAJpmZfominI1jRqdbY=;
        b=cuDvjIx/AaPwCvtsVoX9cVFHQNjHNMs8TqNApLoK6NLIb8L1uBgsYnL1KXUMykvEqv
         9SQAu/YsY2PHRS3LJlHvc4KPTK/vwkuxCWSM9gnqxX9LBSN87lho+fJQP5ekRJXbNpJO
         ShFB2Js6fNiUif0a6nCZXsKF7fROLkNpaaqob1UfHSGgwUY94WWwRmYUl6bNrqwky/Hm
         RLbyIJfVYF8BqiAnfZDiQja/SblNTJqYCLJCvsIqiu0TaAmJQuDEIRn0aXVSjTP7mS/m
         M6Ji50QAlzE+YdHPWicHlmN3i8DMJOsNBKes7bg+QCzr8xUBfqUjgT233u+epHD/3RDq
         PaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703862091; x=1704466891;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJGAbTsJuV5c3Gk6VGVnHrcLGAJpmZfominI1jRqdbY=;
        b=JdRLINV+musrcp03/6Gt8lpDqmOG7/HO3Ip0ccgINtCsfB1NSgnzo9x+OIGHFOsPDH
         AMCpYvrqxCq+Q8Fnn9fYZWGXjrK9PWqCar9kVBj9AJRqJ3Zq4MOTP9ruI0t/06XEVZ1R
         Xbt9I3F1W3eK139miSOI9lCQHu2b2fB7uw/QwKY6osrGH0ZVvkp6DsFEG+TIvHuOIbkE
         J0gqKuaZ+0uzDCfgCIR1ylX1JZuAIe3QLfhZo5SCGDZ7KSaiX1o4spL4vLNe+sNZPQDt
         oPEFb5qZ/EVm81OTyl3b+b0u13c6sF5PXALFlSZzokKTidIaMf6wenPRA6ppX8/4OvB8
         UohQ==
X-Gm-Message-State: AOJu0Yz+oXBd2dgxSZV1x3pARj6pd+7Jsfme0SgJkdMXiP+J5XAD97uM
	WXA2LOW3xtDPfr3j0iFOov6xi7yxqPSRSA==
X-Google-Smtp-Source: AGHT+IEZeurjyRSu48qUdStUze94ZQxDBRD2FAfapU1QE4BtuFKUPN6p6ZaG2oLuMSrnqbkHNZqbfA==
X-Received: by 2002:a50:ccd9:0:b0:553:a5e5:78d8 with SMTP id b25-20020a50ccd9000000b00553a5e578d8mr8073190edj.26.1703862090577;
        Fri, 29 Dec 2023 07:01:30 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ek19-20020a056402371300b0055383eb043csm11193743edb.56.2023.12.29.07.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 07:01:30 -0800 (PST)
Message-ID: <fa0fbadc-a7c3-4bea-bed7-0006db0616dc@linaro.org>
Date: Fri, 29 Dec 2023 16:01:27 +0100
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
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZY7R581pgn3uO6kk@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.12.2023 15:04, Johan Hovold wrote:
> On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
>> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
>> AUX_CLK will be stuck at 'off'.
> 
> No, this path is exercised on every boot without the aux clock ever
> being stuck at off. So something is clearly missing in this description.
That's likely because the hardware has been initialized and not cleanly
shut down by your bootloader. When you reset it, or your bootloader
wasn't so kind, you need to start initialization from scratch.

>> Assert the reset (which may end up being a NOP if it was previously
>> asserted) and de-assert it back *before* turning on the clocks to avoid
>> such cases.
>>
>> In addition to that, in case the clock bulk enable fails, assert the
>> RC reset back, as the hardware is in an unknown state at best.
> 
> This is arguably a separate change, and not necessarily one that is
> correct either
If the clock enable fails, the PCIe hw is not in reset state, ergo it
may be doing "something", and that "something" would eat non-zero power.
It's just cleaning up after yourself.

> so should at least go in a separate patch if it should
> be done at all.
I'll grumpily comply..

>> Fixes: ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")
> 
> I think you're being way to liberal with your use of Fixes tags. To
> claim that this is a bug, you need to make a more convincing case for
> why you think so.
The first paragraph describes the issue that this patch fixes.

> Also note Qualcomm's vendor driver is similarly asserting reset after
> enabling the clocks.
It's also not asserting the reset on suspend, see below.

> That driver does not seem to reset the controller on resume, though, in
> case that is relevant for your current experiments.
I know, the vendor driver doesn't fully shut down the controller. This
is however the only sequence that we (partially) have upstream, and the
only one that is going to work on SC8280XP (due to hw design).

On other platforms, a "soft shutdown" (i.e. dropping the link, cutting
clocks but not fully resetting the RC state) should be possible, but
that's not what this patchset concerns.

Konrad

