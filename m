Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3346447
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfFNQeL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 12:34:11 -0400
Received: from foss.arm.com ([217.140.110.172]:37610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfFNQeL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 12:34:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5583C28;
        Fri, 14 Jun 2019 09:34:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9C173F694;
        Fri, 14 Jun 2019 09:34:08 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:33:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Simon Horman <horms@verge.net.au>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a774a1
Message-ID: <20190614163351.GA30511@e121166-lin.cambridge.arm.com>
References: <1559891016-56157-1-git-send-email-biju.das@bp.renesas.com>
 <20190612114629.wpazihf5ea3g4wjn@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612114629.wpazihf5ea3g4wjn@verge.net.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 01:46:29PM +0200, Simon Horman wrote:
> On Fri, Jun 07, 2019 at 08:03:36AM +0100, Biju Das wrote:
> > Add PCIe support for the RZ/G2M (a.k.a. R8A774A1).
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Should I pick this up and send it via the PCI tree ?

Just let me know please, thanks.

Lorenzo

> > ---
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > index 6904882..45bba9f 100644
> > --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > @@ -3,6 +3,7 @@
> >  Required properties:
> >  compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> >  	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
> > +	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
> >  	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
> >  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
> >  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> > -- 
> > 2.7.4
> > 
