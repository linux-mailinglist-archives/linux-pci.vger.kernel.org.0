Return-Path: <linux-pci+bounces-44310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CEED069F7
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 01:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDF3302E157
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 00:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAAE189F43;
	Fri,  9 Jan 2026 00:38:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46EA1891A9;
	Fri,  9 Jan 2026 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767919096; cv=none; b=bdfNF8VJi0mB54Fzd9AjyW5JEX2znIoTDBs18KzFs4UdU0SrD5he8/p0/x1nB/NK4ACwmhA5PbSoFxQUnXm/bF5sf4Uzqq6fIoP+d0lE8krvapVrRJV77i5w+SnHkGD7noF5/R3OuZf0SEcpu55j8vVeu9XxvGlKrodPt93bOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767919096; c=relaxed/simple;
	bh=nv59iUhkI6eyf0Ps0d7O4TT4mAhgGT7r7J9eL/naf+k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QFUC3/rKVx0jkE1wMn3sJuqaDQkvZb0F2XETHPEDVwpbFi/o7oAzdRBWhwwqB9ovRP91EbmZsCQsjXPyCpN0l9kcxmkf4ISxRIcgVjK4QfCDLzhrBlYLWowTz/RYGhTV3RmNAkb3hy4Tfd0az8233JnHcQV8mPrybQrAaS/Pzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EAA8592009C; Fri,  9 Jan 2026 01:38:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E3C9F92009B;
	Fri,  9 Jan 2026 00:38:05 +0000 (GMT)
Date: Fri, 9 Jan 2026 00:38:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: David Laight <david.laight.linux@gmail.com>
cc: Ziming Du <duziming2@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    liuyongqiang13@huawei.com
Subject: Re: [PATCH v3 3/3] PCI/sysfs: Prohibit unaligned access to I/O port
 on non-x86
In-Reply-To: <20260108085611.0f07816d@pumpkin>
Message-ID: <alpine.DEB.2.21.2601082358370.30566@angie.orcam.me.uk>
References: <20260108015944.3520719-1-duziming2@huawei.com> <20260108015944.3520719-4-duziming2@huawei.com> <20260108085611.0f07816d@pumpkin>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 8 Jan 2026, David Laight wrote:

> I'm not sure it makes any real sense for x86 either.

 FWIW I agree.

> IIRC io space is just like memory space, so a 16bit io access looks the
> same as two 8bit accesses to an 8bit device (some put the 'data fifo' on
> addresses 0 and 1 so the code could use 16bit io accesses to speed things up).

 Huh?  A 16-bit port I/O access will have the byte enables set accordingly 
on PCI and the target device's data lines are driven accordingly in the 
data cycle.  Just as with MMIO; it's just a different bus command (or TLP 
type for PCIe).

 There's no data FIFO or anything as exotic in normal hardware to drive or 
collect data for port I/O accesses wider than 8 bits.  Some peripheral 
hardware may ignore byte enables though to simplify logic and e.g. assume 
that all port I/O or MMIO accesses are of a certain width, such as 16-bit 
or 32-bit.

> The same will have applied to misaligned accesses.

 Misaligned accesses may or may not have to be split depending on whether 
they span the data bus width boundary or not.  E.g. a 16-bit access to 
port I/O location 1 won't be split on 32-bit PCI as it fits on the bus: 
byte enables #1 and #2 will be driven active and byte enables #0 and #3 
will be left inactive.  Conversely such an access to location 3 needs to 
be split into two cycles, with byte enables #3 and #0 only driven active 
respectively in the first and the second cycle.

 The x86 BIU will do the split automatically for port I/O instructions as 
will some other CPU architectures that use memory access instructions to 
reach the PCI port I/O decoding window in their memory address space (this 
is a simplified view, as the split may have to be done in the chipset when 
passing the boundary between data buses of a different width each).

 With other architectures such as MIPS designated instructions need to be 
used to drive the byte enables by hand for individual partial accesses in 
a split access, and the remaining architectures cannot drive some of the 
byte-enable patterns needed for such split accesses at all (and do masking 
in software instead for unaligned accesses to regular memory).

> But, in reality, all device registers are aligned.

 True, sometimes beyond their width too.

  Maciej

