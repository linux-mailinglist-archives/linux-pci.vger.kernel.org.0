Return-Path: <linux-pci+bounces-16270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49969C0BEF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1954C1C21046
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B42629C;
	Thu,  7 Nov 2024 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dql3Dcdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48FDDBE;
	Thu,  7 Nov 2024 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997987; cv=none; b=N/smJPaLxl+neIfpvbQwAFf3OSJ9GeJ3LX1eEJc3++B/sb6GIYkeOXjnevkcRunoR612TPOvbj84aQ/NlGGIZZrS4Hp04RQ+DG9vnnJ5i6j8fJ3ksF70D41sYvrrkW4LvXu9xC8ZmGRGaTmPe5jIB5fV6eXTd5M5VRXI8ufON4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997987; c=relaxed/simple;
	bh=GZHWeP89CUKrAe3MvpLoueZH/R99ojWtvbeyFfi7yj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cISBXn8/aMBJRwNJmoL7Wnz122NmzifG2gP9EmbDC+Jn0Y5Pz5AClBu080zXGbJsNUw/npwCUw2+HXhcbC1CZqKVPc75KVYi7zeW4qWn6WiYbfvmAtFRDVxOuvvOsLNH7KUPialL8Sab1Gp46NA18bSIWXccVU8uLALYz+vwO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dql3Dcdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595F2C4CECC;
	Thu,  7 Nov 2024 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730997987;
	bh=GZHWeP89CUKrAe3MvpLoueZH/R99ojWtvbeyFfi7yj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Dql3DcdiSw6/w7rk8GoAlnLI5jh2cZBXjjhWoLwNBf+/GdHMPonOD9UzeB4iCMyTF
	 lAmTyLyimvHtMztSWzboGnqigMuXV3j6FQzHwJ+ShPSCkovNPd0L74a3vaynKnR+2n
	 UQi7zJzODcelksrznG50+NHfaFiKvM305FehRCXCm8edyq8AupKpqqsrDL60T5cq4B
	 GlFZBItAKrfRPuhIOspE+Q6hcdqDgASwQlJjJrbsJrk5qH8SeU5jyqhmQzCEKgbfgg
	 tb4RVylua4obd8Wgh2FBkSoFMHUC959fBxncGWpklUukNZwBYhugy02bU5/vbL6yiD
	 7Fs8zgD+Mm8JQ==
Date: Thu, 7 Nov 2024 10:46:24 -0600
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
Message-ID: <20241107164624.GA1618716@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzpGSyAVe6bz9H2@lore-desk>

On Thu, Nov 07, 2024 at 05:21:45PM +0100, Lorenzo Bianconi wrote:
> On Nov 07, Bjorn Helgaas wrote:
> > On Thu, Nov 07, 2024 at 08:39:43AM +0100, Lorenzo Bianconi wrote:
> > > > On Wed, Nov 06, 2024 at 11:40:28PM +0100, Lorenzo Bianconi wrote:
> > > > > > On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > > > > > > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > > > > > > PCIe controller driver.
> > > > > > > ...
> > 
> > > > > > Is this where PERST# is asserted?  If so, a comment to that effect
> > > > > > would be helpful.  Where is PERST# deasserted?  Where are the required
> > > > > > delays before deassert done?
> > > > > 
> > > > > I can add a comment in en7581_pci_enable() describing the PERST issue for
> > > > > EN7581. Please note we have a 250ms delay in en7581_pci_enable() after
> > > > > configuring REG_PCI_CONTROL register.
> > > > > 
> > > > > https://github.com/torvalds/linux/blob/master/drivers/clk/clk-en7523.c#L396
> > > > 
> > > > Does that 250ms delay correspond to a PCIe mandatory delay, e.g.,
> > > > something like PCIE_T_PVPERL_MS?  I think it would be nice to have the
> > > > required PCI delays in this driver if possible so it's easy to verify
> > > > that they are all covered.
> > > 
> > > IIRC I just used the delay value used in the vendor sdk. I do not
> > > have a strong opinion about it but I guess if we move it in the
> > > pcie-mediatek-gen3 driver, we will need to add it in each driver
> > > where this clock is used. What do you think?
> > 
> > I don't know what the 250ms delay is for.  If it is for a required PCI
> > delay, we should use the relevant standard #define for it, and it
> > should be in the PCI controller driver.  Otherwise it's impossible to
> > verify that all the drivers are doing the correct delays.
> 
> ack, fine to me. Do you prefer to keep 250ms after clk_bulk_prepare_enable()
> in mtk_pcie_en7581_power_up() or just use PCIE_T_PVPERL_MS (100)?
> I can check if 100ms works properly.

It's not clear to me where the relevant events are for these chips.

Do you have access to the PCIe CEM spec?  The diagram in r6.0, sec
2.2.1, is helpful.  It shows the required timings for Power Stable,
REFCLK Stable, PERST# deassert, etc.

Per sec 2.11.2, PERST# must be asserted for at least 100us (T_PERST),
PERST# must be asserted for at least 100ms after Power Stable
(T_PVPERL), and PERST# must be asserted for at least 100us after
REFCLK Stable.

It would be helpful if we could tell by reading the source where some
of these critical events happen, and that the relevant delays are
there.  For example, if PERST# is asserted/deasserted by
"clk_enable()" or similar, it's not at all obvious from the code, so
we should have a comment to that effect.

Bjorn

