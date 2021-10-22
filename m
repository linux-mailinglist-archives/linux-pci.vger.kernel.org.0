Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C097437484
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 11:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJVJQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhJVJQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 05:16:09 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069C7C061766;
        Fri, 22 Oct 2021 02:13:52 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id l39so1147147vkd.7;
        Fri, 22 Oct 2021 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKZNZt/ePpP4JI+7GOVcUMH5xA+e+M0dG/pe/CUJvS4=;
        b=KC3eACJBtWgooU/lqi35STBN9j3/Mpq1z/NQeztv8hKgcweb5PPttx//R0/mjb/yTU
         0AXBD4mY/oCkSZx8kwihHJw2R/iSEOkxeK5et0KoiGS6Ukq9T3kcJ8zSNxh96uVKUqXZ
         2BhFy9fF1CdZAHQST9k09CZj4ypZBBpRKHRTb+5T+M2+6OZI6OuBjAEnwTB7uGBAGQSg
         rLHgqryWCQ3MZ8U4ltUIvvk2LGbEAFwW5N6t2YvcNaqqs22o2/zZ4Gqfpmcq7ye9Qqd3
         +299AkQkuufSOhN01Bn8ux9UVw0iVwtrqTXI0wgDSGnue7ocXXS498OdouczIQcwG9fq
         fEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKZNZt/ePpP4JI+7GOVcUMH5xA+e+M0dG/pe/CUJvS4=;
        b=8ENnwgdSzZPD8sZJPh0nT4MmgbiossFsfpQUiM2rRKqeQM2LhgUc8JrByRHcYg+kwS
         L2MS2NgR5qwe1uCd/5YZve/M3HFISv9OB1v+t5Dde5am0olAx1UH2L1g1oKSf4vUAWoM
         2BrfDbZD8KIfJmqXoKqzghkPvAqnhVIG/HarIXJcOr4rkqMR1d16VY3sTR511int0jNk
         N5xE5FSZR3sU9BM7B+f76cTOm714EjOkd/1Zw6RSAAfAsTLqIPgDrNtm10fx9zZOueUR
         lqGDfX+Ol4Qjse1+aCVkoY/I6hBgT1h/82wT+K2DcY2Jg3uHjiYbTmD1/9D0QqF5eisx
         GnhQ==
X-Gm-Message-State: AOAM531yiBODm7TRhmodKftMBNby4CcmttVo4fMuc7tVr/vHI7cL5YTz
        javLow758+dhtQmN5sly+4eihY9ue/9yRokPZYg=
X-Google-Smtp-Source: ABdhPJxIhtm4+luijSs2jaQ3y1B264lhviqg5RM6b964abV81JCkFejGfDh6lQH8xnRLntO8lcae1XLqV4UPtcsExYs=
X-Received: by 2002:a05:6122:d06:: with SMTP id az6mr12200459vkb.17.1634894030971;
 Fri, 22 Oct 2021 02:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhs-H-BA+KzEwuDPzcmrDPdgJBFA2XdYTBvT4R4MEOUB=WQ1g@mail.gmail.com>
 <20211021181145.GA2708516@bhelgaas> <CAMhs-H8pTmbG0idbPWjnW4faFj0F4TKwSSK6wzwepbqWSEtx4w@mail.gmail.com>
 <20211022083455.GA20345@lpieralisi>
In-Reply-To: <20211022083455.GA20345@lpieralisi>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 22 Oct 2021 11:13:39 +0200
Message-ID: <CAMhs-H90rD8aHJ+txDzFZ62Ej9_TY=BZMT+1058d=Pm_LfYwPA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 10:35 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Oct 21, 2021 at 09:23:35PM +0200, Sergio Paracuellos wrote:
> > On Thu, Oct 21, 2021 at 8:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Thu, Oct 21, 2021 at 07:27:21PM +0200, Sergio Paracuellos wrote:
> > > > On Thu, Oct 21, 2021 at 5:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > Since this is a PCIe (not conventional PCI) controller, I vote for
> > > > > renaming these from:
> > > > >
> > > > >   PCI_MT7621
> > > > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > > >   drivers/pci/controller/pci-mt7621.c
> > > > >
> > > > > to:
> > > > >
> > > > >   PCIE_MT7621
> > > > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> > > > >   drivers/pci/controller/pcie-mt7621.c
> > > > >
> > > > > We have a mix of these, with many of the early PCIe drivers being
> > > > > named "pci", but I think that was my mistake and there's no reason to
> > > > > continue it.
> > > >
> > > > I see.
> > > >
> > > > >
> > > > > I can do this locally unless somebody objects.
> > > >
> > > > I have no problem at all. Only one question. Do you mean to change
> > > > compatible string also, or only the name of the file? Let me know if I
> > > > have to do anything.
> > >
> > > I didn't change the compatible string, to avoid a DT incompatibility.
> > > But I *did* change the Kconfig symbol to PCIE_MT7621, which could
> > > require changes to out-of-tree .configs.  I'm open to suggestions
> > > either way for both things.
> >
> > IMHO, I do think we should not worry about out-of-tree stuff at all.
>
> For Kconfig I tend to agree. For DT I see some "bindings" in the staging
> tree are being deleted and published as official DT bindings with this
> patchset but I believe we still have to keep the compatible string
> backward compatibility regardless because there may be firmware out
> there using it.

The bindings txt file removed in staging with this patchset was also
added by me three years ago[0], and has been changing until the YAML
bindings are reviewed by Rob and driver updated accordly in this
patchset.
OpenWRT maintains its own file[1] which I don't know is updated or not
according to the one in staging which I am pretending to properly
mainline for 5.17. But yes, I agree there might be firmware out there
using current compatible string.

[0]: Commit 5451e22618b8 ("staging: mt7621-pci: dt-bindings: add dt
bindings for mt7621 pcie controller")
[1]: https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/dts/mt7621.dtsi

Best regards,
    Sergio Paracuellos
>
> Rob, what's the standard policy that should be used in this case ?
>
> Thanks,
> Lorenzo
>
> > If the correct way to define the Kconfig symbol or the compatible
> > string is to change them, just do that. MT7621 SoC is extensively used
> > by openWRT community. As far as I have seen until now, the way of
> > doing things there is to take the latest long term kernel (now they
> > are using 5.4 as stable and 5.10 as testing kernel), apply a bunch of
> > patches they have and do a complete build of both kernel, device tree
> > and rootfs. So I guess it is not a big problem if we also change
> > compatible string since when an update is performed for a device all
> > of the stuff is just replaced. Maybe I am wrong and John has a
> > different opinion... John, any comments on this?
> >
> > Best regards,
> >     Sergio Paracuellos
