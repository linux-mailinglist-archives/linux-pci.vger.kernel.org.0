Return-Path: <linux-pci+bounces-31351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF5EAF6FF4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A107A14AD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A82E2EE3;
	Thu,  3 Jul 2025 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYtvgWeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5102E1737;
	Thu,  3 Jul 2025 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538313; cv=none; b=E9WrOXPkZHa0HPcxDwellu2Qt7u9TY11QAs8ZwzUWsFxzsFEWHsOQ1mG7Pt/gHmpd/jzb4Y9wSQAE1QIwX0ORKq81144J68fPoBN83bPHdQMJRlOkfse31NEfxs+ZnPKZGZmrnx1idMF2Iafk4us8kHuTIPbBzdtpIDoAawHsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538313; c=relaxed/simple;
	bh=MJlhjkmXDYyiSt6enP5P9DMUTBp3PzU/u6P5SRisubs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZA6jNfgRMWb3HbDo0ZNIlJ+pvVMv8KYlVddeofpLf/oOrOFW/HbZjbgL/zH7l5FHe1WVrJYsg81+AvgOnuYIJX22/xHUlYMfWJRE0WZWF0IdfjXDXO/2TWJZvFvj1EAZ7iPX2R0cGFnwRqUbeowkbvwjHQnpJbzq7Y//Dmvb1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYtvgWeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD860C4CEE3;
	Thu,  3 Jul 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538313;
	bh=MJlhjkmXDYyiSt6enP5P9DMUTBp3PzU/u6P5SRisubs=;
	h=From:Subject:Date:To:Cc:From;
	b=QYtvgWegb2puDSg/+wWNFKO3BKOTeYuV/HCYM0b53fCYsNxPnBSPDxjfjFRvfJKrn
	 YinCpLjRi4StE6F/4svlKlc215qqb3G7BxW8iEOGhfS7xACwcLaH6SYiBAQG5z2cUe
	 EC/jXcMXCkBXIpk/1FcM85wERDl22Ijmdrbp+qBDOeugkLnbtpxii8FVkCaCPMHT9K
	 C6Xbq0TNErGrF+C2yib8E8N2vJjRgZLgR1dEKvAfZrxneM59F8G0g7z57EBGvnOjxp
	 d1srRaWRq5lTNBn6BSTgeYKZmtygIRW68oyzYXM4PUp5z+6AtdpiSsw6CQULtAm+xM
	 0YZYTM2yzT7Ow==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v7 00/31] Arm GICv5: Host driver implementation
Date: Thu, 03 Jul 2025 12:24:50 +0200
Message-Id: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJaZmgC/23RwU7DMAwG4FeZciYocWyv5cR7IA5p47QRaB1pq
 UBT351sIK1VOTrS9yfxf1Gj5CSjejpcVJY5jWk4leH4cFBt70+d6BTKrMAAGTSV7lI7k+6HcdJ
 HrKOz7KNUqAo4Z4np6xb28lrmPo3TkL9v2bO9nv4bM1tttI3AoUGmWIXnN8kneX8ccqeuOTOsL
 ODGQrGEJKH10VhodtbdLRneWFcsSwjka4jB1DuLK2vdxmKxjWOpG0ueW7ezdLdst/+lYkMtDOB
 bIre/l1cWtm/mYrESg2XtyAgbu/yWkOXjsxQ5/TWxLD9gnfWH5gEAAA==
X-Change-ID: 20250408-gicv5-host-749f316afe84
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

Implement the irqchip kernel driver for the Arm GICv5 architecture,
as described in the GICv5 beta0 specification, available at:

https://developer.arm.com/documentation/aes0070

The GICv5 architecture is composed of multiple components:

- one or more IRS (Interrupt Routing Service)
- zero or more ITS (Interrupt Translation Service)
- zero or more IWB (Interrupt Wire Bridge)

The GICv5 host kernel driver is organized into units corresponding
to GICv5 components.

The GICv5 architecture defines the following interrupt types:

- PPI (PE-Private Peripheral Interrupt)
- SPI (Shared Peripheral Interrupt)
- LPI (Logical Peripheral Interrupt)

This series adds sysreg entries required to automatically generate
GICv5 registers handling code, one patch per-register.

This patch series is split into patches matching *logical* entities,
to make the review easier.

Logical entities:

- PPI
- IRS/SPI
- LPI/IPI
- SMP enablement
- ITS

The salient points of the driver are summarized below.

=============
1. Testing
=============

Patchset tested with an architecturally compliant FVP model with
the following setup:

- 1 IRS
- 1 and 2 ITSes
- 1 and 2 IWBs

configured with different parameters that vary the IRS(IST) and
ITS(DT/ITT) table levels and INTID/DEVICEID/EVENTID bits.

Trusted-Firmware (TF-A) was used for device tree bindings and component
initializations.

Guidelines to set-up the FVP model, kernel and TF-A in order to
bootstrap the GICv5 software stack are outlined in this wikipage,
it will be kept up-to-date with the latest developments:

https://linaro.atlassian.net/wiki/x/CQAF-wY

================
2. Driver design
================

=====================
2.1 GICv5 DT bindings
=====================

The DT bindings attempt to map directly to the GICv5 component
hierarchy, with a top level node corresponding to the GICv5 "system",
having IRS child nodes, that have in turn ITS child nodes.

The IWB is defined in a separate schema; its relationship with the ITS
is explicit through the msi-parent property required to define the IWB
deviceID.

===================
2.2 GICv5 top level
===================

The top-level GICv5 irqchip driver implements separate IRQ
domains - one for each interrupt type, PPI (PE-Private Peripheral
Interrupt), SPI (Shared Peripheral Interrupt) and LPI (Logical
Peripheral Interrupt).

The top-level exception handler routes the IRQ to the relevant IRQ
domain for handling according to the interrupt type detected when the
IRQ is acknowledged.

All IRQs are set to the same priority value.

The driver assumes that the GICv5 components implement enough
physical address bits to address the full system RAM, as required
by the architecture; it does not check whether the physical address
ranges of memory allocated for IRS/ITS tables are within the GICv5
physical address range.

Components are probed by relying on the early DT irqchip probing
scheme. The probing is carried out hierarchically, starting from
the top level.

The IWB driver has been reworked to match an MBIgen like interface.

Power management and Kexec are not yet supported at this stage.

=============
2.3 GICv5 IRS
=============

The GICv5 IRS driver probes and manages SPI interrupts by detecting their
presence and by providing the top-level driver the information required
to set up the SPI interrupt domain.

The GICv5 IRS driver also parses from firmware Interrupt AFFinity ID
(IAFFID) IDs identifying cores and sets up IRS IRQ routing.

The GICv5 IRS driver allocates memory to handle the IRS tables.

The IRS LPI interrupts state is kept in an Interrupt State Table (IST)
and it is managed through CPU instructions.

The IRS driver allocates the IST table that, depending on available HW
features can be either 1- or 2-level.

If the IST is 2-level, memory for the level-2 table entries
is allocated on demand (ie when LPIs are requested), using an IRS
mechanism to make level-1 entry valid on demand after the IST
has already been enabled.

Chunks of memory allocated for IST entries can be smaller or larger than
PAGE_SIZE and are required to be physically contiguous within an IST level
(i.e. a linear IST is a single memory block, a 2-level IST is made up of a
block of memory for the L1 table, whose entries point at different L2 tables
that are in turn allocated as memory chunks).

LPI INTIDs are allocated in software using an IDA. IDA does not support
allocating ranges, which is a bit cumbersome because this forces us
to allocate IDs one by one where the LPIs could actually be allocated
in chunks.

An IDA was chosen because basically it is a dynamic bitmap, which
carries out memory allocation automatically.

Other drivers/subsystems made different choices to allocate ranges,
an IDA was chosen since it is part of the core kernel and an IDA
range API is in the making.

IPIs are implemented using LPIs and a hierarchical domain is created
specifically for IPIs using the LPI domain as a parent.

arm64 IPI management core code is augmented with a new API to handle
IPIs that are not per-cpu interrupts and force the affinity of the LPI
backing an IPI to a specific and immutable value.

=============
2.4 GICv5 ITS
=============

The ITS driver partially reuses the existing GICv3/v4 MSI-parent
infrastructure and on top builds an IRQ domain needed to enable message
based IRQs.

ITS tables - DT (device table) and ITT (Interrupt Translation Table) are
allocated according to the number of required deviceIDs and eventIDs on
a per device basis. The ITS driver relies on the kmalloc() interface
because memory pages must be physically contiguous within a table level
and can be < or > than PAGE_SIZE.

=============
2.5 GICv5 IWB
=============

The IWB driver has been reworked to match an MBIgen like interface.

A new MSI flag (MSI_ALLOC_FLAGS_FIXED_MSG_DATA) had to be added for MSI
allocation in that the IWB has a fixed eventID per-wire and the ITS driver
code is not allowed to allocate eventIDs dynamically for events backing IWB
wires.

===================
3. Acknowledgements
===================

The patchset was co-developed with T.Hayes and S.Bischoff from
Arm - thank you so much for your help.

A big thank you to M.Zyngier for his fundamental help/advice.

If you have some time to help us review this series and get it into
shape, thank you very much.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
Changes in v7:
- Added CDDI/CDDIS/CDEN FIELD_PREP(hwirqid) for instruction preparation
- Fixed IST/DT/ITT L2 size selection logic for 64K PAGE_SIZE
- Reordered some ITS error paths according to review
- Link to v6: https://lore.kernel.org/r/20250626-gicv5-host-v6-0-48e046af4642@kernel.org

Changes in v6:
- Reworked arm64 IPIs on non-SGI systems code according to review
- Fixed msi-map management, added helper function to map ID and retrieve
  controller node pointer at the same time
- Added IRQ domain flag for IRQdomain selection on GICv5
- Split ITS patch according to review - smaller helper/clean-up first
- Added review tag
- Tidied-up error labels return code
- Link to v5: https://lore.kernel.org/r/20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org

Changes in v5:
- Added support for ITS multiple translate frame registers
- Added DT/PCI support function to retrieve msi controller from
  msi-parent and msi-map properties
- Updated DT bindings to add interrupt-domains
- Fixed request_irq() IPI parameter sparse error
- Forced __always_inline to fix gcc build error on patch 20
- Fixed trivial sysreg typo
- Applied review tags
- Added arm64 gic-v5 booting requirements patch
- Rebased on v6.16-rc2
- Link to v4: https://lore.kernel.org/r/20250513-gicv5-host-v4-0-b36e9b15a6c3@kernel.org

Changes in v4:
- Added IWB new driver version based on MBIgen interface
- Added MSI alloc flag
- Rebased against git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/msi-prepare-teardown
- Made more coding style updates to comply with tip-maintainer
  guidelines
- Updated PPI type handling
- Updated devicetree bindings
- Fixed includecheck warning
- Link to v3: https://lore.kernel.org/r/20250506-gicv5-host-v3-0-6edd5a92fd09@kernel.org

Changes in v3:
- Reintroduced v1 patch split to simplify review
- Reworked IRS/ITS iopoll loop, split in atomic/non-atomic
- Cleaned-up IRS/ITS code with macros addressing review comments
- Dropped IWB driver waiting for IRQ core code to be fixed for DOMAIN_BUS_WIRED_TO_MSI
  https://lore.kernel.org/lkml/87tt6310hu.wl-maz@kernel.org/
- Moved headers to arch/arm64 and include/linux/irqchip
- Reworked GSB barriers definition
- Added extensive GSB/ISB barriers comments
- Limited error checking on IRS/ITS code - introduced couple of fatal
  BUG_ON checks
- Link to v2: https://lore.kernel.org/r/20250424-gicv5-host-v2-0-545edcaf012b@kernel.org

Changes in v2:
- Squashed patches [18-21] into a single logical entity
- Replaced maple tree with IDA for LPI IDs allocation
- Changed coding style to tip-maintainer guidelines
- Tried to consolidate poll wait mechanism into fewer functions
- Added comments related to _relaxed accessors, barriers and kmalloc
  limitations
- Removed IPI affinity check hotplug callback
- Applied DT schema changes requested, moved IWB into a separate schema
- Fixed DT examples
- Fixed guard() usage
- Link to v1: https://lore.kernel.org/r/20250408-gicv5-host-v1-0-1f26db465f8d@kernel.org

---
Lorenzo Pieralisi (30):
      dt-bindings: interrupt-controller: Add Arm GICv5
      arm64/sysreg: Add GCIE field to ID_AA64PFR2_EL1
      arm64/sysreg: Add ICC_PPI_PRIORITY<n>_EL1
      arm64/sysreg: Add ICC_ICSR_EL1
      arm64/sysreg: Add ICC_PPI_HMR<n>_EL1
      arm64/sysreg: Add ICC_PPI_ENABLER<n>_EL1
      arm64/sysreg: Add ICC_PPI_{C/S}ACTIVER<n>_EL1
      arm64/sysreg: Add ICC_PPI_{C/S}PENDR<n>_EL1
      arm64/sysreg: Add ICC_CR0_EL1
      arm64/sysreg: Add ICC_PCR_EL1
      arm64/sysreg: Add ICC_IDR0_EL1
      arm64/sysreg: Add ICH_HFGRTR_EL2
      arm64/sysreg: Add ICH_HFGWTR_EL2
      arm64/sysreg: Add ICH_HFGITR_EL2
      arm64: Disable GICv5 read/write/instruction traps
      arm64: cpucaps: Rename GICv3 CPU interface capability
      arm64: cpucaps: Add GICv5 CPU interface (GCIE) capability
      arm64: Add support for GICv5 GSB barriers
      irqchip/gic-v5: Add GICv5 PPI support
      irqchip/gic-v5: Add GICv5 IRS/SPI support
      irqchip/gic-v5: Add GICv5 LPI/IPI support
      irqchip/gic-v5: Enable GICv5 SMP booting
      of/irq: Add of_msi_xlate() helper function
      PCI/MSI: Add pci_msi_map_rid_ctlr_node() helper function
      irqchip/gic-v3: Rename GICv3 ITS MSI parent
      irqchip/msi-lib: Add IRQ_DOMAIN_FLAG_FWNODE_PARENT handling
      irqchip/gic-v5: Add GICv5 ITS support
      irqchip/gic-v5: Add GICv5 IWB support
      docs: arm64: gic-v5: Document booting requirements for GICv5
      arm64: Kconfig: Enable GICv5

Marc Zyngier (1):
      arm64: smp: Support non-SGIs for IPIs

 Documentation/arch/arm64/booting.rst               |   41 +
 .../interrupt-controller/arm,gic-v5-iwb.yaml       |   78 ++
 .../bindings/interrupt-controller/arm,gic-v5.yaml  |  267 +++++
 MAINTAINERS                                        |   10 +
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/include/asm/barrier.h                   |    3 +
 arch/arm64/include/asm/el2_setup.h                 |   45 +
 arch/arm64/include/asm/smp.h                       |   24 +-
 arch/arm64/include/asm/sysreg.h                    |   71 +-
 arch/arm64/kernel/cpufeature.c                     |   17 +-
 arch/arm64/kernel/smp.c                            |  144 ++-
 arch/arm64/tools/cpucaps                           |    3 +-
 arch/arm64/tools/sysreg                            |  495 +++++++-
 drivers/irqchip/Kconfig                            |   12 +
 drivers/irqchip/Makefile                           |    5 +-
 drivers/irqchip/irq-gic-common.h                   |    2 -
 ...3-its-msi-parent.c => irq-gic-its-msi-parent.c} |  168 ++-
 drivers/irqchip/irq-gic-its-msi-parent.h           |   12 +
 drivers/irqchip/irq-gic-v3-its.c                   |    1 +
 drivers/irqchip/irq-gic-v5-irs.c                   |  822 +++++++++++++
 drivers/irqchip/irq-gic-v5-its.c                   | 1228 ++++++++++++++++++++
 drivers/irqchip/irq-gic-v5-iwb.c                   |  284 +++++
 drivers/irqchip/irq-gic-v5.c                       | 1087 +++++++++++++++++
 drivers/irqchip/irq-gic.c                          |    2 +-
 drivers/irqchip/irq-msi-lib.c                      |    5 +-
 drivers/of/irq.c                                   |   22 +-
 drivers/pci/msi/irqdomain.c                        |   20 +
 include/asm-generic/msi.h                          |    1 +
 include/linux/irqchip/arm-gic-v5.h                 |  394 +++++++
 include/linux/irqdomain.h                          |    3 +
 include/linux/msi.h                                |    1 +
 include/linux/of_irq.h                             |    5 +
 32 files changed, 5200 insertions(+), 73 deletions(-)
---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250408-gicv5-host-749f316afe84

Best regards,
-- 
Lorenzo Pieralisi <lpieralisi@kernel.org>


