Return-Path: <linux-pci+bounces-6206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305CB8A3878
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 00:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7491C21D9D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 22:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5521514C0;
	Fri, 12 Apr 2024 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmmFPxsJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0E15218A
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712959916; cv=none; b=gNRr+EKpNtReoQqLUDpYkr2Baqt1q1w6IhE2BfD79AX2gDGKO7kvw0pIHEFcYMtJ/LPqt7t84eH/eQnntKDRtXUgeggrJcf66mEKvWhGvACY5kKAvio+ufDOsivH04k00GI/PjKmQvl/2YYLj07welRO3q09EW9pTzk0B7+wwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712959916; c=relaxed/simple;
	bh=OZwvmDGS/9jos0oXpEDMyV23RH68O16X3jDCFlPoCk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S27JNFK8+6GnPTmtC7KLB/pLau3CM2SMTxG+k399gTm7fLB7Xp7Bbj/qP5MvLm2uQ64ZH1XkHeygL1K8A+6Ma6aIWsa1RzjOj+DaTJr/kVblGJDAsL+//MEBI6n12+9wNs8Lo/fW/0gOPj2Tx8QZX1yutiZnJ4Ag65NWcw1Nn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmmFPxsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC87CC113CC;
	Fri, 12 Apr 2024 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712959916;
	bh=OZwvmDGS/9jos0oXpEDMyV23RH68O16X3jDCFlPoCk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dmmFPxsJme3/18nT2Jf5IaGpKomI0Fqtbt/SUgyXNo4D1GL55MMr3ql9Rzdj4DF0k
	 Q5YLRzs9USvoprkiSvwVYuXyby+lJpSAGTurkXDdqvphHQb+Cs/AORZY734W9lL0kG
	 OfPgUWai58nLqqTvo3wAErCUMzbK6DmBKeCNMZhQK2w/UTCZVJHg9aZC0XIj2fSV5R
	 R/jPtRhr+pcAmWGoZv+rgDtLEqMD6A1zYzi6L/EyInHLY0croqnJg+TSHJdVJ6Eywt
	 e9Pft9/vUaZ1dIiHFTXMnK9Lm40qNn3B7UVEWIMGU7QGDVFQbID68K3WwK3bsHXy26
	 8dNR4yatlFsrA==
Date: Fri, 12 Apr 2024 17:11:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/9] PCI: rockchip-ep: Set a 64-bit BAR if requested
Message-ID: <20240412221153.GA21914@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmvZJg7A11tyh5Q@ryzen>

On Sat, Apr 13, 2024 at 12:02:12AM +0200, Niklas Cassel wrote:
> On Fri, Apr 12, 2024 at 01:59:01PM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 13, 2024 at 11:58:00AM +0100, Niklas Cassel wrote:
> > > ...
> > 
> > > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > > @@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> > >  		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
> > >  	} else {
> > >  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> > > -		bool is_64bits = sz > SZ_2G;
> > > +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
> > >  
> > >  		if (is_64bits && (bar & 1))
> > >  			return -EINVAL;
> > 
> > Completely unrelated to *these* patches, but the BAR_CFG_CTRL
> > definitions in both cadence and rockchip lead to some awkward case
> > analysis:
> > 
> >   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS              0x4
> >   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_32BITS     0x5
> >   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_64BITS              0x6
> >   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_64BITS     0x7
> > 
> >   if (is_64bits && is_prefetch)
> >           ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
> >   else if (is_prefetch)
> >           ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
> >   else if (is_64bits)
> >           ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_64BITS;
> >   else
> >           ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS;
> > 
> > that *could* be just something like this:
> > 
> >   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM           0x4
> >   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_64BITS        0x2
> >   #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH      0x1
> > 
> >   ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM;
> >   if (is_64bits)
> >     ctrl |= ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_64BITS;
> >   if (is_prefetch)
> >     ctrl |= ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH;
> 
> If you send the cleanup patches, I will send the Reviewed-by tags ;)

Fair enough :)

