Return-Path: <linux-pci+bounces-36299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E5B5A1DA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 22:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CCD3BE844
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471D2D9EE5;
	Tue, 16 Sep 2025 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmBLBF6K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BED2C0268;
	Tue, 16 Sep 2025 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053303; cv=none; b=XWJGXE52SKPyNiMH8WMgVKSebkyju8m28WCw3ErfjOxvFV3lmIWY+NCj29pJQL098cpQjfFu/dslDhHMdYGlscXbwCSBJNBT3kbCdyQyWN9ZFxLFwGSnVqqpb9LNkUMflhbm/gQfHB0a5lHhXeepGvhehnWXueDeb8DLpBdg5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053303; c=relaxed/simple;
	bh=c07+nrBCBVI2N9HmL41m7c9WRz3jG1BDnxKK1KtQgvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PtaLnrF97W5NfpCPRdNtEMTLwReIOQLyh7TIMewNdFV66AJIsKv+D13WibTlDqngp2pcbKyFb5VT3z19f3upRF+VpniBtasogU2h33e+wFF3Seni7zz0Bqofi1MxPoK3Ec8BFj31BKJ04KMcO+7YOspBoFCK9rSWHq/ku2REI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmBLBF6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57474C4CEEB;
	Tue, 16 Sep 2025 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758053299;
	bh=c07+nrBCBVI2N9HmL41m7c9WRz3jG1BDnxKK1KtQgvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AmBLBF6K7tgJv4FVjr4LpxbcDNRkTbEBo3oEptCsjCUKFoYDjPH9vQIGjKpR8ViTR
	 oTnjDhybQhFR8jn08e7GesLk5GzC9WtJ8f5D/f+2D9/FHkbD1yczEMbZL+4OuUBGIh
	 +9GcE26FkX6ptHyCTQpgNzjQjqpSd8Y78KCuCWDRiJuVSmU6DQlmC4bCVTNNVsm6v7
	 6U993AgnvxQjfx+k9Pkyix+cEazqUyVOrDiqs5qW0eFGa+YifPAI6oq1RxgvuJyr51
	 Ovr13gUIPixChWR0lvXqFf5IFQGR4DG7Fg7lddrEZqiG1IjdCmESTzm8c/5GcS06sh
	 eX4g9LAjJT4Kw==
Date: Tue, 16 Sep 2025 15:08:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 2/4] PCI: qcom: Move host bridge 'phy' and 'reset'
 pointers to struct qcom_pcie_port
Message-ID: <20250916200817.GA1814336@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-pci-pwrctrl-perst-v3-2-3c0ac62b032c@oss.qualcomm.com>

On Fri, Sep 12, 2025 at 02:05:02PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> DT binding allows specifying 'phy' and 'reset' properties in both host
> bridge and Root Port nodes, though specifying in the host bridge node is
> marked as deprecated. Still, the pcie-qcom driver should support both
> combinations for maintaining the DT backwards compatibility. For this
> purpose, the driver is holding the relevant pointers of these properties in
> two structs: struct qcom_pcie_port and struct qcom_pcie.
> 
> However, this causes confusion and increases the driver complexity. Hence,
> move the pointers from struct qcom_pcie to struct qcom_pcie_port. As a
> result, even if these properties are specified in the host bridge node,
> the pointers will be stored in struct qcom_pcie_port as if the properties
> are specified in a single Root Port node. This logic simplifies the driver
> a lot.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com> 

I would put this patch by itself on pci/controller/qcom immediately
because it's not related to the rest of the series, and we should make
sure it's in v6.18 regardless of the rest.

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 87 ++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..6170c86f465f43f980f5b2f88bd8799c3c152e68 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -279,8 +279,6 @@ struct qcom_pcie {
>  	void __iomem *elbi;			/* DT elbi */
>  	void __iomem *mhi;
>  	union qcom_pcie_resources res;
> -	struct phy *phy;
> -	struct gpio_desc *reset;
>  	struct icc_path *icc_mem;
>  	struct icc_path *icc_cpu;
>  	const struct qcom_pcie_cfg *cfg;
> @@ -297,11 +295,8 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
>  	struct qcom_pcie_port *port;
>  	int val = assert ? 1 : 0;
>  
> -	if (list_empty(&pcie->ports))
> -		gpiod_set_value_cansleep(pcie->reset, val);
> -	else
> -		list_for_each_entry(port, &pcie->ports, list)
> -			gpiod_set_value_cansleep(port->reset, val);
> +	list_for_each_entry(port, &pcie->ports, list)
> +		gpiod_set_value_cansleep(port->reset, val);
>  
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
> @@ -1253,57 +1248,32 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
>  	return val & PCI_EXP_LNKSTA_DLLLA;
>  }
>  
> -static void qcom_pcie_phy_exit(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_port *port;
> -
> -	if (list_empty(&pcie->ports))
> -		phy_exit(pcie->phy);
> -	else
> -		list_for_each_entry(port, &pcie->ports, list)
> -			phy_exit(port->phy);
> -}
> -
>  static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_port *port;
>  
> -	if (list_empty(&pcie->ports)) {
> -		phy_power_off(pcie->phy);
> -	} else {
> -		list_for_each_entry(port, &pcie->ports, list)
> -			phy_power_off(port->phy);
> -	}
> +	list_for_each_entry(port, &pcie->ports, list)
> +		phy_power_off(port->phy);
>  }
>  
>  static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_port *port;
> -	int ret = 0;
> +	int ret;
>  
> -	if (list_empty(&pcie->ports)) {
> -		ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
>  		if (ret)
>  			return ret;
>  
> -		ret = phy_power_on(pcie->phy);
> -		if (ret)
> +		ret = phy_power_on(port->phy);
> +		if (ret) {
> +			qcom_pcie_phy_power_off(pcie);
>  			return ret;
> -	} else {
> -		list_for_each_entry(port, &pcie->ports, list) {
> -			ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> -			if (ret)
> -				return ret;
> -
> -			ret = phy_power_on(port->phy);
> -			if (ret) {
> -				qcom_pcie_phy_power_off(pcie);
> -				return ret;
> -			}
>  		}
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> @@ -1748,8 +1718,10 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>  	return ret;
>  
>  err_port_del:
> -	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		phy_exit(port->phy);
>  		list_del(&port->list);
> +	}
>  
>  	return ret;
>  }
> @@ -1757,20 +1729,32 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>  static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
>  {
>  	struct device *dev = pcie->pci->dev;
> +	struct qcom_pcie_port *port;
> +	struct gpio_desc *reset;
> +	struct phy *phy;
>  	int ret;
>  
> -	pcie->phy = devm_phy_optional_get(dev, "pciephy");
> -	if (IS_ERR(pcie->phy))
> -		return PTR_ERR(pcie->phy);
> +	phy = devm_phy_optional_get(dev, "pciephy");
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
>  
> -	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> -	if (IS_ERR(pcie->reset))
> -		return PTR_ERR(pcie->reset);
> +	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
>  
> -	ret = phy_init(pcie->phy);
> +	ret = phy_init(phy);
>  	if (ret)
>  		return ret;
>  
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->reset = reset;
> +	port->phy = phy;
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);
> +
>  	return 0;
>  }
>  
> @@ -1984,9 +1968,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  err_host_deinit:
>  	dw_pcie_host_deinit(pp);
>  err_phy_exit:
> -	qcom_pcie_phy_exit(pcie);
> -	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		phy_exit(port->phy);
>  		list_del(&port->list);
> +	}
>  err_pm_runtime_put:
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> 
> -- 
> 2.45.2
> 
> 

