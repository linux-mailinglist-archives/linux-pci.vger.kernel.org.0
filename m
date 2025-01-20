Return-Path: <linux-pci+bounces-20160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ACFA16FD6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 17:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD061885048
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDCE1DF989;
	Mon, 20 Jan 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPTJxnEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1C18FDC8
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389257; cv=none; b=otOXJg6svPtlgFx/7aX5CJ+zsZZAGKJFRSxtquQ6McBwSKy3EMdrBi5AyaVXj0IdpR4rj0zkABkmIBx1+e+dJiOoq6lXQmgGJF3S9kr6GRbCC7QQOtB5ARKNF8LCLQlzAtoNLpshWbs+5HqKsYGgpye5lE5x3p6iqxW7UEPf3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389257; c=relaxed/simple;
	bh=9CVDsPv7+I4dHA9V07UlO6Byu0jdGe03uk9dzrJWMgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmcHuPyWHzGv+jme+rgeTJkpDJq7KmvsZepzW7/S/9jONEXSKk3xHUNdIcyvYx05likHp/7RwCUV5F3bfIcl7vxNbzZmXwk95qtzDZLDH6+p/ER+FlvdVygc+OTBgWWEFMSxlITeb0LeghGKwE8CD9qlv6PjuSaeJM/0kMd2YRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPTJxnEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E31BC4CEDD;
	Mon, 20 Jan 2025 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737389257;
	bh=9CVDsPv7+I4dHA9V07UlO6Byu0jdGe03uk9dzrJWMgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPTJxnEAijwNDV9rnHIghLRX3N5Y8dW1MqBvtEiFnvc02hEyeGOVg9v1PLvfI8jn6
	 Ofx8cF/HNRluffbadhkTkv3VTN7jDdBNZLi5m+1FBPg1YY1bnN4kQZIBxFwx0TFqsm
	 Kj+1vefzZ0VQkWvezjTbAu8LmiGFxN59W6XDinMg632pWENHn3Xs5KNwI2j1ILdu+Q
	 pu4M3BPEfkU+X79ajFpWtopGKEXNPdSanBz3zH5XBmVawnDG+bJxc51aftQ/EWhgfZ
	 rWuOaLw/4lIMqNpG+Idpc0Evs5h1eII21l/+eYZ3sx/rJDCtnHNLbPASeSLQQ3aVAT
	 +Hxl0CQuFvG8g==
Date: Mon, 20 Jan 2025 17:07:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <Z450xJve4u0eqVIY@ryzen>
References: <20241203063851.695733-5-cassel@kernel.org>
 <20250118203421.GA790917@bhelgaas>
 <Z446zwlcPt8dv5lx@ryzen>
 <20250120154415.6abry7rkuchehfjx@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120154415.6abry7rkuchehfjx@thinkpad>

On Mon, Jan 20, 2025 at 09:14:15PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 20, 2025 at 01:00:15PM +0100, Niklas Cassel wrote:
> > Hello Bjorn,
> > 
> > On Sat, Jan 18, 2025 at 02:34:21PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Dec 03, 2024 at 07:38:53AM +0100, Niklas Cassel wrote:
> > > > The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> > > > which allocates the backing memory using dma_alloc_coherent(), which will
> > > > return zeroed memory regardless of __GFP_ZERO was set or not.
> > > 
> > > > +static void pci_epf_test_set_capabilities(struct pci_epf *epf)
> > > > +{
> > > > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > > > +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > > > +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > > > +	struct pci_epc *epc = epf->epc;
> > > > +	u32 caps = 0;
> > > > +
> > > > +	if (epc->ops->align_addr)
> > > > +		caps |= CAP_UNALIGNED_ACCESS;
> > > > +
> > > > +	reg->caps = cpu_to_le32(caps);
> > > 
> > > "make C=2 drivers/pci/" complains about this:
> > > 
> > >   drivers/pci/endpoint/functions/pci-epf-test.c:756:19: warning: incorrect type in assignment (different base types)
> > >   drivers/pci/endpoint/functions/pci-epf-test.c:756:19:    expected unsigned int [usertype] caps
> > >   drivers/pci/endpoint/functions/pci-epf-test.c:756:19:    got restricted __le32 [usertype]
> > 
> > Yes, pci-epf-test is broken when it comes to endianness, as reported here:
> > https://lore.kernel.org/linux-pci/ZxYHoi4mv-4eg0TK@ryzen.lan/
> > 
> > 
> > Nice to see that sparse is complaining about it! :)
> > 
> > Mani said that he was going to work on it, but I guess that it fell through
> > the cracks.
> > 
> 
> It doesn't but I put it in the back burner due to other high priority issues to
> fix.

I know that feeling :)

Yeah, I know you have been very busy lately :)

Have a nice evening!


Kind regards,
Niklas

