Return-Path: <linux-pci+bounces-4934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2587A880CBB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EF01C21282
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407922BD1F;
	Wed, 20 Mar 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTQGyRx2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54792374D1
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922149; cv=none; b=OluvQZpJhbMWapjm7b24QRbWI4Yi6t9O5KXIxWgfqEztxG/scuaFzNCiUva8/aQmMr5oZ/Mt/+WAqCzQeC3hwoIpZt82vySBXszSm9f2LnvUTNr2tUEk9s9hnSFVELP4+qUyb59whESDtPKubPw8TVleydwhN/MTZCYMB83iae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922149; c=relaxed/simple;
	bh=g6vL1gQBRUvlde/11uEfc6jiem2SF6/e2PYqvB9Y77U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gdr7mcMSl98pqA37EYNhzmSo18YWHPgUk6HjbkthPg3vZ4j+4J2rFFMo47DbbDNB2pXu5uNit2JXFthat7ny02BgQa6xTTIdif23foH7TfIhHUB7rPMdSCWYEBeIxxOT0Uh2V7oNXZ42CzYue6M2oR8tNx6zY0myqTSIlP03vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTQGyRx2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46d9fbb5a5so224460366b.2
        for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710922145; x=1711526945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ASNi9NWUv9VIlSCO1/SKf1kBYpvLWhcXFFZ8p/fVKCI=;
        b=bTQGyRx23V704SOooG1CNYh9YKC4yAeor9jJjJa8K3J13BCRWFzYswVdl/xA2aPeJb
         PdEnkISpJrmodS0JCtfxNHTYRm+FexoFCLvPrrlbEmkjegGPOeHfLDsIV7S+1XmUe67r
         TmEr0hAur2Mqvf97fPGxmi11pBqQFJkTNxc8EztgvpKmq2rynDXGAATlS4GvtsAJYUxa
         PuIlpYamNAzeE8zbH9AYwdzfJrIbUA9c8k44QjX5Jaggyw9UJLoA8MCg5EUo+j9aXdhA
         RLIWPJdeR4QTClEHccFiFw8WO5TAlNusgyLRsVNzfBrRauz3nYXLeHiig8Nas1OFib4U
         w3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710922145; x=1711526945;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASNi9NWUv9VIlSCO1/SKf1kBYpvLWhcXFFZ8p/fVKCI=;
        b=uApNSrb2sfNQWB4ACQa+CdttGTRrbMDWLENxoHcUh1Mc4a7DcdZ2tU8U28ydZxHslN
         cvfaGhVjFJ4Oe2VTTnIB53NmT6sr+yXp6qdvEeXRmCo7pezC5QdiM/L2DpNyg+bSTxyF
         UuICTz8y5gOVNVErEJagVnVn0ufcqREtojgV0zeXoD3+O1DeCHsJ9Gt4FiqtcDM4pVqR
         0nPsNXo+gTBr8gpAzBV++twh5QtpARoWB4b5bWH8+7JTPUSafa2MetmM1swlAitYiDb2
         EogqBWH/7qKYCyiIUkW8CUKmTWYKOLiloCVwCxP2tv4rFWhLUH8vUMCE+fnQ1vTHCKTS
         +ePQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyI1TW/J0QNVXcBc17ur9A3Ot56fcCxp0ZjaWSCF6D8JjSyNNjSOzVX5q9wm4Eaw5DKdCk71N75KI5nDVQKE7tojrI3e5UNPK8
X-Gm-Message-State: AOJu0YwsWrHvGftGw6NQ9P4QWCrrK3OX066yxUDdnC/Wt8mhvW5l2pRT
	aYnvfKKpMMufJt5X58Bk4YyFaO2qiCMx6sQ5wLu+N5kN4kTW0xCFAYeWgWoH3U4=
X-Google-Smtp-Source: AGHT+IHzLz/YDC6wvNDvpXxhSlIQNsL5c/APZk2tA36UUOOq9RLOFN0hyiFZSdZBuyE5sXQ9isMB3w==
X-Received: by 2002:a17:906:1796:b0:a46:baa8:6cea with SMTP id t22-20020a170906179600b00a46baa86ceamr3287708eje.10.1710922145614;
        Wed, 20 Mar 2024 01:09:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ap2-20020a17090735c200b00a46c1dd36f0sm3065788ejc.173.2024.03.20.01.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 01:09:05 -0700 (PDT)
Message-ID: <9b475e13-96b9-4bce-8041-e0d8e5a332a1@linaro.org>
Date: Wed, 20 Mar 2024 09:09:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes
 and GICv3 ITS enable
To: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Johan Hovold <johan+linaro@kernel.org>,
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zfk98hYPn7kiFGkt@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 08:25, Johan Hovold wrote:
> On Mon, Mar 18, 2024 at 09:48:30PM -0500, Bjorn Andersson wrote:
>>
>> On Wed, 06 Mar 2024 10:56:46 +0100, Johan Hovold wrote:
>>> This series addresses a few problems with the sc8280xp PCIe
>>> implementation.
>>>
>>> The DWC PCIe controller can either use its internal MSI controller or an
>>> external one such as the GICv3 ITS. Enabling the latter allows for
>>> assigning affinity to individual interrupts, but results in a large
>>> amount of Correctable Errors being logged on both the Lenovo ThinkPad
>>> X13s and the sc8280xp-crd reference design.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [4/5] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
>>       commit: 2b621971554a94094cf489314dc1c2b65401965c
> 
> I noticed that you applied both of these for 6.10, but this one is a fix
> that should go into 6.9.

Well, mixing fixes for different cycles in one patchset was always
discouraged. In case of some subsystems you would receive clear
response, that you must split fixes out of the patchset.

Fixes being first in the patchset would be probably accepted by the rest
of subsystems, but putting it in the middle of the patchset is wrong.

Best regards,
Krzysztof


