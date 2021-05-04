Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A34372A04
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhEDMZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 08:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEDMZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 08:25:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54735613B4;
        Tue,  4 May 2021 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620131064;
        bh=vArYzEMEwRqDbMRFkfiHNa4Cgeb/07wrYgojfXEM6ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8ApvRPhpj1ghZ3GYlONwF21yByVn6tOlm5gExHU9CgVbE38i4gVlkktgw2fcqEBT
         2BI1Kc+8aoqMzhiK+LgMM/mkS/TOu4WchUA47NAZFl56Od8RreTRfQOpguR2XoJgc2
         0ojolL9ZtF/h6+OfVzabe/ChOlHh35FJ8K09aqkFtpcDgj6RQm88Axlyp5z1fqHelY
         S7CNTilkyJ2Cgs79Vz8LRogTJt2ixK1EkztsdanK089ZE6wdtQB/Kj5eplasCOxeGc
         y7osxn+gPLsTO5KkTVn073nXPICN6pUipqsNZOOte8gfA4ULES81Kz9N2FB/7R1JP/
         bHMrKkSRsKxBw==
Date:   Tue, 4 May 2021 15:24:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, robh+dt@kernel.org,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: Re: [PATCH v6 1/6] clk: sifive: Add pcie_aux clock in prci driver
 for PCIe driver
Message-ID: <YJE886bhppqes5LQ@unreal>
References: <20210504105940.100004-1-greentime.hu@sifive.com>
 <20210504105940.100004-2-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504105940.100004-2-greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 04, 2021 at 06:59:35PM +0800, Greentime Hu wrote:
> We add pcie_aux clock in this patch so that pcie driver can use
> clk_prepare_enable() and clk_disable_unprepare() to enable and disable
> pcie_aux clock.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/sifive/fu740-prci.c               | 11 +++++
>  drivers/clk/sifive/fu740-prci.h               |  2 +-
>  drivers/clk/sifive/sifive-prci.c              | 41 +++++++++++++++++++
>  drivers/clk/sifive/sifive-prci.h              |  9 ++++
>  include/dt-bindings/clock/sifive-fu740-prci.h |  1 +
>  5 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
> index 764d1097aa51..53f6e00a03b9 100644
> --- a/drivers/clk/sifive/fu740-prci.c
> +++ b/drivers/clk/sifive/fu740-prci.c
> @@ -72,6 +72,12 @@ static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
>  	.recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,

<...>

> +/* PCIE AUX clock APIs for enable, disable. */
> +int sifive_prci_pcie_aux_clock_is_enabled(struct clk_hw *hw)

It should be bool

> +{
> +	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
> +	struct __prci_data *pd = pc->pd;
> +	u32 r;
> +
> +	r = __prci_readl(pd, PRCI_PCIE_AUX_OFFSET);
> +
> +	if (r & PRCI_PCIE_AUX_EN_MASK)
> +		return 1;
> +	else
> +		return 0;
> +}

and here simple "return r & PRCI_PCIE_AUX_EN_MASK;"

> +
> +int sifive_prci_pcie_aux_clock_enable(struct clk_hw *hw)
> +{
> +	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
> +	struct __prci_data *pd = pc->pd;
> +	u32 r __maybe_unused;
> +
> +	if (sifive_prci_pcie_aux_clock_is_enabled(hw))
> +		return 0;

You actually call to this new function only once, put your
__prci_readl() here.

Thanks
