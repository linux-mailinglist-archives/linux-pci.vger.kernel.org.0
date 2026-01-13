Return-Path: <linux-pci+bounces-44599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 495A2D17F1E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 11:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1DEF3067DEF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8932238A289;
	Tue, 13 Jan 2026 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnCo48+i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD9389DEE;
	Tue, 13 Jan 2026 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299276; cv=none; b=W7u4hgmLy/rKQHdrbyi5pWuJN/QN/K5NuUctrcgP6L2vqYMn3YKtfN7cMB5mZKKS09qRqWQrlo3qFbsod95Yp/5bAdW9ZWzS6mdZ8/zk/YnDfxnMcys3Hahs7vLpzr7n7yz0vTcAc7PnoMD8ZbDx7aLPgcmOFmin4NX9EPCcNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299276; c=relaxed/simple;
	bh=noH2csNYttkzJximg2DkOMRq7PSZu8QvD26YdxlPYIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1D+JWxwZyiCvBDW4E74S8lF4Pgb3HjEeW+EGe/2btE1AQNh3yxx8sAjhPrF76LNP/FJeL9HS6UCKwksenlKrlsYsh7M//7UL5evHdZqqA0Lg9W8XT2C67cRG4vF2IEc1yTQB55dHknpUUXPdgfpKuNtZuOaT0UEMWkrWNezGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnCo48+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44057C116C6;
	Tue, 13 Jan 2026 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768299276;
	bh=noH2csNYttkzJximg2DkOMRq7PSZu8QvD26YdxlPYIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnCo48+itSv/Z28wMZQtVhh0fd455MaYSuLbQW6msp/bVpo2RGKM7v01FABDcC/+U
	 6APVMBzTSQbuUc6AhL7BcTRAI4Ixf+UFQNB4/DHAQArlAsgjubbi6i5acb75Au4E4Z
	 8MjbpNxoc3ojtcQwW/hR8ZT+dxKkJ/RRMJ9g2rkV08Nhf4bobolIcGJsMuW5IoG60K
	 YqIaDSdymp+dxdHtZ30GCRkvvFqg2To2vhn47htFBg2/y6fikSE3Nm9wqjNn2PzWHB
	 BK4d/7sUcf70yGB9PUsgJE4SbBD1cX2dV7Oe2O9HSgpZl83MYSX/dmIyJNVoc2FGPw
	 PN58GnzLcopoA==
Date: Tue, 13 Jan 2026 11:14:23 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
	heiko@sntech.de, srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
	rongqianfeng@vivo.com, 18255117159@163.com,
	shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com, vidyas@nvidia.com, Frank.Li@nxp.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 2/5] PCI: dwc: Allow glue drivers to return mutable
 EPC features
Message-ID: <aWYa_9mlWu-A2uCN@ryzen>
References: <20260113023715.3463724-1-den@valinux.co.jp>
 <20260113023715.3463724-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113023715.3463724-3-den@valinux.co.jp>

On Tue, Jan 13, 2026 at 11:37:12AM +0900, Koichiro Den wrote:
> The DesignWare EP midlayer needs to advertise additional capabilities at
> the DWC layer (e.g. subrange_mapping) without duplicating the same bit
> in every DWC-based glue driver and without copying feature structures.
> 
> Change dw_pcie_ep_ops.get_features() to return a mutable
> struct pci_epc_features * and update all DWC-based glue drivers
> accordingly. The DWC midlayer can then adjust/augment the returned
> features while still exposing a const struct pci_epc_features * to the
> PCI EPC core.
> 
> No functional change on its own.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

