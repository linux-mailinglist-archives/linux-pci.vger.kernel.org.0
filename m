Return-Path: <linux-pci+bounces-3742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9100985AD9F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 22:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004D9B20BAC
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED353E22;
	Mon, 19 Feb 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwpWR2z6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F253E12
	for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377807; cv=none; b=pgMord8NYZy5kJpETcOv/cJDdBXL1rvXYaMyTxuk69hbvezgXtCwJCgKIS3sd/IzvAMsg1bmhOWnOzXG+hIfAgL0wYXg/cg05ynVHVu5No989mijeQKDXbDh5v8tN1vFQTPAXIpwgvmS/JEAtXGvi0xenFCgy+O4mW1tj1nKwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377807; c=relaxed/simple;
	bh=8xz+6XpDTd1vb3gFdfA/PynLF+pwhW660BuoCbdZBNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr56zrUe2YV+v1jwWNmmH6D+EAvtqICSZmK/hVjYqcR72DxZzJbjpS+ATgZXW+pkaBJr8RpAhzOGlJwARX8ITJrb9xeT3i0//c2DKJ0hRx7rch8Elm0OjkAsGlUf+MIwr779/Xudfrt43EvrVSvIrkqznv3yC5aNhxOvapvIgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HwpWR2z6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4126cff4721so2052495e9.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708377804; x=1708982604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Dp7g0ZZlHWDLtOm92Hg+KE1Fsd9aYHxUp8R+ILIVC8=;
        b=HwpWR2z6YGeWngOoQfoVdNaKSRSqkzbRQtuFLlh9IJ8SV2N7gj/6vySmrcUuY1zGF3
         eSvtvwnlf3y6F7FcDTXht/BVYsQ6BG3xdhG8Xw9pZzaAL+pWYBUB5DQ1q+jz0kbv3LKa
         coiLo7Ai1jDDTSHLozFeWZFswKyFt3Zvih1N6t0yQxc/T5qiVbX0vYRjVcplMLmMQvHn
         YngEjhzs2WSPiRCNC0feItvCGtPLIwolxGqZY77kBIv5m6xultIMXdqzeX64jEKrLr0r
         ksGbYD4gKBbrfdLCB6/efrVZbWzvmG5tQe2E6LL1DOG+nEe7SKiDqTaHnxT+lNBeoz7B
         QiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708377804; x=1708982604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dp7g0ZZlHWDLtOm92Hg+KE1Fsd9aYHxUp8R+ILIVC8=;
        b=hdKElkpfRpWbtGHGLAKJR+h8SeMmd8D/LBTGybCn85k/MItIxWWpDgeVn8CwXovKI5
         Zy8kL7Ot53ndrPYTlwOJANUfBVulFQ0qq1L73SaXgI//TT9R5QPvpPZjr9Ww4966R6Z4
         cNK2b6j7v6JuqWHv2b72NIRGwKtFq+fuPVbVVL0l91Oea6FA8JFA0eXIxtpDyJHaMriC
         s0JDvXFgimZcGVMD5Cw1R1DPwEGGcyw95p09DOeW5P2ZaoYTTbzUIRzxm/J5J1xhks5R
         kGVdLbvFOoYgcVC17LtUx2lanswzg6AlHYK49bfOXr+fMrcDFSxEy+zOYVCtejwBrbTt
         g+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVH8YeFdds+KUuQn2ZaqlQpz027Vrhi0hFszQDF3MzEpCma/70RtfQ3au1jKqvnMyAzni33PVZDjODHzTxVl/VGrffMn5ATLaaE
X-Gm-Message-State: AOJu0YxnroyoXNDNk1vN4pNqxcnp68zeyhgxdsLTAZg/H8sGUJ/ib+q1
	0sRbQQyEk6mFblSZGM1E8IDy37AWJnSxYHqfGOjgvEmO9DQ3YXvOIrUEJP5xUFo=
X-Google-Smtp-Source: AGHT+IGMDWyCqdrf3limUzCDQCeqBmV2qO6/3JtbpjNeO7lE8mmXkQsNbh5abKcT5FIEPx2wqRSzUw==
X-Received: by 2002:a7b:c408:0:b0:40f:ddc2:7260 with SMTP id k8-20020a7bc408000000b0040fddc27260mr9610955wmi.36.1708377804375;
        Mon, 19 Feb 2024 13:23:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id je11-20020a05600c1f8b00b0040fdf5e6d40sm12549766wmb.20.2024.02.19.13.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 13:23:23 -0800 (PST)
Message-ID: <a9c34206-0068-4bd1-9fae-8963ad00eb36@linaro.org>
Date: Mon, 19 Feb 2024 22:23:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/18] dt-bindings: regulator: describe the PMU module
 of the QCA6390 package
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Brown <broonie@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Saravana Kannan <saravanak@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-4-brgl@bgdev.pl>
 <ZdDVNbjv60G9YUNy@finisterre.sirena.org.uk>
 <CAMRc=Mf9Sro4kM_Jn8_v=cyO5PxCp6AnBdeS9XspqVDGKdA_Dg@mail.gmail.com>
 <7c1327c0-d0ea-4797-a5fa-5844ba46bf53@linaro.org>
 <CAMRc=Me=3HhGc_yZuaEo1TsLbF2R=g+072185_PAh5GmAQ-M7w@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMRc=Me=3HhGc_yZuaEo1TsLbF2R=g+072185_PAh5GmAQ-M7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/02/2024 13:53, Bartosz Golaszewski wrote:
> On Mon, Feb 19, 2024 at 8:32 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/02/2024 19:32, Bartosz Golaszewski wrote:
>>> On Sat, Feb 17, 2024 at 4:48 PM Mark Brown <broonie@kernel.org> wrote:
>>>>
>>>> On Fri, Feb 16, 2024 at 09:32:00PM +0100, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> The QCA6390 package contains discreet modules for WLAN and Bluetooth. They
>>>>> are powered by the Power Management Unit (PMU) that takes inputs from the
>>>>> host and provides LDO outputs. This document describes this module.
>>>>
>>>> Please submit patches using subject lines reflecting the style for the
>>>> subsystem, this makes it easier for people to identify relevant patches.
>>>> Look at what existing commits in the area you're changing are doing and
>>>> make sure your subject lines visually resemble what they're doing.
>>>> There's no need to resubmit to fix this alone.
>>>
>>> Mark,
>>>
>>> This is quite vague, could you elaborate? I have no idea what is wrong
>>> with this patch.
>>
>> Use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Yes, I always do. And for Documentation/devicetree/bindings/regulator/
> the subjects are split 50:50 between "dt-bindings: regulator: ..." and

No, there are only ~54 "dt + regulator" ones and around 400 starting
with "regulator" (Mark removes first prefix if it is not regulator:). So
50 to 400 is not 50:50.


> "regulator: dt-bindings: ...". For Documentation/devicetree/bindings/
> it's overwhelmingly "dt-bindings: <subsystem>: ...". It's the first
> time someone wants me to send a DT bindings patch without
> "dt-bindings" coming first in the subject.
> 
> I mean: I can do it alright but it's not stated anywhere explicitly.

Well, practice was kind of known and obvious, but it is also stated:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/submitting-patches.rst?h=next-20240219#n18



Best regards,
Krzysztof


