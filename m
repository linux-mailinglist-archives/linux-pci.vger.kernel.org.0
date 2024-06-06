Return-Path: <linux-pci+bounces-8409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88D8FF53F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 21:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10BF6B21A3E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E884503C;
	Thu,  6 Jun 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHPrf9QG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B12110E;
	Thu,  6 Jun 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717701974; cv=none; b=HHg9fyaSTB46khqexomMdQMOPV9eTcgL2bDOhrKglPPW37deuV9ZoJsPlm7Rq+6q5ojlZuxWi/2PV4Dofqjhq/3tsBKzer0YCQZtGaJlXW1/MEJdjs8DXWxBQuEG7PZwBKO13PqgCDXNToQlMDBwG5mJdt1TArrhZuPx8JcTc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717701974; c=relaxed/simple;
	bh=1HIaQotNiUpWV2qc7pNQjMXtq8vCq2cgNxyb4ZjQbJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ASj4rX8rPSEuHSNIK+XvTyhNwd/5bikyuEjwnV3RFEZ1zLC215DmwhEemF3SgQVCq6rYwFtSwDiYfwNjNHkMegaiZU1VTwLWjWOYJ5JrxFqfl0NkaCXwM+3GIVMYbOEIjhY/E9L4VhmvEXObFctibWu3w8SyRLqGTYYNBTV08vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHPrf9QG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DFFC2BD10;
	Thu,  6 Jun 2024 19:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717701973;
	bh=1HIaQotNiUpWV2qc7pNQjMXtq8vCq2cgNxyb4ZjQbJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qHPrf9QGQnvxAvKCMsYlArJj+cnlvJo3xKFVsMgLa1Ty3FFrtK/HuvI7/9tW3Sq5I
	 Hclf/l/+fMttK7SpWNevDE8H1tL4cmlioTU33WNuPQQDVvSJo2RkBzs1JzkvJsuEUf
	 K/G1iST0k7V9BHTiBBMkIHBY27RFn8pCyAFOTUobP7R0h3W9H8loQeU2py618TpYwP
	 lZqMfztQd5+9uAzS7ShnRUka7fRfQYfo11okwWxX5RIqR44rdNY344T4k3Q/McDUl4
	 aCwZTPBkpLydJvrnzPLtE0RbKkTH9mizfgBP0JZkdolj5LnBm/PR08wpPnmmu0qu1y
	 ruDta++esJMaQ==
Date: Thu, 6 Jun 2024 14:26:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 17/19] PCI: of_property: Add interrupt-controller
 property in PCI device nodes
Message-ID: <20240606192612.GA814032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527161450.326615-18-herve.codina@bootlin.com>

On Mon, May 27, 2024 at 06:14:44PM +0200, Herve Codina wrote:
> PCI devices and bridges DT nodes created during the PCI scan are created
> with the interrupt-map property set to handle interrupts.
> 
> In order to set this interrupt-map property at a specific level, a
> phandle to the parent interrupt controller is needed. On systems that
> are not fully described by a device-tree, the parent interrupt
> controller may be unavailable (i.e. not described by the device-tree).
> 
> As mentioned in the [1], avoiding the use of the interrupt-map property
> and considering a PCI device as an interrupt controller itself avoid the
> use of a parent interrupt phandle.
> 
> In that case, the PCI device itself as an interrupt controller is
> responsible for routing the interrupts described in the device-tree
> world (DT overlay) to the PCI interrupts.
> 
> Add the 'interrupt-controller' property in the PCI device DT node.
> 
> [1]: https://lore.kernel.org/lkml/CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com/
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

No objection from me, but I'd like an ack/review from Rob.

> ---
>  drivers/pci/of_property.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 03539e505372..5a0b98e69795 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -183,6 +183,26 @@ static int of_pci_prop_interrupts(struct pci_dev *pdev,
>  	return of_changeset_add_prop_u32(ocs, np, "interrupts", (u32)pin);
>  }
>  
> +static int of_pci_prop_intr_ctrl(struct pci_dev *pdev, struct of_changeset *ocs,
> +				 struct device_node *np)
> +{
> +	int ret;
> +	u8 pin;
> +
> +	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
> +	if (ret != 0)
> +		return ret;
> +
> +	if (!pin)
> +		return 0;
> +
> +	ret = of_changeset_add_prop_u32(ocs, np, "#interrupt-cells", 1);
> +	if (ret)
> +		return ret;
> +
> +	return of_changeset_add_prop_bool(ocs, np, "interrupt-controller");
> +}
> +
>  static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>  				struct device_node *np)
>  {
> @@ -336,6 +356,10 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
>  		ret = of_pci_prop_intr_map(pdev, ocs, np);
>  		if (ret)
>  			return ret;
> +	} else {
> +		ret = of_pci_prop_intr_ctrl(pdev, ocs, np);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = of_pci_prop_ranges(pdev, ocs, np);
> -- 
> 2.45.0
> 

