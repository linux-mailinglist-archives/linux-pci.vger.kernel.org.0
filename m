Return-Path: <linux-pci+bounces-43273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BB0CCB524
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 11:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06749302AAAD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846F331221;
	Thu, 18 Dec 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg678wxJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD5E23A994;
	Thu, 18 Dec 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052905; cv=none; b=oi3nGtbblx/hCVCDpV46No6nTyy6BPavNyueQghwwmBCkH5/9bG1iHtPZqyvSKx6GY7VnlW0jUkU6Do86jbJrgQkN0nh5tTvmgKOaFotPUmwwGlSKXGT7e4ec6cXj2KzxWJumUKsUPAK6QLwbctfSK/pifUZ89DRH+t8mW8+plU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052905; c=relaxed/simple;
	bh=bUrOudaBNEyNMrDDCs/9pJg9ZvlHYmUGDr+eXIjrMyo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Au+jorhSbfUBydshPTuT9Mdo1MzdlrVEs57O1Ak9pnjeDYPSB9PiXmJp7fvzVjxfj4NPL7cTCfenNr3pJVNBO6E3JaMy54Hd+0hY7RetiDq+/kI8BAId/+P/ClXceqG46njGkGq8YnLVdSd2I5Tk7NnCpNVyXNiJDo+qrt+62VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg678wxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99C0C4CEFB;
	Thu, 18 Dec 2025 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766052904;
	bh=bUrOudaBNEyNMrDDCs/9pJg9ZvlHYmUGDr+eXIjrMyo=;
	h=From:Subject:Date:To:Cc:From;
	b=Rg678wxJlwP2XtXO1kbmDVfmPFRvx3qUSeWXchI0F55x5wmP53dUVUIXohf5Zbu+n
	 ZfIsju8wp3+Y4bDyqpgBhNRR0H8cIkzilNOtzeh9QI4DMxbEFMCeZDHDAp5wyYjl+n
	 xNrZp+D0ETul3gohzeUtwdl+celqsdWG7rEEBX8Ak4+rlZdcCLLeBK6+eV5mQWV0oE
	 A1F+SaXu5/TZhB9hSM+K0GOhqkK6BsEKaajGX4B9jqGPx6ZwoBKKo1Vp+cwSObHrby
	 1aHe8SRtbr7EAFu8WLs/oHY8uCBUKdAzqD9nbVB/0J9A8fXZD29doqSZb+l0G9ADeu
	 7w8nMhIlAva+w==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v2 0/7] irqchip/gic-v5: Code first ACPI boot support
Date: Thu, 18 Dec 2025 11:14:26 +0100
Message-Id: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAALUQ2kC/2WNQQrCMBBFr1Jm7UgSSa2ueg/pIibTZlCSkpSgl
 N7dWHDl8j3476+QKTFluDYrJCqcOYYK6tCA9SZMhOwqgxJKS6EUTmyLRh/zgsbOjE5fXGulOzl
 xhrqaE4382ou3obLnvMT03g+K/Npfq/trFYkChTRdq0a6a2v6B6VAz2NMEwzbtn0AzUKfja8AA
 AA=
X-Change-ID: 20251022-gicv5-host-acpi-d59d6c1d3d07
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jose Marinho <jose.marinho@arm.com>
X-Mailer: b4 0.14.3

The ACPI and ACPI IORT specifications were updated to support bindings
required to describe GICv5 based systems.

The ACPI specification GICv5 bindings ECR [1] were approved and the
required changes merged in the ACPICA upstream repository[5].

The Arm IORT specification [2] has been updated to include GICv5 IWB
specific bindings in revision E.g.

Implement kernel code that - based on the aforementioned bindings - adds
support for GICv5 ACPI probing.

ACPICA changes supporting the bindings are posted with the series; they
were cherry-picked from the upcoming ACPICA Linuxised release patches
and they should _not_ be merged in any upstream branch because the
full set of Linuxised ACPICA changes will be subsequently posted in
order to be merged, I added the two ACPICA patches to make the series
self-contained.

The ACPI bindings were prototyped in edk2 - code available in these
branches [3][4].

===========================
Kernel implementation notes
===========================

IRS and ITS probing is triggered using the standard irqchip ACPI probing
mechanism - there is no significant difference compared to previous GIC
versions other.

The only difference that is worth noting is that GICv3/4 systems include a
single MADT component describing the interrupt controller (ie GIC distributor)
whereas GICv5 systems include one or more IRSes. The probing code is
implemented so that an MADT IRS detection triggers probing for all IRSes
in one go.

The IWB driver probes like any other ACPI device. IORT code is updated so
that a deviceID for the IWB can be detected.

The only major change compared to GICv3/4 systems is the GSI namespace that
is split between PPI/SPI IRQs and IWB backed IRQs.

The main GSI handle - to map an IRQ - has to detect whether to look-up
using the top level GSI domain or an IWB domain in that the two IRQ
namespaces are decoupled.

IORT code implements the logic to retrieve an IWB domain by looking up its
IWB frame id, as described in [1].

Most important implementation detail worth noting is that - at this stage -
ACPI code is not capable of handling devices probe order IRQ dependency on
the interrupt controller driver their IRQ is routed to.

This is not an issue on GICv3/4 systems in that the full GIC hierarchy
probes earlier than any other device, so by the time IRQs mappings have to
be carried out (ie acpi_register_gsi()) the GIC drivers have already
probed.

On GICv5 systems, the IWB is modelled as a device and its device driver
probes at device_initcall time. That's when the IWB IRQ domain is actually
registered - which poses problems for devices whose IRQs are IWB routed and
require to resolve the IRQ mapping before the IWB driver has a chance to
probe.

Work on resolving devices<->IWB probe order dependency has started in
parallel with this series and will be posted shortly.

For PPI/SPI/LPI backed IRQs the probe dependency is not a problem because
in GICv5 systems the IRSes and ITSes probe early so their IRQ domain are
set in place before devices require IRQ mappings.

ACPICA patches are a Linuxised version of ACPICA GICv5 upstream changes
[5] and should not be considered for merging because they would conflict
with the full ACPICA release changes patchset that will be posted later
in this dev cycle (owing to patch dependencies in the ACPICA commit
history) they are there so that the patch series is self-contained.

[1] https://github.com/tianocore/edk2/issues/11148
[2] https://developer.arm.com/documentation/den0049/eg
[3] https://github.com/LeviYeoReum/edk2/tree/levi/gicv5_patch
[4] https://github.com/LeviYeoReum/edk2-platforms/tree/levi/gicv5_patch
[5] https://github.com/acpica/acpica/commits/master/

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
Changes in v2:
- Cherry-picked ACPICA upstream changes
- Minor editorial changes
- Removed the "not for merging" tag because now ACPI specs are approved
- Rebased against v6.19-rc1
- Link to v1: https://lore.kernel.org/r/20251028-gicv5-host-acpi-v1-0-01a862feb5ca@kernel.org

---
Jose Marinho (2):
      ACPICA: Add GICv5 MADT structures
      ACPICA: Add Arm IORT IWB node definitions

Lorenzo Pieralisi (5):
      irqdomain: Add parent field to struct irqchip_fwid
      PCI/MSI: Make the pci_msi_map_rid_ctlr_node() interface firmware agnostic
      irqchip/gic-v5: Add ACPI IRS probing
      irqchip/gic-v5: Add ACPI ITS probing
      irqchip/gic-v5: Add ACPI IWB probing

 drivers/acpi/arm64/iort.c                | 190 +++++++++++++++++++-----
 drivers/acpi/bus.c                       |   3 +
 drivers/irqchip/irq-gic-its-msi-parent.c |  43 +++---
 drivers/irqchip/irq-gic-v5-irs.c         | 246 ++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic-v5-its.c         | 132 ++++++++++++++++-
 drivers/irqchip/irq-gic-v5-iwb.c         |  42 ++++--
 drivers/irqchip/irq-gic-v5.c             | 138 ++++++++++++++---
 drivers/pci/msi/irqdomain.c              |  24 ++-
 include/acpi/actbl2.h                    |  56 ++++++-
 include/linux/acpi.h                     |   1 +
 include/linux/acpi_iort.h                |  11 +-
 include/linux/irqchip/arm-gic-v5.h       |   8 +
 include/linux/irqdomain.h                |  30 +++-
 include/linux/msi.h                      |   3 +-
 kernel/irq/irqdomain.c                   |  14 +-
 15 files changed, 784 insertions(+), 157 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251022-gicv5-host-acpi-d59d6c1d3d07

Best regards,
-- 
Lorenzo Pieralisi <lpieralisi@kernel.org>


