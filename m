Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01335624B01
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiKJTxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiKJTxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:53:32 -0500
Received: from resqmta-h1p-028589.sys.comcast.net (resqmta-h1p-028589.sys.comcast.net [IPv6:2001:558:fd02:2446::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A648773
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 11:53:19 -0800 (PST)
Received: from resomta-h1p-027912.sys.comcast.net ([96.102.179.201])
        by resqmta-h1p-028589.sys.comcast.net with ESMTP
        id tCeRo6MDBIP6etDZYoVicu; Thu, 10 Nov 2022 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668109848;
        bh=/aHJeQHePJUbJj7fdHDITqdaKx9GdhGL2xZ60i2fMKo=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=aN2b7JyrmYa1XHi2EqqtZe7DFk+tLp/QnyszixXJRBeU2VfwYIj/UitsjxxuYcRMu
         nRA34fUnzLd2O5h+pW5PyutmxgbSU7bYI+iIFl+q7a0bhBG66neUDPRmkwTkrReI0M
         Na4hSovFcD9i0AQKCPgopvKjvXuY3HBTNvz2FvBH3TEW8hj7yC0l2VzdrNx8LEfYMY
         qL+Tn8BUBsYqk1cMN7iJg0JQKocZYq9SXJ01vwlXqjVPPXyOQGlHBdMjHyoMqF3Yoc
         ptZY+WyO5/9H8UZzlKI5r3Ntcbob/Mb/gqnSNpnxQI6Xpe1yfZCCdSxBvIkXfCDTmx
         u1Avp2ayW28KA==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027912.sys.comcast.net with ESMTPA
        id tDZ4oZTHiVTvltDZKokliT; Thu, 10 Nov 2022 19:50:35 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlhhishhisegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
 hugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohepphgrlhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 7/7] PCI: pciehp: Wire up pcie_port_emulate_slot and
Date:   Thu, 10 Nov 2022 12:50:15 -0700
Message-Id: <20221110195015.207-8-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110195015.207-1-jonathan.derrick@linux.dev>
References: <20221110195015.207-1-jonathan.derrick@linux.dev>
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

Add pcie_port_slot_emulated hook and wire it up to pciehp_emul. Add
pciehp_emul_{attach,detach} calls in pciehp and move the management
check into the attach caller.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/hotplug/pciehp.h      | 18 ++++++++++++++++++
 drivers/pci/hotplug/pciehp_emul.c |  8 ++++++++
 drivers/pci/hotplug/pciehp_hpc.c  |  3 +++
 drivers/pci/pcie/portdrv_core.c   |  3 +++
 include/linux/pci.h               |  4 ++++
 5 files changed, 36 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e221f5d12ad5..db09705ecb46 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -196,6 +196,24 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_EMUL
+bool pciehp_emul_will_manage(struct pci_dev *dev);
+int pciehp_emul_attach(struct controller *ctrl);
+void pciehp_emul_detach(struct controller *ctrl);
+#else
+static inline bool pciehp_emul_will_manage(struct pci_dev *dev)
+{
+	return false;
+};
+
+static inline int pciehp_emul_attach(struct controller *ctrl)
+{
+	return 0;
+};
+
+static inline void pciehp_emul_detach(struct controller *ctrl) {};
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_emul.c b/drivers/pci/hotplug/pciehp_emul.c
index 716ec57feb79..81e39b0964b4 100644
--- a/drivers/pci/hotplug/pciehp_emul.c
+++ b/drivers/pci/hotplug/pciehp_emul.c
@@ -370,3 +370,11 @@ void pciehp_emul_detach(struct controller *ctrl)
 
 	kfree(emul);
 }
+
+static int __init pciehp_emul_init(void)
+{
+	pcie_port_slot_emulated = &pciehp_emul_will_manage;
+
+	return 0;
+}
+postcore_initcall(pciehp_emul_init);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f711448e0a70..fc5983e70997 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -1003,6 +1003,9 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 	ctrl->pcie = dev;
 	ctrl->depth = pcie_hotplug_depth(dev->port);
+	if (pciehp_emul_will_manage(pdev) && pciehp_emul_attach(ctrl))
+		return NULL;
+
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
 
 	if (pdev->hotplug_user_indicators)
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index b3c1e7d4ff10..3df397c01f0e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -19,6 +19,9 @@
 #include "../pci.h"
 #include "portdrv.h"
 
+/* Hook for hotplug emulation driver */
+bool (*pcie_port_slot_emulated)(struct pci_dev *dev);
+
 struct portdrv_service_data {
 	struct pcie_port_service_driver *drv;
 	struct device *dev;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0c907f94bb61..0011e7775735 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1656,7 +1656,11 @@ extern bool pcie_ports_native;
 #define pcie_ports_native	false
 #endif
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_EMUL
+extern bool (*pcie_port_slot_emulated)(struct pci_dev *dev);
+#else
 #define pcie_port_slot_emulated(dev) false
+#endif
 
 #define PCIE_LINK_STATE_L0S		BIT(0)
 #define PCIE_LINK_STATE_L1		BIT(1)
-- 
2.30.2

