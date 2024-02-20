Return-Path: <linux-pci+bounces-3795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD92D85C85E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 22:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C36281D00
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D97151CCC;
	Tue, 20 Feb 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJ6oHUQB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0101509AC
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464072; cv=none; b=ng3VL8Lq3xPsB6BQ9D3zK+5fFHX0JAOkOD/miFLQ4E/FnPbLe38J8j0ham+XGPgIr7YbNh+0MplCCMSsuIi+QptQV86v+EfmITpHKivbWmxbU2Uliwy11Xmm9Vikqu+IkqhunMuQrUf5FYRA5YGgFGlmY6MBT15jHUbayARxZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464072; c=relaxed/simple;
	bh=QIb79S8dEXh8LFbr/l1y4IqwiNhKYcYdvIOdGbZPR10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmpyrqgQC/iiLOszIzMUyUtJrFLKFeoUyqk7ESiZHq9WJLg2oB5UPU+JLtF8HO1sX+0uS6Ec0Usp2YFU1Aufg4HBiyCAA8VTSZR0NqyNJE+oWQfAlEOOzJRjgo1nAuaVL5uwpBerA2ZawHR9D4/hbMCs17sGjZnFQCn25vIfqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kJ6oHUQB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512be9194b7so2413772e87.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708464069; x=1709068869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aewqZFQqAR8f8P67ZzKs5ZfSe1DqicHVEuGcz5XnehA=;
        b=kJ6oHUQBobYzdU7nmQFkM3o1PTzoD/1gWwOCvaCiuaShekcaWW64iGJ+G9nrY2rEXR
         ty/VqImKjaPAXIHGh2hBywNFMUNF37eHSug1XHzVLgjEuUPekwwFHi70nlxVG97wMkg/
         bq2pXuDPqDRpW+M4DRfa28qEVuwOVDtOvfgzl9ZKQAyxbnHpK0dxu2/pXFU1zwhFfArn
         IV/xkFys5PLZw2jigIjJCYO/DoTEXCkVImGCVNfGn7SAims0skOmVCLUvgVcn3LRdSxf
         kg/K6oybXpR6nWqv1J9MO5bZGveHi56Hr9fJ+/e0AVRuBXvjK+ot0MI1492XMKc69zwQ
         kEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708464069; x=1709068869;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aewqZFQqAR8f8P67ZzKs5ZfSe1DqicHVEuGcz5XnehA=;
        b=slYull5rn635d89SnjMktkQOmKGfV7/FQd0Sjo2MRIiIo9McMBY5ge9vt+CbJRJQOp
         +4xrsTRXzoPZR3XLCMrZR9wahzqz4w+PKj1Op4YmUKSFks6KMMHNklxMoZfhEqYM4S4A
         rYkI2iYhlKIcK4IEooLcWfskEFHIpcm18AziH1w+EIwXP0KLBlGfq0lkyFE65SZRvpj7
         L8vUTc7PRHpjW2+lAx+bX+amWntUlCuEb0MhNlaXJZdg0y1XwDmW8YHBKYHGt5/5I2FY
         Lf3twHUXKLqmoDqw+lKvbt42AjlIJZ6ZJ2h6y8WOvDrUFJ6rqZ+Q/bbiNmBdO+v+thgb
         OM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc6VpPNq0m3NDgmM2oXPOlZ6TkhMuCiNsnQ3yuvDcUwCHg9AEHmWCzfrrCrWOWA5WDSl9BsEEJVAcs/h274HM7H03IJYZT0QU5
X-Gm-Message-State: AOJu0YyCoFPfYrj8IVgjbmBJxqQpJMCPubKQb56qD/WH6NVBNfpyAGsz
	T4IH6Of5Ah33vU7D5EYJtYLvrDf60pvuoKUZMTlaPGR6HghaPUu/MlOIT02cBzk=
X-Google-Smtp-Source: AGHT+IE7oxGB2v2CxKN0KBUsYoVrLWeS67J9KHU2sgtn9zhSwTZSLaGf6S53k3pQEILvmz2pBWcsQg==
X-Received: by 2002:a05:6512:48b:b0:512:b85e:9831 with SMTP id v11-20020a056512048b00b00512b85e9831mr3472902lfq.36.1708464069273;
        Tue, 20 Feb 2024 13:21:09 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q23-20020ac24a77000000b00512b25729bdsm972840lfp.31.2024.02.20.13.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:21:08 -0800 (PST)
Message-ID: <17bbd9ae-0282-430e-947b-e6fb08c53af7@linaro.org>
Date: Tue, 20 Feb 2024 22:21:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/18] PCI/pwrctl: add a power control driver for
 WCN7850
To: Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
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
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-15-brgl@bgdev.pl>
 <d5d603dc-ec66-4e21-aa41-3b25557f1fb7@sirena.org.uk>
 <CAMRc=MeUjKPS3ANE6=7WZ3kbbGAdyE8HeXFN=75Jp-pVyBaWrQ@mail.gmail.com>
 <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.02.2024 13:47, Mark Brown wrote:
> On Tue, Feb 20, 2024 at 12:22:42PM +0100, Bartosz Golaszewski wrote:
>> On Mon, Feb 19, 2024 at 6:50 PM Mark Brown <broonie@kernel.org> wrote:
>>> On Fri, Feb 16, 2024 at 09:32:11PM +0100, Bartosz Golaszewski wrote:
> 
>>>> +static struct pci_pwrctl_wcn7850_vreg pci_pwrctl_wcn7850_vregs[] = {
>>>> +     {
>>>> +             .name = "vdd",
>>>> +             .load_uA = 16000,
>>>> +     },
> 
>>> I know a bunch of the QC stuff includes these load numbers but are they
>>> actually doing anything constructive?  It keeps coming up that they're
>>> causing a bunch of work and it's not clear that they have any great
>>> effect on modern systems.
> 
>> Yes, we have what is called a high-power mode and a low-power mode in
>> regulators and these values are used to determine which one to use.
> 
> Are you *sure* this actually happens (and that the regulators don't
> figure it out by themselves), especially given that the consumers are
> just specifying the load once rather than varying it dynamically at
> runtime which is supposed to be the use case for this API?  This API is
> intended to be used dynamically, if the regulator always needs to be in
> a particular mode just configure that statically.

*AFAIU*

The regulators aggregate the requested current (there may be
multiple consumers) and then it's decided if it's high enough
to jump into HPM.

Konrad


