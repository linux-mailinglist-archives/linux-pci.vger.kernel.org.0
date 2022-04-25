Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3739750D6BB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 03:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiDYBxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 21:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbiDYBxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 21:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241EE6458;
        Sun, 24 Apr 2022 18:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAE126149E;
        Mon, 25 Apr 2022 01:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEDC385A9;
        Mon, 25 Apr 2022 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650851440;
        bh=A+IkgleLx5GpYaRe8XgG8WBa7kh9cTf9GNEyRineIbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HLzwfKf8aWJjQvJFi64XmqmEotQ7wdDf+Plzmipv4qqh7a4ldhUwheEfX8PzJdxhn
         5oPvKJOk4Q5uZqvERPwIAWGAm8xbckez7Ux6KzOh9GvXVfulc+iZOK6wkU8DcFkvp7
         t3GXfYgvB496nc5isCNdDWV/F79VpBWujCMn5ovQROgEd28cctv3oScU8+n6vGH/Ob
         151fat9emLRcHXUUDrt8JNmYRyd9Ov/Dpoh1T2+h/Lal1W0UfU8HY2m6kgH8qO72CL
         eA1qn1cbWjilygyH4HUkWuuq/g3PBpNJ/aqopPmEdo6tAXbYQmeasdSM9hN7x2BL5x
         um5Of0HHfgGSg==
Date:   Sun, 24 Apr 2022 20:50:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI: dwc: Teach dwc core to parse additional MSI
 interrupts
Message-ID: <20220425015037.GA1611231@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423133939.2123449-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 23, 2022 at 04:39:36PM +0300, Dmitry Baryshkov wrote:
> DWC driver parses a single "msi" interrupt which gets fired when the EP
> sends an MSI interrupt, however for some devices (Qualcomm) devies MSI
> vectors are handled in groups of 32 vectors. Add support for parsing
> "split" MSI interrupts.

devies?  Maybe spurious?

> In addition to the "msi" interrupt, the code will lookup the "msi2",
> "msi3", etc. IRQs and use them for the MSI group interrupts. For
> backwards compatibility with existing DTS files, the code will not error
> out if any of these interrupts is missing. Instead it will limit itself
> to the amount of MSI group IRQs declared in the DT file.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 23 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 5d90009a0f73..ce7071095006 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -382,6 +382,29 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  				pp->msi_irq[0] = irq;
>  			}
>  
> +			if (pp->has_split_msi_irq) {
> +				char irq_name[] = "msiXXX";
> +				int irq;
> +
> +				for (ctrl = 1; ctrl < num_ctrls; ctrl++) {
> +					if (pp->msi_irq[ctrl])
> +						continue;
> +
> +					snprintf(irq_name, sizeof(irq_name), "msi%d", ctrl + 1);
> +					irq = platform_get_irq_byname_optional(pdev, irq_name);
> +					if (irq == -ENXIO) {
> +						num_ctrls = ctrl;
> +						pp->num_vectors = num_ctrls * MAX_MSI_IRQS_PER_CTRL;
> +						dev_warn(dev, "Limiting amount of MSI irqs to %d\n", pp->num_vectors);
> +						break;
> +					}
> +					if (irq < 0)
> +						return irq;
> +
> +					pp->msi_irq[ctrl] = irq;
> +				}
> +			}

This is getting pretty deeply nested, which means it's impractical to
fit in 80 columns like the rest of the file, which means it's ripe for
refactoring to reduce the indentation.

s/amount of/number of/
s/MSI irqs/MSI IRQs/

>  			pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
>  
>  			ret = dw_pcie_allocate_domains(pp);
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
> -- 
> 2.35.1
> 
