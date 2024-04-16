Return-Path: <linux-pci+bounces-6331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C781D8A75E7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 22:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679A81F21A73
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5774317C;
	Tue, 16 Apr 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSFZDRtQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C717736;
	Tue, 16 Apr 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300416; cv=none; b=trE695kUU2Cy8CPHaPckvGwuLqoMiB+Sf5KOWh7Bw8EP1SfZdRHh2aFhdZfbi9vFeOnpx4XOILvPKzQTyEDnIdI46/s+m4x6KbHKfHLBaxrK7KegAOh+l3XwSTSJ+OnEHcjOyW4ffpBMFpE8CM7bDRsq6xxoZAnFaoGK57A6AwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300416; c=relaxed/simple;
	bh=PzXDXli+NQ8Ipg2Q4mQ6/IuDWq/2DB2/UEhvKB1bDGY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jaVGvYHqB2EYPP+aIgQnYNctO+XxGE0A16yQmMYGrRPm9y/dQhDiu4g2CIdMMQc6pedBY7uMptMBCmzDfrN1dWPHxgxCi9+zgqNJGv38UQteIC6RrMoP5cNEYzFVBTU0C1l6tQHKNitMcdSsqorqPd4ncc1V5falv0CEZAqlG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSFZDRtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE13DC113CE;
	Tue, 16 Apr 2024 20:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713300416;
	bh=PzXDXli+NQ8Ipg2Q4mQ6/IuDWq/2DB2/UEhvKB1bDGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fSFZDRtQHi98DyjaM7ap3zCMfLlmmte/nFr/5XWlWTnTM1LpqvArQ+D8bckThywai
	 jFMa7mUCIFjhJ1oWR5p8SMN3y+R7l15DYEeFuqYu+hsTyNPM/RteaxG1JUO1BhDKgs
	 CrPUvOqTDDMl72OsXWjnO+jy5TEy4Wl5iPb/XgpMaiEktYx2XSYFM+F0IGvNhd5T8M
	 s32geYw0IVrgqrG54iJT61/6UeLeWhZ+vFl+wVtT5nrNT7V1W6bJ/7UDTXHjnV9J5g
	 k4S265Dw8ltfIt6gbU1DfKSUOJlTSed0ol1qhvoiaUS9wMATn9An1Tw38qqQwxejlW
	 PDM8tZvF67x5A==
Date: Tue, 16 Apr 2024 15:46:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
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
Message-ID: <20240416204653.GA164172@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh41pOmtAJ0EcbiN@sunil-laptop>

On Tue, Apr 16, 2024 at 01:54:04PM +0530, Sunil V L wrote:
> Hi Bjorn,
> 
> On Mon, Apr 15, 2024 at 06:15:23PM -0500, Bjorn Helgaas wrote:
> > On Mon, Apr 15, 2024 at 10:30:56PM +0530, Sunil V L wrote:
> > > Similar to commit 9ec37efb8783 ("PCI/MSI: Make
> > > pci_host_common_probe() declare its reliance on MSI domains"), declare
> > > this dependency for PCI probe in ACPI based flow.
> > > 
> > > This is required especially for RISC-V platforms where MSI controller
> > > can be absent. However, setting this for all architectures seem to cause
> > > issues on non RISC-V architectures [1]. Hence, enabled this only for
> > > RISC-V.
> > > 
> > > [1] - https://lore.kernel.org/oe-lkp/202403041047.791cb18e-oliver.sang@intel.com
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  drivers/pci/probe.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 1325fbae2f28..e09915bee2ee 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -3048,6 +3048,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> > >  	bridge->sysdata = sysdata;
> > >  	bridge->busnr = bus;
> > >  	bridge->ops = ops;
> > > +#ifdef CONFIG_RISCV
> > > +	bridge->msi_domain = true;
> > > +#endif
> > 
> > Ugh.  I looked at [1], but that's not a very good justification for
> > this #ifdef.  The fault mentioned in [1] would need to be fixed, but
> > not this way.
> 
> Thank you again for the feedback!
> 
> I agree. This is due to my limitation with knowledge and resources to
> debug the issue happening on non-UEFI x86 system with some particular
> PCIe RC. Also, I was worried that we get into a rat hole of
> assumptions/quirks with various architecture/PCIe RC combinations.

The problem is that adding #ifdefs like this leads to a rat hole
itself.  We need to understand and fix the underlying issue instead.

> For ex: I think the issue is, somehow MSI domain is not set at the time
> of PCI host bridge registration in pci_register_host_bridge() causing
> PCI_BUS_FLAGS_NO_MSI to be set. This causes pci_alloc_irq_vectors() to
> fail. In portdrv.c, pcie_init_service_irqs() doesn't switch to INTx
> handling if MSI can not be used. It switches only if pcie_pme_no_msi()
> returns true. I couldn't find who actually sets up MSI domain bit late
> on this platform so that it somehow worked when we didn't set this flag.
> 
> Unfortunately, I don't have system to root cause and fix this issue with
> confidence. Also, I don't know if any other architectures have similar
> issues which are not caught yet. Hence, I thought it may be better
> just restrict the change to RISC-V.

It sounds like the above is a good start on analyzing the problem.

I don't quite understand your statement that pcie_init_service_irqs()
doesn't fall back to INTx when MSI/MSI-X is not available.

I'm looking at this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/portdrv.c?id=v6.8#n177
pcie_port_enable_irq_vec() attempts
pci_alloc_irq_vectors(PCI_IRQ_MSIX | PCI_IRQ_MSI) and returns 0 if
successful.  If it returns failure, it looks like
pcie_init_service_irqs() *does* fall through to trying INTx
(PCI_IRQ_LEGACY).

Bjorn

