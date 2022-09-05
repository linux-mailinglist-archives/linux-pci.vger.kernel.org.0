Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C15ADB30
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 00:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiIEWJd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiIEWJK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 18:09:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E351A0D;
        Mon,  5 Sep 2022 15:09:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r69so9003507pgr.2;
        Mon, 05 Sep 2022 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=7X66Mhu89Nd1JC1tC2C3GiFsxMesGQdlZVFrlo9aYm8=;
        b=b7jRxWPyK0Rq4w8FR9ZFdzOAagpu8Ly97+vIsJC3Zr3BYQL9lMVB+ShDYBZ2D8gDRn
         iG42XCqTvMR/etwnUxtVq4dc6kjBUmYkBG8G+Uq0g4SiQD+aD7FdS44c68HxkrxInjmX
         rQwIEiXivv7vBIj5Sf8Y65QbFkdKpO+b+xgFODtb9auHWLSyyRIc9buVgrGAtV6dAmSk
         vw5WAxq8xcLg9s7lPX4OmewpOzfHhIQkLGIRLhUtapokGcK0j0Egcpyqr1AShiOI+SGy
         eWqxW4Icxyq7dn3JsNejnG/2tlPR6tqehYrDr8AxyduISs7Ol7B5gyVkSMCzO9kplR/h
         RRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=7X66Mhu89Nd1JC1tC2C3GiFsxMesGQdlZVFrlo9aYm8=;
        b=DeBANqo0eak8ewOZv7MDuBTc5gX4zDq2EnL/NztyRFAjwJ3C7CXRTxOzYwsrZ3itWe
         UIVJ5H5IwJjIEhmMrBA6EYLJw2lpMPhtGCbFtl0E8+3COg/UorqmvSZml9Yu9XmJLRpp
         5HeQRAnr4pazqoXtbLxGkOen1HpNBWWo58a47uaH0hbU4fsFWTS+R2BON8ba0rtKQ/1q
         T0K1rtLDeXPAVFNwxtwYNp//GkLEq2/YoBkg7V+OszkI0xSiKKUosbYV374jnv2qwOzY
         EQ7h5qmA6eudedi6F837KsCRjKRJ/69/6H43gYpqMoI+mH68dLtdncnQzsPM3dXyUVEf
         X0Ow==
X-Gm-Message-State: ACgBeo1WkHUh2xgsy86TkHTRqR+PGvaCgrYJAaDDC5YOU3SilSVk+iR0
        ht94UXORt7mwoRkaUifYegI=
X-Google-Smtp-Source: AA6agR6Eea0J+fyHn4cnB8pX01mZJQu8GcEqrT2a0QWMcFiUqA9q20U0tI3FWNDXq+ZYzlcm5H9Qbw==
X-Received: by 2002:a63:6e09:0:b0:430:663:7757 with SMTP id j9-20020a636e09000000b0043006637757mr24953820pgc.340.1662415749460;
        Mon, 05 Sep 2022 15:09:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b00176b8f587efsm2127192plg.148.2022.09.05.15.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 15:09:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <73749107-35aa-0720-1a30-02a90c0540fa@roeck-us.net>
Date:   Mon, 5 Sep 2022 15:09:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 10/11] watchdog: bd9576_wdt: switch to using
 devm_fwnode_gpiod_get()
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-10-b29adfb27a6c@gmail.com>
 <CAHp75Vd35EOy=mP25=9fmYfqQnbafgotHw1fxk-TdGk6Oc8g8Q@mail.gmail.com>
 <75e60144-9fa2-d6ba-bc92-edd23f7e7189@roeck-us.net>
 <CAHp75VcisCTYoRp-=713YKtwi7BQyPKGiUhF4DkpfAFtvDXCiQ@mail.gmail.com>
 <c696b9bf-d0ce-1c6a-0ee3-939b180891be@roeck-us.net>
 <YxZSUlCPEE9o/s4G@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YxZSUlCPEE9o/s4G@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/5/22 12:47, Dmitry Torokhov wrote:
[ ... ]
>> We know that count is either 1 or 2 here, so strictly speaking
>> 	if (count == 1) {
>> 	} else {
>> 	}
>> would be sufficient. On the other side, that depends on ARRAY_SIZE() being
>> exactly 2, so
>> 	if (count == 1) {
>> 	} else if (count == 2) {
>> 	}
>> would also make sense. Either way is fine with me. I'll leave it up
>> to Dmitry to decide what he wants to do.
> 
> My goal is to drop usage of devm_gpiod_get_from_of_node(), beyond that I
> do not have strong preferences either way really. It is probing code, so
> performance is not critical, but I'm obviously satisfied with how the
> code looks now, or I would not have sent it.
> 

Good point.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
