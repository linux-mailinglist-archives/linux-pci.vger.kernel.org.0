Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C690F7A43
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKKRxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 12:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfKKRxI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 12:53:08 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC83221655;
        Mon, 11 Nov 2019 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573494787;
        bh=xJFmVH/uXjYcNb75TTvwpLpBB4PDjlo1ZUoxbrejYcc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H3wLrPCq1S2mcidD9ntD27yBxkc4CM792jL8Pwa/Vz0JLBKojxI9knN51xjHE9VfU
         rqiDQJUzeiQQAp68aT/prDdrrZWHCuzJI4OYzPfd32lk1lxN0DVxw9Z+SxL9PBQ27W
         l/xWBrhq78wNJwnjyw3I1XVxeud9TDwCmLkf7gh8=
Received: by mail-qk1-f174.google.com with SMTP id e187so11945046qkf.4;
        Mon, 11 Nov 2019 09:53:06 -0800 (PST)
X-Gm-Message-State: APjAAAXp0GdMFGw2nPGB5Lbc+5QDsIzzK5inQFQ8QjW9mKICM+E68+Gq
        mo6P09oxZfBVHGOsR9Nk5gPu98a42hvhkQtc9Q==
X-Google-Smtp-Source: APXvYqyhgd+jsdRArXJvw6D32tKzSqjKQBZgbZChIL2jqDzeI+Y/s8akvQi/iCLrKxtM7fPi1z1aspYSSA8LyO3+ub0=
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr1800151qkm.393.1573494786072;
 Mon, 11 Nov 2019 09:53:06 -0800 (PST)
MIME-Version: 1.0
References: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
 <CGME20191028121748epcas5p3054c9583c14a2edde9f725d005895a04@epcas5p3.samsung.com>
 <1572264988-17455-2-git-send-email-anvesh.s@samsung.com> <20191105215332.GA19296@bogus>
 <20191106095340.GO9723@e119886-lin.cambridge.arm.com> <001601d595e4$17d8e470$478aad50$@samsung.com>
In-Reply-To: <001601d595e4$17d8e470$478aad50$@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Nov 2019 11:52:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tnpDvndosvvAhZN6NXsx6hfo7AVJz5amD5_wBTKz_uA@mail.gmail.com>
Message-ID: <CAL_Jsq+tnpDvndosvvAhZN6NXsx6hfo7AVJz5amD5_wBTKz_uA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: designware: Add binding for
 ZRX-DC PHY property
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anvesh Salveru <anvesh.s@samsung.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 7, 2019 at 9:25 PM Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Andrew Murray <andrew.murray@arm.com>
> > Sent: Wednesday, November 6, 2019 3:24 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: Anvesh Salveru <anvesh.s@samsung.com>; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > bhelgaas@google.com; gustavo.pimentel@synopsys.com;
> > jingoohan1@gmail.com; pankaj.dubey@samsung.com; Mark Rutland
> > <mark.rutland@arm.com>
> > Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: designware: Add binding for
> ZRX-
> > DC PHY property
> >
> > On Tue, Nov 05, 2019 at 03:53:32PM -0600, Rob Herring wrote:
> > > On Mon, Oct 28, 2019 at 05:46:27PM +0530, Anvesh Salveru wrote:
> > > > Add support for ZRX-DC compliant PHYs. If PHY is not compliant to
> > > > ZRX-DC specification, then after every 100ms link should transition
> > > > to recovery state during the low power states which increases power
> > consumption.
> > > >
> > > > Platforms with ZRX-DC compliant PHY can use "snps,phy-zrxdc-compliant"
> > > > property in DesignWare controller DT node.
> > > >
> > > > CC: Rob Herring <robh+dt@kernel.org>
> > > > CC: Mark Rutland <mark.rutland@arm.com>
> > > > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > > Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > ---
> > > > Change in v2: None
> > > >
> > > >  Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > > b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > > index 78494c4050f7..9507ac38ac89 100644
> > > > --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > > +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > > @@ -38,6 +38,8 @@ Optional properties:
> > > >     for data corruption. CDM registers include standard PCIe
> configuration
> > > >     space registers, Port Logic registers, DMA and iATU (internal
> Address
> > > >     Translation Unit) registers.
> > > > +- snps,phy-zrxdc-compliant: This property is needed if phy complies
> > > > +with the
> > > > +  ZRX-DC specification.
> > >
> > > If this is a property of the phy, then it belongs in the phy node or
> > > should just be implied by the phy's compatible.
> >
> Yes, from HW point of view this is a property of the PHY. As PHY is the one
> which is ZRXDC compliant or non-compliant.  But as the DW controller
> programming needs to be altered for handling such phys, so we added it as a
> DT binding of DW controller driver.

Bindings are for h/w blocks not drivers.

> We can't use PHY's compatible in case we want this to be in common code
> (pcie-designware.c), as PHY compatible for each of the platform would be
> different and PCIe DWC core file is not aware of this compatible. Of-course
> this can be handled in platform specific driver, but then in that case each
> of these drivers will add similar code to handle this.
>
> > As suggested in the previous revision of this series [1], this is
> absolutely a
> > property of the phy.
>
> Agreed, but as I tried to explain in series [1], this we are adding in
> controller driver, as controller driver needs to program it's register based
> on PHY HW property.
>
> >
> > > IOW, you should be able
> > > to support this or not without changing DTs.
> > >
> > > Is this spec Synopys specific? (About the only thing Google turns up
> > > are your patches.) If not, then probably shouldn't have a 'snps' prefix.
> >
> > This was also unfamiliar to me, however my current understanding is that
> Zrx-dc
> > describes the 'Receiver DC single ended impedance' limits, this is
> specified in the
> > PCI specification (table 'Common Receiver Parameters'), with a different
> limit
> > for each speed.
> >
> > I believe the purpose of this series is to to satisfy the following
> implementation
> > note in the spec "Ports that meet the Zrx-dc specification for 2.5 GT/s
> while in
> > the L1.Idle state are therefore not required to implement the 100 ms
> timeout
> > and transition to Recovery should avoid implementing it, since it will
> reduce the
> > power savings expected from the
> > L1 state".
> >
>
> > In other words, if it is known that the phy is compliant then an
> unnecessary
> > transition to a higher energy state can be avoided. Though it's the PCI
> controller
> > (in this case) that must action this and must find out about the phy it is
> > connected to.
> >
>
> Thanks, this is exactly the purpose of the patch. Currently this is being
> handled in respective platform's driver, this patch intends to move this in
> common code, where any platform driver using DesignWare controller can use
> it without repeating same piece of code.

Driver structure is not an argument for DT binding design.

> > So in my view 'phy-zrxdc-compliant' should be a property of a phy (without
> snps
> > prefix), and if a controller wants to determine if it is compliant then
> there must
> > be a phandle to the phy so the controller can find out.
>
>
> Removing snps prefix, I am OK with it. But for moving this property to PHY
> node, we need to find solution, how PCIe controller driver will access this
> property of PHY device.
>
> Platform driver which are using DesignWare controller driver has a phandle
> to PHY, but question is here how does DesignWare controller driver will
> infer this information from PHY driver. Some approaches which I can think of
> are:
> 1) If PHY framework has some generic API to check if a particular property
> exists in PHY node then it will be useful in such cases. Currently I don't
> see any such API exists. Though I am not sure if it is OK to add such API in
> PHY framework for such cases? Adding Kishon to comment on this.

It's always okay to change/extend kernel APIs. We don't work-around
kernel APIs in drivers nor in DT. (Maybe not agreement in how though)

IMO, this is what should happen. This solution makes enabling this
feature or not detached from DT. It could be a DT property, determined
by compatible of the phy, or just always enabled for a phy driver.
This is not the first time this issue has come up with the phy api
needing something like this (USB PHYs in particular).

> 2) Currently phandle to PHY is being stored as part of private data
> structure of platform specific controller driver, and DesignWare core driver
> can't access the phandle. So we need to move or keep copy of phandle pointer
> to DesignWare core driver structure instead of keeping it in platform
> specific private structure.

Or just parse it again...

Rob
