Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9B51BC78
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348605AbiEEJxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiEEJxQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:53:16 -0400
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C5457AA;
        Thu,  5 May 2022 02:49:36 -0700 (PDT)
Received: from [192.168.1.17] (hst-208-205.medicom.bg [84.238.208.205])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 63318D2AC;
        Thu,  5 May 2022 12:49:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1651744174; bh=AFckxHcnZVoQgT2lesS9EBjRiWjo3xR8AXz9n0uwhSs=;
        h=Date:Subject:To:Cc:From:From;
        b=Z4vPaW/2NzYNAwiVbosE5R51lWhDKZ62Y8XlKOzwvq5GeUnVQ0e/xd84XD7/7rN/0
         bQhOGyxPOomr26qBHWe9XMRDR2xogNEr5UzkOn2c63c0PUwl+q3N+xAUZrhSuVbQe8
         8S45Z5XV3EKQv4EJZxr/RG9vC+V+5SuSuP8D4TVjCnyEhamcNF7iT18Ef1a1exsXEa
         PTghS7N6hqkxZi/mtwI9KRK2BmaCLSeTNFTrJABiWjHfjwOnABHLDEdywVnR1G9Onu
         Myn0FO57YOL6PposCjJnmtZBMlsklhjOLnPcE9w1BqzIy+zlpJn2zLMEnELIlz3GpP
         J7OY9m1HS7Hag==
Message-ID: <d1632695-754b-06a9-35c7-a82e44f37e6d@mm-sol.com>
Date:   Thu, 5 May 2022 12:49:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 5/7] PCI: qcom: Handle MSIs routed to multiple GIC
 interrupts
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
 <20220505091231.1308963-6-dmitry.baryshkov@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220505091231.1308963-6-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/5/22 12:12, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Thus to receive higher MSI vectors properly,
> add separate msi_host_init()/msi_host_deinit() handling additional host
> IRQs.
> 
> Note, that if DT doesn't list extra MSI interrupts, the driver will limit
> the amount of supported MSI vectors accordingly (to 32).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 137 ++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 375f27ab9403..6cd1c2cc6d9e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -194,6 +194,7 @@ struct qcom_pcie_ops {
>  
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> +	unsigned int has_split_msi_irqs:1;
>  	unsigned int pipe_clk_need_muxing:1;
>  	unsigned int has_tbu_clk:1;
>  	unsigned int has_ddrss_sf_tbu_clk:1;
> @@ -209,6 +210,7 @@ struct qcom_pcie {
>  	struct phy *phy;
>  	struct gpio_desc *reset;
>  	const struct qcom_pcie_cfg *cfg;
> +	int msi_irqs[MAX_MSI_CTRLS];
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1387,6 +1389,124 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static void qcom_chained_msi_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	int irq = irq_desc_get_irq(desc);
> +	struct pcie_port *pp;
> +	int i, pos;
> +	unsigned long val;
> +	u32 status, num_ctrls;
> +	struct dw_pcie *pci;
> +	struct qcom_pcie *pcie;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	pp = irq_desc_get_handler_data(desc);
> +	pci = to_dw_pcie_from_pp(pp);
> +	pcie = to_qcom_pcie(pci);
> +
> +	/*
> +	 * Unlike generic dw_handle_msi_irq(), we can determine which group of
> +	 * MSIs triggered the IRQ, so process just that group.
> +	 */
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +	for (i = 0; i < num_ctrls; i++) {
> +		if (pcie->msi_irqs[i] == irq)
> +			break;
> +	}
> +
> +	if (WARN_ON_ONCE(unlikely(i == num_ctrls)))
> +		goto out;
> +
> +	status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> +				   (i * MSI_REG_CTRL_BLOCK_SIZE));
> +	if (!status)
> +		goto out;
> +
> +	val = status;
> +	pos = 0;
> +	while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
> +				    pos)) != MAX_MSI_IRQS_PER_CTRL) {
> +		generic_handle_domain_irq(pp->irq_domain,
> +					  (i * MAX_MSI_IRQS_PER_CTRL) +
> +					  pos);
> +		pos++;
> +	}
> +
> +out:
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int qcom_pcie_msi_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	struct platform_device *pdev = to_platform_device(pci->dev);
> +	char irq_name[] = "msiXXX";
> +	unsigned int ctrl, num_ctrls;
> +	int msi_irq, ret;
> +
> +	pp->msi_irq = -EINVAL;
> +
> +	/*
> +	 * We provide our own implementation of MSI init/deinit, but rely on
> +	 * using the rest of DWC MSI functionality.
> +	 */
> +	pp->has_msi_ctrl = true;
> +
> +	msi_irq = platform_get_irq_byname_optional(pdev, "msi");
> +	if (msi_irq < 0) {
> +		msi_irq = platform_get_irq(pdev, 0);
> +		if (msi_irq < 0)
> +			return msi_irq;
> +	}
> +
> +	pcie->msi_irqs[0] = msi_irq;
> +
> +	for (num_ctrls = 1; num_ctrls < MAX_MSI_CTRLS; num_ctrls++) {
> +		snprintf(irq_name, sizeof(irq_name), "msi%d", num_ctrls + 1);
> +		msi_irq = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (msi_irq == -ENXIO)
> +			break;
> +
> +		pcie->msi_irqs[num_ctrls] = msi_irq;
> +	}
> +
> +	pp->num_vectors = num_ctrls * MAX_MSI_IRQS_PER_CTRL;
> +	dev_info(&pdev->dev, "Using %d MSI vectors\n", pp->num_vectors);
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +		pp->irq_mask[ctrl] = ~0;
> +
> +	ret = dw_pcie_allocate_msi(pp);
> +	if (ret)
> +		return ret;
> +
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +		irq_set_chained_handler_and_data(pcie->msi_irqs[ctrl],
> +				qcom_chained_msi_isr,
> +				pp)

Align on the open brace, please.

;
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_msi_host_deinit(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	unsigned int ctrl, num_ctrls;
> +
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +		irq_set_chained_handler_and_data(pcie->msi_irqs[ctrl],
> +				NULL,
> +				NULL);

ditto.


-- 
regards,
Stan
