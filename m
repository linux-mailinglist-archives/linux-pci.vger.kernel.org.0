Return-Path: <linux-pci+bounces-7760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F98CC8D5
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 00:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28530281DEC
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254E51465A8;
	Wed, 22 May 2024 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG9l8swA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF07F47F;
	Wed, 22 May 2024 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415837; cv=none; b=GE7zay9A7l2vFfGDGNPQDNRP+FchM0i/PywUW07f2fwWZKrJQSDdRuxq+JNAJssIwmMGCBES+M4ucqXKcRzfbY1w+N5l+D0kMRaoeGK7MTX3/YCY/ppyD4WXffbQRAMSiWkJkpI1REUMgTAvdnDPZOKBgzCtp6JIobjbRGarR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415837; c=relaxed/simple;
	bh=78lSOt435SpzlKtYFJRnRC9xals+PsmCRmkOx4okULU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kgModzx9HguWgyF+cgHR+dN46lP1ZaIAkxP+qSNFuOzjAsTKqzPTkIJuIaJHsV6NbMr6aBKSdFyHKGFNDubPUsznDgfpmf93pjSwQbP+0NLLSvvGSChLOdnOhjvECekxfShsNEn3XUunqjateoYWsMA78WjaE4RDRIhTi/AlAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG9l8swA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5CAC2BBFC;
	Wed, 22 May 2024 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716415836;
	bh=78lSOt435SpzlKtYFJRnRC9xals+PsmCRmkOx4okULU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QG9l8swAl+2uLJlTgqBUAn1o2pxnCYHODesOdRxMEAL+yKCPO/ptqgxYEmtcEWHza
	 2Ttp0uF6DOs/G/2dn6c5nT8/MuORHjJXMXq8en+AaL4Rx9QNMBLwgH3sH1pqLkZ0sU
	 /yzJtJGaq8erEVBauiQaBlmSVXWip0wwdZPtvuXVEOGNLorpqdz3hb7uKhWOpI6DtM
	 E7VeoG7Lv6MpKiUJqMo8bLHMbIB6qKbniCDkIsFmWaJxi9JN7encYqT8WsB3v+j2H/
	 Th3B+Ik4ds12hJz3pXKtiAQikPmd5iyPC6hHTNWHxweBaIKxKHeFPTUoNJ9F2giBKy
	 /7+hB7Ceb732w==
Date: Wed, 22 May 2024 17:10:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjE2IDA4?=
 =?utf-8?Q?=2F22=5D_PCI?= =?utf-8?Q?=3A?= microchip: Change the argument of
 plda_pcie_setup_iomems()
Message-ID: <20240522221034.GA83828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SHXPR01MB086351396027D8A443BB6068E6EB2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>

On Wed, May 22, 2024 at 01:50:57AM +0000, Minda Chen wrote:
> > The patch is OK, but the subject line is not very informative.  It
> > should be useful all by itself even without the commit log.
> > "Change the argument of X" doesn't say anything about why we would
> > want to do that.
> > 
> > On Thu, Mar 28, 2024 at 05:18:21PM +0800, Minda Chen wrote:
> > > If other vendor do not select PCI_HOST_COMMON, the driver data is not
> > > struct pci_host_bridge.
> > 
> > Also, I don't think this is the real problem.  Your PCIE_MICROCHIP_HOST
> > Kconfig selects PCI_HOST_COMMON, and the driver calls
> > pci_host_common_probe(), so the driver wouldn't even build without
> > PCI_HOST_COMMON.
> > 
> > This patch is already applied and ready to go, but if you can tell
> > us what's really going on here, I'd like to update the commit log.
> > 
> It is modified for Starfive code. Starfive JH7110 PCIe do not select
> PCI_HOST_COMMON
> plda_pcie_setup_iomems() will be changed to common plda code.
> 
> I think I can modify the title and commit log like this.
> 
> Title: 
> PCI: microchip: Get struct pci_host_bridge pointer from platform code
> 
> Since plda_pcie_setup_iomems() will be a common PLDA core driver
> function, but the argument0 is a struct platform_device pointer.
> plda_pcie_setup_iomems() actually using struct pci_host_bridge
> pointer other than platform_device pointer. Further more if a new
> PLDA core PCIe driver do not select PCI_HOST_COMMON, the platform
> driver data is not struct pci_host_bridge pointer. So get struct
> pci_host_bridge pointer from platform code function
> mc_platform_init() and make it to be an argument of
> plda_pcie_setup_iomems().

OK, I see what you're doing.  This actually has nothing to do with
whether PCI_HOST_COMMON is *enabled*.  It has to do with whether
drivers use pci_host_common_probe().  Here's what I propose:

  PCI: plda: Pass pci_host_bridge to plda_pcie_setup_iomems()

  plda_pcie_setup_iomems() needs the bridge->windows list from struct
  pci_host_bridge and is currently used only by pcie-microchip-host.c.  This
  driver uses pci_host_common_probe(), which sets a pci_host_bridge as the
  drvdata, so plda_pcie_setup_iomems() used platform_get_drvdata() to find
  the pci_host_bridge.

  But we also want to use plda_pcie_setup_iomems() in the new pcie-starfive.c
  driver, which does not use pci_host_common_probe() and will have struct
  starfive_jh7110_pcie as its drvdata, so pass the pci_host_bridge directly
  to plda_pcie_setup_iomems() so it doesn't need platform_get_drvdata() to
  find it.

> > > Move calling platform_get_drvdata() to mc_platform_init().
> > >
> > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  drivers/pci/controller/plda/pcie-microchip-host.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c
> > > b/drivers/pci/controller/plda/pcie-microchip-host.c
> > > index 9b367927cd32..805870aed61d 100644
> > > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> > > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> > > @@ -876,11 +876,10 @@ static void plda_pcie_setup_window(void __iomem
> > *bridge_base_addr, u32 index,
> > >  	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);  }
> > >
> > > -static int plda_pcie_setup_iomems(struct platform_device *pdev,
> > > +static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
> > >  				  struct plda_pcie_rp *port)
> > >  {
> > >  	void __iomem *bridge_base_addr = port->bridge_addr;
> > > -	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
> > >  	struct resource_entry *entry;
> > >  	u64 pci_addr;
> > >  	u32 index = 1;
> > > @@ -1018,6 +1017,7 @@ static int mc_platform_init(struct
> > > pci_config_window *cfg)  {
> > >  	struct device *dev = cfg->parent;
> > >  	struct platform_device *pdev = to_platform_device(dev);
> > > +	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
> > >  	void __iomem *bridge_base_addr =
> > >  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> > >  	int ret;
> > > @@ -1031,7 +1031,7 @@ static int mc_platform_init(struct
> > pci_config_window *cfg)
> > >  	mc_pcie_enable_msi(port, cfg->win);
> > >
> > >  	/* Configure non-config space outbound ranges */
> > > -	ret = plda_pcie_setup_iomems(pdev, &port->plda);
> > > +	ret = plda_pcie_setup_iomems(bridge, &port->plda);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > --
> > > 2.17.1
> > >

