Return-Path: <linux-pci+bounces-42740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676BACAB626
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 15:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0AF63004D3C
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709EB26F293;
	Sun,  7 Dec 2025 14:40:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326351D9346;
	Sun,  7 Dec 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765118432; cv=none; b=iHaRdDwn3Yo4eAHnp4WqXZvp4kLyXYxG7QfLfyP0NUHk6L9BuYKyh7tRjXNhPMuKNSBcnU80T7sqFGJAjak/caZMI0J+tvJdCDF+6MVY/aNqk/cPzl48IkyTXx/at/llb/p7Jk18YQ9crpYe9R0Z7moO0hJXcAKzjC1rqzMlBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765118432; c=relaxed/simple;
	bh=c8GezEngyDqAoFIdl1ksK+nzls9d0Ti0mEv0pZ0KPYw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RqHZkGWo9Mofx7OzUBaP6DZ5Oh/gtLpd+aTEQBISBYuzG0/epk8sJdddWXySW5h2ZROM71ckTIE3liPvxoY/oy0uD3A3ZRJVWkvueArS0cnD+jq9SvmV4YSHeqz7IwqWVDr+A1IK2nndgOjbyMe0RH/6YeAjOxWrQFd/wB7Wq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id ABBC192009C; Sun,  7 Dec 2025 15:40:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9CA4192009B;
	Sun,  7 Dec 2025 14:40:28 +0000 (GMT)
Date: Sun, 7 Dec 2025 14:40:28 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, riccardo.mottola@libero.it
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
In-Reply-To: <339B5A39-BC20-489A-9969-BF01B4E6AD63@exactco.de>
Message-ID: <alpine.DEB.2.21.2512071431560.49654@angie.orcam.me.uk>
References: <20251202.174007.745614442598214100.rene@exactco.de> <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de> <20251202.180451.409161725628042305.rene@exactco.de> <alpine.DEB.2.21.2512050237490.49654@angie.orcam.me.uk>
 <f419b6d8a36e43c90e1875da5fb67a7f2a18a219.camel@physik.fu-berlin.de> <339B5A39-BC20-489A-9969-BF01B4E6AD63@exactco.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 6 Dec 2025, René Rebe wrote:

> I love my quirky Sgi MIPS64 Octane and O2 also very much, but fact is: those
> systems had not only special proprietary high speed xbow interconnects, but also
> very glitchy PCI bridges that already barely work to start with.
> 
> Also that just one modern Loongson system might work, does not mean all the
> history of MIPS(64) system will be okay.

 Obviously, but then the individual problematic systems/chips need to be 
blacklisted rather than the whole MIPS port.

> That being said I did not yet found an issue on old x86 systems with the 2015
> Year check removed to d3hot those more than mainstream currently does.

 Well, x86 is special in that the kernel has to interact with the firmware 
(BIOS/ACPI/whatever) that has traditionally had its own quirks even where 
the hardware itself is sane.

  Maciej

