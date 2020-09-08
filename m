Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E619B261CDF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 21:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgIHT1w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 15:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbgIHT1o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 15:27:44 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 536B52078B;
        Tue,  8 Sep 2020 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599593263;
        bh=P32hrheM3XHI3hTzptMJ7G2yosA8KkleDbFzT5mxRX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ESpLf9qQ48q6G0oYZK0DDSxnAToFh8X+OLSi3TXK319kaqsGFStN2BElD1KojPhuh
         POzL3Ry4hoAitBnLT11VgU8pHxTX/BzCj+72EVjRXki4Tfci2NuCXMjEE1Tyj4vDkV
         ZQTXd1Ouvmsamzfw0DAWvM0OfoUOX0K4yATha7XA=
Date:   Tue, 8 Sep 2020 14:27:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: rcar-pci-ep: Document r8a774e1
Message-ID: <20200908192742.GA615450@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908192600.GA615209@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 08, 2020 at 02:26:01PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 04, 2020 at 11:38:49AM +0100, Lad Prabhakar wrote:
> > Document the support for R-Car PCIe EP on R8A774E1 SoC device.
> > 
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> > index 70c45f72ab20..a059c96c294b 100644
> > --- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> > @@ -18,6 +18,7 @@ properties:
> >            - renesas,r8a774a1-pcie-ep     # RZ/G2M
> >            - renesas,r8a774b1-pcie-ep     # RZ/G2N
> >            - renesas,r8a774c0-pcie-ep     # RZ/G2E
> > +          - renesas,r8a774e1-pcie-ep     # RZ/G2H
> 
> This is on Lorenzo's pci/rcar branch and headed to -next.
> 
> There's a similar older commit on that branch, 2de82ec86674
> ("dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1") that
> came with a companion that added device IDs to pci_endpoint_test.c:
> cfb824ddd1c0 ("misc: pci_endpoint_test: Add Device ID for RZ/G2M and
> RZ/G2N PCIe controllers").
> 
> Is there, or should there be a similar device ID patch for
> renesas,r8a774e1-pcie-ep?

Sheesh, sorry, could have saved all of us a little time if I'd
scrolled up to see the next patch, a63c5f3db07d ("misc:
pci_endpoint_test: Add Device ID for RZ/G2H PCIe controller") 
