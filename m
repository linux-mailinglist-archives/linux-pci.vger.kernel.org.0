Return-Path: <linux-pci+bounces-41374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8AC63304
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BFE735CAD0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9FB324B12;
	Mon, 17 Nov 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s16gOmgG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31162D7DC7;
	Mon, 17 Nov 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371753; cv=none; b=h9NPqxXUCeO5/BsrI/hi7gNme3pBJBHPpRFnVzg/f4y0uOe8/TMhX8gMEUKnhJaVkiaskyLuP3Hu706/Lhqhbx54MIMGbIX5m1TtBqz/GImVTqg1YfjTTCbYbi4nK1Ep/xQy4z75CnR1WXn4aLO1aSXHZ+RL02n1tmmXHanUsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371753; c=relaxed/simple;
	bh=EvfhddzpSjAUpbk6cAJyWuqhfd5As3u/pK+Q9MjlPCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwiyv1+ctSxBbnDACCy9euliOmNHQuASaPJSS+aJD8DYOUl++rrXumAkq1M/4N/qDZCIeJqhrAGBT/fi0peU5wsLVWUKcM4hGup6jP54ft+CiLDI5YG/VANvRem7QHBOxmsj0g3VuoFva9wP6YOce79PsFfjRDTSrOwbxBDhIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s16gOmgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E040C4CEFB;
	Mon, 17 Nov 2025 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763371751;
	bh=EvfhddzpSjAUpbk6cAJyWuqhfd5As3u/pK+Q9MjlPCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s16gOmgGUVKPAqiWs++keSoec+8iplKd+ZA9c8CDc2VzfqMtJrvxEMaDUSkjFleol
	 62idgoBXux7xRBcbcaQeTCv8H1Evpz6gjxCa+gKuF3plPK4BO//7UwHc1L2Z/tWsay
	 o45oCTnOdifacpFCrKPTGoD6/Mc0wNGMEzfZjYavJDdvGwIiHmytTDTdB/gaZexbcE
	 4S8j3/Zu7jIq4tkZTgd9SgYjglZKH8LqfIZCzcfhuJejTUPwe3Ex/nvS4LCE0P+KAC
	 P+hppMncliPGWnBN3H/JeNcRVAIechrv7o/RHeB09M2+m4Ens6eiCEktgeuU24jlkg
	 cZCnkHf5xuWNA==
Date: Mon, 17 Nov 2025 14:58:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, bhelgaas@google.com, Chen Wang <unicorn_wang@outlook.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, stable@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from
 tristate to bool
Message-ID: <k4yatufwwibauqxmm2nv6bh4clckk2j2xnpc2o5zjjpk7j7phk@ihrd2rsqdm64>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
 <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
 <250d2b94d5785e70530200e00c1f0f46fde4311b.camel@ti.com>
 <201b9ad1-3ebd-4992-acdd-925d2e357d22@app.fastmail.com>
 <7eaa4d917f7639913838abd4fd64ae8fe73a8cfc.camel@ti.com>
 <37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com>
 <8ac2ed36a85f854a54ee1d05599891632087869d.camel@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ac2ed36a85f854a54ee1d05599891632087869d.camel@ti.com>

On Mon, Nov 17, 2025 at 02:53:00PM +0530, Siddharth Vadapalli wrote:
> On Mon, 2025-11-17 at 10:06 +0100, Arnd Bergmann wrote:
> > On Mon, Nov 17, 2025, at 07:05, Siddharth Vadapalli wrote:
> > > On Fri, 2025-11-14 at 08:03 +0100, Arnd Bergmann wrote:
> > > > On Fri, Nov 14, 2025, at 06:47, Siddharth Vadapalli wrote:
> > 
> > > I understand that the solution should be fixing the pci-j721e.c driver
> > > rather than updating Kconfig or Makefile. Thank you for the feedback. I
> > > will update the pci-j721e.c driver to handle the case that is triggering
> > > the build error.
> > 
> > Ok, thanks!
> > 
> > I think a single if(IS_ENABLED(CONFIG_PCI_J721E_HOST)) check
> > is probably enough to avoid the link failure
> > 
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > @@ -669,7 +669,8 @@ static void j721e_pcie_remove(struct platform_device *pdev)
> >         struct cdns_pcie_ep *ep;
> >         struct cdns_pcie_rc *rc;
> >  
> > -       if (pcie->mode == PCI_MODE_RC) {
> > +       if (IS_ENABLED(CONFIG_PCI_J721E_HOST) &&
> > +           pcie->mode == PCI_MODE_RC) {
> >                 rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
> >                 cdns_pcie_host_disable(rc);
> > 
> > 
> > but you may want to split it up further to get better dead
> > code elimination and prevent similar bugs from reappearing when
> > another call gets added without this type of check.
> > 
> > If you split j721e_pcie_driver into a host and an ep driver
> > structure with their own probe/remove callbacks, you can
> > move the IS_ENABLED() check all the way into module_init()
> > function.
> 
> Thank you for the suggestion :)
> 
> Would it work if I send a quick fix for `cdns_pcie_host_disable` using
> IS_ENABLED in the existing driver implementation and then send the
> refactoring series later? This is to resolve the build error quickly until
> the refactoring series is ready.
> 

This will work for me so that this fix can be backported.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

