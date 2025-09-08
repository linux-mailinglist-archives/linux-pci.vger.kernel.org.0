Return-Path: <linux-pci+bounces-35669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA86B48EC3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 15:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0123E3C0504
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ADC30ACED;
	Mon,  8 Sep 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Xpmn5v7a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0A30ACE8
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336817; cv=none; b=g3P0vfJqSua249cL8ywt/0C37Jdw+WCL5XCLCMPLuKK1FXCipdibGUZlBG6sRlOHLaMLAiOfW7jOy4jk/nZfpq/oDuk3mT6PCVT6vyDUyPqZX54H6HWQhSCwjw7Nz6MS5IwG2B1xr0u0uKQdGF2Y1dvIY8azJnmSFLtuorFIRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336817; c=relaxed/simple;
	bh=PLnJz39kDLECH+d7SpDM281bUAzO33U7yXlh+bairl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdhDsYvfeUQWTD8cBUDXfOiT1NYzR2kWPRmR7VzWGmkqLs7xYbQEzuosO4JdxOSOtmiBPlsI6mlGOqDXo5JyJ/Ye7KevD4hl5TZt9kPpAK4ldiceGsCcPzqgcutO6K6MhFjsDelVL537ICzJKyPkDZTttVJUoPq9ApjVvc/dvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Xpmn5v7a; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b047f28a83dso723477566b.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Sep 2025 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757336814; x=1757941614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfMVf6nBBryTF7E6UcdgModrpBMwN13bx9ZSeOrOTno=;
        b=Xpmn5v7aSwh54eqyw/7YY5mBNjXsKPgt3kxkxasj/VLkUyecHmlmOMB9D21SpLBm5L
         yhb+oYEzXpkSWbjM7ozz9zzjN6AA0io+VRo1l7zaSdJfVvSDUtsvplOlYLbJje1QcWFS
         qecTFfqA5W9KNSV+xvYVBF+AjH6BsNwF1lfbfLdBFPawKHEnrXPRSHKOAvX/L5jgEaYH
         udVyXbLxpDvgV3uKy8NjIJIQ5RtN48Y/fC4WwJETqyzdwIpCMJ+rFmRtYDtVU8R8CnIY
         6GcKUrTZDfkpOlIaFz8biHLvvc1F3fEgf7TKB/Mum+lDHb1lPcGNLe8CS8AN/qgreFul
         bqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336814; x=1757941614;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfMVf6nBBryTF7E6UcdgModrpBMwN13bx9ZSeOrOTno=;
        b=hyC23iEHOp834VPsMwiD4y6i7P2Txf+IoFunVzLiV7HM+hlHX+NLUPv93Ho4c+unnq
         5WnsjDWsldfR4ZH4tm7Wa65jTa331EGLz7TIVk9uv8SrW8t5TA17cCt1h5JmjUWtFVoU
         kPvwGLVuPewTwi7wYNnmXU9Uu2ot5n8/lnEMXU7LeRsz3iazjYI0QWxJCKK5DHgPbG3A
         AQI7TFCmXpozdX9b3tbDSWX34aIQXoKu2PR+QvaGCDHj+hlu8I2jXpxSQ/EtIEmUCCt3
         boRI2Q0LjKPFFKOmxiH8TCQkUjNqiB1htcgJRWZeAp68ZmThQ9za/esl2lkfF6JZc1lW
         5NAA==
X-Forwarded-Encrypted: i=1; AJvYcCXnTcDxyH1zpBXUdnOC0lozdMbfDnHAnGm+1ZAGZjhN5tK14GF6Iz3VzDDLjXrNeti91Yz2yb+DiM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx06d8wZssCJURP8+BmCEuiYfpA96eKwXsFvmZjQYYvmlsOB1Wn
	dFwtkSkiFvd8okrljJ2bs6MMBKjPxrVjb94soas9QDQTxIU09lnfvm2hHsKxLftwmW8=
X-Gm-Gg: ASbGncvWgL5BeQ4s33ILX/BN1F3ltvs/u2K9UCQWqSxw1e0lCFgf0fpfoR3T4qHO2To
	2fxekCClPVCj+PhCl9KaudW73fwpIrVuR4ze6QZFgMpjpVDGG0yaJVbvKieOdH+1VBMa67wT3dx
	RzU6Gz3I1qrMJ5ZJ81KZFgtM2YGcD7yM6uXYVv3WAgDR+bAfsnHZ6dDSsD5H3Y56QLwas/LNk8d
	D465XFcDN5NY3rYfT+OpjfAxpZ3Jrv2oZxcoQ77wlb4ePPlpIJsMPdvamoTqg0pFR0z1w2sCFpX
	sAtXmSAl5nuTuacRNtKakZryG+s7JnIdxz93Byo0XRHfxASVgDD1C1nPY8LqKjC/lNcX6/AYVxu
	XfzeUu1Hi1bmgEeHdVT6SX9AKETxWXDAzpgZW3ZudgaRy7UrnMW/r
X-Google-Smtp-Source: AGHT+IHNtIRcKMzfVe31q41uVJvIJUKXuFurzwJj/AutDBZPs44uojZLouOewThTolpsDraRQmap2Q==
X-Received: by 2002:a17:907:2d0c:b0:b04:a780:4673 with SMTP id a640c23a62f3a-b04b1663c1cmr806523566b.31.1757336813148;
        Mon, 08 Sep 2025 06:06:53 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0438102debsm1795871566b.66.2025.09.08.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:06:52 -0700 (PDT)
Message-ID: <742cf1ae-1723-4cf5-8931-afd35699cc95@tuxon.dev>
Date: Mon, 8 Sep 2025 16:06:50 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: Manivannan Sadhasivam <mani@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 lizhi.hou@amd.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-6-claudiu.beznea.uj@bp.renesas.com>
 <ddxayjj5wcuuish4kvyluzrujkes5seo7zlusmomyjfjcgzcyj@xe3zzzmy2zaj>
 <8ef466aa-b470-4dcb-9024-0a9c36eb9a6a@tuxon.dev>
 <zsgncwvhykw4ja3bbqaxwupppjsqq4pcrdgrsduahokmt72xsm@twekpse6uzzh>
 <CAMuHMdUu0uXBJndcwWoZp8NNyBJox5dZw4aoB8Ex50vBDDtP7g@mail.gmail.com>
 <6f2hpdkonomgrfzqoupcex2rpqtlhql4lmsqm7hqk25qakp7ax@bfrzflghmnev>
 <CAMuHMdUEqKc+qtRXiPzgjhWaer5KLroZ+hCSVLCQ497h3BtOAw@mail.gmail.com>
 <vdn4lomtgr6htab7uodgm75iphju6yyimhlnfonysxxdpudib7@qm4yettsvsrs>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <vdn4lomtgr6htab7uodgm75iphju6yyimhlnfonysxxdpudib7@qm4yettsvsrs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Manivannan,

On 9/1/25 18:54, Manivannan Sadhasivam wrote:
> On Mon, Sep 01, 2025 at 04:22:16PM GMT, Geert Uytterhoeven wrote:
>> Hi Mani,
>>
>> On Mon, 1 Sept 2025 at 16:04, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>> On Mon, Sep 01, 2025 at 11:25:30AM GMT, Geert Uytterhoeven wrote:
>>>> On Sun, 31 Aug 2025 at 06:07, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>>>> On Sat, Aug 30, 2025 at 02:22:45PM GMT, Claudiu Beznea wrote:
>>>>>> On 30.08.2025 09:59, Manivannan Sadhasivam wrote:
>>>>>>> On Fri, Jul 04, 2025 at 07:14:05PM GMT, Claudiu wrote:
>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>
>>>>>>>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>>>>>>>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>>>>>>>> only as a root complex, with a single-lane (x1) configuration. The
>>>>>>>> controller includes Type 1 configuration registers, as well as IP
>>>>>>>> specific registers (called AXI registers) required for various adjustments.
>>>>>>>>
>>>>>>>> Hardware manual can be downloaded from the address in the "Link" section.
>>>>>>>> The following steps should be followed to access the manual:
>>>>>>>> 1/ Click the "User Manual" button
>>>>>>>> 2/ Click "Confirm"; this will start downloading an archive
>>>>>>>> 3/ Open the downloaded archive
>>>>>>>> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
>>>>>>>> 5/ Open the file r01uh1014ej*-rzg3s.pdf
>>>>>>>>
>>>>>>>> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
>>>>>>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>>>>>> +  ret = pm_runtime_resume_and_get(dev);
>>>>>>>> +  if (ret)
>>>>>>>> +          return ret;
>>>>>>>> +
>>>>>>>
>>>>>>> Do you really need to do resume_and_get()? If not, you should do:
>>>>>>
>>>>>> It it's needed to enable the clock PM domain the device is part of.
>>>>>>
>>>>>
>>>>> I've replied below.
>>>>>
>>>>>>>
>>>>>>>     pm_runtime_set_active()
>>>>>>>     pm_runtime_no_callbacks()
>>>>>>>     devm_pm_runtime_enable()
>>>>
>>>>>>>> +static int rzg3s_pcie_suspend_noirq(struct device *dev)
>>>>>>>> +{
>>>>>>>> +  struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
>>>>>>>> +  const struct rzg3s_pcie_soc_data *data = host->data;
>>>>>>>> +  struct regmap *sysc = host->sysc;
>>>>>>>> +  int ret;
>>>>>>>> +
>>>>>>>> +  ret = pm_runtime_put_sync(dev);
>>>>>>>> +  if (ret)
>>>>>>>> +          return ret;
>>>>>>>
>>>>>>> Since there are no runtime callbacks present, managing runtime PM in the driver
>>>>>>> makes no sense.
>>>>>>
>>>>>> The PCIe device is part of a clock power domain. Dropping
>>>>>> pm_runtime_enable()/pm_runtime_put_sync() in this driver will lead to this
>>>>>> IP failing to work as its clocks will not be enabled/disabled. If you don't
>>>>>> like the pm_runtime_* approach that could be replaced with:
>>>>>>
>>>>>> devm_clk_get_enabled() in probe and clk_disable()/clk_enable() on
>>>>>> suspend/resume. W/o clocks the IP can't work.
>>>>>
>>>>> Yes, you should explicitly handle clocks in the driver. Runtime PM makes sense
>>>>> if you have a power domain attached to the IP, which you also do as I see now.
>>>>> So to conclude, you should enable/disable the clocks explicitly for managing
>>>>> clocks and use runtime PM APIs for managing the power domain associated with
>>>>> clock controller.
>>>>
>>>> Why? For the past decade, we've been trying to get rid of explicit
>>>> module clock handling for all devices that are always part of a
>>>> clock domain.
>>>>
>>>> The Linux PM Domain abstraction is meant for both power and clock
>>>> domains.  This is especially useful when a device is present on multiple
>>>> SoCs, on some also part of a power domain,  and the number of module
>>>> clocks that needs to be enabled for it to function is not the same on
>>>> all SoCs.  In such cases, the PM Domain abstraction takes care of many
>>>> of the integration-specific differences.
>>>
>>> Hmm, my understanding was that we need to explicitly handle clocks from the
>>> consumer drivers. But that maybe because, the client drivers I've dealt with
>>> requires configuring the clocks (like setting the rate, re-parenting etc...) on
>>> their own. But if there is no such requirement, then I guess it is OK to rely on
>>> the PM core and clock controller drivers.
>>
>> When you need to know the actual clock rate, or change it, you
>> indeed have to handle the clock explicitly.  But it still may be enabled
>> automatically through the clock domain.
>>
> 
> Yeah!
> 
>>>>> But please add a comment above pm_runtime_resume_and_get() to make it clear as
>>>>> most of the controller drivers are calling it for no reason.
>>>>
>>>> Note that any child device that uses Runtime PM depends on all
>>>> its parents in the hierarchy to call pm_runtime_enable() and
>>>> pm_runtime_resume_and_get().
>>>
>>> Two things to note from your statement:
>>>
>>> 1. 'child device that uses runtime PM' - Not all child drivers are doing
>>> runtime PM on their own. So there is no need to do pm_runtime_resume_and_get()
>>> unless they depend on the parent for resource enablement as below.
>>
>> It indeed depends on the child device, and on the bus.  For e.g. an
>> Ethernet controller connected to a simple SoC expansion bus, the bus must
>> be powered and clock, which is what "simple-pm-bus" takes care of
>> ("simple-bus" does not).
>>
> 
> Right. But most of the PCI controller drivers call pm_runtime_resume_and_get()
> for no good reasons. They might have just copied the code from a driver that did
> it on purpose. So I tend to scrutinize these calls whenever they get added for a
> driver.

To be sure I will prepare the next version with something that was
requested: are you OK with keeping pm_runtime_resume_and_get() and add a
comment for it?

Thank you,
Claudiu


