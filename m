Return-Path: <linux-pci+bounces-9214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64930915FF9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 09:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB27B24DC2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3A146A99;
	Tue, 25 Jun 2024 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NgMgMb2J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="et5PWOAo"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008B1465A8;
	Tue, 25 Jun 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300327; cv=none; b=eOMeQknSzP/1aRs8tRvgYa1MRhwYjHwrapUhrP7qWYllGj9X35SBdqXA46dGGgQxi7V9K7wjzoqh2SLSJkEOHZ/IOvlLrX5EBVAVNEzy6fLSFWrVzZmqcpUs46GMMhHvR36/P21YmxFso7DM+/U82mxRJkaVJTUi2+oYFByXRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300327; c=relaxed/simple;
	bh=ezb77GZXdVAFrfyo9/1iyHlxE3AHchnIk/xpupP7DRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IHY6hAH8/mhFMmGeaCkeZkqUcsNuMK8pL5d9qCmEvfucdxQrkeEwlL2r8NqIOoYJ9CsJKqBdWRJcFiF14rhd2ULIQmThonw3rjx14lBcaFC40roGJbZkm2knrmqBMGIcgYVsqSZH6GCpg3JHZSA4KPz8r83HUaX2TCecPnVB770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NgMgMb2J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=et5PWOAo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719300324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbM9+X7lQHMtCd9+f5UahNU/0eZ7QOoLWzJWZWNqVH8=;
	b=NgMgMb2JTCsUYPLOwbJdeNIErCWElIL3im8v3aHkfMZrzDiafPyOHz2ZQihqzTZ59feUZI
	Ph8GKIjDgaGD3fXranxhg0jog/omT47YnESkhPBfZYeXbIutaovJ4h46ymqAOe0w/vObtQ
	VAmIXZt60RmMYm596wr4gT0oa1Q5nXqkVZVUIagqA0D4lGFhgPTPJ8udrrTUjHf+S93zJK
	+wZXkqyAEgtttXeUcPfEiN9srR0V1lxTI/minAq/ggs8/RrCLiw1CV//KQH6z6iRPnsBjt
	Wq6RLW6LZQmqqcZ+Sq9yBw1m4BTlyXefGqZ59SkNO9ZPEoqmyjOKtwBBWmpRsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719300324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbM9+X7lQHMtCd9+f5UahNU/0eZ7QOoLWzJWZWNqVH8=;
	b=et5PWOAoB6bFhTt4xdB92o5jth/5tAlsTrRR8UenmF/PZcTUGdlGchhMt2EvKAp/MhhBQx
	vz9Mlm/0DoVUKsCg==
To: Sunil V L <sunilvl@ventanamicro.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>, Samuel Holland
 <samuel.holland@sifive.com>, Robert Moore <robert.moore@intel.com>, Conor
 Dooley <conor.dooley@microchip.com>, Andrew Jones
 <ajones@ventanamicro.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Marc Zyngier <maz@kernel.org>, Atish
 Kumar Patra <atishp@rivosinc.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>
Subject: Re: [PATCH v6 00/17] RISC-V: ACPI: Add external interrupt
 controller support
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
Date: Tue, 25 Jun 2024 09:25:23 +0200
Message-ID: <875xtx7acc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 01 2024 at 20:33, Sunil V L wrote:
> This series adds support for the below ECR approved by ASWG.
> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
>
> The series primarily enables irqchip drivers for RISC-V ACPI based
> platforms.
>
> The series can be broadly categorized like below. 
>
> 1) PCI ACPI related functions are migrated from arm64 to common file so
> that we don't need to duplicate them for RISC-V.
>
> 2) Added support for re-ordering the probe of interrupt controllers when
> IRQCHIP_ACPI_DECLARE is used.
>
> 3) To ensure probe order between interrupt controllers and devices,
> implicit dependency is created similar to when _DEP is present.
>
> 4) ACPI support added in RISC-V interrupt controller drivers.

So this needs eyeballs from the ACPI people and a strategy how to merge
it.

Thanks,

        tglx

