Return-Path: <linux-pci+bounces-36074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD71B55A11
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 01:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906251D63388
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B12D641D;
	Fri, 12 Sep 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2AEkExt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3822D5A14;
	Fri, 12 Sep 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719430; cv=none; b=rbZHlvlVWqNplLYKiJT1Zb9LNEjlDndXiHlEZ3UW3ttWLkBxjSom6qCqu4d03h8l8DLPuAo7FV0nNMUpXCOHtr5IZRYrkZJaE7qgkLfcVXIrJlcyhSmEapot0jMSXyIEfsfARk4pMW8DHL3EzTwbzUeaFfQKIdTsU4eiZ2rJIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719430; c=relaxed/simple;
	bh=HhlQH87muZ5l8bahZ1JQh/wQL2+NmIcRaW7diyeKJdo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ancc0xPcmvZC2XIr88OnXySGvPASXnNaX+ROrKmBb5LvwLVUYNQay90Mse3NP6xPbR02Jxu20VcvKulW7YrqMK4IZBgSwMq4lumb7nJpntcX+/4s4X4HqhGLTyF+4pSQ9IR+QEq+/agfjtQY3McgXdiobJNXzaqn510Vxp/A+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2AEkExt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9E4C4CEF1;
	Fri, 12 Sep 2025 23:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757719429;
	bh=HhlQH87muZ5l8bahZ1JQh/wQL2+NmIcRaW7diyeKJdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S2AEkExtho8QDGnTQat0wBZUTZuRwc+kdQEO7RVyWP7AHMuIrMKZkxwsqE7AtZvlN
	 OS1RbVqgwdLIlVpWuWnYqNjbCr+jDLXUZt7+WStynlyJjkOWgY2CXMvJIyd12Pz8i6
	 YUJCYncP6daouDdOhxljI2LbhYNjcyHlPYmW/NlpL2QhBB2AvDUCEkzUJuYfn9rP//
	 go9wIC9pHQJrXK2RoUr8qXENrVRdvtZAOKSduX0L9Sv1yEQCDZgIuhZDw2lZQQCUa7
	 Ngk2jqePqNtmMsB3383ZL8XOfb9B29um6lwXROv1OcgakHKPu3zo1MtwsC6fDl8Mxv
	 BpNjRq9rIN26Q==
Date: Fri, 12 Sep 2025 18:23:48 -0500
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
Message-ID: <20250912232348.GA1653056@bhelgaas>
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

This is so much nicer, thanks for doing this!

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

Seems like it would be easier to integrate this fallback into
qcom_pcie_parse_port() instead if separating it into
qcom_pcie_parse_legacy_binding().

What if you did something like this in qcom_pcie_parse_port():

  qcom_pcie_parse_port
  {
      reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
				    "reset",  GPIOD_OUT_HIGH, "PERST#");
      if (IS_ERR(reset)) {
	  reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
	  if (IS_ERR(reset))
	      return PTR_ERR(reset);
      }
      ...

Then you could share all the port kzalloc and port list management.

Could do the same with the PHY stuff.

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

