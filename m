Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B07C0103
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjJJQCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjJJQCq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 12:02:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E58A7;
        Tue, 10 Oct 2023 09:02:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E2FC433C7;
        Tue, 10 Oct 2023 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953762;
        bh=8zTGRYTY1WUSPexJBZKSYXIXebpfzjhtEAwIpwHKrgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPfnQ4Mqq/LwUfreTwFh2h7CpeWm1aEetozjYfx9hep8O3FN5ECtreNqLxdO38h4D
         y2M4N0vbTDKEqB0hqR5Gj4wp//6BhUIyeyzarNel8VnlHeGz7zSnawtIJZYoXg0mIB
         X1kxcEPxUxbVc6CJN4yLmqP9IsVviwIgAl3dk/XdYU2p2AP1HyHTYct6nl7aJAI1Na
         y1Q73d4THK7/xQV198rpNqDqOIYAxFwUmCYguOeBkMJGCQlLvwH+lSoSSrDxHObl5o
         FWQmFW0v8FHC/s0zHtU7iOk7N1XpVaO97nOxNcG2mDEAW1GtvKhWjB6l63p7vX3J8t
         tOM7bgskk4kmA==
Date:   Tue, 10 Oct 2023 18:02:36 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 2/3] PCI: layerscape: add suspend/resume for ls1021a
Message-ID: <ZSV1nJUAbUdLXkt4@lpieralisi>
References: <20230915184306.2374670-1-Frank.Li@nxp.com>
 <20230915184306.2374670-2-Frank.Li@nxp.com>
 <ZR10SVVBYvfMJPv1@lizhi-Precision-Tower-5810>
 <ZSVdnAsRQA2zHsF7@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSVdnAsRQA2zHsF7@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 10:20:12AM -0400, Frank Li wrote:
> On Wed, Oct 04, 2023 at 10:23:51AM -0400, Frank Li wrote:
> > On Fri, Sep 15, 2023 at 02:43:05PM -0400, Frank Li wrote:
> > > ls1021a add suspend/resume support.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > 
> > ping
> > 
> > Frank
> 
> Ping

Read and follow please (and then ping us):
https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

> Frank
> 
> > 
> > >  drivers/pci/controller/dwc/pci-layerscape.c | 88 ++++++++++++++++++++-
> > >  1 file changed, 87 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > > index 20c48c06e2248..bc5a8ff1a26ce 100644
> > > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > > @@ -35,6 +35,12 @@
> > >  #define PF_MCR_PTOMR		BIT(0)
> > >  #define PF_MCR_EXL2S		BIT(1)
> > >  
> > > +/* LS1021A PEXn PM Write Control Register */
> > > +#define SCFG_PEXPMWRCR(idx)	(0x5c + (idx) * 0x64)
> > > +#define PMXMTTURNOFF		BIT(31)
> > > +#define SCFG_PEXSFTRSTCR	0x190
> > > +#define PEXSR(idx)		BIT(idx)
> > > +
> > >  #define PCIE_IATU_NUM		6
> > >  
> > >  struct ls_pcie_drvdata {
> > > @@ -48,6 +54,8 @@ struct ls_pcie {
> > >  	struct dw_pcie *pci;
> > >  	const struct ls_pcie_drvdata *drvdata;
> > >  	void __iomem *pf_base;
> > > +	struct regmap *scfg;
> > > +	int index;
> > >  	bool big_endian;
> > >  };
> > >  
> > > @@ -170,13 +178,91 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
> > >  	return 0;
> > >  }
> > >  
> > > +static void ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > +	u32 val;
> > > +
> > > +	if (!pcie->scfg) {
> > > +		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/* Send Turn_off message */
> > > +	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> > > +	val |= PMXMTTURNOFF;
> > > +	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> > > +
> > > +	/* There are not register to check ACK, so wait PCIE_PME_TO_L2_TIMEOUT_US */
> > > +	mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> > > +
> > > +	/* Clear Turn_off message */
> > > +	regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> > > +	val &= ~PMXMTTURNOFF;
> > > +	regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> > > +}
> > > +
> > > +static void ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > +	u32 val;
> > > +
> > > +	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
> > > +	val |= PEXSR(pcie->index);
> > > +	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
> > > +
> > > +	regmap_read(pcie->scfg, SCFG_PEXSFTRSTCR, &val);
> > > +	val &= ~PEXSR(pcie->index);
> > > +	regmap_write(pcie->scfg, SCFG_PEXSFTRSTCR, val);
> > > +}
> > > +
> > > +static int ls1021a_pcie_host_init(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct ls_pcie *pcie = to_ls_pcie(pci);
> > > +	struct device *dev = pcie->pci->dev;
> > > +	u32 index[2];
> > > +	int ret;
> > > +
> > > +	ret = ls_pcie_host_init(pp);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,pcie-scfg");
> > > +	if (IS_ERR(pcie->scfg)) {
> > > +		ret = PTR_ERR(pcie->scfg);
> > > +		dev_err(dev, "No syscfg phandle specified\n");
> > > +		pcie->scfg = NULL;
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = of_property_read_u32_array(dev->of_node, "fsl,pcie-scfg", index, 2);
> > > +	if (ret) {
> > > +		pcie->scfg = NULL;
> > > +		return ret;
> > > +	}
> > > +
> > > +	pcie->index = index[1];
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static const struct dw_pcie_host_ops ls_pcie_host_ops = {
> > >  	.host_init = ls_pcie_host_init,
> > >  	.pme_turn_off = ls_pcie_send_turnoff_msg,
> > >  };
> > >  
> > > +static const struct dw_pcie_host_ops ls1021a_pcie_host_ops = {
> > > +	.host_init = ls1021a_pcie_host_init,
> > > +	.pme_turn_off = ls1021a_pcie_send_turnoff_msg,
> > > +};
> > > +
> > >  static const struct ls_pcie_drvdata ls1021a_drvdata = {
> > > -	.pm_support = false,
> > > +	.pm_support = true,
> > > +	.ops = &ls1021a_pcie_host_ops,
> > > +	.exit_from_l2 = ls1021a_pcie_exit_from_l2,
> > >  };
> > >  
> > >  static const struct ls_pcie_drvdata layerscape_drvdata = {
> > > -- 
> > > 2.34.1
> > > 
