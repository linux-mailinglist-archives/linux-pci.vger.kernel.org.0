Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710139A2E4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 16:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFCOSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 10:18:32 -0400
Received: from foss.arm.com ([217.140.110.172]:42430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhFCOSc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 10:18:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593E911FB;
        Thu,  3 Jun 2021 07:16:47 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71DE23F73D;
        Thu,  3 Jun 2021 07:16:46 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:16:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Arm64 double PCI ECAM reservations in acpi_resource_consumer()
Message-ID: <20210603141641.GA17284@lpieralisi>
References: <c82b61f5-00d4-182f-2bb7-3518adf2ca75@quicinc.com>
 <CAErSpo4=uspbvScDzfEw+NjsVJKYf6=DyrC=Gasw2Qdt1gwXYg@mail.gmail.com>
 <3a1165b6-033f-33af-fe1f-33a1be4b500a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1165b6-033f-33af-fe1f-33a1be4b500a@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 08:15:20PM -0400, Qian Cai wrote:
> 
> 
> On 6/2/2021 6:09 PM, Bjorn Helgaas wrote:
> > [+cc linux-pci]
> > 
> > On Wed, Jun 2, 2021 at 4:49 PM Qian Cai <quic_qiancai@quicinc.com> wrote:
> >>
> >> Bjorn, I noticed PCI ECAM could be reserved twice on arm64. Firs time through,
> >>
> >> [   19.087790][    T1]  acpi_ns_walk_namespace+0xc0/0x390
> >> [   19.092927][    T1]  acpi_get_devices+0x160/0x1a4
> >> [   19.097629][    T1]  acpi_resource_consumer+0x8c/0xc0
> >> [   19.102680][    T1]  pci_acpi_scan_root+0x158/0x4c8
> >> [   19.107555][    T1]  acpi_pci_root_add+0x450/0x8e8
> >> [   19.112345][    T1]  acpi_bus_attach+0x300/0x7d0
> >> [   19.116960][    T1]  acpi_bus_attach+0x178/0x7d0
> >> [   19.121576][    T1]  acpi_bus_attach+0x178/0x7d0
> >> [   19.126190][    T1]  acpi_bus_scan+0xa8/0x170
> >> [   19.130545][    T1]  acpi_scan_init+0x220/0x558
> >> [   19.135074][    T1]  acpi_init+0x1f4/0x270
> >>
> >> where pci_acpi_setup_ecam_mapping() confirmed all reservations are succeed. Then,
> >>
> >> [   19.880588][    T1]  acpi_ns_walk_namespace+0xc0/0x390
> >> [   19.885725][    T1]  acpi_get_devices+0x160/0x1a4
> >> [   19.890426][    T1]  pnpacpi_init+0xa0/0x10
> >>
> >> As the results, those messages are showed up during the boot in pnpacpi_init().
> >>
> >> [ 17.763968] system 00:00: [mem 0x10000000000-0x1000fffffff window] could not be reserved
> >> [ 17.772900] system 00:00: [mem 0x7800000000-0x780fffffff window] could not be reserved
> >> [ 17.781627] system 00:00: [mem 0x7000000000-0x700fffffff window] could not be reserved
> >> [ 17.790350] system 00:00: [mem 0x6000000000-0x600fffffff window] could not be reserved
> >> [ 17.799073] system 00:00: [mem 0x5800000000-0x580fffffff window] could not be reserved
> >> [ 17.808155] system 00:00: [mem 0x1000000000-0x100fffffff window] could not be reserved
> >> [ 17.816862] system 00:00: [mem 0x600000000-0x60fffffff window] could not be reserved
> >> [ 17.825417] system 00:00: [mem 0x400000000-0x40fffffff window] could not be reserved
> >>
> >> Looking through the x86's version of pci_acpi_scan_root(), it won't call acpi_resource_consumer(), so I suppose this bug is only affecting arm64?
> > 
> > This might be related to
> > https://lore.kernel.org/linux-acpi/20210510234020.1330087-1-luzmaximilian@gmail.com/T/#u
> > 
> > Can you try applying that patch to see if it is related?
> 
> Unfortunately, that revert patch does not help. FYI, here is the first reservation from acpi_resource_consumer().

This is not the "reservation". AFAICS acpi_resource_consumer() checks
whether the ECAM region is part of _a_ given ACPI device _CRS in the
namespace, it does not "reserve" anything.

IIUC the issue here is that we request the ECAM region in
pci_ecam_create() and later the code in:

drivers/pnp/system.c

tries to request the ECAM region (that lives in the PNP0C02 _CRS) and
fails (see reserve_range() and request_mem_region()).

As the comment in reserve_range() goes, this is harmless, not sure
whether there is anything to do about it.

Lorenzo

> [   16.224306] acpi PNP0A08:00: ECAM area [mem 0x10000000000-0x1000fffffff] reserved by PNP0C02:00
> [   16.241027] acpi PNP0A08:00: ECAM at [mem 0x10000000000-0x1000fffffff] for [bus 00-ff]
> [   16.810172] acpi PNP0A08:01: ECAM area [mem 0x7800000000-0x780fffffff] reserved by PNP0C02:00
> [   16.826701] acpi PNP0A08:01: ECAM at [mem 0x7800000000-0x780fffffff] for [bus 00-ff]
> [   17.289302] acpi PNP0A08:02: ECAM area [mem 0x1000000000-0x100fffffff] reserved by PNP0C02:00
> [   17.305840] acpi PNP0A08:02: ECAM at [mem 0x1000000000-0x100fffffff] for [bus 00-ff]
> [   17.641917] acpi PNP0A08:03: ECAM area [mem 0x5800000000-0x580fffffff] reserved by PNP0C02:00
> [   17.658445] acpi PNP0A08:03: ECAM at [mem 0x5800000000-0x580fffffff] for [bus 00-ff]
> [   18.059837] acpi PNP0A08:04: ECAM area [mem 0x6000000000-0x600fffffff] reserved by PNP0C02:00
> [   18.076368] acpi PNP0A08:04: ECAM at [mem 0x6000000000-0x600fffffff] for [bus 00-ff]
> [   18.413220] acpi PNP0A08:05: ECAM area [mem 0x7000000000-0x700fffffff] reserved by PNP0C02:00
> [   18.429745] acpi PNP0A08:05: ECAM at [mem 0x7000000000-0x700fffffff] for [bus 00-ff]
> [   18.767189] acpi PNP0A08:06: ECAM area [mem 0x600000000-0x60fffffff] reserved by PNP0C02:00
> [   18.783559] acpi PNP0A08:06: ECAM at [mem 0x600000000-0x60fffffff] for [bus 00-ff]
> [   19.201613] acpi PNP0A08:07: ECAM area [mem 0x400000000-0x40fffffff] reserved by PNP0C02:00
> [   19.217965] acpi PNP0A08:07: ECAM at [mem 0x400000000-0x40fffffff] for [bus 00-ff]
