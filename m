Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302074AAF7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 08:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGGGKZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGGGKY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 02:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43271183;
        Thu,  6 Jul 2023 23:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE72617AE;
        Fri,  7 Jul 2023 06:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57532C433C7;
        Fri,  7 Jul 2023 06:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688710222;
        bh=hwZb9xiL6+BjFphaC0EJk5hRu7h8UZMN+RbscB3yoAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkwLO/k5i1CdBBRDGSXH1ggbN7ZfJf9EmBPhwvHAt7ATX85SEuzfXde7sPJ33CWAz
         6R1Syfot09dRyGyEQ/Epf7KK6QTs2WSnlw+i1+LFt768Iyp6CLBPgU8BD8dz+h8Iep
         +pmDQ73JO36g3E/Pj/raFNWF0ovCPoHxpyrHfZLtNKCLS3x2m6JsFth2WF+AKfXJHD
         cT5z3/Nrwups8uoJ7KgFm5bbi7PEcztlTTRa77RdNe5XtCBWeQml4ysaXpc+PnLbgf
         MZr/jIGNEbJcYrIrUqfMdCuBQYBnFcu42PGaqa2dycvqo4V/B+5Zi9p7jkVxi9puKR
         iBzqG0SG3wWVQ==
Date:   Fri, 7 Jul 2023 11:40:05 +0530
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
Subject: Re: [PATCH v2 6/8] PCI: qcom: ep: Add wake up host op to
 dw_pcie_ep_ops
Message-ID: <20230707061005.GE6001@thinkpad>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-7-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688122331-25478-7-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 04:22:09PM +0530, Krishna chaitanya chundru wrote:

Subject prefix should be "PCI: qcom-ep:"

> Add wakeup host op to dw_pcie_ep_ops to wake up host.
> If the EPF asks to send PME trigger the inband PME by writing
> into the parf registers otherwise toggle wake signal.
> 

If the wakeup type is PME, then trigger inband PME by writing to the PARF
PARF_PM_CTRL register, otherwise toggle #WAKE.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index e75aec4..e382b4b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -89,6 +89,7 @@
>  /* PARF_PM_CTRL register fields */
>  #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
>  #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
> +#define PARF_PM_CTRL_XMT_PME			BIT(4)
>  #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
>  
>  /* PARF_MHI_CLOCK_RESET_CTRL fields */
> @@ -729,10 +730,40 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  }
>  
> +static int qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no,
> +					enum pci_epc_wakeup_host_type type)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> +	struct device *dev = pci->dev;
> +	u32 val;
> +
> +	if (type == PCI_WAKEUP_TOGGLE_WAKE) {
> +		dev_dbg(dev, "Waking up the host by toggling WAKE#\n");
> +		gpiod_set_value_cansleep(pcie_ep->wake, 1);
> +		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
> +		gpiod_set_value_cansleep(pcie_ep->wake, 0);
> +		return 0;
> +
> +	} else if (type == PCI_WAKEUP_SEND_PME) {
> +		dev_dbg(dev, "Waking up the host using PME\n");
> +		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> +		val |= PARF_PM_CTRL_XMT_PME;
> +		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
> +
> +	} else {
> +		dev_err(dev, "Device is not in D3 state wakeup is not supported\n");
> +		return -EOPNOTSUPP;

This is not needed if you use bool. And this debug message is wrong btw since
you are not checking whether the device is in D3 state or not.

- Mani

> +	}
> +
> +	return 0;
> +}
> +
>  static const struct dw_pcie_ep_ops pci_ep_ops = {
>  	.ep_init = qcom_pcie_ep_init,
>  	.raise_irq = qcom_pcie_ep_raise_irq,
>  	.get_features = qcom_pcie_epc_get_features,
> +	.wakeup_host = qcom_pcie_ep_wakeup_host,
>  };
>  
>  static int qcom_pcie_ep_probe(struct platform_device *pdev)
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
