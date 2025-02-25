Return-Path: <linux-pci+bounces-22386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E86A44DFB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 21:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7DA3B14F9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88020C476;
	Tue, 25 Feb 2025 20:44:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC31A2C0E;
	Tue, 25 Feb 2025 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516245; cv=none; b=nxgzcErj6vcdS2lXbGkVZpzXPAa35U8txGIN2Ens9cZEpm4Y2x/lD6QhJzduYBYcMbky1L4BA3Sp37Fn3F9ychS6rmtPl1DU3l+OOAehZ+0wod8MaJ+VvFMNcUGkphoB8hv9ewugYre7mivFR6ULCf3+TPvU5H5GtBf5n7dj7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516245; c=relaxed/simple;
	bh=Yv+Z9Y+3B4jBCJ4/yx5U464umiGC38OjXZxWPi4QusE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aTojWX4A/83V77UtmNTM81e6qLf5qtG/BU2PKHv+V6X1aTPCm36aRU07gnFB0rSzyuVygq4PTiKPCd5oUGxew7hduXKablPfL126ZBpwGQ/8/B2TFrZaFTw625k2KtJkHXye5ezqj5qqZQDZ2D1GIjDdiU0Bu50KqOq2qY2X57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af513.dynamic.kabel-deutschland.de [95.90.245.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D9D4061E646F9;
	Tue, 25 Feb 2025 21:43:47 +0100 (CET)
Message-ID: <d1661817-1036-420a-9f76-a7124e6550a7@molgen.mpg.de>
Date: Tue, 25 Feb 2025 21:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Linux logs new warning `gpio gpiochip0:
 gpiochip_add_data_with_key: get_direction failed: -22`
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de>
 <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
 <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de>
 <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bartosz,


Thank you for your support.

Am 24.02.25 um 09:51 schrieb brgl@bgdev.pl:
> On Sun, 23 Feb 2025 23:04:05 +0100, Paul Menzel <pmenzel@molgen.mpg.de> said:

>> Am 23.02.25 um 21:54 schrieb Bartosz Golaszewski:
>>> On Fri, Feb 21, 2025 at 10:02 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>>>
>>>>> What GPIO driver is it using? It's likely that it's not using the
>>>>> provider API correctly and this change uncovered it, I'd like to take
>>>>> a look at it and fix it.
>>>>
>>>> How do I find out? The commands below do not return anything.
>>>>
>>>>        $ lsmod | grep gpio
>>>>        $ lspci -nn | grep -i gpio
>>>>        $ sudo dmesg | grep gpio
>>>>        [    5.150955] gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: -22
>>>>        [Just these lines match.]
>>
>>> If you have libgpiod-tools installed, you can post the output of
>>> gpiodetect here.
>>
>>       $ sudo gpiodetect
>>       gpiochip0 [INT344B:00] (152 lines)
> 
> So it's pinctrl-intel, specifically this function in
> drivers/pinctrl/intel/pinctrl-intel.c:
> 
> static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> {
> 	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
> 	void __iomem *reg;
> 	u32 padcfg0;
> 	int pin;
> 
> 	pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
> 	if (pin < 0)
> 		return -EINVAL;
> 
> 	reg = intel_get_padcfg(pctrl, pin, PADCFG0);
> 	if (!reg)
> 		return -EINVAL;
> 
> 	scoped_guard(raw_spinlock_irqsave, &pctrl->lock)
> 		padcfg0 = readl(reg);
> 
> 	if (padcfg0 & PADCFG0_PMODE_MASK)
> 		return -EINVAL;
> 
> 	if (__intel_gpio_get_direction(padcfg0) & PAD_CONNECT_OUTPUT)
> 		return GPIO_LINE_DIRECTION_OUT;
> 
> 	return GPIO_LINE_DIRECTION_IN;
> }
> 
> Can you add some logs and see which -EINVAL is returned here specifically?

Sure. I used the diff below, and added `dyndbg="file pinctrl-intel.c 
+p"` added to `/boot/grub/grub.cfg`.

```
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c 
b/drivers/pinctrl/intel/pinctrl-intel.c
index 527e4b87ae52..f0922d9e64ee 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1067,18 +1067,24 @@ static int intel_gpio_get_direction(struct 
gpio_chip *chip, unsigned int offset)
         int pin;

         pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
-       if (pin < 0)
+       if (pin < 0) {
+               dev_dbg(pctrl->dev, "pin < 0");
                 return -EINVAL;
+       }

         reg = intel_get_padcfg(pctrl, pin, PADCFG0);
-       if (!reg)
+       if (!reg) {
+               dev_dbg(pctrl->dev, "not reg");
                 return -EINVAL;
+       }

         scoped_guard(raw_spinlock_irqsave, &pctrl->lock)
                 padcfg0 = readl(reg);

-       if (padcfg0 & PADCFG0_PMODE_MASK)
+       if (padcfg0 & PADCFG0_PMODE_MASK) {
+               dev_dbg(pctrl->dev, "padcfg0 = %x", padcfg0);
                 return -EINVAL;
+       }

         if (__intel_gpio_get_direction(padcfg0) & PAD_CONNECT_OUTPUT)
                 return GPIO_LINE_DIRECTION_OUT;
```

These are the logs:

```
[    0.198584] sunrisepoint-pinctrl INT344B:00: Community0 features: 
0x000000
[    0.198613] sunrisepoint-pinctrl INT344B:00: Community1 features: 
0x00000c
[    0.198629] sunrisepoint-pinctrl INT344B:00: Community2 features: 
0x000000
[    0.198687] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198688] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198693] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198694] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198699] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198700] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198704] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198705] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198709] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198710] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198715] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198715] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198720] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198721] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198730] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198731] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198735] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198736] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198741] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198741] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198746] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198747] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198756] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198757] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198766] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198767] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198812] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198812] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198817] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198818] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198822] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198823] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198837] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198838] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198843] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198843] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198848] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198849] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198853] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198854] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198863] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198864] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198874] sunrisepoint-pinctrl INT344B:00: padcfg0 = 4000700
[    0.198875] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198879] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198880] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198884] sunrisepoint-pinctrl INT344B:00: padcfg0 = 4000700
[    0.198885] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198938] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198939] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198944] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198945] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198950] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198951] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198972] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198973] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198978] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.198979] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.198989] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.198990] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199006] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199007] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199011] sunrisepoint-pinctrl INT344B:00: padcfg0 = 84000700
[    0.199012] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199028] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199029] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199034] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199035] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199040] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199041] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199045] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199046] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199211] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199211] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199217] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199217] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199239] sunrisepoint-pinctrl INT344B:00: padcfg0 = 4000700
[    0.199240] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199255] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199256] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199261] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199262] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199267] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199268] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199273] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000702
[    0.199274] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199278] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.199279] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199284] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.199285] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199301] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000502
[    0.199302] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199307] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.199308] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199312] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.199313] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199318] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.199319] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199324] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000700
[    0.199325] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199382] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000600
[    0.199383] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
[    0.199387] sunrisepoint-pinctrl INT344B:00: padcfg0 = 44000600
[    0.199388] gpio gpiochip0: gpiochip_add_data_with_key: get_direction 
failed: -22
```

With

     #define PADCFG0_PMODE_MASK              GENMASK(13, 10)

indeed one bit is always set in this range.

> In any case: Linus: what should be our policy here? There are some pinctrl
> drivers which return EINVAL if the pin in question is not in GPIO mode. I don't
> think this is an error. Returning errors should be reserved for read failures
> and so on. Are you fine with changing the logic here to explicitly default to
> INPUT as until recently all errors would be interpreted as such anyway?


Kind regards,

Paul

