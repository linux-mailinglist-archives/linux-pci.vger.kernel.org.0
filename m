Return-Path: <linux-pci+bounces-19190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB0CA001C4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 00:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9945164C39
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 23:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB171BFE0D;
	Thu,  2 Jan 2025 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh5XVJyA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384731BEF86
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 23:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860501; cv=none; b=IqxIv2Uo/UHTtUBleWTRP0vZw+vyREFp2xWes7pqiksr6FSaRpsqruUc9GkqbCyDTjH+lKKCrCaiHBKWAqbC9M+Gf9biRXQbYNclnQHe3s4FwNzlUhNwY0ATRR3UcvlshEeq6Z7F+C03ZFxPr1U3zLRELU4MPSUiquaJxAFJ29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860501; c=relaxed/simple;
	bh=o8Evq/Jq7VTHs84rjitCUFOTChZzkwzLSgAyMnDD4CA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uyDq9Oo8HdZ8PL59Q6wQzeXH2mnp4WWUpeg6hBT1rPZafhvBEwzOskkuk4siEq4QDZAT7pSODxc86tiZcq4MsakvARtphc14WfJV2XaYtHpUDSANRFHg5BLJ/tbEEVl4YBdMwQBlAWY65MjWfzCxJD3e7rWyKOjQseX9EO0F5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh5XVJyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8304DC4CED7;
	Thu,  2 Jan 2025 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735860500;
	bh=o8Evq/Jq7VTHs84rjitCUFOTChZzkwzLSgAyMnDD4CA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zh5XVJyAyIKPbBdYNw8zG8iHqib2Doua4b1soxpN4u91DBRCvDqe0t+ef1BcRPmoa
	 y6EXojfQCmXuS6sJ0Jp4/SWvy/+nnpNDQTxc9GoSMW30T9rqTu5/MKdHVnKOH7sXPY
	 6yCXakKSOntzIKxnFtwGhH4raj67Ond3HtwPRpbeJsY3C4WoyRzLLbbi+TlaEGgkEL
	 Q4WvYR//5ibRXe07gWFZ5y6kX53IGw0t9sx9NybbjYZFQhZ7zHMCHSpCNKX5nMIrpX
	 2IBg+mCPOecgO1WYHOB+0VIJhn5HVgBdSjcKUXa2Nf1C+hXlS+xdMI2f+tC3XbogwU
	 DAZ208w3zAc0g==
Date: Thu, 2 Jan 2025 17:28:17 -0600
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
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <20250102232817.GA4147111@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3Z4jcwtgcXk9Zo6@lore-desk>

On Thu, Jan 02, 2025 at 12:29:17PM +0100, Lorenzo Bianconi wrote:
> > On Wed, Nov 13, 2024 at 02:58:08PM +0100, Lorenzo Bianconi wrote:
> > > Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> > > causing occasional PCIe link down issues. In order to overcome the
> > > problem, PCIE_RSTB signals are not asserted/released during device probe or
> > > suspend/resume phase and the PCIe block is reset using REG_PCI_CONTROL
> > > (0x88) and REG_RESET_CONTROL (0x834) registers available in the clock
> > > module running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
> > > 
> > > Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> > > specify per-SoC capabilities.
> 
> Hi Bjorn,
> 
> similar to the other series, this patch is already in Krzysztof's branch.
> Do you prefer to resend it or just incremental changes?

If it's not too much trouble, I think a new v4 would be simplest so
the Link: in the lore archives is more correct.

