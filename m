Return-Path: <linux-pci+bounces-268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A5D7FE9AB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 08:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F5E1C20B1E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4690E1E51F;
	Thu, 30 Nov 2023 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P9Oeq6jo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC241B3
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 23:26:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-285741e9a9aso677547a91.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 23:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701329181; x=1701933981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vaR9Py/1wlD3zkHO4kH1K6KgzRNK2LkfyWPObJ0DwQ=;
        b=P9Oeq6joT9emA9oNnU89wkt56f/6q+TWP3vv961Xz/j4Nk8BHfOYKhdfyyojrV4QIx
         ZZJ8yL3YeYSJKMPzwfZuanExbb5nphk+lpaOmuu/F4fF7pr7IISvqhhuEAAgpsLvNdK8
         wQRrBSMVDtPqglMKLGZaOeKTF5Ja67s8h9dI+GAqJ0+G4Ez//+AowBQHzZqx//XVXk+w
         EyWB507znPQ8FiK42+zC99YX3+ODASI1RON4vSVYo0jT36p9jBNQviCbD4eF6b/at2CV
         hH9cOdWi7h2f4v+eXG5V/vbGdmYHcqyV9y4OObw9PGiwzDPke31u7fw8Y0d2wCQQEcDM
         SWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701329181; x=1701933981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vaR9Py/1wlD3zkHO4kH1K6KgzRNK2LkfyWPObJ0DwQ=;
        b=jh4NCATCXwPcwIuu6VRDSBrJk3+NRECg/K7x6PdOovVcGtyy2yE4gqEvag6xtlbDhn
         aAmLtXnAPA/eObnhmiNNBQz7IZx/O0eBThOEtohfrslDiLNhX6d48ZaVqu4qQQ/+c89f
         d8anVkghUUywQdPuTH8PD3mvBaAkajMRo35NazP/WBCWxhiyxFKBj1JjspdsmkZc0zPW
         f+RZRq7HIBUpsHLNNSTOSj8QF24pSwZjwC+f8YmdDTGSO+dGxtXvM80+Jn8Z/3O2SGDf
         05yrOkBhJm1KGcNzGoSkqkLy7SWkPx0l5mcH9bnuXTaY2nT4ZYQvBAAg3FyCdKGlL5Rj
         Mytw==
X-Gm-Message-State: AOJu0YyiqeHNGormINAR83q7TWKt7HGkkUdjKlN5sZ8xEH6iMdGINdJz
	203lxMPfLOLo/qA90eUgITKroQ==
X-Google-Smtp-Source: AGHT+IH2on3YHau4m4WDZtSzS0WzaeUBhPmKYsoqjQK6MFS9wCuSki2QkCdwcnsk3EBBXK/13hpGLA==
X-Received: by 2002:a17:90b:1811:b0:285:b69c:a725 with SMTP id lw17-20020a17090b181100b00285b69ca725mr15602862pjb.12.1701329181182;
        Wed, 29 Nov 2023 23:26:21 -0800 (PST)
Received: from sunil-laptop ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id ip1-20020a17090b314100b00285d330ae8bsm2503694pjb.57.2023.11.29.23.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:26:20 -0800 (PST)
Date: Thu, 30 Nov 2023 12:56:09 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v2 06/21] RISC-V: Kconfig: Select deferred GSI probe
 for ACPI systems
Message-ID: <ZWg5ETNkcXuceDFY@sunil-laptop>
References: <ZTuzJ1nsicZYp+uh@sunil-laptop>
 <20231106221606.GA264641@bhelgaas>
 <ZUtailOcozI9xIou@sunil-laptop>
 <87a5r6rn8f.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5r6rn8f.fsf@all.your.base.are.belong.to.us>
X-Spam-Level: *

Hi Björn!,

Apologies for the delay in response. Held up with something else.

On Wed, Nov 22, 2023 at 01:22:56PM +0100, Björn Töpel wrote:
> Hi Sunil!
> 
> I'm trying to decipher this thread, so apologies in advance for the
> stupid questions! :-P
>
Appreciate your help to review the patch and suggesting solutions.
Thank you very much!.

> Sunil V L <sunilvl@ventanamicro.com> writes:
> 
> > Hi Bjorn,
> >
> > On Mon, Nov 06, 2023 at 04:16:06PM -0600, Bjorn Helgaas wrote:
> >> On Fri, Oct 27, 2023 at 06:25:03PM +0530, Sunil V L wrote:
> >> > On Thu, Oct 26, 2023 at 12:04:08PM -0500, Bjorn Helgaas wrote:
> >> > > On Thu, Oct 26, 2023 at 01:53:29AM +0530, Sunil V L wrote:
> >> > > > On RISC-V platforms, apart from root interrupt controllers (which
> >> > > > provide local interrupts and IPI), other interrupt controllers in the
> >> > > > hierarchy are probed late. Enable this select this CONFIG option for
> >> > > > RISC-V platforms so that device drivers which connect to deferred
> >> > > > interrupt controllers can take appropriate action.
> >> > > 
> >> > > Quite a bit of this series seems related to the question of interrupt
> >> > > controllers being probed "late".
> >> > > 
> >> > > I don't see anything specific about *how* late this might be, but from
> >> > > the use of -EPROBE_DEFER in individual drivers (8250_pnp explicitly,
> >> > > and acpi_register_gsi() and pnp_irq() and acpi_pci_irq_enable(), which
> >> > > are called from driver .probe() paths) it seems like interrupt
> >> > > controllers might be detected even after devices that use them.
> >> > > 
> >> > > That seems like a fairly invasive change to the driver probe flow.
> >> > > If we really need to do that, I think it might merit a little more
> >> > > background as justification since we haven't had to do it for any
> >> > > other arch yet.
> >> > 
> >> > In RISC-V, the APLIC can be a converter from wired (GSI) to MSI interrupts.
> >> > Hence, especially in this mode, it has to be a platform device to use
> >> > device MSI domain. Also, according to Marc Zyngier there is no reason to
> >> > probe interrupt controllers early apart from root controller. So, the
> >> > device drivers which use wired interrupts need to be probed after APLIC.
> >> > 
> >> > The PNP devices and PCI INTx GSI links use either
> >> > acpi_dev_resource_interrupt() (PNP) or acpi_register_gsi() directly
> >> > (PCI). The approach taken here is to follow the example of
> >> > acpi_irq_get() which is enhanced to return EPROBE_DEFER and several
> >> > platform device drivers which use platform_get_irq() seem to be handling
> >> > this already.
> >> 
> >> This series (patch 04/21 "ACPI: irq: Add support for deferred probe in
> >> acpi_register_gsi()" [1]) makes acpi_register_gsi() return
> >> -EPROBE_DEFER, which percolates up through pci_enable_device().
> >> 
> >> Maybe that's ok, but this affects *all* PCI drivers, and it's a new
> >> case that did not occur before.  Many drivers emit warning or error
> >> messages for any pci_enable_device() failure, which you probably don't
> >> want in this case, since -EPROBE_DEFER is not really a "failure";
> >> IIUC, it just means "probe again later."
> >>
> > Yeah, I think all the drivers which need to be supported on RISC-V
> > ACPI based systems will have to support deferred probe with this scheme.
> >
> >> > Using ResourceSource dependency (mbigen uses) in the namespace as part of
> >> > Extended Interrupt Descriptor will not ensure the order since PNP/INTx
> >> > GSI devices don't work with that.
> >> 
> >> Are these PNP/INTx GSI devices described in ACPI?  In the namespace?
> >> Or in a static table?
> >> 
> > Yes, these are standard devices in the namespace. For ex: PNP0501(16550)
> > or PNP0C0F (PCI interrupt link devices) are in the namespace.
> >
> >> > Is there any other better way to create dependency between IO devices
> >> > and the interrupt controllers when interrupt controller itself is a
> >> > platform device? While using core_initcall() for interrupt controllers
> >> > seem to work which forces the interrupt controller to be probed first,
> >> > Marc is not in favor of that approach since it is fragile.
> >> 
> >> I guess PCI interrupts from the PCI host bridges (PNP0A03 devices)
> >> feed into the APLIC?  And APLIC is described via MADT?  Based on this
> >> series, it looks like this:
> >> 
> >>     acpi_init
> >>   +   acpi_riscv_init
> >>   +     riscv_acpi_aplic_platform_init
> >>   +       acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0)
> >>       acpi_scan_init
> >>         acpi_pci_root_init
> >>         acpi_pci_link_init
> >> 	acpi_bus_scan             # add PCI host bridges, etc
> >> 
> >> If that's the sequence, it looks like aplic_parse_madt() should be
> >> called before the PCI host bridges are added.
> >> 
> >> Or maybe this isn't how the APLICs are enumerated?
> >> 
> > That's partly correct. APLIC platform devices are created prior to PCI
> > host bridges added. But the actual APLIC driver which creates the
> > irqdomain will be probed as a regular platform driver for the APLIC
> > device. The platform driver probe will happen using DD framework and
> > devices don't have any dependency on APLIC which can cause device probe
> > prior to APLIC driver probe.
> >
> > DT supports fw_devlink framework which makes it easier for IRQ devices
> > to use regular platform drivers and produces-consumers are probed in the
> > order without requiring drivers to do deferred probe. But I don't see
> > that supported for ACPI framework.  Also, the way PNP devices get added
> > there is an assumption that interrupt controller is already setup fully.
> 
> AFAIU, the -EPROBE_DEFER changes are needed for GSIs (and the way the
> IMSIC/APLIC irqchip series is structured), right?
> 
Yes, It is only for GSI's.

> There's a couple of separate pieces in play here:
> 1. IMSIC-IPI (MADT init)
> 2. IMSIC-MSI (MADT init, imsic_platform_acpi_probe() patch 14)
> 3. APLIC-wired (platform)
> 4. APLIC-MSI-bridge (platform)
> 
> APLIC-MSI-bridge is pretty much a RISC-V mbigen.
> 
> Some devices do not have ResourceSource parsing implemented yet. The PNP
> devices that cannot use ResourceSource (you mention PNP0501 (16550) and
> PNP0C0F (PCI interrupt link devices), do we really need to care about
> them for the RISC-V platforms using ACPI? If that would change, the
> kernel drivers can be adjusted (d44fa3d46079 ("ACPI: Add support for
> ResourceSource/IRQ domain mapping"))?
> 
> I guess my question is we need to care about GSIs w/o explicit
> ResourceSource, so that APLIC-MSI-bridge can be used.
> 
> GED works nicely with ResourceSource, and covers a lot of the GSI
> use-cases, no?
> 
> And if we do care, then *both* 3 and 4 would need at MADT scan
> point/init, and not be a platform device (late init).
> 
I am not sure it is a good idea not to support PCI link devices. Not
allowing them removes the flexibility in _PRT. Also, is there a standard
16550 UART apart from PNP0501? ACPI platform devices already support
deferred probe as per the series you mentioned. IMO, PNP also should
support it. So, I am not sure it is a good idea to prohibit all PnP
devices on RISC-V platforms. Other OS's might be able to handle them.

> From my, probably naive perspective, it's a bit weird *not* to create
> the irq domains at MADT scan time.
> 
> > With this new use case in RISC-V, here are the alternatives I am aware of.
> >
> > 1) Use core_initcall() in the APLIC drivers which makes APLIC driver to
> > be probed prior to PNP or PCI INTx devices. But this was ruled out in
> > the context of DT from Marc.
> >
> > 2) Like the approach tried in this series, add support for deferred
> > probe in drivers. This will be invasive change requiring many drivers to
> > change like you pointed.
> 
> Again is this only for GSIs? Patch 14 moves the IMSIC-MSI init to MADT
> for PCIe devices (which is different from DT), so it's not for PCIe
> devices. I wonder if it's a lot of churn for something that will not be
> used for RISC-V ACPI systems...
> 
> A quick look at what Arm's GICv3 does, all irq domains are created at
> MADT init.
> 
The issue is primarily with APLIC-MSI. Since it needs MSI device domain,
it has to be a platform device.

I am investigating fw-devlink like Marc suggested atleast for IRQ
dependencies. If that works, it would be the best solution.

Thanks,
Sunil

