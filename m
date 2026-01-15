Return-Path: <linux-pci+bounces-44923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B908FD23B5C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE99302F824
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679C35F8A1;
	Thu, 15 Jan 2026 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzIJoWu6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229E35EDA0;
	Thu, 15 Jan 2026 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470669; cv=none; b=XUDBL9v7PWbi4DrF+99K8F9HrcaJkF5jkfjOsvaKUc46sdnFMn1RAnYEGw1zfhNxjGQfXINsO05z9OSHVZgnaQF/ViIT4oqjcMnQn49zEgOIDx8Ar6BKLixpalQIpXrQBHA3wGvAL9uy1JrdhFSnFCimU/7OlZe0hcqrX0V3eFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470669; c=relaxed/simple;
	bh=pRUo4IfxKSIdmqxfjlq5gep3aUZS10dP72qqvU6sP+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RP5h+2Xaw/3w3US6zRq0hbjASIpCEiHPopDhHPxdt5YJ8mgGd6yOiXl22Oce9+msxMNia9C9ViLO0R4+M+7uDtnPy7lDr6WqUzCwlm6/ZmS0WTfN5WOXPdJnmXZzOXCU2p/idRl8EcKSZmiT60v4oeE0dIYxCRZFXNterEcFL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzIJoWu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3C1C116D0;
	Thu, 15 Jan 2026 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470669;
	bh=pRUo4IfxKSIdmqxfjlq5gep3aUZS10dP72qqvU6sP+k=;
	h=From:Subject:Date:To:Cc:From;
	b=HzIJoWu6DQj06GQph5RB+kUjQyIrbkLnNGn26cDf5NdD8j+0RNIrOScndC0SyvYor
	 l7+sVNrsv6eEJN1LpsWDgOOPOC9HjuMvH74m+uW9pXTPqpQq9H48f1Ak50zHwJ+APw
	 GII9f1zjX46qSFcpdxKVHscq05XSQYCNDknbVKgy8cqnZ9HaP+AYq4xZH16R4WAlfM
	 GXxr/zB8BOIcWndxZJM26VIZSgtImg6Jwbom5E0hDw18NNpLcMMpC1SD+NoooSeZKR
	 lEZ6g95O6Z1HPxQclKxEhgtjogNnVusxksq0VhBNKBkI4+vsB7YHx7/uazqby4cGzM
	 nXu7E4ucjcOkQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v3 0/6] irqchip/gic-v5: Code first ACPI boot support
Date: Thu, 15 Jan 2026 10:50:46 +0100
Message-Id: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHe4aGkC/23PTU7DMBAF4KtEXuPInuL8CaFKPQBiC2LhjCeJK
 YlbOxiqqnfHSYUQguUbab6Zd2aBvKXAmuzMPEUbrJtS2NxkDAc99cStSZmBACUFAO8tRsUHF2a
 u8WC5UbUpUJqNESVLWwdPnf1cxeeXlAcbZudP64Eol+m3Vf2xouSCC6mrAjpqFertnvxEb7nzP
 VuwCD8AyH8ASAARlgUaaW5F+wu4XN/zdHxPPefrj2ykEPTas8nuJFQAic4falcWTyY+7rZedzo
 Rr/nHKTjc2/ulZqsDcXTjaOcmi0Uua+5RpRuXL1I6CLhTAQAA
X-Change-ID: 20251022-gicv5-host-acpi-d59d6c1d3d07
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.14.3

The ACPI and ACPI IORT specifications were updated to support bindings
required to describe GICv5 based systems.

The ACPI specification GICv5 bindings ECR [1] were approved and the
required changes merged in the ACPICA upstream repository[5].

The Arm IORT specification [2] has been updated to include GICv5 IWB
specific bindings in revision E.g.

Implement kernel code that - based on the aforementioned bindings - adds
support for GICv5 ACPI probing.

ACPICA changes supporting the bindings were posted [6] - this series
depends on [6] to work and should not be merged stand alone.

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

[1] https://github.com/tianocore/edk2/issues/11148
[2] https://developer.arm.com/documentation/den0049/eg
[3] https://github.com/LeviYeoReum/edk2/tree/levi/gicv5_patch
[4] https://github.com/LeviYeoReum/edk2-platforms/tree/levi/gicv5_patch
[5] https://github.com/acpica/acpica/commits/master/
[6] https://lore.kernel.org/linux-acpi/12822121.O9o76ZdvQC@rafael.j.wysocki/

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
Changes in v3:
- Dropped ACPICA patches
- Split IRS OF refactoring into a separate patch
- Renamed new fwnode interface according to review
- Applied minor review comments
- Rebased on v6.19-rc5
- Link to v2: https://lore.kernel.org/r/20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org

Changes in v2:
- Cherry-picked ACPICA upstream changes
- Minor editorial changes
- Removed the "not for merging" tag because now ACPI specs are approved
- Rebased against v6.19-rc1
- Link to v1: https://lore.kernel.org/r/20251028-gicv5-host-acpi-v1-0-01a862feb5ca@kernel.org

---
Lorenzo Pieralisi (6):
      irqdomain: Add parent field to struct irqchip_fwid
      PCI/MSI: Make the pci_msi_map_rid_ctlr_node() interface firmware agnostic
      irqchip/gic-v5: Split IRS probing into OF and generic portions
      irqchip/gic-v5: Add ACPI IRS probing
      irqchip/gic-v5: Add ACPI ITS probing
      irqchip/gic-v5: Add ACPI IWB probing

 drivers/acpi/arm64/iort.c                | 193 +++++++++++++++++++-----
 drivers/acpi/bus.c                       |   3 +
 drivers/irqchip/irq-gic-its-msi-parent.c |  43 +++---
 drivers/irqchip/irq-gic-v5-irs.c         | 247 ++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic-v5-its.c         | 132 ++++++++++++++++-
 drivers/irqchip/irq-gic-v5-iwb.c         |  42 ++++--
 drivers/irqchip/irq-gic-v5.c             | 138 ++++++++++++++---
 drivers/pci/msi/irqdomain.c              |  23 ++-
 include/linux/acpi.h                     |   1 +
 include/linux/acpi_iort.h                |  11 +-
 include/linux/irqchip/arm-gic-v5.h       |   8 +
 include/linux/irqdomain.h                |  30 +++-
 include/linux/msi.h                      |   3 +-
 kernel/irq/irqdomain.c                   |  14 +-
 14 files changed, 734 insertions(+), 154 deletions(-)
---
base-commit: d0e305301e82474223bf26185e86e7dc2eb85350
change-id: 20251022-gicv5-host-acpi-d59d6c1d3d07
prerequisite-message-id: <12822121.O9o76ZdvQC@rafael.j.wysocki>
prerequisite-patch-id: 9f722bfc7e4861af40637017a83826401b3958e4
prerequisite-patch-id: f619b4724a25a5c2b95032ef4c6d0b53dde45142
prerequisite-patch-id: 3738d015d93d77b3d381ba8de056be533df48794
prerequisite-patch-id: 50b1ee01b2ee63f6db21276ec24dadd645f8931e
prerequisite-patch-id: 6671f1c96dc89d5e375196e545c9750c2378f010
prerequisite-patch-id: b5d91dce8f61ab75796ba6a766d499d7321c0231
prerequisite-patch-id: 1f433eeb8848ce51c2b2fe601813939a042c6c0e
prerequisite-patch-id: 4f9aab64e4f4a75c18ae692bd903266069100d34
prerequisite-patch-id: 793a7b3fab40b903ffa0855e0db5336acb69505b
prerequisite-patch-id: 3eeebe1df8abadc1606cc6dadd15031ad46ff64f
prerequisite-patch-id: 3477bb220e91c9cdb4d778ce15e44babbefddf23
prerequisite-patch-id: 153be22f930d0c05bc04b37006bdb1e286883a92
prerequisite-patch-id: 1a7dcfd7e1317aeec52c772f3150c115e965af52
prerequisite-patch-id: 43a604c0109163e51a892d888c728794bca8a0a3
prerequisite-patch-id: 580debc0f26b7c301160504e2360de6765e7a179
prerequisite-patch-id: 15f2c86c557c835e4aed0cb914c23e04da1392ed
prerequisite-patch-id: 00986721db8da2e52c733971b482b9cf0c32910e
prerequisite-patch-id: 9d0607df90015bac8768549cbb0a19580f0b2661
prerequisite-patch-id: f478f56f3ded4d0ce43254418deb5e10f49555ef
prerequisite-patch-id: 6f9563683e92392564935f24cc5e8be23301790c
prerequisite-patch-id: 4d701f77a597391e0d04c5da3d6f1cb24d1e40d0
prerequisite-patch-id: d70577c2355648acbc7c857c5512df21280e917f
prerequisite-patch-id: 8c6408293baa1a758b0b0b4f078eaf7dbe1404e0
prerequisite-patch-id: 84008a72aa67b54af8a294a0fc07d2b6eaede597
prerequisite-patch-id: 97acab35d513bc6b091efa4185a9826262d5ed79
prerequisite-patch-id: 04652a3bfdf9f4fa2ba829631c899ea3569f11a2

Best regards,
-- 
Lorenzo Pieralisi <lpieralisi@kernel.org>


