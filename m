Return-Path: <linux-pci+bounces-7861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D818D0815
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916DAB30CE6
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E929315FD19;
	Mon, 27 May 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gc1IA0Cc"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B915A848;
	Mon, 27 May 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826503; cv=none; b=hLQqwFRLWAiQ/QqaTOlSi2AjJntPWgBpka/kTl/8zO9e3akX7a8jNyaZlOdZbN8Nqz1M9moYfCpcaZrSySSljWO6n12PGNtyeO/XJn+wfgxE9xsAActGA7WZWqJpevh+51wtu7xZXiPXBrnBWEMKP6Svx/7GJ1M0xBJp5UACYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826503; c=relaxed/simple;
	bh=Nkv1p3ZENfKDlNqI+54nRq6lBXcqUNOi6P16n+/l/Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=izng8jtseC3s/xmCgTZxbrNndECWoJGqM7Nk1iU9assc5IRYzzStiYwzSD/1cdtMClBJcbZ+faRJbW9025frvY+t+SqH9hPhyXeij37OdeB38ztGxQbc259wH/M/PoddLtMwD8woc7yf75ytWSwlfBPDMfp4hkS/78SW0mCpFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gc1IA0Cc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5B2DFFF80F;
	Mon, 27 May 2024 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W3Mdy4D5AfzKGYOQg2kvPo1SG7babkD1Hg9+fJZbynE=;
	b=Gc1IA0CcOaRQqvwBfyHOehrLkpRypTguANF5LYaSAFixeGPUpjMUucqkEoBEPTi7aziWgP
	K9PcQPainBGBKYLuFTOOIL+2UUvheA1dL/40FQncHKIrUvKQ+mYipIWJw86bBPNEtKklSZ
	r80033wBXkDwiaCJ36e0sr61X51Eq28l165w83O/X4mGz8tZiZlOCJK/DfUaARL6pESi2Y
	RHFI3n+TBmoW4RfT9Tk2vdJEgiecDvw2Kp8uZT/w1T8+dqy1Ud4peDQrCrAUXJX31baWpT
	UNGjuE4F6FAEDz0RDzn0FSuxcFBH+ZPNJT0DDT709saNHPfk/am7OA5GgUmNdQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
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
Subject: [PATCH v2 00/19] Add support for the LAN966x PCI device using a DT overlay
Date: Mon, 27 May 2024 18:14:27 +0200
Message-ID: <20240527161450.326615-1-herve.codina@bootlin.com>
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

 - Patches 6 and 7 improve the MDIO controller driver to properly
   handle its reset signal.

 - Patches 8 to 12 introduce the internal interrupt controller used in
   the LAN996x. It is one of the few peripherals in the LAN996x that
   are only relevant when the LAN996x is used as a PCI device, which is
   why this interrupt controller did not have a driver so far.

 - Patches 13 to 16 make some small additions to the OF core and
   PCI/OF core to consider the PCI device as an interrupt controller.
   This topic was previously mentioned in [1] to avoid the need of
   phandle interrupt parents which are not available at some points.

 - Patches 17 and 18 introduce the LAN996x PCI driver itself, together
   with its DT bindings.

We believe all items from the above list can be merged separately, with
no build dependencies. We expect:

 - Patches 1 to 5 to be taken by reset maintainers

 - Patches 6 and 7 to be taken by network driver maintainers

 - Patches 8 to 12 to be taken by irqchip maintainers

 - Patch 13 to 17 to be taken by DT/PCI maintainers

 - Patch 18 and 19 by the MFD maintainers

Additionally, we also believe all preparation items in this patch series
can be taken even before there's a final agreement on the last part of
the series (the MFD driver itself).

[1] https://lore.kernel.org/all/CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com/

Compare to the previous iteration:
  https://lore.kernel.org/lkml/20240430183301.46568e35@bootlin.com/
this v2 series mainly:
  - Adds tests for of_changeset_add_prop_*() function family
  - Fixes typos, coding style and doc descriptions
  - Fixes a missing ret value assignment in the OIC .probe()
  - Uses indices in the OIC register definition
  - Removes Patch 8 (sent alone to net)
  - Rebases on top of v6.10-rc1

Best regards,
Hervé

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

Herve Codina (14):
  dt-bindings: net: mscc-miim: Add resets property
  net: mdio: mscc-miim: Handle the switch reset
  dt-bindings: interrupt-controller: Add support for Microchip LAN966x
    OIC
  irqdomain: Add missing parameter descriptions in docs
  irqdomain: Introduce irq_domain_alloc() and irq_domain_publish()
  irqchip: Add support for LAN966x OIC
  MAINTAINERS: Add the Microchip LAN966x OIC driver entry
  of: dynamic: Constify parameter in
    of_changeset_add_prop_string_array()
  of: unittest: Add tests for changeset properties adding
  of: dynamic: Introduce of_changeset_add_prop_bool()
  of: unittest: Add a test case for of_changeset_add_prop_bool()
  PCI: of_property: Add interrupt-controller property in PCI device
    nodes
  mfd: Add support for LAN966x PCI device
  MAINTAINERS: Add the Microchip LAN966x PCI driver entry

 .../microchip,lan966x-oic.yaml                |  55 ++++
 .../devicetree/bindings/net/mscc,miim.yaml    |  11 +
 MAINTAINERS                                   |  12 +
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-lan966x-oic.c             | 308 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  24 ++
 drivers/mfd/Makefile                          |   4 +
 drivers/mfd/lan966x_pci.c                     | 229 +++++++++++++
 drivers/mfd/lan966x_pci.dtso                  | 167 ++++++++++
 drivers/mfd/syscon.c                          | 145 ++++++++-
 drivers/net/mdio/mdio-mscc-miim.c             |   8 +
 drivers/of/dynamic.c                          |  27 +-
 drivers/of/unittest.c                         | 166 ++++++++++
 drivers/pci/of_property.c                     |  24 ++
 drivers/pci/quirks.c                          |   1 +
 drivers/reset/Kconfig                         |   3 +-
 drivers/reset/core.c                          |   2 +
 drivers/reset/reset-microchip-sparx5.c        |  11 +-
 include/linux/irqdomain.h                     |  16 +
 include/linux/mfd/syscon.h                    |  18 +
 include/linux/of.h                            |   5 +-
 kernel/irq/irqdomain.c                        | 118 +++++--
 23 files changed, 1323 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
 create mode 100644 drivers/irqchip/irq-lan966x-oic.c
 create mode 100644 drivers/mfd/lan966x_pci.c
 create mode 100644 drivers/mfd/lan966x_pci.dtso

-- 
2.45.0


