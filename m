Return-Path: <linux-pci+bounces-3763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1385BC31
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF005B22425
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E0969977;
	Tue, 20 Feb 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FQcnko7R"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EEF44373;
	Tue, 20 Feb 2024 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432268; cv=none; b=qBgrhUhXV9W2Ao4VyX8wZGm8hMwv23zdy4l20eZnIREPQ3xa6qHX16Q4CVsIy8izJtJxQwGM64aZUiKFyKJAUBf11GT2vt2yl6JctU3MXcb+wMax9jjkJ31X0MTcZ7BVM7GVckhKzWk5FprlToFqMy4/IpSiRpF88oomB/7ZlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432268; c=relaxed/simple;
	bh=PQqamGZppq5o6Qqr8I3GU1b0V/YNU2o8dzbd0n79mQs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXEVmyOuv4dVrGvlwrcQLcZYlvDrf7RmomQ3XnDT1ZNIwmW9U6Zd6ASZ9E5FjPfRXReyDuafD1pdpxdHAluDc9P/qfgyV1yx0xNDCP4smbBvfcUmunPRIh4oV9LdieteNOPnAscdu+rxPggmX1v0rgWF06lk40GmxGofr+bEcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FQcnko7R; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KCUnX0092634;
	Tue, 20 Feb 2024 06:30:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708432249;
	bh=X2TNTFiXe9xfD+D7kqdm/A0TrDMIgtFiMCyCVu1JtIY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FQcnko7R/a5J6gZDSYHAZ7XLx0BkHKkurR5koB+hQYCPo1ySDn3ZCWpdsfzqs7HxY
	 yXdH7RPdGisnHbhrinHMXj6M6JiyYLaWw9zBvExfenEXJL3uqCNKGCj73nbgek598q
	 chbc2oGroeEDM/2DdGwzZn0+YuolTZM+cc9jFYDI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KCUn9W017384
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 06:30:49 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 06:30:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 06:30:49 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KCUmfT099249;
	Tue, 20 Feb 2024 06:30:49 -0600
Date: Tue, 20 Feb 2024 18:00:48 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut
	<marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 4/5] PCI: qcom-ep: Add HDMA support for SA8775P SoC
Message-ID: <85374225-287f-4f2a-998b-a1ef997da268@ti.com>
References: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
 <20240216-dw-hdma-v2-4-b42329003f43@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240216-dw-hdma-v2-4-b42329003f43@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 24/02/16 11:04PM, Manivannan Sadhasivam wrote:
> From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> 
> SA8775P SoC supports the new Hyper DMA (HDMA) DMA Engine inside the DWC IP.
> Let's add support for it by passing the mapping format and the number of
> read/write channels count.
> 
> The PCIe EP controller used on this SoC is of version 1.34.0, so a separate
> config struct is introduced for the sake of enabling HDMA conditionally.
> 
> It should be noted that for the eDMA support (predecessor of HDMA), there
> are no mapping format and channels count specified. That is because eDMA
> supports auto detection of both parameters, whereas HDMA doesn't.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> [mani: Reworded commit message, added kdoc, and minor cleanups]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 45008e054e31..89d06a3e6e06 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -149,6 +149,14 @@ enum qcom_pcie_ep_link_status {
>  	QCOM_PCIE_EP_LINK_DOWN,
>  };
>  
> +/**
> + * struct qcom_pcie_ep_cfg - Per SoC config struct
> + * @hdma_support: HDMA support on this SoC
> + */
> +struct qcom_pcie_ep_cfg {
> +	bool hdma_support;
> +};
> +
>  /**
>   * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
>   * @pci: Designware PCIe controller struct
> @@ -803,6 +811,7 @@ static const struct dw_pcie_ep_ops pci_ep_ops = {
>  
>  static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  {
> +	const struct qcom_pcie_ep_cfg *cfg;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_pcie_ep *pcie_ep;
>  	char *name;
> @@ -816,6 +825,14 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  	pcie_ep->pci.ops = &pci_ops;
>  	pcie_ep->pci.ep.ops = &pci_ep_ops;
>  	pcie_ep->pci.edma.nr_irqs = 1;
> +
> +	cfg = of_device_get_match_data(dev);
> +	if (cfg && cfg->hdma_support) {
> +		pcie_ep->pci.edma.ll_wr_cnt = 8;
> +		pcie_ep->pci.edma.ll_rd_cnt = 8;
> +		pcie_ep->pci.edma.mf = EDMA_MF_HDMA_NATIVE;
> +	}
> +
>  	platform_set_drvdata(pdev, pcie_ep);
>  
>  	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
> @@ -874,8 +891,12 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
>  	qcom_pcie_disable_resources(pcie_ep);
>  }
>  
> +static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
> +	.hdma_support = true,
> +};
> +
>  static const struct of_device_id qcom_pcie_ep_match[] = {
> -	{ .compatible = "qcom,sa8775p-pcie-ep", },
> +	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>  	{ .compatible = "qcom,sm8450-pcie-ep", },
>  	{ }
> 
> -- 
> 2.25.1
> 
> 

