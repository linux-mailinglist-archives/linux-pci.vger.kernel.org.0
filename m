Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B00852B6FA
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiERJpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 05:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiERJoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 05:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7BB13F1CC;
        Wed, 18 May 2022 02:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFF0617A7;
        Wed, 18 May 2022 09:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0031EC385A5;
        Wed, 18 May 2022 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652867012;
        bh=Jpi/1jh96rWRxGpCkg7Oxud6ZiXGVqLYgED2pDrLhmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4mHEn+Yua3OAv39u2P0/mrjBnr6V7vEfW6IGrTtinTFO/oVBlqrYC5InB64ZqLUO
         zFzhSAgB065XpSZG3zpEgutJtPt7gTaakexflusTqS0slN7lTzK3emWR+wNR9FhKBk
         8ZMbxWN3eimSiTdMAbegV1W7tvUnxbKjTzm0yZEf/jvJwOpAFHuQhEZeip6jHDIy9R
         kvJIoLKoXZicA6X6/FQi8aQQ1B4kvhDG1k+sRuO3612YL12lTL+1032K9AiYgMyNin
         L7d4KVVprtKvO4YEtke/X6xGZ8QQLshFLyDhDvYQGeCZhvEG+Q9oZNg2pg0wpK4AvR
         7A4uIrZ0tJs+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrGDL-0003Sw-UH; Wed, 18 May 2022 11:43:32 +0200
Date:   Wed, 18 May 2022 11:43:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 06/10] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <YoS/wwkZoaFc76u1@hovoldconsulting.com>
References: <20220513172622.2968887-1-dmitry.baryshkov@linaro.org>
 <20220513172622.2968887-7-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513172622.2968887-7-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:26:18PM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Implement support for such configurations by
> parsing "msi0" ... "msiN" interrupts and attaching them to the chained
> handler.
> 
> Note, that if DT doesn't list an array of MSI interrupts and uses single
> "msi" IRQ, the driver will limit the amount of supported MSI vectors
> accordingly (to 32).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 70f0435907c1..320a968dd366 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -288,6 +288,11 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
> +static const char * const split_msi_names[] = {
> +	"msi0", "msi1", "msi2", "msi3",
> +	"msi4", "msi5", "msi6", "msi7",
> +};
> +
>  static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -300,17 +305,48 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>  		pp->irq_mask[ctrl] = ~0;
>  
> +	if (pp->has_split_msi_irq) {

You don't need to add this configuration parameter as it can be inferred
from the devicetree (e.g. if "msi0" is specified).

> +		/*
> +		 * Parse as many IRQs as described in the DTS. If there are
> +		 * none, fallback to the single "msi" IRQ.
> +		 */
> +		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +			int irq;
> +
> +			if (pp->msi_irq[ctrl])
> +				continue;
> +
> +			irq = platform_get_irq_byname(pdev, split_msi_names[ctrl]);

You need to use platform_get_irq_byname_optional() here or an error will
still printed if the number of "msi" interrupts is less than 8.

> +			if (irq == -ENXIO) {
> +				num_ctrls = ctrl;
> +				break;
> +			} else if (irq < 0) {
> +				return dev_err_probe(dev, irq,
> +						     "Failed to parse MSI IRQ '%s'\n",
> +						     split_msi_names[ctrl]);
> +			}
> +
> +			pp->msi_irq[ctrl] = irq;
> +		}
> +
> +		if (num_ctrls == 0)
> +			num_ctrls = 1;
> +	}
> +
>  	if (!pp->msi_irq[0]) {
>  		int irq = platform_get_irq_byname_optional(pdev, "msi");
>  
>  		if (irq < 0) {
>  			irq = platform_get_irq(pdev, 0);
>  			if (irq < 0)
> -				return irq;
> +				return dev_err_probe(dev, irq, "Failed to parse MSI irq\n");
>  		}
>  		pp->msi_irq[0] = irq;
>  	}
>  
> +	pp->num_vectors = min_t(u32, pp->num_vectors, num_ctrls * MAX_MSI_IRQS_PER_CTRL);
> +	dev_dbg(dev, "Using %d MSI vectors\n", pp->num_vectors);

Can you rework the handling of num_vectors == 0 (in dw_pcie_host_init())
so that the number is always inferred from the number of "msi"
interrupts without having to pass in num_vectors == MAX_MSI_IRQS?

That is

	num_vectors == 0 && "msi" => num_vectors = MSI_DEF_NUM_VECTORS (32)
	num_vectors == 0 && "msi0".."msin" => num_vectors = n * MAX_MSI_IRQS_PER_CTRL (n * 32)

> +
>  	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
>  
>  	ret = dw_pcie_allocate_domains(pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9c1a38b0a6b3..3aa840a5b19c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -179,6 +179,7 @@ struct dw_pcie_host_ops {
>  
>  struct pcie_port {
>  	bool			has_msi_ctrl:1;
> +	bool			has_split_msi_irq:1;
>  	u64			cfg0_base;
>  	void __iomem		*va_cfg0_base;
>  	u32			cfg0_size;

Johan
