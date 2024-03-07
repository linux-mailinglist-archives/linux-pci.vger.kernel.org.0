Return-Path: <linux-pci+bounces-4616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F88757A1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 20:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7061C220DF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 19:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E7C139593;
	Thu,  7 Mar 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp/jepb4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA22137C48;
	Thu,  7 Mar 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841184; cv=none; b=O4hClBO6J08FRLsMpHHd8Lfa9QGafo8Yxp+bmCHARq2Kj3wjfLTJxlUCfsQUiHOAT4tS1PBPtuWVlzcBTPFi8Od6UlgR2U9qX4Sy2CKD4BL6NkOXbO2nkpuRz1MYQ3Ee23kIt0O9IXp7GsR4FJ8jpJxdfYiSGcwXhDpYRYdMG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841184; c=relaxed/simple;
	bh=zBtZ5IOpkL6qCfo2I5F6M8ftp0zLjynvpva1eSiBuSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F++ZZtyO+UpNZhKZwoV2DphAoS1LCeLAikEya/gG7eG+X/ByhAqJKOShHamXZpO482dvAbIzKptjTLZod6ci5OAISTnKt0zAObpPb/20lVwG7TXiU76Tj8jzHds+eBgfYm84jdqAWnvhWx/M0vFnMyeFxdZI7RrhZeczNb+1X+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp/jepb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4ECC433C7;
	Thu,  7 Mar 2024 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841184;
	bh=zBtZ5IOpkL6qCfo2I5F6M8ftp0zLjynvpva1eSiBuSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bp/jepb4PDvsNrjk56N3ijuTUlescXOvoEL1HEYCfWnGtSJ5C2lciuKIk9hA3sNLN
	 bauPP3oAanTRILudB5QaMYsIwhDnQeJgMVYm1WQbwu2/T5yDhsjpnulrhAzJSyM0Um
	 JSMNL1vDNLWZdY0h9jv3RuugiiMLH4eRc3RAY9fkP3uivAoUWyMJvQmEjckoo2KjtU
	 9KqWTy+EFjPHoe8Cvm1gfS4PHZmArqpr84IwIWhs5aFsxn22g3DjPefBB8NHLkt1XW
	 JZgtpaxHi5t367t6OiIreMnBe+pN+axheeVGhig2M9HfvhCTf3kvKSM1WGUAgl46qs
	 N5f5iB1+2AGww==
Date: Thu, 7 Mar 2024 20:52:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v9 02/10] PCI: dwc: ep: Rename dw_pcie_ep_exit() to
 dw_pcie_ep_deinit()
Message-ID: <ZeobFZ0gXsmQPFyV@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-2-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-2-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:14PM +0530, Manivannan Sadhasivam wrote:
> dw_pcie_ep_exit() API is undoing what the dw_pcie_ep_init() API has done
> already (at least partly). But the API name dw_pcie_ep_exit() is not quite
> reflecting that. So let's rename it to dw_pcie_ep_deinit() to make the
> purpose of this API clear. This also aligns with the DWC host driver.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

