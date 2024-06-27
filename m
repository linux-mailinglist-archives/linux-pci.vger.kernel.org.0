Return-Path: <linux-pci+bounces-9359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C041791A255
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A288B21400
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A61386BF;
	Thu, 27 Jun 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P+Oq4cr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880C1304A2;
	Thu, 27 Jun 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479537; cv=none; b=bkeHvr3vvBe1ml7XdPYq+gGTKFyEs7ydRI8YcuDHX92GPHWwurO4wVWQkfUZcY0GGppgf0kNsn/S1zw9rZvNJ/NWEd18X4YOkn8KAd780D1aIOrpPklkkrogaUv0bdndcAxALMTO4hyjz/Sl/PKkkjDF2CcHs40/1ylq05betrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479537; c=relaxed/simple;
	bh=ceCSCQcyHfEOj3C0RHJnstJ5z6fHYexZxWf5gfQ3JiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RhYL4cNbTxlRCMtEoCncDch+/FRzrJf/+hmD4cF1LM3cQt+6vP8KY1UTVRw7QrqzPHbdgl+0O+ifLu9h5AvZ4DoWt6PiktOFv+nnNGDR5Lnc3XHOwL7wPOpm3sY2Rnh24d/qDOR0mwSI24PM/m0EWm49p6P7QqPLD+j0BqhOEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P+Oq4cr7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 68AFE20003;
	Thu, 27 Jun 2024 09:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719479526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NG0i74h+ixmJPsRUkY/tND9HuxPkBLpwimrmXoK0c+c=;
	b=P+Oq4cr7PFLC7+swrC0uH3WsMvqvUEOg7t2ChR+FoEGZoabTagiVZdiSFCDTm66VVYVPH9
	BHf4diTJrR1gcbfTlZYJYdAX5GF3+4w/WhiagJBQwnZ1AePP+pjGT/vQ377gOp4RE1S3Bi
	PyZoe8AUwCOrPop5t4zNhF9DR9TOEUsp//TyMk2SwDMmpJy40Ko4U6EL/yv278/+S7ORgU
	kSOoOxbAq69//lJh4Zxqb2Sb59mr+FEE5NxH5k3WmqJ1k5z2/RhCN3RWmEExWQS7UBK/ib
	KaV4IHb4c4bvRc3eWY157h8ozxroLBXTiQpDXL2hTF0CGCXqLa1CrAqWVbGQiA==
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	UNGLinuxDriver@microchip.com,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/7] Add support for the LAN966x PCI device using a DT overlay
Date: Thu, 27 Jun 2024 11:11:29 +0200
Message-ID: <20240627091137.370572-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
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

This series adds support for the LAN966x chip when used as a PCI
device.

For reference, the LAN996x chip is a System-on-chip that integrates an
Ethernet switch and a number of other traditional hardware blocks such
as a GPIO controller, I2C controllers, SPI controllers, etc. The
LAN996x can be used in two different modes:

- With Linux running on its Linux built-in ARM cores.
  This mode is already supported by the upstream Linux kernel, with the
  LAN996x described as a standard ARM Device Tree in
  arch/arm/boot/dts/microchip/lan966x.dtsi. Thanks to this support,
  all hardware blocks in the LAN996x already have drivers in the
  upstream Linux kernel.

- As a PCI device, thanks to its built-in PCI endpoint controller.
  In this case, the LAN996x ARM cores are not used, but all peripherals
  of the LAN996x can be accessed by the PCI host using memory-mapped
  I/O through the PCI BARs.

This series aims at supporting this second use-case. As all peripherals
of the LAN996x already have drivers in the Linux kernel, our goal is to
re-use them as-is to support this second use-case.

Therefore, this patch series introduces a PCI driver that binds on the
LAN996x PCI VID/PID, and when probed, instantiates all devices that are
accessible through the PCI BAR. As the list and characteristics of such
devices are non-discoverable, this PCI driver loads a Device Tree
overlay that allows to teach the kernel about which devices are
available, and allows to probe the relevant drivers in kernel, re-using
all existing drivers with no change.

This patch series for now adds a Device Tree overlay that describes an
initial subset of the devices available over PCI in the LAN996x, and
follow-up patch series will add support for more once this initial
support has landed.

In order to add this PCI driver, a number of preparation changes are
needed:

 - Patches 1 to 5 allow the reset driver used for the LAN996x to be
   built as a module. Indeed, in the case where Linux runs on the ARM
   cores, it is common to have the reset driver built-in. However, when
   the LAN996x is used as a PCI device, it makes sense that all its
   drivers can be loaded as modules.

 - Patches 6 and 7 introduce the LAN996x PCI driver itself, together
   with its DT bindings.

We believe all items from the above list can be merged separately, with
no build dependencies. We expect:

 - Patches 1 to 5 to be taken by reset maintainers

 - Patch 6 and 7 by the MFD maintainers

Additionally, we also believe all preparation items in this patch series
can be taken even before there's a final agreement on the last part of
the series (the MFD driver itself).

[1] https://lore.kernel.org/all/CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com/

Compare to the previous iteration:
  https://lore.kernel.org/lkml/20240614173232.1184015-1-herve.codina@bootlin.com/
this v3 series mainly:
  - Suppress patches as they were applied or extracted and handled in
    dedicated series.
  - Update the LAN966x PCI device driver.

Best regards,
Hervé

Changes v2 -> v3
  - Patches 1 and 5
    No changes

  - Patch 6 (v2 patch 18)
    Add a blank line in the commit log to split paragraphs
    Remove unneeded header file inclusion
    Use IRQ_RETVAL()
    Remove blank line
    Use dev_of_node()
    Use pci_{set,get}_drvdata()
    Remove unneeded pci_clear_master() call
    Move { 0, } to { }
    Remove the unneeded pci_dev member from the lan966x_pci structure
    Use PCI_VENDOR_ID_EFAR instead of the hardcoded 0x1055 PCI Vendor ID
    Add a comment related to the of_node check.

  - Patch 7 (v2 patch 19)
    No changes

  Patches removed in v3
    - Patches 6 and 7
      Extracted and sent separately
      https://lore.kernel.org/lkml/20240620120126.412323-1-herve.codina@bootlin.com/

    - Patches 9
      Already applied

    - Patches 8, 10 to 12
      Extracted, reworked and sent separately
      https://lore.kernel.org/lkml/20240614173232.1184015-1-herve.codina@bootlin.com/

    - Patches 13 to 14
      Already applied

Changes v1 -> v2
  - Patch 1
    Fix a typo in syscon.h (s/intline/inline/)

  - Patches 2..5
    No changes

  - Patch 6
    Improve the reset property description

  - Patch 7
    Fix a wrong reverse x-mass tree declaration

  - Patch 8 removed (sent alone to net)
    https://lore.kernel.org/lkml/20240513111853.58668-1-herve.codina@bootlin.com/

  - Patch 8 (v1 patch 9)
    Add 'Reviewed-by: Rob Herring (Arm) <robh@kernel.org>'

  - Patch 9 (v1 patch 10)
    Rephrase and ident parameters descriptions

  - Patch 10 (v1 patch 11)
    No changes

  - Patch 11 (v1 patch 12)
    Fix a missing ret value assignment before a goto in .probe()
    Limit lines to 80 columns
    Use indices in register offset definitions

  - Patch 13 and 14 (new patches in v2)
    Add new test cases for existing of_changeset_add_prop_*()

  - Patch 15 (v1 patch 14)
    No changes

  - Patch 16 (new patches in v2)
    Add tests for of_changeset_add_prop_bool()

  - Patch 17 (v1 patch 15)
    Update commit subject
    Rewrap a paragraph in commit log

  - Patch 18 (v1 patch 16)
    Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY

  - Patch 19 (v1 patch 17)
    No changes

Clément Léger (5):
  mfd: syscon: Add reference counting and device managed support
  reset: mchp: sparx5: Remove dependencies and allow building as a
    module
  reset: mchp: sparx5: Release syscon when not use anymore
  reset: core: add get_device()/put_device on rcdev
  reset: mchp: sparx5: set the dev member of the reset controller

Herve Codina (2):
  mfd: Add support for LAN966x PCI device
  MAINTAINERS: Add the Microchip LAN966x PCI driver entry

 MAINTAINERS                            |   6 +
 drivers/mfd/Kconfig                    |  24 +++
 drivers/mfd/Makefile                   |   4 +
 drivers/mfd/lan966x_pci.c              | 229 +++++++++++++++++++++++++
 drivers/mfd/lan966x_pci.dtso           | 167 ++++++++++++++++++
 drivers/mfd/syscon.c                   | 145 +++++++++++++++-
 drivers/pci/quirks.c                   |   1 +
 drivers/reset/Kconfig                  |   3 +-
 drivers/reset/core.c                   |   2 +
 drivers/reset/reset-microchip-sparx5.c |  11 +-
 include/linux/mfd/syscon.h             |  18 ++
 11 files changed, 593 insertions(+), 17 deletions(-)
 create mode 100644 drivers/mfd/lan966x_pci.c
 create mode 100644 drivers/mfd/lan966x_pci.dtso

-- 
2.45.0


