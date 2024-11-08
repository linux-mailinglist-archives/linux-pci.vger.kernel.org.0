Return-Path: <linux-pci+bounces-16343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CA9C226D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F071B248BD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C51C3F28;
	Fri,  8 Nov 2024 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk/tmd9m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EEF198E85
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084498; cv=none; b=ifqYH/26FQAUbQDV4OJJLV5IfetiDMXjPMI7Gd878faWGbzyMTuVw1XbbIj0mvXCqhMrDL9+S2o+BzL+CrexUmf542PqXnnMsIzoowfXSCp93K66LOVZoDQcwz83N2bD5WuGdAPtQdBGPon6VhBb4d1DI8HGEbbxWRAIEkJII0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084498; c=relaxed/simple;
	bh=bnVD4rkav0ZeJAD/SxnELzRm/Vojs5RiuAQetQRIYCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c0xmI0j0ct9FMAPfEnhLwJdo10qYqJb/ToB9SoGEpVxqaDha8oTDNS4x0c8SFxww7ZATIlz1DiPjC8lzetcM4htARQt+fxrYyIu+nQBCpLcpWl/Ttc8vQoXl0Y+zMb780Dr3qlnDJrsaDsq3Y07cpaS0J8qc/V4NKt1sjINtm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk/tmd9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A047C4CECD;
	Fri,  8 Nov 2024 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731084498;
	bh=bnVD4rkav0ZeJAD/SxnELzRm/Vojs5RiuAQetQRIYCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qk/tmd9mcQG4lWwgAX57d6FU5ML7M9ZoN4zGzHdNSiH9DpKLUdKRJoWcwIewIFViD
	 zoIOt0nEWdYBLLSrffXGrmVcv8wJkPiRRzawF36VcF08hSeXPVGQfxw4v6STCdJ2hM
	 ZV/eEG71LZcbRn1Zda2sJEvqo7/h9dR6GSmlAqTyzCvkpIyJ+nRYYTqp5sTTE1FGv0
	 fVRXvXmSMzYX3RQzm+izX291G1oVTc4pI20yChu3CJj1MlwiJOtDeOPsmfaRo4QX5V
	 MenF1ypuQgWslaNy2mXmI5zbbN5cidSS3GIYDxIIruqbjaVMFzsVAm8vMid4yA+WlE
	 O16mBfgm6azwQ==
Date: Fri, 8 Nov 2024 10:48:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>
Cc: "lorenzo@kernel.org" <lorenzo@kernel.org>,
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
Message-ID: <20241108164817.GA1665283@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <547216d36f8eaa313690ff8b52407ae46b8e9c40.camel@mediatek.com>

On Fri, Nov 08, 2024 at 02:51:15AM +0000, Jianjun Wang (王建军) wrote:
> On Thu, 2024-11-07 at 10:21 -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 07, 2024 at 05:08:55PM +0100, Lorenzo Bianconi wrote:
> > > > On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wrote:
> > > > > In order to make the code more readable, move phy and mac
> > > > > reset lines assert/de-assert configuration in .power_up
> > > > > callback (mtk_pcie_en7581_power_up/mtk_pcie_power_up).
> > > 
> > > ...
> > > > Is there a requirement that the PHY and MAC reset ordering be
> > > > different for EN7581 vs other chips?
> > > > 
> > > > EN7581:
> > > > 
> > > >   assert PHY reset
> > > >   assert MAC reset
> > > >   power on PHY
> > > >   deassert PHY reset
> > > >   deassert MAC reset
> > > > 
> > > > others:
> > > > 
> > > >   assert PHY reset
> > > >   assert MAC reset
> > > >   deassert PHY reset
> > > >   power on PHY
> > > >   deassert MAC reset
> > > > 
> > > > Is there one order that would work for both?
> > > 
> > > EN7581 requires to run phy_init()/phy_power_on() before deassert
> > > PHY reset lines.
> > 
> > And the other chips require the PHY power-on to be *after*
> > deasserting PHY reset?
> 
> For MediaTek's chips, the reset will clear all register values and
> reset the hardware state. Therefore, we can only initialize and
> power-on the MAC and PHY after deasserting their resets.

OK, it sounds like you're saying the Airoha EN7581 is not a MediaTek
chip and does require a different ordering of PHY reset deassert and
PHY power-on:

  - EN7581 requires PHY power-on before PHY reset deassert,

  - other chips require PHY reset deassert before PHY power-on.

That's fine and probably worth a short comment in
mtk_pcie_en7581_power_up(), e.g., "Unlike the MediaTek controllers,
the Airoha EN7581 requires PHY power-on before PHY reset deassert".

Bjorn

