Return-Path: <linux-pci+bounces-3484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05028855F17
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 11:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF372286C72
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACDA67A1D;
	Thu, 15 Feb 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xwMdhGTz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5267C44
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992561; cv=none; b=gF8a6OA/sokdcvSttc3qKZ+ykdN24mBmHhW27j0Jp9NtBTPiPFMcGWVw7dQG4KsGpE2cBZsyUOJfnLhnSAQZIKAXM6JB2///SW220HQnrUV56mv7KBHOZkvvU24UZ7SYVC1zSk4RmNuEPbb3vt5d36ucKvIAaJoc2DF6Gws7zNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992561; c=relaxed/simple;
	bh=CWpIL3XABUujYhuG7eE/i0p4b279rBYem6KgKyaZaBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlLwTkSUIVBC3wSGev42CKqqPm+lvNEbZBPGvF4b/ehscnXER4cG2NDdHdMEjgL62MDqx4vzZgHJpx9Ux7UdViPDsUYGdJiwYvHK7LJy1EWlZDr7A93TEugGFO2W6PWRMH4vuxi+tulmtWqMLdGjWiZYYxen0b7jlBrtzRyBEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xwMdhGTz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so917640a12.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707992558; x=1708597358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOkNu0rG484BLsBBaD2UW5VVuIqfgjAH0mKF8SREstc=;
        b=xwMdhGTzMtSdMAeyB6mErkgQv2ppSJY63kzmX6wVVnVr1ci9HAarBgcOv4uBxjYxkJ
         5npmPOmqkwtNimGrsYtqgSmNNoP1cNTgcS+KjQ4CRkwlkWuxaTm1SLkqooGqpnA0IyaT
         CyVHzQ5WjeHhE5PY6tosXKTYbZA1kMceEW8V6DFFHUZdpUJm2+2+E5ycvOsHOgy06rm2
         RPNoRs57krmC+HG1/pBoZoG2AV4ZW6mFJ7UVotRDK2qMMQkFPeP01l92M05BjhHCCecN
         iHFWdVXEs+fze2PgG1SWWNKXuEH9BMMRkhTTnlM8W6nDAJOae5VIy/F5exX4TGKH9k52
         NFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992558; x=1708597358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOkNu0rG484BLsBBaD2UW5VVuIqfgjAH0mKF8SREstc=;
        b=oLBkhrZobD6M67IVDcCpOJK0MfsVQaaYmpYb3G0LAZdCgi1M6SyTVMBrh6ZcRQ3tvK
         uim2sJcPghOvsc5t1xj+3Lg9fv6VXk+jowKD/umqJFh1/B9eQMB4ohjD0hIJzEEPCLUi
         iHAyYFLRUwCBw0yx+p0/bZL18l7rg/mILqto9+XEgSKLmVNYWXIu4NMguUoKl7+2vVfC
         QwnE5V3H/P2ipKLdwxyyP6sHsCAL4YzL127RVxeSwOzipk2GYwieFPh+7osDVTAR0ma9
         /oVWs2XTm5gbx4BJbgizeEsy0w+ItfQ3TSrcfPswfpTNOp6BwLW7JTvme2BEQGQNb+1V
         nWEA==
X-Forwarded-Encrypted: i=1; AJvYcCWr2ylMPU1TJ1+zuV1VtX1sRxbbatPGtY0n72odGplFMhVuPdTOr+m0mubHqBTzc6wh0WXtEGJVfzlrDjathVFjeB9WgK/tyh0Y
X-Gm-Message-State: AOJu0YxYOHi6sq9AEGNDYoVExgT86rUFEBObq80RyKkSjnAG7N9KTE+j
	aq+CB/NNDvpoEc3EHdJuGRyZqrPKYK1seAQbibsERMBEAZ3a9lzaBqALzV8eHVg=
X-Google-Smtp-Source: AGHT+IHp2YRszxlP/Hr8ylAK8FhHbs+i7NZPgZdPGhqXfD4lbCczUvLcjlso4h0dz1/FZf68GKQW8A==
X-Received: by 2002:aa7:c6d6:0:b0:560:64f4:cbd1 with SMTP id b22-20020aa7c6d6000000b0056064f4cbd1mr1132316eds.19.1707992558232;
        Thu, 15 Feb 2024 02:22:38 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id em2-20020a056402364200b005639fbc1ff4sm405940edb.43.2024.02.15.02.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:22:37 -0800 (PST)
Message-ID: <905dbef1-d03c-49ab-b79e-34f26b4f3a66@linaro.org>
Date: Thu, 15 Feb 2024 11:22:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: qcom: properly implement RC shutdown/power up
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240212213216.GA1145794@bhelgaas>
 <27560098-ced3-4672-bc60-6c1b7c0dc807@linaro.org>
 <Zc25rIZbzWyw7hzq@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <Zc25rIZbzWyw7hzq@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 08:13, Johan Hovold wrote:
> On Wed, Feb 14, 2024 at 10:33:19PM +0100, Konrad Dybcio wrote:
>> On 12.02.2024 22:32, Bjorn Helgaas wrote:
>>> "Properly" is a noise word that suggests "we're doing it right this
>>> time" but doesn't hint at what actually makes this better.
>>>
>>> On Sat, Feb 10, 2024 at 06:10:07PM +0100, Konrad Dybcio wrote:
>>>> Currently, we've only been minimizing the power draw while keeping the
>>>> RC up at all times. This is suboptimal, as it draws a whole lot of power
>>>> and prevents the SoC from power collapsing.
>>>
>>> Is "power collapse" a technical term specific to this device, or is
>>> there some more common term that could be used?  I assume the fact
>>> that the RC remains powered precludes some lower power state of the
>>> entire SoC?
>>
>> That's spot on, "power collapse" commonly refers to shutting down as many
>> parts of the SoC as possible, in order to achieve miliwatt-order power draw.
> 
> I'm pretty sure "power collapse" is a Qualcomm:ism so better to use
> common terminology as Bjorn suggested, and maybe put the Qualcomm
> wording in parenthesis or similar.

Ok, I keep hearing it so much that I had previously assumed it's the
standard way of describing it.. I'll reword this.

Konrad

