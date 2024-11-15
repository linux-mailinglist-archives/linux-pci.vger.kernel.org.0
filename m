Return-Path: <linux-pci+bounces-16908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE8A9CF2CC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9D62911DE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BE1D5AAD;
	Fri, 15 Nov 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcXaPIm6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CD84D02;
	Fri, 15 Nov 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691538; cv=none; b=h6SFhldbPj5i8ggZs0+V2tjhEDS1Am+mZt0HCDPFs+dph/XKHQ8C1d2x5wkzFAr18l5lTuD2/L1GgA2g/2m5m66DkUwHonmlUKU6uMNefc8uvSOJyJNR5Xe1erYLZg7JgSe7jHKoqRFXcisAgrcxoyNuPgBa5xMxx9kKsUg7ILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691538; c=relaxed/simple;
	bh=B5HD6FNYjbwvelKHX9O/ZdMyYIKdSlEvRVWHBFf74j8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IhoWxrCvGUMEc9oMLP/lCgnvFt4dAPy7peiGQ2E4w7qlQTxGqTxVaL17GTAxa7hoF6l2FB+WZFwRoD/Emr/xu1ElQ3S0iPkHKrfNl21CMcjJ+KR7o0L1Nuw4Spd7wAwNTv6tCVSRtcwIb7yyZP6soP6HTtdVxXWlgLO8TRt4n6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcXaPIm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7167C4CECF;
	Fri, 15 Nov 2024 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731691537;
	bh=B5HD6FNYjbwvelKHX9O/ZdMyYIKdSlEvRVWHBFf74j8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WcXaPIm6WdUXfZSjMdG+JVztfyMit+f2yPV6YeN1NZzQXkpO0wmt1PgI3au1RF50R
	 LHUBGZ0Cvt86wCrxygPt98TmAcFHPzMWjkT3D1CDHcOtALCHGLjhUqBMq2esM83LRq
	 dC66w/GliM5szwN6wE+X7c/6i3JYnQuI/lnIZY+ygQMmilIqVDGWBQ0s7jdMYZPnhZ
	 LGzZEKSxuQVpXUUyDg6A0Nff5ZAb+Z2yKW0E2cNDRAc4xifpGzAGBPW56dlr5j/X/S
	 hRyM4fl66Rjw6Ohf2wPWaNZLQ3guLNCoFS6Dfkw4CK7FEwjGTwli+8n9i49ABjNtR7
	 cN9Lq0wdTNFLw==
Date: Fri, 15 Nov 2024 11:25:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: of_property: Assign PCI instead of CPU bus address
 to dynamic PCI nodes
Message-ID: <20241115172534.GA2044163@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108094256.28933-1-andrea.porta@suse.com>

On Fri, Nov 08, 2024 at 10:42:56AM +0100, Andrea della Porta wrote:
> When populating "ranges" property for a PCI bridge or endpoint,
> of_pci_prop_ranges() incorrectly use the CPU bus address of the resource.
> In such PCI nodes, the window should instead be in PCI address space. Call
> pci_bus_address() on the resource in order to obtain the PCI bus
> address.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Herve Codina <herve.codina@bootlin.com>

I picked this up on pci/of for v6.13, thanks!  Rob, let me know if
you'd prefer to take it or ack/review it.

> ---
> This patch, originally preparatory for a bigger patchset (see [1]), has
> been splitted in a standalone one for better management and because it
> contains a bugfix which is probably of interest to stable branch.
> 
>  drivers/pci/of_property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 5a0b98e69795..886c236e5de6 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -126,7 +126,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>  		if (of_pci_get_addr_flags(&res[j], &flags))
>  			continue;
>  
> -		val64 = res[j].start;
> +		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
>  		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
>  				   false);
>  		if (pci_is_bridge(pdev)) {
> -- 
> 2.35.3
> 

