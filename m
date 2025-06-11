Return-Path: <linux-pci+bounces-29491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C64AD5F31
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 21:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFDC3AA137
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE29F27511A;
	Wed, 11 Jun 2025 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGkXm5jz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3D1F09B3;
	Wed, 11 Jun 2025 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670981; cv=none; b=Zgia9PVg5GNNBkNHCi/8UwwbqFXmfKZpS8YgknZlMpp8G4BVwaqjo570Fp7s76d6efBjDKPZwKf443E0+kKsZKXOmemeQ+EpEKCFoOPELY4Q/26OiPy3FDgKDKQbBtnRkQhLAH4m9KREH+lw5lA5ef36ndNKBdhp78r2fSIfXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670981; c=relaxed/simple;
	bh=7+2javrPWqSAk9Zpl9AulQcOQIGGbbbbRurwg6AeHZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cH9BhyE8HDCw72qQYnZYVI3akhQvUgC8hXnosybE1dSBtPCuRrz6s5fnw5PKHIemcrOM3XwNPRHPoKdgGnLskACL2VJkp1oi+Q+sTclYGpltRn2YVGVF+UREaTI01El9KG1BRE/+1pNsa7Lkw2tfjxSlz/U64BxDAXpBIbKDEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGkXm5jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADCFC4CEE3;
	Wed, 11 Jun 2025 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749670981;
	bh=7+2javrPWqSAk9Zpl9AulQcOQIGGbbbbRurwg6AeHZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HGkXm5jzFWs8lo2Rxe8xrG+ZpRTKtZMg2tULoy/ewNWO8y6xjTiELmi991KtFgw5d
	 0nvDZJkeQ9A7qRRbbUGOweTehA+Y6k1CAWNsVG90DiKNgwX49/9auuWJfCOKpOy/f4
	 s7BeJKzk1z0BrLGu5yXMNt8lGkuTWPJwKJjjpkSvaPAru11qBYugvEU9fnH2eauqmR
	 26P+STx7gehj/DYz8AGFoPjhJUIGuY/oqkJuxs7wSOdG+fyahFaDe8EWLTtVYUmmVJ
	 tJuPwveYHN1W1PzhNpIP6obWHuujk8J+eZFX947mcvr2Go5YPzcyRJ49Ulbt49iQrN
	 wEk3iYgr8vqig==
Date: Wed, 11 Jun 2025 14:42:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] PCI: pcie-rockchip: add Link Control and
 Status Register 2
Message-ID: <20250611194259.GA825364@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ae3286f3217881ae6ea3aecad47ae4567d6ec7.1749588810.git.geraldogabriel@gmail.com>

On Tue, Jun 10, 2025 at 06:19:49PM -0300, Geraldo Nascimento wrote:
> Link Control and Status Register 2 is not present in current
> pcie-rockchip.h definitions. Add it in preparation for
> setting it before Gen2 retraining.
> 
> While at it, also reference other registers from offset at
> Capabilities Register through standard PCI definitions. Only
> RC registers have been touched, although in principle there's
> no functional change.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 5864a20323f2..90d98aa8830e 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -155,17 +155,19 @@
>  #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
>  #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
>  #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
> -#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
> +#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
> +#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP)

I would really like to see PCI_EXP_DEVCAP referenced in the source
where we currently use PCIE_RC_CONFIG_DCR.  That way, cscope/tags/grep
will find the actual uses of PCI_EXP_DEVCAP, not just this #define of
PCIE_RC_CONFIG_DCR.

Something like this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?id=v6.15#n265

>  #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
>  #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
>  #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26

Also use PCI_EXP_DEVCAP_PWR_VAL and PCI_EXP_DEVCAP_PWR_SCL here if
possible.  And FIELD_GET()/FIELD_PREP(), which avoid the need to
define _SHIFT values.

I would do a pure conversion patch of the existing #defines.  Then I
suspect you wouldn't need a patch to add the Link 2 registers at all
because you could just use the #defines from pci_regs.h.

> -#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
> +#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL)
>  #define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
>  #define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
> -#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
> +#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP)
>  #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
> -#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> +#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL)
>  #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
> +#define PCIE_RC_CONFIG_LCS_2		(PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2)
>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>  #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
> -- 
> 2.49.0
> 

