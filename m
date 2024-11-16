Return-Path: <linux-pci+bounces-16979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EEE9CFFC9
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 17:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9149B22237
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8623EAF6;
	Sat, 16 Nov 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRajz0Ni"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFD372;
	Sat, 16 Nov 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773412; cv=none; b=khR6oER5xfY5gnZtrgq7jhBOM3feZ5CE0Z/HTwxOYJ8C9SiV98fY2mcYYQLJbYOd1r9AmqzS8x/cWwCqKY1XAA8b+slukkz45iOrxXWmjKAzd87K7JYM7wIogv5KYlms3DnfE9y01Uu9hwqrGe1p6h4j0QNEbxi8hiHwW9vyaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773412; c=relaxed/simple;
	bh=uQ2hZIbcyCdOT5tFiJM33Yw3IrjR5YjDThAnh5uBtiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lJDn+wYY7/H2Dc0jjqIB/evQ37UuCvvSLRcBT9WyfQZaW1LJWCUMUDjX1FVbFJY+Qc8+V0CmnWchpYtFrt/yHnHHa7dnpvofvKs8dfInu6xMcNMjURehu65eSg5RjjYS7MFAd32OWpQtm/jhnJLEztyGjLZtZHmQawvYpaHeV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRajz0Ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DAFC4CEC3;
	Sat, 16 Nov 2024 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731773412;
	bh=uQ2hZIbcyCdOT5tFiJM33Yw3IrjR5YjDThAnh5uBtiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QRajz0Nivm/dImoTpjV42/bIEt+TN4wI5erATGPAjmhkw4ENo6FQbL/zjKdSdk9/6
	 rn0k1xF+mSMKL6cU5xVSrKfo3x+h+SjTVOuoBAO/stWd1Rys7xrJl+LEQo9Rg6n3hv
	 6odm8MoOr8UGB5CDGrdzSBjKEcT/69xpgr5sH/4D9FXboNLpoxyDzk4619ehBnqWuu
	 tT/2dh3a6glt6l8+2O++2bgz9r02KQGcD3AoZpy48Ty+0K2vBzTJjdslVZCaRlQv1M
	 NX7gdIHdPS2hb/Tvyfe2AxJsq0l3xI0DJzJoPaA22645pB1ZHifbDfVhb3i3vK4Chc
	 81eb1N0jaQyBA==
Date: Sat, 16 Nov 2024 10:10:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove IRQF_ONESHOT and handle hardirqs
 instead
Message-ID: <20241116161010.GA2125250@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec7f9169-26dc-cc0e-e321-b66ca9d3f40e@linux.intel.com>

On Sat, Nov 16, 2024 at 04:40:51PM +0200, Ilpo Järvinen wrote:
> On Fri, 15 Nov 2024, Bjorn Helgaas wrote:
> 
> > On Fri, Nov 15, 2024 at 06:57:17PM +0200, Ilpo Järvinen wrote:
> > > bwctrl cannot use IRQF_ONESHOT because it shares interrupt with other
> > > service drivers that are not using IRQF_ONESHOT nor compatible with it.
> > > 
> > > Remove IRQF_ONESHOT from bwctrl and convert the irq thread to hardirq
> > > handler. Rename the handler to pcie_bwnotif_irq() to indicate its new
> > > purpose.
> > > 
> > > The IRQ handler is simple enough to not require not require other
> > > changes.
> > > 
> > > Fixes: 058a4cb11620 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
> > > Reported-by: Stefan Wahren <wahrenst@gmx.net>
> > > Link: https://lore.kernel.org/linux-pci/dcd660fd-a265-4f47-8696-776a85e097a0@gmx.net/
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Squashed into 058a4cb11620, thanks!
> > 
> > Also added your tested-by, Stefan, thanks very much for doing that!
> 
> Hi Bjorn,
> 
> You might want to also remove "3) ..." part from the commit message as it 
> still refers to threaded IRQ and IRQF_ONESHOT so it won't confuse anybody 
> when looking at this years from now :-).

Removed, thanks for that!

