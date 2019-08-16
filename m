Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33957902D6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfHPNXK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 09:23:10 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:54828 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfHPNXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 09:23:10 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 37AC125BDF3;
        Fri, 16 Aug 2019 23:23:08 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 2F72094057D; Fri, 16 Aug 2019 15:23:06 +0200 (CEST)
Date:   Fri, 16 Aug 2019 15:23:06 +0200
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20190816132305.gyyml5r3xsimmoor@verge.net.au>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809175741.7066-2-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 07:57:40PM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> In case the "dma-ranges" DT property contains either too many ranges
> or the range start address is unaligned in such a way that populating
> the range into the controller requires multiple entries, a situation
> may occur where all ranges cannot be loaded into the controller.
> 
> Currently, the driver refuses to probe in such a situation. Relax this
> behavior, load as many ranges as possible and warn if some ranges do
> not fit anymore.

What is the motivation for relaxing this?

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
> V2: Update on top of 1/3
> V3: No change
> ---
>  drivers/pci/controller/pcie-rcar.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 56a6433eb70b..e2735005ffd3 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1049,8 +1049,9 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
>  
>  	while (cpu_addr < cpu_end) {
>  		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
> -			dev_err(pcie->dev, "Failed to map inbound regions!\n");
> -			return -EINVAL;
> +			dev_warn(pcie->dev,
> +				 "Too many inbound regions, not all are mapped.\n");
> +			break;
>  		}
>  		/*
>  		 * Set up 64-bit inbound regions as the range parser doesn't
> -- 
> 2.20.1
> 
