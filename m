Return-Path: <linux-pci+bounces-43745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F0DCDF1C3
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 00:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2814B3007694
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE521FF3B;
	Fri, 26 Dec 2025 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nei/gX+f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079ED10F2;
	Fri, 26 Dec 2025 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766791500; cv=none; b=dzHd58IfFb6oUAGelUGREhtT4dvpvycEu6Pr7x9k77bY89SWX181U0QnwKpvUsbkmC0zJhpWNZDsMDotQPdBadfVgtMi1/L/3wexhzdGUyAzQNdq2PDhaPpUPOj+4i7SfFUFTDxqX6D4y2uxSuoDjtEmDjufyb3ESucvKoOcPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766791500; c=relaxed/simple;
	bh=AWt7pcXXqvKV9yo+hcRwKMW/Zt2bgrBfmP87pZ4GteY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pgiek+WrspasQ0vYwfvvbg/r88WOaftcHz+WzzcHK03EFVB8yfXr9wtDdj90NSPf1dJovUD8R8dCUpHwjHwWqLxG5pXeh2uKly3ItSF3hXCLE4MWE1o4TBCPBgAcEGoSWac4eMg0FyQDQu6miDMQgDhqf6jnLVAg4fPubCWeDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nei/gX+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7096EC4CEF7;
	Fri, 26 Dec 2025 23:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766791499;
	bh=AWt7pcXXqvKV9yo+hcRwKMW/Zt2bgrBfmP87pZ4GteY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nei/gX+fU2n6xE0L2n/GyfMbRVpjpZDwqQe7sWCJCPb+p8DgunGaLS4Y55TDGsZaP
	 t6eGK0KuW5sNSvEwISOUm9daK3S5irJAus/FLCfCGPrmEpN9jZY3P7JT69IETOdTDZ
	 TEF1p3WLBSyqag42FtB7Y/DkGTq1ajA+VqxqsQAKmID5Okk6exo/Ou+fktgjln+BoM
	 vKqaM94Sda3ICZoBU05RyXaEp4lyYRRHkOkuXNs0kUqYXurQ9/+5lpQLVw8KMt+vwZ
	 MPUp2TGkgkmTSkyFNGvQ8ZTIGhxMFB3NhnlRdwABi7tBQiq7aF8ZwLk8cdICmX00ZH
	 McuqHRYbGyDyA==
Date: Fri, 26 Dec 2025 17:24:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 1/5] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Message-ID: <20251226232458.GA4146464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-pci-pwrctrl-rework-v2-1-745a563b9be6@oss.qualcomm.com>

On Tue, Dec 16, 2025 at 06:21:43PM +0530, Manivannan Sadhasivam wrote:
> Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
> nodes, not just in Root Port node. But the current logic parses PERST# only
> from the Root Port nodes. Though it is not causing any issue on the current
> platforms, the upcoming platforms will have PERST# in PCIe switch
> downstream ports also. So this requires parsing all the PCIe bridge nodes
> for the PERST# GPIO.
> 
> Hence, rework the parsing logic to extend to all PCIe bridge nodes starting
> from the Root Port node. If the 'reset-gpios' property is found for a PCI
> bridge node, the GPIO descriptor will be stored in qcom_pcie_perst::desc
> and added to the qcom_pcie_port::perst list.

>  static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
>  {
> +	struct qcom_pcie_perst *perst;
>  	struct qcom_pcie_port *port;
>  	int val = assert ? 1 : 0;
>  
> -	list_for_each_entry(port, &pcie->ports, list)
> -		gpiod_set_value_cansleep(port->reset, val);
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		list_for_each_entry(perst, &port->perst, list)
> +			gpiod_set_value_cansleep(perst->desc, val);
> +	}
>  
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
> @@ -1702,18 +1710,58 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
>  	}
>  };
>  
> -static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
> +/* Parse PERST# from all nodes in depth first manner starting from @np */
> +static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
> +				 struct qcom_pcie_port *port,
> +				 struct device_node *np)
>  {
>  	struct device *dev = pcie->pci->dev;
> -	struct qcom_pcie_port *port;
> +	struct qcom_pcie_perst *perst;
>  	struct gpio_desc *reset;
> -	struct phy *phy;
>  	int ret;
>  
> -	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> -				      "reset", GPIOD_OUT_HIGH, "PERST#");
> -	if (IS_ERR(reset))
> +	if (!of_find_property(np, "reset-gpios", NULL))
> +		goto parse_child_node;
> +
> +	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
> +				      GPIOD_OUT_HIGH, "PERST#");
> +	if (IS_ERR(reset)) {
> +		/*
> +		 * FIXME: GPIOLIB currently supports exclusive GPIO access only.
> +		 * Non exclusive access is broken. But shared PERST# requires
> +		 * non-exclusive access. So once GPIOLIB properly supports it,
> +		 * implement it here.
> +		 */
> +		if (PTR_ERR(reset) == -EBUSY)
> +			dev_err(dev, "Shared PERST# is not supported\n");
> +
>  		return PTR_ERR(reset);
> +	}
> +
> +	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
> +	if (!perst)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&perst->list);
> +	perst->desc = reset;
> +	list_add_tail(&perst->list, &port->perst);
> +
> +parse_child_node:
> +	for_each_available_child_of_node_scoped(np, child) {
> +		ret = qcom_pcie_parse_perst(pcie, port, child);

It looks like the perst->list will be ordered by distance from the
root, i.e., a Root Port first, followed by downstream devices?

And qcom_perst_assert() will assert/deassert PERST# in that same
order?  Intuitively I would have expected that if there are multiple
PERST# signals, we would assert them bottom-up, and deassert them
top-down.  Does the order matter?

I suppose maybe you plan to enhance pwrctrl so it can assert/deassert
individual PERST# in the hierarchy?

I'm confused about qcom_perst_assert() because it's only called from
qcom_ep_reset_assert() and qcom_ep_reset_deassert(), which are only
called from qcom_pcie_assert_perst().  Seems like a mix of host and
endpoint situation.  I assumed pwrctrl would be used on the host.
Maybe the "_ep_" names are not quite right?  Or more likely I'm just
misunderstanding the plan.

I notice you'd only applied this patch (1/5) so far on
pci/controller/dwc-qcom.  Is this patch useful by itself?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

