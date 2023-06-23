Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4BA73B0A6
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 08:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFWGS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 02:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFWGSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 02:18:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62970189;
        Thu, 22 Jun 2023 23:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B8F61988;
        Fri, 23 Jun 2023 06:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EFBC433C0;
        Fri, 23 Jun 2023 06:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687501133;
        bh=OhAcmxvQIZSLKJdX6Slkll6dY3L+01o3voqnmE4tALo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgd9wDIpuOoTdcPBctQKlD5bqnEQb2Sy+RCFfvDHDKfVWdD3uZhvHKIclbSp2bD36
         Lhc1xKFz/2FDPm9II/O10T2vipd486FCVOq/XcaK/VRYueRBMJw2ta8cp2QLdT4UId
         HjMzSNOKlTLvXvjLJ5IkrRBqCrkxGgK78EbetWFkZ228ABjknQ/VYYMiMpOX9sx86l
         iiU1CYfhIkNBFEJPJhafe8SdmzAF2PffM85ZJLul27INGj6Negx30uUiMMOl4oeAHQ
         l7BuXO4BpKiHcVGCZcsbPJ2I6J2rMU7YTjbpwGg9K/NImENT6Tnn7iebhZxh69PLaV
         /OOvqlKNNmawg==
Date:   Fri, 23 Jun 2023 11:48:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v1 3/3] PCI: qcom: ep: Add wake up host op to
 dw_pcie_ep_ops
Message-ID: <20230623061839.GC5611@thinkpad>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
 <1686754850-29817-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1686754850-29817-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 14, 2023 at 08:30:49PM +0530, Krishna chaitanya chundru wrote:
> Add wakeup host op to dw_pcie_ep_ops to wake up host from D3cold
> or D3hot.
> 

Commit message should describe how the wakeup is implemented in the driver.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 34 +++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 5d146ec..916a138 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -91,6 +91,7 @@
>  /* PARF_PM_CTRL register fields */
>  #define PARF_PM_CTRL_REQ_EXIT_L1		BIT(1)
>  #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
> +#define PARF_PM_CTRL_XMT_PME			BIT(4)
>  #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
>  
>  /* PARF_MHI_CLOCK_RESET_CTRL fields */
> @@ -794,10 +795,43 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  }
>  
> +static int qcom_pcie_ep_wakeup_host(struct dw_pcie_ep *ep, u8 func_no)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> +	struct device *dev = pci->dev;
> +	u32 perst, dstate, val;
> +
> +	perst = gpiod_get_value(pcie_ep->reset);
> +	/* Toggle wake GPIO when device is in D3 cold */
> +	if (perst) {
> +		dev_info(dev, "Device is in D3 cold toggling wake\n");

dev_dbg(). "Waking up the host by toggling WAKE#"

> +		gpiod_set_value_cansleep(pcie_ep->wake, 1);

Waking a device from D3cold requires power-on sequence by the host and in the
presence of Vaux, the EPF should be prepared for that. In that case, the mode of
wakeup should be decided by the EPF driver. So the wakeup API should have an
argument to decide whether the wakeup is through PME or sideband WAKE#.

Also note that as per PCIe Spec 3.0, the devices can support PME generation from
D3cold provided that the Vaux is supplied to the device. I do not know if that
is supported by Qcom devices but API should honor the spec. So the wakeup
control should come from EPF driver as I suggested above.

> +		usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
> +		gpiod_set_value_cansleep(pcie_ep->wake, 0);
> +		return 0;
> +	}
> +
> +	dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
> +				   DBI_CON_STATUS_POWER_STATE_MASK;
> +	if (dstate == 3) {
> +		dev_info(dev, "Device is in D3 hot sending inband PME\n");

dev_dbg(). As I said, the device can sent PME from D3cold also. So the log could
be "Waking up the host using PME".

> +		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> +		val |= PARF_PM_CTRL_XMT_PME;
> +		writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
> +	} else {
> +		dev_err(dev, "Device is not in D3 state wakeup is not supported\n");
> +		return -EPERM;

-ENOTSUPP

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
