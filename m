Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419D61C1A26
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgEAPyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 11:54:44 -0400
Received: from foss.arm.com ([217.140.110.172]:43118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAPyo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 11:54:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C65430E;
        Fri,  1 May 2020 08:54:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E9FD3F68F;
        Fri,  1 May 2020 08:54:42 -0700 (PDT)
Date:   Fri, 1 May 2020 16:54:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: rcar: add r8a77961 support
Message-ID: <20200501155440.GE7398@e121166-lin.cambridge.arm.com>
References: <1586511020-31833-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586511020-31833-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 06:30:20PM +0900, Yoshihiro Shimoda wrote:
> Add support for r8a77961 (R-Car M3-W+).
> 
> To avoid confusion between R-Car M3-W (R8A77960) and R-Car M3-W+
> (R8A77961), this patch also updates the comment of
> "renesas,pcie-r8a7796".
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to pci/rcar, thanks.

Lorenzo

> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 12702c8..1041c44a 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -11,7 +11,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
>  	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
>  	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
> -	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
> +	    "renesas,pcie-r8a7796" for the R8A77960 SoC;
> +	    "renesas,pcie-r8a77961" for the R8A77961 SoC;
>  	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
>  	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
>  	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
> -- 
> 2.7.4
> 
