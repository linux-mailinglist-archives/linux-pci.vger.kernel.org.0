Return-Path: <linux-pci+bounces-8545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A42D9024FA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865461C227A2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354751384A9;
	Mon, 10 Jun 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeibQCtB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B19137747
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032032; cv=none; b=maMaoc8ts4WYCLZiJot53gBfguPcRiVM34fHO0TGgezCxSiMBAkKrtSV9K9mhDCpOVpe8ILPg0Zk4gdUhNPdn9q7bvNLYuxT1P48Pa2Q9cjO1oy35X7QlkaKIMU5i4mkyny5s2bNyzRdvxsGXsEor2E8jCrUIpbhp9NAaVo01pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032032; c=relaxed/simple;
	bh=BHUKNWu9Gm7BFV2h2F+vtKAxK01wDm8l07XgvB9kSDE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s2oD8Ff08lmS5WgAAkAYxWz6iCX2zEIMZ9Le7YLj1+zZZgFvsr7BZYV6vJelTJ+2I4EFItTqv0q5IQwsOjMINfKS0fpHXqJ4jFYame/Vlcukr1gVFqk6324VR7HviIAsuy4l3io5bqDeVLM02bAHvVnysWoLWiZ7sThSRCFR6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeibQCtB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c8c0d73d3so1213199e87.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718032028; x=1718636828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h9kWcRmGR8cLJ82ciTUgDAD6Cy9Z+U9GhZ0rBx9PYEE=;
        b=MeibQCtBLodHNGDT+mVWFDX0U8tFDIL0Y9J6ps59vAkOuTzYNA6xazU9dVtXKf0oll
         S3GC1AWid4FNNhqfOB+FjmUux9MGmt0Szs325YOTsdlodiGru6SdCvwEwaZMFgtJTtDi
         NObeu5pVWqCJWaM5u4soYit0hgKeFmmcS9xBFfIpoY8pILyC77SJCRiuZb7Atllzs7wt
         5AO64+5SmxcJlncjdHUhiqD4pIIXyLdWOzmx5/5f8adxMUQBCv/s/z7NG3EAJB38/Pq7
         z3MJF7SdOwMxL04JDIKpLG33jSldVTj0rI7D0Izq8G9/saO6SbPVi5VgIQ2V/adSIL1y
         0YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718032028; x=1718636828;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9kWcRmGR8cLJ82ciTUgDAD6Cy9Z+U9GhZ0rBx9PYEE=;
        b=a0pNFmpIYA/CLUGuYSw+VIgQK1oA5qVsDQCdRd3JyMUs2r0mhnRcbeqWs0gVeQSjkf
         6MinNwi6iVGW4MTukruWmDg8g+dbELmshjcy3ajp7KKIyXoriA/UZMjUaz+Csh4xEzzq
         4O1Qz955G7JewkBICZ38OyPnyW+s9Yr2/hp4xO7ORePPZwcMjxbSjzUAp+A2JQPaKL54
         pkLSVKBlWzYsRmwC7cxJAcjqpUl/Zdn98ij1DncFuLZxIWHj/nMtJzXVsw/xf1p4BVhs
         Cj4fdfqUuD/mx6VA9JnDUlfjYYWiMpj7eAyEg+g9MhGy5gLqcjBgrLBTTNRxHBqeAXdR
         +bog==
X-Forwarded-Encrypted: i=1; AJvYcCWLHICmVTw/MtSRDKlhtbJ6P3NjNqKNhABX5k35OK7T9eheRVhGIYgz1aFGthLNulh8sSMQGaFrfToeuDnJmKELDarAtD8CpAql
X-Gm-Message-State: AOJu0YylDPadji8XC2IbnPkJcAL9+N2WFKHaT78ARDU8SchIncRILU5B
	p5WuXOwMKJXhQWwpHKGj6gEE3VFTVW0kcPBhB3+r8my6U/3ECvDURHqOHKDu33c=
X-Google-Smtp-Source: AGHT+IElQ/NmsD0/0eKD3JUYRHo+Iv+RmXxwHvybvSNVCfKdGJPsv5LDDbzVkR1JOditnQZBbQsPqg==
X-Received: by 2002:a05:6512:3da3:b0:52c:86eb:a2e6 with SMTP id 2adb3069b0e04-52c86eba461mr2983156e87.4.1718032026006;
        Mon, 10 Jun 2024 08:07:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42196386d13sm47420235e9.12.2024.06.10.08.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 08:07:05 -0700 (PDT)
Message-ID: <bc56ecb2-9940-48b5-afbc-1a447b1ff46f@linaro.org>
Date: Mon, 10 Jun 2024 17:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] power: pwrseq: add a driver for the PMU module on
 the QCom WCN chipsets
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Amit Pundir <amit.pundir@linaro.org>, Xilin Wu <wuxilin123@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <20240605123850.24857-1-brgl@bgdev.pl>
 <20240605123850.24857-3-brgl@bgdev.pl>
 <e7c997a3-8d68-410d-9f04-8637d76a0d61@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e7c997a3-8d68-410d-9f04-8637d76a0d61@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2024 17:05, Krzysztof Kozlowski wrote:
> On 05/06/2024 14:38, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> This adds the power sequencing driver for the PMU modules present on the
>> Qualcomm WCN Bluetooth and Wifi chipsets. It uses the pwrseq subsystem
>> and knows how to match the sequencer to the consumer device by verifying
>> the relevant properties and DT layout. Using this driver will allow the
>> BT and WLAN drivers to respect the required delays between enabling the
>> two modules.
>>
> 
> ...
> 
> 
>> +
>> +	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
>> +	if (IS_ERR(ctx->bt_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
>> +				     "Failed to get the Bluetooth enable GPIO\n");
>> +
>> +	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
>> +						 GPIOD_OUT_LOW);
>> +	if (IS_ERR(ctx->wlan_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
>> +				     "Failed to get the WLAN enable GPIO\n");
>> +
>> +	ctx->clk = devm_clk_get_optional(dev, NULL);
> 
> Your binding does not allow the clock. Do you need it for non-DT platforms?

Bah, damn covid, now I see second commit with clocks.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


