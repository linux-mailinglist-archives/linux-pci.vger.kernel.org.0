Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F14774B0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhLPOcT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 16 Dec 2021 09:32:19 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:35361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbhLPOcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 09:32:19 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTiLj-1n5F6a251h-00U5iK; Thu, 16 Dec 2021 15:32:17 +0100
Received: by mail-wr1-f53.google.com with SMTP id u17so44594231wrt.3;
        Thu, 16 Dec 2021 06:32:17 -0800 (PST)
X-Gm-Message-State: AOAM533iwfNXqkMdgKte3ZjTRTdALcjVIQsq4Opaa9Jp70+WE95OoDMZ
        iUuptiFib7+ZNGSeX3QfyG0c0vp8mq9EZ/KIiv0=
X-Google-Smtp-Source: ABdhPJy61qKYJci/6ZudP0JAo6z6MtYVZYLHYbaNUv1gpF53y5LHQ6bGJAcJW+L6DvxIcrhI+8fFJtv1wFeCyVqHDfs=
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr9483509wry.407.1639665137128;
 Thu, 16 Dec 2021 06:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-6-sergio.paracuellos@gmail.com> <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
 <6ee31420-ef67-471e-a924-a0158b4a9428@www.fastmail.com> <CAK8P3a2i6eW8JunE_6h6OTCa51eHfPahQQhaGHGWePX+r4ybww@mail.gmail.com>
 <bfdfb7b3-1322-573d-eddc-1d337c4616e6@flygoat.com> <CAK8P3a2iQhxckn0MfLyLpKmyKN_MwAJ0t2yh6DLsS0MvdreYNA@mail.gmail.com>
 <88d1835f-cee5-0fb2-f7de-7fc06e8e671d@flygoat.com>
In-Reply-To: <88d1835f-cee5-0fb2-f7de-7fc06e8e671d@flygoat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Dec 2021 15:32:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1nozEpQ_9Q+NhocWZDsrfLmDibrkmoX8ph63wYaFxvjg@mail.gmail.com>
Message-ID: <CAK8P3a1nozEpQ_9Q+NhocWZDsrfLmDibrkmoX8ph63wYaFxvjg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] MIPS: implement architecture-specific 'pci_remap_iospace()'
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Xi Ruoyao <xry111@mengyan1223.wang>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:gA7GXo2DEKhce0AUJVRuLUC/lfHEPBuUDniCQipWVbm/VXPxhdl
 a+m/0tcDIoOecbrut551OFpCc8NmTlbwJIYQVTNFuxgbN7lbe4NBUHqdpjQuGlfZBuo2M4N
 wNYWUbUbiMWuytTxg6yDglDXLylERVhnDSL8zyb9xMsTfWHiITcX3TjsnxEcAHruqvKqr4F
 UZtCPd5Q+M6v0GVhA/HAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fkeEueox5mQ=:0tksoT6zkMzd4IPAjJxPkL
 IAyyfJm+lmbrwivChtQ5EP7bF8Lx4osIB+yK76NS44fKbrkHWOmDa5FQlpn0eQ/sz38JsjXOi
 tXlY9O88tX35EaqSJRXSxpIPKqKMsYmQaQFXjFLK4Tn6OPPT5egZmef1evyFzJ0XOAY1lQmF6
 64KBiGYiFOjDsZHMK9if1WUj4HztMS2TRDpflUOhk9mw9u1vcCA4sI2fB+0GYmhrZgD1+Pws1
 xPmE7MESVcPct22QtTT3IAOeZZIGtPO+EFdFp4Da9tGdhINfrDv14/7PwdGcc5dWTpPK7fYGS
 eJlbq5LstlN2v+wLYZHwM8/z5DieBWgQQbx/DHkohTLDNpHbW1KKyDix3ERQ0sIdz6nspTE9j
 xuSxB1/ett5AKdlrJwAecXWtyDmk9xSPKSr08Hol/4pbryVv+139aBzoxdp2Q1RcfGmqIL7i8
 kEDYCvn6Pq9n8uQa5c8zR2D+qhCLzX8+R2km7NG1PVmfvN81DWhxf4FtmbCsP7x0h8S5/c+zY
 J8V2hrAijrDXQKBvHtLCc9tzzCO0tgJtKgjGgs0ShMHwuakqj1XgUSHJ2OWw63s1qDOfzGH4r
 3ECAyc43TcDZadUwAymnD9xMd1bWum8rZUTLPQt8+6ggG4VUdaTS+o6MKGlvg71zRZkLq3qC/
 1oD2gGzDM79mMmVWrU1kn1yh4Lh6qM0tKCpCsaXkXreWWxRHlKDZL2GyyG8TZnX7EfKXgG0UX
 tc6F+tQrhJufFntVcOESSBQNBCe/RwFmo2Y3NFtaXebcNV6xvGRfXT4ufogbib0do5doUk0TT
 R+h85F+YgQvwJMrquwPRlZstGJknircYs7oebHm6RmzZoL9Cl4=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 16, 2021 at 3:27 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 在 2021/12/16 14:18, Arnd Bergmann 写道:
> >> It got refactored by this patch as TLB entries are expensive on MIPS,
> >> also the size of IO range doesn't always fits a page.
> > Are PIO accesses common enough that the TLB entry makes a difference?
> > I would imagine that on most systems with a PCI bus, there is not even
> > a single device that exposes an I/O resource, and even on those devices that
> > do, the kernel drivers tend to pick MMIO whenever both are available.
>
> Actually that was claimed by the author of this patch :-)
> I can understand the point. As he is working on a ramips system utlizes
> 1004Kec,
> which has only 32 TLB entries, saving a entry can give considerable
> improvement.

Ok

> For Loongson as we have legacy i8042/i8259 which can only be accessed via
> PIO, the access is very common.

Ah, right. It makes a lot of sense that anything based on ISA PC peripherals
would need it, regardless of the PCI support.

       Arnd
