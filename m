Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CE578E6C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiGRXo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 19:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiGRXo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 19:44:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7A3192D;
        Mon, 18 Jul 2022 16:44:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p81so10630119iod.2;
        Mon, 18 Jul 2022 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bTJywUAqX3j6iJePWZLrUnkk/lwpRK52+zopJgYfdMg=;
        b=ZzrnIuDDrStWpWKXGlfYH8jwB3wRvf5cbTYA/+IqCifYOJM1S0j1Uy4vcTgCMGKwzP
         dSHtSWqJmEUgT1q+1BeoeC97j7KFCz57ZinZS72qvtDSG7ThxZr5PCG6a2peCH8Ku0Mz
         jjobKwUZhocDwX16bBRY5Vwp2KwxfDMxqklKpkG4SKuPlZvMsrn8WNhjFDuFsmPp86MF
         /EjD7KB5DEsTmDMab14aecaw9FDpfISMOd2blQ+rXiPfjq03OIvDLHqVIa1YyYOus8sn
         4/7zHja54HzEsODNv+vINWVaQ6TuFoZm7l9BMGSpYxW/zgAPcc8UrmOiAyp9UgQzkXGv
         N7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bTJywUAqX3j6iJePWZLrUnkk/lwpRK52+zopJgYfdMg=;
        b=DqP8U98vd7fnolMj11hBaWXzh/S2PYnWvkGAmG/UIGv/CVI4AhsaesnQuao8JKEtBe
         nvIK2aw04XT/35qJtiKpHu5PAEJ7UOMmWgJ7hTH2s9seslJsWmaHNG4RcAUB72IbrgMS
         0iw2qMST+tONgKH/UDZaC3qTq9qzeNQbNQlEBB4pPPD71X/yF6cvCfKk9ykLgqTY8XdJ
         O1KRt2GU+IEtLI6lYwy2VPcvrOQ5+U1tfy5jtS6ltTLczNlP6aATx/DrOiznHtUBUt6y
         Nf6taAihdXts1zFkpT4yaQuAwQ6R9E4HowHbTEC1ljS47ikUCDclAAidXZ/8cRhM9fnt
         QesQ==
X-Gm-Message-State: AJIora8AP7BXTpGn+W1vsQfupc6T9YKDeo/Je5Q/Kxg4P7I7XtofKq34
        hJVGC8H3jDLv0XO1vYu8HNE=
X-Google-Smtp-Source: AGRyM1ttUhenzTJiVmVOnzL8/ifpXfD1MqX6UtPYQTK96Gt2UOwRrC6FhJ0GfovX6/AxhVd4rwNyXw==
X-Received: by 2002:a6b:c30c:0:b0:67b:963a:c6ef with SMTP id t12-20020a6bc30c000000b0067b963ac6efmr14712469iof.137.1658187866695;
        Mon, 18 Jul 2022 16:44:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:71f7:9f7:a010:d581? ([2600:1700:2442:6db0:71f7:9f7:a010:d581])
        by smtp.gmail.com with ESMTPSA id y2-20020a926402000000b002dc0ccc4cafsm5191201ilb.49.2022.07.18.16.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 16:44:26 -0700 (PDT)
Message-ID: <725f870b-b927-352d-85ab-675b91b7c75a@gmail.com>
Date:   Mon, 18 Jul 2022 18:44:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] of: overlay: rename overlay source files from .dts
 to .dtso
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20220503211954.1428919-1-frowand.list@gmail.com>
 <CAMuHMdWhn8cY4usyqao-osEcSCcmkU+NYg21co+GxVfvg5+dhw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAMuHMdWhn8cY4usyqao-osEcSCcmkU+NYg21co+GxVfvg5+dhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/7/22 02:21, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Tue, May 3, 2022 at 11:20 PM <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> In drivers/of/unittest-data/:
>>    - Rename .dts overlay source files to use .dtso suffix.
>>    - Add Makefile rule to build .dtbo.o assembly file from overlay
>>      .dtso source file.
>>    - Update Makefile to build .dtbo.o objects instead of .dtb.o from
>>      unittest overlay source files.
>>
>> Modify driver/of/unitest.c to use .dtbo.o based symbols instead of
>> .dtb.o
>>
>> Modify scripts/Makefile.lib %.dtbo rule to depend upon %.dtso instead
>> of %.dts
>>
>> Rename .dts overlay source files to use .dtso suffix in:
>>    arch/arm64/boot/dts/freescale/
>>    arch/arm64/boot/dts/xilinx/
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> What is the status of this work?
> Thanks!

I'll work on this tomorrow after I test your overlay improvement patches.

-Frank

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

