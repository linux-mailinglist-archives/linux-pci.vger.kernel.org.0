Return-Path: <linux-pci+bounces-30519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A2EAE6B82
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839A21C41ADA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4517526CE1A;
	Tue, 24 Jun 2025 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAdJn0S2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF026CE00;
	Tue, 24 Jun 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779201; cv=none; b=MxnKoWXrSCqnqhnPuWB9I1+M37rpkoldb8kCWtM5NbMIWy8fKNGR9OHuI4aJdowpEOhda+ZSDo7QmrWdY4zoQYa4FF/8WFXh/YN1o6eX1L4YCRJYGGwAAT8fX4yKAZ5UMABO2RiS9xfAnnomLxth7PqJXTIHIMbi4h3S2EBqaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779201; c=relaxed/simple;
	bh=q6zc5t1ffrY54UuAj9wfKtHgj2vJk8nzvm5t/rgZlJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lI85s+DNBFTcMGTRdI/7FrYiFsJuit7sQ93JwQDnH+m3mVrSAliaadbUiKZviF9TtJimxGrn+k+JsFXW2VbzWAlTy48QDYW3mR599XxOiHQ00mQ2JKX2cdxkBpUaA2Xf6FKHLkV+Xbd3Tmi82g+v1X36e17YvQwj4h/iC/fHYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAdJn0S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61216C4CEE3;
	Tue, 24 Jun 2025 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750779199;
	bh=q6zc5t1ffrY54UuAj9wfKtHgj2vJk8nzvm5t/rgZlJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tAdJn0S2KFY7K9z1dPx1SBSRAXjgZzFEpuX9Cz8uE2gOzckJHxm7jz+0gdwzWO+ex
	 CwT0ZhtL3tH9wwwdwjZBylW6D+MQ0M2HcWcRC2oWuS9rz02Rbu4tw8KGNnF3XJ80hQ
	 iNmEoquScWaakp/njFSojt3F09lCIqgde2eukZOpgCGkqxK8JMJ4CbFm4/h2AGuVwS
	 ITwBL8mhY6G4yj+CNxqP8lp9R651VyBgDXFGPM+uwbPELKLg4tpfsbFb2UGECQ8kOP
	 v4pAFDhjBxAWCSbz34wWUDKlhtjtMzRHLkBhFjVhGsk0f9wG0bP/QpPAl++srzrNwW
	 oQSp5ec0EoFFA==
Date: Tue, 24 Jun 2025 10:33:18 -0500
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
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQw==?= =?utf-8?Q?H?= 7/7] pci: aspeed:
 Add ASPEED PCIe host controller driver
Message-ID: <20250624153318.GA1477975@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51342E52B3C4A7AFD42485039D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Jun 20, 2025 at 06:05:20AM +0000, Jacky Chou wrote:
> > > Introduce PCIe Root Complex driver for ASPEED SoCs. Support RC
> > > initialization, reset, clock, IRQ domain, and MSI domain setup.
> > > Implement platform-specific setup and register configuration for
> > > ASPEED. And provide PCI config space read/write and INTx/MSI interrupt
> > > handling.

> > > +static int aspeed_ast2600_rd_conf(struct pci_bus *bus, unsigned int devfn,
> > > +				  int where, int size, u32 *val)
> > > +{
> > > +	struct aspeed_pcie *pcie = bus->sysdata;
> > > +	u32 bdf_offset;
> > > +	int rx_done_fail = 0, slot = PCI_SLOT(devfn);
> > > +	u32 cfg_val, isr, type = 0;
> > > +	u32 link_sts = 0;
> > > +	int ret;
> > > +
> > > +	/* Driver may set unlock RX buffere before triggering next TX config
> > > +*/
> > > +	writel(PCIE_UNLOCK_RX_BUFF | readl(pcie->reg + H2X_DEV_CTRL),
> > > +	       pcie->reg + H2X_DEV_CTRL);
> > > +
> > > +	if (bus->number == 128 && slot != 0 && slot != 8)
> > > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > > +	type = (bus->number > 128);
> > 
> > Weird.  What's all this?  Some kind of device you want to hide?
> > Deserves a hint about what's special.
> 
> The bus range in our AST2600 design is just starting from 128.
> There is no something special.  I will use the child_ops that is in
> struct pci_host_bridge to distinguish the rc bridge and the other
> bus.

Is the 128 root bus number hardwired into the RC?  Maybe it should be
described in DT?

