Return-Path: <linux-pci+bounces-3483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EDF855F10
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 11:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD051C20844
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738D67E70;
	Thu, 15 Feb 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAe9h4xU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087F67A1D
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992511; cv=none; b=GWWOPHsmtglqAlIF+n78EIkjuEI/4zVBlAwdv8LbD3ne6bza1b9JQTDCXcLCyNtkRchf59JK7FafGkAjzWZHtFdr597XD359D4D3401gYy2iY05VziuBHOJai5UU5u/pSeq3eKIoLxlkpBYdLkl3Xw6oHKUbbposz17T9UGuMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992511; c=relaxed/simple;
	bh=YT83jAApk16SoeiAMl/v7WhogysHMW2ucF4uBrLYJgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULo9kWJqARMehmK1GNZYAJZos0L1ouSF6iwISlMfZ5XuHFm9EMBuJq8XODrk2p4NHCTPPozzIK6jRv8ThuI/5+xladPdU5WBj2BLgfRkzrB0UGRhcb4Ay0Ht8C+ZEJ3047W5gEfydwoVFPZ1zNHuECmINWBBh7qBkijb3X/K+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAe9h4xU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so1005139a12.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707992508; x=1708597308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ciw4pOtP95/auA7ToeOHSPYuZOxAhM3oTuFVWwrCe4I=;
        b=qAe9h4xU3pMbFl23XO/ZRH6n82/1CKM2lo537rbZeqm43te562ztbUeDff6kWIRf0C
         7M5/g81oe68UHsfpziByW4UkYpBdhCdpokZwzFcwxJ70wP5JOSH4MilRmWkiLKbgVfbp
         dBv/ZCTTOK58R6uL0ysfDOi9J7OMnI3JlpJS7yYYmKpPh+EEXl+GgKgzBqMSAojfefTY
         GJOLsH96vhnt0APzgjq4/xkUIRBduTRfWRm3Rx8XV6XRKcxSoTjuph+piV0dfZtzswZr
         /RxuqTklo0odpllCRQvQqBlKZm5yrYyd+kEos58S1Rsq3DmxMJZizwZBmBKQHpgge5kC
         4fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992508; x=1708597308;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ciw4pOtP95/auA7ToeOHSPYuZOxAhM3oTuFVWwrCe4I=;
        b=gQiUvAusajCPuS8unyC6or5QNi+wJ0AQP4t9Cdj8JR26wr5IzVVXOcA5BD6e3FUBVz
         7YOn2DGlzhv3Nm2I0Us8nzn4zq0anHHyPhlLH1yyNdV9fhwFRl3VnY5ckMJWDCLw3xeN
         gm2JfrQkdS+3jCFSfTUlwSCJTBe5/AIaPlqZ+RtfF+IgmuqpfK1daQN/fI7Ajk7spZpf
         bYMT6GIQdlm3p6ncMbK7TkhHDXaPNfmYHAyGK8DVNg4gbYmTceywmMeLEg9MkdlgWxB2
         ulKVUeySHGb8/OIBdHUgOLk88wGtZ9IUJCdKy532+ZwU7Z1P6ATsZss4gSXc/LIm+i9C
         qctA==
X-Forwarded-Encrypted: i=1; AJvYcCV8SWrgnaorh3MQgaFShMbQQTfj1D9asoGLXnM2ckB90EsoMytXGOsklw50uwAopDY5PNHMQAL2DLQFgKSVJA2MDRnWMfOoKuF9
X-Gm-Message-State: AOJu0YxpaSU8u8oh1GYx1b/v2FMxjSxylkJAj0sekiwuN38DsIkIMtb2
	a4AKA4CMuAMypiMr2RaFmI05myz6RngpzmfG6vkdD32IdTdAJTONEpxxwOxem6w=
X-Google-Smtp-Source: AGHT+IEjU1fLiIjBQfeIMSUt81GJzz0CYW7vyVaEhVKuxOdlx7UsMzgiXgzjyjabpUtPbw2S8mJrAQ==
X-Received: by 2002:aa7:d518:0:b0:561:fec0:cd44 with SMTP id y24-20020aa7d518000000b00561fec0cd44mr1251437edq.27.1707992507614;
        Thu, 15 Feb 2024 02:21:47 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id em2-20020a056402364200b005639fbc1ff4sm405940edb.43.2024.02.15.02.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:21:47 -0800 (PST)
Message-ID: <3a040d65-4843-4e7d-818e-2523d112c74a@linaro.org>
Date: Thu, 15 Feb 2024 11:21:45 +0100
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
References: <20240214222819.GA1269395@bhelgaas>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240214222819.GA1269395@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.02.2024 23:28, Bjorn Helgaas wrote:
> On Wed, Feb 14, 2024 at 10:35:16PM +0100, Konrad Dybcio wrote:
>> On 12.02.2024 22:17, Bjorn Helgaas wrote:
>>> Maybe include the reason in the subject?  "Read back" is literally
>>> what the diff says.
>>>
>>> On Sat, Feb 10, 2024 at 06:10:06PM +0100, Konrad Dybcio wrote:
>>>> To ensure write completion, read the PARF_LTSSM register after setting
>>>> the LTSSM enable bit before polling for "link up".
>>>
>>> The write will obviously complete *some* time; I assume the point is
>>> that it's important for it to complete before some other event, and it
>>> would be nice to know why that's important.
>>
>> Right, that's very much meaningful on non-total-store-ordering
>> architectures, like arm64, where the CPU receives a store instruction,
>> but that does not necessarily impact the memory/MMIO state immediately.
> 
> I was hinting that maybe we could say what the other event is, or what
> problem this solves?  E.g., maybe it's as simple as "there's no point
> in polling for link up until after the PARF_LTSSM store completes."
> 
> But while the read of PARF_LTSSM might reduce the number of "is the
> link up" polls, it probably wouldn't speed anything up otherwise, so I
> suspect there's an actual functional reason for this patch, and that's
> what I'm getting at.

So, the register containing the "enable switch" (PARF_LTSSM) can (due
to the armv8 memory model) be "written" but not "change the value of
memory/mmio from the perspective of other (non-CPU) memory-readers
(such as the MMIO-mapped PCI controller itself)".

In that case, the CPU will happily continue calling qcom_pcie_link_up()
in a loop, waiting for the PCIe controller to bring the link up, however
the PCIE controller may have never received the PARF_LTSSM "enable link"
write by the time we decide to time out on checking the link status.

It may also never happen for you, but that's exactly like a classic race
condition, where it may simply not manifest due to the code around the
problematic lines hiding it. It may also only manifest on certain CPU
cores that try to be smarter than you and keep reordering/delaying
instructions if they don't seem immediately necessary.

Konrad

