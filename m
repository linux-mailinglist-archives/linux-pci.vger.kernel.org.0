Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236C017EEBD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 03:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCJCia (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 22:38:30 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56682 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbgCJCi3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 22:38:29 -0400
Received: from [10.130.0.70] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2mZ_WZeQgcZAA--.51S3;
        Tue, 10 Mar 2020 10:38:19 +0800 (CST)
Subject: =?UTF-8?Q?Re:_=e5=9b=9e=e5=a4=8d:[PATCH_3/6]_MIPS:_Loongson:_Use_fi?=
 =?UTF-8?Q?rmware_arguments_to_get_board_name?=
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
 <1583742206-29163-4-git-send-email-yangtiezhu@loongson.cn>
 <170be7063d1.c7d52ae02285.4730966984142345992@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ide <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d01a5855-5b77-e792-a48c-49f2d153523e@loongson.cn>
Date:   Tue, 10 Mar 2020 10:38:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <170be7063d1.c7d52ae02285.4730966984142345992@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxj2mZ_WZeQgcZAA--.51S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy3WFW8Zry3Jr4rWF1xXwb_yoW5Wr45pa
        n3Aa4vgr45Kr17ur98trW3Crnaya98KFs7GFW2v3WUKa4DKw1aqF98G3W8GrZrAF1UKFy0
        qryfKr4kCa1xG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF3kuDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/09/2020 04:36 PM, Jiaxun Yang wrote:
>
>   ---- 在 星期一, 2020-03-09 16:23:23 Tiezhu Yang <yangtiezhu@loongson.cn> 撰写 ----
>   > In order to distinguish various types of bridge chip such as AMD RS780E
>   > or Loongson 7A1000, we can use firmware arguments to get board name.
>   >
> Hi Tiezhu,
>
> Thanks for your contribution.
> Your series is sightly conflict with my "modernize" series. But that's fine,
> if your code can meet mainline requirement, I'm going to adjust my works.

Hi Jiaxun,

Thanks very much for your kindly reply.

>
> See my comments bellow.
>
>   > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>   > ---
>   >  arch/mips/include/asm/mach-loongson64/boot_param.h | 1 +
>   >  arch/mips/loongson64/env.c                         | 5 +++++
>   >  2 files changed, 6 insertions(+)
>   >
>   > diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
>   > index 8c286be..225a563 100644
>   > --- a/arch/mips/include/asm/mach-loongson64/boot_param.h
>   > +++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
>   > @@ -217,5 +217,6 @@ struct loongson_system_configuration {
>   >
>   >  extern struct efi_memory_map_loongson *loongson_memmap;
>   >  extern struct loongson_system_configuration loongson_sysconf;
>   > +extern struct board_devices *eboard;
>   >
>   >  #endif
>   > diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
>   > index 0daeb7b..a244a8c 100644
>   > --- a/arch/mips/loongson64/env.c
>   > +++ b/arch/mips/loongson64/env.c
>   > @@ -24,6 +24,9 @@ EXPORT_SYMBOL(cpu_clock_freq);
>   >  struct efi_memory_map_loongson *loongson_memmap;
>   >  struct loongson_system_configuration loongson_sysconf;
>   >
>   > +struct board_devices *eboard;
>   > +EXPORT_SYMBOL(eboard);
>
> Can we make it as a part of struct loongson_sysconf and export that struct?
> Memory of struct eboard is not managed by kernel,  we shouldn't export such symbol.

OK, I will do it.

>
> Also I noticed that you're checking PCH type repeatly in other subsystems. Can you just
> determine the PCH type here?

Yes, of course.

Thanks,

Tiezhu Yang

>
>   > +
>   >  u64 loongson_chipcfg[MAX_PACKAGES] = {0xffffffffbfc00180};
>   >  u64 loongson_chiptemp[MAX_PACKAGES];
>   >  u64 loongson_freqctrl[MAX_PACKAGES];
>   > @@ -51,6 +54,8 @@ void __init prom_init_env(void)
>   >          ((u64)loongson_p + loongson_p->system_offset);
>   >      ecpu = (struct efi_cpuinfo_loongson *)
>   >          ((u64)loongson_p + loongson_p->cpu_offset);
>   > +    eboard = (struct board_devices *)
>   > +        ((u64)loongson_p + loongson_p->boarddev_table_offset);
>   >      eirq_source = (struct irq_source_routing_table *)
>   >          ((u64)loongson_p + loongson_p->irq_offset);
>   >      loongson_memmap = (struct efi_memory_map_loongson *)
>   > --
>   > 2.1.0
>   >
>   >

