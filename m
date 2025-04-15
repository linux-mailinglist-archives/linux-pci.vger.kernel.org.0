Return-Path: <linux-pci+bounces-25916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCCEA895D6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 09:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976DB7A4BC4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8124C086;
	Tue, 15 Apr 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaaGi+Or"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8C27A117
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703972; cv=none; b=e3yX7MNsPSFy0dwddLhZlyB0mFVh2tmIpzQnd+SIskKTlBqUCv4a58XPOX28FkqibNMShsDndyKw6VaqLpKvuk8bGtblZhNVc3L2aub/wZt2FpP95MboAktk+dIgFTgoXO377lM2g9Z9O1fO7p13MF1FvtAikU6mcWdgBnxU+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703972; c=relaxed/simple;
	bh=mbyIlrnTFMEaBucKW56BO1bsVEUz4eMIVcBi9YQ4IC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl19PXEOGx+kuQa4ZCSWitTZ+o4o7DifGMzUTmA1WZyPq66ML0QYZZaupAse7BfMjFlSNupq4zpuoxdbckgMBJmjToKnXRhiuf9Q/4Tz3cjxnMs0bT+ZM2U9wP/qHJwbB3FhDbmTozQf24AsGLUGevhoUtlmWZVu7IV46iCcUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kaaGi+Or; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227c7e57da2so45744105ad.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744703969; x=1745308769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G28Yd2YUW/f1H73Kb4ZerwrkOpL39DDqqeZI1q72GTc=;
        b=kaaGi+OrU7x3BeFZvv9cCqJnlh0i9ah7M5upVeRLo3cIQI+xPV6iUtx1tuGkraosZh
         ind7NcIjhO0Ug61w1PBXpyI0pICNy3SbME6JOtg2ZN1HMmTK7ATXQ5HGAxKTbRCGtJxd
         27nLC4c2Z7E1n3cVHVZfVeuE3Q/0iQPlNwZAVQNuer3ZMltLKnMs+/KUpGvLa6wZ+GMR
         3vvK89R1XKODoNXYtULmCN1LZLXt9i4f6VfzAO4dgULglxugi+kQNsMUZE7SNKKWdPYP
         higl6+mImtIrZdsLKmlKZo/Vyi+ckZT0qFks6X0opisdlwb/rynN/gpy9K+rVhOb0JXM
         oM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703969; x=1745308769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G28Yd2YUW/f1H73Kb4ZerwrkOpL39DDqqeZI1q72GTc=;
        b=DCMW5VfQpZo3BgxUEQNdhw+P+FSZBemM6GifEtkVUmrr1g0v+MxTUULZwVU1BM2AQg
         7ao3rOfm66HChKkzAhciCtg+sPzCl2zFvkc3Z3XH13zws4u8FZ7/MRwkihZgxnfh/jnB
         M6PNQXkIi9oCQzCgp+pXEnHBlYtuirDs1H0EwKxRpr6TsNy421s0yYQMrKNYwARQp0dU
         M0w5enF2gMW+itXnZYLzNaGvv+LrWQcDauyWqPx4s+HguEAyejqC3sOsUZcfsjQS2QOy
         102PtceFi9lR/3YSQt8OEGeam45GEiWLcjOoA/Uwucv1ALWhG+t8UfaXy6B4HrCOdWnb
         eZMw==
X-Forwarded-Encrypted: i=1; AJvYcCUHHctY4LN6bKUuGJVDHRvEV2nBC0Y3SFbqdF5Cow0BxQxlV5nwfcjkTzpaiC2eVlaJFElSe6mw91c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuwHPk/iLhfDFSxzm8RZaZ6MUgY0QuC6T7374MhfRWGC0vzJB
	Ja8WGktYa70bB995/xhjzGTlB538FNfovgGb38BStGhf2xoj9llIWZFiR2M5fQ==
X-Gm-Gg: ASbGncs7RVGdWnoxG+uJUASn8HRq2sSB6Cct0neWyqjc980232XJhCtOvcQipg296GN
	m0jbP+eNZIOGXVBY9fb7HR3OfI7XBU7BeV3pg4uWGgt4/B8Kmd+3CKstjzpAaBM3H5OJf5k+Sof
	lPnW9m/GqfpA7pkpUxT+HZciTLOrECftD+iDUxaUFAvgWFMyQC/cqVdPDdtocex7HhcYB/N7gCA
	6jWNHSgPnzEFO/OD8/aFMGn/RuyL0fgDLjAyF4TY3VE41RBaRZXAJfCTVozM1sWJSv7tYNFCyTc
	kE3jht1qdXbrgnTNLjSCCy+kWLu7MIl5RMVnUmMhKSJIeO3d9w==
X-Google-Smtp-Source: AGHT+IG8uAJ0rXIi1LWS3C08UCWmLhLn27A9y4ex/em6Wm3kazTn66Ldm1uP5agXCrSfm3CegdBK9g==
X-Received: by 2002:a17:902:d4cf:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-22bea4b328amr247928465ad.12.1744703969523;
        Tue, 15 Apr 2025 00:59:29 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm12628978a91.12.2025.04.15.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:59:29 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:29:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v2 3/3] PCI: qcom: Add support for multi-root port
Message-ID: <racomxxb467xteo5ihavi7kga5ygecxz3cy3pekviartlo3m25@i7jzgj26jkyd>
References: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
 <20250414-perst-v2-3-89247746d755@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414-perst-v2-3-89247746d755@oss.qualcomm.com>

On Mon, Apr 14, 2025 at 11:09:14AM +0530, Krishna Chaitanya Chundru wrote:
> Move phy, perst handling to root port and provide a way to have multi-port
> logic.
> 
> Currently, qcom controllers only support single port, and all properties
> are present in the controller node itself. This is incorrect, as
> properties like phy, perst, wake, etc. can vary per port and should be
> present in the root port node.
> 

Mention the fact that you are preserving DT backwards compatibility by
continuing to support older DTs which stuff these properties in controller node.

> pci-bus-common.yaml uses reset-gpios property for representing PERST, use
> same property instead of perst-gpios.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 149 +++++++++++++++++++++++++++------
>  1 file changed, 123 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index dc98ae63362db0422384b1879a2b9a7dc564d091..5566c8aa7f9a9928c06aa6284ca4de21cc411874 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -262,6 +262,11 @@ struct qcom_pcie_cfg {
>  	bool no_l0s;
>  };
>  
> +struct qcom_pcie_port {
> +	struct list_head list;
> +	struct gpio_desc *reset;
> +	struct phy *phy;
> +};
>  struct qcom_pcie {
>  	struct dw_pcie *pci;
>  	void __iomem *parf;			/* DT parf */
> @@ -276,21 +281,36 @@ struct qcom_pcie {
>  	struct dentry *debugfs;
>  	bool suspended;
>  	bool use_pm_opp;
> +	struct list_head ports;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
> -	gpiod_set_value_cansleep(pcie->reset, 1);
> +	struct qcom_pcie_port *port, *tmp;
> +
> +	if (list_empty(&pcie->ports))
> +		gpiod_set_value_cansleep(pcie->reset, 1);
> +	else
> +		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +			gpiod_set_value_cansleep(port->reset, 1);
> +
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
>  static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>  {
> +	struct qcom_pcie_port *port, *tmp;
> +
>  	/* Ensure that PERST has been asserted for at least 100 ms */
>  	msleep(100);
> -	gpiod_set_value_cansleep(pcie->reset, 0);
> +	if (list_empty(&pcie->ports))
> +		gpiod_set_value_cansleep(pcie->reset, 0);
> +	else
> +		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +			gpiod_set_value_cansleep(port->reset, 0);

Looks like you can use a helper here (for both assert and deassert).

> +
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
> @@ -1229,10 +1249,19 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
>  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
>  }
>  
> +static void qcom_pcie_port_phy_off(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_port *port, *tmp;
> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		phy_power_off(port->phy);
> +}
> +
>  static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	struct qcom_pcie_port *port, *tmp;
>  	int ret;
>  
>  	qcom_ep_reset_assert(pcie);
> @@ -1241,13 +1270,27 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> -	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> -	if (ret)
> -		goto err_deinit;
> +	if (list_empty(&pcie->ports)) {
> +		ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +		if (ret)
> +			goto err_deinit;
>  
> -	ret = phy_power_on(pcie->phy);
> -	if (ret)
> -		goto err_deinit;
> +		ret = phy_power_on(pcie->phy);
> +		if (ret)
> +			goto err_deinit;
> +	} else {
> +		list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +			ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +			if (ret)
> +				goto err_deinit;
> +
> +			ret = phy_power_on(port->phy);
> +			if (ret) {
> +				qcom_pcie_port_phy_off(pcie);
> +				goto err_deinit;
> +			}
> +		}
> +	}

Again, you should consider introducing helpers wherever both multiport and
legacy methods are used. This will avoid sprinkling the list_empty() checks all
over the place.

>  
>  	if (pcie->cfg->ops->post_init) {
>  		ret = pcie->cfg->ops->post_init(pcie);
> @@ -1268,7 +1311,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  err_assert_reset:
>  	qcom_ep_reset_assert(pcie);
>  err_disable_phy:
> -	phy_power_off(pcie->phy);
> +	if (list_empty(&pcie->ports))
> +		phy_power_off(pcie->phy);
> +	else
> +		qcom_pcie_port_phy_off(pcie);
>  err_deinit:
>  	pcie->cfg->ops->deinit(pcie);
>  
> @@ -1281,7 +1327,10 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
>  	qcom_ep_reset_assert(pcie);
> -	phy_power_off(pcie->phy);
> +	if (list_empty(&pcie->ports))
> +		phy_power_off(pcie->phy);
> +	else
> +		qcom_pcie_port_phy_off(pcie);
>  	pcie->cfg->ops->deinit(pcie);
>  }
>  
> @@ -1579,11 +1628,41 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
> +{
> +	struct device *dev = pcie->pci->dev;
> +	struct qcom_pcie_port *port;
> +	struct gpio_desc *reset;
> +	struct phy *phy;
> +
> +	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> +				      "reset", GPIOD_OUT_HIGH, "PERST#");
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	phy = devm_of_phy_get(dev, node, NULL);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->reset = reset;
> +	port->phy = phy;
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);
> +
> +	return 0;
> +}
> +
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;
>  	unsigned long max_freq = ULONG_MAX;
> +	struct qcom_pcie_port *port, *tmp;
>  	struct device *dev = &pdev->dev;
> +	struct device_node *of_port;
>  	struct dev_pm_opp *opp;
>  	struct qcom_pcie *pcie;
>  	struct dw_pcie_rp *pp;
> @@ -1611,6 +1690,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_pm_runtime_put;
>  
> +	INIT_LIST_HEAD(&pcie->ports);
> +
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
> @@ -1619,12 +1700,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->cfg = pcie_cfg;
>  
> -	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> -	if (IS_ERR(pcie->reset)) {
> -		ret = PTR_ERR(pcie->reset);
> -		goto err_pm_runtime_put;
> -	}
> -
>  	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
>  	if (IS_ERR(pcie->parf)) {
>  		ret = PTR_ERR(pcie->parf);
> @@ -1647,12 +1722,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	pcie->phy = devm_phy_optional_get(dev, "pciephy");
> -	if (IS_ERR(pcie->phy)) {
> -		ret = PTR_ERR(pcie->phy);
> -		goto err_pm_runtime_put;
> -	}
> -
>  	/* OPP table is optional */
>  	ret = devm_pm_opp_of_add_table(dev);
>  	if (ret && ret != -ENODEV) {
> @@ -1699,9 +1768,31 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pp->ops = &qcom_pcie_dw_ops;
>  
> -	ret = phy_init(pcie->phy);
> -	if (ret)
> -		goto err_pm_runtime_put;
> +	for_each_child_of_node(dev->of_node, of_port) {

I think we should just iterate over enabled nodes instead of disabled ones also.
So use 'for_each_available_child_of_node'.

> +		ret = qcom_pcie_parse_port(pcie, of_port);
> +		of_node_put(of_port);
> +		if (ret)
> +			break;
> +	}
> +
> +	/* Fallback to previous method */

	/*
	 * In the case of failure in parsing the port nodes, fallback to the
	 * legacy method of parsing the controller node. This is to maintain DT
	 * backwards compatibility.
	 */

- Mani

-- 
மணிவண்ணன் சதாசிவம்

