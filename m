Return-Path: <linux-pci+bounces-43754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0D7CDF445
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 05:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15DD3008185
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 04:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CDF1DF27D;
	Sat, 27 Dec 2025 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdIeTGCD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79F45C0B;
	Sat, 27 Dec 2025 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766810559; cv=none; b=e08q4P3EKKVJpXgNmzZMdaMDn5LIe0+X2yR4+QoHxFjQszUzle/68TatfSQTkvLWl6/RT2ti8b0UQMQlCjH0ENDg6r88QdSsv0tPgcA5z2OqNpKFTVVr4CRzh9Ed/34GrIzgaF7Yktak/tBTexOfDR/9zCIyvzuGn4xPWZuQ33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766810559; c=relaxed/simple;
	bh=HJ1Mg1aNTedk02BBtbXHOBjt3oUYpxf+I9kTL+6Z0Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4XDRvK7u0+ug2NYQxvSZooZ2hliQhObsgQOSrj3LxxDPL5c9+A/34jQHNF5KNwsG+0J2PTJggeo8eJpJdvVjZC77zGkp6EX68rQRQKki3GzEuG1vTNnJndSAaQVvh60f/dHP6+mUc7wLwLFsI1lFYixkLc9ZVTW2yj0Vp+Je7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdIeTGCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3806C4CEF1;
	Sat, 27 Dec 2025 04:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766810559;
	bh=HJ1Mg1aNTedk02BBtbXHOBjt3oUYpxf+I9kTL+6Z0Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdIeTGCDVUlRuCGNUR/4Qhlvmw1dFDnlUowK7FsrAp7Jn0c0FeVoltFCJDFoFHmyN
	 UvunmVuR1yyoNWUx7hq701mBwqIVWp9h1OI3JkVVcuVgKckMldJD2H/3oYe4fhISNK
	 WTdQtEXy6/6ddC3pL1ZJRIBQEZ76/ig768h7K0aLFXom73fBV2ZJrMgOIVThzeHG/t
	 v87omKmr2s6B9DxnNijhR5cgq9928vaSD8zmn0mp0dtV+obCXBVc1qmDRugNndM1Mz
	 J1UtOeTaKI31ggdqqNbdUP4k2Lh2Lb+LbYQGKBJWjMu1etgySHYwYLd+sz70uSFOSu
	 nMTYnL9F9QqOg==
Date: Sat, 27 Dec 2025 10:12:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 1/5] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Message-ID: <ibvk4it7th4bi6djoxshjqjh7zusbulzpndac5jtqkqovvgcei@5sycben7pqkk>
References: <20251216-pci-pwrctrl-rework-v2-1-745a563b9be6@oss.qualcomm.com>
 <20251226232458.GA4146464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251226232458.GA4146464@bhelgaas>

On Fri, Dec 26, 2025 at 05:24:58PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 16, 2025 at 06:21:43PM +0530, Manivannan Sadhasivam wrote:
> > Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
> > nodes, not just in Root Port node. But the current logic parses PERST# only
> > from the Root Port nodes. Though it is not causing any issue on the current
> > platforms, the upcoming platforms will have PERST# in PCIe switch
> > downstream ports also. So this requires parsing all the PCIe bridge nodes
> > for the PERST# GPIO.
> > 
> > Hence, rework the parsing logic to extend to all PCIe bridge nodes starting
> > from the Root Port node. If the 'reset-gpios' property is found for a PCI
> > bridge node, the GPIO descriptor will be stored in qcom_pcie_perst::desc
> > and added to the qcom_pcie_port::perst list.
> 
> >  static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
> >  {
> > +	struct qcom_pcie_perst *perst;
> >  	struct qcom_pcie_port *port;
> >  	int val = assert ? 1 : 0;
> >  
> > -	list_for_each_entry(port, &pcie->ports, list)
> > -		gpiod_set_value_cansleep(port->reset, val);
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		list_for_each_entry(perst, &port->perst, list)
> > +			gpiod_set_value_cansleep(perst->desc, val);
> > +	}
> >  
> >  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> >  }
> > @@ -1702,18 +1710,58 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
> >  	}
> >  };
> >  
> > -static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
> > +/* Parse PERST# from all nodes in depth first manner starting from @np */
> > +static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
> > +				 struct qcom_pcie_port *port,
> > +				 struct device_node *np)
> >  {
> >  	struct device *dev = pcie->pci->dev;
> > -	struct qcom_pcie_port *port;
> > +	struct qcom_pcie_perst *perst;
> >  	struct gpio_desc *reset;
> > -	struct phy *phy;
> >  	int ret;
> >  
> > -	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> > -				      "reset", GPIOD_OUT_HIGH, "PERST#");
> > -	if (IS_ERR(reset))
> > +	if (!of_find_property(np, "reset-gpios", NULL))
> > +		goto parse_child_node;
> > +
> > +	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
> > +				      GPIOD_OUT_HIGH, "PERST#");
> > +	if (IS_ERR(reset)) {
> > +		/*
> > +		 * FIXME: GPIOLIB currently supports exclusive GPIO access only.
> > +		 * Non exclusive access is broken. But shared PERST# requires
> > +		 * non-exclusive access. So once GPIOLIB properly supports it,
> > +		 * implement it here.
> > +		 */
> > +		if (PTR_ERR(reset) == -EBUSY)
> > +			dev_err(dev, "Shared PERST# is not supported\n");
> > +
> >  		return PTR_ERR(reset);
> > +	}
> > +
> > +	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
> > +	if (!perst)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&perst->list);
> > +	perst->desc = reset;
> > +	list_add_tail(&perst->list, &port->perst);
> > +
> > +parse_child_node:
> > +	for_each_available_child_of_node_scoped(np, child) {
> > +		ret = qcom_pcie_parse_perst(pcie, port, child);
> 
> It looks like the perst->list will be ordered by distance from the
> root, i.e., a Root Port first, followed by downstream devices?
> 

Yes.

> And qcom_perst_assert() will assert/deassert PERST# in that same
> order?  Intuitively I would have expected that if there are multiple
> PERST# signals, we would assert them bottom-up, and deassert them
> top-down.  Does the order matter?
> 

I did't give much importance to the PERST# ordering since it doesn't matter,
atleast per base/electromechanical specs.

> I suppose maybe you plan to enhance pwrctrl so it can assert/deassert
> individual PERST# in the hierarchy?
> 

No, that plan has been dropped for good. For now, PERST# will be handled
entirely by the controller drivers. Sharing the PERST# handling with pwrctrl
proved to be a pain and it looks more clean (after the API introduction) to
handle PERST# in controller drivers.

> I'm confused about qcom_perst_assert() because it's only called from
> qcom_ep_reset_assert() and qcom_ep_reset_deassert(), which are only
> called from qcom_pcie_assert_perst().  Seems like a mix of host and
> endpoint situation.  I assumed pwrctrl would be used on the host.
> Maybe the "_ep_" names are not quite right?  Or more likely I'm just
> misunderstanding the plan.
> 

Yeah, it is a bit confusing now due to the introduction of the
'dw_pcie_ops::assert_perst' callback. But it will go away at the end of the
pwrctrl rework series and I'll fix those names by then.

> I notice you'd only applied this patch (1/5) so far on
> pci/controller/dwc-qcom.  Is this patch useful by itself?
> 

Yes, ofc. This patch allows the controller driver to parse and assert/deassert
PERST# from all PCI nodes, not just from the Root Port node.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

