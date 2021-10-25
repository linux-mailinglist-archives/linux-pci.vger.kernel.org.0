Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73543A596
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhJYVPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 17:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234509AbhJYVPA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 17:15:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C09BC61073;
        Mon, 25 Oct 2021 21:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635196358;
        bh=4MXuBNVzkrZP3yecgRjqdL1aeKI6T/KhfEayaMfhl5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Jwx48/xdZTS5oCSdpphMARaOk5BXsy/YhtvgQK58CS0MIbpFO/7nVRXfsizhctVfR
         DHn11NFtFXjfnu6kyDHuqPw89urntqir4r8uypb/5YKdemXm94z7eYj6keuXdeIE25
         DXSNsPXSoB7zjCqOT+Et5sjq1DtzstEtlDWbAhhCErQsIOpLcJ/97usD3deU4+3YdK
         MHURE3evLaqBPAtcbvjIeGjPfhVB6lKH0heav9dnl+Wot8LtpkTvQGZBBmEBQkPFve
         wn8n9vsGs2dHq3cKEq4GbiUzVa6XVCu+uhZ6TeALJcplO2i1e8+vq8/HkoP4FAQIIy
         2ot2MOyZdSGpQ==
Date:   Mon, 25 Oct 2021 16:12:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
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
Subject: Re: [PATCH v3 0/3] PCI: mt7621: Add MediaTek MT7621 PCIe host
 controller driver
Message-ID: <20211025211236.GA31293@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H90rD8aHJ+txDzFZ62Ej9_TY=BZMT+1058d=Pm_LfYwPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 11:13:39AM +0200, Sergio Paracuellos wrote:
> On Fri, Oct 22, 2021 at 10:35 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Thu, Oct 21, 2021 at 09:23:35PM +0200, Sergio Paracuellos wrote:
> > > On Thu, Oct 21, 2021 at 8:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 21, 2021 at 07:27:21PM +0200, Sergio Paracuellos wrote:
> > > > > On Thu, Oct 21, 2021 at 5:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > Since this is a PCIe (not conventional PCI) controller, I
> > > > > > vote for renaming these from:
> > > > > >
> > > > > >   PCI_MT7621
> > > > > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > > > >   drivers/pci/controller/pci-mt7621.c
> > > > > >
> > > > > > to:
> > > > > >
> > > > > >   PCIE_MT7621
> > > > > >   Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> > > > > >   drivers/pci/controller/pcie-mt7621.c
> > > > > >
> > > > > > We have a mix of these, with many of the early PCIe
> > > > > > drivers being named "pci", but I think that was my mistake
> > > > > > and there's no reason to continue it.
> > > > >
> > > > > I see.
> > > > >
> > > > > > I can do this locally unless somebody objects.
> > > > >
> > > > > I have no problem at all. Only one question. Do you mean to
> > > > > change compatible string also, or only the name of the file?
> > > > > Let me know if I have to do anything.
> > > >
> > > > I didn't change the compatible string, to avoid a DT
> > > > incompatibility.  But I *did* change the Kconfig symbol to
> > > > PCIE_MT7621, which could require changes to out-of-tree
> > > > .configs.  I'm open to suggestions either way for both things.
> > >
> > > IMHO, I do think we should not worry about out-of-tree stuff at
> > > all.
> >
> > For Kconfig I tend to agree. For DT I see some "bindings" in the
> > staging tree are being deleted and published as official DT
> > bindings with this patchset but I believe we still have to keep
> > the compatible string backward compatibility regardless because
> > there may be firmware out there using it.
> 
> The bindings txt file removed in staging with this patchset was also
> added by me three years ago[0], and has been changing until the YAML
> bindings are reviewed by Rob and driver updated accordly in this
> patchset.
>
> OpenWRT maintains its own file[1] which I don't know is updated or
> not according to the one in staging which I am pretending to
> properly mainline for 5.17. But yes, I agree there might be firmware
> out there using current compatible string.
> 
> [0]: Commit 5451e22618b8 ("staging: mt7621-pci: dt-bindings: add dt
> bindings for mt7621 pcie controller")
> [1]: https://github.com/openwrt/openwrt/blob/master/target/linux/ramips/dts/mt7621.dtsi

OK, for now I left my rework as-is:

  - changed CONFIG_PCI_MT7621 to CONFIG_PCIE_MT7621
  - renamed mediatek,mt7621-pci.yaml to mediatek,mt7621-pcie.yaml
  - renamed pci-mt7621.c to pcie-mt7621.c
  - kept DT compatible string "mediatek,mt7621-pci" in .yaml and .c

I reason that the Kconfig and filename changes only affect people
building kernels or DTs, but a compatible string change would force a
DT update to be synchronized with a kernel update.

Happy to change this if necessary.

Bjorn
