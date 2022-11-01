Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07B36149B5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 12:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKALrL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiKALqv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 07:46:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5B1AF18;
        Tue,  1 Nov 2022 04:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20458B81CD5;
        Tue,  1 Nov 2022 11:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C494C433C1;
        Tue,  1 Nov 2022 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667302742;
        bh=lbB96mj70AgIpEUP840h3pERYilupgXuqFOiFELd0z0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nUTxWiXi9CTxTo3fSllJvcWh+IPCtXES5icAKaVRQu1TcyixwG5l/CrFTvC8DoEJe
         /gNn6sH1UiyC37U0S94Lgvb7Ii+IasJyUl6yd82OF4T0Liqub+QLEBWES67OXqi3A0
         7iHc3cHRr2VtsiO0EPgTzfUhpx1LYwLA+LfNTViqwBilvaWxtl/KqTOijhnrLeDQ+/
         nPzuaaDMyRPaYhm2oXy8qwteYZ9HvFFElPOoFNOqFMjedWqK9Mgm7wsv78ckZhwWVK
         arojVAd6K7+oqKtDoSB4kLurgABVNJV7lNdUwbnqCBEhWbXpyCoS4mpKd3yE+N1k2I
         nrTfy4P4p9bXg==
Message-ID: <fb862f47-ecaa-5d4a-b3b8-0b1f2681b7c5@kernel.org>
Date:   Tue, 1 Nov 2022 13:38:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add basic interconnect support
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        stanimir.k.varbanov@gmail.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021064616.6380-1-johan+linaro@kernel.org>
 <20221021064616.6380-3-johan+linaro@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20221021064616.6380-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the patches, Johan!

On 21.10.22 9:46, Johan Hovold wrote:
> On Qualcomm platforms like SC8280XP and SA8540P, interconnect bandwidth
> must be requested before enabling interconnect clocks.
> 
> Add basic support for managing an optional "pcie-mem" interconnect path
> by setting a low constraint before enabling clocks and updating it after
> the link is up.
> 
> Note that it is not possible for a controller driver to set anything but
> a maximum peak bandwidth as expected average bandwidth will vary with
> use case and actual use (and power policy?). This very much remains an
> unresolved problem with the interconnect framework.
> 
> Also note that no constraint is set for the SC8280XP/SA8540P "cpu-pcie"
> path for now as it is not clear what an appropriate constraint would be
> (and the system does not crash when left unspecified).
> 
> Fixes: 70574511f3fc ("PCI: qcom: Add support for SC8280XP")
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Georgi Djakov <djakov@kernel.org>

Also CC-ing Stan's new e-mail address.

Thanks,
Georgi

> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 76 ++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7db94a22238d..0c13f976626f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -12,6 +12,7 @@
>   #include <linux/crc8.h>
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/interconnect.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
> @@ -224,6 +225,7 @@ struct qcom_pcie {
>   	union qcom_pcie_resources res;
>   	struct phy *phy;
>   	struct gpio_desc *reset;
> +	struct icc_path *icc_mem;
>   	const struct qcom_pcie_cfg *cfg;
>   };
>   
> @@ -1644,6 +1646,74 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>   	.start_link = qcom_pcie_start_link,
>   };
>   
> +static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	int ret;
> +
> +	pcie->icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> +	if (IS_ERR(pcie->icc_mem)) {
> +		ret = PTR_ERR(pcie->icc_mem);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */
> +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 offset, status, bw;
> +	int speed, width;
> +	int ret;
> +
> +	if (!pcie->icc_mem)
> +		return;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	/* Only update constraints if link is up. */
> +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +		return;
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	switch (speed) {
> +	case 1:
> +		bw = MBps_to_icc(250);
> +		break;
> +	case 2:
> +		bw = MBps_to_icc(500);
> +		break;
> +	default:
> +	case 3:
> +		bw = MBps_to_icc(985);
> +		break;
> +	}
> +
> +	ret = icc_set_bw(pcie->icc_mem, 0, width * bw);
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +	}
> +}
> +
>   static int qcom_pcie_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -1704,6 +1774,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   		goto err_pm_runtime_put;
>   	}
>   
> +	ret = qcom_pcie_icc_init(pcie);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
>   	ret = pcie->cfg->ops->get_resources(pcie);
>   	if (ret)
>   		goto err_pm_runtime_put;
> @@ -1722,6 +1796,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   		goto err_phy_exit;
>   	}
>   
> +	qcom_pcie_icc_update(pcie);
> +
>   	return 0;
>   
>   err_phy_exit:

