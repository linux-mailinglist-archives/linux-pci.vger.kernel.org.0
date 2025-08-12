Return-Path: <linux-pci+bounces-33837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF9B21E47
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12797A2D1B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 06:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE972D4811;
	Tue, 12 Aug 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YCwjP4zv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3YZcet6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02FC2C21E3;
	Tue, 12 Aug 2025 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980050; cv=none; b=ntFX0br/1uqFFi1tpT7se5k36l8Tk3LTkoYoWF6AdiJJQ2xJMmgmJ+hH3ZrNOHd4vPfl9Wb2ZR0nih8Bawtkw/1QUhBnK5/YPQVR2cCV6O3u/4Asl3BNCn8N/tfysH44M/K3M4N9tMD6tQ2OFWloZcjYU21FkT2J+HV8sGkUkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980050; c=relaxed/simple;
	bh=2zXtN27wOEWwnqIzbf/6hOa52R9QIws6lpKyKqUO4E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYmkGoNw4ozPMUC/XupN5eiqZrDs2VNmQR3YAleTtb+BhjRe/64OekKbQ0NeIykRkV5WURwG5ZsTaMucP2N92QLu1U8kdEhpWv7KBRHcKfxpMMXJNh4inKWw30O1dmubEHKotrn7GwuufnB7bhOZ7QhGNEcMWZymPMhy1grIYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YCwjP4zv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3YZcet6u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Aug 2025 08:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754980047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPmlgwTQjbKtST3ioeXe30KnbkE79UAnrUUUOawhgMU=;
	b=YCwjP4zvmXq9xhFEzhXui7n8JEvZATOJKC61r7qq17HX3j8hgjTzA0kFH2upZpKj3kFswP
	4TVxEwLraNI4FAwa7WkfOwYeFdXN57JMQBXBeG1t0kJ5BymFuHIsjhlnZp0krAzCT48EI6
	N5WoUwotdGpVxNLhj87zIjELhuYlZ3k12rrw3ERODZKCxmx/UTrZt+3WzEFfnniwrL4HyO
	bWD5J9aFwdZ6ZEO/evYeLnpd6MfT0n8gU9XON+J/X51vj9fFx5VyLSXv4NQlrewW7YgpuA
	FVRd0pHJVvH0kkQWXB4Cq7ZdDIQf8U+oeBIyNkBMun1ss+iKx89V4tk9eefEIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754980047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPmlgwTQjbKtST3ioeXe30KnbkE79UAnrUUUOawhgMU=;
	b=3YZcet6uXvR2q2rBg7ocEhSRRGd8fg/sQN2tGHvsMwsT0zdQXQtz/b6kkAZ6AOMzVf873F
	CQaknr+wMpdsi7Cw==
From: Nam Cao <namcao@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <20250812062715.X9TWWWh-@linutronix.de>
References: <20250811053935.4049211-1-namcao@linutronix.de>
 <20250811224659.GA168102@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811224659.GA168102@bhelgaas>

On Mon, Aug 11, 2025 at 05:46:59PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 11, 2025 at 07:39:35AM +0200, Nam Cao wrote:
> > Commit d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> > added a WARN_ON sanity check that child devices support MSI-X, because VMD
> > document says [1]:
> > 
> >     "Intel VMD only supports MSIx Interrupts from child devices and
> >     therefore the BIOS must enable PCIe Hot Plug and MSIx interrups [sic]."
> 
> Can VMD tell the difference between an incoming MSI MWr transaction
> and an MSI-X MWr?
> 
> I wonder if "MSIx" was meant to mean "VMD only supports MSI or MSI-X
> interrupts, not INTx interrupts, from child devices"?

I don't know, sorry. I am hoping that the VMD maintainers can help us here.

But I don't expect to get an answer soon, and this is affecting users, so I
prefer to merge it regardless.

And to be honest, depending on the answer, this patch may be the wrong fix.
But in this worst case, we would just bring the driver back to how it had
always behaved, and no one complained before. Therefore it should be safe to
do.

Nam

