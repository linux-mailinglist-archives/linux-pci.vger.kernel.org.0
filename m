Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCB6624AFB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiKJTxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiKJTxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:53:32 -0500
Received: from resqmta-h1p-028590.sys.comcast.net (resqmta-h1p-028590.sys.comcast.net [IPv6:2001:558:fd02:2446::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584FE48768
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 11:53:19 -0800 (PST)
Received: from resomta-h1p-027912.sys.comcast.net ([96.102.179.201])
        by resqmta-h1p-028590.sys.comcast.net with ESMTP
        id t7UAoNDWXxPzbtDZYo9nzF; Thu, 10 Nov 2022 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668109848;
        bh=4ke7cD7/palQFOoAL4nLOITBDTgQrjCTwxozvYBcwx8=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=Q+KDOe3DNpmOqLqImyewJYeeoLCYAD90NZglpeuNKVZW9YP1Xv5bBhe8FyNPTbgTd
         rxMbTSBuALitTjmG8WhEQo8KTzUtzwP8q1GwI1Y9LMlw9ZfO3Jhqo2rU9u73vANDc/
         iFFWw9BxdNBJQfG/8yP0TzLlBO5i6FIME3X/AL8iNKA5jkjfTPi0q/0/lCNQnFpBmt
         fLN/kypRH+WM+PvX/2Lrd9GkOkP5uRA1bwltto1IxesJSoQ2YgF/eldX5vO/KAYyLB
         xBoM7b1Wm7N/QjVhPfg7vUJCqDgMgKI0dFGMW+ajMZWWGwTQ/UyZrC3njqWkkHQemq
         4jOtd5qFVNTEw==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027912.sys.comcast.net with ESMTPA
        id tDZ4oZTHiVTvltDZAoklhh; Thu, 10 Nov 2022 19:50:26 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedvtdejiefgueelteevudevhfdvjedvhfdtgfehjeeitdevueektdegtedttdehvdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlhhishhisegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
 dqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohepphgrlhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 0/7] PCIe Hotplug Slot Emulation driver
Date:   Thu, 10 Nov 2022 12:50:08 -0700
Message-Id: <20221110195015.207-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please see note [1] about v2

This set adds an emulation driver for PCIe Hotplug. There may be platforms with
specific configurations that can support hotplug but don't provide the logical
slot hotplug hardware. For instance, the platform may use an
electrically-tolerant interposer between the slot and the device.

This driver utilizes the pci-bridge-emul architecture to manage register reads
and writes. The underlying functionality of the hotplug emulation driver uses
the Data Link Layer Link Active Reporting mechanism in a polling loop, but can
tolerate other event sources such as AER or DPC.

When enabled and a slot is managed by the driver, all port services are managed
by the kernel. This is done to ensure that firmware hotplug and error
architecture does not (correctly) halt/machine check the system when hotplug is
performed on a non-hotplug slot.

The driver offers two active mode: Auto and Force.
auto: The driver will bind to non-hotplug slots
force: The driver will bind to all slots and overrides the slot's services

There are three kernel params:
pciehp.pciehp_emul_mode={off, auto, force}
pciehp.pciehp_emul_time=<msecs polling time> (def 1000, min 100, max 60000)
pciehp.pciehp_emul_ports=<PCI [S]BDF/ID format string>

The pciehp_emul_ports kernel parameter takes a semi-colon tokenized string
representing PCI [S]BDFs and IDs. The pciehp_emul_mode will then be applied to
only those slots, leaving other slots unmanaged by pciehp_emul.

The string follows the pci_dev_str_match() format:

  [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
  pci:<vendor>:<device>[:<subvendor>:<subdevice>]

When using the path format, the path for the device can be obtained
using 'lspci -t' and further specified using the upstream bridge and the
downstream port's device-function to be more robust against bus
renumbering.

When using the vendor-device format, a value of '0' in any field acts as
a wildcard for that field, matching all values.

The driver is enabled with CONFIG_HOTPLUG_PCI_PCIE_EMUL=y.

The driver should be considered 'use at own risk' unless the platform/hardware
vendor recommends this mode.

[1]
The main intent of posting v2 is to help Vidya further along with his
GPIO-based hotplug driver. I have no direct need for a DLLSC-based emulated
mode, and I'm not certain the model is appropriate. The GPIO-based model could
modify some of the logic in patch 6 to check for GPIO instead of DLLSC.

v1->v2: Indirects capacibility accessors instead of filtering pciehp slot operations

Jonathan Derrick (7):
  PCI: Allow for indirecting capability registers
  PCI: Add pcie_port_slot_emulated stub
  PCI: pciehp: Expose the poll loop to other drivers
  PCI: Move pci_dev_str_match to search.c
  PCI: pci-bridge-emul: Provide a helper to set behavior
  PCI: pciehp: Add hotplug slot emulation driver
  PCI: pciehp: Wire up pcie_port_emulate_slot and

 drivers/pci/access.c              |  29 +++
 drivers/pci/hotplug/Makefile      |   4 +
 drivers/pci/hotplug/pciehp.h      |  20 ++
 drivers/pci/hotplug/pciehp_emul.c | 380 ++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  |  19 +-
 drivers/pci/pci-acpi.c            |   3 +
 drivers/pci/pci-bridge-emul.c     |  19 ++
 drivers/pci/pci-bridge-emul.h     |  10 +
 drivers/pci/pci.c                 | 163 -------------
 drivers/pci/pcie/Kconfig          |  13 +
 drivers/pci/pcie/portdrv_core.c   |  12 +-
 drivers/pci/probe.c               |   2 +-
 drivers/pci/search.c              | 162 +++++++++++++
 include/linux/pci.h               |  22 ++
 14 files changed, 688 insertions(+), 170 deletions(-)
 create mode 100644 drivers/pci/hotplug/pciehp_emul.c

-- 
2.30.2

