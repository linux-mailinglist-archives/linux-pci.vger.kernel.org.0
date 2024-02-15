Return-Path: <linux-pci+bounces-3538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FEF856D25
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627EAB2648E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 18:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BA13849B;
	Thu, 15 Feb 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WG5tRvTJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBA1369AC
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022675; cv=none; b=LiCU0YwkbEGs9Edj/kfqVXr+tcl830W2L/5Vw7vJYdOG5LZIOvxD3U4E8/qFC1kZONOBQu4D7rAhLRMiJAnYFI1I+YA6FUdQAvxfg5GwaJR1kvCTg602SKeefSgQYHxxAbIgRBoUykguuEGW3BvV7e67GnFF560fdmqdir4RJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022675; c=relaxed/simple;
	bh=Ov3h6NmCfWVCrQRPZcBAGDu7dD9jbUeBaBXLPNApxYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFwxcqcQQ+U/khDmq6Kju/pT4gWxBJtmfDCtoXX7tkgjU3aBJX/OPNTx+xTqFlIwac+h+jEy/ao8EQoZCxviMv/HORHomLL+zPabusPH431a2zu+KscishsE5FVuXk1EmJNUkK8CqjCQ3ZewQ6CD4czg+SrNuT3XQ5p9ceder+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WG5tRvTJ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d10d2da73dso16169431fa.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 10:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708022671; x=1708627471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1q2t5THAXaIQHLTF3wmnuNYqSVcOhZJZA6IWBoe7FA=;
        b=WG5tRvTJ1rdHfIHXlYPaO0CM7ZXYcZCypeRc6bGXR/Zs23BLfe/Slp5NPYbVR0/UMc
         CN/nKy5+yZlhAoFrBZVY616VDSdy3FGGcTjODyZWg6JKpw+Q2FMfpxW+zBkX1B/+x0Kl
         J2Q68R0xsy9p7EesHzQM1fszC447pm1rTAyXEcVqQqCqeC0Z+ZG9csY/BY2LR4CH4CAF
         gEo1uKOVSxwMW3yGF1F4dYD3IVf6vJVOa7gRsLGkC1nz+29/HsxsO3sqVsgptWbmFEDx
         NdaHnr0vL9SOc6Whe922s6fXDm8wUUV0u/re/fBQiX3Nn+Z/Q8SdxOK7rREgf+7eAKQ/
         LIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022671; x=1708627471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1q2t5THAXaIQHLTF3wmnuNYqSVcOhZJZA6IWBoe7FA=;
        b=KXEg+LsoKxC1HIzpzZy+LO31mYvpXbBhezXMUDdkhFrgFi/Wl8GDnfrQfnsnVumM+Z
         BT1BL5yhtoXZhrZqPQBkfh4Qgo2OI8bAFVll+5ttynZ9o6fknfZbKyNKDe/kYNKaOdQX
         tl3EyvYBObbKhs9u9EYat3jhJ37bdD24Lm1oKMogEaVrWkvi0x3d9Mu9xVw0vHd/dtXe
         25Sg7Wq84Q+50a3AEHYwbIWyDSEJ49509knGOw4jQzc+8dYfkS286M+X/fflOIMol5LU
         3YaHqt2NExph4YZCEB3fbYNBmZEm7w3R3q0Xto055WZKjetV0xN/MYHFVgnkjx+7brgp
         hmUA==
X-Forwarded-Encrypted: i=1; AJvYcCUBh0dilu0HEmGV2WX1/a4p+1gZ5ATz31VCnkXRYGb5/01RijIl5RhcCjrwGF4IewiWWMPWhJEl4E1XAa+S8U2JOHZEz68/81AB
X-Gm-Message-State: AOJu0YxvLIjAl5U5R+peGQ0FcgCTl++k0oSfsxJ+wF8IBhooZk/IckBj
	V38aWCtNFEtow5XKz7gWOtLJ9/YSydz8THwFIKPgp/XA4q5OlDTIMu+3BH6PLO0=
X-Google-Smtp-Source: AGHT+IHBrUEPEGVeK0vtIcVNlx2ltmsJu5vHeHHZz0wFy9l8DbCDpMTbmDuhROJn4UpG+ml/N/UStA==
X-Received: by 2002:a2e:a483:0:b0:2d1:33a:6c85 with SMTP id h3-20020a2ea483000000b002d1033a6c85mr1959604lji.8.1708022671457;
        Thu, 15 Feb 2024 10:44:31 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e9d14000000b002d0b4fdf3a2sm383976lji.46.2024.02.15.10.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 10:44:30 -0800 (PST)
Message-ID: <bc7d9859-f7ec-41c5-8a9e-170ccdfff46a@linaro.org>
Date: Thu, 15 Feb 2024 19:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240215161114.GA1292081@bhelgaas>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240215161114.GA1292081@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 17:11, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 11:21:45AM +0100, Konrad Dybcio wrote:
>> On 14.02.2024 23:28, Bjorn Helgaas wrote:
>>> On Wed, Feb 14, 2024 at 10:35:16PM +0100, Konrad Dybcio wrote:
>>>> On 12.02.2024 22:17, Bjorn Helgaas wrote:
>>>>> Maybe include the reason in the subject?  "Read back" is literally
>>>>> what the diff says.
>>>>>
>>>>> On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
>>>>>> To ensure write completion, read the PARF_LTSSM register after setting
>>>>>> the LTSSM enable bit before polling for "link up".
>>>>>
>>>>> The write will obviously complete *some* time; I assume the point is
>>>>> that it's important for it to complete before some other event, and it
>>>>> would be nice to know why that's important.
>>>>
>>>> Right, that's very much meaningful on non-total-store-ordering
>>>> architectures, like arm64, where the CPU receives a store instruction,
>>>> but that does not necessarily impact the memory/MMIO state immediately.
>>>
>>> I was hinting that maybe we could say what the other event is, or what
>>> problem this solves?  E.g., maybe it's as simple as "there's no point
>>> in polling for link up until after the PARF_LTSSM store completes."
>>>
>>> But while the read of PARF_LTSSM might reduce the number of "is the
>>> link up" polls, it probably wouldn't speed anything up otherwise, so I
>>> suspect there's an actual functional reason for this patch, and that's
>>> what I'm getting at.
>>
>> So, the register containing the "enable switch" (PARF_LTSSM) can (due
>> to the armv8 memory model) be "written" but not "change the value of
>> memory/mmio from the perspective of other (non-CPU) memory-readers
>> (such as the MMIO-mapped PCI controller itself)".
>>
>> In that case, the CPU will happily continue calling qcom_pcie_link_up()
>> in a loop, waiting for the PCIe controller to bring the link up, however
>> the PCIE controller may have never received the PARF_LTSSM "enable link"
>> write by the time we decide to time out on checking the link status.
>>
>> It may also never happen for you, but that's exactly like a classic race
>> condition, where it may simply not manifest due to the code around the
>> problematic lines hiding it. It may also only manifest on certain CPU
>> cores that try to be smarter than you and keep reordering/delaying
>> instructions if they don't seem immediately necessary.
> 
> Does this mean the register is mapped incorrectly, e.g., I see arm64
> has many different kinds of mappings for cacheability,
> write-buffering, etc?

No, it's correctly mapped as "device" memory, but even that gives no
guarantees about when the writes are "flushed" out of the CPU/cluster

> 
> Or, if it is already mapped correctly, are we confident that none of
> the *other* register writes need similar treatment?  Is there a rule
> we can apply to know when the read-after-write is needed?

Generally, it's a good idea to add such readbacks after all timing-
critical writes, especially when they concern asserting reset,
enabling/disabling power, etc., to make sure we're not assuming the
hardware state of a peripheral has changed before we ask it to do so. 

Konrad

