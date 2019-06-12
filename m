Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7565424A2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfFLLqe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 07:46:34 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:38080 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFLLqd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 07:46:33 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D075525AEA9;
        Wed, 12 Jun 2019 21:46:31 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id A60F0E21AAA; Wed, 12 Jun 2019 13:46:29 +0200 (CEST)
Date:   Wed, 12 Jun 2019 13:46:29 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a774a1
Message-ID: <20190612114629.wpazihf5ea3g4wjn@verge.net.au>
References: <1559891016-56157-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559891016-56157-1-git-send-email-biju.das@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 07, 2019 at 08:03:36AM +0100, Biju Das wrote:
> Add PCIe support for the RZ/G2M (a.k.a. R8A774A1).
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 6904882..45bba9f 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>  compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a7744" for the R8A7744 SoC;
> +	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
>  	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
>  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
> -- 
> 2.7.4
> 
