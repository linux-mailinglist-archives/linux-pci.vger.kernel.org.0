Return-Path: <linux-pci+bounces-42711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0DBCA9D1E
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 02:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC34309591A
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 01:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0EF24503C;
	Sat,  6 Dec 2025 01:07:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38A238C36;
	Sat,  6 Dec 2025 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764983275; cv=none; b=XS5pxRETWmGLYjMMJI2g+mmUpCYBbWCyuVY49qBS7JfNhv8XRmda8oV0NVnxXvbHCIhQfP6Umc3vUC072Z0VuxvOJTSNPYU3qyXDWzVccQpVexz07IzGZpLInMp1fHmOgWGVolsTUETa0oUiUZPzI7+4eoA3m+h52kx0oUBlvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764983275; c=relaxed/simple;
	bh=pjYgaVIbcEfdDNWxprIyquS+GGOvI+TLtRVvquPUyXQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gZOwU2KP4oNhK+CNeSIyou2E/lvoBKxkrBENNnB2c1sVG8GBFyCMalYpRed6Jqq2CEcLrM10t49Xggjfrcyvykbxtk4lxfKAJmU9ocFEqcU50XMRmUV4I59AT2Xd0VrZa6fyjNRaaunFE+9VCes7n5zFRaR/guE92J82nDxiFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A06C192009C; Sat,  6 Dec 2025 02:07:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 994C892009B;
	Sat,  6 Dec 2025 01:07:43 +0000 (GMT)
Date: Sat, 6 Dec 2025 01:07:43 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
cc: glaubitz@physik.fu-berlin.de, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    riccardo.mottola@libero.it
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
In-Reply-To: <20251202.180451.409161725628042305.rene@exactco.de>
Message-ID: <alpine.DEB.2.21.2512050237490.49654@angie.orcam.me.uk>
References: <20251202.174007.745614442598214100.rene@exactco.de> <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de> <20251202.180451.409161725628042305.rene@exactco.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 2 Dec 2025, René Rebe wrote:

> > Is there actually a justification to restrict the use of D3 to ARM64,
> > PPC64 and RISCV? What about MIPS, LoongArch or s390x?
> 
> Because the ones I picked are more modern, and thus more likely to
> work. MIPS is very old. [...]

 How old is "very old?"

 Granted, the newest MIPS CPU/system controller (aka host bridge) I own is
from 2013 and conventional PCI only, but that is just because the core was 
synthesised for interfacing a conventional PCI base board I have the core 
card plugged into.  Is it very old already or just somewhat old?

 Chips continue being manufactured to date and I'm not sure as to new core
designs, but those went through to at least 2018 and I'd expect some were 
combined with PCIe system controller IP.

 So this seems like something that needs to be keyed off perhaps the 
capabilities of the system controller/host bridge?  If you give me a shell 
recipe to trigger the issue you came across, then I can see what happens 
with some of my MIPS systems.  I've got a bunch of options with PCI-PCIe 
reverse bridges and PCIe switches I could try.

  Maciej

