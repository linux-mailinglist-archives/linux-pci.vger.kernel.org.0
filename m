Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F7848D21C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 06:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiAMFwy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 00:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiAMFwx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 00:52:53 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872FFC06173F;
        Wed, 12 Jan 2022 21:52:53 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id c36so9043893uae.13;
        Wed, 12 Jan 2022 21:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VacwZVPOJEgERNsEcisnb2BeyEAPowJ9bL7/Aod4750=;
        b=Qjkseb1t5CmCIjGVttXv7Vekl6sKJB+xrWoSxAQTuKsgsYi4r9Fn+Z0opv4QFRWeJ5
         JLbXRON3hGCJLBvrrCYnbzzvYa+zSlcg6nEii1noY4AhbgxB53sx9rGfGVNPd1rx4i4e
         uckNRYjIKWSPuirGMYJO+wHFjbqBEtfQT14CwNLJIUJeARI2tECzIE0+xL/efbzsHzmH
         GA5uWUwmowSkP5mO5JXLRnAlUVXqRqVt9RDbbbkxeU2Ue2rItiEgXDROdFrTcrPhkKiV
         oT1z7oua5p2D6JAnY4EWN89QGaH9KId8Qd8/piT82poomcc1BBn9Zj3it8fm2S7ewD8D
         CwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VacwZVPOJEgERNsEcisnb2BeyEAPowJ9bL7/Aod4750=;
        b=QJ+t1GP7i3azlFD3kGsQgxaP1N6QPF+1YfDbR+ocQHxMZBPifW5Fw5G8zkG/T2mPr1
         rIUTRucLirakorahWkh6TVvHdmVCBLmnT/qU53OpSdHomPiK1ZgnTZBVn1Ii2uvClYmq
         pGp/UilaQFMfELrSdAwEWmKQm24zZ0oVhAjVJOQhjReOp2cDqIqIutmChTNZmxhwH6nu
         v7GgfIHxL7J7KS3oa1TBgGYcVZ2lrdKIR2l4ePj0UH2a9XhnbZ/BsTcP75qxhqaeXpaf
         8TbOcgHjRfE45+PdEiRVwhyt+3Y5+xTr9/JnOZa8dU1SMsrgdqFVidYymIkhFMABjVsk
         FUhA==
X-Gm-Message-State: AOAM531vQRiHVbZ2vLDvdfvviKqK3GYwN4ZmZnPIVfQhxkjuIC+QU5Q7
        2hk9SAqJd+vsHUIatZ5q9YFtXqoRL5b0b2PHe7esO7RayFg=
X-Google-Smtp-Source: ABdhPJy/PvHFS7oW3cogGKFqF6P6ZQntSgJd9pWl4ZiU8cO8ToHne1XXLLPruuAE8RpryJymiilm/2QMOa+e8Sfcho4=
X-Received: by 2002:a9f:31cc:: with SMTP id w12mr1633916uad.46.1642053172642;
 Wed, 12 Jan 2022 21:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com> <20220112215203.GA286653@bhelgaas>
In-Reply-To: <20220112215203.GA286653@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 13 Jan 2022 06:52:41 +0100
Message-ID: <CAMhs-H-D_58dbYX1jetMMVEf4p+sSP0CV5GEEC7bBLs8Eo7wpQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PCI: mt7621: Remove specific MIPS code from driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Jan 12, 2022 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Dec 07, 2021 at 11:49:19AM +0100, Sergio Paracuellos wrote:
> > Hi all,
> >
> > MIPS specific code can be removed from driver and put into ralink mt762=
1
> > instead which is a more accurate place to do this. To make this possibl=
e
> > we need to have access to 'bridge->windows' in 'pcibios_root_bridge_pre=
pare()'
> > which has been implemented for ralink mt7621 platform (there is no real
> > need to implement this for any other platforms since those ones haven't=
 got
> > I/O coherency units). This also allow us to properly enable this driver=
 to
> > completely be enabled for COMPILE_TEST. This patchset appoarch:
> > - Move windows list splice in 'pci_register_host_bridge()' after functi=
on
> >   'pcibios_root_bridge_prepare()' is called.
> > - Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
> > - Avoid custom MIPs code in pcie-mt7621 driver.
> > - Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compile=
 test
> >   module compilation to complain (already sent patch from Yanteng Si th=
at
> >   I have rewrite commit message and long description a bit.
> > - Remove MIPS conditional code from Kconfig and mark driver as 'tristat=
e'.
> >
> > This patchset is a real fix for some errors reported by Kernel Test Rob=
ot about
> > implicit mips functions used in driver code and fix errors in driver wh=
en
> > is compiled as a module [1] (mips:allmodconfig).
> >
> > Changes in v3:
> >  - Rebase the series on the top of the temporal fix sent for v5.16[3] f=
or
> >    the module compilation problem.
> >  - Address review comments from Guenter in PATCH 2 (thanks Guenter!):
> >     - Address TODO in comment about the hardware does not allow zeros
> >       after 1s for the mask and WARN_ON if that's happend.
> >     - Be sure mask is real valid upper 16 bits.
> >
> > Changes in v2:
> >  - Collect Acked-by from Arnd Bergmann for PATCH 1.
> >  - Collect Reviewed-by from Krzysztof Wilczy=C5=84ski for PATCH 4.
> >  - Adjust some patches commit subject and message as pointed out by Bjo=
rn in review of v1 of the series[2].
> >
> > This patchset is the good way of properly compile driver as a module re=
moving
> > all MIPS specific code into arch ralink mt7621 place. To avoid mips:all=
modconfig reported
> > problems for v5.16 the following patch has been sent[3]. This series ar=
e rebased onto this patch to provide
> > a real fix for this problem.
> >
> > [0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=3DV=
365RXN_Kjuj=3DfPFENGJiiw@mail.gmail.com/T/#t
> > [1]: https://lkml.org/lkml/2021/11/14/436
> > [2]: https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuello=
s@gmail.com
> > [3]: https://lore.kernel.org/linux-pci/20211203192454.32624-1-sergio.pa=
racuellos@gmail.com/T/#u
> >
> > Thanks in advance for your time.
> >
> > Best regards,
> >    Sergio Paracuellos
> >
> > Sergio Paracuellos (5):
> >   PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
> >   MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
> >   PCI: mt7621: Avoid custom MIPS code in driver code
> >   PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
> >   PCI: mt7621: Allow COMPILE_TEST for all arches
> >
> >  arch/mips/ralink/mt7621.c            | 31 ++++++++++++++++++++++
> >  drivers/pci/controller/Kconfig       |  4 +--
> >  drivers/pci/controller/pcie-mt7621.c | 39 ++--------------------------
> >  drivers/pci/probe.c                  |  4 +--
> >  4 files changed, 37 insertions(+), 41 deletions(-)
>
> I tentatively put this on my pci/host/mt7621 branch.  The only
> non-mt7621 change is the pci_register_host_bridge() change, which
> seems innocuous, so maybe we can still squeeze it in.
>
> I squashed these patches together:
>
>   MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
>   PCI: mt7621: Avoid custom MIPS code in driver code
>
> because the first adds the coherency setup to the MIPS
> pcibios_root_bridge_prepare(), and the second removes that same code
> from pcie-mt7621.c.  I think it makes more sense to do it as a move in
> a single patch, both for ease of reviewing and for potential
> bisection.

Makes sense. Thanks for letting me know.

Best regards,
    Sergio Paracuellos
