Return-Path: <linux-pci+bounces-16782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBE19C912A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E27EB46863
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C54F18D62D;
	Thu, 14 Nov 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ap37S00P"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98009188713;
	Thu, 14 Nov 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603303; cv=none; b=rzMw/LqKu43Z6nIt2txWbzIZ7Eta0mECsrm0ewDketfBHhzteXgthj1JX38VMhmNH0WqqIx24ktQqDXttCVFstpmIqUmA821LVGoPqiuUbQDhJfuXY4lHyP9qPISVQFVpdv+CXmO7r1hlh6FQO8BYdQ86Ec6lhwoJMd24ygwwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603303; c=relaxed/simple;
	bh=S8Lb7hps0g/gDVO3JIOZvrHBJFRQq2V4LVvCU1kzv6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bu5bIifvXKJRGoYcBiaf4l9pDond3VVdBe0M+4qB6iP3Ik5WiXs0NniWDwUIP431g6PBoJcAm2RWXKuRj0Iyt0rNUhZ3u79TaIjj/otTpG7xT34jFZ0++HTBHHms96k/ocFcpzRs9k1vWHq3raP+1nHMcEYh5c6W3RQkHtM253I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ap37S00P; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C4E4FE000A;
	Thu, 14 Nov 2024 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731603292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nyDG5q7w2xEPN0oIrCDvQSDGLlnU08uwmwLzPZKQe04=;
	b=ap37S00PYAzc8IMzU00Ufp3ZOxNlO1CS0dS/U1mkVceQtL9gnw4vSB3xwFvK6LUswMfPzX
	S4LbSbfPU0lX+Z9bOiTAGpCtrr+XFwDDczEdGEiDMjjobmpzXUljqNe2q/NwfAGLYNC+V1
	w+KWFV/Li0bn/3U8rYyzpaKTGnyliVUU6JU9VFxOS8ZeTh5bf+A3ZwqfBGcmJ/miFpOw3g
	C2BPmxdeQ4NydQUW1Ohyd7gVftM/Z0r6N7zzzZe4Ow5Nv1HbcCdUlLZwFUco4+w2upPlv3
	ax0QIkR7OPFbDS1V1ZQFXkIiDFwu933VWa5m8Px3iUDxj1veol4Ot3hzOvqmjw==
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
Subject: [PATCH v3 0/6] Add support for the PCI host bridge device-tree node creation.
Date: Thu, 14 Nov 2024 17:54:36 +0100
Message-ID: <20241114165446.611458-1-herve.codina@bootlin.com>
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

The LAN966x PCI device driver was recently accepted [1] and relies on
this feature.

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

[1] https://lore.kernel.org/lkml/7512cbb7911b8395d926e9e9e390fbb55ce3aea9.camel@pengutronix.de/

Compare to previous iteration, this v3 series fixes patch 5 commit log
and sets #size-cells to 2 in the empty root DT node.

Best regards,
Hervé Codina

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


