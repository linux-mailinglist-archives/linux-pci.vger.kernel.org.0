Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9689953BA2B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 15:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiFBNzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 09:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiFBNzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 09:55:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0742E29C;
        Thu,  2 Jun 2022 06:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE16DB81ED6;
        Thu,  2 Jun 2022 13:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7931BC385A5;
        Thu,  2 Jun 2022 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654178121;
        bh=/RDmOcN35BWi7GR4EvLaIKmq0NmJ0DnyM3Q1jTsh+IE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4v/S/mA/vOcvEjSZgk4NLp6cb9Gs9xzJu+6eyKbmoLKGhAAbUIM//EzosgFGx7pr
         pwbt1RjLh1eu+o0EbMgWrXgYQQ6oILLEvQyGFZlBCZg3uOSzbFvwkYNno6p1rwC0Mm
         5HP2XKMAF8czYzmkNWCVoLZa1fQAkMAI5jvetUFDrEvv+M3BDruCx2J87qFVf5Xu4n
         oG/7Wox8Zp/eSkU1ZSJFHE3391ecggiNUvd+dYC2wadhETAK88gM7kk/HCVdPW7/Xh
         uwmTBpc3eD2K5DXbBJgEWeOkQpFpePzZ3rodRnpFzUymbCXADzCdIcj2D48YPeeVbQ
         G3KNSlaT/HJFA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nwlIE-0005kq-9l; Thu, 02 Jun 2022 15:55:18 +0200
Date:   Thu, 2 Jun 2022 15:55:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 4/8] PCI: dwc: split MSI IRQ parsing/allocation to a
 separate function
Message-ID: <YpjBRjSafpvNcpe0@hovoldconsulting.com>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:32PM +0300, Dmitry Baryshkov wrote:
> Split handling of MSI host IRQs to a separate dw_pcie_msi_host_init()
> function. The code is complex enough to warrant a separate function.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 98 +++++++++++--------
>  1 file changed, 56 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 8dd913f69de7..a076abe6611c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -288,6 +288,60 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
> +static int dw_pcie_msi_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int ret;
> +	u32 ctrl, num_ctrls;
> +
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +		pp->irq_mask[ctrl] = ~0;
> +
> +	if (!pp->msi_irq[0]) {
> +		int irq = platform_get_irq_byname_optional(pdev, "msi");
> +
> +		if (irq < 0) {
> +			irq = platform_get_irq(pdev, 0);
> +			if (irq < 0)
> +				return irq;
> +		}
> +		pp->msi_irq[0] = irq;
> +	}
> +
> +	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> +
> +	ret = dw_pcie_allocate_domains(pp);
> +	if (ret)
> +		return ret;
> +
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +		if (pp->msi_irq[ctrl] > 0)
> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> +							 dw_chained_msi_isr,
> +							 pp);

Reminder: brackets.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
