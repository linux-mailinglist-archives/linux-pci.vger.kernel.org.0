Return-Path: <linux-pci+bounces-19275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D758A01248
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 05:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54C2161F39
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 04:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6C143725;
	Sat,  4 Jan 2025 04:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXLBg1tb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD7137742
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 04:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735965826; cv=none; b=WcJDMyxh/6jnZ8dbn2XBQ3fdhEbhrZ2PcZdDid95p42ZOt+Rl6jkejeCl7AaVSj1CyiggvqyHMfgkERtAS4NOTEJaLYjRYOfMU7n2P+1NUKuK104fZ5h2D47VNRlWt45lF5dngaHiAEIdZKENoyRNu8a62xLSLmSfOJYmzL32wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735965826; c=relaxed/simple;
	bh=m2QRyOXsW2X9xZHCn8psu+sGIScThHMdQ+vdi+bBQcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ55KLkX1gpZyH4kXA6F6lpKZSWDNmaMo6vUuDZr68/vibCc5Kvm0xACJC5TOt9o5CRX/9zz3O4ZALlftLGoyqhdjS/WuGARsztu4qSTtsChKXrJdZZ34MGu0SFwW3xo9FiNRdT/4NKQoxQKhQVRsi2uQv/F+0xeyy/ZTZQttfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXLBg1tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C1C4CED1;
	Sat,  4 Jan 2025 04:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735965826;
	bh=m2QRyOXsW2X9xZHCn8psu+sGIScThHMdQ+vdi+bBQcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXLBg1tbkKqSvUT1MdUpOtbKeACmNrlXz5ZqhharWXZjORizoE/KBDtU1OnVpOLsu
	 DNbRSXFdR99yC7+BxYhT+KvHJnUENnpLsPD+0V7TLvvqqmQlaJbsTO7IOlTf5zHbS9
	 qXUd778s92w7x0o6LqNydlPZNIGQu8ZoS522a4DI2vc70YkRxyMHMoYDn1mJDBxEkS
	 GYroRfb0KxgQD2fCUO7jd+TW4KiOcpyFSXBn1YQlwpGu1k5syoifC5Oi/VWadVa1ID
	 iJ+62CNA8zwWRVtXwTLTKOoW45ae3pW7bz6k36W9mEcO6HAdMwghi3bXSFk3W8htrJ
	 EVvj4HdgK3BBQ==
Date: Sat, 4 Jan 2025 05:43:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Fix potential truncation in
 dw_pcie_edma_irq_verify()
Message-ID: <Z3i8fQ8CRGzZuhUT@ryzen>
References: <20250104002119.2681246-2-cassel@kernel.org>
 <20250104042901.47qx5iiez3gkdtrt@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250104042901.47qx5iiez3gkdtrt@thinkpad>

On Sat, Jan 04, 2025 at 09:59:01AM +0530, Manivannan Sadhasivam wrote:
> On Sat, Jan 04, 2025 at 01:21:20AM +0100, Niklas Cassel wrote:
> > Increase the size of the string buffer to avoid potential truncation in
> > dw_pcie_edma_irq_verify().
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
> > Changes since v2:
> > -Simply increase the size of the string buffer instead of chaning the
> >  print format specifier.
> > 
> >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 3c683b6119c3..145e7f579072 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -971,7 +971,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
> >  {
> >  	struct platform_device *pdev = to_platform_device(pci->dev);
> >  	u16 ch_cnt = pci->edma.ll_wr_cnt + pci->edma.ll_rd_cnt;
> > -	char name[6];
> > +	char name[15];
> 
> Isn't 14 big enough to hold INT_MAX + 'dma'? Not a big deal, but asking just for
> the sake of correctness.

We need to be able to hold INT_MIN which is "-2147483648" 11 chars/bytes
+ "dma" 3 chars/bytes + terminating null byte (1 char/byte) = 15.


Kind regards,
Niklas

