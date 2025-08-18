Return-Path: <linux-pci+bounces-34219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42ECB2B03A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 20:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CB21895869
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD43314A9;
	Mon, 18 Aug 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDIrUk6e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED63314A2;
	Mon, 18 Aug 2025 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541547; cv=none; b=g1OMUJ6Qr4RDhwJ+Ny5kHSUf0qLxOFNOWgB9ge5JyygcUJUst8vo/XO2AIJwmVQWF7fYn6uxS/5Fptoy+iacSXDyfFXDJL9BTVS/FI/5IGc2tRQKw6C5tDR01aMfsMSGAsYvOXZyjaRAj87PtW0Nk4msLM52ve3Iau5khQRAgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541547; c=relaxed/simple;
	bh=P5OJ4RHbL7bfCZueIbVBkF40afwl0Pm482XBXI7/HfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j/7DAsrVu5bMm/6j74ZWS6j+W/Atc7CHOzd1jZPP1GiRFR1NvnVf8HTPdkrCFPFsUw+5qQkLsYcigzmuTeNXEeMOMFYeJtEnmX9FtjOYNuWGOedVyHAgWKafDJ/hH2LtDwlQ7KUO27k9snEDqzwjH5d1UrYO3lq43gmMPYH6m0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDIrUk6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50078C4CEEB;
	Mon, 18 Aug 2025 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541546;
	bh=P5OJ4RHbL7bfCZueIbVBkF40afwl0Pm482XBXI7/HfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IDIrUk6equNseS0ZrN+tjnJzBgBbvhGFPTLcNrmqpDYFo8ThI70gRQ1UQo83gHjLN
	 y6axwix4PwvKDr3Qxm4V+5NyFfjqgcbavchlT1oHZgZygTQm9lVuS1d70g6BqQBdya
	 50XI46xc97f1NcbV9SKLIwwXvcY/QHJfm5PPEZ4BRJ7f61zRejSLUpXnWGVDzcerDF
	 fzJ9IGTpdNW9EmIJ52biPC64T7A73pMNSc5BRcd6QmhoC2Y9A4KEwaVUs17c44r9Zj
	 4Ba762DlDExTmr4RoFgVk3fpKr7j0VmeHipw0KWx8OadDdKkSeegTBvmRmNl//M3xp
	 UHGRuax/NOnLA==
Date: Mon, 18 Aug 2025 13:25:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
	jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
Message-ID: <20250818182544.GA534647@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01dc1022$ad8c0740$08a415c0$@samsung.com>

[+to Krzysztof]

On Mon, Aug 18, 2025 at 03:00:00PM +0530, Shradha Todi wrote:
> > On Mon, Aug 11, 2025 at 09:16:37PM +0530, Shradha Todi wrote:
> > > Add host and endpoint controller driver support for FSD SoC.

> > It's kind of unfortunate that the driver uses "ep" everywhere for
> > struct exynos_pcie pointers.  It's going to be confusing because "ep"
> > is also commonly used for endpoint-related things, e.g., struct
> > dw_pcie_ep pointers.  Maybe it's not worth changing; I dunno.
> 
> I did try to rename the structure and the pointers 
> (https://lore.kernel.org/all/20230214121333.1837-9-shradha.t@samsung.com/)
> But the intention was different back then and so the idea was rejected.
> I could add a patch to only rename the pointers to something less
> confusing like "exy_pci"

The patch you mention did several renames:

  s/to_exynos_pcie/to_samsung_pcie/
  s/struct exynos_pcie/struct samsung_pcie/
  s/struct exynos_pcie *ep/struct samsung_pcie *sp/

I'm only concerned about the confusion of "ep" being used both for
"struct exynos_pcie *" and for "struct dw_pcie_ep *".

It would still be sort of an annoying patch to do something like this:

  s/struct exynos_pcie *ep/struct exynos_pcie *pcie/

But 'git grep "struct .*_pcie \*.*=" drivers/pci/controller/' says
using "pcie" in this way is quite common, so maybe it would be worth
doing.

What do you think, Krzysztof?

> > > +static irqreturn_t fsd_pcie_irq_handler(int irq, void *arg)
> > > +{
> > > +	u32 val;
> > > +	struct exynos_pcie *ep = arg;
> > > +	struct dw_pcie *pci = &ep->pci;
> > > +	struct dw_pcie_rp *pp = &pci->pp;
> > > +
> > > +	val = readl(ep->elbi_base + FSD_IRQ2_STS);
> > > +	if ((val & FSD_IRQ_MSI_ENABLE) == FSD_IRQ_MSI_ENABLE) {
> > > +		val &= FSD_IRQ_MSI_ENABLE;
> > > +		writel(val, ep->elbi_base + FSD_IRQ2_STS);
> > 
> > This looks weird because FSD_IRQ_MSI_ENABLE sounds like an *enable*
> > bit, but here you're treating it as a *status* bit.
> > 
> > As far as I can tell, you set FSD_IRQ_MSI_ENABLE once at probe-time in
> > fsd_pcie_msi_init(), then you clear it here in an IRQ handler, and it
> > will never be set again.  That seems wrong; am I missing something?
> 
> Actually the status IRQ and enable IRQ registers are different offsets
> but the bit position for MSI remains same in both cases so I just reused
> the macro.

Ah, that's what I missed, thanks!  At probe-time, fsd_pcie_msi_init()
enables it in FSD_IRQ2_EN.  Here you clear it in FSD_IRQ2_STS.

> But I understand that it's confusing so I will add another
> macro for FSD_IRQ_MSI_STATUS or just rename the macro to
> FSD_IRQ_MSI to re-use.

Using the same name just because a similar bit happens to be at the
same position in two different registers is definitely confusing.  I
think it will be better to have two macros, one for FSD_IRQ2_STS and
another for FSD_IRQ2_EN, e.g.,

  #define FSD_IRQ2_STS                         0x008
  #define   FSD_IRQ2_STS_MSI                   BIT(17)
  #define FSD_IRQ2_EN                          0x018
  #define   FSD_IRQ2_EN_MSI                    BIT(17)

Another question about the test:

  if ((val & FSD_IRQ_MSI_ENABLE) == FSD_IRQ_MSI_ENABLE) {

This assumes there are no other bits in FSD_IRQ2_STS that could be
set.  I would have expected a test like this:

  if (val & FSD_IRQ_MSI_ENABLE) {

Is there a reason to restrict it to the case when *only*
FSD_IRQ_MSI_ENABLE is set?

Bjorn

