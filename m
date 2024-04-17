Return-Path: <linux-pci+bounces-6359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF338A87B0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A27282F3C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD2142625;
	Wed, 17 Apr 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jJYQFZ88"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE013EFEC
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367995; cv=none; b=HaGJMgyRqgl6EnW+bZ/qJup1JpLxqEJ/DkNeDQgCl4yjaWZP/rc0uMAAiH5PX42gsrOO7C3SFyY6wr+xUem82jJAYDHj8vd7roPG87t5IK1E8MkOYogCZ5cHL2s2chqGoGSPazsgcLlEidRaiZlFrwEzqLGDCjQScvALekUPSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367995; c=relaxed/simple;
	bh=LyasFuHZp08VqwNu42/PVIEbWPHzMUfT5uQ3KYTy324=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBAAB4UfbqtCH9bAX9vMKaLB7MJrpBYMX2+5d4c7o6Ncjtl97W6E94msxYWI1hxSSFkKkXKGZW/q2zaS8wyFy/fKq9U2uG67XxNLKPccM59Gq+LlVKpUTWc2J1GvJ2oP9j51W/HTPJ9CIgIja/KCScD9lVfM7Tr6qPpeNM7Yje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jJYQFZ88; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e455b630acso27411995ad.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713367993; x=1713972793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci0/H2jmcb2D55FJA4q2NJz7BMdC0uHP2xAuYH6nUsQ=;
        b=jJYQFZ88TdQWsGhcrTJ6Fi1nyzHDWxH/0SGxp3FlSXhYZAR5vk5eTmiDkV4XIS1Bam
         dYIPNcnEO1wceqW5OvoiE2wQ0suPz+QzGSqcYDepxk3JL5OoARtcQwtuaBcNT3OrEcDS
         u0JVQN/lEx5GImrma/eVBpH+fgqEu00f1rrCBijMl1YWmkFvarsCb7HnYPoyNBUX97RH
         cse1OBTZgLaPyW5nKHPMPlUvMrHX3WurE1k1GM/vXwyjUzERdgJIHUsLN+lHTpKPGrZs
         wZwquGJDFaX6XSq1WgMntLnIx5yVLx2x3HjwdKTsoiNdAl6NgB4hBBJhuFq1jBQ1AZ+6
         Grcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367993; x=1713972793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci0/H2jmcb2D55FJA4q2NJz7BMdC0uHP2xAuYH6nUsQ=;
        b=caJWyhqWs5rLMj/D4BvmNlU7ioqE0b3HfXscFsV5kKt9+oR+brsUdAhyUenp+PY01K
         yos5T9yVSMvoWDiOOVhVtOAA+nta3ZFL1ByBmMFetcJQoYgUIxphUL0h/fagt75EJ/mr
         Udd6Y3lw9uteNpl8mzoAYq4bFrBZBe+x6k0rQO8BPNwc89dcdZJ/xr+5xLkj2BgqB+29
         MFzt6EHOtzd5tUi3zs2NgLpnh03oWOGjaM525NmkOjEaG1lOCpaSXsfo4kY5XSmBqIX0
         dVclzuYmpxpLcsitOQwBV70KBc5I6ubsNTxoB3BUZaTARGpy75N7VxYD+cT11AIBzwnh
         DHCA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Qg8rshIFv4VYGZLaRnRX2XsKYA3lbpfJPtWw6gabsmScwK7kjYpIkxxogPGI8E5rSWEXRXaoz28yECTP0w+kE7JSPLHeobHp
X-Gm-Message-State: AOJu0YxAZvBrP6sfUxsHNqtMvlj/JguZg5I2I9ZzlsAb7mUbL3Ir7hxk
	uPsiGe3nKVYgkHGx8bn/gLbUSNi01wY7tAdvkF8BOXcZsS5ShAb4ny6GKu23oxY=
X-Google-Smtp-Source: AGHT+IHRZkCksWn0BOoecd+0pqZBwGMmL39xcXlgwLsVriOPR0oxo+w+nj8DW8s7r0j6AcJINnUn5A==
X-Received: by 2002:a17:902:e5c1:b0:1e4:35b9:f150 with SMTP id u1-20020a170902e5c100b001e435b9f150mr19787192plf.11.1713367993089;
        Wed, 17 Apr 2024 08:33:13 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001e83a718d87sm1102769plh.19.2024.04.17.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 08:33:12 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:03:02 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [RFC PATCH v4 03/20] PCI: Make pci_create_root_bus() declare its
 reliance on MSI domains
Message-ID: <Zh/rroBTGTq/Q/FN@sunil-laptop>
References: <Zh41pOmtAJ0EcbiN@sunil-laptop>
 <20240416204653.GA164172@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416204653.GA164172@bhelgaas>

On Tue, Apr 16, 2024 at 03:46:53PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 16, 2024 at 01:54:04PM +0530, Sunil V L wrote:
> > Hi Bjorn,
> > 
> > On Mon, Apr 15, 2024 at 06:15:23PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 15, 2024 at 10:30:56PM +0530, Sunil V L wrote:
> > > > Similar to commit 9ec37efb8783 ("PCI/MSI: Make
> > > > pci_host_common_probe() declare its reliance on MSI domains"), declare
> > > > this dependency for PCI probe in ACPI based flow.
> > > > 
> > > > This is required especially for RISC-V platforms where MSI controller
> > > > can be absent. However, setting this for all architectures seem to cause
> > > > issues on non RISC-V architectures [1]. Hence, enabled this only for
> > > > RISC-V.
> > > > 
> > > > [1] - https://lore.kernel.org/oe-lkp/202403041047.791cb18e-oliver.sang@intel.com
> > > > 
> > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > ---
> > > >  drivers/pci/probe.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 1325fbae2f28..e09915bee2ee 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -3048,6 +3048,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> > > >  	bridge->sysdata = sysdata;
> > > >  	bridge->busnr = bus;
> > > >  	bridge->ops = ops;
> > > > +#ifdef CONFIG_RISCV
> > > > +	bridge->msi_domain = true;
> > > > +#endif
> > > 
> > > Ugh.  I looked at [1], but that's not a very good justification for
> > > this #ifdef.  The fault mentioned in [1] would need to be fixed, but
> > > not this way.
> > 
> > Thank you again for the feedback!
> > 
> > I agree. This is due to my limitation with knowledge and resources to
> > debug the issue happening on non-UEFI x86 system with some particular
> > PCIe RC. Also, I was worried that we get into a rat hole of
> > assumptions/quirks with various architecture/PCIe RC combinations.
> 
> The problem is that adding #ifdefs like this leads to a rat hole
> itself.  We need to understand and fix the underlying issue instead.
> 
Agree. Ideally, from my reading of code, this change should have worked
across architectures.

> > For ex: I think the issue is, somehow MSI domain is not set at the time
> > of PCI host bridge registration in pci_register_host_bridge() causing
> > PCI_BUS_FLAGS_NO_MSI to be set. This causes pci_alloc_irq_vectors() to
> > fail. In portdrv.c, pcie_init_service_irqs() doesn't switch to INTx
> > handling if MSI can not be used. It switches only if pcie_pme_no_msi()
> > returns true. I couldn't find who actually sets up MSI domain bit late
> > on this platform so that it somehow worked when we didn't set this flag.
> > 
> > Unfortunately, I don't have system to root cause and fix this issue with
> > confidence. Also, I don't know if any other architectures have similar
> > issues which are not caught yet. Hence, I thought it may be better
> > just restrict the change to RISC-V.
> 
> It sounds like the above is a good start on analyzing the problem.
> 
> I don't quite understand your statement that pcie_init_service_irqs()
> doesn't fall back to INTx when MSI/MSI-X is not available.
> 
> I'm looking at this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/portdrv.c?id=v6.8#n177
> pcie_port_enable_irq_vec() attempts
> pci_alloc_irq_vectors(PCI_IRQ_MSIX | PCI_IRQ_MSI) and returns 0 if
> successful.  If it returns failure, it looks like
> pcie_init_service_irqs() *does* fall through to trying INTx
> (PCI_IRQ_LEGACY).
> 
You are right. Not sure what I was looking at :-(.

I think fundamentally there are two issues here.

1) MSI domain should have been setup properly when
pci_register_host_bridge() is called. I see that pci_arch_init() which
is supposed to get called early calls x86_create_pci_msi_domain().
pci_register_host_bridge() also calls pci_set_bus_msi_domain() to setup
the MSI domain which can walk up to host bridge to find. So, not sure
why PCI_BUS_FLAGS_NO_MSI is getting set. Is there an issue in walking up
the tree?

2) When it switches to legacy interrupt since MSI domain is not found,
for some reason there is an interrupt enabled without a handler. I was
suspecting PME since it was matching the IRQ#16 but it looks like PME
handlers are present. I am unable to find anything suspicious from the
log alone.

I really don't know how to proceed further. With my limited
understanding, I don't get any hint what is happening from the log.

Thanks,
Sunil

