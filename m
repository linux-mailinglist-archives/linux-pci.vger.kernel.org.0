Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BAB7BFACA
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjJJMHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 08:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjJJMHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 08:07:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21B494;
        Tue, 10 Oct 2023 05:07:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86E3C433C8;
        Tue, 10 Oct 2023 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939631;
        bh=za2l4w484JGV1JQq1NuVdJOjePBtNufYGNfJ71lUcBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsjoqcscnCtCN2Q2XpmEHBbsxWDP0OubWLQpbZvXztffL4ktgVMQpLWVeeGV//dWu
         1C/X9tW7sxRx2WjmvIN5zZ4IaLxAdDxnJbQrHJV5eodZFHqB26gVya2GsHvtAWwLEl
         OodBZF6yDKs14pkvZyy9mdrrmeJnUTIKyV8faLGiEjQnuEswcdr1Lqg81MYd284Q/Z
         PO8qeyBAL4iltrnzhpHjGWcXp0VHGVvRrzwvtm4QrSA/r0m533LdJjFrocFw5Nuxow
         CGqaTGKiBiv3J+9zYOGUWviMThKDfc7El+/6BKYmV8GFD2j3sEQPR4EpuosRtB6lE1
         y4dTj8L3syzwg==
Date:   Tue, 10 Oct 2023 17:36:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v21 14/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 Endpoint support
Message-ID: <20231010120657.GH4884@thinkpad>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-15-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922065331.3806925-15-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 03:53:29PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe controller for endpoint mode. This controller is based
> on Synopsys DesignWare PCIe.
> 
> Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-18-yoshihiro.shimoda.uh@renesas.com
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig          |  11 ++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 136 +++++++++++++++++++-
>  2 files changed, 144 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index bc69fcab2e2a..e7fd37717998 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -429,4 +429,15 @@ config PCIE_RCAR_GEN4_HOST
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called pcie-rcar-gen4.ko. This uses the DesignWare core.
>  
> +config PCIE_RCAR_GEN4_EP
> +	tristate "Renesas R-Car Gen4 PCIe controller (endpoint mode)"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCIE_RCAR_GEN4
> +	help
> +	  Say Y here if you want PCIe controller (endpoint mode) on R-Car Gen4
> +	  SoCs. To compile this driver as a module, choose M here: the module
> +	  will be called pcie-rcar-gen4.ko. This uses the DesignWare core.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index dfff6bb18932..68879b7308c5 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -45,6 +45,9 @@
>  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
>  #define RCAR_MAX_LINK_SPEED		4
>  
> +#define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> +#define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> +
>  struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
> @@ -53,6 +56,7 @@ struct rcar_gen4_pcie {
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
> +/* Common */
>  static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
>  					bool enable)
>  {
> @@ -310,6 +314,9 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>  {
>  	struct dw_pcie_rp *pp = &rcar->dw.pp;
>  
> +	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
> +		return -ENODEV;
> +
>  	pp->num_vectors = MAX_MSI_IRQS;
>  	pp->ops = &rcar_gen4_pcie_host_ops;
>  	rcar->mode = DW_PCIE_RC_TYPE;
> @@ -322,8 +329,114 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>  	dw_pcie_host_deinit(&rcar->dw.pp);
>  }
>  
> +/* Endpoind mode */
> +static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	int ret;
> +
> +	ret = rcar_gen4_pcie_common_init(rcar);
> +	if (ret)
> +		return;
> +
> +	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
> +}
> +
> +static void rcar_gen4_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +}
> +
> +static void rcar_gen4_pcie_ep_deinit(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +
> +	writel(0, rcar->base + PCIEDMAINTSTSEN);
> +	rcar_gen4_pcie_common_deinit(rcar);
> +}
> +
> +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				       unsigned int type, u16 interrupt_num)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_IRQ_LEGACY:
> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +	case PCI_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(dw->dev, "Unknown IRQ type\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +	.reserved_bar = 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
> +	.align = SZ_1M,
> +};
> +
> +static const struct pci_epc_features*
> +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &rcar_gen4_pcie_epc_features;
> +}
> +
> +static unsigned int rcar_gen4_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
> +						       u8 func_no)
> +{
> +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET;
> +}
> +
> +static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
> +						      u8 func_no)
> +{
> +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET;
> +}
> +
> +static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.pre_init = rcar_gen4_pcie_ep_pre_init,
> +	.ep_init = rcar_gen4_pcie_ep_init,
> +	.deinit = rcar_gen4_pcie_ep_deinit,
> +	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
> +	.get_features = rcar_gen4_pcie_ep_get_features,
> +	.func_conf_select = rcar_gen4_pcie_ep_func_conf_select,
> +	.get_dbi2_offset = rcar_gen4_pcie_ep_get_dbi2_offset,
> +};
> +
> +static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie_ep *ep = &rcar->dw.ep;
> +
> +	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_EP))
> +		return -ENODEV;
> +
> +	rcar->mode = DW_PCIE_EP_TYPE;
> +	ep->ops = &pcie_ep_ops;
> +
> +	return dw_pcie_ep_init(ep);
> +}
> +
> +static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
> +{
> +	dw_pcie_ep_exit(&rcar->dw.ep);
> +}
> +
> +/* Common */
>  static int rcar_gen4_pcie_probe(struct platform_device *pdev)
>  {
> +	enum dw_pcie_device_mode mode;
>  	struct rcar_gen4_pcie *rcar;
>  	int err;
>  
> @@ -339,7 +452,13 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	err = rcar_gen4_add_dw_pcie_rp(rcar);
> +	mode = (enum dw_pcie_device_mode)of_device_get_match_data(&pdev->dev);
> +
> +	if (mode == DW_PCIE_RC_TYPE)
> +		err = rcar_gen4_add_dw_pcie_rp(rcar);
> +	else if (mode == DW_PCIE_EP_TYPE)
> +		err = rcar_gen4_add_dw_pcie_ep(rcar);
> +
>  	if (err)
>  		goto err_unprepare;
>  
> @@ -355,12 +474,23 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>  {
>  	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
>  
> -	rcar_gen4_remove_dw_pcie_rp(rcar);
> +	if (rcar->mode == DW_PCIE_RC_TYPE)
> +		rcar_gen4_remove_dw_pcie_rp(rcar);
> +	else if (rcar->mode == DW_PCIE_EP_TYPE)
> +		rcar_gen4_remove_dw_pcie_ep(rcar);
> +
>  	rcar_gen4_pcie_unprepare(rcar);
>  }
>  
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> -	{ .compatible = "renesas,rcar-gen4-pcie", },
> +	{
> +		.compatible = "renesas,rcar-gen4-pcie",
> +		.data = (void *)DW_PCIE_RC_TYPE,
> +	},
> +	{
> +		.compatible = "renesas,rcar-gen4-pcie-ep",
> +		.data = (void *)DW_PCIE_EP_TYPE,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
