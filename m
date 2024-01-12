Return-Path: <linux-pci+bounces-2082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B082BC5C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 09:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1247D1F25C13
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883D85D8EA;
	Fri, 12 Jan 2024 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIzYeLBF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27EB468C
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3376ead25e1so4118507f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 00:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705048167; x=1705652967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzSBMcH9OV38tGE26hwdykcph14F12FzWZt67w15gGA=;
        b=QIzYeLBFr1Z2YhvUAjOFcfs1vHuJC85UwMAyKvH92LeEjiUSP4vk4QE2+d83wN1p6f
         NrLfdg2ic/i1iJZqF1Cfn1ef+9ecmTe6oZJFJdfKzV2bXC58ZPzAEQ+7Gpkh+yikxUjW
         CGlH+CqSBClqGBA4NNfNpSecJlL0rh5VRr6YK7C+vMkhO0QLTCaUCERr8im6UN9Sb74C
         Ton0svIQyOQ5FCQvaoguP3c6djxE9zlubFoggcHbl/iHp2EGrhJ54UgnzeaTbEOe3Eh+
         YdhzZf2QAkmT6Rm4EldX1+IewKB40ScazcaGk9uXIzhd05ZVjXhFJqjk7BOHJSiAhR7z
         O4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705048167; x=1705652967;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzSBMcH9OV38tGE26hwdykcph14F12FzWZt67w15gGA=;
        b=nU/uj7wSbelpxwIBuAlew6kK4bIuxIpwb3I3PF1zaL0fQ7i7ljPUCq+0tnKegBXlln
         UfJeFyRmAtBCKPhu76sWlyHhiRp+i/XZzfpLyeFt9JiPnRXvtRPVFh3Y+6xVW4/D150J
         xCQ/pkzzU25qweTm4/7YHrRcN/BvufevPCB8s+mm1UsuMUKJtCtvSjVMt9ZcMj1Cihfy
         5qFHLYVuFlhY6+CNfbZ9K4j0CINFSra6CcvZUVsEwr7C9m32m2cnvRqdYZETzxJi/gBq
         bttSY89JMje+v4JkUuFPdiBngZcO3R9lP2n1FDKFlUmSyHUvI7rCsjMXVg4+dKKiShNa
         UZfg==
X-Gm-Message-State: AOJu0YzGK0wCXYx2wrrR1IkLju/HrF436zJ5SS6QAM0Q0rmZH7ObW4tN
	OZJoM/cAaNXnixR4UjoNVpLsPm8avw1c8Q==
X-Google-Smtp-Source: AGHT+IGNVOmMTkXQmLG65ejTgWdYNJLQ6LXgvuBftvdyvWhyCCS9fO8Cuw/eItmzvQaQj5t9Ahi+Vg==
X-Received: by 2002:a05:600c:1e17:b0:40d:5bbf:71f2 with SMTP id ay23-20020a05600c1e1700b0040d5bbf71f2mr583829wmb.5.1705048167162;
        Fri, 12 Jan 2024 00:29:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b0040e555f12d8sm8765004wmq.8.2024.01.12.00.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 00:29:26 -0800 (PST)
Message-ID: <ba10b5dd-d9c0-46e1-b868-8c9f19a470d7@linaro.org>
Date: Fri, 12 Jan 2024 09:29:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal for QCOM PCIe switch power and configuration driver
Content-Language: en-US
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
 quic_skananth@quicinc.com, bartosz.golaszewski@linaro.org,
 open list <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM"
 <linux-arm-msm@vger.kernel.org>, p.zabel@pengutronix.de,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" <linux-pci@vger.kernel.org>
References: <413d612f-0e31-6281-64e3-6484b85afe06@quicinc.com>
 <036823ce-9815-4884-aa3a-9c3831cea9bb@linaro.org>
 <f4805d04-9514-6a41-b39e-aa8a4577ce90@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f4805d04-9514-6a41-b39e-aa8a4577ce90@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2024 05:16, Krishna Chaitanya Chundru wrote:
> ++CC   Philipp Zabel ( reset controller maintainer)  & Bjorn & PCI list 
> from PCIe subsytem.
> 
> On 1/11/2024 11:20 PM, Krzysztof Kozlowski wrote:
>> On 11/01/2024 18:38, Krishna Chaitanya Chundru wrote:
>>> Hi DT maintainers,
>>>
>>> We are trying to upstream the QCOM PCIe switch which has I2C interface
>>> to configure the switch.
>>>
>>> In generic a PCIe switch is a device that allows expansion of PCI
>>> Express hierarchy, which allows more devices(PCIe endpoints) to be
>>> connected to a single PCIe port.
>>>
>>> We need to configure the QCOM switch like L0s, L1ss entry times, Tx
>>> amplitudes etc.. through I2C interface before PCIe link is established
>>> as these settings can affect link stability if we don't configure them.
>>>
>>> Once PCIe switch is configured, PCIe link between the PCIe switch and
>>> PCIe port connected should be established by the QCOM PCIe controller
>>> driver to enumerate the PCIe endpoints connected to the PCIe switch.
>>>
>>> We had a QCOM switch driver which powers on the switch and do the I2C
>>> configurations.
>>>
>>> This is how the flow goes.
>>> -->Power on the switch
>>>       -->Do Switch configuration (over i2c) with qcom switch driver
>>>           -->PCIe link training and enumeration.
>>
>> And where is the PCI controller in this? Why isn't this represented like
>> I2C or GPIO expander? You need to describe what exactly the switch is doing.
>>
> The PCIe link training and enumeration is handled by PCIe controller driver.
> Usually a single endpoint will be connected to PCIe port, using a switch
> we can connect multiple endpoints like WLAN, NVME, PCIe to ethernet
> bridge etc. So in single instance of PCIe multiple endpoints are
> connected and enumerated.
> Like I2C or GPIO expander we don't want to configure any endpoints, here
> we are trying to solve the initialization part of the switch power to
> the switch and configuration of the switch before PCIe controller starts
> link training and enumeration.

Post your datasheet or at least send some diagrams describing
everything, so I won't have to keep guessing.

> 
>> Also, how about using existing solutions? Aren't there any? I am not
>> going to look for them for you...
>>
> As of I know we don't have any solutions exiting now, we are trying to
> explore different ways for it.

So did you look it up? How much? If I find one, in the drivers, what
then? Can you look for it first?

>> Anyway, you should ask (means Cc) reset controller maintainers if they
>> are happy for such usage of reset framework for something not being a
>> reset. For similar reasons you should Cc PCI maintainers. If you ask me,
>> then no, PCI switch does not look like reset line so, you should not use
>> reset lines.
>>
> I added both maintainers now. sorry for the miss.
> We want to use reset line because I2c driver has to power on the device
> and configure the switch only before PCIe controller driver probes.

Let's don't repeat the style of discussion we have with Luo Jie, where I
say this is not reset and you say "but we want" and use some ridiculous
argument.

> This is how reset controller operates(correct me if I was wrong).

I talk about bindings. Otherwise why would you Cc me? Just because
something has power it is a reset? No, it is not. You said about
configuring lines: reset does not do this.
I am really tired of such discussions after last time. Getting
half-baked answers from you, incomplete pictures and something just to
respond to my question without providing anything valuable, because you
do not want to disclose too much. I got really disappointed last time
and this will affect further submissions from you. That's how reputation
works, sorry.

Just because it controls power, among many other things, does not mean
it is a reset. Maybe it is a phy? Or a mux? How do I know? Do you expect
me to guess?

Best regards,
Krzysztof


