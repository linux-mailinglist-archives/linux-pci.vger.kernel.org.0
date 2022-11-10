Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB9624AFF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiKJTxg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKJTxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:53:32 -0500
Received: from resqmta-h1p-028594.sys.comcast.net (resqmta-h1p-028594.sys.comcast.net [IPv6:2001:558:fd02:2446::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943048769
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 11:53:19 -0800 (PST)
Received: from resomta-h1p-027912.sys.comcast.net ([96.102.179.201])
        by resqmta-h1p-028594.sys.comcast.net with ESMTP
        id t7enopKwunCnBtDZYovSAu; Thu, 10 Nov 2022 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668109848;
        bh=bQerkWg6K2GQUzSCC4gsty8efMvieIoJj52PHPj0HX0=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=hnxiOFUY/qk2ePrXjsb5lmKj16E86Us90KJnYSXSB43Uny25Wx107HHGVm2+anIgr
         Nq9oow+2c2puutsoZjahnMNM6ykgW72sNaBRTcoUfliBBLOGIhg5Er4AbWL62yfp+e
         VIgUmOf+hIYp+K7791ajBROoY9OliY3iH0qBC7C8wnrAK2TwElMRf0ZvEBDz/OQsTi
         7wjKc41mhMSWs5r/jk3mev31lUHCq6Mk5Iu+5fo72N9l2R69nJAUr+S3NSbGeolVl2
         DjQOp4mRZIqrpDJq23wkwW51BIP9BRiF+l/mTxsFzuU+k7KADMvVWmUhaeAm2ZodMc
         Trx5gBkDYV0EA==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027912.sys.comcast.net with ESMTPA
        id tDZ4oZTHiVTvltDZJokliP; Thu, 10 Nov 2022 19:50:34 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlhhishhisegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
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
Subject: [PATCH v2 6/7] PCI: pciehp: Add hotplug slot emulation driver
Date:   Thu, 10 Nov 2022 12:50:14 -0700
Message-Id: <20221110195015.207-7-jonathan.derrick@linux.dev>
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

This adds the PCIe Hotplug emulation driver. There may be platforms with
specific configurations that can support hotplug but don't provide the
logical slot hotplug hardware. For instance, the platform may use an
electrically-tolerant interposer between the slot and the device.

This driver utilizes the pci-bridge-emul architecture to manage register
reads and writes. The underlying functionality of the hotplug emulation
driver uses the Data Link Layer Link Active Reporting mechanism in a
polling loop, but can tolerate other event sources such as AER or DPC.

When enabled and a slot is managed by the driver, all PCIe Port services
are managed by the kernel. This is done to ensure that firmware hotplug
and error architecture does not (correctly) machine check the system
when hotplug is performed on a non-hotplug slot.

The driver offers two active mode: auto and force. auto: Bind to
non-hotplug slots force: Bind to all slots and overrides the slot's
services

There are three kernel parameters:
pciehp.pciehp_emul_mode={off, auto, force}
pciehp.pciehp_emul_time=<msecs poll time> (def 1000, min 100, max 60000)
pciehp.pciehp_emul_ports=<PCI [S]BDF/ID format string>

The pciehp_emul_ports parameter takes a semi-colon tokenized string
representing PCI [S]BDFs and IDs. The pciehp_emul_mode will then be
applied to only those slots, leaving other slots unmanaged by
pciehp_emul.

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

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/hotplug/Makefile      |   4 +
 drivers/pci/hotplug/pciehp_emul.c | 372 ++++++++++++++++++++++++++++++
 drivers/pci/pcie/Kconfig          |  13 ++
 3 files changed, 389 insertions(+)
 create mode 100644 drivers/pci/hotplug/pciehp_emul.c

diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 5196983220df..4c01ecaa1dde 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -65,6 +65,10 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
 
+ifdef CONFIG_HOTPLUG_PCI_PCIE_EMUL
+pciehp-objs		+=	pciehp_emul.o
+endif
+
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
 				shpchp_pci.o	\
diff --git a/drivers/pci/hotplug/pciehp_emul.c b/drivers/pci/hotplug/pciehp_emul.c
new file mode 100644
index 000000000000..716ec57feb79
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_emul.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express PCI Hot Plug Slot Emulation Driver
+ * Author: Jon Derrick <jonathan.derrick@linux.dev>
+ *
+ * Copyright (C) 2022 Solidigm
+ */
+
+#define dev_fmt(fmt) "pciehp: " fmt
+
+#include <linux/moduleparam.h>
+#include <linux/kthread.h>
+
+#include "../pci.h"
+#include "../pci-bridge-emul.h"
+#include "pciehp.h"
+
+static char *pciehp_emul_ports;
+module_param(pciehp_emul_ports, charp, 0444);
+MODULE_PARM_DESC(pciehp_emul_ports, "list of port BDF/IDs (optional)");
+
+static unsigned int pciehp_emul_time = 1000;
+module_param(pciehp_emul_time, uint, 0644);
+MODULE_PARM_DESC(pciehp_emul_time, "link polling delay in msecs");
+
+enum {
+	PCIEHP_EMUL_OFF,
+	PCIEHP_EMUL_AUTO,
+	PCIEHP_EMUL_FORCE,
+};
+
+static const char *const pciehp_emul_mode_strings[] = {
+	"off",
+	"auto",
+	"force",
+};
+
+static int pciehp_emul_mode;
+MODULE_PARM_DESC(pciehp_emul_mode, "slot emulation mode");
+
+static int pciehp_emul_mode_set(const char *str, const struct kernel_param *kp)
+{
+	int i;
+
+	i = match_string(pciehp_emul_mode_strings,
+			 ARRAY_SIZE(pciehp_emul_mode_strings), str);
+	if (i < 0)
+		return i;
+
+	pciehp_emul_mode = i;
+	return 0;
+}
+
+static int pciehp_emul_mode_get(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%s\n", pciehp_emul_mode_strings[pciehp_emul_mode]);
+}
+
+static const struct kernel_param_ops pciehp_emul_mode_ops = {
+	.set = pciehp_emul_mode_set,
+	.get = pciehp_emul_mode_get,
+};
+
+module_param_cb(pciehp_emul_mode, &pciehp_emul_mode_ops, &pciehp_emul_mode, 0444);
+
+static LIST_HEAD(pciehp_emul_list);
+static DEFINE_MUTEX(list_lock);
+
+/**
+ * struct pciehp_emul - Emulated PCIe Hotplug Slot structure
+ * @node:		List of PCIe Hotplug Emulated PCI devices.
+ * @ctrl:		Slot's pciehp controller.
+ * @bridge:		PCI Bridge Emul descriptor. Emulates the common register
+ *			read/write behaviors.
+ * @poll_thread:	Per-slot Data Link Layer Link Active polling thread.
+ */
+struct pciehp_emul {
+	struct list_head node;
+	struct controller *ctrl;
+	struct pci_bridge_emul bridge;
+	struct task_struct *poll_thread;
+};
+
+/* Emul Bridge OPS */
+static struct pci_bridge_emul_ops pciehp_emul_pci_bridge_ops = {};
+
+static struct pciehp_emul *pci_dev_to_pciehp_emul(struct pci_dev *dev)
+{
+	struct pciehp_emul *emul;
+
+	list_for_each_entry(emul, &pciehp_emul_list, node)
+		if (emul->ctrl->pcie->port == dev)
+			return emul;
+
+	return NULL;
+}
+
+static int pciehp_emul_slot_rw(struct pci_dev *dev, int pos, int len,
+			       u32 *val, int dir)
+{
+	struct pciehp_emul *emul;
+	int ret;
+
+	mutex_lock(&list_lock);
+	emul = pci_dev_to_pciehp_emul(dev);
+	if (!emul) {
+		mutex_unlock(&list_lock);
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	if (dir == READ)
+		ret = pci_bridge_emul_conf_read(&emul->bridge,
+						pos + PCI_STD_HEADER_SIZEOF,
+						len, val);
+	else
+		ret = pci_bridge_emul_conf_write(&emul->bridge,
+						 pos + PCI_STD_HEADER_SIZEOF,
+						 len, *val);
+	mutex_unlock(&list_lock);
+
+	return ret;
+}
+
+/* Assuming aligned accesses to slot registers */
+static int pciehp_emul_slot_read(struct pci_dev *dev, int pos, int len, u32 *val)
+{
+	if (pos >= PCI_EXP_SLTCAP && pos <= PCI_EXP_SLTSTA)
+		return pciehp_emul_slot_rw(dev, pos, len, val, READ);
+	return 1;
+}
+
+static int pciehp_emul_slot_write(struct pci_dev *dev, int pos, int len, u32 val)
+{
+	if (pos >= PCI_EXP_SLTCAP && pos <= PCI_EXP_SLTSTA)
+		return pciehp_emul_slot_rw(dev, pos, len, &val, WRITE);
+	return 1;
+}
+
+static struct caps_rw_ops pciehp_emul_slot_ops = {
+	.read = pciehp_emul_slot_read,
+	.write = pciehp_emul_slot_write,
+};
+
+static int pciehp_emul_thread(void *data)
+{
+	struct pciehp_emul *emul = data;
+	struct controller *ctrl = emul->ctrl;
+	struct pci_dev *dev = ctrl->pcie->port;
+	__le16 *emul_lnksta_p = &emul->bridge.pcie_conf.lnksta;
+	__le16 *emul_slotsta_p = &emul->bridge.pcie_conf.slotsta;
+	u16 emul_lnksta, port_lnksta;
+	int ret;
+
+	/* Store initial link status state */
+	ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &port_lnksta);
+	if (!ret && port_lnksta != (u16)~0)
+		*emul_lnksta_p = cpu_to_le16(port_lnksta);
+
+	/* Start with 1 sec delay */
+	schedule_timeout_idle(1 * HZ);
+
+	/*
+	 * Data Link Layer Link Active (DLLLA) event sets Data Link Layer State
+	 * Changed (DLLSC) and updates internal link status tracking.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA,
+						&port_lnksta);
+		if (ret || port_lnksta == (u16)~0)
+			goto cont;
+
+		emul_lnksta = le16_to_cpup(emul_lnksta_p);
+		if ((port_lnksta ^ emul_lnksta) & PCI_EXP_LNKSTA_DLLLA) {
+			ctrl_dbg(ctrl, "link change event (%04x->%04x)\n",
+				 emul_lnksta, port_lnksta);
+			*emul_lnksta_p = cpu_to_le16(port_lnksta);
+			*emul_slotsta_p |= cpu_to_le16(PCI_EXP_SLTSTA_DLLSC);
+
+			while (pciehp_events_pending(ctrl))
+				pciehp_handle_events(ctrl);
+		}
+
+cont:
+		/* Clamp to sane value */
+		pciehp_emul_time = clamp(pciehp_emul_time, 100U, 60000U);
+		schedule_timeout_idle(msecs_to_jiffies(pciehp_emul_time));
+	}
+
+	return 0;
+}
+
+/**
+ * pciehp_emul_ports_check - Matches pci_dev against pciehp_emul_ports filter
+ * @dev:	Struct pci_dev to match against string
+ *
+ * Matches a semi-colon tokenized string list of PCI addresses or vendor-device
+ * IDs to the struct pci_dev. Follows the pci_dev_str_match format in the form:
+ *
+ *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
+ *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+ *
+ * When using the path format, the path for the device can be obtained using
+ * 'lspci -t' and further specified using the upstream bridge and the
+ * downstream port's device-function to be more robust against bus renumbering.
+ *
+ * When using the vendor-device format, a value of '0' in any field acts as a
+ * wildcard for that field, matching all values.
+ *
+ * Returns 0 on match or null/empty string.
+ */
+static int pciehp_emul_ports_check(struct pci_dev *dev)
+{
+	const char *p = pciehp_emul_ports;
+	int ret;
+
+	/* Null or empty string matches all devices */
+	if (!p || !*p)
+		return 0;
+
+	while (*p) {
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret < 0) {
+			pr_info_once("Can't parse pciehp_emul_ports parameter: %s\n",
+				     pciehp_emul_ports);
+			return ret;
+		}
+
+		/* Found a match */
+		if (ret == 1)
+			return 0;
+
+		if (*p != ';' && *p != ',') {
+			/* End of param or invalid format */
+			return -ENODEV;
+		}
+		p++;
+	}
+
+	return -ENODEV;
+}
+
+bool pciehp_emul_will_manage(struct pci_dev *dev)
+{
+	u32 lnkcap;
+	u16 sltcap;
+	int ret;
+
+	if (pciehp_emul_mode == PCIEHP_EMUL_OFF)
+		return false;
+
+	/* A physical slot must be present for emulation to be useful. */
+	if (!(pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT))
+		return false;
+
+	/* Match a port BDF/ID descriptor if given */
+	if (pciehp_emul_ports_check(dev))
+		return false;
+
+	/* Port must support Data Link Layer Link Active (DLLLA) Reporting. */
+	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (ret || lnkcap == (u32)~0)
+		return false;
+	if (!(lnkcap & PCI_EXP_LNKCAP_DLLLARC))
+		return false;
+
+	/* Require 'force' if the port is already hotplug-capable */
+	ret = pcie_capability_read_word(dev, PCI_EXP_SLTCAP, &sltcap);
+	if (ret || sltcap == (u16)~0)
+		return false;
+	if (sltcap & PCI_EXP_SLTCAP_HPC && pciehp_emul_mode != PCIEHP_EMUL_FORCE)
+		return false;
+
+	return true;
+}
+
+int pciehp_emul_attach(struct controller *ctrl)
+{
+	struct pciehp_emul *emul;
+	struct pci_bridge_emul *bridge;
+	struct pci_dev *dev = ctrl->pcie->port;
+	u32 slotcap = 0;
+	int ret;
+
+	emul = kzalloc(sizeof(*emul), GFP_KERNEL);
+	if (!emul)
+		return -ENOMEM;
+
+	ret = pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &slotcap);
+	if (ret)
+		goto free_emul;
+
+	emul->ctrl = ctrl;
+	bridge = &emul->bridge;
+	bridge->has_pcie = true;
+	bridge->data = emul;
+	bridge->ops = &pciehp_emul_pci_bridge_ops;
+	pci_bridge_emul_init(bridge, 0);
+
+	pci_bridge_emul_set_reg_behavior(bridge, true, PCI_EXP_SLTCTL,
+					 ~PCI_EXP_SLTCTL_DLLSCE,
+					 PCI_BRIDGE_EMUL_REG_BEHAVIOR_RO);
+
+	bridge->pcie_conf.slotcap = cpu_to_le32(PCI_EXP_SLTCAP_HPS |
+						PCI_EXP_SLTCAP_HPC |
+						PCI_EXP_SLTCAP_NCCS |
+						(slotcap & PCI_EXP_SLTCAP_PSN));
+	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
+
+	mutex_lock(&list_lock);
+	list_add_tail(&emul->node, &pciehp_emul_list);
+
+	dev->caps_rw_ops = &pciehp_emul_slot_ops;
+	mutex_unlock(&list_lock);
+
+	emul->poll_thread = kthread_run(&pciehp_emul_thread, emul,
+					"emul-%05x:%04x",
+					pci_domain_nr(dev->bus),
+					pci_dev_id(dev));
+	ret = PTR_ERR_OR_ZERO(emul->poll_thread);
+	if (ret)
+		goto del_node;
+
+	ctrl_info(ctrl, "PCIe Hotplug Emulation active -- use at own risk!\n");
+
+	return 0;
+
+del_node:
+	mutex_lock(&list_lock);
+	dev->caps_rw_ops = NULL;
+	list_del(&emul->node);
+	mutex_unlock(&list_lock);
+free_emul:
+	kfree(emul);
+	return ret;
+}
+
+static void pciehp_emul_stop_child_threads(struct pci_dev *dev)
+{
+	struct pciehp_emul *emul;
+	struct pci_bus *bus = dev->subordinate;
+
+	if (!bus)
+		return;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pciehp_emul_stop_child_threads(dev);
+
+		emul = pci_dev_to_pciehp_emul(dev);
+		if (emul)
+			kthread_stop(emul->poll_thread);
+	}
+}
+
+void pciehp_emul_detach(struct controller *ctrl)
+{
+	struct pciehp_emul *emul;
+	struct pci_dev *dev = ctrl->pcie->port;
+
+	mutex_lock(&list_lock);
+	pciehp_emul_stop_child_threads(ctrl->pcie->port);
+
+	emul = pci_dev_to_pciehp_emul(ctrl->pcie->port);
+	if (emul) {
+		kthread_stop(emul->poll_thread);
+		dev->caps_rw_ops = NULL;
+		list_del(&emul->node);
+	}
+	mutex_unlock(&list_lock);
+
+	kfree(emul);
+}
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9d..44901b7e30d5 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -21,6 +21,19 @@ config HOTPLUG_PCI_PCIE
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_PCIE_EMUL
+	bool "PCI Express Hotplug Emulation driver"
+	depends on HOTPLUG_PCI_PCIE && PCIEAER
+	select PCI_BRIDGE_EMUL
+	help
+	  This enables a PCI Express Native Hotplug emulation driver for
+	  non-hotplug-capable PCI Express slots. Hotplug is determined using
+	  link events and this driver can be disabled, or manage either only
+	  non-hotplug-capable slots or both non-hotplug and hotplug slots.
+	  Specific slots may also be targeted.
+
+	  When in doubt, say N.
+
 config PCIEAER
 	bool "PCI Express Advanced Error Reporting support"
 	depends on PCIEPORTBUS
-- 
2.30.2

