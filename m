Return-Path: <linux-pci+bounces-11591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B5794EC2F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 13:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2B41C20E01
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9E177981;
	Mon, 12 Aug 2024 11:59:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67557178CE7;
	Mon, 12 Aug 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463955; cv=none; b=sEs95hIzZ76f2BA220on7wxLUgUZpAwinVIU67hapwPgDSJ2B8NUlPPi2uRzvmRCHmjwKjyWjqmrsDnpCRHSARvdy1EtC+ZzJkhIcLgqMdP8dJuOiPBt3igYygBvllZoC+sz5p6/LhvMKJDwfe6hvsryxckKkJR4T5TwhThleIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463955; c=relaxed/simple;
	bh=CGUVZHA4td1Bf0yOxb/xPJ+40kpIL1S5PJ8nX1gT5fw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tRQaL1+yuRS2HwwyG5ptUPrx9ek3B2kuPe06mph2d5TduK5M760sYP4uttnMm5jYruuRroyWf4aYz50HXXEE34BhUNKDKWm40OD6iupzRL0MFkZExCKjxdxUIICv7DCJVZEslZkZjAKnDQ4o+sD1ubT9ffC+LcgMqHGj4fAaFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E2B7A92009C; Mon, 12 Aug 2024 13:59:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DCA2692009B;
	Mon, 12 Aug 2024 12:59:04 +0100 (BST)
Date: Mon, 12 Aug 2024 12:59:04 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] PCI: Clear LBMS on resume to avoid Target Speed
 quirk
In-Reply-To: <42afa3ee-4429-90e4-9e98-18a0d30c0a3c@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2408121247580.59022@angie.orcam.me.uk>
References: <20240129184354.GA470131@bhelgaas> <aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com> <alpine.DEB.2.21.2401301537070.15781@angie.orcam.me.uk> <a7ff7695-77c5-cf5a-812a-e24b716c3842@linux.intel.com> <d5f14b8f-f935-5d5e-e098-f2e78a2766c6@linux.intel.com>
 <alpine.DEB.2.21.2402011800320.15781@angie.orcam.me.uk> <d9f6efe3-3e99-0e4b-0d1c-5dc3442c2419@linux.intel.com> <a0b070b7-14ce-7cc5-4e6c-6e15f3fcab75@linux.intel.com> <alpine.DEB.2.21.2408091327390.61955@angie.orcam.me.uk>
 <42afa3ee-4429-90e4-9e98-18a0d30c0a3c@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 9 Aug 2024, Ilpo Järvinen wrote:

> > # setpci -s 02:03.0 CAP_EXP+0x12.W
> > 5812
> > # setpci -s 02:03.0 CAP_EXP+0x12.W
> > 5811
> > 
> > As you can see the Link Training bit oscillates as I previously reported 
> > and noted in the introduction to `pcie_failed_link_retrain', and also the 
> > Current Link Speed field flips between 2.5GT/s and 5GT/s.
> 
> Okay, thanks for testing. I suppose that test wasn't done in a busy loop 
> (it might not be easy capture very short link up state if there was any 
> such period when testing it by manually launching that command a few 
> times)?

 These were just random samples obtained by reissuing `setpci' command at
a command prompt, as shown.  As I say I haven't ever seen DLLLA going up, 
or I suppose the dance would have stopped.  Polling for the bit set in a 
busy loop would require injecting code into `pcie_failed_link_retrain' for 
such a diagnostic check if at all feasible or fiddling with U-Boot code.  

 I'll see if I can make a suitable change to `pcie_failed_link_retrain' 
and persuade the kernel not to interfere for the duration of the check 
(it'll be fine for the kernel to crash afterwards).  If that won't do, 
then it's straightforward to arrange with U-Boot, but to do it safely it 
requires physical access to the system as U-Boot is stored on a uSD card 
with this system, and I'm not on site anymore, so it'll have to wait.

  Maciej

