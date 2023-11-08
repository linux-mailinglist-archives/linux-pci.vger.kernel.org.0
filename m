Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205C27E52E6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 10:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjKHJxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 04:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 04:53:29 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2920C1B3
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 01:53:27 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so4554974a12.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2023 01:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1699437206; x=1700042006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=juZI1n0aMz+KCog5r3XPutHhgq5o1lm8dusNtuYCGmE=;
        b=l4+BwGgY2FKriVF/7CpzeLjOonahsX0UZ+iRlPfKa5SCMWP3uOmqqSvDaHQXXn97Nl
         CaRsML0xSTtH4bN1IDXI1yeVyQRl8O0vFVZx0oVVL7f4wTYykEtD75oLJem13+2Pj46r
         dE+B+f7R8+YlrjLV6Np5COFcnaVwXxSAZEEjDm/pwCulNSkBh4VogF8RucBzCftg1CqK
         sd1E8gnivGkhxH9jYMz+VZbhnnThdzq9ssdHSLDhH94pXHWioa32JWxiWlJhRx0ls7/t
         Lnxg3mput54c1cqplbmUFgOXLaaXlRyzH7+neGhNDUxqYiALdscsQQIHKXhvSIdktCn0
         094A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699437206; x=1700042006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juZI1n0aMz+KCog5r3XPutHhgq5o1lm8dusNtuYCGmE=;
        b=GyaNRLh1yvtpCyGeJsbeqOOgqbYmizLG5r1hFJ6PgGaM8A3xcU54nbWiMpDgFVr3gw
         6fqiqZMnBkNQqGKnNCw/E57rO+FsDEIb/LQ3kJtqgmv18lpKo+ScbGopjC1J9HvlOA10
         mIif7MdZZY9JRT2qz/gAP3dP/FxXPOWQ8hhZloaEW2I+gk+y/aFZFACRphpuxwghAcf2
         7mPU7FoTQK/vnR8chKBMopoauniR2om+08POuLqVntme01lBBXxpkVAEGRZOrGqcUIXT
         cDcbIAMi6j3dqpA/BDO8Bl71M7HKz8SiPjYMyJhzRz0WH9aASqVUaP9ClGgmWA1I8B1+
         aaiw==
X-Gm-Message-State: AOJu0YzMEkierPU/WxOpPLyVnc5DkeryG0GN+ydN7QVsIw3BwXHTnp+V
        haRfhGM26ynyUusVoJ2AVoIRpg==
X-Google-Smtp-Source: AGHT+IEEgxtG4vAOOXAzU0cQ43q+y/GuzULUrpgSTtLmSEOIhXbF+HzsEiLo0Th7PmwROQ6HsMZIlg==
X-Received: by 2002:a05:6a20:7495:b0:14e:43b0:5f99 with SMTP id p21-20020a056a20749500b0014e43b05f99mr1462760pzd.52.1699437206593;
        Wed, 08 Nov 2023 01:53:26 -0800 (PST)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001c728609574sm1346631plz.6.2023.11.08.01.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 01:53:25 -0800 (PST)
Date:   Wed, 8 Nov 2023 15:23:14 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        Haibo Xu <haibo1.xu@intel.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v2 06/21] RISC-V: Kconfig: Select deferred GSI probe
 for ACPI systems
Message-ID: <ZUtailOcozI9xIou@sunil-laptop>
References: <ZTuzJ1nsicZYp+uh@sunil-laptop>
 <20231106221606.GA264641@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106221606.GA264641@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Mon, Nov 06, 2023 at 04:16:06PM -0600, Bjorn Helgaas wrote:
> On Fri, Oct 27, 2023 at 06:25:03PM +0530, Sunil V L wrote:
> > On Thu, Oct 26, 2023 at 12:04:08PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Oct 26, 2023 at 01:53:29AM +0530, Sunil V L wrote:
> > > > On RISC-V platforms, apart from root interrupt controllers (which
> > > > provide local interrupts and IPI), other interrupt controllers in the
> > > > hierarchy are probed late. Enable this select this CONFIG option for
> > > > RISC-V platforms so that device drivers which connect to deferred
> > > > interrupt controllers can take appropriate action.
> > > 
> > > Quite a bit of this series seems related to the question of interrupt
> > > controllers being probed "late".
> > > 
> > > I don't see anything specific about *how* late this might be, but from
> > > the use of -EPROBE_DEFER in individual drivers (8250_pnp explicitly,
> > > and acpi_register_gsi() and pnp_irq() and acpi_pci_irq_enable(), which
> > > are called from driver .probe() paths) it seems like interrupt
> > > controllers might be detected even after devices that use them.
> > > 
> > > That seems like a fairly invasive change to the driver probe flow.
> > > If we really need to do that, I think it might merit a little more
> > > background as justification since we haven't had to do it for any
> > > other arch yet.
> > 
> > In RISC-V, the APLIC can be a converter from wired (GSI) to MSI interrupts.
> > Hence, especially in this mode, it has to be a platform device to use
> > device MSI domain. Also, according to Marc Zyngier there is no reason to
> > probe interrupt controllers early apart from root controller. So, the
> > device drivers which use wired interrupts need to be probed after APLIC.
> > 
> > The PNP devices and PCI INTx GSI links use either
> > acpi_dev_resource_interrupt() (PNP) or acpi_register_gsi() directly
> > (PCI). The approach taken here is to follow the example of
> > acpi_irq_get() which is enhanced to return EPROBE_DEFER and several
> > platform device drivers which use platform_get_irq() seem to be handling
> > this already.
> 
> This series (patch 04/21 "ACPI: irq: Add support for deferred probe in
> acpi_register_gsi()" [1]) makes acpi_register_gsi() return
> -EPROBE_DEFER, which percolates up through pci_enable_device().
> 
> Maybe that's ok, but this affects *all* PCI drivers, and it's a new
> case that did not occur before.  Many drivers emit warning or error
> messages for any pci_enable_device() failure, which you probably don't
> want in this case, since -EPROBE_DEFER is not really a "failure";
> IIUC, it just means "probe again later."
>
Yeah, I think all the drivers which need to be supported on RISC-V
ACPI based systems will have to support deferred probe with this scheme.

> > Using ResourceSource dependency (mbigen uses) in the namespace as part of
> > Extended Interrupt Descriptor will not ensure the order since PNP/INTx
> > GSI devices don't work with that.
> 
> Are these PNP/INTx GSI devices described in ACPI?  In the namespace?
> Or in a static table?
> 
Yes, these are standard devices in the namespace. For ex: PNP0501(16550)
or PNP0C0F (PCI interrupt link devices) are in the namespace.

> > Is there any other better way to create dependency between IO devices
> > and the interrupt controllers when interrupt controller itself is a
> > platform device? While using core_initcall() for interrupt controllers
> > seem to work which forces the interrupt controller to be probed first,
> > Marc is not in favor of that approach since it is fragile.
> 
> I guess PCI interrupts from the PCI host bridges (PNP0A03 devices)
> feed into the APLIC?  And APLIC is described via MADT?  Based on this
> series, it looks like this:
> 
>     acpi_init
>   +   acpi_riscv_init
>   +     riscv_acpi_aplic_platform_init
>   +       acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0)
>       acpi_scan_init
>         acpi_pci_root_init
>         acpi_pci_link_init
> 	acpi_bus_scan             # add PCI host bridges, etc
> 
> If that's the sequence, it looks like aplic_parse_madt() should be
> called before the PCI host bridges are added.
> 
> Or maybe this isn't how the APLICs are enumerated?
> 
That's partly correct. APLIC platform devices are created prior to PCI
host bridges added. But the actual APLIC driver which creates the
irqdomain will be probed as a regular platform driver for the APLIC
device. The platform driver probe will happen using DD framework and
devices don't have any dependency on APLIC which can cause device probe
prior to APLIC driver probe.

DT supports fw_devlink framework which makes it easier for IRQ devices
to use regular platform drivers and produces-consumers are probed in the
order without requiring drivers to do deferred probe. But I don't see
that supported for ACPI framework.  Also, the way PNP devices get added
there is an assumption that interrupt controller is already setup fully.

With this new use case in RISC-V, here are the alternatives I am aware of.

1) Use core_initcall() in the APLIC drivers which makes APLIC driver to
be probed prior to PNP or PCI INTx devices. But this was ruled out in
the context of DT from Marc.

2) Like the approach tried in this series, add support for deferred
probe in drivers. This will be invasive change requiring many drivers to
change like you pointed.

I don't know which is less evil or if there is any other alternative
which I am not aware of.

Thomas/Marc, could you allow APLIC (and PLIC) irqchip drivers to use
core_initcall() for ACPI?

Thanks,
Sunil
