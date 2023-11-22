Return-Path: <linux-pci+bounces-127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41DE7F45E0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C6280C47
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F34D593;
	Wed, 22 Nov 2023 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsHuEKgs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A25BC13F;
	Wed, 22 Nov 2023 12:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B255C433C7;
	Wed, 22 Nov 2023 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700655780;
	bh=6S2477i1eBrWi6MdXtHpYcNgUIbufoSnif77dzfTWyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PsHuEKgss+IP6NdSdts7W9nwVVimGzqCAt0Amtf3T/GnYWgSfi+oMymO7ViH5LR8Z
	 yQhqhFtmbM6R7YxLbcL+IQ+zQLh7ciJmRk4kVSDcPjN+Q/3vb+VCQNE66hMM+ZU1BY
	 TFdkG4Ad5Kes9f+Cvoh0MDv5jm8y/LKgsDAQVpwnOzkrWQnCHn/7OYKgH6eQEQ+9OR
	 fwsxmvroxShojZhQs7VhPRXgB+/jNUD5wsaIe8eO3sA6FYyb2v+wJ/UH5x+JkwC9qi
	 HQY+8yiVVttoX9CP8C4C4UfGYBu50shQqtxZivV3NM4XvxneF9qRWRBm3DEzFA9ds4
	 7IWWFHa3te4EQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Anup Patel
 <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, Andrew
 Jones <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>,
 Haibo Xu <haibo1.xu@intel.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v2 06/21] RISC-V: Kconfig: Select deferred GSI probe
 for ACPI systems
In-Reply-To: <ZUtailOcozI9xIou@sunil-laptop>
References: <ZTuzJ1nsicZYp+uh@sunil-laptop>
 <20231106221606.GA264641@bhelgaas> <ZUtailOcozI9xIou@sunil-laptop>
Date: Wed, 22 Nov 2023 13:22:56 +0100
Message-ID: <87a5r6rn8f.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sunil!

I'm trying to decipher this thread, so apologies in advance for the
stupid questions! :-P

Sunil V L <sunilvl@ventanamicro.com> writes:

> Hi Bjorn,
>
> On Mon, Nov 06, 2023 at 04:16:06PM -0600, Bjorn Helgaas wrote:
>> On Fri, Oct 27, 2023 at 06:25:03PM +0530, Sunil V L wrote:
>> > On Thu, Oct 26, 2023 at 12:04:08PM -0500, Bjorn Helgaas wrote:
>> > > On Thu, Oct 26, 2023 at 01:53:29AM +0530, Sunil V L wrote:
>> > > > On RISC-V platforms, apart from root interrupt controllers (which
>> > > > provide local interrupts and IPI), other interrupt controllers in =
the
>> > > > hierarchy are probed late. Enable this select this CONFIG option f=
or
>> > > > RISC-V platforms so that device drivers which connect to deferred
>> > > > interrupt controllers can take appropriate action.
>> > >=20
>> > > Quite a bit of this series seems related to the question of interrupt
>> > > controllers being probed "late".
>> > >=20
>> > > I don't see anything specific about *how* late this might be, but fr=
om
>> > > the use of -EPROBE_DEFER in individual drivers (8250_pnp explicitly,
>> > > and acpi_register_gsi() and pnp_irq() and acpi_pci_irq_enable(), whi=
ch
>> > > are called from driver .probe() paths) it seems like interrupt
>> > > controllers might be detected even after devices that use them.
>> > >=20
>> > > That seems like a fairly invasive change to the driver probe flow.
>> > > If we really need to do that, I think it might merit a little more
>> > > background as justification since we haven't had to do it for any
>> > > other arch yet.
>> >=20
>> > In RISC-V, the APLIC can be a converter from wired (GSI) to MSI interr=
upts.
>> > Hence, especially in this mode, it has to be a platform device to use
>> > device MSI domain. Also, according to Marc Zyngier there is no reason =
to
>> > probe interrupt controllers early apart from root controller. So, the
>> > device drivers which use wired interrupts need to be probed after APLI=
C.
>> >=20
>> > The PNP devices and PCI INTx GSI links use either
>> > acpi_dev_resource_interrupt() (PNP) or acpi_register_gsi() directly
>> > (PCI). The approach taken here is to follow the example of
>> > acpi_irq_get() which is enhanced to return EPROBE_DEFER and several
>> > platform device drivers which use platform_get_irq() seem to be handli=
ng
>> > this already.
>>=20
>> This series (patch 04/21 "ACPI: irq: Add support for deferred probe in
>> acpi_register_gsi()" [1]) makes acpi_register_gsi() return
>> -EPROBE_DEFER, which percolates up through pci_enable_device().
>>=20
>> Maybe that's ok, but this affects *all* PCI drivers, and it's a new
>> case that did not occur before.  Many drivers emit warning or error
>> messages for any pci_enable_device() failure, which you probably don't
>> want in this case, since -EPROBE_DEFER is not really a "failure";
>> IIUC, it just means "probe again later."
>>
> Yeah, I think all the drivers which need to be supported on RISC-V
> ACPI based systems will have to support deferred probe with this scheme.
>
>> > Using ResourceSource dependency (mbigen uses) in the namespace as part=
 of
>> > Extended Interrupt Descriptor will not ensure the order since PNP/INTx
>> > GSI devices don't work with that.
>>=20
>> Are these PNP/INTx GSI devices described in ACPI?  In the namespace?
>> Or in a static table?
>>=20
> Yes, these are standard devices in the namespace. For ex: PNP0501(16550)
> or PNP0C0F (PCI interrupt link devices) are in the namespace.
>
>> > Is there any other better way to create dependency between IO devices
>> > and the interrupt controllers when interrupt controller itself is a
>> > platform device? While using core_initcall() for interrupt controllers
>> > seem to work which forces the interrupt controller to be probed first,
>> > Marc is not in favor of that approach since it is fragile.
>>=20
>> I guess PCI interrupts from the PCI host bridges (PNP0A03 devices)
>> feed into the APLIC?  And APLIC is described via MADT?  Based on this
>> series, it looks like this:
>>=20
>>     acpi_init
>>   +   acpi_riscv_init
>>   +     riscv_acpi_aplic_platform_init
>>   +       acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, =
0)
>>       acpi_scan_init
>>         acpi_pci_root_init
>>         acpi_pci_link_init
>> 	acpi_bus_scan             # add PCI host bridges, etc
>>=20
>> If that's the sequence, it looks like aplic_parse_madt() should be
>> called before the PCI host bridges are added.
>>=20
>> Or maybe this isn't how the APLICs are enumerated?
>>=20
> That's partly correct. APLIC platform devices are created prior to PCI
> host bridges added. But the actual APLIC driver which creates the
> irqdomain will be probed as a regular platform driver for the APLIC
> device. The platform driver probe will happen using DD framework and
> devices don't have any dependency on APLIC which can cause device probe
> prior to APLIC driver probe.
>
> DT supports fw_devlink framework which makes it easier for IRQ devices
> to use regular platform drivers and produces-consumers are probed in the
> order without requiring drivers to do deferred probe. But I don't see
> that supported for ACPI framework.  Also, the way PNP devices get added
> there is an assumption that interrupt controller is already setup fully.

AFAIU, the -EPROBE_DEFER changes are needed for GSIs (and the way the
IMSIC/APLIC irqchip series is structured), right?

There's a couple of separate pieces in play here:
1. IMSIC-IPI (MADT init)
2. IMSIC-MSI (MADT init, imsic_platform_acpi_probe() patch 14)
3. APLIC-wired (platform)
4. APLIC-MSI-bridge (platform)

APLIC-MSI-bridge is pretty much a RISC-V mbigen.

Some devices do not have ResourceSource parsing implemented yet. The PNP
devices that cannot use ResourceSource (you mention PNP0501 (16550) and
PNP0C0F (PCI interrupt link devices), do we really need to care about
them for the RISC-V platforms using ACPI? If that would change, the
kernel drivers can be adjusted (d44fa3d46079 ("ACPI: Add support for
ResourceSource/IRQ domain mapping"))?

I guess my question is we need to care about GSIs w/o explicit
ResourceSource, so that APLIC-MSI-bridge can be used.

GED works nicely with ResourceSource, and covers a lot of the GSI
use-cases, no?

And if we do care, then *both* 3 and 4 would need at MADT scan
point/init, and not be a platform device (late init).

From my, probably naive perspective, it's a bit weird *not* to create
the irq domains at MADT scan time.

> With this new use case in RISC-V, here are the alternatives I am aware of.
>
> 1) Use core_initcall() in the APLIC drivers which makes APLIC driver to
> be probed prior to PNP or PCI INTx devices. But this was ruled out in
> the context of DT from Marc.
>
> 2) Like the approach tried in this series, add support for deferred
> probe in drivers. This will be invasive change requiring many drivers to
> change like you pointed.

Again is this only for GSIs? Patch 14 moves the IMSIC-MSI init to MADT
for PCIe devices (which is different from DT), so it's not for PCIe
devices. I wonder if it's a lot of churn for something that will not be
used for RISC-V ACPI systems...

A quick look at what Arm's GICv3 does, all irq domains are created at
MADT init.


Bj=C3=B6rn (no, not PCI-Bjorn ;-))

