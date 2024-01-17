Return-Path: <linux-pci+bounces-2252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1068301EF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62DD1F27799
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350E125AB;
	Wed, 17 Jan 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pyisi1NY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793813FEB
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482805; cv=none; b=LWXkCNyA6jOcA0cNqhb197h+dBx8BB+8/WbdVRZwZaMjUyC7g2UNXQAxLEEEzjn4ZESQvPYtXgWaKEvJ5kNi9VtQcqP8nJ6njWUjLa6y1UG6CF41Gd3zUPHYyu3E6Yp/IuQtDFGrA2gLPH7lL9PUIEmdQeSwp1V7xuknap1tFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482805; c=relaxed/simple;
	bh=3QKG4X44VzuBpp0/MyF+g9YvHja0bvB6aou5vhWSoZU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=bJ0fpQDLvbunQ2arwV/ocidauO1HbEnFH2U9hQNdPo8S8wHVkmkq53mYwx9MnhF6RJCbSv38XuZBvM9edQoPy/OZRPWoCQn713HUr48u2kvpz2vrpXMGF07q+qZXGVURS6TTwlcdGeXyKuWyx1WwfE+64nybmEnbJXttpBefYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pyisi1NY; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd1a1c5addso125839921fa.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 01:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705482802; x=1706087602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wwyu1C0cyc8uW+GR2bf6x9B8R8CXK0267QnxkJZctz8=;
        b=Pyisi1NYdbkco5BcsHIAcOFK7bNF8wYCKZ8MHxMWLaoht6FxWRgdZUXYZT3S8Gk6q/
         Tk4ZAkousniJL19Zi5VtuU4kCrUHj6ohgCYOzKTYo21TPc8hyejiHjDrZQWtCTIaAYB4
         MbofLk7JttO1LEEmSrD8+qQLYP2GhLy+ks30Z6td3o2GWOri6WLW8ppBPdXUSa38mKvQ
         P6DQZoLE+yyuVfeMvib97kaxlANKbGOETRQDG6z/MDwAaRxF2TX9nnSIGov5J7wdicxd
         GkkMv3tfvYnedEzC/hdn/+BR+4CuxJa5WEOPjB9fGD/dzfFza+ywyShJHFcVJZxd5d9v
         lOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705482802; x=1706087602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwyu1C0cyc8uW+GR2bf6x9B8R8CXK0267QnxkJZctz8=;
        b=JpaUwByUbun4yGPSWUg6LKmMH3X2ddUtiFI9Kf+oK2AbPxHwAfPG1loVMQ/6+FCDTa
         OrIej9mEZxqMcuMs1ScWe+CtYU1jqrl/REaE2DRpYdJB4PAATEIclc3jC9dZPxpb6/uW
         CQcxi/+moiwrzwz6P/cMxAnlA50/5rSQSp0QBxvMeGZTL41KVSvOKawFPkg5Gda4rUlf
         Hh5EFT6/2fLUAN+0PBvlBSLB6pC4M1deRtL7ey5dE5xpYnzJJBFXNfypEtRqF1gLzt93
         2FNPSS0H9PLiaXfyd9EfJNEMge6y7Gcohyi4TgviqVIeaBVqngAkbLYksnLZb0s89hKs
         5kGA==
X-Gm-Message-State: AOJu0YwdE8/VUqMFkCdiAL0HteG9Z2XcMntl8UzfX5wIPNH6kTVWM3nV
	Wz1+6sU3qQ7PhroDWs17wYNUeWsyaFFaEQ==
X-Google-Smtp-Source: AGHT+IFMDBMxw1t88rGyo/U0DDixbc/dpcoDsnvG0JEuKbtjnQcp8QN9fqXEa+48olQLuSbz0vi3qw==
X-Received: by 2002:a2e:8481:0:b0:2cd:7ac4:f9b5 with SMTP id b1-20020a2e8481000000b002cd7ac4f9b5mr4043594ljh.14.1705482801427;
        Wed, 17 Jan 2024 01:13:21 -0800 (PST)
Received: from [172.30.204.250] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id l6-20020a2ea306000000b002cc8772c87bsm1888797lje.76.2024.01.17.01.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 01:13:20 -0800 (PST)
Message-ID: <ca4f3f38-f0e5-4d10-b9eb-155f6ffbc57c@linaro.org>
Date: Wed, 17 Jan 2024 10:13:15 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>,
 linux-arm-msm@vger.kernel.org, vireshk@kernel.org,
 quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <fecfd2d9-7302-4eb6-92d0-c2efbe824bf4@linaro.org>
 <f9a177e0-3698-4865-9463-220c65c653fb@linaro.org>
 <ZaZf4EyX5oADXG9N@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZaZf4EyX5oADXG9N@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/24 11:52, Johan Hovold wrote:
> On Fri, Jan 12, 2024 at 11:33:15PM +0100, Konrad Dybcio wrote:
>> On 12.01.2024 16:17, Bryan O'Donoghue wrote:
>>> On 12/01/2024 14:22, Krishna chaitanya chundru wrote:
>>>> CPU-PCIe path consits for registers PCIe BAR space, config space.
>>>> As there is less access on this path compared to pcie to mem path
>>>> add minimum vote i.e GEN1x1 bandwidth always.
>>>>
>>>> In suspend remove the cpu vote after register space access is done.
>>>>
>>>> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
>>>
>>> If this patch is a Fixes then don't you need the accompanying dts change as a parallel Fixes too ?
>>>
>>> i.e. without the dts update - you won't have the nodes in the dts to consume => applying this code to the stable kernel absent the dts will result in no functional change and therefore no bugfix.
>>
>> The Fixes tag denotes a bug fix, its use for backport autosel is just
>> a nice "coincidence".
>>
>> Fixing a lack of a required icc path and having to rely on BL leftovers
>> / keepalive bus settings is definitely worth this tag in my eyes.
> 
> An incomplete implementation can sometimes be considered a bug, but not
> always. If this is needed to enable a new use case, then it's hard to
> argue that the original omission was a bug.
> 
> And as I just mentioned to Krishna, the above Fixes tag is not correct
> as that commit did not *introduce* any issue. It solved the bit that was
> strictly needed for sc8280xp, but now it seems you may need something
> more for an even newer platform (even if no details and motivation was
> included in the commit message as it should have been).

The PCIe hardware seems to be piggybacking off of others' bus
bandwidth requests and I think it's just been pure luck that
it didn't simply refuse to work on previous generations.

So indeed, the commit message seems incomplete in explaining
where the problem lies

Konrad

