Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D502B90FA
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 12:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgKSL1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 06:27:14 -0500
Received: from foss.arm.com ([217.140.110.172]:53852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgKSL1N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 06:27:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 728C01396;
        Thu, 19 Nov 2020 03:27:12 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7E683F718;
        Thu, 19 Nov 2020 03:27:10 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:27:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [RESEND PATCH] dt-bindings: pci: rcar-pci: Add device tree
 support for r8a774e1
Message-ID: <20201119112708.GB19942@e121166-lin.cambridge.arm.com>
References: <20200927124257.29612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927124257.29612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 27, 2020 at 01:42:57PM +0100, Lad Prabhakar wrote:
> Add PCIe support for the RZ/G2H (a.k.a. R8A774E1).
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> Hi Lorenzo,
> 
> This patch is part of series [1] and is Acked the DT maintainers,
> while rest of the patches have been picked up by the respective
> maintainers, could you please pick this patch.

I can, is this still pending (I think so but wanted to check) ?

Thanks,
Lorenzo

> 
> [1] https://www.spinics.net/lists/dmaengine/msg22971.html
> 
> Cheers,
> Prabhakar
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 14d307deff06..8e495d6811a0 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -7,6 +7,7 @@ compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
>  	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
>  	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
>  	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
> +	    "renesas,pcie-r8a774e1" for the R8A774E1 SoC;
>  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
>  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
> -- 
> 2.17.1
> 
