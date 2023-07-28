Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA77662AD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 05:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjG1D5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 23:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjG1D5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 23:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D52D64;
        Thu, 27 Jul 2023 20:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1732361FA2;
        Fri, 28 Jul 2023 03:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB637C433C8;
        Fri, 28 Jul 2023 03:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690516661;
        bh=Wr4rn9Z46tsAaKd/EBJgh+7aUpkBCah5+HYfJ+AcNJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjD8+ykb3lknuHS1JP+ECFvx6jp8tng92qIm8DIwrjHrspC1JfmsTszaxl2XMJ20A
         DyzCH6Q83Tzi7TTigJUGcK7XgcQFD68Iq9ObxhCBWiba/Mx96MG//Ue5zVYXtUvdqc
         OAlxXjEb7h9t9Bk5Y/hMHBRm62CwDyaG+HO73gno8qWAbWSdNBL7zJ8hAM+DCrclvp
         nEBa7GA01rsUnZSm+7j2/n3ercIHxV0TJ9iiSX2xIvzezu+TBKeVpwyTQS9i/xmq05
         LuMu+wxz39HD3I/Y4lyL7puVZ9xrJo1LPASmYBDKMOBv6OSgVJ0bmXLduDC8VJbxZf
         VJN4QC+cziC9A==
Date:   Fri, 28 Jul 2023 09:27:31 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 2/9] PCI: qcom-ep: Add support for D-state change
 notification
Message-ID: <20230728035731.GE4433@thinkpad>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689232218-28265-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 13, 2023 at 12:40:11PM +0530, Krishna chaitanya chundru wrote:
> Add support to pass D-state change notification to Endpoint
> function driver.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

One nit below:

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 0fe7f06..66fd421 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -561,6 +561,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	struct device *dev = pci->dev;
>  	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
>  	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
> +	pci_power_t state;
>  	u32 dstate, val;
>  
>  	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
> @@ -583,11 +584,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>  					   DBI_CON_STATUS_POWER_STATE_MASK;
>  		dev_dbg(dev, "Received D%d state event\n", dstate);
> +		state = dstate;
>  		if (dstate == 3) {
>  			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>  			val |= PARF_PM_CTRL_REQ_EXIT_L1;
>  			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);

Newline here.

- Mani

> +			state = PCI_D3hot;
> +			if (gpiod_get_value(pcie_ep->reset))
> +				state = PCI_D3cold;
>  		}
> +		pci_epc_dstate_notify(pci->ep.epc, state);
>  	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>  		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>  		dw_pcie_ep_linkup(&pci->ep);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
