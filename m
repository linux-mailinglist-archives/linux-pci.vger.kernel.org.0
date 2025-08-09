Return-Path: <linux-pci+bounces-33669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C7FB1F526
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 17:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB6417DAA2
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D25927602C;
	Sat,  9 Aug 2025 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UuuGHDDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fquZQ+de"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC331E5B60;
	Sat,  9 Aug 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752698; cv=none; b=BZluG0NDrL8IJAMIpr9AXinIN6sc3L0sGqxbN+qOG/6i1SedFNE8CK+x1zvRT64HoHUrjv7CYSJwSvc8p0wGkOoLQbJBG3O+XHP9Mx8TNIiTja3EfIb4FKECw/6jwOvg/1PdJrQbYgYALpjpju/bk1ptVwvRD1qnkOix5C7/YPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752698; c=relaxed/simple;
	bh=Hls6mqOYnTN35cBxHbtYbYlN5GFh2eK6R9TKiwNYzsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xg8SBg10gB3Ql45kAXtvWw2WKih1WG8Wo6T/NxB/xbXCjmAefkAmqmSyu5wmgjkd9SmKRauERsiGhrt6SLrSgZ0bkjloKtCyhqFlC4UdliwceKZjJH1+djvg3bjYFOrxP3dKGMYa8czkmklHVotzrxgAJZG+uUBo98f4nhnvf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UuuGHDDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fquZQ+de; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754752694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3w31G8jhpfzZgVyoqxrvuWFTWkEVhs2+el9KBVYIH8=;
	b=UuuGHDDUT4NcTCSJiR8ORMtb1KE1sy5vljRpc/gz+eIXk5VDNMj+m72ORjSQU3QA+FYCFG
	P8E1e6C4NOWl2ti7h+AYxjuSegh5IVKK3gQflZEI4WTLCzD5md4MRk8j6xz4GpAYyxHDjR
	lUZb9lCaS0SnIRT5SoxRORqZo7ITCxqckoL/EUETlOxO4eAYvWBW11GmYYvP5zH8cluxTy
	GVUQ4tcU5uTyez+Bpjp/hTnRAdy3bIiIIPk8UIZapop3zd50Fb9IWS2CPrN3EmAg4uNnZb
	aQnv+gwF17ICjdIO18FhC0pfhxtebzyUyXzneZWdac5JnzeHEaG8PgcvEQG43w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754752694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3w31G8jhpfzZgVyoqxrvuWFTWkEVhs2+el9KBVYIH8=;
	b=fquZQ+dePKLF6LA3d9Sm6XRH2vheCckefoM7QL8KmlvYByjBnmB2SccAVf5Wik4/KvpLT8
	3uUPFZkObmhZuwBQ==
To: Claudiu <claudiu.beznea@tuxon.dev>, marek.vasut+renesas@gmail.com,
 yoshihiro.shimoda.uh@renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, geert+renesas@glider.be, magnus.damm@gmail.com,
 tglx@linutronix.de
Cc: claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH] PCI: rcar-host: Use proper IRQ domain
In-Reply-To: <20250809144447.3939284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250809144447.3939284-1-claudiu.beznea.uj@bp.renesas.com>
Date: Sat, 09 Aug 2025 17:18:01 +0200
Message-ID: <87zfc8h6c6.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Claudiu <claudiu.beznea@tuxon.dev> writes:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Starting with commit dd26c1a23fd5 ("PCI: rcar-host: Switch to
> msi_create_parent_irq_domain()"), the MSI parent IRQ domain is NULL because
> the object of type struct irq_domain_info passed to:
>
> msi_create_parent_irq_domain() ->
>   irq_domain_instantiate()() ->
>     __irq_domain_instantiate()
>
> has no reference to the parent IRQ domain. Using msi->domain->parent as an
> argument for generic_handle_domain_irq() leads to a "Unable to handle
> kernel NULL pointer dereference at virtual address" error.

Right. Before that commit, msi->domain is the domain of the children PCI
devices, and msi->domain->parent is the domain of this device.

That commit changed msi->domain to be the domain of this
device. msi->domain->parent does not exist anymore.

drivers/pci/controller/pcie-xilinx.c has the same issue, let me send a
patch..

> This error was identified while switching the upcoming RZ/G3S PCIe host
> controller driver to msi_create_parent_irq_domain() (which was using a
> similar pattern to handle MSIs (see link section)), but it was not tested
> on hardware using the pcie-rcar-host controller driver due to lack of
> hardware.
>
> Link: https://lore.kernel.org/all/20250704161410.3931884-6-claudiu.beznea.uj@bp.renesas.com/
> Fixes: dd26c1a23fd5 ("PCI: rcar-host: Switch to msi_create_parent_irq_domain()")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>

