Return-Path: <linux-pci+bounces-12286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84351960C6E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8EC1F21C71
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16AB1C0DE3;
	Tue, 27 Aug 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epTVc03+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8FB1C0DD6
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766198; cv=none; b=NdChs5sYSp7ZI1H5+DDJDu8RvYg5vFwDY76YnyQWqItMUB/eLlTdhL7vRJSEq1OACHy2TX9FxiSrC4+nACi46M+lAAZOdHsosrpb/GXdMCVVB7ToE87HZksd6B+WtIh0sH9czH2pU5W47gRjRxRoNqu2Uam5ODzwtPNT8fus8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766198; c=relaxed/simple;
	bh=+OhHidtktFf5YZp76+TaLa1IBsJiNY38LfvLPE3Rxkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAJ1lEKU7fgBMwTcdL231Gz7OxkitWib2oo409vuJ54EdlV8KIrR3q3K7PPCUUwFih9fscsq2Ypa09xyfKgnDr49kk5pJOK214xAdTB2iQZyQpSm0Pu3vAGLw4tguTTTo4GeiVk4OPpcxif7edjmYZCsc8pXy2HxwTjxx31X5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=epTVc03+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371b2a51746so158181f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724766195; x=1725370995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aXqRlOi/4kgWJtXgLS8F5ACtkppRdByA9Aezvb2TYDE=;
        b=epTVc03+o385e275+NEAZv5furCR4IJCV96sRIFrbuf+ooHRSK4Apu3wJyiKJF+riu
         9q6MquzpS6fe38UgqgqKI5qa1n8NQEqL1GHubQgXT6zdsc5OSTB4W6cxqagihQa34kqw
         sS+dMSVO5HVm022AdVz4bnrsPWQxrmieiXNxhJJHKu/Ls1TsKNLAsko3QjnNcHtJO2dN
         ZIGBx8g+sMJTbob1iJSh5ptHXw+B2RT/D3W1dbLNyRF7huiG/3+1mDmNhvKbNjwXuGop
         uUrJhfKJ4FkN74uX4j/wvlog67hXHi8XZghbaYiDWuYCx3Gye1tFa4ISrTjF2xVeeTaM
         UZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724766195; x=1725370995;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXqRlOi/4kgWJtXgLS8F5ACtkppRdByA9Aezvb2TYDE=;
        b=cfI4DmmbDgv75dPZghf9LKV3WDrmbhF94MdzjXtuRmJrURF76XpkgK4xEV4g8oGyec
         jWmIgOdulhC3jeJtFHlhA5ULRmhRpfi529Qm5lO3eAH9StroJ2TAKNWV2v7p8adHzXSg
         tpQbvcKffhzy+WYH0hW/Ij7Tv+/MGkcc+0LrGNOiq0RMsXautmAQOMRChRfld6NduEts
         O5SUI5wOnx033liiMtqT7mkLnZxjKWO9b0DJZWcsqgyCbRT8R602f/d7hEbdEenOoag/
         aCA2XYdJ+hCOwl7hulF1PW/+nc1dsCbL0guBv4ORF6K6r5eH9pYOQbOtv1VsPPA/B2mu
         vrlw==
X-Forwarded-Encrypted: i=1; AJvYcCVbxfckmxIJgDPJ0zmm3F3F2dbJFokwvjOEy0nSPN34NKodHerhMvlsWIq/78msIlsbxUCwIC8ev6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2B7+pes6AF6x6iOKdnofttS36+SCcJI1XyXoeMDzN9eY0MKj
	+NzB9RRZTkVNjnqLjsvD/zDbuDt9f7IvW5RZonZZQREdXLFmLJbvgUV1jLU7zYs=
X-Google-Smtp-Source: AGHT+IFM/T+Y5HHhpm7/Qi5B735avy9oHTmm65ie8uBgbRrjM0tDcNqyvfdg7nm2OwwCeZ3ZY+8Q1Q==
X-Received: by 2002:a05:6000:178a:b0:360:8490:74d with SMTP id ffacd0b85a97d-373118ce84cmr5368196f8f.5.1724766195201;
        Tue, 27 Aug 2024 06:43:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c1e3sm13083010f8f.35.2024.08.27.06.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:43:14 -0700 (PDT)
Message-ID: <420178e9-ff55-4c22-b52e-da5af72d096c@linaro.org>
Date: Tue, 27 Aug 2024 15:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
 <93da058b-8d72-4f76-9ee7-f6837a1a4a9a@linaro.org>
 <3dcaee19-3671-4658-a2e7-247e42b85805@siemens.com>
 <2b368426-a572-4d3c-b991-9532fa828d23@linaro.org>
 <bac7e1fb-83d0-40de-b789-0a4e469a0b64@siemens.com>
 <d67019fe-2107-4a8b-8495-4b737afb6e93@linaro.org>
 <5b09afe0-54c6-4f70-8748-c49918005b7d@siemens.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5b09afe0-54c6-4f70-8748-c49918005b7d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2024 15:38, Jan Kiszka wrote:
> On 27.08.24 14:44, Krzysztof Kozlowski wrote:
>> On 27/08/2024 11:22, Jan Kiszka wrote:
>>> On 27.08.24 08:35, Krzysztof Kozlowski wrote:
>>>> On 26/08/2024 21:25, Jan Kiszka wrote:
>>>>> On 26.08.24 20:53, Krzysztof Kozlowski wrote:
>>>>>> On 26/08/2024 19:56, Jan Kiszka wrote:
>>>>>>> Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
>>>>>>> against DMA-based attacks of external PCI devices. The AM65 is without
>>>>>>> an IOMMU, but it comes with something close to it: the Peripheral
>>>>>>> Virtualization Unit (PVU).
>>>>>>>
>>>>>>> The PVU was originally designed to establish static compartments via a
>>>>>>> hypervisor, isolate those DMA-wise against each other and the host and
>>>>>>> even allow remapping of guest-physical addresses. But it only provides
>>>>>>> a static translation region, not page-granular mappings. Thus, it cannot
>>>>>>> be handled transparently like an IOMMU.
>>>>>>
>>>>>> You keep developing on some old kernel. I noticed it on few patchsets
>>>>>> last days. Please work on mainline.
>>>>>>
>>>>>
>>>>> How did you come to this conclusion? This patch set was written for
>>>>> mainline, just rebased and tested again over next-20240826 before
>>>>> sending today.
>>>>
>>>> You send it to addresses you CANNOT get from mainline kernel. There is
>>>> no way mainline kernel get_maintainers.pl produces them.
>>>>
>>>
>>> That is likely due to that I didn't re-run the get_maintainers.pl for
>>> all areas of changes but rather reused an address list from a slightly
>>> older posting, sorry.
>>>
>>> IOW, your assumption is still not correct when it comes to code.
>>
>> Sure, I see results and I am guessing the reason. Keeping the list
>> static is not the approach you should be using, as seen here. It does
>> not make even sense, because then you need to keep several lists per
>> different subsystems or you CC unrelated people (don't). Just use simple
>> wrapper over git send email, b4 or patman.
>>
>> https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91
>> ha
> 
> Those options are useful, unconditional automated usage of the script is
> not when you might be targeting multiple subsystems in a series (not
> that uncommon in our scenarios). That's why shaping/confirming the final
> list remains a manual step for me. But I'll improve on keeping it updated.

For that use git send-email identity hack. And anyway it still does not
apply to patchset here which should have been sent to everyone or SPLIT.
Putting DTS in the middle is a no-go, because it suggests there is
depednency and you CANNOT have such dependency.

Best regards,
Krzysztof


