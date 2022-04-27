Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F515115A7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiD0LFO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 07:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiD0LE6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 07:04:58 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D079728CFD4;
        Wed, 27 Apr 2022 03:54:53 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 3702FC22B9;
        Wed, 27 Apr 2022 09:47:27 +0000 (UTC)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 46333240002;
        Wed, 27 Apr 2022 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651052807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QY22kkywdGz9ZZ9vDCj+AzFscs29dSCG+zCgFSuQoY4=;
        b=apqfwr3MNvppcLIhApJyjfR8DLf0VDKvYPEk0C92Xc4dHd1/2IHZUeDZIN+BqgeVMXJBLe
        68KVF6OQE4sfXdyFtdRcjCju9VnSchAPE2vaG57wMDB8Y2TuwQS7THMNdTUzmRwAs0jLak
        YjNtCTox/wSQMGVK5rdQN6aGsI4lOcys2zaTrjFZL/zCWgE3SGguVjAQcTpwRjXEQkqfTg
        kNPG7kMtaqyvcc2ugc858c+w903NRJHcsTBzfRnI2+S+DAqqQVSbjngj8a7GvA9JdNzFrB
        UblHKoUIpNsVXP6fz8DiqtTYu3KAWPwdxw44+I5KkC9u8NvmsUE/69ug+/isZw==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Date:   Wed, 27 Apr 2022 11:44:59 +0200
Message-Id: <20220427094502.456111-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds foundation work to support the lan9662 PCIe card. This
card is meant to be used an ethernet switch with 2 x RJ45 ports and
2 x 2.5G SFPs. The lan966x SoCs can be used in two different ways:

 - It can run Linux by itself, on ARM64 cores included in the SoC. This
   use-case of the lan966x is currently being upstreamed, using a
   traditional Device Tree representation of the lan996x HW blocks [1]
   A number of drivers for the different IPs of the SoC have already
   been merged in upstream Linux.

 - It can be used as a PCIe endpoint, connected to a separate platform
   that acts as the PCIe root complex. In this case, all the devices
   that are embedded on this SoC are exposed through PCIe BARs and the
   ARM64 cores of the SoC are not used. Since this is a PCIe card, it
   can be plugged on any platform, of any architecture supporting PCIe.

The problem that arose is that we want to reuse all the existing OF
compatible drivers that are used when in SoC mode to instantiate the
PCI device when in PCIe endpoint mode.

A previous attempt to tackle this problem was made using fwnode [1].
However, this proved being way too invasive and it required
modifications in both subsystems and drivers to support fwnode. First
series did not lead to a consensus and multiple ideas to support this
use-case were mentioned (ACPI overlay, fwnode, device-tree overlay).
Since it only seemed that fwnode was not a totally silly idea, we
continued on this way.

However, on the series that added fwnode support to the reset subsystem,
Rob Herring mentioned the fact that OF overlay might actually be the
best way to probe PCI devices and populate platform drivers using this
overlay. He also provided a branch containing some commits that helped
to implement this idea on a x86 setup. Due to the dynamic nature of PCI
bus enumeration, some other modifications needs to be applied on the
overlay to apply it correctly. Indeed, it is necessary to modify the
target node of the fragments to apply them correctly on the PCI device
that was probed. Moreover, the 'ranges' must be set according to the
BAR addresses in order to remap devices to the correct PCI addresses.
These modifications are the located into the driver since the remapping
is something that is specific to each driver.

After modifications, this proves to be successful and a full support of
the aforementioned lan966x PCI card was added. The modifications to
support that (apply an overlay on a dynamically created PCI of_node) are
actually minimal and only touches a few places (pci/of.c). This series
contains the 3 commits that are necessary to do that:

- First commit creates the root node if not present on a x86 setup
  without a firmware provided device-tree.
- Second one dynamically creates the PCI bus/device device-tree node
  hierarchy using changeset API.
- Finally a last commit allows to apply an overlay by targeting a
  specific device-tree node.

Other problems that might be considered with this series is the fact
that CONFIG_OF is not enabled by default on x86 configuration and thus
the driver can't be used without rebuilding a complete kernel with
CONFIG_OF=y. In order to fully support this PCIe card and allow lambda
user to use this driver, it would be almost mandatory to enable
CONFIG_OF by default on such setup.

A driver using this support was added and can be seen at [3]. This
driver embeds a builtin overlay and applies it to the live tree using
of_overlay_fdt_apply_to_node(). An interrupt driver is also included and
associated to a node that is added by the overlay. The driver also
insert a specific "ranges" property based on the BAR values which allows
to remap the device-tree node to BAR addresses dynamically. This is
needed to allow applying the overlay without depending on specific
enumeration BAR addresses.

This series was tested on a x86 kernel using CONFIG_OF under a virtual
machine using PCI passthrough.

Link: [1] https://lore.kernel.org/lkml/YhQHqDJvahgriDZK@lunn.ch/t/
Link: [2] https://lore.kernel.org/lkml/20220408174841.34458529@fixe.home/T/
Link: [3] https://github.com/clementleger/linux/tree/lan966x/of_support

Clément Léger (3):
  of: always populate a root node
  PCI: of: create DT nodes for PCI devices if they do not exists
  of: overlay: add of_overlay_fdt_apply_to_node()

 drivers/of/base.c    |  16 +++-
 drivers/of/overlay.c |  21 +++--
 drivers/pci/of.c     | 184 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  17 +++-
 4 files changed, 224 insertions(+), 14 deletions(-)

-- 
2.34.1

