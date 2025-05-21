Return-Path: <linux-pci+bounces-28193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F26ABF060
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183CF4E3F8B
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7086259C8B;
	Wed, 21 May 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8hLmQXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989F230BDF;
	Wed, 21 May 2025 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820760; cv=none; b=gujsUmcrhLfX/FfQcQcPbzKN9wRKEdTjsbVql0PJjbHHY8giNcXE2qpxK+ge4hYVktVPpM9vgzA48jqxL5zQ3F9iFfVHYx7NoS6o4sjAIidf/eDdUInR6/xUHhYq4fmBZKbEQ5YzVFtogH8tyK+Ln9fgEo6PbVx0ruTzbd7JeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820760; c=relaxed/simple;
	bh=7RivNfJQ1tM6ITxUNsv+CWRaSsbDI8HVCn9mI4Hvzik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpYUKlRaMyd+ChRF9mY28ManBOFXgUYBMSYMIZKbwHwHpyZ0BGIqgRZNYXzBCcJC+a8IRti8fpcK5VsFzhaFjPhh9Jwx113FY2JkpijNG+BQ0w7AKcf+LuBf2p/PxnM+fi8Ekkh2HhQlJpyBgaF07g6DKZwuKPYAFWzkXcJJpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8hLmQXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C52C4CEEA;
	Wed, 21 May 2025 09:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747820760;
	bh=7RivNfJQ1tM6ITxUNsv+CWRaSsbDI8HVCn9mI4Hvzik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8hLmQXVmY/w2GWyB6vXjojnqvRerNfVmKYr2A4cFZqWB9JqefvaWU3Qxk4tpTn/g
	 yOgTv6KuDHFD87htzZ0Eb9dlJINuZW2s4UQ8vHUo/7U9ZsTZfOCV4Z2yRP2n5vp0Pm
	 db2tNS7X4EY1xkQ4XcP0Tt5jHdzgoHcHU8dnasUDOjgGZZeUWFr/Pji6llF8dJpAQu
	 ol0NawpfzfWVEYeaDLeYkdC/SFZT3UMbfI0BwGCASOIpDdvJSww2OmcfpyN6VHSdNO
	 EnkeiRtbzv4gYFsKZAcCApI19l6pmk88phgqAWkrouLCHRkXerBB/vGf5E5IIhfa8G
	 Pw1CXtHMHF2og==
Date: Wed, 21 May 2025 11:45:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, 
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com, 
	Hrishikesh Dileep <hrishikesh.d@samsung.com>
Subject: Re: [PATCH 03/10] PCI: exynos: Reorder MACROs to maintain consistency
Message-ID: <20250521-mysterious-mole-of-priority-8a5f4d@kuoka>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193235epcas5p4f0bcf581b583a3acf493a20191ad2b00@epcas5p4.samsung.com>
 <20250518193152.63476-4-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-4-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:45AM GMT, Shradha Todi wrote:
> Exynos PCI file follows MACRO definition order where
> register offset is defined in ascending order and each
> bit field within the offset is defined right after offset
> definition. Some MACROs are out of order and so reorder
> those MACROs to maintain consistency.
> 
> Suggested-by: Hrishikesh Dileep <hrishikesh.d@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 990aaa16b132..286f4987d56f 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -27,11 +27,11 @@
>  
>  /* PCIe ELBI registers */
>  #define EXYNOS_PCIE_IRQ_PULSE			0x000
> +#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
>  #define EXYNOS_IRQ_INTA_ASSERT			BIT(0)
>  #define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
>  #define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
>  #define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
> -#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
>  #define EXYNOS_PCIE_IRQ_EN_LEVEL		0x010
>  #define EXYNOS_PCIE_IRQ_EN_SPECIAL		0x014
>  #define EXYNOS_PCIE_SW_WAKE			0x018
> @@ -42,12 +42,12 @@
>  #define EXYNOS_PCIE_NONSTICKY_RESET		0x024
>  #define EXYNOS_PCIE_APP_INIT_RESET		0x028
>  #define EXYNOS_PCIE_APP_LTSSM_ENABLE		0x02c
> +#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
>  #define EXYNOS_PCIE_ELBI_RDLH_LINKUP		0x074
>  #define EXYNOS_PCIE_ELBI_XMLH_LINKUP		BIT(4)
> -#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
>  #define EXYNOS_PCIE_ELBI_SLV_AWMISC		0x11c
>  #define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
> -#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
> +#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)

What changed here? Why you cannot fix indentation while renaming?

Best regards,
Krzysztof


