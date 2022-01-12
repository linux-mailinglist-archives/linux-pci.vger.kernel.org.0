Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222D048CCE2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 21:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357222AbiALUKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 15:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357669AbiALUJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 15:09:48 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688EC06173F;
        Wed, 12 Jan 2022 12:09:48 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id p37so7030571uae.8;
        Wed, 12 Jan 2022 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/4zazzFqIYCG/88G2zNvkkpvFQtMz6NxYikeCTrDZI8=;
        b=n2jcE2JB0r4p/pRX7koB0HcEiZxuEm+139VeLMGmRhc0z2YEjLKbagbzFaz+aLJoIv
         MqHtwbNDhmy+lWBbx7fCpujC9k8ENfxgB+tf3FOHa8yFvdzO8T3infL44dEBy3HULBNM
         VafqG82USxgDxiS7giR7OuVwBtkGu7i54/mDXoi4HahJ1IErV/l5puRYFdNF8i0zR/HW
         mSUwGxvRGSa4Qwec8CebhvNm0xdDMjRoUiQawNbWT55n7Bg9o7aXGwH/FT9zwMWQQfnn
         IzJtHBOTptqwdKyHTzsglPiNDuQI11Cl8ZnolUzm4VS0N5lsKZslquDRbTW2kI/D8xQP
         ghtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/4zazzFqIYCG/88G2zNvkkpvFQtMz6NxYikeCTrDZI8=;
        b=MFalsCd5/uVhd4fIz+7ARGbhSLaEJlZyWZPu2Sq5/QuknrrCgxv3avJ3tR1AZB+EtT
         gDebTzSYfyqm1iFscA/NbXrlhe3kDdzJ22+sqbrbIdD6zyKI/vyvJUqncBS69nV2OdSj
         lJrpBifwbkEp/zWFHh+MoRkaQXOifiCxcIIk190br1wMH6OuuElz55OEXeyXAoVORQAi
         wTNIbfRXhRadu1m0bEEMW0UxT6ztvksXmETLrZ9fLQ47v7VXLlTsyWTVAoNUq5oayWyF
         J2CJ8sFSVh6vTZDfauYa4+HAC3RM08kjDGYopqKF4WezAS3fm1l6C0+ZTf58iW7C9Kzr
         OPmg==
X-Gm-Message-State: AOAM531Gic1paEnAN7Qs/GhdzT5Mn/PQ9mE/Cxkk2iYpF9OjwJ67Sn9N
        3Unc/eGJKEZiFQEASm0oLthAzhGQN2iWHIYx/S8=
X-Google-Smtp-Source: ABdhPJxJo/rld++GT9M5d6zn4cBK6v8mhODfJW+SsfVSE/Z0P8+PlYSevigr4p+wsfOnnf8CplHidPAUdUc1sqBKvJE=
X-Received: by 2002:ab0:3c9e:: with SMTP id a30mr969512uax.131.1642018187671;
 Wed, 12 Jan 2022 12:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
 <CAMhs-H886ZPZED-qmMtZcWFabRLNL14Y7SSz_Ko7d45zXL+v2w@mail.gmail.com> <20220112180627.GB1319@lpieralisi>
In-Reply-To: <20220112180627.GB1319@lpieralisi>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 12 Jan 2022 21:09:36 +0100
Message-ID: <CAMhs-H_KXmAuJzJhNWoHX7yy0p2hNeexe5rbBc4EPinTwGmzSA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PCI: mt7621: Remove specific MIPS code from driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 7:06 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Jan 12, 2022 at 03:42:56PM +0100, Sergio Paracuellos wrote:
> > Hi Bjorn, Lorenzo,
> >
> > On Tue, Dec 7, 2021 at 11:49 AM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > >
> > > Hi all,
> > >
> > > MIPS specific code can be removed from driver and put into ralink mt7=
621
> > > instead which is a more accurate place to do this. To make this possi=
ble
> > > we need to have access to 'bridge->windows' in 'pcibios_root_bridge_p=
repare()'
> > > which has been implemented for ralink mt7621 platform (there is no re=
al
> > > need to implement this for any other platforms since those ones haven=
't got
> > > I/O coherency units). This also allow us to properly enable this driv=
er to
> > > completely be enabled for COMPILE_TEST. This patchset appoarch:
> > > - Move windows list splice in 'pci_register_host_bridge()' after func=
tion
> > >   'pcibios_root_bridge_prepare()' is called.
> > > - Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
> > > - Avoid custom MIPs code in pcie-mt7621 driver.
> > > - Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compi=
le test
> > >   module compilation to complain (already sent patch from Yanteng Si =
that
> > >   I have rewrite commit message and long description a bit.
> > > - Remove MIPS conditional code from Kconfig and mark driver as 'trist=
ate'.
> > >
> > > This patchset is a real fix for some errors reported by Kernel Test R=
obot about
> > > implicit mips functions used in driver code and fix errors in driver =
when
> > > is compiled as a module [1] (mips:allmodconfig).
> > >
> > > Changes in v3:
> > >  - Rebase the series on the top of the temporal fix sent for v5.16[3]=
 for
> > >    the module compilation problem.
> > >  - Address review comments from Guenter in PATCH 2 (thanks Guenter!):
> > >     - Address TODO in comment about the hardware does not allow zeros
> > >       after 1s for the mask and WARN_ON if that's happend.
> > >     - Be sure mask is real valid upper 16 bits.
> >
> > What are your plans for this series? Can we merge this?
>
> I was waiting for an ACK on patch (2) since it affects MIPS code.

I was expecting Thomas to get ACK for this patch or get it through the
MIPS tree.

>
> It would also be great if Bjorn reviewed it to make sure he agrees
> with the approach.

Agreed.

>
> I think it is too late for this cycle, apologies, there is a significant
> review backlog.
>
> Lorenzo

Best regards,
    Sergio Paracuellos

>
> > Best regards,
> >     Sergio Paracuellos
> >
> > >
> > > Changes in v2:
> > >  - Collect Acked-by from Arnd Bergmann for PATCH 1.
> > >  - Collect Reviewed-by from Krzysztof Wilczy=C5=84ski for PATCH 4.
> > >  - Adjust some patches commit subject and message as pointed out by B=
jorn in review of v1 of the series[2].
> > >
> > > This patchset is the good way of properly compile driver as a module =
removing
> > > all MIPS specific code into arch ralink mt7621 place. To avoid mips:a=
llmodconfig reported
> > > problems for v5.16 the following patch has been sent[3]. This series =
are rebased onto this patch to provide
> > > a real fix for this problem.
> > >
> > > [0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=
=3DV365RXN_Kjuj=3DfPFENGJiiw@mail.gmail.com/T/#t
> > > [1]: https://lkml.org/lkml/2021/11/14/436
> > > [2]: https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuel=
los@gmail.com
> > > [3]: https://lore.kernel.org/linux-pci/20211203192454.32624-1-sergio.=
paracuellos@gmail.com/T/#u
> > >
> > > Thanks in advance for your time.
> > >
> > > Best regards,
> > >    Sergio Paracuellos
> > >
> > > Sergio Paracuellos (5):
> > >   PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
> > >   MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
> > >   PCI: mt7621: Avoid custom MIPS code in driver code
> > >   PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
> > >   PCI: mt7621: Allow COMPILE_TEST for all arches
> > >
> > >  arch/mips/ralink/mt7621.c            | 31 ++++++++++++++++++++++
> > >  drivers/pci/controller/Kconfig       |  4 +--
> > >  drivers/pci/controller/pcie-mt7621.c | 39 ++------------------------=
--
> > >  drivers/pci/probe.c                  |  4 +--
> > >  4 files changed, 37 insertions(+), 41 deletions(-)
> > >
> > > --
> > > 2.33.0
> > >
