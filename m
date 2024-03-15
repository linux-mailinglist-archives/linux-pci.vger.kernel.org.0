Return-Path: <linux-pci+bounces-4849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E587CB3D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA52824AC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992051862A;
	Fri, 15 Mar 2024 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPsowmXT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5C182D8
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497830; cv=none; b=i/e5hnfk5JprxUzOzwZ323yUeKqeLqa7mMrtxALzKSLvkSHPZSRK2iciCR3AiiulbxQJr+dNJUYPJt8oi/1CMbBwsDuod084TT1h01zrV1yTZGy7KxC18eX/x0/1gUIklJGkfB2OErVfwmrCvduYGAqQCu1A4acGMrsmgM1rg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497830; c=relaxed/simple;
	bh=oHV5jyiNttfVN2XdElX7JwJmvr1YWBo1/0MlP/fboNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fX4zK+DgCj78xBwVyDNGy2U22eH/kUzWLLZhxfcqSRgqG9/SpMaciBE8NxL9NOw5bqyoAP8v66/5/AZiYAYA57JluPAn3ZnWJTuh+lesOnvy8xSpcawau4seTcF9cFPLV/5UCy9U/N2lNoLCwlZSWl5rfQCtkWsRBh3gXTH6KE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RPsowmXT; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690db6edb2bso11356286d6.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710497828; x=1711102628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6tT+NcwpCH1Pw07al3Z4O6Zj2OI59Neo7bH4uFpikU=;
        b=RPsowmXT64dpl7oyDH7qsDikmJcWt4AYym6upL2gtxeRUg0bFelEcIhASeC37dZXna
         UfdtTx+bcQTForK3l9/iaL1ykkacEgeDD1MlgjbRrSg7+RosZpo2vJE6V4lxGEOsX4PQ
         7yq8RVSmX50P62J32wZJywl4lMbSJJkdDJencYsOXUeOd/yAzmyVkHkARmW8HgJYn//f
         IbonwcDJcHtNomwNkUEgJx1W3XsyZFapBGQcdlHc4Ky8AtHvffghdhOGOELPeBe1B+Vk
         pM+VBOe3M5usnBPPDd9/NaWwERPkfRKq9jQA0bSFksgOh4/Z+hUYqawUVFVL6CKnDBwV
         yetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710497828; x=1711102628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6tT+NcwpCH1Pw07al3Z4O6Zj2OI59Neo7bH4uFpikU=;
        b=JLqDrZeASNjtCXzxp2L2nA/y9KTC0FW+Jf6oyURcNTVyg8ayEB4d1Jnh8JoN9UHe0B
         DUhnr3Ohcyi2q5BnP59S8yVGrobs1Bxjj3CzTxDbj6MF+mLvq2CusySkW19ZmpA6NZAx
         MHyIATrwHlrFVA1Su964jWnbcFuBiaKP5UG1XqTJCYb8JYg8eE1vxb3OqKFXPQCvZru6
         TzMFm/Ilx7eN9T1g3RVbG9iEIXrAxeFfXhSxy89SKp87scF0IPnUymR2VvA2Ei38/w6/
         XQoFgGZCatQ/ORru4A/Lfs2BroB/R+JL7kuWtwAbfPjCdYIjk9w6VlGW0szpHIg/UHqR
         eCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeE4RYAk7Sx+HAFPZn5Ibk7/fBwBw1dZZPwVbrcpQ4KC4eVu7P0UGwha104p3f1TS7O1r13M1Alaxei97ih3UcB9oD7GewVic6
X-Gm-Message-State: AOJu0Yx4JRA2FUcK+TEi/9kHk9zYMuUm5tnOFWWS8yeqtOBHU1Foe00t
	zxZVrL+AYC7KCtiDXBQdby5S1goNtOk7kSWjCpDKwhBULath1u7YKsUpOH2t3hY=
X-Google-Smtp-Source: AGHT+IHrhbiGVEjN1QgiRSnPRQQmIe+549icsYvrMinCkS0IAydYdE6xtIBvVfhrF3hMoV0M0FyHzQ==
X-Received: by 2002:a0c:e8c6:0:b0:690:9a8a:855b with SMTP id m6-20020a0ce8c6000000b006909a8a855bmr4498037qvo.29.1710497827614;
        Fri, 15 Mar 2024 03:17:07 -0700 (PDT)
Received: from [87.246.221.229] (netpanel-87-246-221-229.pol.akademiki.lublin.pl. [87.246.221.229])
        by smtp.gmail.com with ESMTPSA id p14-20020a05621421ee00b00691631154a2sm1472434qvj.43.2024.03.15.03.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 03:17:07 -0700 (PDT)
Message-ID: <c1f85249-32b1-41e2-adc3-5aa4ad7609b9@linaro.org>
Date: Fri, 15 Mar 2024 11:16:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240215161114.GA1292081@bhelgaas>
 <bc7d9859-f7ec-41c5-8a9e-170ccdfff46a@linaro.org>
 <Zc8GHrgdF7jJBgyu@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Zc8GHrgdF7jJBgyu@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/16/24 07:52, Johan Hovold wrote:
> On Thu, Feb 15, 2024 at 07:44:27PM +0100, Konrad Dybcio wrote:
>> On 15.02.2024 17:11, Bjorn Helgaas wrote:
>>> On Thu, Feb 15, 2024 at 11:21:45AM +0100, Konrad Dybcio wrote:
>>>> On 14.02.2024 23:28, Bjorn Helgaas wrote:
>>>>> On Wed, Feb 14, 2024 at 10:35:16PM +0100, Konrad Dybcio wrote:
>>>>>> On 12.02.2024 22:17, Bjorn Helgaas wrote:
>>>>>>> Maybe include the reason in the subject?  "Read back" is literally
>>>>>>> what the diff says.
>>>>>>>
>>>>>>> On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
>>>>>>>> To ensure write completion, read the PARF_LTSSM register after setting
>>>>>>>> the LTSSM enable bit before polling for "link up".
>>>>>>>
>>>>>>> The write will obviously complete *some* time; I assume the point is
>>>>>>> that it's important for it to complete before some other event, and it
>>>>>>> would be nice to know why that's important.
>>>>>>
>>>>>> Right, that's very much meaningful on non-total-store-ordering
>>>>>> architectures, like arm64, where the CPU receives a store instruction,
>>>>>> but that does not necessarily impact the memory/MMIO state immediately.
>>>>>
>>>>> I was hinting that maybe we could say what the other event is, or what
>>>>> problem this solves?  E.g., maybe it's as simple as "there's no point
>>>>> in polling for link up until after the PARF_LTSSM store completes."
>>>>>
>>>>> But while the read of PARF_LTSSM might reduce the number of "is the
>>>>> link up" polls, it probably wouldn't speed anything up otherwise, so I
>>>>> suspect there's an actual functional reason for this patch, and that's
>>>>> what I'm getting at.
>>>>
>>>> So, the register containing the "enable switch" (PARF_LTSSM) can (due
>>>> to the armv8 memory model) be "written" but not "change the value of
>>>> memory/mmio from the perspective of other (non-CPU) memory-readers
>>>> (such as the MMIO-mapped PCI controller itself)".
>>>>
>>>> In that case, the CPU will happily continue calling qcom_pcie_link_up()
>>>> in a loop, waiting for the PCIe controller to bring the link up, however
>>>> the PCIE controller may have never received the PARF_LTSSM "enable link"
>>>> write by the time we decide to time out on checking the link status.
> 
> This makes no sense. As Bjorn already said, you're just polling for the
> link to come up (for a second). And unless you have something else that
> depends on the write to have reached the device, there is no need to
> read it back. It's not going to be cached indefinitely if that's what
> you fear.

The point is, if we know that the hardware is expected to return "done"
within the polling timeout value of receiving the request to do so, we
are actively taking away an unknown amount of time from that timeout.

So, if the polling condition becomes true after 980ms, but due to write
buffering the value reached the PCIe hardware after 21 ms, we're gonna
hit a timeout. Or under truly extreme circumstances, the polling may
time out before the write has even arrived at the PCIe hw.

> 
>> Generally, it's a good idea to add such readbacks after all timing-
>> critical writes, especially when they concern asserting reset,
>> enabling/disabling power, etc., to make sure we're not assuming the
>> hardware state of a peripheral has changed before we ask it to do so.
> 
> Again no, there is no general need to do that. It all depends on what
> the code does and how the device works.

Agreed it's not necessary *in general*, but as I pointed out, this is
an operation that we expect to complete within a set time frame, which
involves external hardware.

Konrad

