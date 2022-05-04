Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9451AF96
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbiEDUqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353672AbiEDUqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 16:46:01 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6C95133D;
        Wed,  4 May 2022 13:42:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x22so1801322qto.2;
        Wed, 04 May 2022 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v6DLoX9H171xAWvh1FTxcKgm9Suih5LJx6upFl4sT9o=;
        b=FZCOM2Ku1I/B+PNyQcumfK6reTSU9R/PQngfBkAdJra7zr4F5+alEiyj9K0PoNETeY
         ycGii1QtGvlCFmP6TKUIeO8t/Ezciyd3a6KZHXBBDzW+rLQfJwzoHYPNiMhRDgvp1d/Q
         8fcUQTbdessRxvcoM0GpcjYgkbJfeCDu2GMKnsCkV55p883I6wkd2pr2pKF0Agpq5KoK
         3eFY0sTW6YDUvaPQVprCBPTPWGoY9YBrgjtSbQ4bBWrLD98p1GWISDQDF1FCHmqaEFUS
         CnBcb01xGsNf5aactdb8KmunxxZ+w7Tzzgxldgz7BpH6ebkmoiOmBW8mOWOj3lbxI17i
         ejqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v6DLoX9H171xAWvh1FTxcKgm9Suih5LJx6upFl4sT9o=;
        b=FLurCLDIVYACXWEDrKGDlB4dExWW0MeGAqV1jtkq9k2KgI5ezgnevH0JXoMGynan5n
         egL+P/Qos5OIj1JfPCUxS+IYhoDAwnn7SWr705BqPrnNg/x4tAfz9jSiFM62Oj3FZu6C
         YZrZBOgVtwxEdXREBSCQhmQtWNY2jjiKhtPL2d6xz7lqPmTWiq+otK8sdHkJNQdaqRp6
         KLifKBe1kvYxpjvmHXvHxfXN/kABlNFnQzmEjJe1V0BJzQuWQ4D1JdZT343M2sYuKWcM
         x/vG/Qy/P4BhWR2hlZfOJ0ckfOm4pvIhQ0O2LehxjsNuEPD36QS+FyPH+M20WKfC2QEd
         0u+Q==
X-Gm-Message-State: AOAM532oots9kqjXpK8AWEY3078Bf+oHr7pWSZUFi4GJcC8zTnYaWvCY
        6ZY266V4X0Vxtc2h29OUJFk=
X-Google-Smtp-Source: ABdhPJxLeRMd/FVABPBHJlb/F2L2PxDLgXfPNV7qr6Rm0k+hqdM7blTM09HvpVGDaJmvoS9Gj40lOg==
X-Received: by 2002:a05:622a:290:b0:2f3:b28d:22a with SMTP id z16-20020a05622a029000b002f3b28d022amr7411844qtw.446.1651696942165;
        Wed, 04 May 2022 13:42:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:5871:54:c73e:3c22? ([2600:1700:2442:6db0:5871:54:c73e:3c22])
        by smtp.gmail.com with ESMTPSA id m21-20020ac84455000000b002f39b99f674sm7944344qtn.14.2022.05.04.13.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 13:42:21 -0700 (PDT)
Message-ID: <dc72de86-af22-84e3-53fa-8a3958a08fb6@gmail.com>
Date:   Wed, 4 May 2022 15:42:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] of: overlay: rename overlay source files from .dts
 to .dtso
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
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
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqKqBWKWzQC1qXABuiC6b3OgwfO+c5-fpGz=AgSUSCHCcA@mail.gmail.com>
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

On 5/3/22 16:42, Rob Herring wrote:
> On Tue, May 3, 2022 at 4:20 PM <frowand.list@gmail.com> wrote:
>>
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
>> ---
>>
>> Testing by arm64 people would be much appreciated.
>>
>> Applies on branch dt/next, commit 4fb74186cee8 of Rob's kernel.org tree.
>> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
>>
>> version 1 patch:
>>    https://lore.kernel.org/r/20210324223713.1334666-1-frowand.list@gmail.com
>>
>> changes from version 1:
>>    - rebase to 5.18-rc1 plus many patches already accepted by Rob
>>      Applies on branch dt/next, commit 4fb74186cee8 of Rob's kernel.org tree.
>>    - Add new overlay source files in:
>>       arch/arm64/boot/dts/freescale/
>>       arch/arm64/boot/dts/xilinx/
> 
> I can't apply these. They need to be applied separately. And probably
> at end of the merge window or right after rc1 (IOW, coordinated with
> SoC maintainers in advance). Or we support both forms for a cycle.

If applied separately then git bisect is broken.  I don't see this change
as being big enough to be considered a "flag day" change, but if I can't
get the SoC maintainers to ack you pulling these renames then I can easily
re-spin in a way to support both forms for a release cycle.

> 
> [...]
> 
>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>> index d072f3ba3971..df2ca1820273 100644
>> --- a/drivers/of/unittest-data/Makefile
>> +++ b/drivers/of/unittest-data/Makefile
>> @@ -1,38 +1,58 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -obj-y += testcases.dtb.o
>>
>> -obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
>> -                           overlay_0.dtb.o \
>> -                           overlay_1.dtb.o \
>> -                           overlay_2.dtb.o \
>> -                           overlay_3.dtb.o \
>> -                           overlay_4.dtb.o \
>> -                           overlay_5.dtb.o \
>> -                           overlay_6.dtb.o \
>> -                           overlay_7.dtb.o \
>> -                           overlay_8.dtb.o \
>> -                           overlay_9.dtb.o \
>> -                           overlay_10.dtb.o \
>> -                           overlay_11.dtb.o \
>> -                           overlay_12.dtb.o \
>> -                           overlay_13.dtb.o \
>> -                           overlay_15.dtb.o \
>> -                           overlay_16.dtb.o \
>> -                           overlay_17.dtb.o \
>> -                           overlay_18.dtb.o \
>> -                           overlay_19.dtb.o \
>> -                           overlay_20.dtb.o \
>> -                           overlay_bad_add_dup_node.dtb.o \
>> -                           overlay_bad_add_dup_prop.dtb.o \
>> -                           overlay_bad_phandle.dtb.o \
>> -                           overlay_bad_symbol.dtb.o \
>> -                           overlay_base.dtb.o \
>> -                           overlay_gpio_01.dtb.o \
>> -                           overlay_gpio_02a.dtb.o \
>> -                           overlay_gpio_02b.dtb.o \
>> -                           overlay_gpio_03.dtb.o \
>> -                           overlay_gpio_04a.dtb.o \
>> -                           overlay_gpio_04b.dtb.o
>> +# Generate an assembly file to wrap the output of the device tree compiler
>> +quiet_cmd_dt_S_dtbo= DTB     $@
>> +cmd_dt_S_dtbo=\
>> +{                                                      \
>> +       echo '\#include <asm-generic/vmlinux.lds.h>';   \
>> +       echo '.section .dtb.init.rodata,"a"';           \
>> +       echo '.balign STRUCT_ALIGNMENT';                \
>> +       echo '.global __dtbo_$(subst -,_,$(*F))_begin'; \
>> +       echo '__dtbo_$(subst -,_,$(*F))_begin:';        \
>> +       echo '.incbin "$<" ';                           \
>> +       echo '__dtbo_$(subst -,_,$(*F))_end:';          \
>> +       echo '.global __dtbo_$(subst -,_,$(*F))_end';   \
>> +       echo '.balign STRUCT_ALIGNMENT';                \
>> +} > $@
>> +
>> +
>> +$(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
>> +       $(call if_changed,dt_S_dtbo)
> 
> Humm, this belongs in scripts/Makefile.lib.

I would rather keep it isolated to just the use in unittest.
We just now got rid of the final driver use of of_overlay_fdt_apply()
by the grandfathered legacy user in:

   841281fe52a7 drm: rcar-du: Drop LVDS device tree backward compatibility

That driver was the only use of %.dtb.S for an overlay.

I can't eliminate the rule for %.dtb.S because that is used in several
cases for building the system FDT into the kernel.  But having this
rule in drivers/of/unittest-data/Makefile provides consistent naming
of overlays withing unittest.  Helping to make it clear that they are
not a system FDT.

> 
> I don't think we need a different section name with __dtbo_* instead
> of __dtb_* if that simplifies the Makefile.

A different section name is not needed if the rule is moved to
scripts/Makefile.lib but even if moved there, I prefer to keep the
overlay data clearly delineated from the system FDT data.

There is also a kernel test robot email warning about randconfig
arc build errors:

>> make[4]: *** No rule to make target 'drivers/of/unittest-data/static_base_1.dtb', needed by 'drivers/of/unittest-data/static_test_1.dtb'.
>> make[4]: *** No rule to make target 'drivers/of/unittest-data/static_base_2.dtb', needed by 'drivers/of/unittest-data/static_test_2.dtb'.

They look like a pre-existing problem, not new.  I'll get their
build environment and see what's going on.

-Frank

> 
>> +
>> +obj-y += testcases.dtbo.o
>> +
>> +obj-$(CONFIG_OF_OVERLAY) += overlay.dtbo.o \
>> +                           overlay_0.dtbo.o \
>> +                           overlay_1.dtbo.o \
>> +                           overlay_2.dtbo.o \
>> +                           overlay_3.dtbo.o \
>> +                           overlay_4.dtbo.o \
>> +                           overlay_5.dtbo.o \
>> +                           overlay_6.dtbo.o \
>> +                           overlay_7.dtbo.o \
>> +                           overlay_8.dtbo.o \
>> +                           overlay_9.dtbo.o \
>> +                           overlay_10.dtbo.o \
>> +                           overlay_11.dtbo.o \
>> +                           overlay_12.dtbo.o \
>> +                           overlay_13.dtbo.o \
>> +                           overlay_15.dtbo.o \
>> +                           overlay_16.dtbo.o \
>> +                           overlay_17.dtbo.o \
>> +                           overlay_18.dtbo.o \
>> +                           overlay_19.dtbo.o \
>> +                           overlay_20.dtbo.o \
>> +                           overlay_bad_add_dup_node.dtbo.o \
>> +                           overlay_bad_add_dup_prop.dtbo.o \
>> +                           overlay_bad_phandle.dtbo.o \
>> +                           overlay_bad_symbol.dtbo.o \
>> +                           overlay_base.dtbo.o \
>> +                           overlay_gpio_01.dtbo.o \
>> +                           overlay_gpio_02a.dtbo.o \
>> +                           overlay_gpio_02b.dtbo.o \
>> +                           overlay_gpio_03.dtbo.o \
>> +                           overlay_gpio_04a.dtbo.o \
>> +                           overlay_gpio_04b.dtbo.o
>>
>>  # enable creation of __symbols__ node
>>  DTC_FLAGS_overlay += -@
> 
> 
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index dff55ae09d97..1d3c170d95db 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1423,12 +1423,12 @@ static int __init unittest_data_add(void)
>>         void *unittest_data_align;
>>         struct device_node *unittest_data_node = NULL, *np;
>>         /*
>> -        * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
>> -        * created by cmd_dt_S_dtb in scripts/Makefile.lib
>> +        * __dtbo_testcases_begin[] and __dtbo_testcases_end[] are
>> +        * created by cmd_dt_S_dtbo in Makefile
>>          */
>> -       extern uint8_t __dtb_testcases_begin[];
>> -       extern uint8_t __dtb_testcases_end[];
>> -       const int size = __dtb_testcases_end - __dtb_testcases_begin;
>> +       extern uint8_t __dtbo_testcases_begin[];
>> +       extern uint8_t __dtbo_testcases_end[];
>> +       const int size = __dtbo_testcases_end - __dtbo_testcases_begin;
>>         int rc;
>>         void *ret;
>>
>> @@ -1443,7 +1443,7 @@ static int __init unittest_data_add(void)
>>                 return -ENOMEM;
>>
>>         unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
>> -       memcpy(unittest_data_align, __dtb_testcases_begin, size);
>> +       memcpy(unittest_data_align, __dtbo_testcases_begin, size);
>>
>>         ret = of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
>>         if (!ret) {
>> @@ -3009,24 +3009,24 @@ static inline void __init of_unittest_overlay(void) { }
>>  #ifdef CONFIG_OF_OVERLAY
>>
>>  /*
>> - * __dtb_ot_begin[] and __dtb_ot_end[] are created by cmd_dt_S_dtb
>> - * in scripts/Makefile.lib
>> + * __dtbo_##overlay_name##_begin[] and __dtbo_##overlay_name##_end[] are
>> + * created by cmd_dt_S_dtbo in Makefile
>>   */
>>
>> -#define OVERLAY_INFO_EXTERN(name) \
>> -       extern uint8_t __dtb_##name##_begin[]; \
>> -       extern uint8_t __dtb_##name##_end[]
>> +#define OVERLAY_INFO_EXTERN(overlay_name) \
>> +       extern uint8_t __dtbo_##overlay_name##_begin[]; \
>> +       extern uint8_t __dtbo_##overlay_name##_end[]
>>
>> -#define OVERLAY_INFO(overlay_name, expected)             \
>> -{      .dtb_begin       = __dtb_##overlay_name##_begin, \
>> -       .dtb_end         = __dtb_##overlay_name##_end,   \
>> -       .expected_result = expected,                     \
>> -       .name            = #overlay_name,                \
>> +#define OVERLAY_INFO(overlay_name, expected)               \
>> +{      .dtbo_begin       = __dtbo_##overlay_name##_begin, \
>> +       .dtbo_end         = __dtbo_##overlay_name##_end,   \
>> +       .expected_result = expected,                       \
>> +       .name            = #overlay_name,                  \
>>  }
>>
>>  struct overlay_info {
>> -       uint8_t         *dtb_begin;
>> -       uint8_t         *dtb_end;
>> +       uint8_t         *dtbo_begin;
>> +       uint8_t         *dtbo_end;
> 
> Is this rename really needed?
> 
>>         int             expected_result;
>>         int             ovcs_id;
>>         char            *name;
>> @@ -3100,7 +3100,7 @@ static struct overlay_info overlays[] = {
>>         OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
>>         OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
>>         /* end marker */
>> -       {.dtb_begin = NULL, .dtb_end = NULL, .expected_result = 0, .name = NULL}
>> +       {.dtbo_begin = NULL, .dtbo_end = NULL, .expected_result = 0, .name = NULL}
>>  };
>>
>>  static struct device_node *overlay_base_root;
>> @@ -3157,13 +3157,13 @@ void __init unittest_unflatten_overlay_base(void)
>>                 return;
>>         }
>>
>> -       data_size = info->dtb_end - info->dtb_begin;
>> +       data_size = info->dtbo_end - info->dtbo_begin;
>>         if (!data_size) {
>>                 pr_err("No dtb 'overlay_base' to attach\n");
>>                 return;
>>         }
>>
>> -       size = fdt_totalsize(info->dtb_begin);
>> +       size = fdt_totalsize(info->dtbo_begin);
>>         if (size != data_size) {
>>                 pr_err("dtb 'overlay_base' header totalsize != actual size");
>>                 return;
>> @@ -3175,7 +3175,7 @@ void __init unittest_unflatten_overlay_base(void)
>>                 return;
>>         }
>>
>> -       memcpy(new_fdt, info->dtb_begin, size);
>> +       memcpy(new_fdt, info->dtbo_begin, size);
>>
>>         __unflatten_device_tree(new_fdt, NULL, &overlay_base_root,
>>                                 dt_alloc_memory, true);
>> @@ -3210,11 +3210,11 @@ static int __init overlay_data_apply(const char *overlay_name, int *ovcs_id)
>>                 return 0;
>>         }
>>
>> -       size = info->dtb_end - info->dtb_begin;
>> +       size = info->dtbo_end - info->dtbo_begin;
>>         if (!size)
>>                 pr_err("no overlay data for %s\n", overlay_name);
>>
>> -       ret = of_overlay_fdt_apply(info->dtb_begin, size, &info->ovcs_id);
>> +       ret = of_overlay_fdt_apply(info->dtbo_begin, size, &info->ovcs_id);
>>         if (ovcs_id)
>>                 *ovcs_id = info->ovcs_id;
>>         if (ret < 0)
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 9f69ecdd7977..b409bec5fa45 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -363,7 +363,7 @@ endef
>>  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>>         $(call if_changed_rule,dtc)
>>
>> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>> +$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
>>         $(call if_changed_dep,dtc)
>>
>>  dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>

