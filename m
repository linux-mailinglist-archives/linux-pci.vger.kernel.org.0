Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8DC17EEC3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 03:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgCJCk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 22:40:29 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57052 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgCJCk2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 22:40:28 -0400
Received: from [10.130.0.70] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD98S_mZeWgcZAA--.47S3;
        Tue, 10 Mar 2020 10:40:19 +0800 (CST)
Subject: =?UTF-8?Q?Re:_=e5=9b=9e=e5=a4=8d:[PATCH_4/6]_MIPS:_Loongson:_Add_DM?=
 =?UTF-8?Q?A_support_for_7A1000?=
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
 <1583742206-29163-5-git-send-email-yangtiezhu@loongson.cn>
 <170be7768e3.c920b6d62296.161774605460069850@flygoat.com>
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
Message-ID: <a2f747e6-500e-0a4a-9e63-397b4aa0191f@loongson.cn>
Date:   Tue, 10 Mar 2020 10:40:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <170be7768e3.c920b6d62296.161774605460069850@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxD98S_mZeWgcZAA--.47S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4fAr17Gr1DWFWkJw15XFb_yoW7Xr4DpF
        Z7Aa1rGr4Yqr1UuFySg3yxWry5ZrZ5tr4IqFW2gF1Yka4qvw1rJF1UCryqgw1fAr48KF18
        ZrW0gF1fuF47KFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbN6pPUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/09/2020 04:44 PM, Jiaxun Yang wrote:
>
>   ---- 在 星期一, 2020-03-09 16:23:24 Tiezhu Yang <yangtiezhu@loongson.cn> 撰写 ----
>   > Implement __phys_to_dma() and __dma_to_phys() according to the
>   > node id offset in 7A1000 DMA route config register.
>
> That design shocked me a lot. And It is known that some firmware didn't configure
> HT Recieve window correctly to make it work. So probably for mainline kernel,
> just set DMA_MASK to limit LS7A DMA address to Node0 would be a better Option?

Hi Jiaxun,

Let me rethink it and find a proper way.

>   
>   > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>   > ---
>   >  arch/mips/include/asm/mach-loongson64/boot_param.h |  1 +
>   >  arch/mips/loongson64/dma.c                         | 49 +++++++++++++++++++++-
>   >  arch/mips/loongson64/init.c                        | 13 ++++++
>   >  3 files changed, 61 insertions(+), 2 deletions(-)
>   >
>   > diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
>   > index 225a563..60e7a7e 100644
>   > --- a/arch/mips/include/asm/mach-loongson64/boot_param.h
>   > +++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
>   > @@ -218,5 +218,6 @@ struct loongson_system_configuration {
>   >  extern struct efi_memory_map_loongson *loongson_memmap;
>   >  extern struct loongson_system_configuration loongson_sysconf;
>   >  extern struct board_devices *eboard;
>   > +extern u32 node_id_offset;
>   >
>   >  #endif
>   > diff --git a/arch/mips/loongson64/dma.c b/arch/mips/loongson64/dma.c
>   > index 5e86635..997c257 100644
>   > --- a/arch/mips/loongson64/dma.c
>   > +++ b/arch/mips/loongson64/dma.c
>   > @@ -2,24 +2,69 @@
>   >  #include <linux/dma-direct.h>
>   >  #include <linux/init.h>
>   >  #include <linux/swiotlb.h>
>   > +#include <boot_param.h>
>   >
>   > -dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>   > +struct loongson_dma_ops {
>   > +    dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
>   > +    phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
>   > +};
>   > +
>   > +struct loongson_dma_ops loongson_dma;
>   > +
>   > +dma_addr_t __rs780e_phys_to_dma(struct device *dev, phys_addr_t paddr)
>   >  {
>   >      /* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
>   >       * Loongson-3's 48bit address space and embed it into 40bit */
>   >      long nid = (paddr >> 44) & 0x3;
>   > +
>   >      return ((nid << 44) ^ paddr) | (nid << 37);
>   >  }
>   >
>   > -phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
>   > +dma_addr_t __ls7a_phys_to_dma(struct device *dev, phys_addr_t paddr)
>   > +{
>   > +    long nid = (paddr >> 44) & 0x3;
>   > +
>   > +    return ((nid << 44) ^ paddr) | (nid << (36 + node_id_offset));
>   > +}
>   > +
>   > +
>   > +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>   > +{
>   > +    return loongson_dma.phys_to_dma(dev, paddr);
>   > +}
>   > +
>   > +phys_addr_t __rs780e_dma_to_phys(struct device *dev, dma_addr_t daddr)
>   >  {
>   >      /* We extract 2bit node id (bit 44~47, only bit 44~45 used now) from
>   >       * Loongson-3's 48bit address space and embed it into 40bit */
>   >      long nid = (daddr >> 37) & 0x3;
>   > +
>   >      return ((nid << 37) ^ daddr) | (nid << 44);
>   >  }
>   >
>   > +phys_addr_t __ls7a_dma_to_phys(struct device *dev, dma_addr_t daddr)
>   > +{
>   > +    long nid = (daddr >> (36 + node_id_offset)) & 0x3;
>   > +
>   > +    return ((nid << (36 + node_id_offset)) ^ daddr) | (nid << 44);
>   > +}
>   > +
>   > +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
>   > +{
>   > +    return loongson_dma.dma_to_phys(dev, daddr);
>   > +}
>   > +
>   >  void __init plat_swiotlb_setup(void)
>   >  {
>   >      swiotlb_init(1);
>   > +
>   > +    if (strstr(eboard->name, "780E")) {
>   > +        loongson_dma.phys_to_dma = __rs780e_phys_to_dma;
>   > +        loongson_dma.dma_to_phys = __rs780e_dma_to_phys;
>   > +    }
>   > +
>   > +    if (strstr(eboard->name, "7A1000")) {
>   > +        loongson_dma.phys_to_dma = __ls7a_phys_to_dma;
>   > +        loongson_dma.dma_to_phys = __ls7a_dma_to_phys;
>   > +    }
>   >  }
>   > diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
>   > index 5ac1a0f..dd8463d 100644
>   > --- a/arch/mips/loongson64/init.c
>   > +++ b/arch/mips/loongson64/init.c
>   > @@ -12,6 +12,11 @@
>   >  #include <asm/fw/fw.h>
>   >
>   >  #include <loongson.h>
>   > +#include <boot_param.h>
>   > +
>   > +#define NODE_ID_OFFSET_ADDR     0x90000E001001041CULL
>   > +
>   > +u32 node_id_offset;
>   >
>   >  static void __init mips_nmi_setup(void)
>   >  {
>   > @@ -23,6 +28,11 @@ static void __init mips_nmi_setup(void)
>   >      flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
>   >  }
>   >
>   > +static void ls7a_early_config(void)
>   > +{
>   > +    node_id_offset = (*(u32 *)NODE_ID_OFFSET_ADDR >> 8) & 0x1F;
>
> Please avoid raw pointer. Use readl/writel instead.

OK, I will do it.

Thanks,

Tiezhu Yang

>
>   > +}
>   > +
>   >  void __init prom_init(void)
>   >  {
>   >      fw_init_cmdline();
>   > @@ -32,6 +42,9 @@ void __init prom_init(void)
>   >      set_io_port_base((unsigned long)
>   >          ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
>   >
>   > +    if (strstr(eboard->name, "7A1000"))
>   > +        ls7a_early_config();
>   > +
>   >      prom_init_numa_memory();
>   >
>   >      /* Hardcode to CPU UART 0 */
>   > --
>   > 2.1.0
>   >
>   >

