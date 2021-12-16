Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E8B477446
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhLPOTH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 16 Dec 2021 09:19:07 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:60973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhLPOTH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 09:19:07 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MCsDe-1mp6Aj1WF6-008vRY; Thu, 16 Dec 2021 15:19:05 +0100
Received: by mail-wr1-f49.google.com with SMTP id e5so11065576wrc.5;
        Thu, 16 Dec 2021 06:19:05 -0800 (PST)
X-Gm-Message-State: AOAM532Og1NAamdQ4IykJsrGX5en4sWA919JvtSJzq74nhr5o0GvmUir
        dHY5M61u632Bkn2nif7CbB9QpMIFr4KpamBoBJc=
X-Google-Smtp-Source: ABdhPJxmplO/8wUtDmbZb8q9bqy7ZOfHV5yg368TQTzX4lBN+OEsoFiUjwpCE3vTs4ls9wlTx+wNiOOu6o9NNRcFeqQ=
X-Received: by 2002:a05:6000:52:: with SMTP id k18mr9356273wrx.192.1639664344795;
 Thu, 16 Dec 2021 06:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-6-sergio.paracuellos@gmail.com> <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
 <6ee31420-ef67-471e-a924-a0158b4a9428@www.fastmail.com> <CAK8P3a2i6eW8JunE_6h6OTCa51eHfPahQQhaGHGWePX+r4ybww@mail.gmail.com>
 <bfdfb7b3-1322-573d-eddc-1d337c4616e6@flygoat.com>
In-Reply-To: <bfdfb7b3-1322-573d-eddc-1d337c4616e6@flygoat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Dec 2021 15:18:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2iQhxckn0MfLyLpKmyKN_MwAJ0t2yh6DLsS0MvdreYNA@mail.gmail.com>
Message-ID: <CAK8P3a2iQhxckn0MfLyLpKmyKN_MwAJ0t2yh6DLsS0MvdreYNA@mail.gmail.com>
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
X-Provags-ID: V03:K1:IgD0XB8DIUQjREsvuF1C3HD3944VUT61B2OriSnVMbiFXOdkvap
 O1lFdYUXI7kaNNJMBs5ZtyZHev1LquHSgazOunDmIgdwooZ8FOabTNhviJpzn22oMbsh7ga
 VVSOzehekRPVU1ka/2LvuUIFyd5YuBwuHQySwRtbWoBe3xLMwcQOnXW5AG+kZX3PIDA/IYT
 NqkgirYoJpAoN2Rmkj9mA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lDzxYfROAWU=:V6SAkS6NSz6czEHRo1NFM5
 zbjpP9ugIGMv1E9M3UMxd5h3U6u2E3INp75GevJKkI1k/BnSRBvuPQp1TVQShMu6tPjgvqwkl
 Meyriy3oznMWAfJEPJPF+WO8MmUxS4ObmkoDSPANtquK8/PwOTaY1AAeLOqf/Wy4C6/er9JYy
 A+K/kSllzzRWMgh0KEAERE42kAz/JrNGqvJbAZBXI0wGClFrM9wOPmp579BFFG+8iNUwwWlPP
 4tQREkhLITgAmWg8FGgLpLenuuppNvx7LBKzKrXZHvO494/4VkNKkzKF8ZCrQKo2egOEEUtNU
 AQdI5PfG+J2xIOC+yEo71xW7v28uP8vkTkdu2C5f3pLNWj3F4TANAfTZjxDzYFW5g7e6fHVgq
 ONACbz6HJN/y7WGxRiOtTTQxg+0zzUCWhNeep5D1Ott12q5GgwdkUXSjKkXSNA41wgGofV1X4
 qAXRE1ybP43WGnishkx+WeMKZ4NwJDL3OAqQSVclinp79bxWRmNzgexSVM5bNg1cWlxO7B2fo
 Ve4RNfQtvFlWp7RZKebYJabTSdu3jvAden6RRutoiFzDeYMwNZpzyRiMqXd2HPIoZeWniqjXB
 EEMVCNimWGDP+MBw1nfRwHph0f8hSI6+ERToDZiQkCMZhBgMZ+KvEDz7GQtfvFw9sQA5nn6f4
 7DGoa71ER1og0ReN/c4q23ttyLUk2ZtaXeuB7qCkSpJpI2HkMRHgAytLRiAQXuzfyYEFZURUZ
 9MWb7XzknP4mPQx3mzTZVG6EbPhsGJH0NCdZtCBNXimulHGkfFMjqqRX+/uE+Sh3x3s+70SZ9
 Gn2/eFbWhgG1O4DDc+crRCuyvhlfbH5CR9lVIXVXFtT+1lTLSg=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 16, 2021 at 3:14 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 在 2021/12/16 13:50, Arnd Bergmann 写道:
> > On Thu, Dec 16, 2021 at 2:07 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> >> 在2021年12月16日十二月 上午11:44，Xi Ruoyao写道：
> >> Another way could be keeping a linked list about PIO->PHYS mapping instead of using the single io_port_base variable.
> > I think that would add a lot of complexity that isn't needed here. Not
> > sure if all MIPS CPUs
> > can do it, but the approach used on Arm is what fits in best with the
> > PCI drivers, these
> > reserve a virtual address range for the ports, and ioremap the
> > physical addresses into
> > the PIO range according to the mapping.
>
> Yes, the Arm way was my previous approach when introducing PCI IO map
> for Loongson.
>
> It got refactored by this patch as TLB entries are expensive on MIPS,
> also the size of IO range doesn't always fits a page.

Are PIO accesses common enough that the TLB entry makes a difference?
I would imagine that on most systems with a PCI bus, there is not even
a single device that exposes an I/O resource, and even on those devices that
do, the kernel drivers tend to pick MMIO whenever both are available.

      Arnd
