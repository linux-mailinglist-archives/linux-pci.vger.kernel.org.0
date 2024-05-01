Return-Path: <linux-pci+bounces-6970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0DA8B8F1F
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E765B224A2
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906B12FF6B;
	Wed,  1 May 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG482jE1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C5D2FE;
	Wed,  1 May 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585109; cv=none; b=hBk2z4MA3JWM4s9SPx9gD1wB+k3oOIF838svJx7zBs7ci2c0h0vzOkCe+zll1l/GZ2tndh3qjRk2MNMEfhACMp2I7kiw5zAiXZNBufq5lxZxxmqCejxKSR9T3NZxRRYYXp7vpkwjgHdIYEu0JGYW5+nsyzT6akqMdv4A3KKBOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585109; c=relaxed/simple;
	bh=3Rom1K33gLjGc5KMu7YOMHTB0qLyXpnfXozkAEwXuwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PKd7GUJiMxZwD9EtP178mmOwafAs8acex0vuvItmIA2xOvSSHmWCXODQqCbzHtp5IdRS5hGP++HP5v2a2s/ohYHksgV9LNPzJFNql/MZhmGG/XLU66BfuIauZ+06/gfc+rRRl6eJrcL1mBD8DVOYJCnRq3l//RRNp02yaW6MSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG482jE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA32C072AA;
	Wed,  1 May 2024 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714585108;
	bh=3Rom1K33gLjGc5KMu7YOMHTB0qLyXpnfXozkAEwXuwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FG482jE1b23MALPQTleYDyQE1i/V2NpJTWpzv1GQrZKsSaSchZfte6XfXHrUIstsY
	 wWdvHyKMw9fx5FUqlBzhSH8osTQZvwTaZrGrt0Xn7ftNu8Xnk9lGJlz2dzCPMB9qoz
	 KALX3k6b91XTBT3kA1wPdPZM1m66uA/qOBn4jLCr8YaiQvQ9BXxjfR5pprRftIrhrw
	 /9yJKII93CaytSG1/TarbiJyKVzIxg351HGh1Dn0Eh9JPrh8emJM5tohPnWbTgYddS
	 MVvWkLicm8OIZWsV8yNLVsfkfG/AJ0uL+iysVuZKcIktl/Ty/JJRX7tSvQs9GmjmOW
	 nh95iuzB5VEsA==
Date: Wed, 1 May 2024 12:38:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH 15/17] pci: of_property: Add the interrupt-controller
 property in PCI device nodes
Message-ID: <20240501173826.GA808463@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-16-herve.codina@bootlin.com>

In subject: s/pci:/PCI:/ to match history. s/Add the/Add/ for brevity.

On Tue, Apr 30, 2024 at 10:37:24AM +0200, Herve Codina wrote:
> PCI devices and bridges DT nodes created during the PCI scan are created
> with the interrupt-map property set to handle interrupts.
> 
> In order to set this interrupt-map property at a specific level, a
> phandle to the parent interrupt controller is needed.
> On systems that are not fully described by a device-tree, the parent
> interrupt controller may be unavailable (i.e. not described by the
> device-tree).

Rewrap into one paragraph or add blank line to separate paragraphs.

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
> ---
>  drivers/pci/of_property.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index c2c7334152bc..9f8b940029ed 100644
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
> @@ -334,6 +354,10 @@ int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
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
> 2.44.0
> 

