Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9497C48CA9E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356015AbiALSGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 13:06:40 -0500
Received: from foss.arm.com ([217.140.110.172]:34186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355976AbiALSGb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 13:06:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D5D86D;
        Wed, 12 Jan 2022 10:06:30 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9669C3F766;
        Wed, 12 Jan 2022 10:06:29 -0800 (PST)
Date:   Wed, 12 Jan 2022 18:06:27 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] PCI: mt7621: Remove specific MIPS code from driver
Message-ID: <20220112180627.GB1319@lpieralisi>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
 <CAMhs-H886ZPZED-qmMtZcWFabRLNL14Y7SSz_Ko7d45zXL+v2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H886ZPZED-qmMtZcWFabRLNL14Y7SSz_Ko7d45zXL+v2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 03:42:56PM +0100, Sergio Paracuellos wrote:
> Hi Bjorn, Lorenzo,
> 
> On Tue, Dec 7, 2021 at 11:49 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi all,
> >
> > MIPS specific code can be removed from driver and put into ralink mt7621
> > instead which is a more accurate place to do this. To make this possible
> > we need to have access to 'bridge->windows' in 'pcibios_root_bridge_prepare()'
> > which has been implemented for ralink mt7621 platform (there is no real
> > need to implement this for any other platforms since those ones haven't got
> > I/O coherency units). This also allow us to properly enable this driver to
> > completely be enabled for COMPILE_TEST. This patchset appoarch:
> > - Move windows list splice in 'pci_register_host_bridge()' after function
> >   'pcibios_root_bridge_prepare()' is called.
> > - Implement 'pcibios_root_bridge_prepare()' for ralink mt7621.
> > - Avoid custom MIPs code in pcie-mt7621 driver.
> > - Add missing 'MODULE_LICENSE()' to pcie-mt7621 driver to avoid compile test
> >   module compilation to complain (already sent patch from Yanteng Si that
> >   I have rewrite commit message and long description a bit.
> > - Remove MIPS conditional code from Kconfig and mark driver as 'tristate'.
> >
> > This patchset is a real fix for some errors reported by Kernel Test Robot about
> > implicit mips functions used in driver code and fix errors in driver when
> > is compiled as a module [1] (mips:allmodconfig).
> >
> > Changes in v3:
> >  - Rebase the series on the top of the temporal fix sent for v5.16[3] for
> >    the module compilation problem.
> >  - Address review comments from Guenter in PATCH 2 (thanks Guenter!):
> >     - Address TODO in comment about the hardware does not allow zeros
> >       after 1s for the mask and WARN_ON if that's happend.
> >     - Be sure mask is real valid upper 16 bits.
> 
> What are your plans for this series? Can we merge this?

I was waiting for an ACK on patch (2) since it affects MIPS code.

It would also be great if Bjorn reviewed it to make sure he agrees
with the approach.

I think it is too late for this cycle, apologies, there is a significant
review backlog.

Lorenzo

> Best regards,
>     Sergio Paracuellos
> 
> >
> > Changes in v2:
> >  - Collect Acked-by from Arnd Bergmann for PATCH 1.
> >  - Collect Reviewed-by from Krzysztof Wilczyński for PATCH 4.
> >  - Adjust some patches commit subject and message as pointed out by Bjorn in review of v1 of the series[2].
> >
> > This patchset is the good way of properly compile driver as a module removing
> > all MIPS specific code into arch ralink mt7621 place. To avoid mips:allmodconfig reported
> > problems for v5.16 the following patch has been sent[3]. This series are rebased onto this patch to provide
> > a real fix for this problem.
> >
> > [0]: https://lore.kernel.org/linux-mips/CAMhs-H8ShoaYiFOOzJaGC68nZz=V365RXN_Kjuj=fPFENGJiiw@mail.gmail.com/T/#t
> > [1]: https://lkml.org/lkml/2021/11/14/436
> > [2]: https://lore.kernel.org/r/20211115070809.15529-1-sergio.paracuellos@gmail.com
> > [3]: https://lore.kernel.org/linux-pci/20211203192454.32624-1-sergio.paracuellos@gmail.com/T/#u
> >
> > Thanks in advance for your time.
> >
> > Best regards,
> >    Sergio Paracuellos
> >
> > Sergio Paracuellos (5):
> >   PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
> >   MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
> >   PCI: mt7621: Avoid custom MIPS code in driver code
> >   PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
> >   PCI: mt7621: Allow COMPILE_TEST for all arches
> >
> >  arch/mips/ralink/mt7621.c            | 31 ++++++++++++++++++++++
> >  drivers/pci/controller/Kconfig       |  4 +--
> >  drivers/pci/controller/pcie-mt7621.c | 39 ++--------------------------
> >  drivers/pci/probe.c                  |  4 +--
> >  4 files changed, 37 insertions(+), 41 deletions(-)
> >
> > --
> > 2.33.0
> >
