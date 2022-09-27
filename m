Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925B5EC5F3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiI0O0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiI0O0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:26:39 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E19FA49B68;
        Tue, 27 Sep 2022 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4S5XBiFjDZg4gx2Ocx
        QfUQjnQwfdPOoTKn7C7OGJNZc=; b=DPK/qDxDbMUvYQ/cTLcYRaUN/ZCMN5xq6x
        h7PtMricsucf9NV0yxKSLVpM3Dn28vATg/qAPU9gBo1+yvXbeD5mr/q2wqHK/78a
        qFCsFPBRcoCnkHY9KdIJipMQiV+V5l0FVk052hJYUGuc3d81qm8y16eDC5H8YxLc
        03U+6UB2U=
Received: from os-l3a203-yehs1-dev01.localdomain (unknown [103.244.59.1])
        by smtp1 (Coremail) with SMTP id GdxpCgC3vKTjBzNjs5TAfw--.37703S2;
        Tue, 27 Sep 2022 22:25:41 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, xiaocli@redhat.com,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH v2 1/1] PCI: Set no io resource for bridges that behind VMD controller
Date:   Tue, 27 Sep 2022 22:16:06 +0800
Message-Id: <1664288166-7432-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: GdxpCgC3vKTjBzNjs5TAfw--.37703S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrW5KF4DAryfJF1UKFy5CFg_yoWrtFWDpF
        4agr45Zr48XFy7tws3uwn7CFWFvFs2yFWYyry3KwnIva1UCFyUZr9IyFyjgF4UJF1Dt343
        X3Z5GrykuayDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeHq7UUUUU=
X-Originating-IP: [103.244.59.1]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbioAWJQFjSPgyEjgAAse
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

When enable VMDs on Intel CPUs, VMD controllers(8086:28c0) be
recognized by VMD driver and there are many failed messages of
BAR 13 when scan the bridges and assign IO resource behind it
as listed below, the bridge wants to get 0x6000 as its IO
resource, but there is no IO resources on the host bridge.

VMD host bridge resources:
vmd 0000:e2:00.5: PCI host bridge to bus 10001:00
pci_bus 10001:00: root bus resource [bus 00-1f]
pci_bus 10001:00: root bus resource [mem 0xf4000000-0xf5ffffff]
pci_bus 10001:00: root bus resource [mem 0x29ffff02010-0x29fffffffff 64bit]
pci_bus 10001:00: scanning bus

Read bridge IO resource:
pci 10001:00:02.0: PCI bridge to [bus 01]
pci 10001:00:02.0:   bridge window [io  0x1000-0x6fff]
pci 10001:00:03.0: PCI bridge to [bus 02]
pci 10001:00:03.0:   bridge window [io  0x1000-0x6fff]

Failed messages of BAR#13:
pci 10001:00:02.0: BAR 13: no space for [io  size 0x6000]
pci 10001:00:02.0: BAR 13: failed to assign [io  size 0x6000]
pci 10001:00:03.0: BAR 13: no space for [io  size 0x6000]
pci 10001:00:03.0: BAR 13: failed to assign [io  size 0x6000]

VMD-enabled root ports use
Enhanced Configuration Access Mechanism (ECAM) access
PCI Express configuration space, and offer VMD_CFGBAR as
base of PCI Express configuration space for the bridges
behind it. The configuration space includes IO resources,
but these IO resources are not actually used on X86,
it can result in BAR#13 assign IO resource failed.
Therefor,clear IO resources by setting an IO base value
greater than limit to these bridges here, so in this case,
we can leverage kernel parameter "pci=hpiosize=0KB" to
avoid this failed messages show up.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 drivers/pci/quirks.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798e75b5..efecf12e8059 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5956,3 +5956,63 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
 #endif
+
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86)
+
+#ifdef CONFIG_UML_X86
+#define is_vmd(bus)             false
+#endif /* CONFIG_UML_X86 */
+
+/*
+ * VMD-enabled root ports use Enhanced Configuration Access Mechanism (ECAM)
+ * access PCI Express configuration space, and offer VMD_CFGBAR as the
+ * base of PCI Express configuration space for the bridges behind it.
+ * The configuration space includes IO resources, but these IO
+ * resources are not actually used on X86, and it can result
+ * in BAR#13 assign IO resource failed. Therefor, clear IO resources
+ * by setting an IO base value greater than limit to these bridges here,
+ * so in this case, append kernel parameter "pci=hpiosize=0KB" can avoid
+ * the BAR#13 failed messages show up.
+ */
+static void quirk_vmd_no_iosize(struct pci_dev *bridge)
+{
+	u8 io_base_lo, io_limit_lo;
+	u16 io_low;
+	u32 io_upper16;
+	unsigned long io_mask,  base, limit;
+
+	io_mask = PCI_IO_RANGE_MASK;
+	if (bridge->io_window_1k)
+		io_mask = PCI_IO_1K_RANGE_MASK;
+
+	/* VMD Domain */
+	if (is_vmd(bridge->bus) && bridge->is_hotplug_bridge) {
+		pci_read_config_byte(bridge, PCI_IO_BASE, &io_base_lo);
+		pci_read_config_byte(bridge, PCI_IO_LIMIT, &io_limit_lo);
+		base = (io_base_lo & io_mask) << 8;
+		limit = (io_limit_lo & io_mask) << 8;
+		/* if there are defined io ports behind the bridge on x86,
+		 * we clear it, since there is only 64KB IO resource on it,
+		 * beyond that, hotplug io bridges don't needs IO port resource,
+		 * such as NVMes attach on it. So the corresponding range must be
+		 * turned off by writing base value greater than limit to the
+		 * bridge's base/limit registers.
+		 */
+		if (limit >= base) {
+			/* Clear upper 16 bits of I/O base/limit */
+			io_upper16 = 0;
+			/* set base value greater than limit */
+			io_low = 0x00f0;
+
+			/* Temporarily disable the I/O range before updating PCI_IO_BASE */
+			pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0x0000ffff);
+			/* Update lower 16 bits of I/O base/limit */
+			pci_write_config_word(bridge, PCI_IO_BASE, io_low);
+			/* Update upper 16 bits of I/O base/limit */
+			pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, io_upper16);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_BRIDGE_PCI, 8, quirk_vmd_no_iosize);
+#endif
-- 
2.37.3

