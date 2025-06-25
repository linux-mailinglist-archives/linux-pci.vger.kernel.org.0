Return-Path: <linux-pci+bounces-30666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03387AE90E4
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 00:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A6A168D70
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0317A2F3623;
	Wed, 25 Jun 2025 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRgvI8Ki"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0C2F2C74;
	Wed, 25 Jun 2025 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889815; cv=none; b=eaD2qdEDzZ1k3edNa0VTwWik+OXDT0Sd/H4N57rSZHwoseRMgu2MiUrcIWJgeemVFcz28rCxrkzEgJ6yd9/YSorSIuV5FXMe7X4rldlpLczRjV4fjL4gCdGCzyQKwTkFpOCuT13SBMFGYyvoKBvZx4QuxuCgCKFp1bHcV3eWnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889815; c=relaxed/simple;
	bh=JPCUTE7k+d+bV0g/ym3IuJKj3lnwuQfByYVszEgGuWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NeSVpqgzIkqaIPZGvhJHmt8y55GBejV7wyBDj9AOb+PPTDNx//Fv0bEUvQL5DLXFdGUGQEOLkKJ0ddRmRsfJ9q+mN3xU4eWs1PWZeICvxPk72HncwguGd8Ppaa+lnnj+B1wy/iYITgsNW652YvnwLVPH5UWnlWfwJbTRffwJIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRgvI8Ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2720CC4CEEA;
	Wed, 25 Jun 2025 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889815;
	bh=JPCUTE7k+d+bV0g/ym3IuJKj3lnwuQfByYVszEgGuWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FRgvI8Ki3o+8iAvZxOIOLv4YJj2pE/da5dKHPk4INdG0jov6rqfxyEemaXfjw7Gch
	 7/EpZGNRiorCi7p4OgarRC8qCQ/dx0UQ9I2J3SoVMztSbhHzrqfQSuT5BuAZWrnCwa
	 0Gf4FPtA2UdyAGdoY7lWk0pnZG+LvElbmEFkd4erB8Ioo259Q2nrKXZ55Hh9EC0oXK
	 /Q4N+vlPGYoJ5/LWKa3MzpD9yjxG6/yfB+QoaWFgwrx9j4i7mUTYPOOdtxwcB+6NlK
	 o14doDX3YsC5c5DLWuPCeGWr/HKA5g9BOUlP184kbOtrpIE2lKxBg1GnhPxjAbEP3Y
	 Vwjm1PXyLnUZg==
Date: Wed, 25 Jun 2025 17:16:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"elbadrym@google.com" <elbadrym@google.com>,
	"romlem@google.com" <romlem@google.com>,
	"anhphan@google.com" <anhphan@google.com>,
	"wak@google.com" <wak@google.com>,
	"yuxiaozhang@google.com" <yuxiaozhang@google.com>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY=?= =?utf-8?Q?=3A?= [PATCH 5/7]
 ARM: dts: aspeed-g6: Add PCIe RC node
Message-ID: <20250625221653.GA1590146@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51346BC9292066243CB845699D7BA@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Wed, Jun 25, 2025 at 08:27:26AM +0000, Jacky Chou wrote:
> > > > > +				resets = <&syscon ASPEED_RESET_H2X>,
> > > > > +					 <&syscon ASPEED_RESET_PCIE_RC_O>;
> > > > > +				reset-names = "h2x", "perst";
> > > >
> > > > PERST# is clearly a per-Root Port item since it's a signal on the
> > > > PCIe connector.  Can you separate this and any other per-Root Port
> > > > things into a Root Port stanza to leave open the possibility of
> > > > future hardware that supports multiple Root Ports in the RC?
> > >
> > > The PCIe RC that designed by us is only one root port.
> > 
> > Yes.  But this driver may be used in the future for other RCs that include more
> > than one Root Port, and it would be good if that didn't require structural
> > changes to the DT.  Also, there are RCs from other vendors that include more
> > than one Root Port, and I'd like all the DTs and drivers to have similar
> > structure.
> 
> Thanks.
> Is the "pciec" node in arch/arm/boot/dts/marvell/armada-385.dtsi
> what you said?  Or could you provide some examples for us to modify
> our pcie rc node?

Here are some examples of DT bindings and corresponding driver code:

* drivers/pci/controller/dwc/pcie-kirin.c
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml?id=v6.16-rc1#n108

    kirin_pcie_parse_port():
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-kirin.c?id=v6.16-rc1#n399

* drivers/pci/controller/pci-mvebu.c
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml?id=v6.16-rc1#n125

    mvebu_pcie_parse_port():
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?id=v6.16-rc1#n1252

* drivers/pci/controller/pcie-mt7621.c
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml?id=v6.16-rc1#n111

    mt7621_pcie_parse_port():
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-mt7621.c.c?id=v6.16-rc1#n198

* drivers/pci/controller/pcie-mediatek.c
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mediatek-pcie.txt?id=v6.16-rc1#n85

    mtk_pcie_parse_port():
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-mediatek.c.c?id=v6.16-rc1#n909


