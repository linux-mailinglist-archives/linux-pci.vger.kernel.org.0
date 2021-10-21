Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A50436B4E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhJUT0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUT0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 15:26:03 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D9BC0613B9;
        Thu, 21 Oct 2021 12:23:47 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a17so3220372uax.12;
        Thu, 21 Oct 2021 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iZOrd1VHON6EXEVnr2OGsIIn2iCBQ+KTNa7mjlDUM0=;
        b=oxB1oSOsP0sTjaOmhjon770YW0M1lJJYpt6kycMBP4ougazTjT4o4QoXDq6Lu79V2S
         hjfZ+0HAa+wQ3rbYJ02VZQpNntDOWduBrCMRiT8+7CxerTMUTtIztOyT/oS/pdduADuV
         NjeLE7OR3qqPYyrhR0gzYFzM6rSU6kKOVnNjaT6c/eiRNHvJ1AkRZxr6imxPRMEJsjk6
         vy4+mZ/dXprzxb4DiQbaACRAW+3Q8NKkcPGqXO2xk98sOl08oX6Eo5Ftm9DZnkGJrtQT
         IxCvjQorWaca5/mxyq5+P3Cloteu4eXEI7h5v8/L7Xgr+VyDcUAbGMTKMJGAS7vjxjzY
         f2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iZOrd1VHON6EXEVnr2OGsIIn2iCBQ+KTNa7mjlDUM0=;
        b=yd3+F7XFNkuYmuLuGF8VWGFBf+qsB9wwSiaUuzvh/FsUVV/M3Hjv4QWYWX4hqrXgPq
         LcS1uhhmGkl+CTa6gTuUQygXipqzP7dOui337SptEXG1d0MX28/TOGLYDl/TIOPpTY0M
         bVx/ERoDx5kwpYGTY1lRXXXHjDGlUp6Ut0f8rdJSjPKuB99CPMcFN3JG/IWjG7OcGZ8x
         W2GWxSmb0fP6yei8+WKgWBfXTm5U6R7vgi1Kt7LjPQEVpQP9hKSUpygWXpWjfRIHVXWZ
         1mps41XoAZDanzD7LQPRn8iTrA3FL+j0sOkJQk+ax+yKP5+46BT0AFGlkRIB4Po39L6B
         9Hnw==
X-Gm-Message-State: AOAM531aHj+cuQqGVPMO5TJHcuJsWhg6BikVjZ1tR4+k0Dt/eTJK3HGD
        mLREovvCulXpNM7y6rkha5I2u8DSx8+/cRDFc7E=
X-Google-Smtp-Source: ABdhPJyl+qrRv/nOh0WSig9UsFs43pWf6wVkaq74TeHbHFuOzbysXm1dvud4VyCuBvqj0AKn04lPsWGHcuy+eAYMdrA=
X-Received: by 2002:a05:6102:e11:: with SMTP id o17mr8846106vst.55.1634844226344;
 Thu, 21 Oct 2021 12:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhs-H-BA+KzEwuDPzcmrDPdgJBFA2XdYTBvT4R4MEOUB=WQ1g@mail.gmail.com>
 <20211021181145.GA2708516@bhelgaas>
In-Reply-To: <20211021181145.GA2708516@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 21 Oct 2021 21:23:35 +0200
Message-ID: <CAMhs-H8pTmbG0idbPWjnW4faFj0F4TKwSSK6wzwepbqWSEtx4w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

On Thu, Oct 21, 2021 at 8:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Oct 21, 2021 at 07:27:21PM +0200, Sergio Paracuellos wrote:
> > On Thu, Oct 21, 2021 at 5:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > Since this is a PCIe (not conventional PCI) controller, I vote for
> > > renaming these from:
> > >
> > >   PCI_MT7621
> > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > >   drivers/pci/controller/pci-mt7621.c
> > >
> > > to:
> > >
> > >   PCIE_MT7621
> > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> > >   drivers/pci/controller/pcie-mt7621.c
> > >
> > > We have a mix of these, with many of the early PCIe drivers being
> > > named "pci", but I think that was my mistake and there's no reason to
> > > continue it.
> >
> > I see.
> >
> > >
> > > I can do this locally unless somebody objects.
> >
> > I have no problem at all. Only one question. Do you mean to change
> > compatible string also, or only the name of the file? Let me know if I
> > have to do anything.
>
> I didn't change the compatible string, to avoid a DT incompatibility.
> But I *did* change the Kconfig symbol to PCIE_MT7621, which could
> require changes to out-of-tree .configs.  I'm open to suggestions
> either way for both things.

IMHO, I do think we should not worry about out-of-tree stuff at all.
If the correct way to define the Kconfig symbol or the compatible
string is to change them, just do that. MT7621 SoC is extensively used
by openWRT community. As far as I have seen until now, the way of
doing things there is to take the latest long term kernel (now they
are using 5.4 as stable and 5.10 as testing kernel), apply a bunch of
patches they have and do a complete build of both kernel, device tree
and rootfs. So I guess it is not a big problem if we also change
compatible string since when an update is performed for a device all
of the stuff is just replaced. Maybe I am wrong and John has a
different opinion... John, any comments on this?

Best regards,
    Sergio Paracuellos
