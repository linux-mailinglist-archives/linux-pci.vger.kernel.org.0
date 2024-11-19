Return-Path: <linux-pci+bounces-17086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278DE9D2CD8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1D12831B8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484671D1300;
	Tue, 19 Nov 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3XwbMrW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232761D12EA
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038234; cv=none; b=PWBLK9tG81GkKltOCeBBgWbl5xDmCwglL6FBMSi1xXq5rgxgx6Pwe/CyQjlYIFzV8jhBdMl5jK05Kl7z02WeMZpvWwdgPrmUgen/LVxsahFJeEPzp4GsNoxG7q53DNDHetQpzNonr+qZ+OVaLEa3Edc3muQsHZjFrEX5z3UZht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038234; c=relaxed/simple;
	bh=DfqCGNefCcKmP6DPPWDli0AleKCJ/UH5pUDeWYvOCU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cdw6hUt9nyy6xFJTJ1un5+JIOC2SoBvwIY8bfHUnWfCjYPpzO7X9zkiXh02nf7zDs8PJkmHqZRww3m8coCuOXe/PD0cG/w+cBQDZ/BQU4oDZgynMZm+h7b/4v6q41ViP5ba+XsK23hLLqEBTWWxc7vjCd/28JbvQvRo+nbcconc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3XwbMrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7E3C4CECF;
	Tue, 19 Nov 2024 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038233;
	bh=DfqCGNefCcKmP6DPPWDli0AleKCJ/UH5pUDeWYvOCU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q3XwbMrWKLIBZkrrWAhuCIyZYPIqgRBVVzGZwOeWGcf9RjiG/R+oMyT4RY/17sem3
	 /dkAIPreUYkERepr+D9OZ+PlniGxBnhcXfJ2dMHVVKMR3EvVGCYsSNUqciKoLDR6c7
	 WUOv4nhKYijmdATwZas5eejTBdDVEPKiFwkAq+BfVqD+jQ5J62Ro1Lt/R1KYqcqOVw
	 8GwkREL9vYX+8Zt2kLp5lYhARdrb21j/T3Ce5lO1IS3menJv/I3upwGOmW1DjYcqdl
	 l3uUPyLdJZdaXlg4Pnq8LhULpFXqFgo17R9K392y11NBYX7yOJL988Z68n+V7fku6K
	 roJl6CkXRB/CQ==
Date: Tue, 19 Nov 2024 11:43:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <20241119174350.GA2269929@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzxJMbWkV1OELEID@lore-desk>

On Tue, Nov 19, 2024 at 09:15:45AM +0100, Lorenzo Bianconi wrote:
> > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > causing occasional PCIe link down issues. In order to overcome the
> > problem, PCIE_RSTB signals are not asserted/released during device probe or
> > suspend/resume phase and the PCIe block is reset using REG_PCI_CONTROL
> > (0x88) and REG_RESET_CONTROL (0x834) registers available in the clock
> > module running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
> > 
> > Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> > specify per-SoC capabilities.
> > 
> > Tested-by: Hui Ma <hui.ma@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Hi Jianjun and Bjorn,
> 
> any news about this patch? Thanks in advance.

The v6.13 merge window is open now, so we will merge new content for
v6.14 soon after v6.13-rc1 is tagged, which will probably be Dec 1.

> > ---
> > Changes in v3:
> > - cosmetics
> > - Link to v2: https://lore.kernel.org/r/20241104-pcie-en7581-rst-fix-v2-1-ffe5839c76d8@kernel.org
> > 
> > Changes in v2:
> > - introduce flags field in mtk_gen3_pcie_flags struct instead of adding
> >   reset callback
> > - fix the leftover case in mtk_pcie_suspend_noirq routine
> > - add more comments
> > - Link to v1: https://lore.kernel.org/r/20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 60 ++++++++++++++++++++---------
> >  1 file changed, 42 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index 16a55711a7f3bdc8d6620029e3d2cfdd40b537b7..443072adb9b52a6934a5d1e38eb6fca5f86a1e13 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -128,10 +128,18 @@
> >  
> >  struct mtk_gen3_pcie;
> >  
> > +enum mtk_gen3_pcie_flags {
> > +	SKIP_PCIE_RSTB	= BIT(0), /* skip PCIE_RSTB signals configuration
> > +				   * during device probing or suspend/resume
> > +				   * phase in order to avoid hw bugs/issues.
> > +				   */
> > +};
> > +
> >  /**
> >   * struct mtk_gen3_pcie_pdata - differentiate between host generations
> >   * @power_up: pcie power_up callback
> >   * @phy_resets: phy reset lines SoC data.
> > + * @flags: pcie device flags.
> >   */
> >  struct mtk_gen3_pcie_pdata {
> >  	int (*power_up)(struct mtk_gen3_pcie *pcie);
> > @@ -139,6 +147,7 @@ struct mtk_gen3_pcie_pdata {
> >  		const char *id[MAX_NUM_PHY_RESETS];
> >  		int num_resets;
> >  	} phy_resets;
> > +	u32 flags;
> >  };
> >  
> >  /**
> > @@ -405,22 +414,34 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
> >  	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
> >  	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
> >  
> > -	/* Assert all reset signals */
> > -	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > -	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> > -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > -
> >  	/*
> > -	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> > -	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > -	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> > -	 * for the power and clock to become stable.
> > +	 * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > +	 * causing occasional PCIe link down. In order to overcome the issue,
> > +	 * PCIE_RSTB signals are not asserted/released at this stage and the
> > +	 * PCIe block is reset configuting REG_PCI_CONTROL (0x88) and
> > +	 * REG_RESET_CONTROL (0x834) registers available in the clock module
> > +	 * running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
> >  	 */
> > -	msleep(100);
> > -
> > -	/* De-assert reset signals */
> > -	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
> > -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> > +		/* Assert all reset signals */
> > +		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > +		val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> > +		       PCIE_PE_RSTB;
> > +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +
> > +		/*
> > +		 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
> > +		 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> > +		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> > +		 * for the power and clock to become stable.
> > +		 */
> > +		msleep(PCIE_T_PVPERL_MS);
> > +
> > +		/* De-assert reset signals */
> > +		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> > +			 PCIE_PE_RSTB);
> > +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	}
> >  
> >  	/* Check if the link is up or not */
> >  	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
> > @@ -1179,10 +1200,12 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
> >  		return err;
> >  	}
> >  
> > -	/* Pull down the PERST# pin */
> > -	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > -	val |= PCIE_PE_RSTB;
> > -	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> > +		/* Pull down the PERST# pin */
> > +		val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
> > +		val |= PCIE_PE_RSTB;
> > +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +	}
> >  
> >  	dev_dbg(pcie->dev, "entered L2 states successfully");
> >  
> > @@ -1233,6 +1256,7 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
> >  		.id[2] = "phy-lane2",
> >  		.num_resets = 3,
> >  	},
> > +	.flags = SKIP_PCIE_RSTB,
> >  };
> >  
> >  static const struct of_device_id mtk_pcie_of_match[] = {
> > 
> > ---
> > base-commit: ff80d707f3cb5e8d9ec0739e0e5ed42dea179125
> > change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4
> > 
> > Best regards,
> > -- 
> > Lorenzo Bianconi <lorenzo@kernel.org>
> > 



