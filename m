Return-Path: <linux-pci+bounces-36366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002AB8121F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178951C02751
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F622FB09A;
	Wed, 17 Sep 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY7xIKsJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F834BA5E;
	Wed, 17 Sep 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129083; cv=none; b=spF3E+4OO9y8fl+jAspRzvysNgNpO4ONJEbnKwkZV2WOGaD7WM7dAQh9rNEkhs+30Ovkt7Xa4jmZGG5FqrS4+kzxTOswpeIgS7RKiXcEe+Zho+MDk3gSEolq3ehbcpSUqS34BftZEzF44JAGeHpRg5yZgNVr/WZjarbBrIMN9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129083; c=relaxed/simple;
	bh=5a8Lvl/fyCGhy9i59oV3pta8qeog5MpOntlyY8Wl3ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cclUcEycRvY8/coBFiGyYioli5BTqFT54skvhRTPdmWy8InsxaSgXY0qJip/F2uSjDGWu79OUz2KwMu/ZJhcarLh0i2+BelzYsfSytOyl/oBNbKPTC38PGqEGMkHKtayQk4VogCHVanfVcV5O0kH28PIvY/dfTJcpKYys0rHRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY7xIKsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048A9C4CEE7;
	Wed, 17 Sep 2025 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758129081;
	bh=5a8Lvl/fyCGhy9i59oV3pta8qeog5MpOntlyY8Wl3ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bY7xIKsJMt1zjwyfXRsbFHQsyNw7p8CDSsIGnEh7Wtlbv2+nn5P68Jd6658PzQzqW
	 qMilKropUB9RjntzIENhx+JIt57CM9arwx4B+XNcdY1QRjGTsGhC2R/dHREZ/Yx6E2
	 jvUbVHOs11mOxIi7ZXnyjhSIvBlxxgIeZ+45SpP0ae+J0UxhO1OG3nbd4TELHrAL0p
	 QhUtNz355q6QSb0pPcIq5yQVVEdE7QOjRLpgMs3NfWtfIzcLBkTrRNjDuvwJpWtML9
	 upUdm4eyV4cS9ML8NZ8M9mNrXiR8KXDrB+07YHQ58kaZMQZ6ye9LBcAaPZ2gok/mln
	 ZMf8zYulN9Wwg==
Date: Wed, 17 Sep 2025 22:41:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com, 
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
Message-ID: <e236uncj7qradf34elkmd2c4wjogc6pfkobuu7muyoyb2hrrai@tta36jq5fzsr>
References: <CAKfTPtDog36hBZ0XvhC-NyfL0SwB5ve53nLFpofToKt1ebhuGQ@mail.gmail.com>
 <20250916142313.GA1795171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916142313.GA1795171@bhelgaas>

On Tue, Sep 16, 2025 at 09:23:13AM GMT, Bjorn Helgaas wrote:
> On Tue, Sep 16, 2025 at 10:10:31AM +0200, Vincent Guittot wrote:
> > On Sun, 14 Sept 2025 at 14:35, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > > On Sat, 13 Sept 2025 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > > > > Describe the PCIe controller available on the S32G platforms.
> 
> > > > > +                  num-lanes = <2>;
> > > > > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > > >
> > > > num-lanes and phys are properties of a Root Port, not the host bridge.
> > > > Please put them in a separate stanza.  See this for details and
> > > > examples:
> > > >
> > > >   https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
> > >
> > > Ok, I'm going to have a look
> > 
> > This driver relies on dw_pcie_host_init() to get common resources like
> > num-lane which doesn't look at childs to get num-lane.
> > 
> > I have to keep num-lane in the pcie node. Having this in mind should I
> > keep phys as well as they are both linked ?
> 
> Huh, that sounds like an issue in the DWC core.  Jingoo, Mani?
> 
> dw_pcie_host_init() includes several things that assume a single Root
> Port: num_lanes, of_pci_get_equalization_presets(),
> dw_pcie_start_link() are all per-Root Port things.
> 

Yeah, it is a gap right now. We only recently started moving the DWC platforms
to per Root Port binding (like Qcom).

Unfortunately, I don't have cycles for it atleast this week.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

