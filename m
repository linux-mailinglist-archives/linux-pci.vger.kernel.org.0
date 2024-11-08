Return-Path: <linux-pci+bounces-16347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F19C22C6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 18:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E600528319D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFE199953;
	Fri,  8 Nov 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiY6rnqG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286E208C4
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086232; cv=none; b=ODo6hSPW/pUq1jlPnajy7O3ssVzhCPklyU1vqywM9N1yKSfnuGsMRDjS+lFY36uV5nIwBEdOZSKk/aJKwp5/wuoAmr84MohldiWB6bi5Pw17uT0ur4nXi8geXKYlNhahhf66Om9gRcVVm0gmXmXH/bCCKkSRTP21s+DHbnp5mA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086232; c=relaxed/simple;
	bh=8HG59M124RFlrjV+ts8vrVvvJqG6N9I7IeFFJaZ90+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XKSfpBwC79/fIShWcjcC2VFm+o9o8piHXAkOifuA0OBJc7uUpUKGy9R+CexA2e4XktOuQhxvroKHQv+spoMuGsBBSLxIoCEUz3QzwtnPOllyssXFJjjdPAnjnVj4kLDQHjR7PnhLqYy5AJhMCufKKDBAO8GKbK06nIlJ5fC4/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiY6rnqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA24C4CECF;
	Fri,  8 Nov 2024 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731086232;
	bh=8HG59M124RFlrjV+ts8vrVvvJqG6N9I7IeFFJaZ90+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MiY6rnqG5QpUZhzQ9P6UXTncPAkwwkHtwQPVH3TrqaChe0MswOGEcyZ5ao1yIPLBW
	 IqpMOqbYYj1rggkiogb8X6nP2i54rRD0Xx30n0hmeb561BBh6EUgjqlein3bkFzJmJ
	 VMFxU/eAdfgWcljOkmqElAj2gFw1W09EHLe5uXfxrS8P0lMHWPPqpUxCdyxsrli6Am
	 szVb42VDXy6jSOdb8ihxkKRINQlHlAZl32oYryU63DdoYfZuAD2U3iqlB0feWG/o7t
	 ZWkDtQzJ4RGqYC3ERFBaGgLFytRG4YGDj3+SxtrhNUtBTDbb8ODRdFink55+lnOHlD
	 vVay2AiMFLBcA==
Date: Fri, 8 Nov 2024 11:17:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
Cc: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Message-ID: <20241108171710.GA1667022@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy5EjY_oQaRbb5MY@lore-desk>

On Fri, Nov 08, 2024 at 06:04:13PM +0100, lorenzo@kernel.org wrote:
> > On Fri, Nov 08, 2024 at 09:39:41AM +0100, lorenzo@kernel.org wrote:
> > > > On Thu, 2024-11-07 at 17:08 +0100, Lorenzo Bianconi wrote:
> > > > > > On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wrote:
> > > > > > > In order to make the code more readable, move phy and mac
> > > > > > > reset lines assert/de-assert configuration in .power_up
> > > > > > > callback (mtk_pcie_en7581_power_up/mtk_pcie_power_up).
> > 
> > > > > > > +	/*
> > > > > > > +	 * The controller may have been left out of reset by the
> > > > > > > bootloader
> > > > > > > +	 * so make sure that we get a clean start by asserting resets
> > > > > > > here.
> > > > > > > +	 */
> > > > > > > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > > > > > > +				  pcie->phy_resets);
> > > > > > > +	reset_control_assert(pcie->mac_reset);
> > > > > > > +	usleep_range(10, 20);
> > > > > > 
> > > > > > Unrelated to this patch, but since you're moving it, do you
> > > > > > know what this delay is for?  Can we add a #define and a spec
> > > > > > citation for it?
> > > > > 
> > > > > I am not sure about it, this was already there.  @Jianjun Wang:
> > > > > any input on it?
> > > > 
> > > > This delay is used to ensure the reset is effective. A delay of
> > > > 10us should be sufficient in this scenario.
> > > 
> > > ack, so we can introduce a marco like:
> > > 
> > > #define PCIE_RESET_TIME_US	10
> > > ...
> > > 
> > > usleep_range(PCIE_RESET_TIME_US, 2 * PCIE_RESET_TIME_US);
> > 
> > Unless this corresponds to a value specified by the PCIe base spec
> > or CEM spec, this macro should be internal to
> > pcie-mediatek-gen3.c.
> 
> My plan is to add it in pcie-mediatek-gen3.c. Do you think
> PCIE_RESET_TIME_US is too generic?

It's generic, but so are most of the other #defines in
pcie-mediatek-gen3.c, so I'd follow suit.

Connect it to language in the MediaTek spec if possible, i.e., if the
spec names this parameter, try to use the same name.

