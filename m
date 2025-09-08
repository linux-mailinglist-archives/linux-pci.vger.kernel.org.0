Return-Path: <linux-pci+bounces-35686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1C5B49A0A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2360B3BC1C9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854C62853F1;
	Mon,  8 Sep 2025 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVjEiTrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377412CDA5;
	Mon,  8 Sep 2025 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360070; cv=none; b=XIOvroQNZPT6pIIy7kZUpfWuokkqYdWfMDscDzeMdq6E/OQqHbGycSLbTucQuf3a1MgI+NidT5J7iv6WYIonPBqCTn8VbOUfGhllwBLUndeYj9OMxRcXJ8KBLwWfP5Af0TriXxg+rh/StfDQ39ocsLBfNBMUlRZYH51Z1EeTwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360070; c=relaxed/simple;
	bh=N4jke7ALHYK5hCEBfpPmlp4xquH7nDpRTyLZkO94ln8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fvdRW2/09hnXjpxhl2s3XQxeafT9E/pc5d45N0rs15ahEM08IFz++VjOo+8aO4cdln9OqYCMTXEUidu1fucC5uxDs4pOBYIl8VTNpJi6HUcu16AaAo0IRspjYu37HDIWDQIy8f/pwYSN57wiLCbemRG6wIoUIyYo5H7n8NVWY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVjEiTrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8998C4CEF5;
	Mon,  8 Sep 2025 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757360070;
	bh=N4jke7ALHYK5hCEBfpPmlp4xquH7nDpRTyLZkO94ln8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uVjEiTrAIss07DqBcRAJG5PaP00MCdDFRZY9hxo92UzmUTQ+LLNUZIsv3znlxu284
	 be7JHg9k4hWFlOjYwBd/KcAjNMMT59/Ps/fvCBG81LHhrzRMij+uptIyHtcAYcWsXs
	 7q/bZAqIoilFL4S2LK2AxgbQ5PfhL2drpsfXgNIh/j6moS1rFsy6cZZhOWZfQCQIIg
	 QFKHJYw9jEBxYdJh4NRQzB9+FJH9gQkB0k1B7NzxsLKCIr5M/VAuelKJjULHtGMt8n
	 IHVmHRQ0N/Yr5wHbHzsbMeVdb/33X3CAcRfcWkCkQSzma85Esg9nEfknt4zZmMXG8q
	 oeboQbI6waENg==
Date: Mon, 8 Sep 2025 14:34:28 -0500
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
Subject: Re: [PATCH v2 5/5] PCI: qcom: Allow pwrctrl core to toggle PERST#
 for new DT binding
Message-ID: <20250908193428.GA1437972@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-pci-pwrctrl-perst-v2-5-2d461ed0e061@oss.qualcomm.com>

On Wed, Sep 03, 2025 at 12:43:27PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> If the platform is using the new DT binding, let the pwrctrl core toggle
> PERST# for the device. This is achieved by populating the
> 'pci_host_bridge::toggle_perst' callback with qcom_pcie_toggle_perst().

Can we say something here about how to identify a "new DT binding"?
I assume there is a DT property or something that makes it "new"?

> qcom_pcie_toggle_perst() will find the PERST# GPIO descriptor associated
> with the supplied 'device_node' and toggles PERST#. If PERST# is not found
> in the supplied node, the function will look for PERST# in the parent node
> as a fallback. This is needed since PERST# won't be available in the
> endpoint node as per the DT binding.
> 
> Note that the driver still asserts PERST# during the controller
> initialization as it is needed as per the hardware documentation. Apart
> from that, the driver wouldn't touch PERST# for the new binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 89 +++++++++++++++++++++++++++++-----
>  1 file changed, 78 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 78355d12f10d263a0bb052e24c1e2d5e8f68603d..3c5c65d7d97cac186e1b671f80ba7296ad226d68 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -276,6 +276,7 @@ struct qcom_pcie_port {
>  struct qcom_pcie_perst {
>  	struct list_head list;
>  	struct gpio_desc *desc;
> +	struct device_node *np;
>  };
>  
>  struct qcom_pcie {
> @@ -298,11 +299,50 @@ struct qcom_pcie {
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> -static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
> +static struct gpio_desc *qcom_find_perst(struct qcom_pcie *pcie, struct device_node *np)
> +{
> +	struct qcom_pcie_perst *perst;
> +
> +	list_for_each_entry(perst, &pcie->perst, list) {
> +		if (np == perst->np)
> +			return perst->desc;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void qcom_toggle_perst_per_device(struct qcom_pcie *pcie,
> +					 struct device_node *np, bool assert)
> +{
> +	int val = assert ? 1 : 0;
> +	struct gpio_desc *perst;
> +
> +	perst = qcom_find_perst(pcie, np);
> +	if (perst)
> +		goto toggle_perst;
> +
> +	/*
> +	 * If PERST# is not available in the current node, try the parent. This
> +	 * fallback is needed if the current node belongs to an endpoint or
> +	 * switch upstream port.
> +	 */
> +	if (np->parent)
> +		perst = qcom_find_perst(pcie, np->parent);

Ugh.  I think we need to fix the data structures here before we go
much farther.  We should be able to search for PERST# once at probe of
the Qcom controller.  Hopefully we don't need lists of things.

See https://lore.kernel.org/r/20250908183325.GA1450728@bhelgaas.

> +toggle_perst:
> +	/* gpiod* APIs handle NULL gpio_desc gracefully. So no need to check. */
> +	gpiod_set_value_cansleep(perst, val);
> +}
> +
> +static void qcom_perst_reset(struct qcom_pcie *pcie, struct device_node *np,
> +			      bool assert)
>  {
>  	struct qcom_pcie_perst *perst;
>  	int val = assert ? 1 : 0;
>  
> +	if (np)
> +		return qcom_toggle_perst_per_device(pcie, np, assert);
> +
>  	if (list_empty(&pcie->perst))
>  		gpiod_set_value_cansleep(pcie->reset, val);
>  
> @@ -310,22 +350,34 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
>  		gpiod_set_value_cansleep(perst->desc, val);
>  }
>  
> -static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> +static void qcom_ep_reset_assert(struct qcom_pcie *pcie, struct device_node *np)
>  {
> -	qcom_perst_assert(pcie, true);
> +	qcom_perst_reset(pcie, np, true);
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
> -static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> +static void qcom_ep_reset_deassert(struct qcom_pcie *pcie,
> +				   struct device_node *np)
>  {
>  	struct dw_pcie_rp *pp = &pcie->pci->pp;
>  
>  	msleep(PCIE_T_PVPERL_MS);
> -	qcom_perst_assert(pcie, false);
> +	qcom_perst_reset(pcie, np, false);
>  	if (!pp->use_linkup_irq)
>  		msleep(PCIE_RESET_CONFIG_WAIT_MS);
>  }
>  
> +static void qcom_pcie_toggle_perst(struct pci_host_bridge *bridge,
> +				    struct device_node *np, bool assert)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(bridge->dev.parent);
> +
> +	if (assert)
> +		qcom_ep_reset_assert(pcie, np);
> +	else
> +		qcom_ep_reset_deassert(pcie, np);
> +}
> +
>  static int qcom_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> @@ -1320,7 +1372,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  	int ret;
>  
> -	qcom_ep_reset_assert(pcie);
> +	qcom_ep_reset_assert(pcie, NULL);
>  
>  	ret = pcie->cfg->ops->init(pcie);
>  	if (ret)
> @@ -1336,7 +1388,13 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_disable_phy;
>  	}
>  
> -	qcom_ep_reset_deassert(pcie);
> +	/*
> +	 * Only deassert PERST# for all devices here if legacy binding is used.
> +	 * For the new binding, pwrctrl driver is expected to toggle PERST# for
> +	 * individual devices.

Can we replace "new binding" with something explicit?  In a few
months, "new binding" won't mean anything.

> +	 */
> +	if (list_empty(&pcie->perst))
> +		qcom_ep_reset_deassert(pcie, NULL);
>  
>  	if (pcie->cfg->ops->config_sid) {
>  		ret = pcie->cfg->ops->config_sid(pcie);
> @@ -1344,10 +1402,12 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_assert_reset;
>  	}
>  
> +	pci->pp.bridge->toggle_perst = qcom_pcie_toggle_perst;
> +
>  	return 0;
>  
>  err_assert_reset:
> -	qcom_ep_reset_assert(pcie);
> +	qcom_ep_reset_assert(pcie, NULL);
>  err_disable_phy:
>  	qcom_pcie_phy_power_off(pcie);
>  err_deinit:
> @@ -1361,7 +1421,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
> -	qcom_ep_reset_assert(pcie);
> +	qcom_ep_reset_assert(pcie, NULL);
>  	qcom_pcie_phy_power_off(pcie);
>  	pcie->cfg->ops->deinit(pcie);
>  }
> @@ -1740,6 +1800,9 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
>  		return -ENOMEM;
>  
>  	perst->desc = reset;
> +	/* Increase the refcount to make sure 'np' is valid till it is stored */
> +	of_node_get(np);
> +	perst->np = np;
>  	list_add_tail(&perst->list, &pcie->perst);
>  
>  parse_child_node:
> @@ -1803,8 +1866,10 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>  		list_del(&port->list);
>  	}
>  
> -	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list)
> +	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list) {
> +		of_node_put(perst->np);
>  		list_del(&perst->list);
> +	}
>  
>  	return ret;
>  }
> @@ -2044,8 +2109,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	qcom_pcie_phy_exit(pcie);
>  	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list)
>  		list_del(&port->list);
> -	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list)
> +	list_for_each_entry_safe(perst, tmp_perst, &pcie->perst, list) {
> +		of_node_put(perst->np);
>  		list_del(&perst->list);
> +	}
>  err_pm_runtime_put:
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> 
> -- 
> 2.45.2
> 
> 

