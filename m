Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD087280CED
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 06:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgJBEtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 00:49:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:24386 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgJBEtC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 00:49:02 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Oct 2020 13:48:59 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 4F428180B3C;
        Fri,  2 Oct 2020 13:48:59 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 2 Oct 2020 13:48:59 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 147651A0509;
        Fri,  2 Oct 2020 13:48:59 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/3] PCI: endpoint: Add endpoint restart management
Date:   Fri,  2 Oct 2020 13:48:46 +0900
Message-Id: <1601614127-13837-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601614127-13837-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1601614127-13837-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add new functions to manage recovery of configuration parameters and
restart the controller when asserting bus-reset from root-complex (RC).

This feature is only available if bus-reset (PERST#) line is physically
routed between RC and endpoint and the signal from RC affects endpoint.
This feature works as follows.

- This adds a polling thread, that polls and detects the bus-reset signal,
  and recovers configuration parameters for endpoint. The polling period
  is fixed at EPC_RESTART_POLL_PERIOD_MS.

- After the endpoint controller starts and the user sets configuration
  parameters using sysfs or function drivers, once RC asserts bus-reset
  and endpoint can receive it, the endpoint controller will also reset
  and initialize configuration parameters.

- If the thread detects bus-reset signal, the thread stops the controller,
  unbinds it, quickly binds it and restart it. The configuration
  paremters are restored to the user's values.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/endpoint/Kconfig           |   9 +++
 drivers/pci/endpoint/Makefile          |   1 +
 drivers/pci/endpoint/pci-epc-restart.c | 114 +++++++++++++++++++++++++++++++++
 include/linux/pci-epc.h                |  15 +++++
 4 files changed, 139 insertions(+)
 create mode 100644 drivers/pci/endpoint/pci-epc-restart.c

diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index 17bbdc9..016c82a 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -28,6 +28,15 @@ config PCI_ENDPOINT_CONFIGFS
 	   configure the endpoint function and used to bind the
 	   function with a endpoint controller.
 
+config PCI_ENDPOINT_RESTART
+	bool "PCI Endpoint Restart Management Support"
+	depends on PCI_ENDPOINT
+	help
+	   Enable restart management functions, which detects bus-reset
+	   from root complex, and recover endpoint configuration.
+	   This is only available if bus-reset line is physically routed
+	   between root complex and endpoint.
+
 source "drivers/pci/endpoint/functions/Kconfig"
 
 endmenu
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe4..7301aea 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -4,5 +4,6 @@
 #
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
+obj-$(CONFIG_PCI_ENDPOINT_RESTART)	+= pci-epc-restart.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
 					   pci-epc-mem.o functions/
diff --git a/drivers/pci/endpoint/pci-epc-restart.c b/drivers/pci/endpoint/pci-epc-restart.c
new file mode 100644
index 0000000..ab956be
--- /dev/null
+++ b/drivers/pci/endpoint/pci-epc-restart.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * PCI Endpoint Controller Restart Management
+ *
+ * Copyright (C) 2019-2020 Socionext Inc.
+ * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+
+#define EPC_RESTART_POLL_PERIOD_MS	80
+
+static int pci_epc_restart_thread(void *dev_id)
+{
+	struct pci_epc *epc = dev_id;
+	struct pci_epf *epf;
+	int ret = 0;
+
+	dev_info(&epc->dev, "[epc-restart] thread start\n");
+
+	while (!kthread_should_stop()) {
+		if (epc->restart_poll) {
+			/* call polling function */
+			ret = epc->restart_poll(epc->restart_poll_data);
+			if (!ret) {
+				msleep(EPC_RESTART_POLL_PERIOD_MS);
+				continue;
+			} else if (ret < 0) {
+				break;
+			}
+		} else {
+			/* wait for interrupt */
+			ret = wait_for_completion_interruptible(&epc->restart_comp);
+			if (ret <= 0)
+				break;
+		}
+
+		if (!pci_epc_is_started(epc))
+			continue;
+
+		/*
+		 * After stop linkup, call unbind() once and call bind() again.
+		 * to reload config parameters to the controller.
+		 */
+		pci_epc_stop(epc);
+		list_for_each_entry(epf, &epc->pci_epf, list) {
+			pci_epf_unbind(epf);
+			pci_epf_bind(epf);
+		}
+		pci_epc_start(epc);
+
+		dev_info(&epc->dev, "[epc-restart] assert\n");
+	}
+
+	dev_info(&epc->dev, "[epc-restart] thread exit\n");
+
+	return ret;
+}
+
+/**
+ * pci_epc_restart_init() - initialize epc-restart thread
+ * @epc: the EPC device
+ */
+int pci_epc_restart_init(struct pci_epc *epc)
+{
+	init_completion(&epc->restart_comp);
+
+	epc->restart_task = kthread_run(pci_epc_restart_thread, epc,
+				"pci-epc-restart");
+	if (IS_ERR(epc->restart_task))
+		return PTR_ERR(epc->restart_task);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_restart_init);
+
+/**
+ * pci_epc_restart_cleanup() - clean up epc-restart thread
+ * @epc: the EPC device
+ */
+void pci_epc_restart_cleanup(struct pci_epc *epc)
+{
+	if (epc->restart_task)
+		kthread_stop(epc->restart_task);
+}
+EXPORT_SYMBOL_GPL(pci_epc_restart_cleanup);
+
+/**
+ * pci_epc_restart_notify() - notify to epc-restart thread
+ * @epc: the EPC device
+ */
+void pci_epc_restart_notify(struct pci_epc *epc)
+{
+	complete(&epc->restart_comp);
+}
+EXPORT_SYMBOL_GPL(pci_epc_restart_notify);
+
+/**
+ * pci_epc_restart_register_poll_func() - register polling method for restart thread
+ * @epc: the EPC device
+ * @func: polling function
+ * @data: data for polling function
+ */
+void pci_epc_restart_register_poll_func(struct pci_epc *epc, bool (*func)(void *),
+					void *data)
+{
+	epc->restart_poll = func;
+	epc->restart_poll_data = data;
+}
+EXPORT_SYMBOL_GPL(pci_epc_restart_register_poll_func);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index d875d2d..a50c8c8 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -108,6 +108,10 @@ struct pci_epc_mem {
  * @function_num_map: bitmap to manage physical function number
  * @notifier: used to notify EPF of any EPC events (like linkup)
  * @started: true if this EPC is started
+ * @restart_task: pointer to task for restart thread
+ * @restart_comp: completion object for receiving reset interrupts from RC
+ * @restart_poll: function to poll reset detection from RC
+ * @restart_poll_data: an argument that restart_poll function gets
  */
 struct pci_epc {
 	struct device			dev;
@@ -123,6 +127,11 @@ struct pci_epc {
 	unsigned long			function_num_map;
 	struct atomic_notifier_head	notifier;
 	bool				started;
+	/* for epc-restart */
+	struct task_struct		*restart_task;
+	struct completion		restart_comp;
+	bool				(*restart_poll)(void *func);
+	void				*restart_poll_data;
 };
 
 /**
@@ -223,4 +232,10 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 				     phys_addr_t *phys_addr, size_t size);
 void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 			   void __iomem *virt_addr, size_t size);
+int pci_epc_restart_init(struct pci_epc *epc);
+void pci_epc_restart_cleanup(struct pci_epc *epc);
+void pci_epc_restart_notify(struct pci_epc *epc);
+void pci_epc_restart_register_poll_func(struct pci_epc *epc,
+					bool (*func)(void *), void *data);
+
 #endif /* __LINUX_PCI_EPC_H */
-- 
2.7.4

