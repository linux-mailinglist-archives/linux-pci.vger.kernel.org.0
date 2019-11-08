Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B544F3E5C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 04:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfKHDZA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 22:25:00 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:15351 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfKHDZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 22:25:00 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191108032457epoutp03e0f6f92eb3d6d34401a9c0f98a8c381d~VEg5PNPUD1526115261epoutp03h
        for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2019 03:24:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191108032457epoutp03e0f6f92eb3d6d34401a9c0f98a8c381d~VEg5PNPUD1526115261epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573183497;
        bh=avcypUAnpCI6Psa4aWP4Hr0up9UCkFGxgp69nmi97vQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=tA15s+EheljpVM+FCMVmEFmVKVci6BoXwvqJNZ2brXz578berNGnbIRfLWg93pb6z
         lOotYLVstOss803KtUDPdO08BHc6KxLzbvMnSM4rzxEMx/ge6JfpVTkjEeNSLQljqA
         VthiHVeGVRVeiagqP1RdLk1jVpLYjXBPJQx2DZ0Q=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191108032456epcas5p2eac61e73aa800eb3ab5d86a4c8376849~VEg4t9ZoC0856608566epcas5p2C;
        Fri,  8 Nov 2019 03:24:56 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.4E.20293.800E4CD5; Fri,  8 Nov 2019 12:24:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191108032456epcas5p345dd5896ae5f1c80618e68adadae56e5~VEg4VHn8J2403424034epcas5p3Z;
        Fri,  8 Nov 2019 03:24:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191108032456epsmtrp1a2112a3b0e5ee351e56e7d10630c807e~VEg4UOqgB1128611286epsmtrp1b;
        Fri,  8 Nov 2019 03:24:56 +0000 (GMT)
X-AuditID: b6c32a49-ffbff70000014f45-c5-5dc4e0089897
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.07.25663.800E4CD5; Fri,  8 Nov 2019 12:24:56 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191108032454epsmtip21762285d895199d9f28c8004fe3140a9~VEg2nYSp60356403564epsmtip2D;
        Fri,  8 Nov 2019 03:24:54 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Andrew Murray'" <andrew.murray@arm.com>,
        "'Rob Herring'" <robh@kernel.org>, <kishon@ti.com>
Cc:     "'Anvesh Salveru'" <anvesh.s@samsung.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <gustavo.pimentel@synopsys.com>, <jingoohan1@gmail.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>
In-Reply-To: <20191106095340.GO9723@e119886-lin.cambridge.arm.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: designware: Add binding for
 ZRX-DC PHY property
Date:   Fri, 8 Nov 2019 08:54:53 +0530
Message-ID: <001601d595e4$17d8e470$478aad50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFcSt4EB3+Q9Aj/V+pNnFXbxKeLIQH/YaH4AmF60YIB5E6AIwHHR6CyqDLHRPA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH932ee+6eo+NxbD4k5WotGmKpp62lSfO0qTV/9ENMF88wjtsd
        ijYZQqditMZNR8qP7Mx2yelSJLpjGFGoyY+YUWphpdLU3aPlv9fn83l/fry3D4mLewhnMjYh
        iVUkSOMlfCte0wt3d09yoiN8j2l1P521pifoXsNdgr6fGUOXd/QRtGEsT0DXLpcK6P6Z63x6
        0FDGp3s1Rj5dNTyA0WstzYLD1oxWo0XMY/WYgKnQJTO6umt85mZjHWIaW5cQYxzRY8ySzvUk
        GWp1MIqNj01hFd6HzlvFlJWqkHzc91KbaRzLQCO7VIgkgdoLg1pMhaxIMfUEQX/uT8QFiwie
        5b8nuOAbgrHifIEKCS0dRavlyMxi6imC7AVbTvQRwdXWZUuBT3lD34qGMLMDFQmVXW8sY3Eq
        F4PnNWsWkZAKAO18N25meyoCGjILLXketQOmln/zzCyiDoBhdhjn2A66SqcteZzaCvqFMpy7
        aBv8mKkmzH4cqBPQUHeakzjCXGeHwLwXKI0ARnvnMc5zINQ3Heda7WHe2LhuzBnmCnLWORFW
        7hXhXG82gmLjHYIr+EPbUBnPPAen3KHB4M3tsoEbv6bXx4sgL0fMqXfC99me9StdYDKrCuOY
        gbEqFa8Quak3GFNvMKbe4ED9f1kF4tUhJ1aulEWzSj+5TwJ70UsplSmTE6K9IhNlOmT5MY9j
        zUjdF9yOKBJJNonOunSEiwlpijJV1o6AxCUOImH235QoSpqaxioSIxTJ8ayyHW0meRJHURHx
        OkxMRUuT2DiWlbOKf1WMFDpnoM53rG2IwkGoD3G95dcWap3UVqMt2D0t+qzDfZ1LtKNblp2G
        Kr2r9MxAVIuv/0J6nEj2NmsCSz8zGfSp2qbllfFofcVlgVtgWFdn0AdjpJ3nA1n+S1Pp4r61
        Lw9LQo/kBUyFKm53Bw/3q0/ZXvH6+uhcnl5/YUYea0raXmtaStNKeMoYqY8HrlBK/wC/d/r+
        XwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvC7HgyOxBjNbJSya/29ntTi7ayGr
        xZKmDIv5R86xWuy628FuseLLTHaLC0972Cwu75rDZnF23nE2i6XXLzJZ/N+zg92B22PNvDWM
        Hjtn3WX3WLCp1GPTqk42j74tqxg9tuz/zOhx/MZ2Jo/Pm+QCOKK4bFJSczLLUov07RK4MubM
        7GIsuG9UceDEfaYGxhsaXYycHBICJhKT/sxn7GLk4hAS2M0o8XHOOzaIhIzE5NUrWCFsYYmV
        /56zg9hCAi8ZJXYeswCx2QT0Jc79mAdUw8EhIpAqsfuBEkiYWaCfSeLGUz6ImUuYJE4tfgDW
        yyngJLHm1SlmkHphgViJGTsFQcIsAioSj778ZQGxeQUsJXY9v84MYQtKnJz5hAWknFlAT6Jt
        IyPEeHmJ7W/nMENcpiDx8+kyqAv8JNavCocoEZd4efQI+wRG4VlIBs1CGDQLyaBZSDoWMLKs
        YpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjkMtrR2MJ07EH2IU4GBU4uGNkDkSK8Sa
        WFZcmXuIUYKDWUmEl7MFKMSbklhZlVqUH19UmpNafIhRmoNFSZxXPv9YpJBAemJJanZqakFq
        EUyWiYNTqoGxl0mhfZrh7qJVjW+W6RavvT73qbuNMVeKy93pN28qBLTkuDWK/cvfsu3y8jiJ
        V2mZjD77fXJcFi+umG1adS0k66f2IgWnC1VS2yceTHOewZ/9aYPQmex/kZW/Bavzs/3m26bZ
        Xp2/6rCkcvic+XKmdtYJEVdTPs90bm/WDVDN6L365X97XoESS3FGoqEWc1FxIgB6nLzbvwIA
        AA==
X-CMS-MailID: 20191108032456epcas5p345dd5896ae5f1c80618e68adadae56e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191028121748epcas5p3054c9583c14a2edde9f725d005895a04
References: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191028121748epcas5p3054c9583c14a2edde9f725d005895a04@epcas5p3.samsung.com>
        <1572264988-17455-2-git-send-email-anvesh.s@samsung.com>
        <20191105215332.GA19296@bogus>
        <20191106095340.GO9723@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Andrew Murray <andrew.murray@arm.com>
> Sent: Wednesday, November 6, 2019 3:24 PM
> To: Rob Herring <robh@kernel.org>
> Cc: Anvesh Salveru <anvesh.s@samsung.com>; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; gustavo.pimentel@synopsys.com;
> jingoohan1@gmail.com; pankaj.dubey@samsung.com; Mark Rutland
> <mark.rutland@arm.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: designware: Add binding for
ZRX-
> DC PHY property
> 
> On Tue, Nov 05, 2019 at 03:53:32PM -0600, Rob Herring wrote:
> > On Mon, Oct 28, 2019 at 05:46:27PM +0530, Anvesh Salveru wrote:
> > > Add support for ZRX-DC compliant PHYs. If PHY is not compliant to
> > > ZRX-DC specification, then after every 100ms link should transition
> > > to recovery state during the low power states which increases power
> consumption.
> > >
> > > Platforms with ZRX-DC compliant PHY can use "snps,phy-zrxdc-compliant"
> > > property in DesignWare controller DT node.
> > >
> > > CC: Rob Herring <robh+dt@kernel.org>
> > > CC: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > > Change in v2: None
> > >
> > >  Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > index 78494c4050f7..9507ac38ac89 100644
> > > --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > > @@ -38,6 +38,8 @@ Optional properties:
> > >     for data corruption. CDM registers include standard PCIe
configuration
> > >     space registers, Port Logic registers, DMA and iATU (internal
Address
> > >     Translation Unit) registers.
> > > +- snps,phy-zrxdc-compliant: This property is needed if phy complies
> > > +with the
> > > +  ZRX-DC specification.
> >
> > If this is a property of the phy, then it belongs in the phy node or
> > should just be implied by the phy's compatible.
> 
Yes, from HW point of view this is a property of the PHY. As PHY is the one
which is ZRXDC compliant or non-compliant.  But as the DW controller
programming needs to be altered for handling such phys, so we added it as a
DT binding of DW controller driver.

We can't use PHY's compatible in case we want this to be in common code
(pcie-designware.c), as PHY compatible for each of the platform would be
different and PCIe DWC core file is not aware of this compatible. Of-course
this can be handled in platform specific driver, but then in that case each
of these drivers will add similar code to handle this.

> As suggested in the previous revision of this series [1], this is
absolutely a
> property of the phy.

Agreed, but as I tried to explain in series [1], this we are adding in
controller driver, as controller driver needs to program it's register based
on PHY HW property. 

> 
> > IOW, you should be able
> > to support this or not without changing DTs.
> >
> > Is this spec Synopys specific? (About the only thing Google turns up
> > are your patches.) If not, then probably shouldn't have a 'snps' prefix.
> 
> This was also unfamiliar to me, however my current understanding is that
Zrx-dc
> describes the 'Receiver DC single ended impedance' limits, this is
specified in the
> PCI specification (table 'Common Receiver Parameters'), with a different
limit
> for each speed.
> 
> I believe the purpose of this series is to to satisfy the following
implementation
> note in the spec "Ports that meet the Zrx-dc specification for 2.5 GT/s
while in
> the L1.Idle state are therefore not required to implement the 100 ms
timeout
> and transition to Recovery should avoid implementing it, since it will
reduce the
> power savings expected from the
> L1 state".
>

> In other words, if it is known that the phy is compliant then an
unnecessary
> transition to a higher energy state can be avoided. Though it's the PCI
controller
> (in this case) that must action this and must find out about the phy it is
> connected to.
>

Thanks, this is exactly the purpose of the patch. Currently this is being
handled in respective platform's driver, this patch intends to move this in
common code, where any platform driver using DesignWare controller can use
it without repeating same piece of code.
 
> So in my view 'phy-zrxdc-compliant' should be a property of a phy (without
snps
> prefix), and if a controller wants to determine if it is compliant then
there must
> be a phandle to the phy so the controller can find out.


Removing snps prefix, I am OK with it. But for moving this property to PHY
node, we need to find solution, how PCIe controller driver will access this
property of PHY device.
 
Platform driver which are using DesignWare controller driver has a phandle
to PHY, but question is here how does DesignWare controller driver will
infer this information from PHY driver. Some approaches which I can think of
are:
1) If PHY framework has some generic API to check if a particular property
exists in PHY node then it will be useful in such cases. Currently I don't
see any such API exists. Though I am not sure if it is OK to add such API in
PHY framework for such cases? Adding Kishon to comment on this.
2) Currently phandle to PHY is being stored as part of private data
structure of platform specific controller driver, and DesignWare core driver
can't access the phandle. So we need to move or keep copy of phandle pointer
to DesignWare core driver structure instead of keeping it in platform
specific private structure. 

I am open to any suggestion which can help us in keeping common piece of
code in DesignWare controller driver than repeating same in each and every
platform driver using DWC controller.


Thanks,
Pankaj Dubey

> 
> [1] https://patchwork.kernel.org/patch/11202121/
> 
> Thanks,
> 
> Andrew Murray
> 
> >
> > >  RC mode:
> > >  - num-viewport: number of view ports configured in hardware. If a
platform
> > >    does not specify it, the driver assumes 2.
> > > --
> > > 2.17.1
> > >

