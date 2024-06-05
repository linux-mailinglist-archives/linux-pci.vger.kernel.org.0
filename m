Return-Path: <linux-pci+bounces-8371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80968FD928
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 23:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C76728279D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 21:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E71607B4;
	Wed,  5 Jun 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7rSWXPi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2EF15A877;
	Wed,  5 Jun 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623302; cv=none; b=M0CiEEWtsU88Qm4tUdGrq7DX1qIih7BO5NGYcEpVs9u5G8VbNOsdp5VQrysG4ulDAzPzu7VMTRY8hNnnhrkwLyCrxVd15sM4908tWuUM+jrBiOlxM6qixYmuQ4wRBbX+2IguKLNfLfDkwvQfgieIZqM771ohwaee37snwGER9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623302; c=relaxed/simple;
	bh=M0UoLmlMVzW8p909y9nZdkAGH5fZZHKsZpVrcyD4X7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BRMPDDX8uvCCH9pN0RJUh427zOd+WioHfdsTdzXjI+qZAI1izjWGYzsmrkhwheqX5/Or+6nEqfWqNnDu9zcTFqZtp1sDBaGmX8bNXoQe6+XM8NCFTGsq3mXd1TWpkjLGrMmq1jgz67ryS6ukh9Jhi3k12LfiwZtyLD4F/q313EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7rSWXPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F93EC2BD11;
	Wed,  5 Jun 2024 21:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623302;
	bh=M0UoLmlMVzW8p909y9nZdkAGH5fZZHKsZpVrcyD4X7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N7rSWXPiGPaLBdQ2ie1VWb4kEnIz8LVzuINCO+kqtPN3zcmHPXwrlF6ikAIZCiQft
	 l79P33uVcy13mEhIAUeycr58sW0SzwOJqkWuKcgJ9cydLCS60qj87i64Z/+DDrEkR3
	 /qNENcyT+/KyJOo+KIZOQcln+Y1Dxp0+85bgekpVw73ZOqc9ZqsS+hanRMCH5jFicZ
	 TFUZKp09xPT+Yl6APaBKA+nNilrHH99NxWFNp99paahBpkPoXtKMSid66gT3wTo2oF
	 DuP94/UYpxe908q7KN/oHjnfAg/sQ2qQTnUisVE1SsCGePmlMuNp/5nsl/O9rnEHv0
	 oBDsoz4vu3ClA==
Date: Wed, 5 Jun 2024 16:34:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
Message-ID: <20240605213459.GA781155@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527161450.326615-19-herve.codina@bootlin.com>

On Mon, May 27, 2024 at 06:14:45PM +0200, Herve Codina wrote:
> Add a PCI driver that handles the LAN966x PCI device using a device-tree
> overlay. This overlay is applied to the PCI device DT node and allows to
> describe components that are present in the device.
> 
> The memory from the device-tree is remapped to the BAR memory thanks to
> "ranges" properties computed at runtime by the PCI core during the PCI
> enumeration.
> The PCI device itself acts as an interrupt controller and is used as the
> parent of the internal LAN966x interrupt controller to route the
> interrupts to the assigned PCI INTx interrupt.

Several patches in this series have things like this where it appears
the last two sentences are intended to be separate paragraphs, but the
only way to tell is that the first ends with a short line, which is
annoying to read.

Perhaps either add a blank line between or rewrap the whole thing into
a single paragraph that fills 75 columns or so?

