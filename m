Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33DB5ACF65
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiIEJ4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiIEJ4f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 05:56:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066322295;
        Mon,  5 Sep 2022 02:56:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z6so12339667lfu.9;
        Mon, 05 Sep 2022 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RdubYDDix+oOh2a0h//nboO40BpZ5xfyyxVZCNAs3B0=;
        b=et2BStfuMMuGC6Hmc0ahP2YMtl2IOvVs82z7fBLtShtRiNOLZEUcKr2FN+yvHNZxWj
         hUQof0CelJPy6k645QZnNEtobw55lyLfO/xzbj7BHjhPUtrr6ZyyJrZD5+wJPU8x4s/V
         wDTG6XP1BvwPE/YT5IW93WWtvTubg44nQ/U2m0Ukxn8zuXPeusqOLZkrZIQo7BaTII3T
         tjpw7YIxVKZOVR6ozOO29YwJBQZS8KoqWz1HV/AEJBiJwCnjVlLgAcdY8jrwxwGrjJtw
         gmvPsEX0owb2idPOc8tLiT8uceUOa827MJ139sBCmc4Km7ZtH35OknAdtVpmn61dpmua
         LvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RdubYDDix+oOh2a0h//nboO40BpZ5xfyyxVZCNAs3B0=;
        b=XYe7falFuPUINq8OKUEiYQ/aI22NbiDQESAyt22FWHsr87GRz2RcqhWsDaxMf1aVr8
         thgcr5kuWwdUrZgSdTPdJ7d6L+i+4zpF+pScv5hKuMuCywrL+CpV+rdkj+tU8DPgUvOM
         gWw12+JHT56Z/c4rGvu00Nf5QCtV4YHwnw+XXlX+110JvshiG8dUafvR4f47bPfo1awW
         CWALFDi6dos16Xgl/xfB5w9hGdK2ySxicAAEV1WZz3Gbk3xJPYWynvp8JF0SDciRjzLS
         kVdGUAE9gXO9X6LbViXBrGyHpKuhY1r39uTYOLLrft+xGrSJTFq2YqCaVO01eI71rBW1
         9eWg==
X-Gm-Message-State: ACgBeo2pPnYz468gee9hV+C8+BJwBXFDL28E4YJEKiFTtGrec4zzqbWm
        /xiOMD+UeVlwiZ46k9Atk2Q=
X-Google-Smtp-Source: AA6agR49m1znt1xCwEgykIjaaYQRJwjqD0WPTDOx4N16eYQFUBRnr5DGteFNKPh7H42GT7aHHRsE7g==
X-Received: by 2002:a05:6512:13a4:b0:479:3b9f:f13c with SMTP id p36-20020a05651213a400b004793b9ff13cmr15342515lfa.380.1662371790521;
        Mon, 05 Sep 2022 02:56:30 -0700 (PDT)
Received: from [172.16.194.136] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o4-20020ac25e24000000b004965e80b761sm40259lfg.224.2022.09.05.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 02:56:30 -0700 (PDT)
Message-ID: <0b051f7e-1754-cb69-c0df-0bae08c967fd@gmail.com>
Date:   Mon, 5 Sep 2022 12:56:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 09/11] regulator: bd9576: switch to using
 devm_fwnode_gpiod_get()
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-9-b29adfb27a6c@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-9-b29adfb27a6c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/5/22 09:31, Dmitry Torokhov wrote:
> I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> so that gpiolib can be cleaned a bit, so let's switch to the generic
> fwnode property API.
> 
> While at it switch the rest of the calls to read properties in
> bd957x_probe() to the generic device property API as well.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>


Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
