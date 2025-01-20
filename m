Return-Path: <linux-pci+bounces-20159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6514BA16F7B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 16:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E008188057C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5211E32A2;
	Mon, 20 Jan 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlhfJ0e/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1321348
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387868; cv=none; b=bg0nLxpIb8NPuc79x4l39XsYOE+VIbzFpR8wQbHHbUKsS3FjuHt+B59cW6MJJvu0Ivsiu61j97U4wIalnxJQmNsjiEk0LgtQd17vTrsiesVnapF7cVj+Iv0odB1yE0ewNLFSqUdy1sgcD59PQJYTInk+i5ShNy3jJctr+HHoloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387868; c=relaxed/simple;
	bh=p/J+nb89PTXa3QMIZ/OwGescyOice/686JeYVwNbo3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3VwIm9zIfP114jzAuYoNUT0ApZsTHHC2G8qZ1Xl0yD6HFmKA/7pCFIFFLbHQ56L6yE3psfdkZLaytTVTs91LTK4x0zaOdy4KNWwwX0iexlm1GyUSKSDUYL30s8z1KtSIJLIaWo9NtAOSTSsl54rGhR3Q629DRZAaJCBQX/aKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlhfJ0e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14047C4CEE3;
	Mon, 20 Jan 2025 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737387867;
	bh=p/J+nb89PTXa3QMIZ/OwGescyOice/686JeYVwNbo3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlhfJ0e/at+CJ7E8JcYOsIoKXJEZgX9SINNJe4qr65EqgIMZwvM3hwmiQpTTuBR/6
	 1eVQsV5uzxqkj/OefillcWnMjajyuxa4vzA2s3b62cSmuWohmBPzBhJUrCDlNHFhRX
	 u/dXD+WFTrIgyCg2M96as8nhSJACwNU5Hg/Sq4/4+MvFKewDigDiuGfJ8EoAa2ajYE
	 G1/1zQN0p0WSgM8xXFhvg2wVrWmr+73y5NuD2T4lh0OncVZKKB6KHW3B7zJV5pJvJr
	 XwK8BLXq4C9iA2XUhrztHf217qLEb60ZCPfvG/cUCpx45vFInDLIbhemGfqllwKKm8
	 UH+ZkP3AN5vrQ==
Date: Mon, 20 Jan 2025 21:14:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <20250120154415.6abry7rkuchehfjx@thinkpad>
References: <20241203063851.695733-5-cassel@kernel.org>
 <20250118203421.GA790917@bhelgaas>
 <Z446zwlcPt8dv5lx@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z446zwlcPt8dv5lx@ryzen>

On Mon, Jan 20, 2025 at 01:00:15PM +0100, Niklas Cassel wrote:
> Hello Bjorn,
> 
> On Sat, Jan 18, 2025 at 02:34:21PM -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 03, 2024 at 07:38:53AM +0100, Niklas Cassel wrote:
> > > The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> > > which allocates the backing memory using dma_alloc_coherent(), which will
> > > return zeroed memory regardless of __GFP_ZERO was set or not.
> > 
> > > +static void pci_epf_test_set_capabilities(struct pci_epf *epf)
> > > +{
> > > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > > +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > > +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > > +	struct pci_epc *epc = epf->epc;
> > > +	u32 caps = 0;
> > > +
> > > +	if (epc->ops->align_addr)
> > > +		caps |= CAP_UNALIGNED_ACCESS;
> > > +
> > > +	reg->caps = cpu_to_le32(caps);
> > 
> > "make C=2 drivers/pci/" complains about this:
> > 
> >   drivers/pci/endpoint/functions/pci-epf-test.c:756:19: warning: incorrect type in assignment (different base types)
> >   drivers/pci/endpoint/functions/pci-epf-test.c:756:19:    expected unsigned int [usertype] caps
> >   drivers/pci/endpoint/functions/pci-epf-test.c:756:19:    got restricted __le32 [usertype]
> 
> Yes, pci-epf-test is broken when it comes to endianness, as reported here:
> https://lore.kernel.org/linux-pci/ZxYHoi4mv-4eg0TK@ryzen.lan/
> 
> 
> Nice to see that sparse is complaining about it! :)
> 
> Mani said that he was going to work on it, but I guess that it fell through
> the cracks.
> 

It doesn't but I put it in the back burner due to other high priority issues to
fix.

> I sent patch for it here:
> https://lore.kernel.org/linux-pci/20250120115009.2748899-2-cassel@kernel.org/T/#u
> 

Thanks a lot!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

