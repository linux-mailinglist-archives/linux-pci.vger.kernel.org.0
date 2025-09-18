Return-Path: <linux-pci+bounces-36413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581DB8458A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 13:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9677A2911
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0508B3054D1;
	Thu, 18 Sep 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5zGTtsu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67130506C;
	Thu, 18 Sep 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194850; cv=none; b=G52Bf8iEP0L33BIrsNuj2UgxannnJh7vyb1JT20EzLTHqntNx3FKdvWnyWO2yy5+srV/1Yy0FlhIexfxyCz3O3+Dgy8BKPNz8jImiCtqYBURA7Upu3V/dBT5YvGVZvOhPC+4WpBDtIR3quEgdntFxpkcxDaA8a5+40iqa2zE0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194850; c=relaxed/simple;
	bh=5QEZw9RNRk0Ahq+77CpxSjVPDT2KfPGtnFnDNhj6xoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWMY+Effw4g1qsZecCw6QlAm2cgPD4Ph5hrvuowsKeXfDYR6LttkEJzdpGtH19oSKX3fLvrICLidXyg1URlk5dUf9bcpEBFIqxlnmT+p6qYCBzSOs7u4FngIsBRusLpZm5rRTFcOv7tKznN6D2tLBLyEUsRYw3T7USHiHb35zew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5zGTtsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F854C4CEEB;
	Thu, 18 Sep 2025 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758194850;
	bh=5QEZw9RNRk0Ahq+77CpxSjVPDT2KfPGtnFnDNhj6xoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5zGTtsu1W9M0jWaxE9ILyjT/ckuehlLA/0hpKMWrGT7swQ5Ka93LFolWtBokBtIm
	 dc6Cj23xIowaXTikI5NCF33jw/T7AqRzRMYNy5JgyKjMNG/EKHETeVA1b+uDnGE7FO
	 rjKzZDCJ3t0h5/0cI8H2H+qV0M795NaFHzpuwOJkvuDKK7022WrdFCqPbufsDiIxQD
	 zHWvm1ySLqnZhMRcGNDovEkYiY9cTyB5qHTc/CW8/XoZCkMEY1QmL1e+EbCzswGVMf
	 JPKQVT3CYrZpS8LPwhxZiRAL156S2c9lL0mqPJ4BMM/O+CjAPInW/rGO3tMbbW8Iyv
	 UIUsa0spCwjrQ==
Date: Thu, 18 Sep 2025 16:57:20 +0530
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
Message-ID: <gejrg6oyzml3dwcsoqpusazlipceejvba4zkkg6gkghxdfryki@m5k4hz4pgrk2>
References: <e236uncj7qradf34elkmd2c4wjogc6pfkobuu7muyoyb2hrrai@tta36jq5fzsr>
 <20250917212833.GA1873293@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917212833.GA1873293@bhelgaas>

On Wed, Sep 17, 2025 at 04:28:33PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 17, 2025 at 10:41:08PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Sep 16, 2025 at 09:23:13AM GMT, Bjorn Helgaas wrote:
> > > On Tue, Sep 16, 2025 at 10:10:31AM +0200, Vincent Guittot wrote:
> > > > On Sun, 14 Sept 2025 at 14:35, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > > On Sat, 13 Sept 2025 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > > > > > > Describe the PCIe controller available on the S32G platforms.
> > > 
> > > > > > > +                  num-lanes = <2>;
> > > > > > > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > > > > >
> > > > > > num-lanes and phys are properties of a Root Port, not the host bridge.
> > > > > > Please put them in a separate stanza.  See this for details and
> > > > > > examples:
> > > > > >
> > > > > >   https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
> > > > >
> > > > > Ok, I'm going to have a look
> > > > 
> > > > This driver relies on dw_pcie_host_init() to get common resources like
> > > > num-lane which doesn't look at childs to get num-lane.
> > > > 
> > > > I have to keep num-lane in the pcie node. Having this in mind should I
> > > > keep phys as well as they are both linked ?
> 
> > > Huh, that sounds like an issue in the DWC core.  Jingoo, Mani?
> > > 
> > > dw_pcie_host_init() includes several things that assume a single Root
> > > Port: num_lanes, of_pci_get_equalization_presets(),
> > > dw_pcie_start_link() are all per-Root Port things.
> > 
> > Yeah, it is a gap right now. We only recently started moving the DWC
> > platforms to per Root Port binding (like Qcom).
> 
> Do you need num-lanes in the devicetree?
> dw_pcie_link_get_max_link_width() will read it from PCI_EXP_LNKCAP, so
> if that works maybe you can omit it from the binding?
> 

'num-lanes' is an optional property. But we do need it to be specified in
devicetree so that the drivers can set proper MLW, Link Width and Link Control
settings if the default values are wrong.

> If you do need num-lanes in the binding, maybe you could make a Root
> Port parser similar to mvebu_pcie_parse_port() or
> qcom_pcie_parse_port() that would get num-lanes, the PHY, and
> nxp,phy-mode from a Root Port node?
> 

Yeah, we need to have a similar parser.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

