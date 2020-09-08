Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF58261CBD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 21:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgIHT0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 15:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731078AbgIHT0C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 15:26:02 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640ED2078B;
        Tue,  8 Sep 2020 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599593161;
        bh=sO+Tj0duwUDkoW+83FhiYts6y7HE4PLCeZkRI0UUxhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FhRwCaKdOvGy86sPth451RLscvLjEu3nD2QES2+AS+eon1AhulfGLhuMlrQ3QlkZe
         QTeBLHXk2T4z0rqp0ROh1MJNv06lomI05Q4YYRblp8Fu4tEWbkeJ2auGlGjyrDlutp
         DW04uNdlDFGX3wnBU7rBUrhuEOLZI3cbsUIOkWLA=
Date:   Tue, 8 Sep 2020 14:26:00 -0500
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
Message-ID: <20200908192600.GA615209@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904103851.3946-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 11:38:49AM +0100, Lad Prabhakar wrote:
> Document the support for R-Car PCIe EP on R8A774E1 SoC device.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> index 70c45f72ab20..a059c96c294b 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -18,6 +18,7 @@ properties:
>            - renesas,r8a774a1-pcie-ep     # RZ/G2M
>            - renesas,r8a774b1-pcie-ep     # RZ/G2N
>            - renesas,r8a774c0-pcie-ep     # RZ/G2E
> +          - renesas,r8a774e1-pcie-ep     # RZ/G2H

This is on Lorenzo's pci/rcar branch and headed to -next.

There's a similar older commit on that branch, 2de82ec86674
("dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1") that
came with a companion that added device IDs to pci_endpoint_test.c:
cfb824ddd1c0 ("misc: pci_endpoint_test: Add Device ID for RZ/G2M and
RZ/G2N PCIe controllers").

Is there, or should there be a similar device ID patch for
renesas,r8a774e1-pcie-ep?

>        - const: renesas,rcar-gen3-pcie-ep # R-Car Gen3 and RZ/G2
>  
>    reg:
> -- 
> 2.17.1
> 
