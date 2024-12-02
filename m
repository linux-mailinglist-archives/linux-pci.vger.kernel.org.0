Return-Path: <linux-pci+bounces-17523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BBF9E0303
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF42286E26
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59451FECAC;
	Mon,  2 Dec 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F53OC1q+"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47913AA35;
	Mon,  2 Dec 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145354; cv=none; b=DgpNxcDL7VaJIWftHOBpntBp2GMsfTVBjJ5vgCm6knH5qX/CQVVS5GrG+QzAZsENa8FZv47U7XPX70f0qbTLWpidP59gOSUwm04H3lXIasXiTm2PHnOwMoG17rdCYdFBYRzaw8m6fVcIiUKDsROZLwFus21AITXghRxdImQHGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145354; c=relaxed/simple;
	bh=vWSI2CHjakqbyX7H3hfU9AdEVtrHPGOtXn4c7h4wQHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AIL26tsPrfpKmG0TvvNyahE47Iqt2mBgX2n8B7AyVpNiGhL3ixYX4FAgBdJb0PIKksvtfqRSG9837No3Dg71gG6h8ibFXbBfTfmmLOJ/8uCKBUNJ60UASn8gjyeTivtrp1tByC/xpDZFwwKiUz7kVMR1rYiFzgi3heZ/91VdgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F53OC1q+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2C4F4C0004;
	Mon,  2 Dec 2024 13:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733145345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MQpaWI8uVHJ3ZvL8L9B5diSN1XNKR66nVeJZtMe04Mk=;
	b=F53OC1q+TuqKljlu3rIJ7rPM8ePsOIQISmkaVwbGuHYr1sc+/5dQMQuThGwq6qZsVMbyQ4
	0BtoCZdnDWtv8hkihT6nyac8Dr3ocYbAlz7duof0h4zHMdFmIXJdUJyGV8DvUpoJL2CaDK
	VS7V2ZozDFIJykviDDGD2CPpLbaoFbJt94GJhRCBA+xXbfz3U+6kR84yMT8X44L9LHr6ao
	CiILTROQjbe0LbQkqUc9UyEM/GT7RMOaUOTpWYZ7zyuMFiXymG2hL1RjtmOyHVzqqdIH5v
	H3A9YSWubin1yigofNv3/vyUgAxXay/NtrTvgqDuUxQu2MGhDNBWp/SdyPQf6g==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v4 0/6] Add support for the PCI host bridge device-tree node creation.
Date: Mon,  2 Dec 2024 14:15:12 +0100
Message-ID: <20241202131522.142268-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

This series adds support for creating a device-tree node for the PCI
host bridge on non device-tree based system.

Creating device-tree nodes for PCI devices and PCI-PCI bridges already
exists upstream. It was added in commit 407d1a51921e ("PCI: Create
device tree node for bridge"). Created device-tree nodes need a parent
node to be attached to. For the first level devices, on device-tree
based system, this parent node (i.e. the PCI host bridge) is described
in the base device-tree. The PCI bus related to this bridge (PCI root
bus) inherit of the PCI host bridge device-tree node.

The LAN966x PCI device driver, available since commit 185686beb464
("misc: Add support for LAN966x PCI device"), relies on this feature.

On system where the base hardware is not described by a device-tree, the
PCI host bridge to which first level created PCI devices need to be
attach to does not exist. This is the case for instance on ACPI
described systems such as x86.

This series goal is to handle this case.

In order to have the PCI host bridge device-tree node available even
on x86, this top level node is created (if not already present) based on
information computed by the PCI core. It follows the same mechanism as
the one used for PCI devices device-tree node creation.

As for device-tree based system, the PCI root bus handled by the PCI
host bridge inherit of this created node.

In order to have this feature available, a number of changes are needed:
  - Patch 1 and 2: Introduce and use device_{add,remove}_of_node().
    This function will also be used in the root PCI bus node creation.

  - Patch 3 and 4: Improve existing functions to reuse them in the root
    PCI bus node creation.

  - Patch 5: Set #address-cells and #size-cells in the empty device-tree
    root node.

  - Patch 6: The PCI host bridge device-tree node creation itself.

With those modifications, the LAN966x PCI device is working on x86 systems
and all device-tree kunit tests (including the of_unittest_pci_node test)
pass successfully with the following command:
  qemu-system-x86_64 -machine q35 -nographic \
    -kernel arch/x86_64/boot/bzImage --append console=ttyS0 \
    -device pcie-root-port,port=0x10,chassis=9,id=pci.9,bus=pcie.0,multifunction=on,addr=0x3 \
    -device pcie-root-port,port=0x11,chassis=10,id=pci.10,bus=pcie.0,addr=0x3.0x1 \
    -device x3130-upstream,id=pci.11,bus=pci.9,addr=0x0 \
    -device xio3130-downstream,port=0x0,chassis=11,id=pci.12,bus=pci.11,multifunction=on,addr=0x0 \
    -device i82801b11-bridge,id=pci.13,bus=pcie.0,addr=0x4 \
    -device pci-bridge,chassis_nr=14,id=pci.14,bus=pci.13,addr=0x0 \
    -device pci-testdev,bus=pci.12,addr=0x0

Compare to previous iteration, this v4 series has no changes but
patches have been rebased on top of v6.13-rc1.

Best regards,
Hervé Codina

Changes v3 -> v4
  v3: https://lore.kernel.org/lkml/20241114165446.611458-1-herve.codina@bootlin.com/

  Rebase on top of v6.13-rc1

  - Patches 1 to 6
    No changes

Changes v2 -> v3
  v2: https://lore.kernel.org/lkml/20241108143600.756224-1-herve.codina@bootlin.com/

  - Patch 5
    Fix commit log.
    Use 2 for #size-cells.

  - Patches 1 to 4 and 6
    No changes

Changes v1 -> v2
  v1: https://lore.kernel.org/lkml/20241104172001.165640-1-herve.codina@bootlin.com/

  - Patch 1
    Remove Cc: stable

  - Patch 2
    Remove Fixup tag and Cc: stable

  - Patches 3 and 4
    No changes

  - Patch 5
    Add #address-cells/#size-cells in the empty root DT node instead of
    updating default values for x86.
    Update commit log and commit title.

  - Patch 6
    Create device-tree node for the PCI host bridge and reuse it for
    the PCI root bus. Rename functions accordingly.
    Use "pci" instead of "pci-root" for the PCI host bridge node name.
    Use "res->start - windows->offset" for the PCI bus addresses.
    Update commit log and commit title.

Herve Codina (6):
  driver core: Introduce device_{add,remove}_of_node()
  PCI: of: Use device_{add,remove}_of_node() to attach of_node to
    existing device
  PCI: of_property: Add support for NULL pdev in of_pci_set_address()
  PCI: of_property: Constify parameter in of_pci_get_addr_flags()
  of: Add #address-cells/#size-cells in the device-tree root empty node
  PCI: of: Create device-tree PCI host bridge node

 drivers/base/core.c       |  52 +++++++++++++++++
 drivers/of/empty_root.dts |   9 ++-
 drivers/pci/of.c          |  98 +++++++++++++++++++++++++++++++-
 drivers/pci/of_property.c | 114 ++++++++++++++++++++++++++++++++++++--
 drivers/pci/pci.h         |   6 ++
 drivers/pci/probe.c       |   2 +
 drivers/pci/remove.c      |   2 +
 include/linux/device.h    |   2 +
 8 files changed, 277 insertions(+), 8 deletions(-)

-- 
2.47.0


