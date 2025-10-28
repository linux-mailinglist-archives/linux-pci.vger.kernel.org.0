Return-Path: <linux-pci+bounces-39508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA062C140D2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 11:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0AC189A690
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E32DEA96;
	Tue, 28 Oct 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpCjauIF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE71E49F;
	Tue, 28 Oct 2025 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646751; cv=none; b=tg2ASk9wBOZlJLsKkpwKnAmTj08sL9Tb/imlUHPdjOF/Ui91F4vnfErYxw80IL7N/aPLTJlVvNduJbnVGpX/JvDyM0fJ2kuqxbRgpLvLgbqwnzWpYv3qbUxoQudwDblOH//P6MG+W+CHJrGVqI/wJYE9azarLg8hANfbK9bXSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646751; c=relaxed/simple;
	bh=rTsiu6Lg9PZhrtKUJKqwPQO26S58LDXJ57pUZwdY5ng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f+urHKzzSs/IGcC97T/3A4sjqUJZAbf1PVOVPA6Bgyfsainsx/JYA3y0gc50aZB2EFVBfolGqtxJ/vGbuxuhv1H+7vIiHta5NDPOrOb8wDk0cKupyhLY5eFJUnMhfBIOARmr7LCUo6Q4F7B4Ru+xDwg8jFf9J7VSEXuyOFnG9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpCjauIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3228C4CEE7;
	Tue, 28 Oct 2025 10:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761646750;
	bh=rTsiu6Lg9PZhrtKUJKqwPQO26S58LDXJ57pUZwdY5ng=;
	h=From:Subject:Date:To:Cc:From;
	b=fpCjauIFUkgpfgT171hCNQY/l4yDNErSco51dU7/5qdghLbuP22zvvc5Tm6IZrCIC
	 5anRaznpikHViYV1KfvO/wgw4T8WXN5odJead3jyN9MDiHyALSAhAoUPGGdM5DQfzv
	 I3pHRxCMUqCN2ZrQh1zMYHV9LIcex/MWeThdRRkIr/wMRjSCkc+30oSKXBUbKq/Q/7
	 Rdjpqhc8E+oYFlw1SN+KmoJhj+VMi2l+daVPvdFJi3uJ2RBf5eZmB03Q2EG3emAzvz
	 2Os6VzM3Ic24NgRJSwhqiNj/igG9k7bsPoPmAJFgA8CR5hMgJDW2EOkeEuVYI/Hvql
	 reD5AiDv50eMw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH not for merging 0/7] irqchip/gic-v5: Code first ACPI boot
 support
Date: Tue, 28 Oct 2025 11:18:58 +0100
Message-Id: <20251028-gicv5-host-acpi-v1-0-01a862feb5ca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKYAGkC/x3MQQqEMAxA0auUrA20HTqDXkVcSBNrFraSigji3
 S2zfIv/b6iswhUGc4PyKVVKbnCdgbjOOTEKNYO3PjjrPSaJZ8C11APnuAtS6OkbHX3I/qBVu/I
 i1/84Qi6HWYqajTVJTjA9zwvbbNIpcgAAAA==
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

The ACPI and ACPI IORT specifications are being updated to support bindings
required to describe GICv5 based systems.

The ACPI specification GICv5 bindings ECR [1] was published and now it is
going through the approval process to get it ratified.

The Arm IORT specification [2] has been updated to include GICv5 IWB
specific bindings in revision E.g.

Implement kernel code that - based on the aforementioned bindings - adds
support for GICv5 ACPI probing.

ACPICA changes supporting the bindings are posted with the series
to make it self-contained - they should not be considered for merging
(and consequently the kernel code as well is not ready to be upstreamed,
it is posted so that it can be reviewed ahead of spec ratification, we
are not expecting any major spec changes).

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
parallel with this series.

For PPI/SPI/LPI backed IRQs the probe dependency is not a problem because
in GICv5 systems the IRSes and ITSes probe early so their IRQ domain are
set in place before devices require IRQ mappings.

ACPICA patches are a Linuxised version of ACPICA GICv5 pull request [5] and
should not be considered for merging (ACPICA changes won't be finalized
until the ACPI specification is ratified), they are there so that the
kernel can map/parse GICv5 ACPI firmware data structures 

[1] https://github.com/tianocore/edk2/issues/11148
[2] https://developer.arm.com/documentation/den0049/eg
[3] https://github.com/LeviYeoReum/edk2/tree/levi/gicv5_patch
[4] https://github.com/LeviYeoReum/edk2-platforms/tree/levi/gicv5_patch
[5] https://github.com/acpica/acpica/pull/1043

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
Jose Marinho (2):
      ACPICA: Add GICv5 MADT structures
      ACPICA: Add Arm IORT IWB node definitions

Lorenzo Pieralisi (5):
      irqdomain: Add parent field to irqchip_fwid
      PCI/MSI: Make the pci_msi_map_rid_ctlr_node() interface firmware agnostic
      irqchip/gic-v5: Add ACPI IRS probing
      irqchip/gic-v5: Add ACPI ITS probing
      irqchip/gic-v5: Add ACPI IWB probing

 drivers/acpi/arm64/iort.c                | 190 +++++++++++++++++++-----
 drivers/acpi/bus.c                       |   3 +
 drivers/irqchip/irq-gic-its-msi-parent.c |  45 +++---
 drivers/irqchip/irq-gic-v5-irs.c         | 247 ++++++++++++++++++++++++-------
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
 15 files changed, 786 insertions(+), 158 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251022-gicv5-host-acpi-d59d6c1d3d07

Best regards,
-- 
Lorenzo Pieralisi <lpieralisi@kernel.org>


