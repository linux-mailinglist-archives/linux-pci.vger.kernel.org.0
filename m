Return-Path: <linux-pci+bounces-44659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7403BD1AE09
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 964923023D4E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9934F481;
	Tue, 13 Jan 2026 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ/epLMx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43536284662;
	Tue, 13 Jan 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329879; cv=none; b=tTVFDpr0LLT7CQSnBAbZ1/u1Is0YMg23xPNSmRJQW0/sEa5bBqFwAEGsR6t1fUFQFDuuElm0qCgIQKEysLbCugxHwfknRc1vHjdItqhcoKQKe1bj+rds52Ur1xzsyzOggr+sfrcm282cYet+Q9o1M+n3mC0Vzop5dKhWJBe3ijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329879; c=relaxed/simple;
	bh=guH+X5X5Zw5RK4+z7WReUiSq/PEpKm6VSIBaw1TF1Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKStZ9Rgl8Xk5i/Aci5R+FMjAZpxcs5b5utDwtL4vVMoqtg5hi0pN/gZ+T4IOXlReBYOHWZzTOdA+AXeZh/+ByqxMceQsHuxCEa2By+s5wAtWRQVHp0eN5MWeid+66yVArW/TXrvMm12Bb/BFQ636r+2M2b4OOlalvg/4Sr9nnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ/epLMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC54FC116C6;
	Tue, 13 Jan 2026 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768329878;
	bh=guH+X5X5Zw5RK4+z7WReUiSq/PEpKm6VSIBaw1TF1Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJ/epLMx61KYA6qPjpRXqerwQQ3NcjyRncy5NLUppRcvNbs2ALyBM6FjEhD9uCvW2
	 eg+DxvUNeugL74YCHEYOOv4VS+A/BfA6G/dMZqmg4UIxaOswYQMpqwbpy7mH2VJssd
	 pryhg1yTNddK0bWY9Uq9gE7ggwr1D0Kf4ak8pCyjAuuQxjtChOyO00kugpRuZ29n40
	 WzTS8Cd0E4qQJrBcO9qMgrhYRyavxl9eWt+/iAY5yX2qEdebOKThI+hfkrhzfqh5HQ
	 VQ0q4gLY53Z/GZ66GOvRjkXfxIKgJEY7/T6uorHk2QfWRmmEUeUhwAT/SFYMOSF+KF
	 80DfzL+JVf/oA==
Date: Tue, 13 Jan 2026 19:44:25 +0100
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
Subject: Re: [PATCH v7 4/6] PCI: dwc: Advertise dynamic inbound mapping
 support
Message-ID: <aWaSggUJpnxjAPA_@ryzen>
References: <20260113162719.3710268-1-den@valinux.co.jp>
 <20260113162719.3710268-5-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113162719.3710268-5-den@valinux.co.jp>

On Wed, Jan 14, 2026 at 01:27:17AM +0900, Koichiro Den wrote:
> The DesignWare EP core has supported updating the inbound iATU mapping
> for an already configured BAR (i.e. allowing pci_epc_set_bar() to be
> called again without a prior pci_epc_clear_bar()) since
> commit 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
> inbound map address").
> 
> Now that the EPC layer exposes this capability via the
> dynamic_inbound_mapping feature bit, set the bit centrally in the
> DesignWare EP layer so that all DWC-based EP glue drivers report it
> consistently, without duplicating the same flag in each individual
> driver.
> 
> No functional change intended. This only advertises existing behavior to
> EPF drivers.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

