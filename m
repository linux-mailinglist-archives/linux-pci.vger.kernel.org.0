Return-Path: <linux-pci+bounces-12631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891D968E60
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 21:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706BBB22CCA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2981A2644;
	Mon,  2 Sep 2024 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/2GE23d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220619CC3E;
	Mon,  2 Sep 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304710; cv=none; b=az8i7jS/IKuZe/ayk7bk4S4nex3Z7znee4SbTyVVxn93JXks79Dv7NscGqyBKp4HUDDzxq9sNSP9tY9raQsKPODYz7VSzaWGCFViRDuG5p13VNdZNCtPpGz7h6e6P5gygGqlok+LSnZuulQGoIN5Hk79s9dFfXgEinZx+WYjSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304710; c=relaxed/simple;
	bh=lVD6NdQtOSiq4Qr2J9qExnjFEtwYqUvBaZrGo41wt28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bxaFNI9f/ThWM/hs6PvH2lyeL8ZtZ9ZYVoqbnsFBBRCLNBDpzgYRR9uVVjoTq1yRY6RBzOBGfB8gVfqjx6iG70r2LkC1LqIs577WXKDcyzYWUgXAKRpSUEVd3BHxpbDI+UJt876vEJLqArgXjS0zJjzoVgDJxL8qd5MhmAynFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/2GE23d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A85C4CEC2;
	Mon,  2 Sep 2024 19:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725304709;
	bh=lVD6NdQtOSiq4Qr2J9qExnjFEtwYqUvBaZrGo41wt28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i/2GE23dWychP1K6x47bYp0CIj0J+5yO9gjCNex4s0iGlgq5ZeBXROW72YJ/rOjM7
	 zLhWOJQ/vNZ1Ql3QnpyFofuZ3sDhUUDR6RxW/Vh5Nd0MG7knAO8LlpQP/E3aRc9rVE
	 oO2qnpYTd2p8PJuKJjlG34GRb+ddOyZYuftrNsD45IiUX8t0sosMLVss3RhCAy4DbK
	 DLjmQHgwjx0PMoISULpHa8vW0aics6L3GfXbiWPlx/paw3bI8/BoWT90gU5VxHcB04
	 LWBg/Nx0RG2wuXvjf6wqg3wQkypZp0kVz4qUg0mBr6d5uwou8/m/5KMQZ24eR87GHG
	 lIFksc4Hb9QGg==
Date: Mon, 2 Sep 2024 14:18:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240902191827.GA224376@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815225731.40276-6-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:18PM -0400, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> Use it if present.  Otherwise, continue to use the legacy method to reset
> the bridge.

>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> -	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +	if (val)
> +		reset_control_assert(pcie->bridge_reset);
> +	else
> +		reset_control_deassert(pcie->bridge_reset);
>  
> -	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> -	tmp = (tmp & ~mask) | ((val << shift) & mask);
> -	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	if (!pcie->bridge_reset) {
> +		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> +		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +
> +		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +		tmp = (tmp & ~mask) | ((val << shift) & mask);
> +		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	}

This pattern looks goofy:

  reset_control_assert(pcie->bridge_reset);
  if (!pcie->bridge_reset) {
    ...

If we're going to test pcie->bridge_reset at all, it should be first
so it's obvious what's going on and the reader doesn't have to go
verify that reset_control_assert() ignores and returns success for a
NULL pointer:

  if (pcie->bridge_reset) {
    if (val)
      reset_control_assert(pcie->bridge_reset);
    else
      reset_control_deassert(pcie->bridge_reset);

    return;
  }

  u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
  ...

Krzysztof, can you amend this on the branch?

It will also make the eventual return checking and error message
simpler because we won't have to initialize "ret" first, and we can
"return 0" directly for the legacy case.

Bjorn

