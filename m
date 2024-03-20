Return-Path: <linux-pci+bounces-4936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D60880CF7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423CEB20F34
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BC36AE4;
	Wed, 20 Mar 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHeTQ5Px"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDE3613C
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923100; cv=none; b=IvV5zzrW6R3uJlRoe1KlnPCWJEjp05vL0Z2pgy0hF9CukWmX4q10B2LXGRNDvHxt9JrpKffHy9e0/L/pVCEL/l3AWxkQ4pnEpNfbqp3bInvQqMcLj8SDCrwBIGN0EEwFDvlYOVNICX9WRWxyIK+vcw3IYhsLwBIPMeB/eMYIGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923100; c=relaxed/simple;
	bh=0G/wDf/+bEoJsbR+S3Ffh2JR0dENplkrlOdNn6NjM54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8O6hMY0Dfp2xaZtz1EEPsMuzKqxtHd0Y/+rUvX2u0yijb5PP/grp7KOhJit86mM2qSs3+LoQLbydvmXpVyBEMAKA6S0bdXZ+m+bPaQoTUoOpSVZqrBjn0csZHBiD5iiKfNbSPSHifSMlRDx2PAlXzxpDbYHdSYL82/IYy1AgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHeTQ5Px; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46ba1a05e0so423398866b.3
        for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710923097; x=1711527897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pli4imcMGDmtPbUfMUFZLhGttqyEXhVIwlQoh9s/O+E=;
        b=LHeTQ5Px7+uu6zGdIOXNDk0RHf7WYTc4cpq7bgzbr5MEZUCjCn9l2uGHAALEaknfIX
         cIzg7rwm6JH9p9vrYcW6mvU5gKx8d6DEz/FAJoQmQn1YSM0EO1XPB1wFKyuktYPbyumw
         mh5dtAPm3EDRP4I/fO+JbfcbawhqNybjmhmDuOQcJDKGf63LQ7uh8sFAFNzvc9mMJ/d9
         sNZGhTXdzJZwUQolvZ+HV+AWPCf4x1i4EjLA5npRXG0MRBpXAhv2wrKhYd/qEaZNTUZV
         VYdwemT+yoT+JIqm7VctW2WlFdNnMlodriSPizugmrJrcr3lbs2q2jJb9h/JxlNjjKwF
         AHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710923097; x=1711527897;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pli4imcMGDmtPbUfMUFZLhGttqyEXhVIwlQoh9s/O+E=;
        b=YOISKfcT5EXmEPu1OoFRFB9f9sIbje3gIF7YGmF/rT0dsbxZV5M8VNnz9QPmmdhj+3
         8AJr7tlCCGW6weaXg8SqjLsZ0P0GuZ1C8Tjy58hfT12EdPIB6mplmQVgwmR/FDR+80ew
         SNJCC8LrwJXSQJ7lO9xal4oOOkwkPN7pf0BELFY99uGMtPhCmbuwgeTzdF2uIUEOe3PS
         7lFLBPhK65xzVttpG3cYI5mBGDOlhRxae6LJM6A0f48N749B/bwlQ8w448P9Ziscuwlb
         tx2fkjOiR7a6nk948sp6KXqMQZPIBFigENz4c9v0Rl29yvPn9dw7G7gEGX5A0+1BQi3f
         cWag==
X-Forwarded-Encrypted: i=1; AJvYcCUC6QcgJkajeJkVl8SDQuT+HLtzngiwj5SMghyc2Ds4J+C39tgxXgS65XrvpZ3Oh8ZfT9OUwSdnQzl4IM/x3hJ4PdC1g69sWkmz
X-Gm-Message-State: AOJu0Ywemh0kpDN0Rq/ZtPRq1Zfh8cDGXUNuqSMkdETCW4X3BXaQPowz
	bdSjEbYRUMBhx495XFdd07DpoRTHkoikGCtMCpd1iMhaYPo+m4fdyuy+TBxdtwI=
X-Google-Smtp-Source: AGHT+IG2ytnM+yLYcxXVndyNK7687tWXrVYmiimVuMJg8Vpe+qFWSYcJhzolU52x2iuoHc7v1NzkDQ==
X-Received: by 2002:a17:906:ad6:b0:a46:8bee:668 with SMTP id z22-20020a1709060ad600b00a468bee0668mr3181870ejf.7.1710923096675;
        Wed, 20 Mar 2024 01:24:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c751000000b00568b43fffb0sm5401094eds.96.2024.03.20.01.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 01:24:56 -0700 (PDT)
Message-ID: <baf9c1bd-84ef-4ecb-b229-51a83fe82c3f@linaro.org>
Date: Wed, 20 Mar 2024 09:24:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes
 and GICv3 ITS enable
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Johan Hovold <johan+linaro@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306095651.4551-1-johan+linaro@kernel.org>
 <171081652637.198276.6219023769904423414.b4-ty@kernel.org>
 <Zfk98hYPn7kiFGkt@hovoldconsulting.com>
 <9b475e13-96b9-4bce-8041-e0d8e5a332a1@linaro.org>
 <Zfqb8jPK50vlqu5Q@hovoldconsulting.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zfqb8jPK50vlqu5Q@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 09:18, Johan Hovold wrote:
> On Wed, Mar 20, 2024 at 09:09:02AM +0100, Krzysztof Kozlowski wrote:
>> On 19/03/2024 08:25, Johan Hovold wrote:
>>> On Mon, Mar 18, 2024 at 09:48:30PM -0500, Bjorn Andersson wrote:
>>>> On Wed, 06 Mar 2024 10:56:46 +0100, Johan Hovold wrote:
>>>>> This series addresses a few problems with the sc8280xp PCIe
>>>>> implementation.
> 
>>>> Applied, thanks!
>>>>
>>>> [4/5] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
>>>>       commit: 2b621971554a94094cf489314dc1c2b65401965c
>>>
>>> I noticed that you applied both of these for 6.10, but this one is a fix
>>> that should go into 6.9.
>>
>> Well, mixing fixes for different cycles in one patchset was always
>> discouraged. In case of some subsystems you would receive clear
>> response, that you must split fixes out of the patchset.
>>
>> Fixes being first in the patchset would be probably accepted by the rest
>> of subsystems, but putting it in the middle of the patchset is wrong.
> 
> Perhaps you should not comment before reading up on the history of this
> series.
> 
> This was all intended for 6.9, but merging was stalled for a number of
> reasons so here we are. The patches were also going in through different
> trees, so patch 4/5 is the first Qualcomm SoC patch.

Again, well, you sent it at few days before merge window, so how do you
imagine this being applied for v6.9 and still fulfilling "few linux-next
cycles before merge window" requirement? Especially that arm-soc cut off
is much earlier :/. I talk about patch 5, of course, because that is not
a fix (at least not marked as one). Don't expect in general a arms-co
patch to be applied four days before merge window, thus the actual fix -
patch #4 - should be split.

Best regards,
Krzysztof


