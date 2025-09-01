Return-Path: <linux-pci+bounces-35275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EEEB3E690
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 16:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7FF1883010
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 14:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666DF2F069D;
	Mon,  1 Sep 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON7rfcZr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325F1B3930;
	Mon,  1 Sep 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735444; cv=none; b=NmN60OYGhc7XqvqURoHxtT51Xdg/Lopw516xbx0LP64Ea2sJSRwUE/NT616EOQQdJC2HU4XxpkIAcWV9euHa86YGOOsMH1QJvaAndHBlZBPm50GyToL9X/IsnUFZVE9mOlGtUrqDU/Wc7La+OGCsReE9sdUki2XOuL3V2oSoN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735444; c=relaxed/simple;
	bh=0I395bScAfXDaELxzjx7kkUg8Yab6NEvTHxGLJFKH38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeL5zpWtB2tX/zToDFxRl8nRvvH0oJw7/yY/0pzGf7nGxOXN63qDtWrYykzwtDGb9tNoOuOZFLGoZj2lTb41S639V7uL4TRXNT29olBnWdiq9kn6psem8aKS66a/JtKmScnnHlsnAPcKc8YPkNpIbLgLawfDCThqirXTnrDQikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON7rfcZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E63C4CEF0;
	Mon,  1 Sep 2025 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756735443;
	bh=0I395bScAfXDaELxzjx7kkUg8Yab6NEvTHxGLJFKH38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ON7rfcZrWkVmBjYtjlMhkKpQek1xpm3hU1TZGbJ6OOaING+Vrn9QuQ1ZfeI48TsG8
	 BA3Z9dKoifyKhxyV2JV1zAIVeDE8xdfc/P6cEA/ZUVM4SHjFbbaRRwnpd4bLlInZET
	 +SC9ca9otIPB3FTcRoLSoSQMimq8sw3dBcUXN/BKE6bJu4Z1brMcww598dC/ghhGPl
	 9CnMioU4rvmGR8TbEc2JzA69sCv9U8D7ogozmHtweIaiqWtWbfH3/BIjRLdPf5QxXo
	 tt3zFsHlWpUU/jpm4bGVq+8TjoE9xfHIx+6Uxr0xgk9Xvs3Vwd9n5loRXhVYywkWvk
	 /mmn9n/bmgjDg==
Date: Mon, 1 Sep 2025 19:33:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 5/9] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
Message-ID: <6f2hpdkonomgrfzqoupcex2rpqtlhql4lmsqm7hqk25qakp7ax@bfrzflghmnev>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-6-claudiu.beznea.uj@bp.renesas.com>
 <ddxayjj5wcuuish4kvyluzrujkes5seo7zlusmomyjfjcgzcyj@xe3zzzmy2zaj>
 <8ef466aa-b470-4dcb-9024-0a9c36eb9a6a@tuxon.dev>
 <zsgncwvhykw4ja3bbqaxwupppjsqq4pcrdgrsduahokmt72xsm@twekpse6uzzh>
 <CAMuHMdUu0uXBJndcwWoZp8NNyBJox5dZw4aoB8Ex50vBDDtP7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUu0uXBJndcwWoZp8NNyBJox5dZw4aoB8Ex50vBDDtP7g@mail.gmail.com>

On Mon, Sep 01, 2025 at 11:25:30AM GMT, Geert Uytterhoeven wrote:
> Hi Mani,
> 
> On Sun, 31 Aug 2025 at 06:07, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > On Sat, Aug 30, 2025 at 02:22:45PM GMT, Claudiu Beznea wrote:
> > > On 30.08.2025 09:59, Manivannan Sadhasivam wrote:
> > > > On Fri, Jul 04, 2025 at 07:14:05PM GMT, Claudiu wrote:
> > > >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > >>
> > > >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> > > >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> > > >> only as a root complex, with a single-lane (x1) configuration. The
> > > >> controller includes Type 1 configuration registers, as well as IP
> > > >> specific registers (called AXI registers) required for various adjustments.
> > > >>
> > > >> Hardware manual can be downloaded from the address in the "Link" section.
> > > >> The following steps should be followed to access the manual:
> > > >> 1/ Click the "User Manual" button
> > > >> 2/ Click "Confirm"; this will start downloading an archive
> > > >> 3/ Open the downloaded archive
> > > >> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> > > >> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> > > >>
> > > >> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> > > >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> > > >> +  ret = pm_runtime_resume_and_get(dev);
> > > >> +  if (ret)
> > > >> +          return ret;
> > > >> +
> > > >
> > > > Do you really need to do resume_and_get()? If not, you should do:
> > >
> > > It it's needed to enable the clock PM domain the device is part of.
> > >
> >
> > I've replied below.
> >
> > > >
> > > >     pm_runtime_set_active()
> > > >     pm_runtime_no_callbacks()
> > > >     devm_pm_runtime_enable()
> 
> > > >> +static int rzg3s_pcie_suspend_noirq(struct device *dev)
> > > >> +{
> > > >> +  struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
> > > >> +  const struct rzg3s_pcie_soc_data *data = host->data;
> > > >> +  struct regmap *sysc = host->sysc;
> > > >> +  int ret;
> > > >> +
> > > >> +  ret = pm_runtime_put_sync(dev);
> > > >> +  if (ret)
> > > >> +          return ret;
> > > >
> > > > Since there are no runtime callbacks present, managing runtime PM in the driver
> > > > makes no sense.
> > >
> > > The PCIe device is part of a clock power domain. Dropping
> > > pm_runtime_enable()/pm_runtime_put_sync() in this driver will lead to this
> > > IP failing to work as its clocks will not be enabled/disabled. If you don't
> > > like the pm_runtime_* approach that could be replaced with:
> > >
> > > devm_clk_get_enabled() in probe and clk_disable()/clk_enable() on
> > > suspend/resume. W/o clocks the IP can't work.
> >
> > Yes, you should explicitly handle clocks in the driver. Runtime PM makes sense
> > if you have a power domain attached to the IP, which you also do as I see now.
> > So to conclude, you should enable/disable the clocks explicitly for managing
> > clocks and use runtime PM APIs for managing the power domain associated with
> > clock controller.
> 
> Why? For the past decade, we've been trying to get rid of explicit
> module clock handling for all devices that are always part of a
> clock domain.
> 
> The Linux PM Domain abstraction is meant for both power and clock
> domains.  This is especially useful when a device is present on multiple
> SoCs, on some also part of a power domain,  and the number of module
> clocks that needs to be enabled for it to function is not the same on
> all SoCs.  In such cases, the PM Domain abstraction takes care of many
> of the integration-specific differences.
> 

Hmm, my understanding was that we need to explicitly handle clocks from the
consumer drivers. But that maybe because, the client drivers I've dealt with
requires configuring the clocks (like setting the rate, re-parenting etc...) on
their own. But if there is no such requirement, then I guess it is OK to rely on
the PM core and clock controller drivers.

Thanks for clarifying.

> > But please add a comment above pm_runtime_resume_and_get() to make it clear as
> > most of the controller drivers are calling it for no reason.
> 
> Note that any child device that uses Runtime PM depends on all
> its parents in the hierarchy to call pm_runtime_enable() and
> pm_runtime_resume_and_get().
> 

Two things to note from your statement:

1. 'child device that uses runtime PM' - Not all child drivers are doing
runtime PM on their own. So there is no need to do pm_runtime_resume_and_get()
unless they depend on the parent for resource enablement as below.

2. 'child devices depending on parents in the hierarchy' - Again, not all
child drivers require their parent to enable the resources. In those cases, they
can just call pm_runtime_set_active() and pm_runtime_enable() in their probe.
There is absolutely no need to do pm_runtime_resume_and_get() AFAIK (correct me
if I'm wrong).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

