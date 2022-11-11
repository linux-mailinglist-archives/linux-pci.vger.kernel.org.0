Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A62625C5E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiKKOFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiKKOFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:05:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D11177226;
        Fri, 11 Nov 2022 05:59:16 -0800 (PST)
Message-ID: <20221111133158.196269823@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lKtybZSqr7GZ+L35zm9D6r7kWSuIbe96VBh+Eax0U7M=;
        b=Lw2l2zi/A/Cwisa982jyIY01GCPrOOYGLMdKpX0zZ4JHP61njCJugsptQzJwQkfJybo3HT
        OqMXaiJ1cJ0Td+q63mbEeAc0crfNwIJbWbRsyqq78wqttkdBmFrxf9AKvVwIqg7tT2xSeR
        54v/wZSqh+LI7w+0DaEZfGqEy3qywsTj0cZUhFYglHBH9AZX/chJVIPYAnY1xvc+LMUgSr
        GAeLbe21JwuGWPN3BW1LZHJif+VClnSmE9NVp2uuw9CAbxkiQ0b+HiTYRC3w9L6MWUlQ/g
        sgucTqsm135Tl0Qrw27HdZQIhk+LhwCHV4unBezhUVhgWurzrf9yZQdBBrTYaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lKtybZSqr7GZ+L35zm9D6r7kWSuIbe96VBh+Eax0U7M=;
        b=IOJPq0HPEoya9v9Ama3VRgnFClMDXwvpNRCNkSlq3bphCv/20nIuVLJ0mXXz2EZZOV96/g
        Oh/owgX16WqYdaAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 00/33] genirq, PCI/MSI: Support for per device MSI and PCI/IMS
 - Part 3 implementation
Date:   Fri, 11 Nov 2022 14:58:11 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

This is the third part of a three part series which provides support for
per device MSI interrupt domains. This solves conceptual problems of the
current PCI/MSI design which are in the way of providing support for
PCI/MSI[-X] and the upcoming PCI/IMS mechanism on the same device.

Part 2 can be found here:

  https://lore.kernel.org/all/20221111131813.914374272@linutronix.de

IMS (Interrupt Message Store] is a new specification which allows device
manufactures to provide implementaton defined storage for MSI messages
contrary to the uniform and specification defined storage mechanisms for
PCI/MSI and PCI/MSI-X. IMS not only allows to overcome the size limitions
of the MSI-X table, but also gives the device manufacturer the freedom to
store the message in arbitrary places, even in host memory which is shared
with the device.

There have been several attempts to glue this into the current MSI code,
but after lengthy discussions in various threads:

  https://lore.kernel.org/all/20211126230957.239391799@linutronix.de
  https://lore.kernel.org/all/MWHPR11MB188603D0D809C1079F5817DC8C099@MWHPR11MB1886.namprd11.prod.outlook.com
  https://lore.kernel.org/all/160408357912.912050.17005584526266191420.stgit@djiang5-desk3.ch.intel.com

it turned out that there is a fundamental design problem in the current
PCI/MSI-X implementation. This needs some historical background.

When PCI/MSI[-X] support was added around 2003 interrupt management was
completely different from what we have today in the actively developed
architectures. Interrupt management was completely architecture specific
and while there were attempts to create common infrastructure the
commonalities were rudimental and just providing shared data structures and
interfaces so that drivers could be written in an architecture agnostic
way.

The initial PCI/MSI[-X] support obviously plugged into this model which
resulted in some basic shared infrastructure in the PCI core code for
setting up MSI descriptors, which are a pure software construct for holding
data relevant for a particular MSI interrupt, but the actual association to
Linux interrupts was completely architecture specific. This model is still
supported today to keep museum architectures and notorious stranglers
alive.

In 2013 Intel tried to add support for hotplugable IO/APICs to the kernel
which was creating yet another architecture specific mechanism and resulted
in an unholy mess on top of the existing horrors of x86 interrupt handling.
The x86 interrupt management code was already an uncomprehensible maze of
indirections between the CPU vector management, interrupt remapping and the
actual IO/APIC and PCI/MSI[-X] implementation.

At roughly the same time ARM struggled with the ever growing SoC specific
extensions which were glued on top of the architected GIC interrupt
controller.

This resulted in a fundamental redesign of interrupt management and
provided the today prevailing concept of hierarchical interrupt
domains. This allows to disentangle the interactions between x86 vector
domain and interrupt remapping and also allowed ARM to handle the zoo of
SoC specific interrupt components in a sane way.

The concept of hierarchical interrupt domains aims to encapsulate the
functionality of particual IP blocks which are involved in interrupt
delivery so that they become extensible and pluggable. The X86
encapsulation looks like this:

                                         |--- device 1
     [Vector]---[Remapping]---[PCI/MSI]--|...
                                         |--- device N

where the remapping domain is an optional component and in case that it is
not available the PCI/MSI[-X] domains have the vector domain as their
parent. This reduced the required interaction between the domains pretty
much to the initialization phase where it is obviously required to
establish the proper parent relation ship in the components of the
hierarchy.

While in most cases the model is strictly representing the chain of IP
blocks and abstracting them so they can be plugged together to form a
hierarchy, the design stopped short on PCI/MSI[-X]. Looking at the hardware
it's clear that the actual PCI/MSI[-X] interrupt controller is not a global
entity, but strict a per PCI device entity.

Here we took a short cut on the hierarchical model and went for the easy
solution of providing "global" PCI/MSI domains which was possible because
the PCI/MSI[-X] handling is uniform accross the devices. This also allowed
to keep the existing PCI/MSI[-X] infrastructure mostly unchanged which in
turn made it simple to keep the existing architecture specific management
alive.

A similar problem was created in the ARM world with support for IP block
specific message storage. Instead of going all the way to stack a IP block
specific domain on top of the generic MSI domain this ended in a construct
which provides a "global" platform MSI domain which allows overriding the
irq_write_msi_msg() callback per allocation.

In course of the lengthy discussions we identified other abuse of the MSI
infrastructure in wireless drivers, NTB etc. where support for
implementation specific message storage was just mindlessly glued into the
existing infrastructure. Some of this just works by chance on particular
platforms but will fail in hard to diagnose ways when the driver is used
on platforms where the underlying MSI interrupt management code does not
expect the creative abuse.

Another shortcoming of todays PCI/MSI-X support is the inability to
allocate or free individual vectors after the initial enablement of
MSI-X. This results in an works by chance implementation of VFIO (PCI
passthrough) where interrupts on the host side are not set up upfront to
avoid resource exhaustion. They are expanded at runtime when the guest
actually tries to use them. The way how this is implemented is that the
host disables MSI-X and the enables it with a larger number of vectors
again. That works by chance because most device drivers set up all
interrupts before the device actually will utilize them. But that's not
universally true because some drivers allocate a large enough number of
vectors but do not utilize them until it's actually required,
e.g. acceleration support. But at that point other interrupts of the device
might be in active use and the MSI-X disable/enable dance can just result
in losing interrupts and therefore hard to diagnose subtle problems.

Last but not least the "global" PCI/MSI-X domain approach prevents to
utilize PCI/MSI[-X] and PCI/IMS on the same device due to the fact that IMS
is not longer providing a uniform storage and configuration model.

The solution to this is to implement the missing step and switch from
global MSI domains to per device MSI domains. The resulting hierarchy then
looks like this:

                              |--- [PCI/MSI] device 1
     [Vector]---[Remapping]---|...
                              |--- [PCI/MSI] device N

which in turn allows provide support for multiple domains per device:

                              |--- [PCI/MSI] device 1
                              |--- [PCI/IMS] device 1
     [Vector]---[Remapping]---|...
                              |--- [PCI/MSI] device N
                              |--- [PCI/IMS] device N

To achieve this and to provide solutions for the other identified issues,
e.g. VFIO, this needs a major overhaul of the affected infrastructure.

The 90+ patches series is split into three parts for submission:

  1) General cleanups of the core infrastructure and the PCI/MSI code

  2) Preparatory changes for per device (multiple) MSI domain support
     including a complete replacement of the MSI core interfaces
     switching from a domain pointer based to a domain ID based model
     and providing support for proper range based allocation/free

  3) The actual implementation for per device domains, the conversion of
     the PCI/MSI-X infrastructure, dynamic allocation/free for MSI-X,
     initial support for PCI/IMS and enablement for X86. Plus a demo
     IMS driver for IDXD.

The three parts are available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v1-part1
   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v1-part2
   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v1-part3

To complete the picture we went all the way and converted ARM64 including
the platform-MSI horrors over to the new model. It's barely tested in a VM
(at least the PCI/MSI-X) part can be validated that way. For the rest this
just compiles and we can't do much more as we lack hardware. The reason why
this conversion was done is to ensure that the design, the underlying data
structures and the resulting interfaces are correct and can handle the
requirements of ARM64. The result looks pretty good and while the initial
support does not cover some of the oddball issues of the ARM64 zoo, it
turned out that the extra functionality required is just extending the
provided infrastructure but does not require any design changes. This is
also available from git for the adventurous, but be warned that it might
eat your harddisk, confuse your cat and make your kids miss the bus:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v1-arm

This is not going to be posted as its work in progress. It's provided for
reference and for Marc to play with.

We did look into NTB and other places like VFIO, but did not come around to
actually convert them over partly because of lack of time, but also because
the code is simply incomprehensible.

We tested the creation of a secondary MSI domain with a mockup driver, but
again due to lack of hardware there is no way to validate any functionality.

The dynamic allocation/free of MSI-X interrupts post MSI-X enable was
tested by hacking up a device driver and allocating only one interrupt at
MSI-X enable time and then allocate the rest with the new interfaces. Also
the dynamic free was tested that way.

Note, that dynamic allocation of MSI-X interrupt requires opt-in of the
underlying MSI parent domain. It is neither supported on the legacy
architecture specific MSI mechanism, which is still in use on ia64, sparc,
PPC and a few subarchitectures of MIPS.

The reason why this cannot be supported unconditionally is that due to the
history of PCI/MSI support in the kernel there are many implementations
which expect that MSI[-X] enable is a one off operation which allocates and
associates all required interrupts right at that point. Even architectures
which utilize hierarchical irq domains have such assumptions which are in
some cases even enforced through the underlying hypervisor/firmware.

IMS is opt-in too and it requires that the architecture/platform has been
converted to the per device MSI model and the underlying interrupt domains
have the necessary support in place, which might never happen for ia64 and
some parts of MIPS, SPARC, PPC and S390.

That means driver writers have to be careful about the limitiations of
this. For dynamic MSI-X allocation/free there is a query interface. For IMS
domains that's momentarily just the domain creation failing with an error
code. If necessary for driver conveniance then implementing a query
interface is trivial enough.

Enough of history and theory. Here comes part 3:

It provides the actual per device domain implementation and related
functionality:

  1) Provide infrastructure to create and remove per device MSI domains

  2) Implement per device MSI domains in the PCI/MSI code and make
     them conditional on the availability of a suitable parent MSI
     domain. This allows to convert the existing domains one by one
     and keeps both the legacy and the current "global" PCI/MSI domain
     model working.

  3) Convert the related x86 MSI domains over (vector and remapping).

  4) Provide core infrastructure for dynamic allocations

  5) Provide PCI/MSI-X interfaces for device drivers to do post
     MSI-X enable allocation/free

  6) Enable dynamic allocation support on the x86 MSI parent domains

  7) Provide infrastructure to create PCI/IMS domains

  8) Enable IMS support on the x86 MSI parent domains

  9) Provide a driver for IDXD which demonstrates how IMS domains
     look like.

The IDXD part is untested and the core IMS functionality has only been
exposed to a mockup.

The overall impact of the full series against 6.1-rc4 is:

 54 files changed, 2912 insertions(+), 1366 deletions(-)

while the subsequent work in progress conversion of ARM64 actually has a
negative diffstat:

 30 files changed, 900 insertions(+), 1274 deletions(-)

Thanks,

	tglx
---
 arch/x86/include/asm/irq_remapping.h       |    4 
 arch/x86/include/asm/msi.h                 |    6 
 arch/x86/include/asm/pci.h                 |    1 
 arch/x86/kernel/apic/msi.c                 |  208 +++++++++-------
 drivers/iommu/amd/amd_iommu_types.h        |    1 
 drivers/iommu/amd/iommu.c                  |   23 +
 drivers/iommu/intel/iommu.h                |    1 
 drivers/iommu/intel/irq_remapping.c        |   31 +-
 drivers/irqchip/Kconfig                    |    7 
 drivers/irqchip/Makefile                   |    1 
 drivers/irqchip/irq-pci-intel-idxd.c       |  143 +++++++++++
 drivers/pci/msi/api.c                      |  117 +++++++++
 drivers/pci/msi/irqdomain.c                |  278 +++++++++++++++++++--
 drivers/pci/msi/msi.c                      |  192 ++++++++------
 drivers/pci/msi/msi.h                      |    4 
 include/linux/irqchip/irq-pci-intel-idxd.h |   22 +
 include/linux/irqdomain.h                  |    9 
 include/linux/irqdomain_defs.h             |    5 
 include/linux/msi.h                        |  130 ++++++++--
 include/linux/msi_api.h                    |   38 ++
 include/linux/pci.h                        |   14 +
 kernel/irq/msi.c                           |  375 +++++++++++++++++++++++++++--
 22 files changed, 1357 insertions(+), 253 deletions(-)
