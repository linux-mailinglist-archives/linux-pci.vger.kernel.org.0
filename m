Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436E37662E4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 06:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjG1EPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 00:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjG1EPt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 00:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E333598;
        Thu, 27 Jul 2023 21:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE0661FB5;
        Fri, 28 Jul 2023 04:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2A1C433C9;
        Fri, 28 Jul 2023 04:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690517746;
        bh=uH8VFr7PeChbgzJrr2mwwSuOJ/3AVRBPlJ8m/IOPBjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEWGq2uqci2gSjF8uLCwMKX5qsyt2STSWANftGBB2440zZJPhSEDrMaMztyoTqzWz
         YoCvpRxZ4MPc7YPtzG595vJ8vp9h3Fujvd54w/xztnXasKdHFOgI/90Y1GCUeylEAv
         3BTRO3fZeNBw1sdb1YGYqoMMHjtNvzVSMPnD1RgpeKZK6lozwgyO1HRvz4iCyjlFG8
         7lcFFx7aYyNR1+TQT2f2Wbq/Bv2VSwD9EHK2eY166OYfngfKLwKae7KpKLnjLI2gwx
         xnwM294Pytl6NGile/oUiiOh3XWPmtUAINGDba5m4MyUBpO4dgda9TyQN51/Qwmqw8
         2cdC+UT0eFWzg==
Date:   Fri, 28 Jul 2023 09:45:37 +0530
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
Subject: Re: [PATCH v4 4/9] PCI: qcom-ep: Update the D-state log
Message-ID: <20230728041537.GG4433@thinkpad>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-5-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689232218-28265-5-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 13, 2023 at 12:40:13PM +0530, Krishna chaitanya chundru wrote:
> Updated the D-state log which prints in D-state in string format.
> 

How about:

"Now that the state event is stored as pci_power_t, let's use the PCI helper
pci_power_name() to print the state event."

Also, this patch should be sent ahead of previous patch.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 66fd421..75ab6d6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -583,7 +583,6 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	} else if (FIELD_GET(PARF_INT_ALL_DSTATE_CHANGE, status)) {
>  		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>  					   DBI_CON_STATUS_POWER_STATE_MASK;
> -		dev_dbg(dev, "Received D%d state event\n", dstate);
>  		state = dstate;
>  		if (dstate == 3) {
>  			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> @@ -593,6 +592,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  			if (gpiod_get_value(pcie_ep->reset))
>  				state = PCI_D3cold;
>  		}
> +		dev_dbg(dev, "Received D-state:%s event\n", pci_power_name(state));

dev_dbg(dev, "Received %s event\n", pci_power_name(state));

- Mani

>  		pci_epc_dstate_notify(pci->ep.epc, state);
>  	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>  		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
