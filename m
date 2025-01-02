Return-Path: <linux-pci+bounces-19155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17EF9FF87A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A72188216D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A7374CB;
	Thu,  2 Jan 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWN61Kxr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A55125D6
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735815457; cv=none; b=akdUCi6NYxung41TidOoFLXf5OViPesqmGSC7aFGPVPHNQx3B+iygLoJqtq6+BGhobQJknx6LUXHH1aqyn3W9CKWnBPlmU+MjAxsyWxcFDROmY6C9NkKUQKnATW7MHQLna3rRnbvfmPrVMlAQSOGp+Wibm7GfoMInlLQSzZ1lKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735815457; c=relaxed/simple;
	bh=jYQGhT42EsutXFIPYlsP1xCkgXwU2aDPBqiXLufYMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKc/megBMsAm5RF3C0eC70MYMshxxQfn+OfxihXVMVH3BZ/DPo6qNQA7D/vTGMVWVmcJyjiUEM6DjLuEPXdz2g2qvVpTbfjcrKmq5Yimtza5qRtH3Tzo7LmyKIUhHQK8fYoa31lmj26MeGAtho0/ZZ1ZZCtimgDg9pSlEdq+cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWN61Kxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE29C4CED0;
	Thu,  2 Jan 2025 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735815456;
	bh=jYQGhT42EsutXFIPYlsP1xCkgXwU2aDPBqiXLufYMfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWN61Kxr6Y30pk0RzuLyFgWLbKXfa0p4pm6EGE3jxJGQQKWlxYKzeboIFsFgmeykU
	 a8G+t3Qw5nt6Gdfwju50ns4DpL8z9slTYX7UxbIrr/9KgKytUQdLuH71t1CNvljVR0
	 RsGwltYk8db2hsJIX1bN5E4vi/Tfg6b+FIFp3Ue/EsWPMA36a0q15Mkv9oMca8ATeN
	 axf+W2DfkkUnJ/YocRbYsZnDABGG1ZU9gOUAkN0iVgLnMpBdb55b+SekOKaWI6e21l
	 B0Es6Q3fIQaNSQlnGaFbzxP/omfceK7ubWI3eemVxfLpquoBPu1zQgbQFOlVmYbxkC
	 pxjj/2DbuHl8Q==
Date: Thu, 2 Jan 2025 11:57:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Reject a negative nr_irqs value in
 dw_pcie_edma_irq_verify()
Message-ID: <Z3ZxHLfN7rcpH414@ryzen>
References: <20241220072328.351329-2-cassel@kernel.org>
 <20241231155158.5edodo2r5zar3tfe@thinkpad>
 <Z3Q0TY873woxmsEC@ryzen>
 <20241231184913.s24umoi2yi4wowod@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231184913.s24umoi2yi4wowod@thinkpad>

On Wed, Jan 01, 2025 at 12:19:13AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 31, 2024 at 07:13:33PM +0100, Niklas Cassel wrote:
> > On Tue, Dec 31, 2024 at 09:21:58PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Dec 20, 2024 at 08:23:29AM +0100, Niklas Cassel wrote:
> > > > Platforms that do not have (one or more) dedicated IRQs for the eDMA
> > > > need to set nr_irqs to a non-zero value in their DWC glue driver.
> > > > 
> > > > Platforms that do have (one or more) dedicated IRQs do not need to
> > > > initialize nr_irqs. DWC common code will automatically set nr_irqs.
> > > > 
> > > > Since a glue driver can initialize nr_irqs, dw_pcie_edma_irq_verify()
> > > > should verify that nr_irqs, if non-zero, is a valid value. Thus, add a
> > > > check in dw_pcie_edma_irq_verify() to reject a negative nr_irqs value.
> > > > 
> > > 
> > > Why can't we make dw_edma_chip::nr_irqs unsigned?
> > 
> > dw_edma is defined in drivers/dma/dw-edma/dw-edma-core.h
> > in struct dw_edma.
> > 
> > struct dw_pcie (defined in drivers/pci/controller/dwc/pcie-designware.h)
> > simply has a struct dw_edma as a struct member.
> > 
> > If you bounce on nr_irqs in:
> > drivers/dma/dw-edma/dw-edma-core.c
> > and in
> > drivers/dma/dw-edma/dw-edma-pcie.c
> > you can see that this driver uses signed int for this everywhere.
> > 
> > I didn't feel like refactoring a whole DMA driver.
> > 
> 
> There is no need to refactor. Both 'dma' and 'dwc' drivers do not assume that
> 'nr_irqs' is signed. So simply changing the type to 'unsigned int' is enough.
> I don't see a valid reason to keep it signed and check for negative value.

If you bounce on nr_irqs in
drivers/dma/dw-edma/dw-edma-core.c
and in
drivers/dma/dw-edma/dw-edma-pcie.c

you will see that there are a lot of local variables
that are nr_irqs which are signed, in addition to the
struct member.

I don't want to change the whole driver simply to fix
a warning when building the DWC PCIe driver with W=1.

I have a different solution and will send a V2 soon.


Kind regards,
Niklas

