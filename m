Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919D543ABDC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 07:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhJZFvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 01:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhJZFvx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 01:51:53 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216F9C061745;
        Mon, 25 Oct 2021 22:49:30 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id e10so26961646uab.3;
        Mon, 25 Oct 2021 22:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bt8gnFZ7zRXlSxTO50E3NK4ULqXSpvY8WAtWfScUzG0=;
        b=XvlFPA3yn+iFCXaotivzTIsO+qWlf16GeSElUXWhG3T3M9m/Cj9lW+Yis0yZVM7Cli
         vKCdl96OEhYMK1MTRZawjaTvU6V4HpDmET0j42lb6aoehCLXEEFXiZ2MeNJteE/GGM7o
         9mQsk2a1v+CRVPTfZblzsemULBqhRmIKc89xxSl9927Sg0jgb3sKpwM3FnEcPd/RJa7Z
         nV7eA2eiYNuGBo6WxrF0ARaFqnkRGFn/OQRspkOZO0TLHN3fOJkXFr0LNIgw3kN+i55d
         UIa5jCN2Xz0OQEeYBxiXb1zz2oYugJ41JVM93ww9jae/5a/JfwWAvARto7/adB/1YE9c
         +h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bt8gnFZ7zRXlSxTO50E3NK4ULqXSpvY8WAtWfScUzG0=;
        b=40TUtplK/NQHD0Uo3olavEDjG6+2VitGt89BuljoXrSrA5ScS+oj67x7nBqvqJg7vT
         4oLRV4Fta6CbLINaMHn6W9f+nY3rR88QDReX+TKRhQxG8tX6hA36MdFr7/h0HESno3YE
         hKDF+SxrlkPm5sFLa0G/hVtDRD3jQ3mX+mJydOh2YHOrYq+n+EbOs1qu/pD1O58w+CIG
         khYeo7HcqRsW3SX/gEQ7EOFZmZuaGKw7pnr6Zra6BplTrUSzhizMopT98k2wNCPDty9A
         pJso1xSLhF5KUIMI4RuIZHLam5G4TKGBVtlJvcn5ujFlakQ+nQyVv0QSA+Bamoo1Z9zb
         4mEA==
X-Gm-Message-State: AOAM5322/cFDImA8sTEQMpzgF1VDI525lZoSbeLznrUkvPFnIwsMX+uc
        1ULmGI9j2JuILv+QUaN0UwlVX7Sejv9uT3C99gc=
X-Google-Smtp-Source: ABdhPJwwQ1QduqebQ2QK3PagmHcpgq321TdFHCBaZL1Z8yoc0Ad/iVuajzcpNOgd85uNPT6zLUnZgT57V0K/7wzLMZM=
X-Received: by 2002:a9f:3523:: with SMTP id o32mr13839895uao.131.1635227368384;
 Mon, 25 Oct 2021 22:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhs-H90rD8aHJ+txDzFZ62Ej9_TY=BZMT+1058d=Pm_LfYwPA@mail.gmail.com>
 <20211025211236.GA31293@bhelgaas>
In-Reply-To: <20211025211236.GA31293@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 26 Oct 2021 07:49:16 +0200
Message-ID: <CAMhs-H_HL3OxfN7dCwbeqjwwufaNWEJJCfQeYk+42CVK8=69Ew@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
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

On Mon, Oct 25, 2021 at 11:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Oct 22, 2021 at 11:13:39AM +0200, Sergio Paracuellos wrote:
> > On Fri, Oct 22, 2021 at 10:35 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Thu, Oct 21, 2021 at 09:23:35PM +0200, Sergio Paracuellos wrote:
> > > > On Thu, Oct 21, 2021 at 8:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 21, 2021 at 07:27:21PM +0200, Sergio Paracuellos wrote:
> > > > > > On Thu, Oct 21, 2021 at 5:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > Since this is a PCIe (not conventional PCI) controller, I
> > > > > > > vote for renaming these from:
> > > > > > >
> > > > > > >   PCI_MT7621
> > > > > > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > > > > >   drivers/pci/controller/pci-mt7621.c
> > > > > > >
> > > > > > > to:
> > > > > > >
> > > > > > >   PCIE_MT7621
> > > > > > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> > > > > > >   drivers/pci/controller/pcie-mt7621.c
> > > > > > >
> > > > > > > We have a mix of these, with many of the early PCIe
> > > > > > > drivers being named "pci", but I think that was my mistake
> > > > > > > and there's no reason to continue it.
> > > > > >
> > > > > > I see.
> > > > > >
> > > > > > > I can do this locally unless somebody objects.
> > > > > >
> > > > > > I have no problem at all. Only one question. Do you mean to
> > > > > > change compatible string also, or only the name of the file?
> > > > > > Let me know if I have to do anything.
> > > > >
> > > > > I didn't change the compatible string, to avoid a DT
> > > > > incompatibility.  But I *did* change the Kconfig symbol to
> > > > > PCIE_MT7621, which could require changes to out-of-tree
> > > > > .configs.  I'm open to suggestions either way for both things.
> > > >
> > > > IMHO, I do think we should not worry about out-of-tree stuff at
> > > > all.
> > >
> > > For Kconfig I tend to agree. For DT I see some "bindings" in the
> > > staging tree are being deleted and published as official DT
> > > bindings with this patchset but I believe we still have to keep
> > > the compatible string backward compatibility regardless because
> > > there may be firmware out there using it.
> >
> > The bindings txt file removed in staging with this patchset was also
> > added by me three years ago[0], and has been changing until the YAML
> > bindings are reviewed by Rob and driver updated accordly in this
> > patchset.
> >
> > OpenWRT maintains its own file[1] which I don't know is updated or
> > not according to the one in staging which I am pretending to
> > properly mainline for 5.17. But yes, I agree there might be firmware
> > out there using current compatible string.
> >
> > [0]: Commit 5451e22618b8 ("staging: mt7621-pci: dt-bindings: add dt
> > bindings for mt7621 pcie controller")
> > [1]: https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/dts/mt7621.dtsi
>
> OK, for now I left my rework as-is:
>
>   - changed CONFIG_PCI_MT7621 to CONFIG_PCIE_MT7621
>   - renamed mediatek,mt7621-pci.yaml to mediatek,mt7621-pcie.yaml
>   - renamed pci-mt7621.c to pcie-mt7621.c
>   - kept DT compatible string "mediatek,mt7621-pci" in .yaml and .c
>
> I reason that the Kconfig and filename changes only affect people
> building kernels or DTs, but a compatible string change would force a
> DT update to be synchronized with a kernel update.

This is all ok for me, Bjorn. Thanks for doing this. I guess even if
we don't force people to a DT update to synchronize things, since
bindings have been changed until they have been approved, I guess most
people must upgrade from early not approved DT early versions in any
case. But in any case I guess that maintaining the compatible string
is the safest thing to do.

>
> Happy to change this if necessary.

Best regards,
    Sergio Paracuellos

>
> Bjorn
