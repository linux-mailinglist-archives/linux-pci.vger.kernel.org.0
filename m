Return-Path: <linux-pci+bounces-19270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86624A01147
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 01:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EB91884D5A
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 00:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140D3D66;
	Sat,  4 Jan 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFk4cr2g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F08F77
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735949994; cv=none; b=BDYYXG1BcB0Pte2KaVeENSpCk0EDGo1qVTgcFYt0sqkE3VpEAXsp2c2qfEcHN4xKzoUvsfnhQbjxBZEFEoFKVch6FjR2ZNeBb2JeSb8aD6K516NzNSNWYNQcsqx1rIlg8vJU81GTCxqFAErjTsl2ZFieRD0tBiW7rGrd8bCXsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735949994; c=relaxed/simple;
	bh=46KEX8fD9h8wCCqLKZNWkPZ6VL+RAR67wWbL9J5fFL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQi6jJTPAvcvnhxhqFKl6FPBjoFkZ9ZqaPkPn/ceFXCYCmFpt17hDkvLxu5fVKwjEskAlrtLCuq/JUfyhVWoLZTZFWxcPTxYC5+4Ji0URmG1QSlgF34StNAJ3mLyZisREPffVRnewe7XAoIdTIYXHv2TH26JCwcAhZPxL96UEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFk4cr2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81239C4CEDD;
	Sat,  4 Jan 2025 00:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735949993;
	bh=46KEX8fD9h8wCCqLKZNWkPZ6VL+RAR67wWbL9J5fFL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFk4cr2g63paLl349HZ6QZRX0QUW/X4PzrFOT0ZV4zIa++6llanD9DMIjQPQ6Hh0T
	 sCmJyiTDym6dYIfglyckSixzcnGYgiOP9hhoNT0bO6jDYwY5rbHXzX6iwxj7z+Vg9b
	 EXcg1Drd/Q7qeqBiixggrFxfpZdaQ3ktuGo7cZ+DPbxIB9KDbC4P6NH5WaoeM47hTz
	 NLUxoqxIhwJ38vnw9BSIWmKSUpEV4sm2C33DY4MHrlRtT4PRAixGPsGYdjCGDW/9tR
	 KBeRDfa+GeGyHjGhK+Hs3xIzCHEttw1iOrAbiOaIQpIUDwm1Ep2ZvimJdjEeZ3TK8t
	 OMa1scujdvZTA==
Date: Sat, 4 Jan 2025 01:19:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Fix W=1 build warning in
 dw_pcie_edma_irq_verify()
Message-ID: <Z3h-pFXG4zHiOMBJ@ryzen>
References: <20250102111339.2233101-2-cassel@kernel.org>
 <20250103221056.GA9766@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250103221056.GA9766@bhelgaas>

On Fri, Jan 03, 2025 at 04:10:56PM -0600, Bjorn Helgaas wrote:
> Can you make the subject say something about the fix instead of the
> warning?  E.g., something about fixing a potential truncation?
> 
> On Thu, Jan 02, 2025 at 12:13:40PM +0100, Niklas Cassel wrote:
> > Change dw_pcie_edma_irq_verify() to print the dma channel as %u.
> > 
> > While a DWC glue driver could theoretically initialize nr_irqs to a
> > negative value, doing so would obviously be incorrect, and the later
> > dw_edma_probe(struct dw_edma_chip *chip) call would fail, since while
> > the dw_edma_probe() call expects the caller to initialize chip->nr_irqs,
> > dw_edma_probe() verifies nr_irqs and returns failure if nr_irqs is < 1.
> > 
> > This fixes the following build warning when compiling with W=1:
> > 
> > drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
> > drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
> >   989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
> >       |                                                  ^~
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since V1:
> > -Do not reject negative nr_irqs value in dw_pcie_edma_irq_verify(),
> >  as this will already be done by dw_edma_probe().
> > 
> >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 3c683b6119c3..0a13fb4336f4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -986,7 +986,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
> >  	}
> >  
> >  	for (; pci->edma.nr_irqs < ch_cnt; pci->edma.nr_irqs++) {
> > -		snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
> > +		snprintf(name, sizeof(name), "dma%u", pci->edma.nr_irqs);
> 
> I don't understand this fix.  I guess the warning is complaining that
> sizeof(name) == 6, and "dma" takes up three bytes, so the %d has to
> fit in the remaining region of size 3?

Yes.


> 
> But I don't see how printing nr_irqs as unsigned rather than signed is
> a fix, since even an unsigned int can be longer than 3 digits.

You would need to ask GCC authors behind -Wformat-truncation why the
warning only seems to care about %d.


> 
> And I don't like using "%u" for a signed value in order to "fix"
> something.  That's asking for a future cleanup to revert the change.
>

Well, neither do I. V1 was a nicer solution IMO:
https://lore.kernel.org/linux-pci/20241220072328.351329-2-cassel@kernel.org/
But that fix was rejected by another PCI maintainer.


> What's wrong with just making the name[] buffer big enough?

Sure, I'll do that in v3.


Kind regards,
Niklas

