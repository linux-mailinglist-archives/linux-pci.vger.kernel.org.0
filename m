Return-Path: <linux-pci+bounces-17474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5319DEC8B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 20:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F86B219B7
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD96155391;
	Fri, 29 Nov 2024 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pub/Leiz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01F15AF6;
	Fri, 29 Nov 2024 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732909802; cv=none; b=hnweeZNE84AC5ICtmOGXAM9GODr3xuC5uXqO4g1b9Y0v/ebfN0WphcnsZhct7XJZAMJu3w8ms9FbRIWKb7Fqj1M0/lsr6N9Yvdoo98qFRxz7iiC5Vxvl0DtA+RBDzDo9K8i/mRsTaIdwDYL24hlPHPPCl80qW7LxAE15VEom+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732909802; c=relaxed/simple;
	bh=oRzBt4nPMu99Ci+wT4DlAwimuDa54cGJKx/M3usRIKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HOOnB61/dnTwWFHoK35NGDDnbKI4KyIewr6+nKjTVv4T+qD+WZmZKpPK2PEtRJryZVZheiVmQfOPX5qt/1mpm3qy65VB18JTnSWqec6cW3AKovXtVC3z9INcEgeJEwf11K7EAPRT07z9nKT6vtZ5ntUmrREFs1apy6mbdKSvGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pub/Leiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C627EC4CECF;
	Fri, 29 Nov 2024 19:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732909802;
	bh=oRzBt4nPMu99Ci+wT4DlAwimuDa54cGJKx/M3usRIKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pub/LeizZgMYiJGOjc4mtj9HeGJ2vGWzjTJP1QZvQTg8T3Wb0tTXOhsLsqHttqRI9
	 9AaEtGxfrs3/6KSj26ZNjKN/e9IiAFlAxWt1LBaCUCHTHrO/2LAYmZ4XrPrWjchmt5
	 ljwlc4w2cWTwHGlEmHIaX5rkIbp0hAzEWNsaWkY4vBAjfBmjgWV+jukztINfZFFUfX
	 r4I6K887CdLk2W3z9l6tyLI1dH+qrxvUxUYdnmjmTJzQvAIoxZOBFFwVFgH/bSC/2p
	 /h2WBlKtTJA5o+4KkXN/7m3aXIyezj0WHy0zB+R0lLMvcpm3dNdwk3sRlhOJHq28Nd
	 uzqIOaJXt8j0Q==
Date: Fri, 29 Nov 2024 13:50:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
	lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20241129195000.GA2770247@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MAXPR01MB3984C307B163E615811A25AAFE2A2@MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM>

On Fri, Nov 29, 2024 at 05:51:39PM +0800, Chen Wang wrote:
> On 2024/11/13 5:20, Bjorn Helgaas wrote:
> > On Mon, Nov 11, 2024 at 01:59:56PM +0800, Chen Wang wrote:
> > > From: Chen Wang <unicorn_wang@outlook.com>
> > > 
> > > Add support for PCIe controller in SG2042 SoC. The controller
> > > uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> > > PCIe controller will work in host mode only.
> > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > @@ -67,4 +67,15 @@ config PCI_J721E_EP
> > >   	  Say Y here if you want to support the TI J721E PCIe platform
> > >   	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
> > >   	  core.
> > > +
> > > +config PCIE_SG2042
> > > +	bool "Sophgo SG2042 PCIe controller (host mode)"
> > > +	depends on ARCH_SOPHGO || COMPILE_TEST
> > > +	depends on OF
> > > +	select PCIE_CADENCE_HOST
> > > +	help
> > > +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> > > +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> > > +	  PCIe core.
> >
> > Reorder to keep these menu items in alphabetical order by vendor.
> 
> Sorry, I don't understand your question. I think the menu items in this
> Kconfig file are already sorted alphabetically.

Here's what menuconfig looks like after this patch:

  [*] Cadence platform PCIe controller (host mode)
  [*] Cadence platform PCIe controller (endpoint mode)
  [*] TI J721E PCIe controller (host mode)
  [*] TI J721E PCIe controller (endpoint mode)
  [ ] Sophgo SG2042 PCIe controller (host mode) (NEW)

"Sophgo" sorts *before* "TI".

> > > +	if (pcie->link_id == 1) {
> > > +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_LOW,
> > > +			     lower_32_bits(pcie->msi_phys));
> > > +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_HIGH,
> > > +			     upper_32_bits(pcie->msi_phys));
> > > +
> > > +		regmap_read(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, &value);
> > > +		value = (value & REG_LINK1_MSI_ADDR_SIZE_MASK) | MAX_MSI_IRQS;
> > > +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, value);
> > > +	} else {
> > > +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_LOW,
> > > +			     lower_32_bits(pcie->msi_phys));
> > > +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_HIGH,
> > > +			     upper_32_bits(pcie->msi_phys));
> > > +
> > > +		regmap_read(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, &value);
> > > +		value = (value & REG_LINK0_MSI_ADDR_SIZE_MASK) | (MAX_MSI_IRQS << 16);
> > > +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, value);
> > > +	}
> >
> > Lot of pcie->link_id checking going on here.  Consider saving these
> > offsets in the struct sg2042_pcie so you don't need to test
> > everywhere.
> 
> Actually, there are not many places in the code to check link_id. If to add
> storage information in struct sg2042_pcie, at least four  u32 are needed.
> And this logic will only be called one time in the probe. So I think it is
> better to keep the current method. What do you think?

1) I don't think "link_id" is a very good name since it appears to
refer to one of two PCIe Root Ports.  mvebu uses "marvell,pcie-port"
which looks like a similar usage, although unnecessarily
Marvell-specific.  And arch/arm/boot/dts/marvell/armada-370-db.dts has
separate stanzas for two Root Ports, without needing a property to
distinguish them, which would be even better.  I'm not sure why
arch/arm/boot/dts/marvell/armada-370.dtsi needs "marvell,pcie-port"
even though it also has separate stanzas.

2) I think checking pcie->link_id is likely to be harder to maintain
in the future, e.g., if a new chip adds more Root Ports, you'll have
to touch each use.

Bjorn

