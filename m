Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4649575EC8E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGXHch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGXHcg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 03:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA3B180;
        Mon, 24 Jul 2023 00:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA2B60B96;
        Mon, 24 Jul 2023 07:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408A7C433C7;
        Mon, 24 Jul 2023 07:32:20 +0000 (UTC)
Date:   Mon, 24 Jul 2023 13:02:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v18 02/20] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
Message-ID: <20230724073211.GB6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-3-yoshihiro.shimoda.uh@renesas.com>
 <6e88938f-5cb7-96c8-681e-0e929ace4517@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e88938f-5cb7-96c8-681e-0e929ace4517@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 05:10:27PM +0900, Damien Le Moal wrote:
> On 7/21/23 16:44, Yoshihiro Shimoda wrote:
> > Using "INTx" instead of "legacy" is more specific. So, rename
> > PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.
> > 
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> I would rather drop completely the PCI_EPC_IRQ_XXX enum and simply use the
> PCI_IRQ_XXX macros used everywhere. Less definitions :)
> 
> See attached patch that I have in my queue (about to send that).
> 

It looks better! This patch should be dropped.

- Mani

> > ---
> > This CC-list is for git send-email.
> > 
> > Cc: Tom Joseph <tjoseph@cadence.com>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> > Cc: Mingkai Hu <mingkai.hu@nxp.com>
> > Cc: Roy Zang <roy.zang@nxp.com>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Srikanth Thokala <srikanth.thokala@intel.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c  |  2 +-
> >  drivers/pci/controller/dwc/pci-dra7xx.c           |  2 +-
> >  drivers/pci/controller/dwc/pci-imx6.c             |  2 +-
> >  drivers/pci/controller/dwc/pci-keystone.c         |  2 +-
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 +-
> >  drivers/pci/controller/dwc/pcie-artpec6.c         |  2 +-
> >  drivers/pci/controller/dwc/pcie-designware-plat.c |  2 +-
> >  drivers/pci/controller/dwc/pcie-keembay.c         |  2 +-
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  2 +-
> >  drivers/pci/controller/dwc/pcie-tegra194.c        |  2 +-
> >  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 +-
> >  drivers/pci/controller/pcie-rcar-ep.c             |  2 +-
> >  drivers/pci/controller/pcie-rockchip-ep.c         |  2 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c     | 10 +++++-----
> >  include/linux/pci-epc.h                           |  4 ++--
> >  15 files changed, 20 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > index b8b655d4047e..2af8eb4e6d91 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > @@ -539,7 +539,7 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> >  	struct device *dev = pcie->dev;
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		if (vfn > 0) {
> >  			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
> >  			return -EINVAL;
> > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> > index b445ffe95e3f..8767432dda5c 100644
> > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > @@ -410,7 +410,7 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		dra7xx_pcie_raise_legacy_irq(dra7xx);
> >  		break;
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 235ead4c807f..feadc88782a7 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1063,7 +1063,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 49aea6ce3e87..fce300673ea3 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -907,7 +907,7 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		ks_pcie_am654_raise_legacy_irq(ks_pcie);
> >  		break;
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > index de4c1758a6c3..b2e14d64dba2 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > @@ -155,7 +155,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> > index 9b572a2b2c9a..cf92a11ede86 100644
> > --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> > +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> > @@ -357,7 +357,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
> >  		return -EINVAL;
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> > index b625841e98aa..f72df38dd523 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> > @@ -48,7 +48,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> > index 289bff99d762..62903fef343c 100644
> > --- a/drivers/pci/controller/dwc/pcie-keembay.c
> > +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> > @@ -295,7 +295,7 @@ static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		/* Legacy interrupts are not supported in Keem Bay */
> >  		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> >  		return -EINVAL;
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 267e1247d548..21e2ccc49219 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -660,7 +660,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 383ba71d1e8f..85cc64324efd 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1999,7 +1999,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
> >  
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> > index cba3c88fcf39..a00301928c38 100644
> > --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> > @@ -262,7 +262,7 @@ static int uniphier_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return uniphier_pcie_ep_raise_legacy_irq(ep);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return uniphier_pcie_ep_raise_msi_irq(ep, func_no,
> > diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> > index f9682df1da61..fbdf3d85301c 100644
> > --- a/drivers/pci/controller/pcie-rcar-ep.c
> > +++ b/drivers/pci/controller/pcie-rcar-ep.c
> > @@ -408,7 +408,7 @@ static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> >  	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return rcar_pcie_ep_assert_intx(ep, fn, 0);
> >  
> >  	case PCI_EPC_IRQ_MSI:
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> > index 0af0e965fb57..e856a45d0986 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -413,7 +413,7 @@ static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> >  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> >  
> >  	switch (type) {
> > -	case PCI_EPC_IRQ_LEGACY:
> > +	case PCI_EPC_IRQ_INTX:
> >  		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
> >  	case PCI_EPC_IRQ_MSI:
> >  		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 1f0d2b84296a..caa30596fadd 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -19,11 +19,11 @@
> >  #include <linux/pci-epf.h>
> >  #include <linux/pci_regs.h>
> >  
> > -#define IRQ_TYPE_LEGACY			0
> > +#define IRQ_TYPE_INTX			0
> >  #define IRQ_TYPE_MSI			1
> >  #define IRQ_TYPE_MSIX			2
> >  
> > -#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
> > +#define COMMAND_RAISE_INTX_IRQ		BIT(0)
> >  #define COMMAND_RAISE_MSI_IRQ		BIT(1)
> >  #define COMMAND_RAISE_MSIX_IRQ		BIT(2)
> >  #define COMMAND_READ			BIT(3)
> > @@ -600,9 +600,9 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> >  	WRITE_ONCE(reg->status, status);
> >  
> >  	switch (reg->irq_type) {
> > -	case IRQ_TYPE_LEGACY:
> > +	case IRQ_TYPE_INTX:
> >  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> > -				  PCI_EPC_IRQ_LEGACY, 0);
> > +				  PCI_EPC_IRQ_INTX, 0);
> >  		break;
> >  	case IRQ_TYPE_MSI:
> >  		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> > @@ -659,7 +659,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
> >  	}
> >  
> >  	switch (command) {
> > -	case COMMAND_RAISE_LEGACY_IRQ:
> > +	case COMMAND_RAISE_INTX_IRQ:
> >  	case COMMAND_RAISE_MSI_IRQ:
> >  	case COMMAND_RAISE_MSIX_IRQ:
> >  		pci_epf_test_raise_irq(epf_test, reg);
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 5cb694031072..c5ada36b6ca0 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -21,7 +21,7 @@ enum pci_epc_interface_type {
> >  
> >  enum pci_epc_irq_type {
> >  	PCI_EPC_IRQ_UNKNOWN,
> > -	PCI_EPC_IRQ_LEGACY,
> > +	PCI_EPC_IRQ_INTX,
> >  	PCI_EPC_IRQ_MSI,
> >  	PCI_EPC_IRQ_MSIX,
> >  };
> > @@ -54,7 +54,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
> >   *	     MSI-X capability register
> >   * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
> >   *	     from the MSI-X capability register
> > - * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
> > + * @raise_irq: ops to raise an INTx, MSI or MSI-X interrupt
> >   * @map_msi_irq: ops to map physical address to MSI address and return MSI data
> >   * @start: ops to start the PCI link
> >   * @stop: ops to stop the PCI link
> 
> -- 
> Damien Le Moal
> Western Digital Research

> From e2acf8cc92fc3902b355ba3fe4a8c37c9535c7c8 Mon Sep 17 00:00:00 2001
> From: Damien Le Moal <dlemoal@kernel.org>
> Date: Wed, 12 Apr 2023 19:50:47 +0900
> Subject: [PATCH] PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
> 
> linux/pci.h defines the IRQ flags PCI_IRQ_LEGACY, PCI_IRQ_MSI and
> PCI_IRQ_MSIX. Let's use these flags directly instead of the endpoint
> definitions provided by enum pci_epc_irq_type.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c  |  9 ++++-----
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  6 +++---
>  drivers/pci/controller/dwc/pci-imx6.c             |  9 ++++-----
>  drivers/pci/controller/dwc/pci-keystone.c         |  9 ++++-----
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  8 ++++----
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  6 +++---
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c         |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  6 +++---
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  7 +++----
>  drivers/pci/controller/pcie-rcar-ep.c             |  7 +++----
>  drivers/pci/controller/pcie-rockchip-ep.c         |  7 +++----
>  drivers/pci/endpoint/functions/pci-epf-mhi.c      |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c      |  4 ++--
>  drivers/pci/endpoint/functions/pci-epf-test.c     |  6 +++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c     |  7 ++-----
>  drivers/pci/endpoint/pci-epc-core.c               |  2 +-
>  include/linux/pci-epc.h                           | 11 ++---------
>  21 files changed, 59 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b8b655d4047e..250ad1330ff3 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -531,25 +531,24 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
>  }
>  
>  static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> -				  enum pci_epc_irq_type type,
> -				  u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	struct device *dev = pcie->dev;
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		if (vfn > 0) {
>  			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
>  			return -EINVAL;
>  		}
>  		return cdns_pcie_ep_send_legacy_irq(ep, fn, vfn, 0);
>  
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return cdns_pcie_ep_send_msi_irq(ep, fn, vfn, interrupt_num);
>  
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return cdns_pcie_ep_send_msix_irq(ep, fn, vfn, interrupt_num);
>  
>  	default:
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 4ae807e7cf79..1203f76b3604 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -404,16 +404,16 @@ static void dra7xx_pcie_raise_msi_irq(struct dra7xx_pcie *dra7xx,
>  }
>  
>  static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				 enum pci_epc_irq_type type, u16 interrupt_num)
> +				 unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		dra7xx_pcie_raise_legacy_irq(dra7xx);
>  		break;
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		dra7xx_pcie_raise_msi_irq(dra7xx, interrupt_num);
>  		break;
>  	default:
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 27aaa2a6bf39..2975f3faca61 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1057,17 +1057,16 @@ static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_epc_irq_type type,
> -				  u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 78818853af9e..e63ea88051c0 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -901,20 +901,19 @@ static void ks_pcie_am654_raise_legacy_irq(struct keystone_pcie *ks_pcie)
>  }
>  
>  static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				   enum pci_epc_irq_type type,
> -				   u16 interrupt_num)
> +				   unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		ks_pcie_am654_raise_legacy_irq(ks_pcie);
>  		break;
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  		break;
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>  		break;
>  	default:
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index de4c1758a6c3..794e0bd199b7 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -150,16 +150,16 @@ static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				enum pci_epc_irq_type type, u16 interrupt_num)
> +				unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
>  							  interrupt_num);
>  	default:
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 98102079e26d..e84748b82fee 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -352,15 +352,15 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_epc_irq_type type, u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
>  		return -EINVAL;
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f9182f8d552f..ab87ea3b0986 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -426,7 +426,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  
>  static int dw_pcie_ep_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -				enum pci_epc_irq_type type, u16 interrupt_num)
> +				unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 1fcfb840f238..9871c49b0383 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -42,17 +42,16 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				     enum pci_epc_irq_type type,
> -				     u16 interrupt_num)
> +				     unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 615660640801..e039081eb947 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -320,7 +320,7 @@ struct dw_pcie_rp {
>  struct dw_pcie_ep_ops {
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> -			     enum pci_epc_irq_type type, u16 interrupt_num);
> +			     unsigned int type, u16 interrupt_num);
>  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
>  	/*
>  	 * Provide a method to implement the different func config space
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index f90f36bac018..c93fd79d400b 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -284,19 +284,18 @@ static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
>  }
>  
>  static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				     enum pci_epc_irq_type type,
> -				     u16 interrupt_num)
> +				     unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		/* Legacy interrupts are not supported in Keem Bay */
>  		dev_err(pci->dev, "Legacy IRQ is not supported\n");
>  		return -EINVAL;
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 0fe7f06f2102..3faabc66f07b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -655,14 +655,14 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
>  }
>  
>  static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				  enum pci_epc_irq_type type, u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>  	default:
>  		dev_err(pci->dev, "Unknown IRQ type\n");
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index e1db909f53ec..cafcef0da223 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1993,20 +1993,19 @@ static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  }
>  
>  static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				   enum pci_epc_irq_type type,
> -				   u16 interrupt_num)
> +				   unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
>  
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return tegra_pcie_ep_raise_msi_irq(pcie, interrupt_num);
>  
> -	case PCI_EPC_IRQ_MSIX:
> +	case PCI_IRQ_MSIX:
>  		return tegra_pcie_ep_raise_msix_irq(pcie, interrupt_num);
>  
>  	default:
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index 4d0a587c0ba5..43c27138c3c5 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -256,15 +256,14 @@ static int uniphier_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,
>  }
>  
>  static int uniphier_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> -				      enum pci_epc_irq_type type,
> -				      u16 interrupt_num)
> +				      unsigned int type, u16 interrupt_num)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		return uniphier_pcie_ep_raise_legacy_irq(ep);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return uniphier_pcie_ep_raise_msi_irq(ep, func_no,
>  						      interrupt_num);
>  	default:
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index f9682df1da61..2172db2343d9 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -402,16 +402,15 @@ static int rcar_pcie_ep_assert_msi(struct rcar_pcie *pcie,
>  }
>  
>  static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> -				  enum pci_epc_irq_type type,
> -				  u16 interrupt_num)
> +				  unsigned int type, u16 interrupt_num)
>  {
>  	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		return rcar_pcie_ep_assert_intx(ep, fn, 0);
>  
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return rcar_pcie_ep_assert_msi(&ep->pcie, fn, interrupt_num);
>  
>  	default:
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 0af0e965fb57..397ad551c912 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -407,15 +407,14 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  }
>  
>  static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
> -				      enum pci_epc_irq_type type,
> -				      u16 interrupt_num)
> +				      unsigned int type, u16 interrupt_num)
>  {
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  
>  	switch (type) {
> -	case PCI_EPC_IRQ_LEGACY:
> +	case PCI_IRQ_LEGACY:
>  		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
> -	case PCI_EPC_IRQ_MSI:
> +	case PCI_IRQ_MSI:
>  		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index ddf0bace4e18..f2fcda1c5d4f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -177,7 +177,7 @@ static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
>  	 * MHI supplies 0 based MSI vectors but the API expects the vector
>  	 * number to start from 1, so we need to increment the vector by 1.
>  	 */
> -	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_EPC_IRQ_MSI,
> +	pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no, PCI_IRQ_MSI,
>  			  vector + 1);
>  }
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 9aac2c6f3bb9..fad00b1a8335 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -140,9 +140,9 @@ static struct pci_epf_header epf_ntb_header = {
>  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  {
>  	enum pci_epc_interface_type type;
> -	enum pci_epc_irq_type irq_type;
>  	struct epf_ntb_epc *ntb_epc;
>  	struct epf_ntb_ctrl *ctrl;
> +	unsigned int irq_type;
>  	struct pci_epc *epc;
>  	u8 func_no, vfunc_no;
>  	bool is_msix;
> @@ -159,7 +159,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  			ctrl->link_status |= LINK_STATUS_UP;
>  		else
>  			ctrl->link_status &= ~LINK_STATUS_UP;
> -		irq_type = is_msix ? PCI_EPC_IRQ_MSIX : PCI_EPC_IRQ_MSI;
> +		irq_type = is_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
>  		ret = pci_epc_raise_irq(epc, func_no, vfunc_no, irq_type, 1);
>  		if (ret) {
>  			dev_err(&epc->dev,
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index fa993e71c224..76ddf4c92511 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -602,7 +602,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	switch (reg->irq_type) {
>  	case IRQ_TYPE_LEGACY:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_LEGACY, 0);
> +				  PCI_IRQ_LEGACY, 0);
>  		break;
>  	case IRQ_TYPE_MSI:
>  		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> @@ -612,7 +612,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  			return;
>  		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_MSI, reg->irq_number);
> +				  PCI_IRQ_MSI, reg->irq_number);
>  		break;
>  	case IRQ_TYPE_MSIX:
>  		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
> @@ -622,7 +622,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  			return;
>  		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_EPC_IRQ_MSIX, reg->irq_number);
> +				  PCI_IRQ_MSIX, reg->irq_number);
>  		break;
>  	default:
>  		dev_err(dev, "Failed to raise IRQ, unknown type\n");
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c8b423c3c26e..ba2fe0bb400a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1172,11 +1172,8 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  	func_no = ntb->epf->func_no;
>  	vfunc_no = ntb->epf->vfunc_no;
>  
> -	ret = pci_epc_raise_irq(ntb->epf->epc,
> -				func_no,
> -				vfunc_no,
> -				PCI_EPC_IRQ_MSI,
> -				interrupt_num + 1);
> +	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> +				PCI_IRQ_MSI, interrupt_num + 1);
>  	if (ret)
>  		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 6c54fa5684d2..835d56922cbb 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(pci_epc_start);
>   * Invoke to raise an legacy, MSI or MSI-X interrupt
>   */
>  int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -		      enum pci_epc_irq_type type, u16 interrupt_num)
> +		      unsigned int type, u16 interrupt_num)
>  {
>  	int ret;
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 5cb694031072..f498f9aa2ab0 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -19,13 +19,6 @@ enum pci_epc_interface_type {
>  	SECONDARY_INTERFACE,
>  };
>  
> -enum pci_epc_irq_type {
> -	PCI_EPC_IRQ_UNKNOWN,
> -	PCI_EPC_IRQ_LEGACY,
> -	PCI_EPC_IRQ_MSI,
> -	PCI_EPC_IRQ_MSIX,
> -};
> -
>  static inline const char *
>  pci_epc_interface_string(enum pci_epc_interface_type type)
>  {
> @@ -79,7 +72,7 @@ struct pci_epc_ops {
>  			    u16 interrupts, enum pci_barno, u32 offset);
>  	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>  	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -			     enum pci_epc_irq_type type, u16 interrupt_num);
> +			     unsigned int type, u16 interrupt_num);
>  	int	(*map_msi_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			       phys_addr_t phys_addr, u8 interrupt_num,
>  			       u32 entry_size, u32 *msi_data,
> @@ -229,7 +222,7 @@ int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			phys_addr_t phys_addr, u8 interrupt_num,
>  			u32 entry_size, u32 *msi_data, u32 *msi_addr_offset);
>  int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> -		      enum pci_epc_irq_type type, u16 interrupt_num);
> +		      unsigned int type, u16 interrupt_num);
>  int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> -- 
> 2.41.0
> 


-- 
மணிவண்ணன் சதாசிவம்
