Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CF57CEEFD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 07:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjJSF2q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 01:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSF2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 01:28:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5411B;
        Wed, 18 Oct 2023 22:28:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F87C433C7;
        Thu, 19 Oct 2023 05:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697693323;
        bh=tWq3rqiz/cNExCGNkKKHqtS0CnLQjbFNUb2+HC5UQhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcU0GAdeSEqdV/wptE50hn5YApyKulkEBATXncys+kFprzpFI19uyWLFMcYHxw81D
         njiGbWBWhh2bpxZt2UW2YgaWgyaMtPGxmvIOm8sCnbOpFZQcUkFX0NW9kQeQ6iTahN
         yDKtI93Bd61VN9NRbVBltzMRldqcRjY83YlUdi3rIglzacek1YkZDemnSl1/oq7T56
         R3vraAB3nl/aIacdH25v0D4bZhABM8LvtzcY5APGvmR3YKg+mpq9LzN2S2MCqp1GFb
         m6q3WsApVy41pQpGvCA6uJcjo9ekRyWZguJrsHzmLMYYG0V4K1tP+UrAqI3R1qpebc
         iJzKkAGp6xVjQ==
Date:   Thu, 19 Oct 2023 10:58:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add new accessors to enable/disable DBI
 CS2 while setting the BAR size
Message-ID: <20231019052835.GC5142@thinkpad>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-1-3e26de07bec0@linaro.org>
 <rsv5vgle2d36skx75ds4hqzmlqwldmj4g4ghrlyfuu3ideb3rh@74mnro7qnp4v>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rsv5vgle2d36skx75ds4hqzmlqwldmj4g4ghrlyfuu3ideb3rh@74mnro7qnp4v>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 05:13:41PM +0300, Serge Semin wrote:
> On Tue, Oct 17, 2023 at 11:47:54AM +0530, Manivannan Sadhasivam wrote:
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > As per the DWC databook v4.21a, section M.4.1, in order to write some read
> > only and shadow registers through application DBI, the device driver should
> > assert DBI Chip Select 2 (CS2) in addition to DBI Chip Select (CS).
> > 
> > This is a requirement at least on the Qcom platforms while programming the
> > BAR size, as the BAR mask registers are marked RO. So let's add two new
> > accessors dw_pcie_dbi_cs2_{en/dis} to enable/disable CS2 access in a vendor
> > specific way while programming the BAR size.
> 
> Emm, it's a known thing for all IP-core versions: dbi_cs2 must be
> asserted to access the shadow DW PCIe CSRs space for both RC and
> EP including the BARs mask and their enabling/disabling flag (there
> are many more shadow CSRs available on DW PCIe EPs, and a few in DW
> PCIe RCs). That's why the dw_pcie_ops->writel_dbi2 pointer has been
> defined in the first place (dbi2 suffix means dbi_cs2). You should use
> it to create the platform-specific dbi_cs2 write accessors like it's
> done in pci-keystone.c and pcie-bt1.c. For instance like this:
> 
> static void qcom_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
> {
> 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> 	int ret;
> 
> 	writel(1, pcie_ep->elbi + ELBI_CS2_ENABLE);
> 
> 	ret = dw_pcie_write(pci->dbi_base2 + reg, size, val);
> 	if (ret)
> 		dev_err(pci->dev, "write DBI address failed\n");
> 
> 	writel(0, pcie_ep->elbi + ELBI_CS2_ENABLE);
> }
> 

Hmm, I was not aware that this write_dbi2() callback is supposed to enable the
CS2 access internally. But this approach doesn't look good to me.

We already have accessors for enabling write access to DBI RO registers:

dw_pcie_dbi_ro_wr_en()
dw_pcie_dbi_ro_wr_dis()

And IMO DBI_CS2 access should also be done this way instead of hiding it inside
the register write callback.

- Mani

> /* Common DWC controller ops */
> static const struct dw_pcie_ops pci_ops = {
> 	.link_up = qcom_pcie_dw_link_up,
> 	.start_link = qcom_pcie_dw_start_link,
> 	.stop_link = qcom_pcie_dw_stop_link,
> 	.write_dbi2 = qcom_pcie_write_dbi2,
> };
> 
> For that reason there is absolutely no need in adding the new
> callbacks.
> 
> -Serge(y)
> 
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c |  6 ++++++
> >  drivers/pci/controller/dwc/pcie-designware.h    | 13 +++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index d34a5e87ad18..1874fb3d8df4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -269,11 +269,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  
> >  	dw_pcie_dbi_ro_wr_en(pci);
> >  
> > +	dw_pcie_dbi_cs2_en(pci);
> >  	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> > +	dw_pcie_dbi_cs2_dis(pci);
> > +
> >  	dw_pcie_writel_dbi(pci, reg, flags);
> >  
> >  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > +		dw_pcie_dbi_cs2_en(pci);
> >  		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
> > +		dw_pcie_dbi_cs2_dis(pci);
> > +
> >  		dw_pcie_writel_dbi(pci, reg + 4, 0);
> >  	}
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 55ff76e3d384..3cba27b5bbe5 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -379,6 +379,7 @@ struct dw_pcie_ops {
> >  			     size_t size, u32 val);
> >  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> >  			      size_t size, u32 val);
> > +	void	(*dbi_cs2_access)(struct dw_pcie *pcie, bool enable);
> >  	int	(*link_up)(struct dw_pcie *pcie);
> >  	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> >  	int	(*start_link)(struct dw_pcie *pcie);
> > @@ -508,6 +509,18 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
> >  	dw_pcie_writel_dbi(pci, reg, val);
> >  }
> >  
> > +static inline void dw_pcie_dbi_cs2_en(struct dw_pcie *pci)
> > +{
> > +	if (pci->ops && pci->ops->dbi_cs2_access)
> > +		pci->ops->dbi_cs2_access(pci, true);
> > +}
> > +
> > +static inline void dw_pcie_dbi_cs2_dis(struct dw_pcie *pci)
> > +{
> > +	if (pci->ops && pci->ops->dbi_cs2_access)
> > +		pci->ops->dbi_cs2_access(pci, false);
> > +}
> > +
> >  static inline int dw_pcie_start_link(struct dw_pcie *pci)
> >  {
> >  	if (pci->ops && pci->ops->start_link)
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
