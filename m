Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3717DC24
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 10:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCIJIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 05:08:46 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17830 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbgCIJIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 05:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1583744880;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=hVhkZgf1dJyH1eLo2AiHbw0wZOFEeisZzBmts6rfw1I=;
        b=UyddDk26HFuL014dEfTmKV0pIeZLRPV4ncSMvtB+86Rcz0VpWI3ntN1GqYcGg5hl
        nXIh2ka009QFh7ct+xd/V1cJY1mYOBbV3Y6fjHwhndjSF+4TL0i0LKCpfkGME0fnaGg
        SM6lb076LXgwWDq77eI4HhBsspl8ZNsDsqTw38GQ=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1583744878068457.70062170447306; Mon, 9 Mar 2020 17:07:58 +0800 (CST)
Date:   Mon, 09 Mar 2020 17:07:58 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Huacai Chen" <chenhc@lemote.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "linux-mips" <linux-mips@vger.kernel.org>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-ide" <linux-ide@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Jianmin Lv" <lvjianmin@loongson.cn>
Message-ID: <170be8d05ec.100c6ee822331.1237957190638519817@flygoat.com>
In-Reply-To: <1583742206-29163-7-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn> <1583742206-29163-7-git-send-email-yangtiezhu@loongson.cn>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[PATCH_6/6]_MIPS:_Loongson:_Add_su?=
 =?UTF-8?Q?pport_for_7A1000_interrupt_controller?=
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-03-09 16:23:26 Tiezhu Yan=
g <yangtiezhu@loongson.cn> =E6=92=B0=E5=86=99 ----
 > Use interrupt model to support interrupt controller of Loongson
 > 7A1000 bridge chip.

This patch seems clueless for me.
Partly beacuse you're hijacking what should be done by irq domain and irqch=
ip.
Variuous of abbreviations makes me frustrated, so I didn't dig in to your l=
ogic deeper.=20
See my review comments below.

 >=20
 > Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
 > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
 > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
 > ---
 >  arch/mips/include/asm/mach-loongson64/ioaicu.h | 166 ++++++++++++++
 >  arch/mips/include/asm/mach-loongson64/irq.h    |   2 +
 >  arch/mips/loongson64/Makefile                  |   2 +-
 >  arch/mips/loongson64/ioaicu.c                  | 305 ++++++++++++++++++=
+++++++
 >  arch/mips/loongson64/irq.c                     |  20 +-
 >  arch/mips/loongson64/smp.c                     |  11 +-
 >  6 files changed, 497 insertions(+), 9 deletions(-)
 >  create mode 100644 arch/mips/include/asm/mach-loongson64/ioaicu.h
 >  create mode 100644 arch/mips/loongson64/ioaicu.c
 >=20
 > diff --git a/arch/mips/include/asm/mach-loongson64/ioaicu.h b/arch/mips/=
include/asm/mach-loongson64/ioaicu.h
 > new file mode 100644
 > index 0000000..e55de0d
 > --- /dev/null
 > +++ b/arch/mips/include/asm/mach-loongson64/ioaicu.h
 > @@ -0,0 +1,166 @@
 > +/* SPDX-License-Identifier: GPL-2.0 */
 > +/*
 > + * Copyright (C) 2020 Loongson Technology Corporation Limited
 > + *
 > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
 > + * Author: Tiezhu Yang <yangtiezhu@loongson.cn>
 > + */
 > +
 > +#ifndef _ASM_LOONGSON_IOAICU_H
 > +#define _ASM_LOONGSON_IOAICU_H
 > +
 > +#define LS_CFG_BASE    0x3ff00000

Here your "_BASE" is using phys addr.

 > +#define LS_CFG_OFF(x)    ((void *)TO_UNCAC(LS_CFG_BASE) + (x))
 > +
 > +#define LS_IRC_BASE    LS_CFG_OFF(0x1400)
 > +#define LS_IRC_OFF(x)    (LS_IRC_BASE + x)
 > +
 > +#define LS_IRC_ENT(x)    LS_IRC_OFF(x)
 > +#define LS_IRC_EN    LS_IRC_OFF(0x24)
 > +#define LS_IRC_ENSET    LS_IRC_OFF(0x28)
 > +
 > +#define MAX_IOAICUS        16
 > +#define LS3A_MAX_IPI_IRQ    26
 > +#define LS3A_MAX_IO_VECTOR    64
 > +#define LS3A_MAX_IO_IRQ        256
 > +
 > +#define LS7A_PCH_REG_BASE    0x10000000
 > +#define LS7A_IOAICU_IRQ_BASE    64
 > +
 > +#define IOAICU_BASE    0x90000e0000000000ULL

But here your "_BASE" is using virt addr.

 > +#define IOAICU_IMR    0x20
 > +#define IOAICU_IER    0x60
 > +#define IOAICU_ICR    0x80
 > +#define IOAICU_IRR    0x100
 > +#define IOAICU_ISR    0x3a0
 > +#define IOAICU_IPR    0x3e0
 > +
 > +#define USE_HTH_INT0    0x1

What's that?

 > +
 > +#define LS3A_IOIRQ2VECTOR(irq) (irq - LS3A_MAX_IO_VECTOR)
 > +#define LS3A_VECTOR2IOIRQ(vector) (vector + LS3A_MAX_IO_VECTOR)
 > +
 > +struct ioaicu_config {
 > +    unsigned char aicuid;
 > +    unsigned char aicuver;
 > +    unsigned int aicuaddr;
 > +};
 > +
 > +struct ioaicu_gsi {
 > +    u32 gsi_base;
 > +    u32 gsi_end;
 > +};

What's meant by GSI?

 > +
 > +struct ioaicu {
 > +    int nr_registers;
 > +    struct ioaicu_config config;
 > +    struct ioaicu_gsi gsi_config;
 > +};
 > +
 > +struct loongson_irq_dispatch_ops {
 > +    void (*irq_dispatch)(void);
 > +};
 > +
 > +extern void setup_ioaicu(void);
 > +extern struct ioaicu ioaicus[MAX_IOAICUS];
 > +extern struct loongson_irq_dispatch_ops loongson_pch;
 > +extern unsigned short ls3a_ipi_pos2irq[LS3A_MAX_IO_VECTOR];
 > +
 > +extern void loongson3_send_irq_by_ipi(int cpu, int irqs);
 > +extern int plat_set_irq_affinity(struct irq_data *d,
 > +                 const struct cpumask *affinity, bool force);
 > +
 > +static inline unsigned long ioaicu_read64(unsigned int aicu, unsigned i=
nt reg)
 > +{
 > +    unsigned long addr =3D ioaicus[aicu].config.aicuaddr;
 > +
 > +    return *(unsigned long *)(IOAICU_BASE + addr + reg);

Please avoid raw pointer. Also applied to rest of the patch.=20

 > +}
 > +
 > +static inline void ioaicu_write64(unsigned int aicu,
 > +                  unsigned int reg, unsigned long value)
 > +{
 > +    unsigned long addr =3D ioaicus[aicu].config.aicuaddr;
 > +    *(unsigned long *)(IOAICU_BASE + addr + reg) =3D value;=20
> +}
 > +
 > +static inline unsigned char ioaicu_read8(unsigned int aicu, unsigned in=
t reg)
 > +{
 > +    unsigned long addr =3D ioaicus[aicu].config.aicuaddr;
 > +
 > +    return *(unsigned char *)(IOAICU_BASE + addr + reg);
 > +}
 > +
 > +static inline void ioaicu_write8(unsigned int aicu,
 > +                 unsigned int reg, unsigned char value)
 > +{
 > +    unsigned long addr =3D ioaicus[aicu].config.aicuaddr;
 > +    *(unsigned char *)(IOAICU_BASE + addr + reg) =3D value;
 > +}
 > +
 > +static inline int ioaicu_get_redir_entries(int ioaicu)
 > +{
 > +    return 64;

Why not a macro?

 > +}
 > +
 > +static inline struct ioaicu_gsi *ioaicu_gsi_routing(int ioaicu_idx)
 > +{
 > +    return &ioaicus[ioaicu_idx].gsi_config;
 > +}
 > +
 > +static inline int ioaicu_id(int ioaicu_idx)
 > +{
 > +    return ioaicus[ioaicu_idx].config.aicuid;
 > +}
 > +
 > +static inline unsigned int ioaicu_addr(int ioaicu_idx)
 > +{
 > +    return ioaicus[ioaicu_idx].config.aicuaddr;
 > +}
 > +
 > +#define ioaicu_ver(ioaicu_idx) ioaicus[ioaicu_idx].config.aicuver
 > +
 > +static inline void ls64_conf_write64(u64 val64, void __iomem *addr)
 > +{
 > +    asm volatile (
 > +    "    .set push\n"
 > +    "    .set noreorder\n"
 > +    "    sd    %[v], (%[hw])\n"
 > +    "    lb    $0, (%[hw])\n"
 > +    "    .set pop\n"
 > +    :
 > +    : [hw] "r" (addr),  [v] "r" (val64)
 > +    );
 > +}

What are you doing here? I assume you're trying to workaround hardware bug?
Is it an io barrier? If so, please make it as a part of general io.h.

 > +
 > +static inline void ls64_conf_write32(u32 val, void __iomem *addr)
 > +{
 > +    asm volatile (
 > +    "    .set push\n"
 > +    "    .set noreorder\n"
 > +    "    sw    %[v], (%[hw])\n"
 > +    "    lb    $0, (%[hw])\n"
 > +    "    .set pop\n"
 > +    :
 > +    : [hw] "r" (addr), [v] "r" (val)
 > +    );
 > +}
 > +
 > +static inline void ls64_conf_write8(u8 val, void __iomem *addr)
 > +{
 > +    asm volatile (
 > +    "    .set push\n"
 > +    "    .set noreorder\n"
 > +    "    sb    %[v], (%[hw])\n"
 > +    "    lb    $0, (%[hw])\n"
 > +    "    .set pop\n"
 > +    :
 > +    : [hw] "r" (addr), [v] "r" (val)
 > +    );
 > +}
 > +
 > +#define ls64_conf_read64(addr) readq(addr)
 > +#define ls64_conf_read32(addr) readl(addr)
 > +#define ls64_conf_read8(addr) readb(addr)
 > +
 > +#endif /* _ASM_LOONGSON_IOAICU_H */
 > diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/inc=
lude/asm/mach-loongson64/irq.h
 > index 73a8991..10568be 100644
 > --- a/arch/mips/include/asm/mach-loongson64/irq.h
 > +++ b/arch/mips/include/asm/mach-loongson64/irq.h
 > @@ -4,6 +4,8 @@
 > =20
 >  #include <boot_param.h>
 > =20
 > +#define NR_IRQS (64 + 256)
 > +
 >  /* cpu core interrupt numbers */
 >  #define MIPS_CPU_IRQ_BASE 56
 > =20
 > diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Makefi=
le
 > index 7821891..3db50c6 100644
 > --- a/arch/mips/loongson64/Makefile
 > +++ b/arch/mips/loongson64/Makefile
 > @@ -3,7 +3,7 @@
 >  # Makefile for Loongson-3 family machines
 >  #
 >  obj-$(CONFIG_MACH_LOONGSON64) +=3D irq.o cop2-ex.o platform.o acpi_init=
.o dma.o \
 > -                setup.o init.o env.o time.o reset.o \
 > +                setup.o init.o env.o time.o reset.o ioaicu.o \
 > =20
 >  obj-$(CONFIG_SMP)    +=3D smp.o
 >  obj-$(CONFIG_NUMA)    +=3D numa.o
 > diff --git a/arch/mips/loongson64/ioaicu.c b/arch/mips/loongson64/ioaicu=
.c
 > new file mode 100644
 > index 0000000..904ac75
 > --- /dev/null
 > +++ b/arch/mips/loongson64/ioaicu.c
 > @@ -0,0 +1,305 @@
 > +// SPDX-License-Identifier: GPL-2.0
 > +/*
 > + * Copyright (C) 2020 Loongson Technology Corporation Limited
 > + *
 > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
 > + * Author: Tiezhu Yang <yangtiezhu@loongson.cn>
 > + */
 > +
 > +#include <loongson.h>
 > +#include <ioaicu.h>
 > +
 > +static DEFINE_SPINLOCK(pch_irq_lock);
 > +DECLARE_BITMAP(ls3a_ipi_in_use, LS3A_MAX_IPI_IRQ);
 > +struct loongson_irq_dispatch_ops loongson_pch;
 > +struct ioaicu ioaicus[MAX_IOAICUS];
 > +
 > +unsigned short ls3a_ipi_pos2irq[LS3A_MAX_IO_VECTOR] =3D {
 > +                    [0 ... LS3A_MAX_IO_VECTOR-1] =3D -1 };
 > +unsigned char ls3a_ipi_irq2pos[LS3A_MAX_IO_IRQ] =3D {
 > +                    [0 ... LS3A_MAX_IO_IRQ-1] =3D -1 };
 > +unsigned int cpu_for_irq[LS3A_MAX_IO_IRQ] =3D {
 > +                    [0 ... LS3A_MAX_IO_IRQ-1] =3D -1};
 > +
 > +u32 gsi_top;
 > +int nr_ioaicus;
 > +#define for_each_ioaicu(idx)    \
 > +    for ((idx) =3D 0; (idx) < nr_ioaicus; (idx)++)
 > +#define for_each_pin(idx, pin)    \
 > +    for ((pin) =3D 0; (pin) < ioaicus[(idx)].nr_registers; (pin)++)
 > +
 > +static int bad_ioaicu(unsigned long address)
 > +{
 > +    if (nr_ioaicus >=3D MAX_IOAICUS) {
 > +        pr_warn("WARNING: Max # of I/O AICUs (%d) exceeded (found %d), =
skipping\n",
 > +            MAX_IOAICUS, nr_ioaicus);
 > +        return 1;
 > +    }
 > +
 > +    if (!address) {
 > +        pr_warn("WARNING: Bogus (zero) I/O AICU address found in table,=
 skipping!\n");
 > +        return 1;
 > +    }
 > +
 > +    return 0;
 > +}
 > +
 > +static void register_ioaicu(int id, u32 address, u32 gsi_base)
 > +{
 > +    int idx =3D 0;
 > +    int entries;
 > +    struct ioaicu_gsi *gsi_cfg;
 > +
 > +    if (bad_ioaicu(address))
 > +        return;
 > +
 > +    idx =3D nr_ioaicus;
 > +    ioaicus[idx].config.aicuaddr =3D address;
 > +    ioaicus[idx].config.aicuid =3D id;
 > +    ioaicus[idx].config.aicuver =3D 0;
 > +
 > +    entries =3D ioaicu_get_redir_entries(idx);
 > +    gsi_cfg =3D ioaicu_gsi_routing(idx);
 > +    gsi_cfg->gsi_base =3D gsi_base;
 > +    gsi_cfg->gsi_end =3D gsi_base + entries - 1;
 > +
 > +    ioaicus[idx].nr_registers =3D entries;
 > +
 > +    if (gsi_cfg->gsi_end >=3D gsi_top)
 > +        gsi_top =3D gsi_cfg->gsi_end + 1;
 > +
 > +    pr_info("IOAICU[%d]: aicu_id %d, version %d, address 0x%x, GSI %d-%=
d\n",
 > +        idx, ioaicu_id(idx), ioaicu_ver(idx), ioaicu_addr(idx),
 > +        gsi_cfg->gsi_base, gsi_cfg->gsi_end);
 > +
 > +    nr_ioaicus++;
 > +}
 > +
 > +static int find_ioaicu(u32 gsi)
 > +{
 > +    int i;
 > +
 > +    if (nr_ioaicus =3D=3D 0)
 > +        return -1;
 > +
 > +    for_each_ioaicu(i) {
 > +        struct ioaicu_gsi *gsi_cfg =3D ioaicu_gsi_routing(i);
 > +
 > +        if (gsi >=3D gsi_cfg->gsi_base && gsi <=3D gsi_cfg->gsi_end)
 > +            return i;
 > +    }
 > +
 > +    pr_err("ERROR: Unable to locate IOAICU for GSI %d\n", gsi);
 > +
 > +    return -1;
 > +}
 > +
 > +static int pch_create_dirq(unsigned int irq)
 > +{
 > +    unsigned long flags;
 > +    int pos;
 > +
 > +    spin_lock_irqsave(&pch_irq_lock, flags);
 > +again:
 > +    pos =3D find_first_zero_bit(ls3a_ipi_in_use, LS3A_MAX_IPI_IRQ);
 > +    if (pos =3D=3D LS3A_MAX_IPI_IRQ) {
 > +        spin_unlock_irqrestore(&pch_irq_lock, flags);
 > +        return -ENOSPC;
 > +    }

See Hierarchy IRQ domain, that's what you need.


 > +
 > +    if (test_and_set_bit(pos, ls3a_ipi_in_use))
 > +        goto again;
 > +
 > +    ls3a_ipi_pos2irq[pos] =3D irq;
 > +    ls3a_ipi_irq2pos[LS3A_IOIRQ2VECTOR(irq)] =3D pos;
 > +    spin_unlock_irqrestore(&pch_irq_lock, flags);
 > +
 > +    return 0;
 > +}
 > +
 > +static void pch_destroy_dirq(unsigned int irq)
 > +{
 > +    unsigned long flags;
 > +    int pos;
 > +
 > +    spin_lock_irqsave(&pch_irq_lock, flags);
 > +    pos =3D ls3a_ipi_irq2pos[LS3A_IOIRQ2VECTOR(irq)];
 > +    if (pos >=3D 0) {
 > +        clear_bit(pos, ls3a_ipi_in_use);
 > +        ls3a_ipi_irq2pos[LS3A_IOIRQ2VECTOR(irq)] =3D -1;
 > +        ls3a_ipi_pos2irq[pos] =3D -1;
 > +    }
 > +    spin_unlock_irqrestore(&pch_irq_lock, flags);
 > +}
 > +
 > +static void line_mask_pch_irq(struct irq_data *d)
 > +{
 > +    unsigned long flags, data;
 > +    unsigned int ioaicu;
 > +    unsigned long irq_nr =3D d->irq;
 > +
 > +    ioaicu =3D (unsigned int)find_ioaicu((u32)irq_nr);
 > +
 > +    spin_lock_irqsave(&pch_irq_lock, flags);
 > +    data =3D ioaicu_read64(ioaicu, IOAICU_IMR);
 > +    data |=3D (1ULL << LS3A_IOIRQ2VECTOR(irq_nr));
 > +    ioaicu_write64(ioaicu, IOAICU_IMR, data);
 > +    spin_unlock_irqrestore(&pch_irq_lock, flags);
 > +}
 > +
 > +static void line_unmask_pch_irq(struct irq_data *d)
 > +{
 > +    unsigned long flags, data;
 > +    unsigned int ioaicu;
 > +    unsigned long irq_nr =3D d->irq;
 > +
 > +    ioaicu =3D (unsigned int)find_ioaicu((u32)irq_nr);
 > +
 > +    spin_lock_irqsave(&pch_irq_lock, flags);
 > +    data =3D ioaicu_read64(ioaicu, IOAICU_IMR);
 > +    data &=3D ~(1ULL << LS3A_IOIRQ2VECTOR(irq_nr));
 > +    ioaicu_write64(ioaicu, IOAICU_IMR, data);
 > +    spin_unlock_irqrestore(&pch_irq_lock, flags);
 > +}
 > +
 > +static unsigned int line_startup_pch_irq(struct irq_data *d)
 > +{
 > +    pch_create_dirq(d->irq);
 > +    line_unmask_pch_irq(d);
 > +
 > +    return 0;
 > +}
 > +
 > +static void line_shutdown_pch_irq(struct irq_data *d)
 > +{
 > +    line_mask_pch_irq(d);
 > +    pch_destroy_dirq(d->irq);
 > +}
 > +
 > +static struct irq_chip ioaicu_line_chip =3D {
 > +    .name            =3D "IOAICU-LINE",
 > +    .irq_mask        =3D line_mask_pch_irq,
 > +    .irq_unmask        =3D line_unmask_pch_irq,
 > +    .irq_startup        =3D line_startup_pch_irq,
 > +    .irq_shutdown        =3D line_shutdown_pch_irq,
 > +    .irq_set_affinity    =3D plat_set_irq_affinity,
 > +};
 > +
 > +static void line_route_init(void)
 > +{
 > +    unsigned int dummy;
 > +
 > +    /* route 3A CPU0 INT0 to node0 core0 INT1(IP3) */
 > +    dummy =3D LOONGSON_INT_COREx_INTy(loongson_sysconf.boot_cpu_id, 1);
 > +    ls64_conf_write8(dummy, LS_IRC_ENT(0));
 > +
 > +    dummy =3D ls64_conf_read32(LS_IRC_EN);
 > +    dummy |=3D 0x1;
 > +    ls64_conf_write32(dummy, LS_IRC_ENSET);
 > +}
 > +
 > +static void init_pin_route(unsigned int ioaicu, int vec)
 > +{
 > +    ioaicu_write8(ioaicu, IOAICU_IRR + vec, USE_HTH_INT0);
 > +}
 > +
 > +static void init_ioaicu_pin(unsigned int ioaicu, int pin,
 > +                struct irq_chip *pirq_chip)
 > +{
 > +    init_pin_route(ioaicu, LS3A_IOIRQ2VECTOR(pin));
 > +    irq_set_chip_and_handler(pin, pirq_chip, handle_level_irq);
 > +}
 > +
 > +static void setup_ioaicu_irqs(struct irq_chip *pirq_chip)
 > +{
 > +    unsigned int ioaicu, pin;
 > +    struct ioaicu_gsi *gsi_cfg;
 > +
 > +    for_each_ioaicu(ioaicu) {
 > +        ioaicu_write64(ioaicu, IOAICU_IER, 0);
 > +        ioaicu_write64(ioaicu, IOAICU_IPR, (1ULL << 59));
 > +        ioaicu_write64(ioaicu, IOAICU_ISR, 0);
 > +        ioaicu_write64(ioaicu, IOAICU_IMR, -1ULL);
 > +        ioaicu_write64(ioaicu, IOAICU_ICR, -1ULL);
 > +    }
 > +
 > +    for (ioaicu =3D 0; ioaicu < nr_ioaicus; ioaicu++) {
 > +        for (pin =3D 0; pin < ioaicus[ioaicu].nr_registers; pin++) {
 > +            gsi_cfg =3D ioaicu_gsi_routing(ioaicu);
 > +            init_ioaicu_pin(ioaicu,
 > +                    pin + gsi_cfg->gsi_base, pirq_chip);
 > +        }
 > +    }
 > +}
 > +
 > +static void handle_irqs(unsigned long long irqs, int i)
 > +{
 > +    unsigned int irq;
 > +    struct irq_data *irqd;
 > +    struct cpumask affinity;
 > +    int cpu =3D smp_processor_id();
 > +
 > +    while (irqs) {
 > +        irq =3D __ffs(irqs);
 > +        irqs &=3D ~(1ULL<<irq);
 > +        irq +=3D (i << 6);
 > +
 > +        /* handled by local core */
 > +        if (ls3a_ipi_irq2pos[irq] =3D=3D (unsigned char)-1) {
 > +            do_IRQ(LS3A_VECTOR2IOIRQ(irq));
 > +            continue;
 > +        }
 > +
 > +        irqd =3D irq_get_irq_data(LS3A_VECTOR2IOIRQ(irq));
 > +        cpumask_and(&affinity, irqd->common->affinity, cpu_active_mask)=
;
 > +        if (cpumask_empty(&affinity)) {
 > +            do_IRQ(LS3A_VECTOR2IOIRQ(irq));
 > +            continue;
 > +        }
 > +
 > +        cpu_for_irq[irq] =3D cpumask_next(cpu_for_irq[irq], &affinity);
 > +        if (cpu_for_irq[irq] >=3D nr_cpu_ids)
 > +            cpu_for_irq[irq] =3D cpumask_first(&affinity);
 > +
 > +        if (cpu_for_irq[irq] =3D=3D cpu) {
 > +            do_IRQ(LS3A_VECTOR2IOIRQ(irq));
 > +            continue;
 > +        }
 > +
 > +        /* balanced by other cores */
 > +        loongson3_send_irq_by_ipi(cpu_for_irq[irq],
 > +                      (0x1 << (ls3a_ipi_irq2pos[irq])));
 > +    }
 > +}
 > +
 > +static void ioaicu_line_dispatch(void)
 > +{
 > +    unsigned long flags;
 > +    unsigned int ioaicu;
 > +    unsigned long long intstatus;
 > +    unsigned long long intmask;
 > +
 > +    for_each_ioaicu(ioaicu) {
 > +        /* read irq status register */
 > +        intstatus =3D ioaicu_read64(ioaicu, IOAICU_ISR);
 > +
 > +        spin_lock_irqsave(&pch_irq_lock, flags);
 > +        intmask =3D ioaicu_read64(ioaicu, IOAICU_IMR);
 > +        intmask |=3D intstatus;
 > +        ioaicu_write64(ioaicu, IOAICU_IMR, intmask);
 > +        intmask =3D ioaicu_read64(ioaicu, IOAICU_IMR);
 > +        spin_unlock_irqrestore(&pch_irq_lock, flags);
 > +
 > +        handle_irqs(intstatus, 0);
 > +    }
 > +}
 > +
 > +/* ioaicu: input/output advanced interrupt control unit */
 > +void __init setup_ioaicu(void)
 > +{
 > +    register_ioaicu(0, LS7A_PCH_REG_BASE, LS7A_IOAICU_IRQ_BASE);
 > +
 > +    line_route_init();
 > +    setup_ioaicu_irqs(&ioaicu_line_chip);
 > +    loongson_pch.irq_dispatch =3D ioaicu_line_dispatch;
 > +}
 > diff --git a/arch/mips/loongson64/irq.c b/arch/mips/loongson64/irq.c
 > index 79ad797..988f21f 100644
 > --- a/arch/mips/loongson64/irq.c
 > +++ b/arch/mips/loongson64/irq.c
 > @@ -1,6 +1,7 @@
 >  // SPDX-License-Identifier: GPL-2.0
 >  #include <loongson.h>
 >  #include <irq.h>
 > +#include <ioaicu.h>
 >  #include <linux/interrupt.h>
 >  #include <linux/init.h>
 > =20
 > @@ -71,6 +72,8 @@ static void ht_irqdispatch(void)
 >              continue;
 >          }
 > =20
 > +        ls3a_ipi_pos2irq[ht_irq[i]] =3D ht_irq[i];
 > +
 >          /* balanced by other cores */
 >          loongson3_send_irq_by_ipi(irq_cpu[ht_irq[i]], (0x1 << ht_irq[i]=
));
 >      }
 > @@ -91,7 +94,7 @@ asmlinkage void plat_irq_dispatch(void)
 >          loongson3_ipi_interrupt(NULL);
 >  #endif
 >      if (pending & CAUSEF_IP3)
 > -        ht_irqdispatch();
 > +        loongson_pch.irq_dispatch();
 >      if (pending & CAUSEF_IP2)
 >          do_IRQ(LOONGSON_UART_IRQ);
 >      if (pending & UNUSED_IPS) {
 > @@ -137,11 +140,18 @@ void __init arch_init_irq(void)
 > =20
 >      clear_c0_status(ST0_IM | ST0_BEV);
 > =20
 > -    irq_router_init();
 >      mips_cpu_irq_init();
 > -    init_i8259_irqs();
 > -    chip =3D irq_get_chip(I8259A_IRQ_BASE);
 > -    chip->irq_set_affinity =3D plat_set_irq_affinity;
 > +
 > +    if (strstr(eboard->name, "780E")) {
 > +        irq_router_init();
 > +        init_i8259_irqs();
 > +        loongson_pch.irq_dispatch =3D ht_irqdispatch;
 > +        chip =3D irq_get_chip(I8259A_IRQ_BASE);
 > +        chip->irq_set_affinity =3D plat_set_irq_affinity;
 > +    }
 > +
 > +    if (strstr(eboard->name, "7A1000"))
 > +        setup_ioaicu();

Ahh... strstr again.
Forgot to mention, you'd better make RS780E as fallback when no PCH type st=
ring
found in eboard name. That's to Loongson's crappy specification, 2/5 of my =
Loongson
boards didn't set their board name correctly.

 > =20
 >      irq_set_chip_and_handler(LOONGSON_UART_IRQ,
 >              &loongson_irq_chip, handle_percpu_irq);
 > diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
 > index de8e074..0720df7 100644
 > --- a/arch/mips/loongson64/smp.c
 > +++ b/arch/mips/loongson64/smp.c
 > @@ -20,6 +20,7 @@
 >  #include <loongson.h>
 >  #include <loongson_regs.h>
 >  #include <workarounds.h>
 > +#include <ioaicu.h>
 > =20
 >  #include "smp.h"
 > =20
 > @@ -336,10 +337,14 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 >      }
 > =20
 >      if (irqs) {
 > -        int irq;
 > +        int irq, irq1;
 > +
 >          while ((irq =3D ffs(irqs))) {
 > -            do_IRQ(irq-1);
 > -            irqs &=3D ~(1<<(irq-1));
 > +            irq1 =3D ls3a_ipi_pos2irq[irq - 1];
 > +            if (likely(irq1 !=3D (unsigned short)-1)) {
 > +                do_IRQ(irq1);
 > +                irqs &=3D ~(1 << (irq - 1));
 > +            }
 >          }
 >      }
 >  }
 > --=20
 > 2.1.0
 >=20
 >
