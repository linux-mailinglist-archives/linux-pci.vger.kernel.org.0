Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99A4772B7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 14:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhLPNIH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 08:08:07 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45687 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234696AbhLPNIH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 08:08:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 60EBC580689;
        Thu, 16 Dec 2021 08:08:06 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Thu, 16 Dec 2021 08:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=lZxEZ
        oJEwcfSAdLDjCkroRP5fyKVBPGJT3N9TvVpHx0=; b=McMxPjqnXzi7GmzdFlDIZ
        il6I1fNyXQnjVvh2saCcID8TtgUbFDz1CGXVmFJBm5o72R0N0IVLo48qTBylIn5t
        j0l4O4E6kV9Y3P9QhS9m51buJz0eHAQ4AC0x1a1cOIf+ONfH3eHvRNtxRNaT5U/J
        05qW8Gsoyv/can8/iXRjuDPN1Tk68raN7M7VgrygnLdsQP8unXegnYn1lVYSYnDF
        PtjRJsOaVHQAwSi7dCoHRowkzejIjVIxxVBS1imT7SmgTz06wqdVZbnw1epBLXno
        1MmpHls8oN7aB97qu6QAIChhbDSC3aTgCUawEdyCKvY+SMWjBgPPL3wH6JWXW2LL
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=lZxEZoJEwcfSAdLDjCkroRP5fyKVBPGJT3N9TvVpH
        x0=; b=Sdkat6LvDH169I/f4YjFYs3UXcnfR2uq1GNjVW2LHm+t7SXFRy8/ZFv1V
        K9d8ugTZmdGIC+CAI/02uuItqCBXIKB1xFx9ab3kMaCjgNI7NNX+ep7JCZWmn1ZS
        kROd/5NtFrc2qoAaHQKyDghPXOnPqQHUQ5/Z7nGW643grLns8jLG20r91hC/9lNy
        Z25Yy54m+s40Uz8UbheQRxf4JN/PPo8tLa9a/Ko+Zm8UqdDl5VE8PHcoR4TMKwp+
        uNfepfDWaZ7USfFRAmSIGnsaVCfUGjCVcGAijbXEke9c69m+5qxxJ3tn1KzG4nuy
        RwyAKl4jPmxm0kIhAIfLzXFXd5p3A==
X-ME-Sender: <xms:NTq7YYyW4mJNfkzjn44YJBgdiPriC4KgFUnrX1XKScOTDa43ZCI18A>
    <xme:NTq7YcT9wSbyDlxHyzgGK50SnFkX2rBvgIePvsRX_MWMwID--auUZfjqwc9pSaFfN
    7_hTzCl2Gp67YRaLAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:NTq7YaV8p6oEASGHejvLsw_r94XlS-GxfBTEfLcNZVVmjBXFOAu-uw>
    <xmx:NTq7YWi8S2ZTOkTIvZz76z6_rx3j8miG8olSuEPJz0yf69BmrWP8sA>
    <xmx:NTq7YaBsqLUPNiejKiZtHuFvAp5kwlEuH9eruiEJQbPy4Sq80GnW7w>
    <xmx:Njq7YW4-8aSA_bX9neSAhMd1uql52Q5FW0-hARmnb4o5hZ0dHHGZug>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 70D94FA0AA6; Thu, 16 Dec 2021 08:08:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <6ee31420-ef67-471e-a924-a0158b4a9428@www.fastmail.com>
In-Reply-To: <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-6-sergio.paracuellos@gmail.com>
 <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
Date:   Thu, 16 Dec 2021 13:07:43 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Xi Ruoyao" <xry111@mengyan1223.wang>,
        "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     robh@kernel.org, "Arnd Bergmann" <arnd@arndb.de>,
        catalin.marinas@arm.com, Liviu.Dudau@arm.com,
        "Bjorn Helgaas" <bhelgaas@google.com>, matthias.bgg@gmail.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] MIPS: implement architecture-specific 'pci_remap_iospace()'
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82021=E5=B9=B412=E6=9C=8816=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8A=E5=8D=8811:44=EF=BC=8CXi Ruoyao=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, 2021-09-25 at 22:32 +0200, Sergio Paracuellos wrote:
>> To make PCI IO work we need to properly virtually map IO cpu physical=
 address
>> and set this virtual address as the address of the first PCI IO port =
which
>> is set using function 'set_io_port_base()'.
>>=20
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Hi,
>
> the change is causing a WARNING on loongson64g-4core-ls7a:
>
> [    0.105781] loongson-pci 1a000000.pci:       IO=20
> 0x0018020000..0x001803ffff ->
>  0x0000020000
> [    0.105792] loongson-pci 1a000000.pci:      MEM=20
> 0x0040000000..0x007fffffff ->
>  0x0040000000
> [    0.105801] ------------[ cut here ]------------
> [    0.105804] WARNING: CPU: 0 PID: 1 at arch/mips/pci/pci-generic.c:5=
5=20
> pci_remap_iospace+0x80/0x88
> [    0.105815] resource start address is not zero
>
> I'm not sure how to fix this one.
>
>> ---
>> =C2=A0arch/mips/include/asm/pci.h |=C2=A0 2 ++
>> =C2=A0arch/mips/pci/pci-generic.c | 14 ++++++++++++++
>> =C2=A02 files changed, 16 insertions(+)
>>=20
>> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
>> index 9ffc8192adae..35270984a5f0 100644
>> --- a/arch/mips/include/asm/pci.h
>> +++ b/arch/mips/include/asm/pci.h
>> @@ -20,6 +20,8 @@
>> =C2=A0#include <linux/list.h>
>> =C2=A0#include <linux/of.h>
>> =C2=A0
>> +#define pci_remap_iospace pci_remap_iospace
>> +
>> =C2=A0#ifdef CONFIG_PCI_DRIVERS_LEGACY
>> =C2=A0
>> =C2=A0/*
>> diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
>> index 95b00017886c..18eb8a453a86 100644
>> --- a/arch/mips/pci/pci-generic.c
>> +++ b/arch/mips/pci/pci-generic.c
>> @@ -46,3 +46,17 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_read_bridge_bases=
(bus);
>> =C2=A0}
>> +
>> +int pci_remap_iospace(const struct resource *res, phys_addr_t phys_a=
ddr)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long vaddr;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res->start !=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0WARN_ONCE(1, "resource start address is not zero\n"=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vaddr =3D (unsigned long)i=
oremap(phys_addr, resource_size(res));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set_io_port_base(vaddr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> +}

Hi all,

Another way could be keeping a linked list about PIO->PHYS mapping inste=
ad of using the single io_port_base variable.

Thanks.

>
> --=20
> Xi Ruoyao <xry111@mengyan1223.wang>
> School of Aerospace Science and Technology, Xidian University

--=20
- Jiaxun
