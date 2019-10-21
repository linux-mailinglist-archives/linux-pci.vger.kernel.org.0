Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B2DF099
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfJUO4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 10:56:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14423 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfJUO4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 10:56:37 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191021145633epoutp011b57869215fa19da0f99778521e2b9d5~PsVmhFQYu2342923429epoutp017
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 14:56:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191021145633epoutp011b57869215fa19da0f99778521e2b9d5~PsVmhFQYu2342923429epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571669793;
        bh=+fwHAlORDs9KHULyJD+9+LZLSdj4VooLG0tQObW3l6M=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=h3JmjnZQvQkUPKky5bsLTnxRN/wyrsQKmoOYSZNVRCQGvymNh3bZQAxXOa+IyxYFg
         MMIZvo13slyeCcTUQDzRifGI9p/fzM1YxAz7bpeLw09KlPlKWPVTbKwOGbZ7uQcpFn
         1q+CXa0mnkJh/NhS9D9EfnxYA47v90ipBysZc53U=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191021145632epcas5p4d2fd737aa7b5f3b76f3ed7c4b6cef27e~PsVlWxQkP2081220812epcas5p4w;
        Mon, 21 Oct 2019 14:56:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.52.04647.027CDAD5; Mon, 21 Oct 2019 23:56:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191021145631epcas5p35e11280d6dfe45f86ed5cebd4993e6e0~PsVk050PV2106721067epcas5p3P;
        Mon, 21 Oct 2019 14:56:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191021145631epsmtrp16bae074059a39e386e3aa43eb2bb6263~PsVk0KlSf1793517935epsmtrp1Z;
        Mon, 21 Oct 2019 14:56:31 +0000 (GMT)
X-AuditID: b6c32a49-743ff70000001227-76-5dadc7202b3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.90.03889.F17CDAD5; Mon, 21 Oct 2019 23:56:31 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191021145630epsmtip13ca3f50e4302c59a5cb259141fb6d7bd~PsVjVAFXj3275232752epsmtip1O;
        Mon, 21 Oct 2019 14:56:29 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Andrew Murray'" <andrew.murray@arm.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <gustavo.pimentel@synopsys.com>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
In-Reply-To: <20191021141541.GS47056@e119886-lin.cambridge.arm.com>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: designware: Add binding for
 ZRX-DC PHY property
Date:   Mon, 21 Oct 2019 20:26:28 +0530
Message-ID: <05ba01d5881f$b98989a0$2c9c9ce0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRMLiuZPZOXyo/l4tw66QvoFQK5QJ9zQNRAnN1mOWmxkuucA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGuZ2ZzlApjgXksASxRhFUFgPJSFRQNKlrSHwjgDQyApGW2rL6
        xB6sIgS3UBZBNtk0kgqKEnCENCoUFZHECEpECaAvYlhUrAxTIm/fPef85/x/cilMxhGuVII6
        mdWqlYlysQRvf+bttcvT1Brlb56WMDmWDoIZ6KwmmNrseOZWr5lgOkcLSObOz1KSGeosFzMD
        lSYxUzfyWsTkdfWSoRJFS2ULUjwyjJKKqrYURVvTRbHiirEJKYzds0gx2+YRTkZI9sayiQmp
        rNZvf4wkvqo/m9CUuaS/5MxYJupx1CNbCuhAmLw7Q/Asox8jWCqW6pFkmX8gMGbliYTHHIJr
        mfPkquJz7k1caHQhaOY+koJ8BkGTxYNnMe0H5oXKlbWOdARUjz1YYYweR9D4xIdnWzoMLGOV
        Ip4d6Egw/unDecbprfDe2IrpEUVJ6T3QNRvMl6X0BnheOoELazZBx/dyTPDjCYtf6q2nDkLh
        4JxYmHGGqb5ekvcJdBG5bG3cKjgEN/SfxAI7wLTJaA3mClNF+VZOgoWaEkwQ5yK4aqoghEYI
        9Lwtx3lzGO0N9zr9hGP2UPh7QsSXgZZCQb5MmN4G85P91rPuMJ5TJxJYARWGYbwYbTasiWZY
        E82wJoLh/7EqhDchF1ajU8WxuiBNgJpN89UpVboUdZzvmSRVG1r5WT5HHiKD+TiHaArJ7aSa
        261RMkKZqstQcQgoTO4o/eC/XJLGKjMusNqk09qURFbHITcKlztLS4jhSBkdp0xmz7GshtWu
        dkWUrWsmag8s9FUHE1/HyjYelltk3fez+6O73wztOJpnS3k2b29J58IskBO32+1y9KSqYUrC
        Xtpp7879zQ8vO1sftP6dnYZLK3hhs++XNqpjojEm8vq6SCeHk6EjC/MhLZmL6qxJWcMr+pDX
        +ehvo/rB2qcNJ7glh1M1chuvA6nHOKctpnA5rotXBvhgWp3yH/wdlkdVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSnK788bWxBksfK1o0/9/OanF210JW
        iyVNGRbzj5xjtdh1t4PdYsWXmewWl3fNYbM4O+84m8XS6xeZLFr3HmF34PJYM28No8fOWXfZ
        PRZsKvXYtKqTzaNvyypGjy37PzN6fN4kF8AexWWTkpqTWZZapG+XwJWx4EwTa8FsyYrTh84x
        NzAeEOli5OSQEDCReNwynQXEFhLYzSjx+6IVRFxGYvLqFawQtrDEyn/P2bsYuYBqXjJKrJi2
        lAkkwSagL3HuxzywIhGBKIm/n2+wgBQxgxRNmrWSBaLjLKPE9n13wFZwCjhL/L83D6xbGKjj
        5pOrYHEWAVWJW1vWMncxcnDwClhK7P0MdgWvgKDEyZlPWEDCzAJ6Em0bGUHCzALyEtvfzmGG
        OE5B4ufTZVA3OEn0nv/GBlEjLvHy6BH2CYzCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnlts
        WGCUl1quV5yYW1yal66XnJ+7iREceVpaOxhPnIg/xCjAwajEw3tiydpYIdbEsuLK3EOMEhzM
        SiK8dwyAQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhhD
        FkctbLhsWmxVuD0iRKHGwS3WRfDFBPs/Cq9sg67JLp++8c2Mls5kbq82262rQ/ZM4aps0jtf
        cclpbnht3JI5csfurlp4Vqoo3UGewTRXfk1bstS1WTwx+6K0uOJ81vnzOVX//i97ZNmizMrO
        eR/KzTep8EYfOcax8eUVh7UJVl+8xb/+/aTEUpyRaKjFXFScCAAFamPGuAIAAA==
X-CMS-MailID: 20191021145631epcas5p35e11280d6dfe45f86ed5cebd4993e6e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191021122630epcas5p32bd92762c4304035cad5c1822d96e304
References: <CGME20191021122630epcas5p32bd92762c4304035cad5c1822d96e304@epcas5p3.samsung.com>
        <1571660755-30270-1-git-send-email-anvesh.s@samsung.com>
        <20191021141541.GS47056@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Andrew Murray <andrew.murray@arm.com>
> Sent: Monday, October 21, 2019 7:46 PM
> To: Anvesh Salveru <anvesh.s@samsung.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; bhelgaas@google.com;
> gustavo.pimentel@synopsys.com; jingoohan1@gmail.com; robh+dt@kernel.org;
> mark.rutland@arm.com; Pankaj Dubey <pankaj.dubey@samsung.com>
> Subject: Re: [PATCH 1/2] dt-bindings: PCI: designware: Add binding for
ZRX-DC
> PHY property
> 
> On Mon, Oct 21, 2019 at 05:55:55PM +0530, Anvesh Salveru wrote:
> > Add support for ZRX-DC compliant PHYs. If PHY is not compliant to
> > ZRX-DC specification, then after every 100ms link should transition to
> > recovery state during the low power states which increases power
> consumption.
> >
> > Platforms with ZRX-DC compliant PHY can use "snps,phy-zrxdc-compliant"
> > property in DesignWare controller DT node.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> >  Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > index 78494c4050f7..9507ac38ac89 100644
> > --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > @@ -38,6 +38,8 @@ Optional properties:
> >     for data corruption. CDM registers include standard PCIe
configuration
> >     space registers, Port Logic registers, DMA and iATU (internal
Address
> >     Translation Unit) registers.
> > +- snps,phy-zrxdc-compliant: This property is needed if phy complies
> > +with the
> 
> Strictly speaking, this is a property of the phy - not the controller that
uses it.
> 
> If I understand correctly, there are some DW based PCI controllers that
use a
> phandle reference in DT to a Phy (such as fsl,imx6q-pcie.txt). Therefore
it feels
> like this is in the wrong place. Is there a reason this isn't described in
the Phy?
>

Yes, from HW point of view this is a property of the PHY. As PHY is the one
which is ZRXDC compliant or non-compliant. 
But as the DW controller programming needs to be altered for handling such
phys, so we added it as a DT binding of DW controller driver. 
Also it might be possible that, some other PCIe controller (other than
DesignWare), do not have any such provision in controller H/W and they
expect PHY itself should expose some SFR to handle such scenario. In such
cases it is straight-forward to add this binding as part of PHY node.

We can add this as part of PHY binding, but in that case we will end up
checking PHY binding in DWC driver via PHY nodes which seems little a bit of
hack. 

Do you have any other better approach to handle this? 
 
> Thanks,
> 
> Andrew Murray
> 
> > +  ZRX-DC specification.
> >  RC mode:
> >  - num-viewport: number of view ports configured in hardware. If a
platform
> >    does not specify it, the driver assumes 2.
> > --
> > 2.17.1
> >

