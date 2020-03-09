Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32ED17DBD4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCIIwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:52:37 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17822 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgCIIwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2020 04:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1583743004;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=fspPoWh79zaLVJtcCiuZPHpClxHc3HMz8kus+GU3cug=;
        b=YbuUMczt+Flzmo9PiR+v1tbqyKOqjXiarABsnK0yVQyEU3cIXUA8Flomt/pQ3/zb
        EhZm1g6u1W19YuqOmR4SzBDw8ALe8HixD94y6PpgzvK2f1GOSMeAw+GeHqIUii7eH58
        Re4eRPxz/0Ny+V8XxGeJkYgR/ksbqEj5o542DP6E=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1583743001556858.9546748061696; Mon, 9 Mar 2020 16:36:41 +0800 (CST)
Date:   Mon, 09 Mar 2020 16:36:41 +0800
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
Message-ID: <170be7063d1.c7d52ae02285.4730966984142345992@flygoat.com>
In-Reply-To: <1583742206-29163-4-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn> <1583742206-29163-4-git-send-email-yangtiezhu@loongson.cn>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[PATCH_3/6]_MIPS:_Loongson:_Use_?=
 =?UTF-8?Q?firmware_arguments_to_get_board_name?=
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



 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-03-09 16:23:23 Tiezhu Yan=
g <yangtiezhu@loongson.cn> =E6=92=B0=E5=86=99 ----
 > In order to distinguish various types of bridge chip such as AMD RS780E
 > or Loongson 7A1000, we can use firmware arguments to get board name.
 >=20
Hi Tiezhu,

Thanks for your contribution.
Your series is sightly conflict with my "modernize" series. But that's fine=
,
if your code can meet mainline requirement, I'm going to adjust my works.=
=20

See my comments bellow.

 > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
 > ---
 >  arch/mips/include/asm/mach-loongson64/boot_param.h | 1 +
 >  arch/mips/loongson64/env.c                         | 5 +++++
 >  2 files changed, 6 insertions(+)
 >=20
 > diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/m=
ips/include/asm/mach-loongson64/boot_param.h
 > index 8c286be..225a563 100644
 > --- a/arch/mips/include/asm/mach-loongson64/boot_param.h
 > +++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
 > @@ -217,5 +217,6 @@ struct loongson_system_configuration {
 > =20
 >  extern struct efi_memory_map_loongson *loongson_memmap;
 >  extern struct loongson_system_configuration loongson_sysconf;
 > +extern struct board_devices *eboard;
 > =20
 >  #endif
 > diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
 > index 0daeb7b..a244a8c 100644
 > --- a/arch/mips/loongson64/env.c
 > +++ b/arch/mips/loongson64/env.c
 > @@ -24,6 +24,9 @@ EXPORT_SYMBOL(cpu_clock_freq);
 >  struct efi_memory_map_loongson *loongson_memmap;
 >  struct loongson_system_configuration loongson_sysconf;
 > =20
 > +struct board_devices *eboard;
 > +EXPORT_SYMBOL(eboard);

Can we make it as a part of struct loongson_sysconf and export that struct?
Memory of struct eboard is not managed by kernel,  we shouldn't export such=
 symbol.

Also I noticed that you're checking PCH type repeatly in other subsystems. =
Can you just
determine the PCH type here?

 > +
 >  u64 loongson_chipcfg[MAX_PACKAGES] =3D {0xffffffffbfc00180};
 >  u64 loongson_chiptemp[MAX_PACKAGES];
 >  u64 loongson_freqctrl[MAX_PACKAGES];
 > @@ -51,6 +54,8 @@ void __init prom_init_env(void)
 >          ((u64)loongson_p + loongson_p->system_offset);
 >      ecpu =3D (struct efi_cpuinfo_loongson *)
 >          ((u64)loongson_p + loongson_p->cpu_offset);
 > +    eboard =3D (struct board_devices *)
 > +        ((u64)loongson_p + loongson_p->boarddev_table_offset);
 >      eirq_source =3D (struct irq_source_routing_table *)
 >          ((u64)loongson_p + loongson_p->irq_offset);
 >      loongson_memmap =3D (struct efi_memory_map_loongson *)
 > --=20
 > 2.1.0
 >=20
 >
