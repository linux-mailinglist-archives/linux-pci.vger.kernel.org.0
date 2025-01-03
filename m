Return-Path: <linux-pci+bounces-19266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5107A01018
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 23:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3216818812FB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0AC1BD004;
	Fri,  3 Jan 2025 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h10/5b8i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967291BBBC8
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735942259; cv=none; b=gaK9zSZJ1ke31jR9g+JclwI4KZ2qOTlbfNQ4b3G6abhLprp9l10DygJbcRXDEb94i/RD5iO0kMhAp85WKg8M/mc7oU6l22tmqhs6Qc4VZyNyS8gTsxlahfKvUxOra8DjWo4Aa/IovqGlFxO3Q2uZSsNCsynbNSvwYvH9DsxowIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735942259; c=relaxed/simple;
	bh=jMcJCe+/gVcM5Vr1TvXQ3zZRT0Kp/kVPd5o5PFhup/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=owi7tc6xWMd/VQVo8S/+mVIbso9lTDH7LzHhTEe3EAu4XD3D2TvoOkpI3Sgd+Y+dvRR5p9Braw1TpPY43FIDugUiCvQ6DEoRVWN2X3NEmEWFQl/Wh6d9/NCWR0t1SsesUHHCfCOhYPDZov2mcVKMYnPe95iPdFK0rn3UTCpVQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h10/5b8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90CFC4CECE;
	Fri,  3 Jan 2025 22:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735942259;
	bh=jMcJCe+/gVcM5Vr1TvXQ3zZRT0Kp/kVPd5o5PFhup/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h10/5b8iJ3LBZ6PLA7lEQw4vFqTVVoApQ8fxaV0BlhID4nOXGDfwJAzZUb3hJSHrE
	 PzwHaRvUYWWFyowcdcK5QjWFjQ22Hgwuhai0t+SyPeJjZQ5rWgr9sEGqNf6tcL+hLn
	 K7E5LvhOv9MgXCsP/4CAONah2PbA+mWhLOIVD597xco+URG20Ie0LZQb3dbOuUn+8m
	 E5c2FcoqYXCOcUxVpDHB2rMeTJPJX4Ox8tcOPFkx9Dy+En0fFUIq0y3RN+7Td7KqkX
	 985+Mv+IFi2tESbXK8p5XCB+CgPHa1PHlweF2FccIj/Fjb49QWDz0WVuIDoyODfICh
	 oA/KZUusEQ9iw==
Date: Fri, 3 Jan 2025 16:10:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Fix W=1 build warning in
 dw_pcie_edma_irq_verify()
Message-ID: <20250103221056.GA9766@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250102111339.2233101-2-cassel@kernel.org>

Can you make the subject say something about the fix instead of the
warning?  E.g., something about fixing a potential truncation?

On Thu, Jan 02, 2025 at 12:13:40PM +0100, Niklas Cassel wrote:
> Change dw_pcie_edma_irq_verify() to print the dma channel as %u.
> 
> While a DWC glue driver could theoretically initialize nr_irqs to a
> negative value, doing so would obviously be incorrect, and the later
> dw_edma_probe(struct dw_edma_chip *chip) call would fail, since while
> the dw_edma_probe() call expects the caller to initialize chip->nr_irqs,
> dw_edma_probe() verifies nr_irqs and returns failure if nr_irqs is < 1.
> 
> This fixes the following build warning when compiling with W=1:
> 
> drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
> drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
>   989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
>       |                                                  ^~
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since V1:
> -Do not reject negative nr_irqs value in dw_pcie_edma_irq_verify(),
>  as this will already be done by dw_edma_probe().
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3c683b6119c3..0a13fb4336f4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -986,7 +986,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
>  	}
>  
>  	for (; pci->edma.nr_irqs < ch_cnt; pci->edma.nr_irqs++) {
> -		snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
> +		snprintf(name, sizeof(name), "dma%u", pci->edma.nr_irqs);

I don't understand this fix.  I guess the warning is complaining that
sizeof(name) == 6, and "dma" takes up three bytes, so the %d has to
fit in the remaining region of size 3?

But I don't see how printing nr_irqs as unsigned rather than signed is
a fix, since even an unsigned int can be longer than 3 digits.

And I don't like using "%u" for a signed value in order to "fix"
something.  That's asking for a future cleanup to revert the change.

What's wrong with just making the name[] buffer big enough?

>  		ret = platform_get_irq_byname_optional(pdev, name);
>  		if (ret <= 0)
> -- 
> 2.47.1
> 

