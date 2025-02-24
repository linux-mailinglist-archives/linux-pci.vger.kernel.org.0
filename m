Return-Path: <linux-pci+bounces-22205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16DA4229C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E5A7A323C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F07714D28C;
	Mon, 24 Feb 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TR0Nj59G"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA713A244;
	Mon, 24 Feb 2025 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406450; cv=none; b=GKiJgvwtApwy/Wsi6YsM/QVvCCz4qi+Tm16X8PjRvXnZn6NE50x0XB2iCIXZmAN2w1ctd1kifz4M6+WRZsuN1TWRmJiESf+iDU/vr44nSwLQ4xyD+BRX/tdxeeNkDSENFzpiN94C80OBzLqMcyakA39fiiEobmQIszBA8V7+LbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406450; c=relaxed/simple;
	bh=MAIljGRKHpX+sBKWfPnuoXRZW0de6uzykouYkUcKOts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dhudFdAt+F1SAz6SmNAQflU7CsDwZjK+t1VEJoxmKxU5Jpv9lHqeQrP0f/FQyFGSgL4449rzL3Wf+PK+2d5n4tBi154dZ6vn4WEQbMsgqSztHJOvlsTIltI8+gSIlQDvsjc417LdZWaj8EsOoOrtHTlbrhZOs0VVx6mUsvcDeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TR0Nj59G; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 576B044260;
	Mon, 24 Feb 2025 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740406446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWKVIYSHPKMMFYPuu+WSrGUjM6GtyamEf9C8lY3j5RQ=;
	b=TR0Nj59GIAcemobmsQf3opryoETFqFRrOqU0tltsNxXokjNucpqVFRdZAd6EcCYZXai6PM
	nVW5NeQqcgm/Aco/N5fktauUsu5y+PzuDRhO5mDt9QNy4dM41UemQnJj0YcvoOFHI9h+Ni
	EBK0wgGPILXcSssftiA0bac5XOMDBWD168Bd8FDaYbyYWPsJIbgtIdCTFbHPJ2kSEJtOF3
	EpgMe/m2wPJlJoyvua6FH7y4kkHXP4pPIrtpJopoFPw1jqKqNJf57SXYk0YghGUBDeJJWB
	xfrTVauyxwm2vrh3wKqqnf63fXOF+FqmKmMdtVAuGv4VA4giRyGLnw20wwTEGA==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
Subject: [PATCH v8 0/5] Add support for the PCI host bridge device-tree node creation.
Date: Mon, 24 Feb 2025 15:13:50 +0100
Message-ID: <20250224141356.36325-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleetudffledtvddtffegudfgjeffgeegkeehjeeigffgieevhfekffehheehieeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgo
 hhoghhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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

Compare to previous iteration, this v8 series mainly improves a commit
log.

Best regards,
Hervé Codina

Changes v7 -> v8
  v7: https://lore.kernel.org/lkml/20250204073501.278248-1-herve.codina@bootlin.com/

  - Patch 1
    Add 'Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>'
    Add 'Reviewed-by: Rob Herring (Arm) <robh@kernel.org>'

  - Patch 2, 3, 4
    Add 'Reviewed-by: Rob Herring (Arm) <robh@kernel.org>'

  - Patch 5
    Improve commit log adding a high level part outlining the benefit of
    changes.
    Add 'Reviewed-by: Rob Herring (Arm) <robh@kernel.org>'

Changes v6 -> v7
  v6: https://lore.kernel.org/lkml/20250110082143.917590-1-herve.codina@bootlin.com/

  Rebase on top of v6.14-rc1

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
2.48.1


