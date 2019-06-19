Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7CC4B758
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFSLsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 07:48:19 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:56604 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSLsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 07:48:19 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id BA2ED25AF1B;
        Wed, 19 Jun 2019 21:48:16 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 595189409FF; Wed, 19 Jun 2019 13:48:13 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:48:13 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a774a1
Message-ID: <20190619114812.lwytuojd5ijonxfa@verge.net.au>
References: <1559891016-56157-1-git-send-email-biju.das@bp.renesas.com>
 <20190612114629.wpazihf5ea3g4wjn@verge.net.au>
 <20190614163351.GA30511@e121166-lin.cambridge.arm.com>
 <OSBPR01MB2103F1D063171E45B4E5034DB8EA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2103F1D063171E45B4E5034DB8EA0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 10:38:21AM +0000, Biju Das wrote:
> Hello Lorenzo and Simon,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
> > r8a774a1
> > 
> > On Wed, Jun 12, 2019 at 01:46:29PM +0200, Simon Horman wrote:
> > > On Fri, Jun 07, 2019 at 08:03:36AM +0100, Biju Das wrote:
> > > > Add PCIe support for the RZ/G2M (a.k.a. R8A774A1).
> > > >
> > > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > >
> > > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Should I pick this up and send it via the PCI tree ?
> > 
> > Just let me know please, thanks.
> 
> Simon, 
> What do you think ?

Hi Lorenzo, Hi Biju,

yes, I think that is a good idea.

Please feel free to push this via the PCI tree.

In case it helps:

Acked-by: Simon Horman <horms+renesas@verge.net.au>


> 
> Regards,
> Biju
> 
> > 
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > > index 6904882..45bba9f 100644
> > > > --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > > @@ -3,6 +3,7 @@
> > > >  Required properties:
> > > >  compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> > > >  	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
> > > > +	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
> > > >  	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
> > > >  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
> > > >  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> > > > --
> > > > 2.7.4
> > > >
> 
