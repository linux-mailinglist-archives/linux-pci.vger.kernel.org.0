Return-Path: <linux-pci+bounces-19618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449C1A08A11
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F7F3A8CA9
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6754C20898C;
	Fri, 10 Jan 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nGEi57sZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853E207E09;
	Fri, 10 Jan 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497611; cv=none; b=qUaSjL6x7sV/0zQzF/BBwbnltswY41tkifigjfbTO9kxqiBL72RHpOlrwDpKzxCdG6nq92d5V7WqPwby1dU+C9PaMZRNigUidEkpS+GYDzeVNjVHTstVpdad3cmwMq4oL1TavYyzDePRp9BlpHjSfUjoKo2OKpRtj2i7TIjtRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497611; c=relaxed/simple;
	bh=8iT/CGxqNYEqYQ8S645HB11lrNIMFUJ4tKGMU+hgkXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rcVpWF9QDR31tKrBNr8/4JhahbmYREp1pqSQDPyBfZ4XkyzdgezEr7AZDKmvyWuYtg77KBc0JNUbixQtmFmCrWfREhnLWMqMKMERAFTFdlYTcs7rRckS961yA1/u0uerHI28R6yquiCKo38HZsLLXhra4Dm6EJ1Y00Bic53WmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nGEi57sZ; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A1243C47F9;
	Fri, 10 Jan 2025 08:21:56 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPA id D2D9720003;
	Fri, 10 Jan 2025 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736497314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KNe0gefFKBFIwU4dgG9OeQZfa+i4R5oJpGtPJS6WYvE=;
	b=nGEi57sZdauzAOIXOFT7pr6Ast6QQ2qDVVZirGwu5NgjK8INFicO26zNgtwOd0vGaQfRc7
	oZNnUxk/G+T3GRLPouurVwcPJO3a8kXjvrzdXe10l7y5K71mKJkftGDkd35XDQzspcQqMo
	cSYv86nPxw0aOAriUejS652P2bykWKLMonN5eHO+9yboUufTt8Nsh5epgco89CiK4muKCx
	Xl0LOrTecMkt2AKkO3Ki+1ISXVfqM51zZOENy21qs0PWIrPDCK12TFySquRmfqcM9WL0+E
	iD8ydVNj5aK1gJaes0BGpZdoQkQCCFPZB7pY4cxcogQqZXCI6rI6mE7sDXukYw==
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
Subject: [PATCH v6 0/5] Add support for the PCI host bridge device-tree node creation.
Date: Fri, 10 Jan 2025 09:21:36 +0100
Message-ID: <20250110082143.917590-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
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

  - Patch 5: The PCI host bridge device-tree node creation itself.

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

Compare to previous iteration, this v6 series:
  - Add a return error code in device_add_of_node()
  - Handle this error code in device_add_of_node() callers

Best regards,
Hervé Codina

Changes v5 -> v6
  v5: https://lore.kernel.org/lkml/20241209130339.81354-1-herve.codina@bootlin.com/

  - Patch 1
    Add a return error code in device_add_of_node()

  - Patches 2 and 5
    Handle the device_add_of_node() error code

  - Patches 3 and 4
    No changes

Changes v4 -> v5
  v4: https://lore.kernel.org/lkml/20241202131522.142268-1-herve.codina@bootlin.com/

  - Patch 1
    Use dev_warn() instead of WARN()

  - Patches 2 to 4
    No changes

  - Patch 5 (v4 patch 6)
    Use dev_err()
    Fix a typo in commit log

  Patch removed in v5
    - Patch 5 in v4
      Already applied

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

Herve Codina (5):
  driver core: Introduce device_{add,remove}_of_node()
  PCI: of: Use device_{add,remove}_of_node() to attach of_node to
    existing device
  PCI: of_property: Add support for NULL pdev in of_pci_set_address()
  PCI: of_property: Constify parameter in of_pci_get_addr_flags()
  PCI: of: Create device-tree PCI host bridge node

 drivers/base/core.c       |  61 ++++++++++++++++++++
 drivers/pci/of.c          | 115 +++++++++++++++++++++++++++++++++++++-
 drivers/pci/of_property.c | 114 +++++++++++++++++++++++++++++++++++--
 drivers/pci/pci.h         |   6 ++
 drivers/pci/probe.c       |   2 +
 drivers/pci/remove.c      |   2 +
 include/linux/device.h    |   2 +
 7 files changed, 295 insertions(+), 7 deletions(-)

-- 
2.47.1


