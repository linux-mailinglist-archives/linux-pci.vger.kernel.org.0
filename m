Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87934F572
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 02:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhCaAZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 20:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhCaAY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 20:24:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255C0C061574
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 17:24:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y32so11773448pga.11
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=t8GisNUKhAXhRRmhb5Tmd7cSosC0ChQ5VE6Rcal6IVk=;
        b=urdw3ivXzWShCpZ72V3nD7ok9QIvHP0ke8jFdQ6gOdSvymUjIs2/ErLZOItEsi3Exq
         Zs/3q45bKVnrvrbSLkghBP8hFtj6qVeMzz3QGjNAbe8vYCKmt67b0HU/a1rimNbVG/bG
         9i5i5OG5X0jCsbYssTZKB2kEzfUjkj/Tz2IgeJP/MkJhFphCczFN6i17moOy/H7qOQ3e
         aI+4KGsS3P5GrnDzdy7q9IblINvwNF1BiXXQaD5XzCxZULPiIcfhxzp7xxrMM0HeWyVS
         JANPccHlgxQi8ZyQM3ouLqwjeOC7ke9gUVjz5HNCEAVRcxOfa39fRx9hzMCTKz9mMlld
         ffdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=t8GisNUKhAXhRRmhb5Tmd7cSosC0ChQ5VE6Rcal6IVk=;
        b=AFfjyWU1STjQdk3eeqE8iFc81WJ3eWLyVbvmJrfJRpWm828yPQK+LYanf8KE2hAnpW
         1uuWNZO0D0zmF+SITOYc7BxMe3AaR5csLqrwSVXzO7ih/IRaGO/2UwQLC5T0htFUzlr0
         GkcGkbPxE9QdrHgyohkCKfxgJ7nCxVL7FXIGWgINi6R/RW2IqEyyEjw8UjEL/FZm0InB
         8AWxwppb1UGWq8VzBF9taX5u73aMx7xZ7acB8Z1H8IUm3oC30VpB6CIAbopEVRSgQt8M
         bIvBu7bQPKAO/aPCtgjV3F7lcZpYVzMHOryWMyEWnd4TgQngGB28oI9fmNVFqUA4EAAP
         xGug==
X-Gm-Message-State: AOAM5323jp6zpH2ECyZ9ZkGJR6GNnBjM/Oeh6PT3/p3huZT56b70lABn
        UVyD9hngj0Cf/zZ4X7oBUgsVlg==
X-Google-Smtp-Source: ABdhPJzu1TA+qlBzM73yS6GhrKUJdqQ2kl7j2QOiV7JjAougt35JjgWoZLN67F4hgX4tR8a+GoQsxw==
X-Received: by 2002:aa7:9687:0:b029:22e:e5ce:95b6 with SMTP id f7-20020aa796870000b029022ee5ce95b6mr502259pfk.53.1617150266450;
        Tue, 30 Mar 2021 17:24:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p25sm169258pfe.100.2021.03.30.17.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 17:24:25 -0700 (PDT)
Date:   Tue, 30 Mar 2021 17:24:25 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Mar 2021 17:06:40 PDT (-0700)
Subject:     Re: [PATCH v2 2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
In-Reply-To: <CAHCEehL63aJQPA3DdRCa3pZHWX3DH9ktgKbo1+nD=KWxADsogA@mail.gmail.com>
CC:     sboyd@kernel.org, alex.dewar90@gmail.com, aou@eecs.berkeley.edu,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        erik.danie@sifive.com, hayashi.kunihiko@socionext.com,
        helgaas@kernel.org, hes@sifive.com, jh80.chung@samsung.com,
        khilman@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, lorenzo.pieralisi@arm.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        vidyas@nvidia.com, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-78a4de2c-8723-4b35-b64e-2e1866ad6743@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 29 Mar 2021 20:36:12 PDT (-0700), greentime.hu@sifive.com wrote:
> Stephen Boyd <sboyd@kernel.org> 於 2021年3月30日 週二 上午3:14寫道：
>>
>> Quoting Greentime Hu (2021-03-17 23:08:09)
>> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> > index 71ab75a46491..f094df93d911 100644
>> > --- a/drivers/reset/Kconfig
>> > +++ b/drivers/reset/Kconfig
>> > @@ -173,7 +173,7 @@ config RESET_SCMI
>> >
>> >  config RESET_SIMPLE
>> >         bool "Simple Reset Controller Driver" if COMPILE_TEST
>> > -       default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC
>> > +       default ARCH_AGILEX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARC || RISCV
>>
>> This conflicts. Can this default be part of the riscv defconfig instead?
>>
>
> Maybe I should remove this since it has been selected by CLK_SIFIVE_PRCI?
>
>  config CLK_SIFIVE_PRCI
>         bool "PRCI driver for SiFive SoCs"
> +       select RESET_CONTROLLER
> +       select RESET_SIMPLE

Ya, that's better.  IIRC I suggested something similar in some other 
version, but I might have not actually sent the mail.

>
>> >         help
>> >           This enables a simple reset controller driver for reset lines that
>> >           that can be asserted and deasserted by toggling bits in a contiguous,
>> > @@ -187,6 +187,7 @@ config RESET_SIMPLE
>> >            - RCC reset controller in STM32 MCUs
>> >            - Allwinner SoCs
>> >            - ZTE's zx2967 family
>> > +          - SiFive FU740 SoCs
>> >
>> >  config RESET_STM32MP157
>> >         bool "STM32MP157 Reset Driver" if COMPILE_TEST
