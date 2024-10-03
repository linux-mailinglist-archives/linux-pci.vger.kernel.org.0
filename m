Return-Path: <linux-pci+bounces-13753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0E98EB52
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 10:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B671C20E64
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6BF137923;
	Thu,  3 Oct 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fBemfihI"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88710A1E;
	Thu,  3 Oct 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943479; cv=none; b=gLKpRHNzfH7mA/msGmeJXwZCtLqPTK93oq4ZCs6P/2i2sLFVtLSWulTjRtXDQ9zU98XxNCfes3Q39pZ0zd8I1wcmyAnih1YBRDKqW0s6/WXO03HpdXBkhgXfE2i3ImPoewk6dmMk926xYJ1Ep9DZ51Wq4/X3hvpt5lZJgcIztiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943479; c=relaxed/simple;
	bh=ZXzClI64uZKzurCYKQPW9rVg6HGvMO4FOjxDAyEWI2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyKLl5xggYVSw68N5Kq08X3RBPc4l4R7YEFn7x9jW4lRLXO0lb/qJyhamtGHPZ+yEQDZqA0nQrOhrgPwjoRfvxtZnssdOVzvXFlQUwwUITtvxHhOFPxFw/mnS0Dnk52hhlp8OriKN8HpTgni1flem4p8+5wfZ6vKriIiGVA9wDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fBemfihI; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8F30AE0009;
	Thu,  3 Oct 2024 08:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727943474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2UaNmS6xTczFvj5giaUw0inHxG9R/Dlh790DYEo0DRQ=;
	b=fBemfihIgfkNAnJw5+TxGGLwaNX+Gu+MpIvteQpSsPmYbHnB3DRRx4ZjAEoydZnQ69H7Gq
	xXlJ04KoB2TVp/OaCtYUUABcX1RlW/zTWxcuZiHZzzGDW8v/x1+4nCsLfe+k1ppRM243NO
	998RMhFwEEy2YdwampvweILJwdETEu1onouGqqcX5Pb2aqS94STFDV0TpOctp3OD0v9TNI
	bre8oxALoboETTNcxmtCqky7a3SOo2FomuNuALdqG00MJWIXICKslV0sNJA3g1TlRQw8mO
	e+KxBYDJGXEQ7YRLCdf2VrGXxSPWoKtqCg6ufNHss2fszvdE+y4pJA6roFSQDg==
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 0/6] Add support for the LAN966x PCI device using a DT overlay
Date: Thu,  3 Oct 2024 10:16:37 +0200
Message-ID: <20241003081647.642468-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
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
reuse them as-is to support this second use-case.

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

In order to add this PCI driver, a number changes are needed:
 - Patches 1 and 2 introduce the LAN996x PCI driver itself, together
   with its DT overlay and the related MAINTAINER entry.

 - Patch 3 removes the syscon API usage from the reset driver used for
   the LAN966x.

 - Patches 4 to 7 allow the reset driver used for the LAN996x to be
   built as a module. Indeed, in the case where Linux runs on the ARM
   cores, it is common to have the reset driver built-in. However, when
   the LAN996x is used as a PCI device, it makes sense that all its
   drivers can be loaded as modules.

Compare to the previous iteration:
  https://lore.kernel.org/lkml/20240930121601.172216-1-herve.codina@bootlin.com/
this v7 series mainly:
  - Remove the patch modifying the reset controller DT binding
  - Re-order patches
  - Remove the syscon API usage from the LAN966x reset controller (the
    only syscon user).

Best regards,
Hervé

Changes v6 -> v7
  - Patch 1 (patch 3 in v6)
    Re-introduce the syscon node in the overlay

  - Patch 2 (patch 4 in v6)
    No changes

  - Patch 3 (patch 2 in v6)
    Rework code to map the syscon device locally without using the
    syscon API in the LAN966x case.
    Update commit log

  - Patches 4, 5 and 6 (patches 5, 6, and 7 in v6)
    No changes

  Patch removed in v7
    - Patch 1 in v6 (reset controller DT binding modification)
      Rejected

Changes v5 -> v6
  - Patch 1
    New patch in v6 relatead to removing syscon usage.

  - Patch 2
    New patch in v6 related to removing syscon usage.

  - Patch 3 (patch 1 in v5)
    Add 'Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>'
    Remove syscon node from the overlay.

  - Patch 4, 5, 6 and 7 (patches 2, 4, 5 and 8 in v5)
    No changes

  Patches removed in v6
    - Patch 3 in v5
      Rejected

    - Patch 6 in v5
      No more applicable

    - Patch 7 in v5
      Already applied

Changes v4 -> v5
  - Patch 1
    Add missing include files and keep pci_ids.h.
    Remove IRQ_RETVAL() usage.
    Use __free().
    Remove the pdev->irq check.
    Avoid local variables in devm_pci_dev_remove_intr_ctrl() and
    lan966x_pci_load_overlay().
    Use dev_err_probe().
    Sort header includes in alphabetical order in dtbs file.

  - Patch 3
    Fix a typo in commit log.
    Simplify modification done in device_node_get_syscon().
    Use devm_add_action_or_reset().

  - Patches 4, 5, 6 and 8
    Add 'Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>'

Changes v3 -> v4
  - Patch 1 and 2 (v3 patch 6 and 7)
    Move the driver from drivers/mfd to drivers/misc.

  - Patch 4 and 5 (v3 patch 2)
    Rework reset driver dependencies and module building support.
    Split v3 patch into two distinct patches:
      - patch 4, as suggested by Geert, add a dependency on the
        LAN966x PCI device
      - patch 5, allows to build the reset controller driver as a module

  - Other patches
    Except reordering, no changes

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

Clément Léger (2):
  reset: mchp: sparx5: Allow building as a module
  reset: mchp: sparx5: set the dev member of the reset controller

Herve Codina (4):
  misc: Add support for LAN966x PCI device
  MAINTAINERS: Add the Microchip LAN966x PCI driver entry
  reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x
  reset: mchp: sparx5: Add MCHP_LAN966X_PCI dependency

 MAINTAINERS                            |   6 +
 drivers/misc/Kconfig                   |  24 +++
 drivers/misc/Makefile                  |   3 +
 drivers/misc/lan966x_pci.c             | 215 +++++++++++++++++++++++++
 drivers/misc/lan966x_pci.dtso          | 167 +++++++++++++++++++
 drivers/pci/quirks.c                   |   1 +
 drivers/reset/Kconfig                  |   4 +-
 drivers/reset/reset-microchip-sparx5.c |  38 ++++-
 8 files changed, 455 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/lan966x_pci.c
 create mode 100644 drivers/misc/lan966x_pci.dtso

-- 
2.46.1


