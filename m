Return-Path: <linux-pci+bounces-1562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E4820335
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 02:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74172824E6
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F1D63A;
	Sat, 30 Dec 2023 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPPnWcyQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111380C
	for <linux-pci@vger.kernel.org>; Sat, 30 Dec 2023 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26fa294e56so398213666b.0
        for <linux-pci@vger.kernel.org>; Fri, 29 Dec 2023 17:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703898987; x=1704503787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcIe4YJ5YCTQdS+tf3+D0wVuBPwXDmW3xk764/9wSSI=;
        b=rPPnWcyQNJb6GYO6NY79RTsOAvALwsO8VbpAjyRia2vurXSev+fSLfYLSEjfpcV+F1
         mzYzYyKjyWlhdMqwXSzx1TGwOKlUAr74Hs36YH2iR4QfEyYMd//gntOcJrCKIa7sq5ri
         Xqc8iiKMkkq8SCrY4xkrButWEPusB0DLEYoDeNjeeKJOA9WmtUO8T+oUagrSlGapJLrQ
         D25sNMJH2+89IdR8H6oxuufHEz2Gbcm2wIbOGoK5wT2qKgMlK0EMTtL24CzEwLvFvUJL
         YSuAoeg50cZKpzhCoyVxLW8nwjIbnXtgtb0JXmjDLDMy62NgVKbwXOACSqA1JyPeh39b
         eMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703898987; x=1704503787;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcIe4YJ5YCTQdS+tf3+D0wVuBPwXDmW3xk764/9wSSI=;
        b=ebCy8wupBq0aTy0MXsEYmIPGGUrVVzWZRbK/V8roDdPJbxuirL1ETVJdik6RMcmwVn
         4BVEt7LOojHM7P3yVzte1eDuoTPGgA5vm/6oW4FLEhWYwPqMHhDkk3tbEmlfc+kliubR
         mp3PKdIcGeI40wdLF+7lui+vak48RlPbQp2q6MNSoYJ3aOdRkOy4gW6+QdYy2d7u804x
         N4VE1KFQiVlkKM5LOUNMZ7uE50zZKWc9SHn3VBctuUdLXUwofJYJBbJ7WsUqKFYGJnje
         y5kSgalrGwmeBryzBLv/aBA7F+39udSRtxDU68bo0OLamqGJ53RWwML5wNeNa2i3SAfS
         uXnQ==
X-Gm-Message-State: AOJu0YxZReXucniHkLkABvm1Gs1j+08SsSmcpa74wZI9OU+dl2SR8kQp
	cTaVVcVfL9N5N6G35PxzoQ24EnmuyGvZug==
X-Google-Smtp-Source: AGHT+IHWXrAn3AaZSP5giRmCNTQGDxW9VBM1R4CeODgbmnJ1+Tim4Uq3twZVIGvJye2TZn/uE4d5Zw==
X-Received: by 2002:a17:906:cc12:b0:a17:d7ea:f59e with SMTP id ml18-20020a170906cc1200b00a17d7eaf59emr5811394ejb.48.1703898986762;
        Fri, 29 Dec 2023 17:16:26 -0800 (PST)
Received: from [192.168.199.125] ([178.235.179.36])
        by smtp.gmail.com with ESMTPSA id fp21-20020a1709069e1500b00a26ade46619sm8019163ejc.121.2023.12.29.17.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 17:16:26 -0800 (PST)
Message-ID: <598ede70-bc01-4137-b68b-981c3d420735@linaro.org>
Date: Sat, 30 Dec 2023 02:16:18 +0100
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
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZY7l828-mSGXVwrk@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.12.2023 16:29, Johan Hovold wrote:
> [ Again, please remember to add a newline before you inline comments to
> make you replies readable. ]
> 
> On Fri, Dec 29, 2023 at 04:01:27PM +0100, Konrad Dybcio wrote:
>> On 29.12.2023 15:04, Johan Hovold wrote:
>>> On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
>>>> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
>>>> AUX_CLK will be stuck at 'off'.
>>>
>>> No, this path is exercised on every boot without the aux clock ever
>>> being stuck at off. So something is clearly missing in this description.
> 
>> That's likely because the hardware has been initialized and not cleanly
>> shut down by your bootloader. When you reset it, or your bootloader
>> wasn't so kind, you need to start initialization from scratch.
> 
> What does that even mean? I'm telling you that this reset is asserted on
> each boot, on all sc8280xp platforms I have access to, and never have I
> seen the aux clk stuck at off.
> 
> So clearly your claim above is too broad and the commit message is
> incorrect or incomplete.

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 0b7801971dc1..6650bd6af5e3 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7566,6 +7566,18 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
        if (ret)
                goto err_put_rpm;
 
+       int val;
+       regmap_read(regmap, 0xa0000, &val);
+       pr_err("GCC_PCIE_3A_BCR = 0x%x\n", val);
+       regmap_read(regmap, 0xa00f0, &val);
+       pr_err("GCC_PCIE_3A_LINK_DOWN_BCR = 0x%x\n", val);
+       regmap_read(regmap, 0xa00fc, &val);
+       pr_err("GCC_PCIE_3A_NOCSR_COM_PHY_BCR = 0x%x\n", val);
+       regmap_read(regmap, 0xa00e0, &val);
+       pr_err("GCC_PCIE_3A_PHY_BCR = 0x%x\n", val);
+       regmap_read(regmap, 0xa00e4, &val);
+       pr_err("GCC_PCIE_3A_PHY_NOCSR_COM_PHY_BCR = 0x%x\n", val);
+
        pm_runtime_put(&pdev->dev);
 
        return 0;


[root@sc8280xp-crd ~]# dmesg | grep BCR
[    2.500245] GCC_PCIE_3A_BCR = 0x0
[    2.500250] GCC_PCIE_3A_LINK_DOWN_BCR = 0x0
[    2.500253] GCC_PCIE_3A_NOCSR_COM_PHY_BCR = 0x0
[    2.500255] GCC_PCIE_3A_PHY_BCR = 0x0
[    2.500257] GCC_PCIE_3A_PHY_NOCSR_COM_PHY_BCR = 0x0


0 meaning "not asserted".

Adding the read in the GCC driver .probe ensures we get the
unmodified data, as all GCC consumers must wait for it to probe. 

PCIE3A is used for WLAN on the CRD, btw.

>  
>>>> Assert the reset (which may end up being a NOP if it was previously
>>>> asserted) and de-assert it back *before* turning on the clocks to avoid
>>>> such cases.
>>>>
>>>> In addition to that, in case the clock bulk enable fails, assert the
>>>> RC reset back, as the hardware is in an unknown state at best.
>>>
>>> This is arguably a separate change, and not necessarily one that is
>>> correct either
> 
>> If the clock enable fails, the PCIe hw is not in reset state, ergo it
>> may be doing "something", and that "something" would eat non-zero power.
>> It's just cleaning up after yourself.
> 
> How can it do something without power and clocks?

Fair point.

As far as power goes, the RC hangs off CX, which is on whenever the
system is not in power collapse. As for clocks, at least parts of it
use the crystal oscillator, not sure if directly.

> And leaving reset
> asserted for non-powered devices is generally not a good idea.

Depends on the hw.

>  
>>> so should at least go in a separate patch if it should
>>> be done at all.
> 
>> I'll grumpily comply..
> 
> I suggest you leave it deasserted unless you have documentation
> suggesting that the opposite is safe and recommended for this piece of
> hardware.
>  
>>>> Fixes: ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")
>>>
>>> I think you're being way to liberal with your use of Fixes tags. To
>>> claim that this is a bug, you need to make a more convincing case for
>>> why you think so.
> 
>> The first paragraph describes the issue that this patch fixes.
> 
> Yes, but this is all very hand-wavy so far. With a complete commit
> message I may agree, but you still haven't convinced me that this is a
> bug and not just a workaround from some not fully-understood issue on
> one particular platform.

Right, reading it again, it doesn't really tell the whole story.

>  
>>> Also note Qualcomm's vendor driver is similarly asserting reset after
>>> enabling the clocks.
> 
>> It's also not asserting the reset on suspend, see below.
> 
> Right, as I mentioned.
>  
>>> That driver does not seem to reset the controller on resume, though, in
>>> case that is relevant for your current experiments.
> 
>> I know, the vendor driver doesn't fully shut down the controller. This
>> is however the only sequence that we (partially) have upstream, and the
>> only one that is going to work on SC8280XP (due to hw design).
>>
>> On other platforms, a "soft shutdown" (i.e. dropping the link, cutting
>> clocks but not fully resetting the RC state) should be possible, but
>> that's not what this patchset concerns.
> 
> The commit message does not even mention suspend, it just makes a
> clearly false general claim about a clock being stuck unless you reorder
> things.

No, I insist that this general statement, while indeed lacking a full
description of the problem, is provably true. The AUX clock will not
turn on if the PCIe reset is asserted, at least on SC8280XP.

Konrad

