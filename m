Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855B7E2FA9
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 23:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjKFWQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 17:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjKFWQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 17:16:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C04183;
        Mon,  6 Nov 2023 14:16:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654D4C433C7;
        Mon,  6 Nov 2023 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699308968;
        bh=WqMPMf39yh9ITC8OB+ZJDb9Ky2cXoNVF1zs0fDuZdN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s9wsq7xSaMr7iJ3kiO+j9shFPCu8qXLQJrWBsw5/DIGa63jW9h/MG2FWa4Q2525Fk
         OjpRYf8HorKnxNU3Hxd7c9qYr5lVgIQ2x2GKK4SW3NQG2m2DrhvB+H4HSpgNcBV0Xm
         UexMpN5ETc1fwqspUoTwns6vzMNGIZVNuuUpM3LRhO2Bm4e0H3XmyhB/R8RnmgY61O
         RMkozKDLwcq2NKMzwnpifndjlCiTKAbwke2cUF3PmrGJ1apjCeBMdRlf9vbK3njNaf
         nd2W1a1Kw3zJIXfyl08QIw/lVuVFqZH09q5OGyu7ra9oxT7+g50f5xlVeku7nKzyeu
         VvuUm+kw/bHlQ==
Date:   Mon, 6 Nov 2023 16:16:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 06/21] RISC-V: Kconfig: Select deferred GSI probe
 for ACPI systems
Message-ID: <20231106221606.GA264641@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTuzJ1nsicZYp+uh@sunil-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 27, 2023 at 06:25:03PM +0530, Sunil V L wrote:
> On Thu, Oct 26, 2023 at 12:04:08PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 26, 2023 at 01:53:29AM +0530, Sunil V L wrote:
> > > On RISC-V platforms, apart from root interrupt controllers (which
> > > provide local interrupts and IPI), other interrupt controllers in the
> > > hierarchy are probed late. Enable this select this CONFIG option for
> > > RISC-V platforms so that device drivers which connect to deferred
> > > interrupt controllers can take appropriate action.
> > 
> > Quite a bit of this series seems related to the question of interrupt
> > controllers being probed "late".
> > 
> > I don't see anything specific about *how* late this might be, but from
> > the use of -EPROBE_DEFER in individual drivers (8250_pnp explicitly,
> > and acpi_register_gsi() and pnp_irq() and acpi_pci_irq_enable(), which
> > are called from driver .probe() paths) it seems like interrupt
> > controllers might be detected even after devices that use them.
> > 
> > That seems like a fairly invasive change to the driver probe flow.
> > If we really need to do that, I think it might merit a little more
> > background as justification since we haven't had to do it for any
> > other arch yet.
> 
> In RISC-V, the APLIC can be a converter from wired (GSI) to MSI interrupts.
> Hence, especially in this mode, it has to be a platform device to use
> device MSI domain. Also, according to Marc Zyngier there is no reason to
> probe interrupt controllers early apart from root controller. So, the
> device drivers which use wired interrupts need to be probed after APLIC.
> 
> The PNP devices and PCI INTx GSI links use either
> acpi_dev_resource_interrupt() (PNP) or acpi_register_gsi() directly
> (PCI). The approach taken here is to follow the example of
> acpi_irq_get() which is enhanced to return EPROBE_DEFER and several
> platform device drivers which use platform_get_irq() seem to be handling
> this already.

This series (patch 04/21 "ACPI: irq: Add support for deferred probe in
acpi_register_gsi()" [1]) makes acpi_register_gsi() return
-EPROBE_DEFER, which percolates up through pci_enable_device().

Maybe that's ok, but this affects *all* PCI drivers, and it's a new
case that did not occur before.  Many drivers emit warning or error
messages for any pci_enable_device() failure, which you probably don't
want in this case, since -EPROBE_DEFER is not really a "failure";
IIUC, it just means "probe again later."

> Using ResourceSource dependency (mbigen uses) in the namespace as part of
> Extended Interrupt Descriptor will not ensure the order since PNP/INTx
> GSI devices don't work with that.

Are these PNP/INTx GSI devices described in ACPI?  In the namespace?
Or in a static table?

> Is there any other better way to create dependency between IO devices
> and the interrupt controllers when interrupt controller itself is a
> platform device? While using core_initcall() for interrupt controllers
> seem to work which forces the interrupt controller to be probed first,
> Marc is not in favor of that approach since it is fragile.

I guess PCI interrupts from the PCI host bridges (PNP0A03 devices)
feed into the APLIC?  And APLIC is described via MADT?  Based on this
series, it looks like this:

    acpi_init
  +   acpi_riscv_init
  +     riscv_acpi_aplic_platform_init
  +       acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0)
      acpi_scan_init
        acpi_pci_root_init
        acpi_pci_link_init
	acpi_bus_scan             # add PCI host bridges, etc

If that's the sequence, it looks like aplic_parse_madt() should be
called before the PCI host bridges are added.

Or maybe this isn't how the APLICs are enumerated?

Bjorn

[1] https://lore.kernel.org/r/20231025202344.581132-5-sunilvl@ventanamicro.com
