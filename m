Return-Path: <linux-pci+bounces-16263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C139C0B8C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596441C235A9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEBA216458;
	Thu,  7 Nov 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEZztuxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD3216447
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996498; cv=none; b=un17V8TvcrfuSLmWHV4TWI8A09/oYgi9L7JifInyzP6MwyfIwxFo6Nv/pDeKGvwO1Bmc6X8n1sChZPUzHA8MZfSgBNpupJ+md9nd2KZFDUgUDAjxHT+MakKI5K2A5ShcaA3/RtY1tY/PiTrpzt84BkQFWJnnEk7RIUp1bz9dUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996498; c=relaxed/simple;
	bh=WDKQzVC7YPrESifnzXnpiGCLZPvf4XaK0grfpAL8WCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ArNnmfSOUe6eYn6+wklowcH07UnKF+ycui/uUKB11WcDEFrEOL5vJxwFsoV+vWLZ5inydTK6oHnuQB74hLSG4DR6EAJGPLUm3akr/DannUIMooz2XdtHjG3rxX+67e8gqppm+tvfk8hjXsgzYpmX78goQOF0edsfsSMXfnQEBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEZztuxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C389CC4CECC;
	Thu,  7 Nov 2024 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730996498;
	bh=WDKQzVC7YPrESifnzXnpiGCLZPvf4XaK0grfpAL8WCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vEZztuxZPoXiMgodDEyirBvDBBIG5RvZe5y4dGCCwGXkynqIdNQzvtcLNUzJfCrbQ
	 ghjrLnfgnxDlqFlvCkr5RCCvPJyoB+i/YQ+xj47QEeDtS+P6pVu1UAUjxYw4qNdaB1
	 KpEIQ239IAqPvY1oGamDVZf9ahEg4FSseGwEGlMtDHJ6pGewwsUJrpOWN34kNt4EH7
	 AAE06x5fLlu1DWf0vnIluJkU3zD4+L4Z7SL9d3fs7VBrtmjE4CIgKI39XmstwI2paV
	 QlYlYDkB9hPMPGuncgn/ng2OOSiJDXy9LSEplrsLeqswEjGJpH43lXrUt6gu0z2UJw
	 Ms5KoQKnkDmTQ==
Date: Thu, 7 Nov 2024 10:21:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Message-ID: <20241107162136.GA1618287@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzmFyRYDHX0W6bB@lore-desk>

On Thu, Nov 07, 2024 at 05:08:55PM +0100, Lorenzo Bianconi wrote:
> > On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wrote:
> > > In order to make the code more readable, move phy and mac reset lines
> > > assert/de-assert configuration in .power_up callback
> > > (mtk_pcie_en7581_power_up/mtk_pcie_power_up).
> ...

> > Is there a requirement that the PHY and MAC reset ordering be
> > different for EN7581 vs other chips?
> > 
> > EN7581:
> > 
> >   assert PHY reset
> >   assert MAC reset
> >   power on PHY
> >   deassert PHY reset
> >   deassert MAC reset
> > 
> > others:
> > 
> >   assert PHY reset
> >   assert MAC reset
> >   deassert PHY reset
> >   power on PHY
> >   deassert MAC reset
> > 
> > Is there one order that would work for both?
> 
> EN7581 requires to run phy_init()/phy_power_on() before deassert PHY reset
> lines.

And the other chips require the PHY power-on to be *after* deasserting
PHY reset?

