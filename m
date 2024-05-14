Return-Path: <linux-pci+bounces-7466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE148C5CB3
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 23:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A321F22B2B
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2F181333;
	Tue, 14 May 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np6fuxKT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D62A1D4;
	Tue, 14 May 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721295; cv=none; b=phKcQYYErq8HyZ4S3fKXl3AQuHKXyGG66BHAj7sP9pgQGc5OU2XBJRhWROGHQl2+6bBfcyFJVJ821kUvNKamyIph0OYTfGloKA+Zqm7E/tsYhxCZpy0zmIaPDsB77cQZ0LiIFK55jKqxt4JCq/Ps8SGZob/XMcP0f/wAnpppXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721295; c=relaxed/simple;
	bh=i3fN9h2+CLDQOAZAAbIsEy+v+HuuQjcOK3oDgaeItMk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y+jRRz9hr5wNuTXHdkXWjEpShLkxPRVdz3Rwe8doFe5N43Z34bMJZi7lW+LjemO1cFyH+WswUailZ1bxhD743PAZEwv9254aWinhWO9/0Uk7D5aIflaLBuL0LEd/4HU3+8c8Yf5gV3Gg3hB//WwOWYXMCcX/eo0OCBy5i9YXioM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np6fuxKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421F9C2BD10;
	Tue, 14 May 2024 21:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715721294;
	bh=i3fN9h2+CLDQOAZAAbIsEy+v+HuuQjcOK3oDgaeItMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=np6fuxKTqtPRT8iipzJ0RN510tW9hfBsYEmH9a2GlWjn8JhGRwNOmTvi99QDfxHIx
	 8CmplmCYmbWUT1mYloKdL+lia6l+0IiPVmPRkD3ykqIoW4/808Xj7O69npgPCLMSwu
	 8oiIwFSyc5Z+TsdhJ5Uw4yT2xB9lrK5IOj/ByXPO2SPKPYYvgtPqIsTMYt9LuOl/qj
	 rJov5HhZJSyqYKS7lizxMhy2z5VYOfKzAO9ghIhnnpt/e/RehsrfWFPle4hmWfw4Qd
	 rh+kXH2kRHi8xnU7UDNZRpNi8YKU7tUwHTLOAsdeBYVoJkFIj1p6RlFUnsWKQJ85Ue
	 saTzqVOwH53Og==
Date: Tue, 14 May 2024 16:14:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com, u.kleine-koenig@pengutronix.de,
	cassel@kernel.org, dlemoal@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v7 2/2] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <20240514211452.GA2082543@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b56604d-a2b8-4227-8a6f-c477332416b4@ti.com>

On Tue, May 14, 2024 at 05:41:48PM +0530, Siddharth Vadapalli wrote:
> On Mon, May 13, 2024 at 04:53:50PM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 28, 2024 at 02:20:41PM +0530, Siddharth Vadapalli wrote:
> > > In the process of converting .scan_bus() callbacks to .add_bus(), the
> > > ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> > > The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> > > to controller version 3.65a, while the .add_bus() method had been added
> > > to ks_pcie_ops which is shared between the controller versions 3.65a and
> > > 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> > > ks_pcie_v3_65_add_bus() method is applicable to the controller version
> > > 4.90a which is present in AM654x SoCs.
> > > 
> > > Thus, as a fix, remove "ks_pcie_v3_65_add_bus()" and move its contents
> > > to the .msi_init callback "ks_pcie_msi_host_init()" which is specific to
> > > the 3.65a controller.
> > > 
> > > Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
> > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Suggested-by: Niklas Cassel <cassel@kernel.org>
> > > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > 
> > Thanks for splitting this into two patches.  Krzysztof has applied
> > both to pci/controller/keystone and we hope to merge them for v6.10.
> > 
> > I *would* like the commit log to be at a little higher level if
> > possible.  Right now it's a detailed description at the level of the
> > code edits, but it doesn't say *why* we want this change.
> > 
> > I think the first cut at this was
> > https://lore.kernel.org/linux-pci/20231011123451.34827-1-s-vadapalli@ti.com/t/#u,
> > which mentioned Completion Timeouts during MSI-X configuration and 45
> > second delays during boot.
> > 
> > IIUC, prior to 6ab15b5e7057, ks_pcie_v3_65_scan_bus() initialized BAR
> > 0 and was only used for v3.65a devices.  6ab15b5e7057 renamed it to
> > ks_pcie_v3_65_add_bus() and called it for both v3.65a and v4.90a.
> > 
> > I think the problem is that in the current code, the
> > ks_pcie_ops.add_bus() method (ks_pcie_v3_65_add_bus()) is used for all
> > devices (both v3.65a and v4.90a).  So I guess doing the BAR 0 setup on
> > v4.90a broke something there?
> 
> BAR0 was set to a different value on AM654x SoC which has the v4.90a
> controller, which is identical to what is set even for the v3.65a
> controller. The difference is that BAR0 is programmed to a different
> value for enabling inbound MSI writes on top of the common configuration
> performed for BAR0.
> 
> Common configuration for BAR0:
> ks_pcie_probe
>   dw_pcie_host_init
>     dw_pcie_setup_rc
>     ...
>      /* Setup RC BARs */
>      dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
>      dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);

Tangential questions that don't need to be addressed for this patch:
There's a bunch of code between these writes and the one below.  Does
that code in the middle depend on the above, or should all three of
these writes be together?  Is there some magic in writing
PCI_BASE_ADDRESS_0 twice?  This is common code for all DWC devices, so
it must work OK, but it looks strange.

>      dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);

What's the net effect of these three writes?  Disabling BAR 0 and
BAR 1, as suggested at [1, 2]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-keystone.c?id=v6.9#n399
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-rcar-gen4.c?id=v6.9#n280

> MSI specific configuration of BAR0 performed after the common
> configuration via the ks_pcie_v3_65_scan_bus() callback:
> 	/* Configure and set up BAR0 */
> 	ks_pcie_set_dbi_mode(ks_pcie);
> 
> 	/* Enable BAR0 */
> 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
> 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);

I assume that in DBI mode, this actually writes a mask, not a value?
If writing a 0xfff mask means that the low 12 bits could not be set,
maybe this configures it to be a 4K memory BAR?

But is there some reason to do two writes to the same register?

> 	ks_pcie_clear_dbi_mode(ks_pcie);
> 
> 	 /*
> 	  * For BAR0, just setting bus address for inbound writes (MSI) should
> 	  * be sufficient.  Use physical address to avoid any conflicts.
> 	  */
> 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);

After clearing DBI mode, this looks like it would set BAR 0 to the
ks_pcie->app.start address, which makes some sense, since the low 4
bits would all be zero (assuming the address is page aligned), which
would make it a 32-bit memory BAR.

> The above configuration of BAR0 shouldn't be performed for AM654x SoC.
> While I am not certain, the timeouts are probably a result of the BAR
> being programmed to a wrong value which results in a "no match" outcome.
> 
> > I'm not quite clear on the mechanism, but it would be helpful to at
> > least know what's wrong and on what platform.  E.g., currently v4.90
> > suffers Completion Timeouts and 45 second boot delays?  And this patch
> > fixes that?
> 
> Yes, the Completion Timeouts cause the 45 second boot delays and this
> patch fixes that.

And this problem happens on AM654x/v4.90a, right?  I really want the
commit log to say what platform is affected!

Maybe something like this?

  PCI: keystone: Enable BAR 0 only for v3.65a

  The BAR 0 initialization done by ks_pcie_v3_65_add_bus() should
  happen for v3.65a devices only.  On other devices, BAR 0 should be
  left disabled, as it is by dw_pcie_setup_rc().

  After 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus()
  callback to use add_bus"), ks_pcie_v3_65_add_bus() enabled BAR 0 for
  both v3.65a and v4.90a devices.  On the AM654x SoC, which uses
  v4.90a, enabling BAR 0 causes Completion Timeouts when setting up
  MSI-X.  These timeouts delay boot of the AM654x by about 45 seconds.

  Move the BAR 0 initialization to ks_pcie_msi_host_init(), which is
  only used for v3.65a devices, and remove ks_pcie_v3_65_add_bus().

