Return-Path: <linux-pci+bounces-42965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C1ACB6516
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 16:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7E03032704
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD372D1911;
	Thu, 11 Dec 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FApSG2Np"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258E25B30D;
	Thu, 11 Dec 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466410; cv=none; b=elBYnJ7wbb2I5sS/1p/Bc909We6ZY0uJ9GxMZ1Wv4JrQGd13Izq2NV4UZLh3ors5Oz8mMZNisYr6zs06yI/3AGUGpzTtbSKXd5y+8P3eDxMUgQGlX+v2GhJrKtepP0FmV8dAsviKAwolRY8s9r1L55Li4c5A6N6uz6kXJSySW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466410; c=relaxed/simple;
	bh=VaM+9vzK2D/v6EV/xnarx6FEHiWTCoSFGNq5qtloDG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SECQxrkco8q2VBk9eyS8jg+LFENWK/QbKHxHrdt9zsRJVg/5EvlLEttisy0CP4eQgIsBYoX/PHXWTKHzuBC4jOQkk8mTjEf75e1dGrGBn+lwt/EtHV4mvOBOTbqbcZLsB92C7FKaGSQs5oyAmCAGtYUxLYDpPcgfdiHaVYJ12cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FApSG2Np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AD0C4CEF7;
	Thu, 11 Dec 2025 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466410;
	bh=VaM+9vzK2D/v6EV/xnarx6FEHiWTCoSFGNq5qtloDG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FApSG2NpKCwR8i3dANFkJay5kdFyHDOx0bZcNKtnul6EnjIXqODIVOXS0qtO0ab7C
	 /s9nSEuIfqZ6YDmhwjUw0HXGIzkrjB1rHG6Yc5ubkg/qPbfFA52L8h/VWjmnVZupX/
	 fiWh3Kdxpw0FX71lSuMS+f2+4i0mopi/gU1narc4pdzdmMj/im4HBA2OwZTBvB+bGO
	 nwuuLd0aT+R4sQyrLKE5WPJyGIEeKfQUuCrdbmUdfUi05IaHFZzMCZShnO4K+emFWg
	 jsa79mPcBGgPA1fWKE3kvgIX3o0ULx6bv/IEDXLR7WHEfea3l754xTVaMQXMxFflkz
	 xNRAUGylziFGQ==
Date: Thu, 11 Dec 2025 09:20:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: bhelgaas@google.com, s.hauer@pengutronix.de,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	mani@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
	frank.li@nxp.com, kwilczynski@kernel.org, kernel@pengutronix.de,
	festevam@gmail.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org
Subject: Re: [PATCH v10 2/4] dt-bindings: PCI: pci-imx6: Add external
 reference clock input
Message-ID: <176546640668.1250530.16683675929770601103.robh@kernel.org>
References: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
 <20251211064821.2707001-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211064821.2707001-3-hongxing.zhu@nxp.com>


On Thu, 11 Dec 2025 14:48:19 +0800, Richard Zhu wrote:
> i.MX95 PCIes have two reference clock inputs: one from internal PLL.
> It's wired inside chip and present as "ref" clock. It's not an optional
> clock. The other from off chip crystal oscillator. The "extref" clock
> refers to a reference clock from an external crystal oscillator through
> the CLKIN_N/P pair PADs. It is an optional clock, relied on the board
> design.
> 
> Add additional optional external reference clock input for i.MX95 PCIes.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


