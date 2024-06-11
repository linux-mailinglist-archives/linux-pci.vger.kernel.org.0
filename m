Return-Path: <linux-pci+bounces-8611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34269046BE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E12D1F26246
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADED763F2;
	Tue, 11 Jun 2024 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/NzRHHA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4E3A8E4;
	Tue, 11 Jun 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143605; cv=none; b=dZ2H7wVx+7FMTggyFkL9Zpj4tWo2gy1Njvxi2Bwa4F77MjWCOVjNqtpGgT4PFhEff+7QzO0gemdqk7zKuH+4ObT+p+XWFiZjz7Lqx8yZNFzZZCRYByHN2hN0tOljyBGyM3nXe8W2QmLY3P0wxkZdopXisLZWBnbGqSQy21xBUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143605; c=relaxed/simple;
	bh=2z2T09bcbzfwexUZ5T7jD1TkbLjspNsoiYHpZ3OkpCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S3oQDUOGk9ZUWoUr6usYvNZjGQtGPO6sNTAj+Xg+jFLvMuzH6aXbihOC4v6Y+usGqpSbnLhYQv6s666tSpPXHa2dRrL6crJOu4M0CFgHbcOyKFnsh2KJj1URau+wzmv5Zweg4XoBnug4aF5r96qXPetcw4egG77mjcBDX7TPRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/NzRHHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC81C2BD10;
	Tue, 11 Jun 2024 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718143604;
	bh=2z2T09bcbzfwexUZ5T7jD1TkbLjspNsoiYHpZ3OkpCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a/NzRHHA81Kr/n5nwF8wLMmpSxDwQFBG1tf3wJl/ZX5qrZu3LoF/n38c1RQWAS3to
	 9PF0iBa1/cYKwSVYTUUEyS/nclJFBX6lIO5eO0x1Az0PTI0ZwlAsdX/khbFtfebn6E
	 YXiFVo4lds+SLiDkmm+nUPE/ZqefCzy2l8jaKYjZeHRpo24owJwxwC2tQwf1lgcI1s
	 jSWMaN02nOnAzTwxwp8JNo1/Rsd/DRVvo/SgDh50CtfMf0VE9bi5/DnHDINTWd02UU
	 HtDL2EuqVAPEfbwNIt35YzWTA4zlII6G6PiSRavH22Rynv/chO+GKlSJqnxKZZ2/Mp
	 +OmyobALds0Jg==
Date: Tue, 11 Jun 2024 17:06:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	mhi@lists.linux.dev, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 2/5] PCI: endpoint: Introduce 'epc_deinit' event and
 notify the EPF drivers
Message-ID: <20240611220640.GA1001976@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-pci-deinit-v1-2-4395534520dc@linaro.org>

On Thu, Jun 06, 2024 at 12:56:35PM +0530, Manivannan Sadhasivam wrote:
> As like the 'epc_init' event, that is used to signal the EPF drivers about
> the EPC initialization, let's introduce 'epc_deinit' event that is used to
> signal EPC deinitialization.
> 
> The EPC deinitialization applies only when any sort of fundamental reset
> is supported by the endpoint controller as per the PCIe spec.
> 
> Reference: PCIe Base spec v5.0, sections 4.2.4.9.1 and 6.6.1.

PCIe r6.0, sec 4.2.5.9.1 and 6.6.1.

(Not 4.2.4.9.1, which no longer exists in r6.x)

> Currently, some EPC drivers like pcie-qcom-ep and pcie-tegra194 support
> PERST# as the fundamental reset. So the 'deinit' event will be notified to
> the EPF drivers when PERST# assert happens in the above mentioned EPC
> drivers.
> 
> The EPF drivers, on receiving the event through the epc_deinit() callback
> should reset the EPF state machine and also cleanup any configuration that
> got affected by the fundamental reset like BAR, DMA etc...
> 
> This change also warrants skipping the cleanups in unbind() if already done
> in epc_deinit().
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

