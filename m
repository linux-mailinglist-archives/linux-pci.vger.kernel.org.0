Return-Path: <linux-pci+bounces-31168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F654AEF90D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDED1BC7304
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF71A29A;
	Tue,  1 Jul 2025 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7omG6lv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1160274659;
	Tue,  1 Jul 2025 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373908; cv=none; b=j0AR36/NPZJgQtj0k+0Nxbzc2dWoJwrCxCRHvROQrIlbAY51fkOb8PwRDqRRF811V/QRY4sBbB6zHAyzXAH9s0kaU7kedgpJSA+scaa80XPzLF2q+fWQouCaG4jEYyOHZY1pntfJgi8VpBKT9B8Y/8mXEcvIzN81zlJU67QIn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373908; c=relaxed/simple;
	bh=iA/ph/M71kX2tGT946O6HBiCUvqw1IpsbbdvFe4xP1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkUia4aK9NZmgBgTbjARarhbXxJd2HTQE9G2rzmAaVlscXEvt6yWAsXYWscAR/APGtXTBtblGbCSCVC0lAQTjLry+oApLcK9hyJGw3IH10z0HnjgAANAJBwjhLvslA6pSv1/ih6AIPEpzsGZ7QTWkP67S2FkJxOCwtLUfgrZAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7omG6lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A734C4CEEF;
	Tue,  1 Jul 2025 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751373908;
	bh=iA/ph/M71kX2tGT946O6HBiCUvqw1IpsbbdvFe4xP1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7omG6lvtr1EWRZrLsk+sFSIN6sWytvPyEZspFlI2ntr7CykfGRx7JWDrn71eIZNV
	 tujrFLD8V0/AbA3SHZdblplsXWkSxvPsVnZ7FJfms1isZIRx8rSsCbUCWBblBI8ReD
	 qlGB2wAvYu6nl+SrUXD+aSvQ6gGYjvj77sbxMq+VHuE9eveEyKIWwJVpfSEZ569UPK
	 Iepz5Y1VZ5Hw1GtqY6M9Bu8+T7oFyZzhrJMJRtWfw70F9kqE25m2BWEY7mwbcuyRcx
	 a+CLjszVCYVny4lwiLYc2VX2EOG4iB+HxqMsOaG+NWDPuKIwDWocet/x0o/JO3hN1o
	 iOlR+U8f7hvAg==
Date: Tue, 1 Jul 2025 18:14:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Philipp Stanner <pstanner@redhat.com>, 
	linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rick wertenbroek <rick.wertenbroek@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Valmantas Paliksa <walmis@gmail.com>, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v9 1/4] PCI: rockchip: Use standard PCIe defines
Message-ID: <5uoyjs4vndspqdjho5lb2e6odek5fnfxrefftmxpzpejuqsgze@adyovdwmpxwe>
References: <cover.1751322015.git.geraldogabriel@gmail.com>
 <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com>
 <ce0fdbf2753075056c227ce7567a69386a5aa0a3.camel@redhat.com>
 <aGPOkw2G2IeNhDRy@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGPOkw2G2IeNhDRy@geday>

On Tue, Jul 01, 2025 at 09:03:31AM GMT, Geraldo Nascimento wrote:
> On Tue, Jul 01, 2025 at 09:54:51AM +0200, Philipp Stanner wrote:
> > On Mon, 2025-06-30 at 19:24 -0300, Geraldo Nascimento wrote:
> > > Current code uses custom-defined register offsets and bitfields for
> > > standard PCIe registers. Change to using standard PCIe defines. Since
> > > we are now using standard PCIe defines, drop unused custom-defined
> > > ones,
> > > which are now referenced from offset at added Capabilities Register.
> > 
> > This could be phrased a bit more cleanly. At least I don't get exactly
> > what "from offset" means. You mean you replace the unused custom ones?
> > But if they're unused, why are they even being replaced?
> 
> Hi Philipp!
> 
> "from offset" means we use standard PCIe defines for registers that are
> adjacent to Capabilities Register, and we reference them from the offset
> at Capabilities Register.
> 
> No, all registers replaced are in use, unused in that context means they
> (the custom-defined registers which can be referenced starting from
> Capabilities Register address) become unused after the change, only.
> 

I've reworded the commit message:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rockchip&id=04e740dfe153f2b6530ce99c0e346600d3fb2ef7

> > 
> > 
> > > 
> > > Suggested-By: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > s/By/by
> 
> Thanks for the capitalization catch. Unfortunately there's little I can do
> now that Mani went ahead and applied the first two patches (directly
> related to PCI subsystem).
> 

This was already taken care!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

