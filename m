Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1067C17EEF0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 04:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCJDDd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 23:03:33 -0400
Received: from mail.loongson.cn ([114.242.206.163]:32876 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgCJDDd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 23:03:33 -0400
Received: from [10.130.0.70] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr2h3A2deAgkZAA--.10S3;
        Tue, 10 Mar 2020 11:03:21 +0800 (CST)
Subject: =?UTF-8?Q?Re:_=e5=9b=9e=e5=a4=8d:[PATCH_5/6]_MIPS:_Loongson:_Add_PC?=
 =?UTF-8?Q?I_support_for_7A1000?=
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
 <1583742206-29163-6-git-send-email-yangtiezhu@loongson.cn>
 <170be7abc6d.d0ea51502303.7109395874638183132@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ide <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7c69c3d5-5d2d-9602-d485-553d350550ee@loongson.cn>
Date:   Tue, 10 Mar 2020 11:03:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <170be7abc6d.d0ea51502303.7109395874638183132@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxr2h3A2deAgkZAA--.10S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW8CF15uFWxCFy3AF48Xrb_yoW3XF4UpF
        yfAa15Gr40qF17GF9YvFWDGrn3JrZYyr9Fkay7tFyjvasa9w10qr90gF45Krs7Zr4DXa10
        vFyxWr47CFn8KaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
        Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
        x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
        1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j
        6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/09/2020 04:47 PM, Jiaxun Yang wrote:
>
>   ---- 在 星期一, 2020-03-09 16:23:25 Tiezhu Yang <yangtiezhu@loongson.cn> 撰写 ----
>   > Add PCI support for 7A1000 to detect PCI device.
>   >
>   > Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>   > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>   > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>   > ---
>   >  arch/mips/include/asm/mach-loongson64/pci.h |   1 +
>   >  arch/mips/loongson64/pci.c                  |  12 ++-
>   >  arch/mips/pci/Makefile                      |   2 +-
>   >  arch/mips/pci/ops-loongson3-ls7a.c          | 132 ++++++++++++++++++++++++++++
>   >  4 files changed, 143 insertions(+), 4 deletions(-)
>   >  create mode 100644 arch/mips/pci/ops-loongson3-ls7a.c
>   >
>   > diff --git a/arch/mips/include/asm/mach-loongson64/pci.h b/arch/mips/include/asm/mach-loongson64/pci.h
>   > index 8b59d64..42c9744 100644
>   > --- a/arch/mips/include/asm/mach-loongson64/pci.h
>   > +++ b/arch/mips/include/asm/mach-loongson64/pci.h
>   > @@ -8,6 +8,7 @@
>   >  #define __ASM_MACH_LOONGSON64_PCI_H_
>   >
>   >  extern struct pci_ops loongson_pci_ops;
>   > +extern struct pci_ops loongson_ls7a_pci_ops;
>   >
>   >  /* this is an offset from mips_io_port_base */
>   >  #define LOONGSON_PCI_IO_START    0x00004000UL
>   > diff --git a/arch/mips/loongson64/pci.c b/arch/mips/loongson64/pci.c
>   > index e84ae20..b79368f 100644
>   > --- a/arch/mips/loongson64/pci.c
>   > +++ b/arch/mips/loongson64/pci.c
>   > @@ -23,8 +23,8 @@ static struct resource loongson_pci_io_resource = {
>   >      .flags    = IORESOURCE_IO,
>   >  };
>   >
>   > -static struct pci_controller  loongson_pci_controller = {
>   > -    .pci_ops    = &loongson_pci_ops,
>   > +static struct pci_controller loongson_pci_controller = {
>   > +    .pci_ops    = NULL,
>   >      .io_resource    = &loongson_pci_io_resource,
>   >      .mem_resource    = &loongson_pci_mem_resource,
>   >      .mem_offset    = 0x00000000UL,
>   > @@ -36,6 +36,11 @@ extern int sbx00_acpi_init(void);
>   >
>   >  static int __init pcibios_init(void)
>   >  {
>   > +    if (strstr(eboard->name, "780E"))
>   > +        loongson_pci_controller.pci_ops = &loongson_pci_ops;
>   > +
>   > +    if (strstr(eboard->name, "7A1000"))
>   > +        loongson_pci_controller.pci_ops = &loongson_ls7a_pci_ops;
>
> Please do not check PCH type everywhere.

Yes, you are right.

>
>   >
>   >      loongson_pci_controller.io_map_base = mips_io_port_base;
>   >      loongson_pci_mem_resource.start = loongson_sysconf.pci_mem_start_addr;
>   > @@ -43,7 +48,8 @@ static int __init pcibios_init(void)
>   >
>   >      register_pci_controller(&loongson_pci_controller);
>   >
>   > -    sbx00_acpi_init();
>   > +    if (strstr(eboard->name, "780E"))
>   > +        sbx00_acpi_init();
>   >
>   >      return 0;
>   >  }
>   > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
>   > index 342ce10..7256bb1 100644
>   > --- a/arch/mips/pci/Makefile
>   > +++ b/arch/mips/pci/Makefile
>   > @@ -35,7 +35,7 @@ obj-$(CONFIG_LASAT)        += pci-lasat.o
>   >  obj-$(CONFIG_MIPS_COBALT)    += fixup-cobalt.o
>   >  obj-$(CONFIG_LEMOTE_FULOONG2E)    += fixup-fuloong2e.o ops-loongson2.o
>   >  obj-$(CONFIG_LEMOTE_MACH2F)    += fixup-lemote2f.o ops-loongson2.o
>   > -obj-$(CONFIG_MACH_LOONGSON64)    += fixup-loongson3.o ops-loongson3.o
>   > +obj-$(CONFIG_MACH_LOONGSON64)    += fixup-loongson3.o ops-loongson3.o ops-loongson3-ls7a.o
>   >  obj-$(CONFIG_MIPS_MALTA)    += fixup-malta.o pci-malta.o
>   >  obj-$(CONFIG_PMC_MSP7120_GW)    += fixup-pmcmsp.o ops-pmcmsp.o
>   >  obj-$(CONFIG_PMC_MSP7120_EVAL)    += fixup-pmcmsp.o ops-pmcmsp.o
>   > diff --git a/arch/mips/pci/ops-loongson3-ls7a.c b/arch/mips/pci/ops-loongson3-ls7a.c
>   > new file mode 100644
>   > index 0000000..4ed6c40
>   > --- /dev/null
>   > +++ b/arch/mips/pci/ops-loongson3-ls7a.c
>   > @@ -0,0 +1,132 @@
>   > +// SPDX-License-Identifier: GPL-2.0
>   > +/*
>   > + * Copyright (C) 2020 Loongson Technology Corporation Limited
>   > + *
>   > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
>   > + * Author: Tiezhu Yang <yangtiezhu@loongson.cn>
>   > + */
>   > +
>   > +#include <linux/types.h>
>   > +#include <linux/pci.h>
>   > +#include <linux/kernel.h>
>   > +
>   > +#include <asm/mips-boards/bonito64.h>
>
> Why we need this?

I will check it, if it is useless, I will remove it.

>
>   > +
>   > +#include <loongson.h>
>   > +
>   > +#define PCI_ACCESS_READ 0
>   > +#define PCI_ACCESS_WRITE 1
>   > +
>   > +#define HT1LO_PCICFG_BASE 0x1a000000
>   > +#define HT1LO_PCICFG_BASE_TP1 0x1b000000
>   > +
>   > +#define HT1LO_PCICFG_BASE_EXT 0xefe00000000
>   > +#define HT1LO_PCICFG_BASE_TP1_EXT 0xefe10000000
>   > +
>   > +static int ls7a_pci_config_access(unsigned char access_type,
>   > +        struct pci_bus *bus, unsigned int devfn,
>   > +        int where, u32 *data)
>   > +{
>   > +    u_int64_t addr;
>   > +    void *addrp;
>   > +    unsigned char busnum = bus->number;
>   > +    int device = PCI_SLOT(devfn);
>   > +    int function = PCI_FUNC(devfn);
>   > +    int reg = where & ~3;
>   > +
>   > +    if (where >= PCI_CFG_SPACE_EXP_SIZE)
>   > +        return PCIBIOS_DEVICE_NOT_FOUND;
>   > +
>   > +    if (busnum == 0 && device > 23)
>   > +        return PCIBIOS_DEVICE_NOT_FOUND;
>   > +
>   > +    if (where < PCI_CFG_SPACE_SIZE) { /* standard config */
>   > +        addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
>   > +        if (busnum == 0) {
>   > +            addr = HT1LO_PCICFG_BASE | addr;
>   > +            addrp = (void *)TO_UNCAC(addr);
>   > +        } else {
>   > +            addr = HT1LO_PCICFG_BASE_TP1 | addr;
>   > +            addrp = (void *)TO_UNCAC(addr);
>   > +        }
>   > +    } else { /* extended config */
>   > +        reg = (reg & 0xff) | ((reg & 0xf00) << 16);
>   > +        addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
>   > +        if (busnum == 0) {
>   > +            addr = HT1LO_PCICFG_BASE_EXT | addr;
>   > +            addrp = (void *)TO_UNCAC(addr);
>   > +        } else {
>   > +            addr = HT1LO_PCICFG_BASE_TP1_EXT | addr;
>   > +            addrp = (void *)TO_UNCAC(addr);
>   > +        }
>   > +    }
>   > +
>   > +    if (access_type == PCI_ACCESS_WRITE)
>   > +        *(unsigned int *)addrp = cpu_to_le32(*data);
>   > +    else {
>   > +        *data = le32_to_cpu(*(unsigned int *)addrp);
>   > +        if (busnum == 0 &&
>   > +            reg == PCI_CLASS_REVISION && *data == 0x06000001)
>   > +            *data = (PCI_CLASS_BRIDGE_PCI << 16) | (*data & 0xffff);
>
> It should be a part of quirk. Not a part of accessing.
>
>   > +
>   > +        if (*data == 0xffffffff) {
>   > +            *data = -1;
>   > +            return PCIBIOS_DEVICE_NOT_FOUND;
>   > +        }
>   > +    }
>   > +
>   > +    return PCIBIOS_SUCCESSFUL;
>   > +}
>   > +
>   > +static int ls7a_pci_pcibios_read(struct pci_bus *bus, unsigned int devfn,
>   > +                 int where, int size, u32 *val)
>   > +{
>   > +    int ret;
>   > +    u32 data = 0;
>   > +
>   > +    ret = ls7a_pci_config_access(PCI_ACCESS_READ, bus, devfn, where, &data);
>   > +    if (ret != PCIBIOS_SUCCESSFUL)
>   > +        return ret;
>   > +
>   > +    if (size == 1)
>   > +        *val = (data >> ((where & 3) << 3)) & 0xff;
>   > +    else if (size == 2)
>   > +        *val = (data >> ((where & 3) << 3)) & 0xffff;
>   > +    else
>   > +        *val = data;
>
> That  loggic seems identical with RS780E one, can we reuse them?

OK, I will do it.

Thanks,

Tiezhu Yang

>
>> +
>   > +    return PCIBIOS_SUCCESSFUL;
>   > +}
>   > +
>   > +static int ls7a_pci_pcibios_write(struct pci_bus *bus, unsigned int devfn,
>   > +                  int where, int size, u32 val)
>   > +{
>   > +    int ret;
>   > +    u32 data = 0;
>   > +
>   > +    if (size == 4)
>   > +        data = val;
>   > +    else {
>   > +        ret = ls7a_pci_config_access(PCI_ACCESS_READ, bus,
>   > +                        devfn, where, &data);
>   > +        if (ret != PCIBIOS_SUCCESSFUL)
>   > +            return ret;
>   > +
>   > +        if (size == 1)
>   > +            data = (data & ~(0xff << ((where & 3) << 3))) |
>   > +                (val << ((where & 3) << 3));
>   > +        else if (size == 2)
>   > +            data = (data & ~(0xffff << ((where & 3) << 3))) |
>   > +                (val << ((where & 3) << 3));
>   > +    }
>   > +
>   > +    ret = ls7a_pci_config_access(PCI_ACCESS_WRITE, bus,
>   > +                    devfn, where, &data);
>   > +
>   > +    return ret;
>   > +}
>   > +
>   > +struct pci_ops loongson_ls7a_pci_ops = {
>   > +    .read = ls7a_pci_pcibios_read,
>   > +    .write = ls7a_pci_pcibios_write
>   > +};
>   > --
>   > 2.1.0
>   >
>   >

