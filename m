Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3927A5B6E73
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 15:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIMNf3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiIMNf2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 09:35:28 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEBFA1CB18;
        Tue, 13 Sep 2022 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=U16LZwWLpP6lSvevS/
        +MxEAX56p/rB2gXsgNI9JSmlA=; b=Jjc3nl8yoD3SdvdJaoZWQgc1oJ9jJFxh+n
        HZllsfzPdf4qx3omA2tif9WgGjXTv/YyNYR0l2mrk6KL396ZpDu4Ct8ZFjd/9kKx
        kzq1KqmDT+s8FBHwKIZm/Kt/28qDWjsimHhVZ0fRBV1e3uivSGa7tk+OiMOoPnbB
        uSxxFjXUM=
Received: from os-l3a203-yehs1-dev01.localdomain (unknown [103.244.59.1])
        by smtp4 (Coremail) with SMTP id HNxpCgBHlobghiBjSmbecg--.6836S2;
        Tue, 13 Sep 2022 21:34:24 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH v1] PCI: Set no io resource for bridges that behind VMD controller
Date:   Tue, 13 Sep 2022 21:24:45 +0800
Message-Id: <1663075485-20591-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: HNxpCgBHlobghiBjSmbecg--.6836S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryxCr1Dury8JryrKr4DJwb_yoWrZF4kpF
        Wagw45Xr40qFy7tws3W3yxCFWFvan2yFWYyry7Xrnava18uFyUurnxAFy5XF4DJF1Dtw13
        Xwn5Jrykua1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_sqAUUUUU=
X-Originating-IP: [103.244.59.1]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbioAF7QFjSPWUxggAAs7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
vmd 0000:64:00.5: PCI host bridge to bus 10000:80
pci_bus 10000:80: root bus resource [bus 80-9f]
pci_bus 10000:80: root bus resource [mem 0xe0000000-0xe1ffffff]
pci_bus 10000:80: root bus resource [mem 0x24ffff02010-0x24fffffffff 64bit]

Failed messages of BAR#13:
pci 10000:80:02.0: BAR 13: no space for [io  size 0x1000]
pci 10000:80:02.0: BAR 13: failed to assign [io  size 0x1000]
pci 10000:80:03.0: BAR 13: no space for [io  size 0x1000]
pci 10000:80:03.0: BAR 13: failed to assign [io  size 0x1000]

VMD-enabled root ports use
Enhanced Configuration Access Mechanism (ECAM) access
PCI Express configuration space, and offer VMD_CFGBAR as
base of PCI Express configuration space for the bridges
behind it. The configuration space includes IO resources,
but these IO resources are not actually used on X86,
especially the NVMes as device connected on this hot plug
bridges, and it can result in BAR#13 assign IO resource
failed. So we clear IO resources by setting an IO base value
greater than limit to these bridges. Hence, we can leverage
kernel parameter "pci=hpiosize=0KB" to avoid this failed
messages show out.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 drivers/pci/quirks.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798..f8a37f0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5956,3 +5956,60 @@ static void aspm_l1_acceptable_latency(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
 #endif
+
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86)
+/*
+ * VMD-enabled root ports use Enhanced Configuration Access Mechanism (ECAM)
+ * access PCI Express configuration space, and offer VMD_CFGBAR as
+ * base of PCI Express configuration space for the bridges behind it.
+ * The configuration space includes IO resources, but these IO
+ * resources are not actually used on X86, especially the NVMes as
+ * device connnected on this hot plug bridges, and it can result
+ * in BAR#13 assign IO resource failed. So we clear IO resources
+ * by setting an IO base value greater than limit to these bridges.
+ * Hence, append kernel parameter "pci=hpiosize=0KB" can avoid
+ * this BAR#13 failed messages show out.
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
+		if (limit >= base) {
+			/* if there are defined io ports behind the bridge on x86,
+			 * we clear it, since there is only 64KB IO resource on it,
+			 * beyond that, hotplug io bridges don't needs IO port resource,
+			 * such as NVMes attach on it. So the corresponding range must be
+			 * turned off by writing base value greater than limit to the
+			 * bridge's base/limit registers.
+			 */
+
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
1.8.3.1

