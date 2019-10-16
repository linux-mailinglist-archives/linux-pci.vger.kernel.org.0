Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4CFD94A2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 17:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbfJPPAI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 11:00:08 -0400
Received: from foss.arm.com ([217.140.110.172]:42296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388925AbfJPPAI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 11:00:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2DFF142F;
        Wed, 16 Oct 2019 08:00:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F29863F68E;
        Wed, 16 Oct 2019 08:00:06 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:00:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
Message-ID: <20191016150001.GA7457@e121166-lin.cambridge.arm.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809175741.7066-2-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Patches (1) and (3) are fine but I do not think this one is.

Firmware (DT) should provide dma-ranges according to what HW can handle,
more so given that other subsystems (eg IOMMU) rely on the dma-ranges
value to set-up eg DMA - if there is a mismatch between PCI host inbound
regions and software structures describing DMA'able ranges all bets are
off.

I would not merge this specific patch but let me know what you think.

Thanks,
Lorenzo

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
