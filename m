Return-Path: <linux-pci+bounces-40439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B34C386F0
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 01:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798CC3B5139
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 00:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A720ED;
	Thu,  6 Nov 2025 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Tj1pIe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6D1388;
	Thu,  6 Nov 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387534; cv=none; b=jUy50fhLjTbpByvWamo4i1iy6knLvoTjOs88Odh/3FBhlcKo1WsmK1edUxJ/FEzD36F9mKj6tLG2QvJ34u5+U832FTxYFzxeOrSxbdSX8ibnrCatauyDen5wp648IvnckA6W5YtkeNDFO8aPip5i6y1gadE/DBGd24uYJ+BOguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387534; c=relaxed/simple;
	bh=y/ZAYxCD+K0ben97/l/TcgYvp1v3jhspO1xwcEPug+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hl46bx2rAPvoaOBF82kZ4tjLn9CcO3cwLNd/tAaneJHngUQPxxAjkfTyaYQN4PkKILNl0YKsaolZrGlGQGC4XKyBkumtlLwmkbZFJ8X8kjdyflYdDQx/sK0NrSrvV5glAATOj9xMOf67MFJ9EUvZtGLt6RBEM/xMhQoZMrQYy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2Tj1pIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF74BC4CEF5;
	Thu,  6 Nov 2025 00:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762387533;
	bh=y/ZAYxCD+K0ben97/l/TcgYvp1v3jhspO1xwcEPug+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e2Tj1pIej2SBYovVy9liByuimeqmIgSHUlUPqS3qaqe4q1iQ9iUL0nhZsrG4m3usd
	 TLFBN360oIQrAifta/POgM8nU9YvTGyaHgCVDft5m4cy43QE1vYw/YdF+dZo+bIjl0
	 CUXOZDan9dkcWVK3bS/p+7bK1hZr0ZQTseFeYxpmD31C4aLVggm/7YTH/BiywhkoC0
	 9U6yPAVKUEutUFhQ+wtekf21eqJo8Td4ohrhml9TPiMC7JhLiKqcv/KyPJlgsJeRer
	 FIWkYxgQHYt7a+iYBVzuSklb8MjOvQCVrEiJzZU+hOSiEt/puGzZcLaiO6lSxo1Kg7
	 wfCItHHp/YtYA==
Date: Wed, 5 Nov 2025 18:05:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <20251106000531.GA1930429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>

[+cc imx6, layerscape, stm32 maintainers for possible suspend bug]

On Fri, Oct 24, 2025 at 08:50:46AM +0200, Vincent Guittot wrote:
> On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> > > Add initial support of the PCIe controller for S32G Soc family. Only
> > > host mode is supported.

> > > +static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
> > > +{
> > > ...
> > > +     /*
> > > +      * Make sure we use the coherency defaults (just in case the settings
> > > +      * have been changed from their reset values)
> > > +      */
> > > +     s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> >
> > This seems sketchy and no other driver uses memblock_start_of_DRAM().
> > Shouldn't a physical memory address like this come from devicetree
> > somehow?
> 
> I was using DT but has been asked to not use it and was proposed to
> use memblock_start_of_DRAM() instead

Can you point me to that conversation?

> > > +     s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> > > +     if (IS_ERR(s32g_pp->ctrl_base))
> > > +             return PTR_ERR(s32g_pp->ctrl_base);
> >
> > This looks like the first DWC driver that uses a "ctrl" resource.  Is
> > this something unique to s32g, or do other drivers have something
> > similar but use a different name?
> 
> AFAICT this seems to be s32g specific in the RM

It does look like there's very little consistency in reg-names across
drivers, so I guess it's fine.

> > > +static int s32g_pcie_suspend_noirq(struct device *dev)
> > > +{
> > > +     struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> > > +     struct dw_pcie *pci = &s32g_pp->pci;
> > > +
> > > +     if (!dw_pcie_link_up(pci))
> > > +             return 0;
> >
> > Does something bad happen if you omit the link up check and the link
> > is not up when we get here?  The check is racy (the link could go down
> > between dw_pcie_link_up() and dw_pcie_suspend_noirq()), so it's not
> > completely reliable.
> >
> > If you have to check, please add a comment about why this driver needs
> > it when no other driver does.
> 
> dw_pcie_suspend_noirq returns an error and the suspend fails

The implication is that *every* user of dw_pcie_suspend_noirq() would
have to check for the link being up.  There are only three existing
callers:

  imx_pcie_suspend_noirq()
  ls_pcie_suspend_noirq()
  stm32_pcie_suspend_noirq()

but none of them checks for the link being up.

> I will add a comment
> /*
>  * If the link is not up, there is nothing to suspend and resume

Sometimes true, but still racy as I mentioned, and doesn't explain why
s32g is different from imx, ls, and stm32.

> > > +     return dw_pcie_suspend_noirq(pci);
> > > +}

