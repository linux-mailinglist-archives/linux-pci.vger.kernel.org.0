Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783A55158AC
	for <lists+linux-pci@lfdr.de>; Sat, 30 Apr 2022 00:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381613AbiD2Wu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 18:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381606AbiD2Wu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 18:50:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578963FBCC;
        Fri, 29 Apr 2022 15:47:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1320EB835F3;
        Fri, 29 Apr 2022 22:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A8C385A4;
        Fri, 29 Apr 2022 22:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651272454;
        bh=3SKuEeRlt90D+x7XSL5D9U1N1K/ea2iZqPfs84JCLeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YmKIWBFPYeiBfNZ+7Gll7KxgV2kgSu+oaXeHYPXajUISUDCI9r7ewBjsDL1zj5GqJ
         bkHAhdg5ISN89CFjNNFTjzYGWkqssuWGVQ76b9Z63+amiTT6HhPVKv6l5XR/BVM/B7
         KsrMCDMpSIbq2Da1dEicNFCu5yJJRs0I+vT1kNuQbtYhdP4tY/LEpBDfAlU4Lxf9TD
         dcMvS17diXaxKz/OrFymccyISU7MUOZSQYcVVFNScGQHpXlO8HWdOBGhuJcDat8nph
         mpFh6jaoUpgNu93F0cGT3Sp3936kH08nMUJGaiT520GrtqEDZyHo2+FGWXelGm3pul
         Fq6ijGh0rRdRg==
Date:   Fri, 29 Apr 2022 17:47:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v5 5/7] PCI: qcom: Handle MSI IRQs properly
Message-ID: <20220429224732.GA111265@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429214250.3728510-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject, "Handle MSI IRQs properly" really doesn't tell us anything
useful.  The existing MSI support handles some MSI IRQs "properly," so
we should say something specific about the improvements here, like
"Handle multiple MSI groups" or "Handle MSIs routed to multiple GIC
interrupts" or "Handle split MSI IRQs" or similar.

On Sat, Apr 30, 2022 at 12:42:48AM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Thus to receive higher MSI vectors properly,
> add separate msi_host_init()/msi_host_deinit() handling additional host
> IRQs.

> +static void qcom_chained_msi_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	int irq = irq_desc_get_irq(desc);
> +	struct pcie_port *pp;
> +	int idx, pos;
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
> +	 * Unlike generic dw_handle_msi_irq we can determine, which group of
> +	 * MSIs triggered the IRQ, so process just single group.

Parens and punctuation touch-up:

  Unlike generic dw_handle_msi_irq(), we can determine which group of
  MSIs triggered the IRQ, so process just that group.

> +	 */
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +	for (idx = 0; idx < num_ctrls; idx++) {
> +		if (pcie->msi_irqs[idx] == irq)
> +			break;
> +	}

Since this is basically an enhanced clone of dw_handle_msi_irq(), it
would be nice to use the same variable names ("i" instead of "idx")
so it's not gratuitously different.

Actually, I wonder if you could enhance dw_handle_msi_irq() slightly
so you could use it directly, e.g.,

    struct dw_pcie_host_ops {
      ...
      void (*msi_host_deinit)(struct pcie_port *pp);
 +    bool (*msi_in_block)(struct pcie_port *pp, int irq, int i);
    };

    dw_handle_msi_irq(...)
    {
      ...

      for (i = 0; i < num_ctrls; i++) {
 +      if (pp->ops->msi_in_block && !pp->ops->msi_in_block(pp, irq, i))
 +        continue;

	status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS ...);
	...

 +  bool qcom_pcie_msi_in_block(struct pcie_port *pp, int irq, int i)
 +  {
 +    ...
 +    pci = to_dw_pcie_from_pp(pp);
 +    pcie = to_qcom_pcie(pci);
 +
 +    if (pcie->msi_irqs[i] == irq)
 +      return true;
 +
 +    return false;
 +  }

Maybe that's more complicated than it's worth.

> +
> +	if (WARN_ON_ONCE(unlikely(idx == num_ctrls)))
> +		goto out;
> +
> +	status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> +				   (idx * MSI_REG_CTRL_BLOCK_SIZE));
> +	if (!status)
> +		goto out;
> +
> +	val = status;
> +	pos = 0;
> +	while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
> +				    pos)) != MAX_MSI_IRQS_PER_CTRL) {
> +		generic_handle_domain_irq(pp->irq_domain,
> +					  (idx * MAX_MSI_IRQS_PER_CTRL) +
> +					  pos);
> +		pos++;
> +	}
> +
> +out:
> +	chained_irq_exit(chip, desc);
> +}
