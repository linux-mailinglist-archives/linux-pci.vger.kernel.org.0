Return-Path: <linux-pci+bounces-36927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2600B9D924
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 08:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE901891EC9
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10552E974A;
	Thu, 25 Sep 2025 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v8sXOk1X"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FC72610;
	Thu, 25 Sep 2025 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781182; cv=none; b=Y1TzINQIFv+6nNXSjpo1XvlDguExzUYsX1hi8XWDAfIRV/xJm/cOe8s5XvxXX/b+s/c9K98epC72VM9vtoe/7i/GUl2wTM5w1cTHHPW9TQg0NhwEjl6RtAqRG1gGTbgzt8NEs4kJdscKxmDHDaeQqAaL8g6ZWH461DGYobHmqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781182; c=relaxed/simple;
	bh=K3m8PO9M2Q8WKmPWBwclvXrIabfZRODeoK/e9rTGPBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1FiyEKm9x+b6PC9H+r7Y3LLWcwVv4Vtg4qfNeAN0lhjTlXmFJRuvrhwXSwwm9Ed4z+Kne/ffbmCixEL/e0Tsgy3jaUDZlg0n3JbIVi84yRcDdz8ErEGk3f5LZGl/BMXUSTRA0AIncKdl98XjiwOwvhUExOXyFa4TEUe/OlPDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v8sXOk1X; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758781177; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=jTABLuwtQjXAOgs6BsnUKC+lFGWTA0/BSve5gd1GHso=;
	b=v8sXOk1XOH3K+hB4c3um912wb14Rp/xADLST2XWSSr7hS1EATG91HrJw2RdaDGeEJ5PmsOz4aOUHhs+KjvV5VPRmVGa7B2A3Y9S7KP0kAd9EmmvWi2LA+U2pPQflOU+8PzW+lau44F8IjZirrfIuwGH0Zx+ZshBwtnIZQUOMd3I=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WomdUem_1758781174 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 14:19:35 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: rostedt@goodmis.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mattc@purestorage.com,
	Jonathan.Cameron@huawei.com
Cc: bhelgaas@google.com,
	tony.luck@intel.com,
	bp@alien8.de,
	xueshuai@linux.alibaba.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	oleg@redhat.com,
	naveen@kernel.org,
	davem@davemloft.net,
	anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com,
	peterz@infradead.org,
	tianruidong@linux.alibaba.com
Subject: [PATCH v11 2/3] PCI: trace: Add a RAS tracepoint to monitor link speed changes
Date: Thu, 25 Sep 2025 14:19:27 +0800
Message-Id: <20250925061928.42758-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250925061928.42758-1-xueshuai@linux.alibaba.com>
References: <20250925061928.42758-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe link speed degradation directly impacts system performance and
often indicates hardware issues such as faulty devices, physical layer
problems, or configuration errors.

To this end, add a RAS tracepoint to monitor link speed changes,
enabling proactive health checks and diagnostic analysis.

The following output is generated when a device is hotplugged:

$ echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
$ cat /sys/kernel/debug/tracing/trace_pipe
   irq/51-pciehp-88      [001] .....   381.545386: pcie_link_event: 0000:00:02.0 type:4, reason:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Suggested-by: Matthew W Carlis <mattc@purestorage.com>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  3 +-
 drivers/pci/pci.c                |  2 +-
 drivers/pci/pci.h                | 22 ++++++++++--
 drivers/pci/pcie/bwctrl.c        |  4 +--
 drivers/pci/probe.c              |  9 +++--
 include/linux/pci.h              |  1 +
 include/trace/events/pci.h       | 57 ++++++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bcc51b26d03d..ad5f28f6a8b1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -320,7 +320,8 @@ int pciehp_check_link_status(struct controller *ctrl)
 	}
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
-	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
+	__pcie_update_link_speed(ctrl->pcie->port->subordinate, PCIE_HOTPLUG,
+				 lnk_status, linksta2);
 
 	if (!found) {
 		ctrl_info(ctrl, "Slot(%s): No device found\n",
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..96755ffd3841 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4749,7 +4749,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * Link Speed.
 	 */
 	if (pdev->subordinate)
-		pcie_update_link_speed(pdev->subordinate);
+		pcie_update_link_speed(pdev->subordinate, PCIE_LINK_RETRAIN);
 
 	return rc;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b8d364545e7d..0ccd629e0ccb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -3,6 +3,7 @@
 #define DRIVERS_PCI_H
 
 #include <linux/pci.h>
+#include <trace/events/pci.h>
 
 struct pcie_tlp_log;
 
@@ -455,16 +456,31 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 }
 
 u8 pcie_get_supported_speeds(struct pci_dev *dev);
-const char *pci_speed_string(enum pci_bus_speed speed);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
 
-static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta, u16 linksta2)
+enum pcie_link_change_reason {
+	PCIE_LINK_RETRAIN,
+	PCIE_ADD_BUS,
+	PCIE_BWCTRL_ENABLE,
+	PCIE_BWCTRL_IRQ,
+	PCIE_HOTPLUG,
+};
+
+static inline void __pcie_update_link_speed(struct pci_bus *bus,
+					    enum pcie_link_change_reason reason,
+					    u16 linksta, u16 linksta2)
 {
 	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
 	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
+
+	trace_pcie_link_event(bus,
+			     reason,
+			     FIELD_GET(PCI_EXP_LNKSTA_NLW, linksta),
+			     linksta & PCI_EXP_LNKSTA_LINK_STATUS_MASK);
 }
-void pcie_update_link_speed(struct pci_bus *bus);
+
+void pcie_update_link_speed(struct pci_bus *bus, enum pcie_link_change_reason reason);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 36f939f23d34..32f1b30ecb84 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -199,7 +199,7 @@ static void pcie_bwnotif_enable(struct pcie_device *srv)
 	 * Update after enabling notifications & clearing status bits ensures
 	 * link speed is up to date.
 	 */
-	pcie_update_link_speed(port->subordinate);
+	pcie_update_link_speed(port->subordinate, PCIE_BWCTRL_ENABLE);
 }
 
 static void pcie_bwnotif_disable(struct pci_dev *port)
@@ -234,7 +234,7 @@ static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
 	 * speed (inside pcie_update_link_speed()) after LBMS has been
 	 * cleared to avoid missing link speed changes.
 	 */
-	pcie_update_link_speed(port->subordinate);
+	pcie_update_link_speed(port->subordinate, PCIE_BWCTRL_IRQ);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca7..c4cae2664156 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -21,6 +21,7 @@
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
+#include <trace/events/pci.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -788,14 +789,16 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 }
 EXPORT_SYMBOL_GPL(pci_speed_string);
 
-void pcie_update_link_speed(struct pci_bus *bus)
+void pcie_update_link_speed(struct pci_bus *bus,
+			    enum pcie_link_change_reason reason)
 {
 	struct pci_dev *bridge = bus->self;
 	u16 linksta, linksta2;
 
 	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
 	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &linksta2);
-	__pcie_update_link_speed(bus, linksta, linksta2);
+
+	__pcie_update_link_speed(bus, reason, linksta, linksta2);
 }
 EXPORT_SYMBOL_GPL(pcie_update_link_speed);
 
@@ -882,7 +885,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
 
-		pcie_update_link_speed(bus);
+		pcie_update_link_speed(bus, PCIE_ADD_BUS);
 	}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860..edd8a61ec44e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -305,6 +305,7 @@ enum pci_bus_speed {
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
+const char *pci_speed_string(enum pci_bus_speed speed);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 
diff --git a/include/trace/events/pci.h b/include/trace/events/pci.h
index 208609492c06..4df4daaa2d27 100644
--- a/include/trace/events/pci.h
+++ b/include/trace/events/pci.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_HW_EVENT_PCI_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_HW_EVENT_PCI_H
 
+#include <uapi/linux/pci_regs.h>
 #include <linux/tracepoint.h>
 
 #define PCI_HOTPLUG_EVENT						\
@@ -57,6 +58,62 @@ TRACE_EVENT(pci_hp_event,
 	)
 );
 
+#define PCI_EXP_LNKSTA_LINK_STATUS_MASK (PCI_EXP_LNKSTA_LBMS | \
+					 PCI_EXP_LNKSTA_LABS | \
+					 PCI_EXP_LNKSTA_LT | \
+					 PCI_EXP_LNKSTA_DLLLA)
+
+#define LNKSTA_FLAGS					\
+	{ PCI_EXP_LNKSTA_LT,	"LT"},			\
+	{ PCI_EXP_LNKSTA_DLLLA,	"DLLLA"},		\
+	{ PCI_EXP_LNKSTA_LBMS,	"LBMS"},		\
+	{ PCI_EXP_LNKSTA_LABS,	"LABS"}
+
+TRACE_EVENT(pcie_link_event,
+
+	TP_PROTO(struct pci_bus *bus,
+		  unsigned int reason,
+		  unsigned int width,
+		  unsigned int status
+		),
+
+	TP_ARGS(bus, reason, width, status),
+
+	TP_STRUCT__entry(
+		__string(	port_name,	pci_name(bus->self))
+		__field(	unsigned int,	type		)
+		__field(	unsigned int,	reason		)
+		__field(	unsigned int,	cur_bus_speed	)
+		__field(	unsigned int,	max_bus_speed	)
+		__field(	unsigned int,	width		)
+		__field(	unsigned int,	flit_mode	)
+		__field(	unsigned int,	link_status	)
+	),
+
+	TP_fast_assign(
+		__assign_str(port_name);
+		__entry->type			= pci_pcie_type(bus->self);
+		__entry->reason			= reason;
+		__entry->cur_bus_speed		= bus->cur_bus_speed;
+		__entry->max_bus_speed		= bus->max_bus_speed;
+		__entry->width			= width;
+		__entry->flit_mode		= bus->flit_mode;
+		__entry->link_status		= status;
+	),
+
+	TP_printk("%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_speed:%s, width:%u, flit_mode:%u, status:%s\n",
+		__get_str(port_name),
+		__entry->type,
+		__entry->reason,
+		pci_speed_string(__entry->cur_bus_speed),
+		pci_speed_string(__entry->max_bus_speed),
+		__entry->width,
+		__entry->flit_mode,
+		__print_flags((unsigned long)__entry->link_status, "|",
+				LNKSTA_FLAGS)
+	)
+);
+
 #endif /* _TRACE_HW_EVENT_PCI_H */
 
 /* This part must be outside protection */
-- 
2.39.3


