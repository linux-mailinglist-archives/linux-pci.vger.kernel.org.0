Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F236B21CE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 11:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCIKrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 05:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCIKqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 05:46:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E41720A1F;
        Thu,  9 Mar 2023 02:46:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D26EB81ED3;
        Thu,  9 Mar 2023 10:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56B6C433D2;
        Thu,  9 Mar 2023 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678358804;
        bh=Kx8JrIEBCDpyV5UPrP+4xnSL/3UnrQPCBmZ7NBusVHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ituxghn+9yrt3mfPxAZTut59s4ozydCG8VFCWXXmvFX7p87kxZXX+hDP/k3zgW91D
         hqpfXEKENysSemVs0CkHB+24lJQ/B338Wodty7aGyzHFIiAmiehnLynmb+FzT2Ja4v
         PnDNL8fZLDzNkPznqeg1GXyIlk+MNCPEhXVBJtcKMHZcnBJf0xRhvDkyOdxmXZ9owe
         TQ5GvaSpB/ebEtsCIx8nKfRJzpWD4t/D2QHGs5b9lfmH8P8OcGvHIxUpYBQnpjyx3y
         2eYDpnA60cvSEB4Pq9bu8c+ElKYPYAjntrvna0swLA7ZqkBrhhNV9mHQkhxXtCeuOm
         edenWjnr9TjKQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1paDo4-0005L9-Nt; Thu, 09 Mar 2023 11:47:33 +0100
Date:   Thu, 9 Mar 2023 11:47:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v2 1/1] PCI: qcom: Add support for system suspend and
 resume
Message-ID: <ZAm5RPdn5PmaJzVO@hovoldconsulting.com>
References: <20230302083625.188482-1-manivannan.sadhasivam@linaro.org>
 <20230302083625.188482-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302083625.188482-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 02, 2023 at 02:06:25PM +0530, Manivannan Sadhasivam wrote:
> During the system suspend, vote for minimal interconnect bandwidth and
> also turn OFF the resources like clock and PHY if there are no active
> devices connected to the controller. For the controllers with active
> devices, the resources are kept ON as removing the resources will
> trigger access violation during the late end of suspend cycle as kernel
> tries to access the config space of PCIe devices to mask the MSIs.
> 
> Also, it is not desirable to put the link into L2/L3 state as that
> implies VDD supply will be removed and the devices may go into powerdown
> state. This will affect the lifetime of storage devices like NVMe.
> 
> And finally, during resume, turn ON the resources if the controller was
> truly suspended (resources OFF) and update the interconnect bandwidth
> based on PCIe Gen speed.
> 
> Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Acked-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 53 ++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a232b04af048..7147f0103026 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -227,6 +227,7 @@ struct qcom_pcie {
>  	struct gpio_desc *reset;
>  	struct icc_path *icc_mem;
>  	const struct qcom_pcie_cfg *cfg;
> +	bool suspended;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1820,6 +1821,53 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Set minimum bandwidth required to keep data path functional during suspend */
> +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));

I can again confirm that this now passes basic smoke testing on my CRD
(unlike v1 which set bw to 0) and X13s.

> +	if (ret) {
> +		dev_err(pcie->pci->dev, "Failed to set interconnect bandwidth: %d\n", ret);

You already have a pointer to dev.

> +		return ret;
> +	}

And please try to stay within 80 columns width unless breaking it
improves readability (generally does not apply comments).

> +
> +	/*
> +	 * Turn OFF the resources only for controllers without active PCIe devices. For controllers
> +	 * with active devices, the resources are kept ON and the link is expected to be in L0/L1
> +	 * (sub)states.
> +	 *
> +	 * Turning OFF the resources for controllers with active PCIe devices will trigger access
> +	 * violation during the end of the suspend cycle, as kernel tries to access the PCIe devices
> +	 * config space for masking MSIs.
> +	 *
> +	 * Also, it is not desirable to put the link into L2/L3 state as that implies VDD supply
> +	 * will be removed and the devices may go into powerdown state. This will affect the
> +	 * lifetime of the storage devices like NVMe.
> +	 */

Same here.

> +	if (!dw_pcie_link_up(pcie->pci)) {
> +		qcom_pcie_host_deinit(&pcie->pci->pp);
> +		pcie->suspended = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_resume_noirq(struct device *dev)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +
> +	if (pcie->suspended) {
> +		qcom_pcie_host_init(&pcie->pci->pp);

Looks like error handling is missing here.

> +		pcie->suspended = false;
> +	}
> +
> +	qcom_pcie_icc_update(pcie);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> @@ -1856,12 +1904,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
>  
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
> +};
> +
>  static struct platform_driver qcom_pcie_driver = {
>  	.probe = qcom_pcie_probe,
>  	.driver = {
>  		.name = "qcom-pcie",
>  		.suppress_bind_attrs = true,
>  		.of_match_table = qcom_pcie_match,
> +		.pm = &qcom_pcie_pm_ops,
>  	},
>  };
>  builtin_platform_driver(qcom_pcie_driver);

Johan
