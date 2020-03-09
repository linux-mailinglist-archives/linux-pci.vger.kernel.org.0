Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01A17DB6E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCIIpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:45:02 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17820 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgCIIpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 04:45:02 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 04:44:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1583743463;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=KYW5g7g60jlqHjJZmnr0prG4/+Or022x+S4xgii01O8=;
        b=alszJYuHTDjPCMOgeVyxkWaJ7mfBwId07TEPVKPtWuXJv2d3Fjit3+vBSqEYdF80
        QoEnFTRiuRPhHyr/6EPQ+l7F1iOPd6QFOluLvXKIKqYkn0NHZIFAERZVTwM3BS7ueSx
        vmi625jzdt+M78QphtL4MEO5r9GeMP0hhHdx/7VA=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1583743461607865.8077063393426; Mon, 9 Mar 2020 16:44:21 +0800 (CST)
Date:   Mon, 09 Mar 2020 16:44:21 +0800
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
        "Xuefeng Li" <lixuefeng@loongson.cn>
Message-ID: <170be7768e3.c920b6d62296.161774605460069850@flygoat.com>
In-Reply-To: <1583742206-29163-5-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn> <1583742206-29163-5-git-send-email-yangtiezhu@loongson.cn>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[PATCH_4/6]_MIPS:_Loongso?=
 =?UTF-8?Q?n:_Add_DMA_support_for_7A1000?=
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



 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-03-09 16:23:24 Tiezhu Yan=
g <yangtiezhu@loongson.cn> =E6=92=B0=E5=86=99 ----
 > Implement __phys_to_dma() and __dma_to_phys() according to the
 > node id offset in 7A1000 DMA route config register.

That design shocked me a lot. And It is known that some firmware didn't con=
figure
HT Recieve window correctly to make it work. So probably for mainline kerne=
l,
just set DMA_MASK to limit LS7A DMA address to Node0 would be a better Opti=
on?
=20
 > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
 > ---
 >  arch/mips/include/asm/mach-loongson64/boot_param.h |  1 +
 >  arch/mips/loongson64/dma.c                         | 49 +++++++++++++++=
++++++-
 >  arch/mips/loongson64/init.c                        | 13 ++++++
 >  3 files changed, 61 insertions(+), 2 deletions(-)
 >=20
 > diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/m=
ips/include/asm/mach-loongson64/boot_param.h
 > index 225a563..60e7a7e 100644
 > --- a/arch/mips/include/asm/mach-loongson64/boot_param.h
 > +++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
 > @@ -218,5 +218,6 @@ struct loongson_system_configuration {
 >  extern struct efi_memory_map_loongson *loongson_memmap;
 >  extern struct loongson_system_configuration loongson_sysconf;
 >  extern struct board_devices *eboard;
 > +extern u32 node_id_offset;
 > =20
 >  #endif
 > diff --git a/arch/mips/loongson64/dma.c b/arch/mips/loongson64/dma.c
 > index 5e86635..997c257 100644
 > --- a/arch/mips/loongson64/dma.c
 > +++ b/arch/mips/loongson64/dma.c
 > @@ -2,24 +2,69 @@
 >  #include <linux/dma-direct.h>
 >  #include <linux/init.h>
 >  #include <linux/swiotlb.h>
 > +#include <boot_param.h>
 > =20
 > -dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 > +struct loongson_dma_ops {
 > +    dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
 > +    phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
 > +};
 > +
 > +struct loongson_dma_ops loongson_dma;
 > +
 > +dma_addr_t __rs780e_phys_to_dma(struct device *dev, phys_addr_t paddr)
 >  {
 >      /* We extract 2bit node id (bit 44~47, only bit 44~45 used now) fro=
m
 >       * Loongson-3's 48bit address space and embed it into 40bit */
 >      long nid =3D (paddr >> 44) & 0x3;
 > +
 >      return ((nid << 44) ^ paddr) | (nid << 37);
 >  }
 > =20
 > -phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 > +dma_addr_t __ls7a_phys_to_dma(struct device *dev, phys_addr_t paddr)
 > +{
 > +    long nid =3D (paddr >> 44) & 0x3;
 > +
 > +    return ((nid << 44) ^ paddr) | (nid << (36 + node_id_offset));
 > +}
 > +
 > +
 > +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 > +{
 > +    return loongson_dma.phys_to_dma(dev, paddr);
 > +}
 > +
 > +phys_addr_t __rs780e_dma_to_phys(struct device *dev, dma_addr_t daddr)
 >  {
 >      /* We extract 2bit node id (bit 44~47, only bit 44~45 used now) fro=
m
 >       * Loongson-3's 48bit address space and embed it into 40bit */
 >      long nid =3D (daddr >> 37) & 0x3;
 > +
 >      return ((nid << 37) ^ daddr) | (nid << 44);
 >  }
 > =20
 > +phys_addr_t __ls7a_dma_to_phys(struct device *dev, dma_addr_t daddr)
 > +{
 > +    long nid =3D (daddr >> (36 + node_id_offset)) & 0x3;
 > +
 > +    return ((nid << (36 + node_id_offset)) ^ daddr) | (nid << 44);
 > +}
 > +
 > +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 > +{
 > +    return loongson_dma.dma_to_phys(dev, daddr);
 > +}
 > +
 >  void __init plat_swiotlb_setup(void)
 >  {
 >      swiotlb_init(1);
 > +
 > +    if (strstr(eboard->name, "780E")) {
 > +        loongson_dma.phys_to_dma =3D __rs780e_phys_to_dma;
 > +        loongson_dma.dma_to_phys =3D __rs780e_dma_to_phys;
 > +    }
 > +
 > +    if (strstr(eboard->name, "7A1000")) {
 > +        loongson_dma.phys_to_dma =3D __ls7a_phys_to_dma;
 > +        loongson_dma.dma_to_phys =3D __ls7a_dma_to_phys;
 > +    }
 >  }
 > diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
 > index 5ac1a0f..dd8463d 100644
 > --- a/arch/mips/loongson64/init.c
 > +++ b/arch/mips/loongson64/init.c
 > @@ -12,6 +12,11 @@
 >  #include <asm/fw/fw.h>
 > =20
 >  #include <loongson.h>
 > +#include <boot_param.h>
 > +
 > +#define NODE_ID_OFFSET_ADDR     0x90000E001001041CULL
 > +
 > +u32 node_id_offset;
 > =20
 >  static void __init mips_nmi_setup(void)
 >  {
 > @@ -23,6 +28,11 @@ static void __init mips_nmi_setup(void)
 >      flush_icache_range((unsigned long)base, (unsigned long)base + 0x80)=
;
 >  }
 > =20
 > +static void ls7a_early_config(void)
 > +{
 > +    node_id_offset =3D (*(u32 *)NODE_ID_OFFSET_ADDR >> 8) & 0x1F;

Please avoid raw pointer. Use readl/writel instead.

 > +}
 > +
 >  void __init prom_init(void)
 >  {
 >      fw_init_cmdline();
 > @@ -32,6 +42,9 @@ void __init prom_init(void)
 >      set_io_port_base((unsigned long)
 >          ioremap(LOONGSON_PCIIO_BASE, LOONGSON_PCIIO_SIZE));
 > =20
 > +    if (strstr(eboard->name, "7A1000"))
 > +        ls7a_early_config();
 > +
 >      prom_init_numa_memory();
 > =20
 >      /* Hardcode to CPU UART 0 */
 > --=20
 > 2.1.0
 >=20
 >
