Return-Path: <linux-pci+bounces-14691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D939A12B8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 21:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5752862B9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6443D2141C3;
	Wed, 16 Oct 2024 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS1OkGaV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC391865ED;
	Wed, 16 Oct 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107484; cv=none; b=BynfS8jrGog4bMOYW6iUdyZsRw7wnVLVqng8TNJEVzeUWnsQxP0tJ6bd1syZQPKmdLL1rPq5lPpfyYOobhwypbw+vB4W6Kh54gPrB1AIFr4SxHsM1sysZKKj88R1C2U3ZpjjK4yLvyXU5wnB121B2SIsZ6LUdOqOuO7SEGml8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107484; c=relaxed/simple;
	bh=6dGoC9a9JiCAYeGpX5fIjP+CJ42IJn9E3kkE2FQNvL0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=inyC2DyD2OqWYWJwvWc79ldVxQagOBNy0UedOPPAfAqMuODEyTx8JxXuJ4ckoVJppuCCseYOp1RHHENPdvPzNwL3GiISppkTNUM3UyrXahDeryp5unO4To/1UHpFdha7O59m+kiKGTkygWNeYGQ1h/pvcd0Weuk0tOEbAWKx8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS1OkGaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82649C4CEC5;
	Wed, 16 Oct 2024 19:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729107483;
	bh=6dGoC9a9JiCAYeGpX5fIjP+CJ42IJn9E3kkE2FQNvL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tS1OkGaVsIsv4ZJFraTecKZ2QFO4nUAEAoichSykLSfGjHXeNTJSjpqnrQ69xbYnh
	 URdczNK3W+SkrSWC/V9ZyJFc9etIglHTD7o4KNBZIdKvzjqj500kca4FrMAUoIE5vT
	 yok6MdDEoiwPwiCpUm9r8k+S3Fb9BSAzaEwWEl8vupOe9Nhlb6Eztq4LBhL2hGIOg/
	 5z4dLaBohTguxawa/FZHPqiMK3SiTDXcrO2aMgFmprS2/knK5C7rT2wSNrVQxz0VQz
	 PQxGoNWWyxGOQ3DZKevs1L3byjSr1qq1p3uI1zEn1PwLP8fZu5X0Y2cNMIHCmerxLr
	 5NgHJdKtbl58A==
Date: Wed, 16 Oct 2024 14:38:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <jim2101024@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH v3 04/11] PCI: brcmstb: Expand inbound size calculation
 helper
Message-ID: <20241016193802.GA645895@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCKTBt17LCyvQQnOqMdu1KUY61bRKCYQC8=+HDYaddj-MAd2Q@mail.gmail.com>

On Wed, Oct 16, 2024 at 01:09:00PM -0400, Jim Quinlan wrote:
> On Mon, Oct 14, 2024 at 1:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Oct 14, 2024 at 10:10:11AM -0700, Florian Fainelli wrote:
> > > On 10/14/24 09:57, Bjorn Helgaas wrote:
> > > > On Mon, Oct 14, 2024 at 04:07:03PM +0300, Stanimir Varbanov wrote:
> > > > > BCM2712 memory map can supports up to 64GB of system
> > > > > memory, thus expand the inbound size calculation in
> > > > > helper function up to 64GB.
> > > >
> > > > The fact that the calculation is done in a helper isn't important
> > > > here.  Can you make the subject line say something about supporting
> > > > DMA for up to 64GB of system memory?
> > > >
> > > > This is being done specifically for BCM2712, but I assume it's safe
> > > > for *all* brcmstb devices, right?
> > >
> > > It is safe in the sense that all brcmstb devices with this PCIe
> > > controller will adopt the same encoding of the size, all of the
> > > currently supported brcmstb devices have a variety of
> > > limitations when it comes to the amount of addressable DRAM
> > > however. Typically we have a hard limit at 4GB of DRAM per
> > > memory controller, some devices can do 2GB x3, 4GB x2, or 4GB
> > > x1.
> > >
> > > Does that answer your question?
> >
> > I'd like something in the commit log to the effect that while
> > we're doing this to support more system memory on BCM2712, this
> > change is safe for other SoCs that don't support as much system
> > memory.
> 
> This setting configures the size of an RC's inbound window to system
> memory.  Any inbound access outside of all of the inbound windows
> will be discarded.
> 
> Some existing SoCs cannot support the 64GB size.  Configuring such
> an SoC to 64GB will effectively disable the entire window.

So I *think* you're saying that this patch will break existing SoCs
that don't support the 64GB size, right?

Bjorn

