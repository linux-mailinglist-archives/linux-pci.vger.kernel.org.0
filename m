Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19351B13C
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 23:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiEDVo0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378918AbiEDVoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 17:44:11 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610AA4AE04;
        Wed,  4 May 2022 14:40:33 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z18so2921092iob.5;
        Wed, 04 May 2022 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7pMVwD47RM1PFqynXyEgTOlvIm8nvv7hB1Tv3GlOAM0=;
        b=lj+qCsdttvGjAEXZ0lqXkgbGF+eJvJWJIHh2d5EsE5ID1qq5zghgi6ihfKm91OPzaG
         BhSOue/GpnvbjJ7CDX5BjfK0/q9wzqh2bt1AgRSqEunV/jI/5MHk5G59R9J/SJc8+3bq
         smEWH6ktpAdPzdBVjJquED1IVIITHPGTQG9IcWhu6RfLeK6cAMRnOm4+kaQCDlUTJ/K/
         2W9PVSaN6ZHG25nIhKckYaRmPU03l0YzS3bYHDEprE5xd1Y35KsvkZS8kFYpqFpamEWO
         OTLEGu1UoXcMz6/CsuVFENM45olbyelHmi2ogGZqUGonOGNfeKloxz+VNo2frcLEjkCh
         8jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7pMVwD47RM1PFqynXyEgTOlvIm8nvv7hB1Tv3GlOAM0=;
        b=S4+UO60e/6x2BzBpEKCWXqW6uG9A74Pmb/1RjMr9BF1soaAoeOmXt2sD7/sJsd+kCk
         pbsMnv3R+cu8Ch4cKQl3/swAXxtGhOSATvsq3nvbjVlDX0vpyncM9JMGvcr9lr80aDam
         ddkzTtSBPkT2VHWbJ2zp3DyM5PSzsmikIe5mh8i5ythb/l4UG06tyYjyCSdlOICn6ItT
         FecVlVDaswNE/VYURnsl5q+RHtYOYdUUd1QM9PHtz1qeov7xEM5HSwoMGXsW97J5TwIi
         4bThv2f2Gt8xD6YPTvdy0FdgBmsrIEZeDbiAWKfsfUEvn83ks7F+7fREjQDvXXNnNl3H
         ACtw==
X-Gm-Message-State: AOAM531VDaDJC6joN5qk3DHy/jOZgp+RGPKrCepd2CkWxx8tkNQrzOyW
        66cEL3dSzk7IOCHkwd2cINI=
X-Google-Smtp-Source: ABdhPJw2GJTpq9f4BjSW8Mn6CbgARaPkrJ9Auty6+zNgCryt/SEsi2WRogD9c4Vk1Ans/fiN9VluRA==
X-Received: by 2002:a05:6602:1687:b0:65a:856f:42e3 with SMTP id s7-20020a056602168700b0065a856f42e3mr5170910iow.121.1651700432692;
        Wed, 04 May 2022 14:40:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:5871:54:c73e:3c22? ([2600:1700:2442:6db0:5871:54:c73e:3c22])
        by smtp.gmail.com with ESMTPSA id u6-20020a022e46000000b0032b3a781799sm18053jae.93.2022.05.04.14.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 14:40:32 -0700 (PDT)
Message-ID: <dcf137b0-9f5c-07b5-e348-a99060136511@gmail.com>
Date:   Wed, 4 May 2022 16:40:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] of: overlay: rename overlay source files from .dts
 to .dtso
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
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
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>
References: <20220503211954.1428919-1-frowand.list@gmail.com>
 <CAL_JsqKqBWKWzQC1qXABuiC6b3OgwfO+c5-fpGz=AgSUSCHCcA@mail.gmail.com>
 <dc72de86-af22-84e3-53fa-8a3958a08fb6@gmail.com>
 <CAL_Jsq+YzYaQMrPjtp0yCRy0dqL2Me+GcLbmj_Drv=XVdvWqdw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_Jsq+YzYaQMrPjtp0yCRy0dqL2Me+GcLbmj_Drv=XVdvWqdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/4/22 16:08, Rob Herring wrote:
> On Wed, May 4, 2022 at 3:42 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/3/22 16:42, Rob Herring wrote:
>>> On Tue, May 3, 2022 at 4:20 PM <frowand.list@gmail.com> wrote:
>>>>
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> In drivers/of/unittest-data/:
>>>>    - Rename .dts overlay source files to use .dtso suffix.
>>>>    - Add Makefile rule to build .dtbo.o assembly file from overlay
>>>>      .dtso source file.
>>>>    - Update Makefile to build .dtbo.o objects instead of .dtb.o from
>>>>      unittest overlay source files.
>>>>
>>>> Modify driver/of/unitest.c to use .dtbo.o based symbols instead of
>>>> .dtb.o
>>>>
>>>> Modify scripts/Makefile.lib %.dtbo rule to depend upon %.dtso instead
>>>> of %.dts
>>>>
>>>> Rename .dts overlay source files to use .dtso suffix in:
>>>>    arch/arm64/boot/dts/freescale/
>>>>    arch/arm64/boot/dts/xilinx/
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>
>>>> Testing by arm64 people would be much appreciated.
>>>>
>>>> Applies on branch dt/next, commit 4fb74186cee8 of Rob's kernel.org tree.
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
>>>>
>>>> version 1 patch:
>>>>    https://lore.kernel.org/r/20210324223713.1334666-1-frowand.list@gmail.com
>>>>
>>>> changes from version 1:
>>>>    - rebase to 5.18-rc1 plus many patches already accepted by Rob
>>>>      Applies on branch dt/next, commit 4fb74186cee8 of Rob's kernel.org tree.
>>>>    - Add new overlay source files in:
>>>>       arch/arm64/boot/dts/freescale/
>>>>       arch/arm64/boot/dts/xilinx/
>>>
>>> I can't apply these. They need to be applied separately. And probably
>>> at end of the merge window or right after rc1 (IOW, coordinated with
>>> SoC maintainers in advance). Or we support both forms for a cycle.
>>
>> If applied separately then git bisect is broken.  I don't see this change
>> as being big enough to be considered a "flag day" change, but if I can't
>> get the SoC maintainers to ack you pulling these renames then I can easily
>> re-spin in a way to support both forms for a release cycle.
>>
>>>
>>> [...]
>>>
>>>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>>>> index d072f3ba3971..df2ca1820273 100644
>>>> --- a/drivers/of/unittest-data/Makefile
>>>> +++ b/drivers/of/unittest-data/Makefile
>>>> @@ -1,38 +1,58 @@
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>> -obj-y += testcases.dtb.o
>>>>
>>>> -obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
>>>> -                           overlay_0.dtb.o \
>>>> -                           overlay_1.dtb.o \
>>>> -                           overlay_2.dtb.o \
>>>> -                           overlay_3.dtb.o \
>>>> -                           overlay_4.dtb.o \
>>>> -                           overlay_5.dtb.o \
>>>> -                           overlay_6.dtb.o \
>>>> -                           overlay_7.dtb.o \
>>>> -                           overlay_8.dtb.o \
>>>> -                           overlay_9.dtb.o \
>>>> -                           overlay_10.dtb.o \
>>>> -                           overlay_11.dtb.o \
>>>> -                           overlay_12.dtb.o \
>>>> -                           overlay_13.dtb.o \
>>>> -                           overlay_15.dtb.o \
>>>> -                           overlay_16.dtb.o \
>>>> -                           overlay_17.dtb.o \
>>>> -                           overlay_18.dtb.o \
>>>> -                           overlay_19.dtb.o \
>>>> -                           overlay_20.dtb.o \
>>>> -                           overlay_bad_add_dup_node.dtb.o \
>>>> -                           overlay_bad_add_dup_prop.dtb.o \
>>>> -                           overlay_bad_phandle.dtb.o \
>>>> -                           overlay_bad_symbol.dtb.o \
>>>> -                           overlay_base.dtb.o \
>>>> -                           overlay_gpio_01.dtb.o \
>>>> -                           overlay_gpio_02a.dtb.o \
>>>> -                           overlay_gpio_02b.dtb.o \
>>>> -                           overlay_gpio_03.dtb.o \
>>>> -                           overlay_gpio_04a.dtb.o \
>>>> -                           overlay_gpio_04b.dtb.o
>>>> +# Generate an assembly file to wrap the output of the device tree compiler
>>>> +quiet_cmd_dt_S_dtbo= DTB     $@
>>>> +cmd_dt_S_dtbo=\
>>>> +{                                                      \
>>>> +       echo '\#include <asm-generic/vmlinux.lds.h>';   \
>>>> +       echo '.section .dtb.init.rodata,"a"';           \
>>>> +       echo '.balign STRUCT_ALIGNMENT';                \
>>>> +       echo '.global __dtbo_$(subst -,_,$(*F))_begin'; \
>>>> +       echo '__dtbo_$(subst -,_,$(*F))_begin:';        \
>>>> +       echo '.incbin "$<" ';                           \
>>>> +       echo '__dtbo_$(subst -,_,$(*F))_end:';          \
>>>> +       echo '.global __dtbo_$(subst -,_,$(*F))_end';   \
>>>> +       echo '.balign STRUCT_ALIGNMENT';                \
>>>> +} > $@
>>>> +
>>>> +
>>>> +$(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
>>>> +       $(call if_changed,dt_S_dtbo)
>>>
>>> Humm, this belongs in scripts/Makefile.lib.
>>
>> I would rather keep it isolated to just the use in unittest.
>> We just now got rid of the final driver use of of_overlay_fdt_apply()
>> by the grandfathered legacy user in:
>>
>>    841281fe52a7 drm: rcar-du: Drop LVDS device tree backward compatibility
>>
>> That driver was the only use of %.dtb.S for an overlay.
> 
> I'd actually prefer more drivers handling compatibility this way than
> handling old and new DTs in code. That's easier to find and when
> compatibility with old DTs is no longer needed we can just remove the
> fixup overlay. Though I guess that one was a lot of code too, but that
> would probably be mitigated if we had multiple users. Anyways, that's
> a side issue.

If I remember correctly, that is a total reversal of previous discussions
and policy decisions.

My previous position has been to not have drivers applying overlays.
I'll have to step back and revisit the concept, trying to set aside
my previous assumptions and conclusions.

But before I go away and revisit, there is one thing to mention.  Now
that you have machine parseable bindings (and many of them implemented)
and also a method to statically validate overlays applied on top of
specific base .dtbs (that is the purpose of the arch/arm64/dts/* files
that I renamed in this patch, right?), allowing drivers to dynamically
apply overlays, potentially after modifying the base devicetree (that's
the other patch series I need to be reviewing at the moment...) reduces
the validation coverage.

> 
> .dtb.S is an intermediate format that no one looks at. The arguments
> for knowing what the file is don't really apply to it. We should do
> here whatever makes the makefiles the simplest.
> 
>> I can't eliminate the rule for %.dtb.S because that is used in several
>> cases for building the system FDT into the kernel.  But having this
>> rule in drivers/of/unittest-data/Makefile provides consistent naming
>> of overlays withing unittest.  Helping to make it clear that they are
>> not a system FDT.
> 
> But if they are in one spot you can make that whole unreadable mess of
> a command a macro with '.dtb.S' becoming a variable. Then we have 1
> unreadable blob and when someone goes to fix something in it, they
> don't have to find our hidden copy.> 
>>> I don't think we need a different section name with __dtbo_* instead
>>> of __dtb_* if that simplifies the Makefile.
>>
>> A different section name is not needed if the rule is moved to
>> scripts/Makefile.lib but even if moved there, I prefer to keep the
>> overlay data clearly delineated from the system FDT data.
> 
> At least make that a separate patch then.

OK, will do.

> 
> Rob

