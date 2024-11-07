Return-Path: <linux-pci+bounces-16247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0798D9C09DD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1331F218B5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED17DA9C;
	Thu,  7 Nov 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGUvqI+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F4CA6F;
	Thu,  7 Nov 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992624; cv=none; b=b9V8za9LffFsYwAGOgTZ0cEXU4V+Au87P4Zc2BEyEagtDJFBX4vzK1HPBP9WhzpNpJ02biSJE5kllG9pBj9fUtHS18c/OQRBoyH/mrH7neMNAvrLhOl469WTjU29Xg7YIK12PaELL63h6KhA1DyEAZQhJ3Q64f9SvAbglG+OYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992624; c=relaxed/simple;
	bh=nOBMM5Z93VYRrmS8VDCWfuHFU5UwC2F9O0lLn0o2yX8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dUbrJEtYgiiwIWpx0utnqolfJ7Ve6ws4ue2s30rDRry+giAXOhwxhyQ8BJXyHCAXciA2uljz+u/NCnQ27ZcjMmqNJsj9n2RqlzJyzDxYj0FkEgytKMbDGJ2j0HDTSgBMykeS39i2cNhQwxn5W1HQtt9WWuGPN4dY05ZgXmJcs0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGUvqI+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65039C4CECC;
	Thu,  7 Nov 2024 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730992623;
	bh=nOBMM5Z93VYRrmS8VDCWfuHFU5UwC2F9O0lLn0o2yX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MGUvqI+jo/oOe95SEnpU0MdcS1QG+6EAHLwXb22HVByyosqUJ2ld3+A/Jsc3ksIsV
	 tsk+CooPxFKM50j+ggAW22e8HAdvOaywix/308Su9xIUw6k48gSHo0iZ6DK9BFoa+u
	 w7nkBO3dHxPN0DKGlcSz/5weolwVrGAAXUNzWwiqfNc3JFM0vQ5FmxymzC72P0i2zU
	 EJIGbXVNzkAT9eqicqAbruZXV9NVN1efsScgwSuzam1Nnj5X2NHHm285VbSl7f7FAK
	 VlgT3UfBRtdn980Z4Ym4ezf5uTJGspy3KV7VZmAXkw+mYJXaAYLG2VcaV1V8lwnB8m
	 B6TkCpgLWNpFQ==
Date: Thu, 7 Nov 2024 09:17:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <20241107151701.GA1614390@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyxuv-2SPuEXiL5R@lore-desk>

On Thu, Nov 07, 2024 at 08:39:43AM +0100, Lorenzo Bianconi wrote:
> > On Wed, Nov 06, 2024 at 11:40:28PM +0100, Lorenzo Bianconi wrote:
> > > > On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > > > > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > > > > PCIe controller driver.
> > > > > ...

> > > > Is this where PERST# is asserted?  If so, a comment to that effect
> > > > would be helpful.  Where is PERST# deasserted?  Where are the required
> > > > delays before deassert done?
> > > 
> > > I can add a comment in en7581_pci_enable() describing the PERST issue for
> > > EN7581. Please note we have a 250ms delay in en7581_pci_enable() after
> > > configuring REG_PCI_CONTROL register.
> > > 
> > > https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#L396
> > 
> > Does that 250ms delay correspond to a PCIe mandatory delay, e.g.,
> > something like PCIE_T_PVPERL_MS?  I think it would be nice to have the
> > required PCI delays in this driver if possible so it's easy to verify
> > that they are all covered.
> 
> IIRC I just used the delay value used in the vendor sdk. I do not
> have a strong opinion about it but I guess if we move it in the
> pcie-mediatek-gen3 driver, we will need to add it in each driver
> where this clock is used. What do you think?

I don't know what the 250ms delay is for.  If it is for a required PCI
delay, we should use the relevant standard #define for it, and it
should be in the PCI controller driver.  Otherwise it's impossible to
verify that all the drivers are doing the correct delays.

I don't know what other drivers are using that clock.  Are you
suggesting that it may be used in non-PCI situations where the
required delay might be different?  If another user requires 250ms,
but PCI requires only 100ms, I think it would be worth having separate
delays in each user so PCI wouldn't have to pay that extra 150ms.

Bjorn

