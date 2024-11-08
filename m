Return-Path: <linux-pci+bounces-16342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE19C223D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5F9287F45
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E848192D97;
	Fri,  8 Nov 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw4s3bn0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3D167DB7
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083838; cv=none; b=cSnD/IgZwQQZ55T9/wy8N2aoRIFDZIHkwfsm5epkgbGlvGxafZ/1CTxlx1mTjAf1V3XCUJhEn+/YFf+vaVBqIeI6Rl4FhTpK0U+Z4Tkqf9m0CJzHTBVzsNhrkoCkGv7bizdNu4nGBXyNzsemGgVXOjXw/f10DnKrVj8RQjWCgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083838; c=relaxed/simple;
	bh=IskPDZRNmSgoLqb5hsNNc0juBISKvOEdc7mLaJ7QrxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E/zyxa81Giv3EML0sArLZ2rnbxT6+eDVm3rPK8UfKcTkYuYWRgSkegAcAX+zkrZcdoV8C77DhIyTYJLY+JsZ7dTwadx+MpS1qlpF1MBektz28jJBzeTi+FhUoFiqknbzjg/UitSDrPHbsh1dfnpLSDdXtJMG1ezY0Zfrn7f0eE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw4s3bn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D89FC4CECD;
	Fri,  8 Nov 2024 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731083837;
	bh=IskPDZRNmSgoLqb5hsNNc0juBISKvOEdc7mLaJ7QrxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fw4s3bn0Wf29S1jkpjQYrM2FmwnLA3NrRni74cKk1allD2DKXhvpLMFDPiHQb2DNj
	 1SCvHJVrnvyQRuR59J2x0DUKD5myQTB/wsH0RI+0JXsL2DGFDtxd2jHJAuCfZvBYQ+
	 9FnKBNfqNaK2oMfg09BrLS/8Lj6/5Wmw2PLt1imvcc78QQSYBfmwuwrpmgBGSIAYGb
	 ikdADitO57K7jIongS0VAdg5rcrzn7zazTKNNzIwDyHaTqm+2LqVlT8je4acK1vcW5
	 UmcjN3iWAE9IehTpIW8dDhOslCNDUxf5C9xt8cGJzGGtmsuzj2WN7FMtiQhmps9w3R
	 dFiQyX4LDHDXA==
Date: Fri, 8 Nov 2024 10:37:16 -0600
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
Message-ID: <20241108163716.GA1664097@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy3OTQ5CwPqtaeLU@lore-desk>

On Fri, Nov 08, 2024 at 09:39:41AM +0100, lorenzo@kernel.org wrote:
> > On Thu, 2024-11-07 at 17:08 +0100, Lorenzo Bianconi wrote:
> > > > On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wrote:
> > > > > In order to make the code more readable, move phy and mac
> > > > > reset lines assert/de-assert configuration in .power_up
> > > > > callback (mtk_pcie_en7581_power_up/mtk_pcie_power_up).

> > > > > +	/*
> > > > > +	 * The controller may have been left out of reset by the
> > > > > bootloader
> > > > > +	 * so make sure that we get a clean start by asserting resets
> > > > > here.
> > > > > +	 */
> > > > > +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> > > > > +				  pcie->phy_resets);
> > > > > +	reset_control_assert(pcie->mac_reset);
> > > > > +	usleep_range(10, 20);
> > > > 
> > > > Unrelated to this patch, but since you're moving it, do you
> > > > know what this delay is for?  Can we add a #define and a spec
> > > > citation for it?
> > > 
> > > I am not sure about it, this was already there.  @Jianjun Wang:
> > > any input on it?
> > 
> > This delay is used to ensure the reset is effective. A delay of
> > 10us should be sufficient in this scenario.
> 
> ack, so we can introduce a marco like:
> 
> #define PCIE_RESET_TIME_US	10
> ...
> 
> usleep_range(PCIE_RESET_TIME_US, 2 * PCIE_RESET_TIME_US);

Unless this corresponds to a value specified by the PCIe base spec or
CEM spec, this macro should be internal to pcie-mediatek-gen3.c.

