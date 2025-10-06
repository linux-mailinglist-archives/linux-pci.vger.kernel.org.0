Return-Path: <linux-pci+bounces-37632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF6BBF1DE
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 21:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E16624F13AF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECEB25333F;
	Mon,  6 Oct 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIdRJjOU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEA2AF1B;
	Mon,  6 Oct 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779762; cv=none; b=r1qUAyTT07z3Es4KRxdHACsLUFIUfCswgcW1MZMO6k35UHz0YSHl9/Br1OGTBL2MYxFuIss7vOBj2M0SyY0vcUqGmCLW9QJcowNumzN3zN59azIQkFh8dFlZsKzbGPospOtLbnzXk88Mr2gy5KzP9B/fTU5aHKI6paXkyKUU5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779762; c=relaxed/simple;
	bh=WmVauaY89mdmOO7C3ZW+vI9b3vibAHdUAOecbiQ0amU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b7LevcCO6MOifGXSIrRyT4W5cV6vbtLTmmPKyn9NqQ6UlCqD+KX41gIAXDCGXBBbOn+nH/3IgIehFQpIVrsfS8ocLOERO4JhQsnQED6mMLtMeyv2YrRPiJOVm4OBIGiz+YsGqbC2KRoC61V4msZv94Ethhmc7BKazyTVh2doTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIdRJjOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5F2C4CEF5;
	Mon,  6 Oct 2025 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759779762;
	bh=WmVauaY89mdmOO7C3ZW+vI9b3vibAHdUAOecbiQ0amU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rIdRJjOU0UYrMsrmVlQAuZcbbgV7B3yR3Q8cO9iUXDyyixCQRvEWhakxwUM/2e+BN
	 Sxxhw2Ntpbt2jKUykFR4kDix/3KHtgybkc8XUgESWJanNYUMFMsoqWiUC+c4FgUw/U
	 cW5en5tlJrsTwraM8BTSjzdvP9nqd9x2JgZItsXOJJd2bdFLlDV/DxtjYV9M++g/B0
	 b+/kE+p1iS0XrCFdhBH6+5KX3P4toN2aW8PYkDKVT2vL+Y1NW0YskxO+TGzQXUy5WX
	 aF2gxZUmfII37qR9nZNrw4bWANNZZP0fHBARhd6h83Q4/a4sNmvWZqwdkD8faxCSDe
	 FWb+Yx96gTw0Q==
Date: Mon, 6 Oct 2025 14:42:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: ixp4xx: Guard ARM32-specific hook_fault_code()
Message-ID: <20251006194241.GA537937@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNxCoN2fP4aEAH2i@shell.armlinux.org.uk>

On Tue, Sep 30, 2025 at 09:50:40PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 30, 2025 at 08:59:36PM +0200, Linus Walleij wrote:
> > On Thu, Sep 25, 2025 at 10:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > hook_fault_code() is an ARM32-specific API.  Guard it and related code with
> > > CONFIG_ARM #ifdefs so the driver can be compile tested on other
> > > architectures.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > It looks OK to me
> > Acked-by: Linus Walleij <linus.walleij@linar.org>
> > 
> > I see some other ARM32 drivers use it too, but we surely do
> > not have a arch-agnostic way of handling bus errors so perhaps it
> > need to be like this.
> > 
> > I think Russell created the fault hooks originally so CC:ing him
> > in.
> 
> I wonder what the point of compile testing if it needs code to be
> #ifdef'd out.

We can still catch errors in the bulk of the drivers.

> Wouldn't it be better to add something like:
> 
> #ifndef CONFIG_ARM
> static inline void hook_fault_code(int n, int (*fn)(unsigned long, unsigned int,
> 						    struct pt_regs *),
> 				   int sig, int code, const char *name)
> {
> }
> #endif
> 
> maybe to a local header that pci-imx6, pci-keystone, pcie-rcar-host
> and pci-ixp4xx can all share?

I guess we could put a stub like that in drivers/pci/pci.h.  But all
these drivers also have other CONFIG_ARM #ifdefs for the
hook_fault_code() *handlers*, so I'm not sure it's any better to
remove one #ifdef and leave the other.

