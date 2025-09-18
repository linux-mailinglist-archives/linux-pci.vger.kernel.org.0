Return-Path: <linux-pci+bounces-36437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0457B86D35
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 22:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14977C102F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 20:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5A2D3732;
	Thu, 18 Sep 2025 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd4zarWQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6AB15442C;
	Thu, 18 Sep 2025 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225888; cv=none; b=FselSpLiGp00bwAKBny+ZC0C76e9jAHm369B/SIrXouh14C+AKUv24/0u2IBCI9/k+yEZOFknWgTqmrxoozc17PfkCFUzZc+NPoGjV48YgaH23PNpB9g6IiEeL2sBJp+8uovZrIgbuFvtNbcxn2UDALxPhsxGpYCIJkZxL2q0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225888; c=relaxed/simple;
	bh=Y56ri+HOpi9AkcrgOS+6En+ayGtIS3/lH18Vzeoj5UU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sNLGvu7hKTTlB5CHKvkSWVouv9dOmtAmShVxTazLxNYhYVq8Nxbj01NKcY6lO8IJJyF7KL0CsTqyQbum5iap3I5nkFBrjDKgwP4+iEPLPHQb4C2fYATPgeUCHRvQLFCvkh0aMxB0KTXZBODsLsWylxGjtIYgpAJqdyknv2Rs8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd4zarWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509B0C4CEF1;
	Thu, 18 Sep 2025 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758225888;
	bh=Y56ri+HOpi9AkcrgOS+6En+ayGtIS3/lH18Vzeoj5UU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dd4zarWQCaCMh0RZpW0cjKR1Jx9zVE3jMTNongvGFtU0RnrWXU5Sg/bf45O72imyq
	 VyLvi0xZVnX77BNA7j1pBcwFQvx/Ftnt5c63IhQDGZ8umopp7mB8FQoBxdgSUqRRGv
	 dYLsl3dykF5aqwrjQueS6uzuxMJzPaKH0MMBxKgYemb2z0bnQ/K0IeA7dl2Q+8zNlQ
	 frU+TvtSXMMJ4wWaX6syw4mwOnkRYSaHj30dPvNVp5uNDA0sNpnyV2KxTCrRom2xMH
	 IhHto27MFEgOiIRWtAuN3X4n1JaVwSDeAGvSFiKocQwTsD+JonFkr0i7SEQqBojFiN
	 PIkwKPoUfWYGg==
Date: Thu, 18 Sep 2025 15:04:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
Message-ID: <20250918200447.GA1919114@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918030058.330960-1-marek.vasut+renesas@mailbox.org>

On Thu, Sep 18, 2025 at 05:00:26AM +0200, Marek Vasut wrote:
> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
> Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
> domain, after reset has been asserted by writing a matching reset bit into
> register SRCR, it is mandatory to wait 1ms.

> @@ -182,8 +182,10 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>  		return ret;
>  	}
>  
> -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> +		usleep_range(1000, 2000);

What would you think of "fsleep(1000)"?

I know there's controvery about fsleep(), but while the 1000 usec
lower bound is important, I think the selection of the 2000 usec upper
bound is pretty arbitrary and doesn't really justify spelling it out.

> +	}
>  
>  	val = readl(rcar->base + PCIEMSR0);
>  	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
> -- 
> 2.51.0
> 

