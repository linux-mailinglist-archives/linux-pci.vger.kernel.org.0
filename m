Return-Path: <linux-pci+bounces-4948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A0881049
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDEE28339B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61BC29CEB;
	Wed, 20 Mar 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsYBNO41"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925AC1CD1D
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932064; cv=none; b=eXQakjD0Rk1fjfG6yIggzo37NItIct1Yk10rxGebRredstHbx6pYfKpG1n7N/dXpfRhXTCOMruwlaMEtkjkY9gxFxbP5OeowO6Go+b+XCTG6QMw0w2DDLZyPgO3lUPlf41X59nd4CJsaM5gHFejIwlrMQRmH/LfEZsDCjSrRpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932064; c=relaxed/simple;
	bh=RYQY/iOKM2gPKB/5AnEVVTjn5qRyMGKMtNkig/hbAmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRZqOiV5SeK+fauF5hCU5TnqNl7E4HcTRE8tu2E26yTI74CtYCb/UovdoK/rfIhDFk0q8O3zeZumDF2d7gP/KXn8lCQms09wssy3EfDXY5T9mWMRHTH/i6qPj3L5nvOohK/d4A5f8C0QEY4nKMuBo8LEWQ8Fxpq1ky+PWu+CDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsYBNO41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D141C43390;
	Wed, 20 Mar 2024 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710932064;
	bh=RYQY/iOKM2gPKB/5AnEVVTjn5qRyMGKMtNkig/hbAmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DsYBNO41gTubEvNtixNY+7wDk2PLaX01CRmJ4vUPJ/fMP/bkU4jmSR9AWbcwIFwFb
	 sWPc1KbUXev0lrEmsFkfRlOmQuuMyeUi7DxRHQrNL8KkvxM4CIVcW+oPLhFGGnRh4u
	 ApDXZAO5L6KBx1QLc6bTnxLTfVfUgw9o12fb55rGAoo1BB5vmZSOcsclXscGa+2kfI
	 3zlEj8eqH3gkJZBlOQ13xi6YlMxNkgwQYP5nObjNvMMf43Iggwd0HzzbJc3eYMR7jq
	 fC3Uu28Dj0RKHy/a/DiASq2S28qaH64Sv2vKTyamYanLCAAVE34CIQ5EqwZnF5aVd5
	 RDRuB630iCBuA==
Date: Wed, 20 Mar 2024 11:54:19 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI: endpoint: pci-epf-test: Fix incorrect loop
 increment
Message-ID: <ZfrAW1YGjFTF4hrj@ryzen>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-2-cassel@kernel.org>
 <20240315052045.GA3375@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315052045.GA3375@thinkpad>

On Fri, Mar 15, 2024 at 10:50:45AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 13, 2024 at 11:57:53AM +0100, Niklas Cassel wrote:
> > pci_epf_test_alloc_space() currently skips the BAR succeeding a 64-bit BAR
> > if the 64-bit flag is set, before calling pci_epf_alloc_space().
> > 
> > However, pci_epf_alloc_space() will set the 64-bit flag if we request an
> > allocation of 4 GB or larger, even if it wasn't set before the allocation.
> > 
> 
> Max BAR size is 1MB currently, so I believe you are adding the check just for
> the sake of correctness. If so, please mention it explicitly.

The BAR size defined in:
static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
will only be used if the BAR is not fixed size.
(A fixed BAR size will override the size in static size_t bar_size[])

So a platform could have a fixed size BAR of e.g. 4GB.

Although, you could argue that if a platform has a fixed BAR size of 4GB,
they should have also marked the BAR as "only 64-bit".
(Considering that the largest size supported by a 32-bit BAR is 2GB.)

I will drop this patch in V4.


Kind regards,
Niklas


> 
> - Mani
> 
> > Thus, we need to check the flag also after pci_epf_alloc_space().
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index cd4ffb39dcdc..01ba088849cc 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -865,6 +865,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  			dev_err(dev, "Failed to allocate space for BAR%d\n",
> >  				bar);
> >  		epf_test->reg[bar] = base;
> > +
> > +		/*
> > +		 * pci_epf_alloc_space() might have given us a 64-bit BAR,
> > +		 * if we requested a size larger than 4 GB.
> > +		 */
> > +		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.44.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

