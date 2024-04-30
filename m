Return-Path: <linux-pci+bounces-6844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC82E8B6CED
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A49B20C25
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846BF1272D5;
	Tue, 30 Apr 2024 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OYa1XQLH"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4E1272C6;
	Tue, 30 Apr 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466346; cv=none; b=W8bNKUR+E0+BZIBKnAb7f2WVypYVH/UfeLd+yQwc+ACeEFTRFbqiAg1ShBFAphbtHgDcplWu808sO69a/eatH0RU3suU8/W16R6McpbLd1EtnesCFGQoZKKzpUaj7vyGeUQiIjaMvMUN8q5DBkSsBJoern9x8G/ZxG9ZK4ZA/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466346; c=relaxed/simple;
	bh=tGouIIMweCCg8lFI1k5a8Nmi7sj3tVWhoXa+yZ9Svjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jj6VVhcz2cadv7ILySFj1cGMuFcYhBldXrvX5K4K10awAS8pqJ0e2yQUigxS8uS5KfxHirmoqt+AFr8AAxTu3onOgO8RBKA3azh38s6IwZgNqG1VRYT1XfTYx8nvhhz3A0a9oSHqWalKH2vQbN+FXV9c/ZLFlR3MDX/3BW7/TmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OYa1XQLH; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6105720013;
	Tue, 30 Apr 2024 08:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1z1r8qP3wTyMtexbriJIq+WvlcDHX0KVVkOb8SF0acI=;
	b=OYa1XQLHVHnDfDXtIRKkfKPMke4wZr/J4u5RQY/BSrxG8sI2nJ5TVTYix2l+xnjMM9nfKT
	pUxdnTN/p7g90fsmFxCbPTezHmyDoXUwDdolMNTjhltSK2wkmedl8tOK9Rf96fdVNlX019
	wDbq1dKt8FvjC2+O+Qff0nHwWUxnJ0NXrvCuYGLu1l+iNGv+LC0LVBkYXX7QQuwcApbFZ1
	IZiMGwncytElcKLvDfwGr++lXQ6TGOHaCtnGokFAn145nzBS5/ezLhbZNnyHvfV10dJbmK
	7GA0BLpt30XtoYDlxmcXZDYIIpcuHr7tLjrGwZlFlkZJ8S3vDlEuTA2DBBXaHA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 00/17] Add support for the LAN966x PCI device using a DT overlay
Date: Tue, 30 Apr 2024 10:37:09 +0200
Message-ID: <20240430083730.134918-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
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

 - Patches 6 and 7 improve the MDIO controller driver to properly
   handle its reset signal.

 - Patch 8 fixes an issue in the LAN996x switch driver.

 - Patches 9 to 13 introduce the internal interrupt controller used in
   the LAN996x. It is one of the few peripherals in the LAN996x that
   are only relevant when the LAN996x is used as a PCI device, which is
   why this interrupt controller did not have a driver so far.

 - Patches 14 and 15 make some small additions to the OF core and
   PCI/OF core to consider the PCI device as an interrupt controller.
   This topic was previously mentioned in [1] to avoid the need of
   phandle interrupt parents which are not available at some points.

 - Patches 16 and 17 introduce the LAN996x PCI driver itself, together
   with its DT bindings.

We believe all items from the above list can be merged separately, with
no build dependencies. We expect:

 - Patches 1 to 5 to be taken by reset maintainers

 - Patches 6, 7 and 8 to be taken by network driver maintainers

 - Patches 9 to 13 to be taken by irqchip maintainers

 - Patch 14/15 to be taken by DT/PCI maintainers

 - Patch 16/17 by the MFD maintainers

Additionally, we also believe all preparation items in this patch series
can be taken even before there's a final agreement on the last part of
the series (the MFD driver itself).

[1] https://lore.kernel.org/all/CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com/

Best regards,
Hervé

Clément Léger (5):
  mfd: syscon: Add reference counting and device managed support
  reset: mchp: sparx5: Remove dependencies and allow building as a
    module
  reset: mchp: sparx5: Release syscon when not use anymore
  reset: core: add get_device()/put_device on rcdev
  reset: mchp: sparx5: set the dev member of the reset controller

Herve Codina (12):
  dt-bindings: net: mscc-miim: Add resets property
  net: mdio: mscc-miim: Handle the switch reset
  net: lan966x: remove debugfs directory in probe() error path
  dt-bindings: interrupt-controller: Add support for Microchip LAN966x
    OIC
  irqdomain: Add missing parameter descriptions in docs
  irqdomain: Introduce irq_domain_alloc() and irq_domain_publish()
  irqchip: Add support for LAN966x OIC
  MAINTAINERS: Add the Microchip LAN966x OIC driver entry
  of: dynamic: Introduce of_changeset_add_prop_bool()
  pci: of_property: Add the interrupt-controller property in PCI device
    nodes
  mfd: Add support for LAN966x PCI device
  MAINTAINERS: Add the Microchip LAN966x PCI driver entry

 .../microchip,lan966x-oic.yaml                |  55 ++++
 .../devicetree/bindings/net/mscc,miim.yaml    |   8 +
 MAINTAINERS                                   |  12 +
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-lan966x-oic.c             | 301 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  24 ++
 drivers/mfd/Makefile                          |   4 +
 drivers/mfd/lan966x_pci.c                     | 229 +++++++++++++
 drivers/mfd/lan966x_pci.dtso                  | 167 ++++++++++
 drivers/mfd/syscon.c                          | 145 ++++++++-
 .../ethernet/microchip/lan966x/lan966x_main.c |   6 +-
 drivers/net/mdio/mdio-mscc-miim.c             |   8 +
 drivers/of/dynamic.c                          |  25 ++
 drivers/pci/of_property.c                     |  24 ++
 drivers/pci/quirks.c                          |   1 +
 drivers/reset/Kconfig                         |   3 +-
 drivers/reset/core.c                          |   2 +
 drivers/reset/reset-microchip-sparx5.c        |  11 +-
 include/linux/irqdomain.h                     |  16 +
 include/linux/mfd/syscon.h                    |  18 ++
 include/linux/of.h                            |   3 +
 kernel/irq/irqdomain.c                        | 118 +++++--
 23 files changed, 1149 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
 create mode 100644 drivers/irqchip/irq-lan966x-oic.c
 create mode 100644 drivers/mfd/lan966x_pci.c
 create mode 100644 drivers/mfd/lan966x_pci.dtso

-- 
2.44.0


