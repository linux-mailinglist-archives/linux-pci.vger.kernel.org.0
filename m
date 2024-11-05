Return-Path: <linux-pci+bounces-16081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A143D9BD74F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 21:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599451F2373C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A01D88DC;
	Tue,  5 Nov 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEGT/NDi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C83D81
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840271; cv=none; b=C9vv2gRcKIqsWiDBOvD7CfZSS9yetMHgwuQPK/dUs042apjna8y1R49ruyl+I8qQK6k7xuY9S37B9S2wcn9f0UQKd+jPPpWRqtUq/uP++0CZyFkFJsiDzm8U90bTkuMJHNA+kEBS5FM4cfW/7uScbDgpHVf5YgXKZuOxDEB3eDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840271; c=relaxed/simple;
	bh=DYfBBj3JaDu67bf4HxYtGzC1oE1D8X/KxacexvlRTs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fOWN06lvieR0VOhNdCV8yjVsK2Y8mF5SPQIHL2Ks15vO3cQmV6q6osjiA5azA2FG4/Lf+ikTxFK7v/mvFEba4QNvN5psj3kREvwdXcAG8EI1U70pqAasj6ZA2yRGtjTwiELF8lIhFCmLq2YkOrw8/J7XXx6pAMl181sJU96jTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEGT/NDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5854CC4CECF;
	Tue,  5 Nov 2024 20:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730840270;
	bh=DYfBBj3JaDu67bf4HxYtGzC1oE1D8X/KxacexvlRTs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EEGT/NDigZAvieG+NbZ8bVmafnVdv5lQeTu46psHu8LRVQRAKknpPRZj7ox36oM+a
	 QKCPkZYpWKK474piUG0cn5aVOARWAqhjMFdLIcPR0BVAhlStmLCNxfpXTHfB3FkpsQ
	 aPZcOQQ+eU9bk+xj1gemiNL3JxKskhArqKP8OtrwLAIvMzRynQ7UMEHJlTI96+dm7g
	 diX1CzAbC0FSW/Z8/wJAR08KPjX33v6jNGRFT5oF9xE1kg2dB1tthQlhZ9ISslpwgo
	 Z7p5trRutiezgh5W7pXT6zX02+PhE11Wn9bU2gN6jIwiMlQ1nr31LkuzKDsecu3jPD
	 fKv0Nsq6LrHaQ==
Date: Tue, 5 Nov 2024 14:57:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <20241105205748.GA1484220@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZypgYOn7dcYIoW4i@lore-desk>

On Tue, Nov 05, 2024 at 07:13:52PM +0100, Lorenzo Bianconi wrote:
> > On Mon, Nov 04, 2024 at 11:00:05PM +0100, Lorenzo Bianconi wrote:
> > > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > > causing occasional PCIe link down issues. In order to overcome the
> > > problem, PCIE_RSTB signals are not asserted/released during device probe or
> > > suspend/resume phase and the PCIe block is reset using REG_PCI_CONTROL
> > > (0x88) and REG_RESET_CONTROL (0x834) registers available via the clock
> > > module.
> > > Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> > > specify per-SoC capabilities.
> > 
> > Where does this alternate way of doing reset (using REG_PCI_CONTROL
> > and REG_RESET_CONTROL) happen?  Why isn't there something in this
> > patch to use that alternate method at the same points where
> > PCIE_PE_RSTB is used?
> 
> REG_RESET_CONTROL (0x834) is already asserted/released in the following flow:
> 
> mtk_pcie_en7581_power_up() -> reset_control_bulk_deassert() -> en7523_reset_update()
> https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#L470
> 
> REG_PCI_CONTROL (0x88) is already asserted/released in the following flow:
> mtk_pcie_en7581_power_up() -> clk_bulk_enable() -> en7581_pci_enable()
> https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#L385

So IIUC, you're saying that on EN7581, the PCI hierarchy is reset by
the soc->power_up() callback, mtk_pcie_en7581_power_up(), via
REG_PCI_CONTROL and REG_RESET_CONTROL.

I assume the hierarchy is also reset by the non-EN7581 .power_up()
callback, mtk_pcie_power_up()?

And prior to this patch, we reset the hierarchy *again* in
mtk_pcie_startup_port() via PCIE_RST_CTRL_REG, but this causes
occasional "link down" issues because of a EN7581 hardware defect.

So for EN7581, this patch skips the PCIE_RST_CTRL_REG reset in
mtk_pcie_startup_port().

.power_up() and mtk_pcie_startup_port() are used both at probe time
and in mtk_pcie_resume_noirq().  So after this patch, I assume:

  - EN7581 resets the hierarchy once at probe and resume instead of
    twice.

  - Non-EN7581 resets the hierarchy twice at probe and resume.

I assume I'm missing something (maybe mtk_pcie_power_up() doesn't
actually reset the hierarchy?) because I don't see why we would reset
the hierarchy twice for either controller.

Bjorn

