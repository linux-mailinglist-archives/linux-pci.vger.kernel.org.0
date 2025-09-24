Return-Path: <linux-pci+bounces-36826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658FB9821C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 05:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C481C3BA808
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 03:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B82264BA;
	Wed, 24 Sep 2025 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsRZYHkJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEA4D599;
	Wed, 24 Sep 2025 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758684364; cv=none; b=BwZ0DZxEcKHj+w1PO6gsh3jt/hcGzFuuFCENdVdC+emQdH2yNaevy2UIZCCWMb4g89aA4yIYjWBeN55EdcrWg1qXQIxyotnwr2Mijlqtw48c4AMOzgqF+Y7OKgFFtBSziEEYQKU5kjhQv67t/iyAoS6sigsmXfOMrmW1Zx7uJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758684364; c=relaxed/simple;
	bh=/o8ymzn3T323RpakrbeA3IbprMTOrPkBwJfbYHP8p/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or6FnMqxjxUA6Mr7o7td4s5IaBgu8NpoCF5sP/X2Fnhi+RCsxVC+uxmg12kCHQatj8/kppeJVJZ3IuH0TP6xynqxnPrejXD3SkFGG5nZIacI1rpSM6u3amRb1U0R1R9UKha3DesNdUWq7ABrnSP1WNmbxcdBUz+RDIYdL4+LsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsRZYHkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D61C4CEF5;
	Wed, 24 Sep 2025 03:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758684362;
	bh=/o8ymzn3T323RpakrbeA3IbprMTOrPkBwJfbYHP8p/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsRZYHkJ9zr0PyHuDufKFSOOB8lvcZx1UXfxJyH3382Dw340ubaR8M/V6Vwi2y9+4
	 lwB8gW8fB6vYwITnA+1sfF4romikUw9pw0ql6QFvjdPO0VjJAdY1e10/WEr3MYUs6w
	 vpV+EYM1f0attOWlD3zuUWKNYnKNNvKZ4mZhaDqyjcYwhYH3C3m1JLnUFxVBVljHfp
	 uDxyC544BqiMoMCaA0V5PdfKZMDqPZ7m3YCcF/ArFXPVn12f8fQe5G1DFvcjwUTta0
	 oEQUiR0u3yZzRrieJesaVCdajnUdJUJEqqQqWAjbpINP5QYITVSGrY4jW1GqVPY84G
	 y4BhKVsxfcPbg==
Date: Wed, 24 Sep 2025 08:55:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-host: Add static assertion to check
 !PCI_LOCKLESS_CONFIG
Message-ID: <ebcvi2mput6dyx5omlcvapjt6mwzrpq4h6c4o3kyfdxfrin35x@d75pxu652f6u>
References: <20250923234644.82890-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923234644.82890-1-marek.vasut+renesas@mailbox.org>

On Wed, Sep 24, 2025 at 01:46:18AM +0200, Marek Vasut wrote:
> This driver can not function correctly without PCIe subsystem level
> config space access serialization. In case PCI_LOCKLESS_CONFIG is
> ever enabled on ARM, complain loudly so the driver can be updated
> accordingly.
> 

This limitation applies to almost all host controller drivers except those used
on Intel platforms like VMD and Hyper-V. So this would require adding the
Kconfig dependency for all those, not just for RCAR.

We could also add the dependency to the arch Kconfig, but there is still a
possibility that if the driver is used on a platform selecting
PCI_LOCKLESS_CONFIG, it would be broken silently. So adding the dependency to
the individual drivers that suffer from the limitation seems to be the right
thing to do.

Also, I'm not in favor of adding static_assert with Kconfig dependency in place.

- Mani

> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: Add depends on !PCI_LOCKLESS_CONFIG into Kconfig file, to prevent
>     this from being built when PCI_LOCKLESS_CONFIG is not set at all
> ---
>  drivers/pci/controller/Kconfig          | 1 +
>  drivers/pci/controller/pcie-rcar-host.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 41748d083b933..3f489bed289fb 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -244,6 +244,7 @@ config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe controller (host mode)"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on PCI_MSI
> +	depends on !PCI_LOCKLESS_CONFIG
>  	select IRQ_MSI_LIB
>  	help
>  	  Say Y here if you want PCIe controller support on R-Car SoCs in host
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 213028052aa58..29e13f7ff7ff1 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -35,6 +35,14 @@
>  
>  #include "pcie-rcar.h"
>  
> +/*
> + * This driver can not function correctly without PCIe subsystem level
> + * config space access serialization. In case PCI_LOCKLESS_CONFIG is
> + * ever enabled on ARM, complain loudly so the driver can be updated
> + * accordingly.
> + */
> +static_assert(!IS_ENABLED(CONFIG_PCI_LOCKLESS_CONFIG));
> +
>  struct rcar_msi {
>  	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>  	struct irq_domain *domain;
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

