Return-Path: <linux-pci+bounces-37621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F3BBED5E
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 19:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 122E734A615
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70ED246BA4;
	Mon,  6 Oct 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHKtrkyr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE4242D6F;
	Mon,  6 Oct 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772635; cv=none; b=a7lnpIn5XKqRTb0miZ6WAzE4Zgtzx5bbrsNy98nYT/JcF55IlJBX1N2YFxn92TJzqn4eCE/SFl4AZi6lvZSd7ayKACPSpsgcqqn+E+pC5ALSqDPcfNdLlVm7XJG14igh8xykT16YepD96T7L0g3if+24c6w+rKTqxEtXDTHh9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772635; c=relaxed/simple;
	bh=Y6uixzSgd1RpD1Qpsk4LEEaC4r3WAyx/6nNmZNF/E2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYG1noZWZJNRn+nn29Oo/UEZYDC212o998/vIjYuVJ1arLKz3Zp5yRtFxQK/pGv2PrxFx08SkEgFGaacO+lMub5ddZ1ZbP+sG+wBo/HYvWdzceSwHZxrTY5L8272Oi+M+Pv2jJHZSt1kQxGL4lP6XUnaRKHWNscuGFGwt48XBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHKtrkyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37EAC4CEF5;
	Mon,  6 Oct 2025 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759772635;
	bh=Y6uixzSgd1RpD1Qpsk4LEEaC4r3WAyx/6nNmZNF/E2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHKtrkyrOO9H9F6SQsYF6oGmNZ5jvPK81Un6DOPAkWMb+J/vb+M5p/5gfXu9wE/ym
	 sFVgdbGrBfzHwzqK29ihMKQICHNz6QKbpLObSbnnQRqnaNtJsNlnc2U3NwoeGDmIPv
	 Erwx47FkRSZLylNzBE0nXBnE8HutO4hG8bxJsfxJY9Znnah1QKCE40w/l5L+7FLUk5
	 5RGP+22jbw8x07KUryToDF8FpkjdfXiH8NXQmEakBCnazAYuz2aflB8o/4sajdW2rT
	 O+8ZZCbYiVz66N0NUG3zRsL+JrDlQHkGovr/WFP0aNseHZFaOM62y+cJO4s4vRbDO+
	 qQWlSjQoGtAoQ==
Date: Mon, 6 Oct 2025 10:43:53 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Victor Paul <vipoll@mainlining.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lukas Wunner <lukas@wunner.de>, Greg KH <gregkh@linuxfoundation.org>, 
	Daniel Martin <dmanlfc@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: probe: fix typo: CONFIG_PCI_PWRCTRL ->
 CONFIG_PCI_PWRCTL
Message-ID: <32xgw5nop3xl4toudpskhqppzxa3swtsiueggot4kvrh7q3gn2@jslnan4pmwia>
References: <20251006143714.18868-1-vipoll@mainlining.org>
 <20251006161447.GA521686@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006161447.GA521686@bhelgaas>

On Mon, Oct 06, 2025 at 11:14:47AM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 06, 2025 at 06:37:14PM +0400, Victor Paul wrote:
> > The commit
> > 	8c493cc91f3a ("PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled")
> > introduced a typo, it uses CONFIG_PCI_PWRCTRL while the correct symbol
> > is CONFIG_PCI_PWRCTL. As reported by Daniel Martin, it causes device
> > initialization failures on some arm boards.
> > I encountered it on sm8250-xiaomi-pipa after rebasing from v6.15.8
> > to v6.15.11, with the following error:
> > [    6.035321] pcieport 0000:00:00.0: Failed to create device link (0x180) with supplier qca6390-pmu for /soc@0/pcie@1c00000/pcie@0/wifi@0
> > 
> > Fix the typo to use the correct CONFIG_PCI_PWRCTL symbol.
> > 
> > Fixes: 8c493cc91f3a ("PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled")
> > Cc: stable@vger.kernel.org
> > Reported-by: Daniel Martin <dmanlfc@gmail.com>
> > Closes: https://lore.kernel.org/linux-pci/2025081053-expectant-observant-6268@gregkh/
> > Signed-off-by: Victor Paul <vipoll@mainlining.org>
> 
> Might this be a stale .config file?
> 
> I think 13bbf6a5f065 ("PCI/pwrctrl: Rename pwrctrl Kconfig symbols and
> slot module") should have resolved this. 
> 

Looks like 13bbf6a5f065 was not backported to 6.15 (since it is not a fix), but
8c493cc91f3a was (since it is a fix). But 6.15 is not LTS and the stable release
has been stopped with 6.15.11, we can't backport any fixes now.

So I think you should move on to 6.16 based kernel where the issue is not
present, or carry the fix in your tree.

- Mani

> In the current upstream tree (fd94619c4336 ("Merge tag 'zonefs-6.18-rc1'
> of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs"),
> git grep "\<CONFIG_PCI_PWRCTL\>" finds nothing at all.
> 
> > ---
> >  drivers/pci/probe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 19010c382864..7e97e33b3fb5 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2508,7 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >  }
> >  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
> >  
> > -#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
> > +#if IS_ENABLED(CONFIG_PCI_PWRCTL)
> >  static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> >  {
> >  	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> > -- 
> > 2.51.0
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

