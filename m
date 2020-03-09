Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9095417DB82
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCIItb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:49:31 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17809 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgCIItb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 04:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1583743681;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=leohfUa2RdovFtYX/evd4uHfcOnbnNPz/2a+lo3Wdpo=;
        b=YjL+otoqAK9RWzRHivckv71J8QywOsbSSeR8tBDPqLNoqsyhs61/pmfX/jEkGu/w
        edEam879PVao+c0s3sjwQIHOPPgPZwrHiwWMQf6ujBXtWVZ3cShYpQTF2aCY7IIjWwQ
        cUBOg1BiMXj4PHwZGVr0KrpkEVgnFOHFHWo21oG0=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1583743679601492.4287888170346; Mon, 9 Mar 2020 16:47:59 +0800 (CST)
Date:   Mon, 09 Mar 2020 16:47:59 +0800
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
Message-ID: <170be7abc6d.d0ea51502303.7109395874638183132@flygoat.com>
In-Reply-To: <1583742206-29163-6-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn> <1583742206-29163-6-git-send-email-yangtiezhu@loongson.cn>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[PATCH_5/6]_MIPS:_Loongso?=
 =?UTF-8?Q?n:_Add_PCI_support_for_7A1000?=
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



 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-03-09 16:23:25 Tiezhu Yan=
g <yangtiezhu@loongson.cn> =E6=92=B0=E5=86=99 ----
 > Add PCI support for 7A1000 to detect PCI device.
 >=20
 > Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
 > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
 > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
 > ---
 >  arch/mips/include/asm/mach-loongson64/pci.h |   1 +
 >  arch/mips/loongson64/pci.c                  |  12 ++-
 >  arch/mips/pci/Makefile                      |   2 +-
 >  arch/mips/pci/ops-loongson3-ls7a.c          | 132 +++++++++++++++++++++=
+++++++
 >  4 files changed, 143 insertions(+), 4 deletions(-)
 >  create mode 100644 arch/mips/pci/ops-loongson3-ls7a.c
 >=20
 > diff --git a/arch/mips/include/asm/mach-loongson64/pci.h b/arch/mips/inc=
lude/asm/mach-loongson64/pci.h
 > index 8b59d64..42c9744 100644
 > --- a/arch/mips/include/asm/mach-loongson64/pci.h
 > +++ b/arch/mips/include/asm/mach-loongson64/pci.h
 > @@ -8,6 +8,7 @@
 >  #define __ASM_MACH_LOONGSON64_PCI_H_
 > =20
 >  extern struct pci_ops loongson_pci_ops;
 > +extern struct pci_ops loongson_ls7a_pci_ops;
 > =20
 >  /* this is an offset from mips_io_port_base */
 >  #define LOONGSON_PCI_IO_START    0x00004000UL
 > diff --git a/arch/mips/loongson64/pci.c b/arch/mips/loongson64/pci.c
 > index e84ae20..b79368f 100644
 > --- a/arch/mips/loongson64/pci.c
 > +++ b/arch/mips/loongson64/pci.c
 > @@ -23,8 +23,8 @@ static struct resource loongson_pci_io_resource =3D {
 >      .flags    =3D IORESOURCE_IO,
 >  };
 > =20
 > -static struct pci_controller  loongson_pci_controller =3D {
 > -    .pci_ops    =3D &loongson_pci_ops,
 > +static struct pci_controller loongson_pci_controller =3D {
 > +    .pci_ops    =3D NULL,
 >      .io_resource    =3D &loongson_pci_io_resource,
 >      .mem_resource    =3D &loongson_pci_mem_resource,
 >      .mem_offset    =3D 0x00000000UL,
 > @@ -36,6 +36,11 @@ extern int sbx00_acpi_init(void);
 > =20
 >  static int __init pcibios_init(void)
 >  {
 > +    if (strstr(eboard->name, "780E"))
 > +        loongson_pci_controller.pci_ops =3D &loongson_pci_ops;
 > +
 > +    if (strstr(eboard->name, "7A1000"))
 > +        loongson_pci_controller.pci_ops =3D &loongson_ls7a_pci_ops;

Please do not check PCH type everywhere.

 > =20
 >      loongson_pci_controller.io_map_base =3D mips_io_port_base;
 >      loongson_pci_mem_resource.start =3D loongson_sysconf.pci_mem_start_=
addr;
 > @@ -43,7 +48,8 @@ static int __init pcibios_init(void)
 > =20
 >      register_pci_controller(&loongson_pci_controller);
 > =20
 > -    sbx00_acpi_init();
 > +    if (strstr(eboard->name, "780E"))
 > +        sbx00_acpi_init();
 > =20
 >      return 0;
 >  }
 > diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
 > index 342ce10..7256bb1 100644
 > --- a/arch/mips/pci/Makefile
 > +++ b/arch/mips/pci/Makefile
 > @@ -35,7 +35,7 @@ obj-$(CONFIG_LASAT)        +=3D pci-lasat.o
 >  obj-$(CONFIG_MIPS_COBALT)    +=3D fixup-cobalt.o
 >  obj-$(CONFIG_LEMOTE_FULOONG2E)    +=3D fixup-fuloong2e.o ops-loongson2.=
o
 >  obj-$(CONFIG_LEMOTE_MACH2F)    +=3D fixup-lemote2f.o ops-loongson2.o
 > -obj-$(CONFIG_MACH_LOONGSON64)    +=3D fixup-loongson3.o ops-loongson3.o
 > +obj-$(CONFIG_MACH_LOONGSON64)    +=3D fixup-loongson3.o ops-loongson3.o=
 ops-loongson3-ls7a.o
 >  obj-$(CONFIG_MIPS_MALTA)    +=3D fixup-malta.o pci-malta.o
 >  obj-$(CONFIG_PMC_MSP7120_GW)    +=3D fixup-pmcmsp.o ops-pmcmsp.o
 >  obj-$(CONFIG_PMC_MSP7120_EVAL)    +=3D fixup-pmcmsp.o ops-pmcmsp.o
 > diff --git a/arch/mips/pci/ops-loongson3-ls7a.c b/arch/mips/pci/ops-loon=
gson3-ls7a.c
 > new file mode 100644
 > index 0000000..4ed6c40
 > --- /dev/null
 > +++ b/arch/mips/pci/ops-loongson3-ls7a.c
 > @@ -0,0 +1,132 @@
 > +// SPDX-License-Identifier: GPL-2.0
 > +/*
 > + * Copyright (C) 2020 Loongson Technology Corporation Limited
 > + *
 > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
 > + * Author: Tiezhu Yang <yangtiezhu@loongson.cn>
 > + */
 > +
 > +#include <linux/types.h>
 > +#include <linux/pci.h>
 > +#include <linux/kernel.h>
 > +
 > +#include <asm/mips-boards/bonito64.h>

Why we need this?

 > +
 > +#include <loongson.h>
 > +
 > +#define PCI_ACCESS_READ 0
 > +#define PCI_ACCESS_WRITE 1
 > +
 > +#define HT1LO_PCICFG_BASE 0x1a000000
 > +#define HT1LO_PCICFG_BASE_TP1 0x1b000000
 > +
 > +#define HT1LO_PCICFG_BASE_EXT 0xefe00000000
 > +#define HT1LO_PCICFG_BASE_TP1_EXT 0xefe10000000
 > +
 > +static int ls7a_pci_config_access(unsigned char access_type,
 > +        struct pci_bus *bus, unsigned int devfn,
 > +        int where, u32 *data)
 > +{
 > +    u_int64_t addr;
 > +    void *addrp;
 > +    unsigned char busnum =3D bus->number;
 > +    int device =3D PCI_SLOT(devfn);
 > +    int function =3D PCI_FUNC(devfn);
 > +    int reg =3D where & ~3;
 > +
 > +    if (where >=3D PCI_CFG_SPACE_EXP_SIZE)
 > +        return PCIBIOS_DEVICE_NOT_FOUND;
 > +
 > +    if (busnum =3D=3D 0 && device > 23)
 > +        return PCIBIOS_DEVICE_NOT_FOUND;
 > +
 > +    if (where < PCI_CFG_SPACE_SIZE) { /* standard config */
 > +        addr =3D (busnum << 16) | (device << 11) | (function << 8) | re=
g;
 > +        if (busnum =3D=3D 0) {
 > +            addr =3D HT1LO_PCICFG_BASE | addr;
 > +            addrp =3D (void *)TO_UNCAC(addr);
 > +        } else {
 > +            addr =3D HT1LO_PCICFG_BASE_TP1 | addr;
 > +            addrp =3D (void *)TO_UNCAC(addr);
 > +        }
 > +    } else { /* extended config */
 > +        reg =3D (reg & 0xff) | ((reg & 0xf00) << 16);
 > +        addr =3D (busnum << 16) | (device << 11) | (function << 8) | re=
g;
 > +        if (busnum =3D=3D 0) {
 > +            addr =3D HT1LO_PCICFG_BASE_EXT | addr;
 > +            addrp =3D (void *)TO_UNCAC(addr);
 > +        } else {
 > +            addr =3D HT1LO_PCICFG_BASE_TP1_EXT | addr;
 > +            addrp =3D (void *)TO_UNCAC(addr);
 > +        }
 > +    }
 > +
 > +    if (access_type =3D=3D PCI_ACCESS_WRITE)
 > +        *(unsigned int *)addrp =3D cpu_to_le32(*data);
 > +    else {
 > +        *data =3D le32_to_cpu(*(unsigned int *)addrp);
 > +        if (busnum =3D=3D 0 &&
 > +            reg =3D=3D PCI_CLASS_REVISION && *data =3D=3D 0x06000001)
 > +            *data =3D (PCI_CLASS_BRIDGE_PCI << 16) | (*data & 0xffff);

It should be a part of quirk. Not a part of accessing.

 > +
 > +        if (*data =3D=3D 0xffffffff) {
 > +            *data =3D -1;
 > +            return PCIBIOS_DEVICE_NOT_FOUND;
 > +        }
 > +    }
 > +
 > +    return PCIBIOS_SUCCESSFUL;
 > +}
 > +
 > +static int ls7a_pci_pcibios_read(struct pci_bus *bus, unsigned int devf=
n,
 > +                 int where, int size, u32 *val)
 > +{
 > +    int ret;
 > +    u32 data =3D 0;
 > +
 > +    ret =3D ls7a_pci_config_access(PCI_ACCESS_READ, bus, devfn, where, =
&data);
 > +    if (ret !=3D PCIBIOS_SUCCESSFUL)
 > +        return ret;
 > +
 > +    if (size =3D=3D 1)
 > +        *val =3D (data >> ((where & 3) << 3)) & 0xff;
 > +    else if (size =3D=3D 2)
 > +        *val =3D (data >> ((where & 3) << 3)) & 0xffff;
 > +    else
 > +        *val =3D data;

That  loggic seems identical with RS780E one, can we reuse them?

> +
 > +    return PCIBIOS_SUCCESSFUL;
 > +}
 > +
 > +static int ls7a_pci_pcibios_write(struct pci_bus *bus, unsigned int dev=
fn,
 > +                  int where, int size, u32 val)
 > +{
 > +    int ret;
 > +    u32 data =3D 0;
 > +
 > +    if (size =3D=3D 4)
 > +        data =3D val;
 > +    else {
 > +        ret =3D ls7a_pci_config_access(PCI_ACCESS_READ, bus,
 > +                        devfn, where, &data);
 > +        if (ret !=3D PCIBIOS_SUCCESSFUL)
 > +            return ret;
 > +
 > +        if (size =3D=3D 1)
 > +            data =3D (data & ~(0xff << ((where & 3) << 3))) |
 > +                (val << ((where & 3) << 3));
 > +        else if (size =3D=3D 2)
 > +            data =3D (data & ~(0xffff << ((where & 3) << 3))) |
 > +                (val << ((where & 3) << 3));
 > +    }
 > +
 > +    ret =3D ls7a_pci_config_access(PCI_ACCESS_WRITE, bus,
 > +                    devfn, where, &data);
 > +
 > +    return ret;
 > +}
 > +
 > +struct pci_ops loongson_ls7a_pci_ops =3D {
 > +    .read =3D ls7a_pci_pcibios_read,
 > +    .write =3D ls7a_pci_pcibios_write
 > +};
 > --=20
 > 2.1.0
 >=20
 >
