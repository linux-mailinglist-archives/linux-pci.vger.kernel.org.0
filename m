Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9653E959
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbiFFQ1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 12:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbiFFQ12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 12:27:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEED41CB2F;
        Mon,  6 Jun 2022 09:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B373B81A99;
        Mon,  6 Jun 2022 16:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23100C385A9;
        Mon,  6 Jun 2022 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532844;
        bh=ylWybLonD1BQqCYZrEEqFYrp83QmjcrwN1I8AMq+9V4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKCgBcAhZw0W+7pwPPmYwVhEjCzvTnJ/7rjg5xNoB0iQhZbQ9gh+U4RZ5JomeY3Hp
         6Rswdhk5jO20B82AjljfMyGXlmW1rIPp8rzd8eQ+h0x7RzTS7qcUJvfvNplhSAMnPF
         Se3EWMpDXNMFnq63wG0PJhuHJY+S9N5dLX80eQoL2xWpJT6749f4TYWyoumb1K8/X8
         HZhtP+wzgTikagNv3A3RCRVvwyxO7uGTgafX3qVZX9RGNdouLuyszi0mm1cnOiM6dP
         BgHuO7xdWPs9hBNcqvtKJQjNz3Nrx71QPtbTMFNY5L6AND1xn8SpqMLrFtHegjXS7g
         PsCeW1uxfSgwQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nyFZV-0004As-AQ; Mon, 06 Jun 2022 18:27:17 +0200
Date:   Mon, 6 Jun 2022 18:27:17 +0200
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v13 4/7] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <Yp4q5S7WIYbYEdHc@hovoldconsulting.com>
References: <20220603074137.1849892-1-dmitry.baryshkov@linaro.org>
 <20220603074137.1849892-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603074137.1849892-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 03, 2022 at 10:41:34AM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Implement support for such configurations by
> parsing "msi0" ... "msiN" interrupts and attaching them to the chained
> handler.
> 
> Note, that if DT doesn't list an array of MSI interrupts and uses single
> "msi" IRQ, the driver will limit the amount of supported MSI vectors
> accordingly (to 32).
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 63 +++++++++++++++++--
>  1 file changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 85c1160792e1..d1f9e20df903 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -289,6 +289,46 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
> +static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq;
> +	u32 ctrl, max_vectors;
> +
> +	/* Parse as many IRQs as described in the devicetree. */
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
> +		char *msi_name = "msiX";
> +
> +		msi_name[3] = '0' + ctrl;

This oopses here as the string constant is read only:

	[   19.787973] Unable to handle kernel write to read-only memory at virtual address ffffaa14f831afd3

Did you not test the series before posting?

You need to define msi_name as:

	char msi_name[] = "msiX";

> +		irq = platform_get_irq_byname_optional(pdev, msi_name);
> +		if (irq == -ENXIO)
> +			break;
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq,
> +					     "Failed to parse MSI IRQ '%s'\n",
> +					     msi_name);
> +
> +		pp->msi_irq[ctrl] = irq;
> +	}

Johan
