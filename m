Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FA274AAC9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 07:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjGGFwL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 01:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjGGFvs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 01:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4BA2686;
        Thu,  6 Jul 2023 22:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DDF61652;
        Fri,  7 Jul 2023 05:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401CDC433C9;
        Fri,  7 Jul 2023 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688709097;
        bh=Qj31jtQ+hz+K7R2TBC5oSAupfXV4EUMpsex+zxUEQmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LShkrSAWi9pb43EVbEGdVFj/xP5x3WOfGQhRfRyNupEDa12wYUvmjoRu9YFelPFlf
         JVhZqEjpUlXaMx91KdzlUO5rc5Hp1Kv+WCydSNu9ZV7SN8N+wPy3RuRwopo6TSeCMu
         oZAMdSv3rCAlNK6fbbhT0S7IEzVVE81RgHtpIAIM1GK+/P+KBj+k3RIgwwwBgQTBDf
         bIIh2HexHyoyBhChm1Q0HE//IsNLXPwmjLJpr2eHALHMXnKQJAAfWRGHc6rR8xPI/d
         jupHouDWUuA9TgWPZdeF+lit012gKduXtTaxEb4xhajwjJ+YIWkSp3R0/DQqO+b/5x
         L7dafIhRo7NSg==
Date:   Fri, 7 Jul 2023 11:21:21 +0530
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
Subject: Re: [PATCH v2 2/8] PCI: qcom-ep: Add support for D-state change
 notification
Message-ID: <20230707055121.GB6001@thinkpad>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688122331-25478-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 04:22:05PM +0530, Krishna chaitanya chundru wrote:
> Add support to pass D-state change notification to Endpoint
> function driver.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Few comments below.

> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 1435f51..e75aec4 100644
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

We should also change this debug output to make use of pci_power_name() based on
the "state" variable and move it just above pci_epc_dstate_change(). But this
should be a separate patch.

> +		state = dstate;
>  		if (dstate == 3) {
>  			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>  			val |= PARF_PM_CTRL_REQ_EXIT_L1;
>  			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
> +			state = PCI_D3hot;
> +			if (gpiod_get_value(pcie_ep->reset))
> +				state = PCI_D3cold;
>  		}
> +		pci_epc_dstate_change(pci->ep.epc, state);

Need to change this API as per my comment on patch 1.

- Mani

>  	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>  		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>  		dw_pcie_ep_linkup(&pci->ep);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
