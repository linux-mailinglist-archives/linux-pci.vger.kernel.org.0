Return-Path: <linux-pci+bounces-42893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D74CB3060
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 14:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81938300855C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035B7326938;
	Wed, 10 Dec 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fgYl4odP"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532332039E;
	Wed, 10 Dec 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373365; cv=none; b=PyQkGcvqvcyqihLfCP2cBkTgQHVGUL0XlaMC58ls3YgMWCDx0CJxFBHYcB3/Y87Z361S9bY2Azo6lANjmNpPulD26+mJxi6+wpL3+In66XkG7U+taifxSvHHc7tfBZjhU+24bZ30rLtG934Qmv8k4y3xgYXD+VzAN+x+iRId/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373365; c=relaxed/simple;
	bh=eKEsiuZKQI47H3qp03ED/jJQGePLo1+5EhqHw3OEjTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj+Fkk98ne/J1fWmIIDOT9WkvMIYxy78wZViW2hGQ29UEDca4jDBDz9e5EiueqLatGAt3+gXOMEeMpcVCDNG3k/qO22mT9YR3MahWGJr4KQffvo5MvwFoi3VznvruEVWrbEzjdP7vrfgmH3RR1keiWdyfPdn+lOM9R6vJm0pz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fgYl4odP; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765373352; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=etQUc3bPTYvMnomg1+3c1ZkmuR/0U/CpuSu8BdiszFE=;
	b=fgYl4odPSx2k8Jy70eDtrJ20UCDtsyGxwrHfxvVXTh2/LaZGDkDQ+g3WChNHX/wy4Ky6PdOZPT0UjuNLYc5WtCcr2dGE9Zr1aDJ687FQwc8gPd1FVi7gzYOZV12E/CeSZlR/oWO57UugEii6pYpWSD2X+ZjPFa0lzCWWoF4TMt0=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuWtM4Z_1765373349 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Dec 2025 21:29:10 +0800
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
	Jonathan.Cameron@huawei.com,
	alok.a.tiwari@oracle.com
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
Subject: [PATCH v14 1/3] PCI: trace: Add a generic RAS tracepoint for hotplug event
Date: Wed, 10 Dec 2025 21:29:05 +0800
Message-Id: <20251210132907.58799-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251210132907.58799-1-xueshuai@linux.alibaba.com>
References: <20251210132907.58799-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hotplug events are critical indicators for analyzing hardware health,
and surprise link downs can significantly impact system performance and
reliability.

Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
for hotplug event to help health checks. Add enum pci_hotplug_event in
include/uapi/linux/pci.h so applications like rasdaemon can register
tracepoint event handlers for it.

The following output is generated when a device is hotplugged:

$ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
$ cat /sys/kernel/debug/tracing/trace_pipe
   irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_PRESENT

   irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_UP

Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: "Steven Rostedt (Google)" <rostedt@goodmis.org> # for trace event
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/Makefile              |  3 ++
 drivers/pci/hotplug/pciehp_ctrl.c | 31 ++++++++++---
 drivers/pci/trace.c               | 11 +++++
 include/trace/events/pci.h        | 72 +++++++++++++++++++++++++++++++
 include/uapi/linux/pci.h          |  7 +++
 5 files changed, 118 insertions(+), 6 deletions(-)
 create mode 100644 drivers/pci/trace.c
 create mode 100644 include/trace/events/pci.h

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e10cfe5a280b..8c259a9a8796 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -47,3 +47,6 @@ obj-y				+= controller/
 obj-y				+= switch/
 
 subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
+
+CFLAGS_trace.o := -I$(src)
+obj-$(CONFIG_TRACING)		+= trace.o
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bcc938d4420f..7805f697a02c 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
+#include <trace/events/pci.h>
 
 #include "../pci.h"
 #include "pciehp.h"
@@ -244,12 +245,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	case ON_STATE:
 		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
-		if (events & PCI_EXP_SLTSTA_DLLSC)
+		if (events & PCI_EXP_SLTSTA_DLLSC) {
 			ctrl_info(ctrl, "Slot(%s): Link Down\n",
 				  slot_name(ctrl));
-		if (events & PCI_EXP_SLTSTA_PDC)
+			trace_pci_hp_event(pci_name(ctrl->pcie->port),
+					   slot_name(ctrl),
+					   PCI_HOTPLUG_LINK_DOWN);
+		}
+		if (events & PCI_EXP_SLTSTA_PDC) {
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
 				  slot_name(ctrl));
+			trace_pci_hp_event(pci_name(ctrl->pcie->port),
+					   slot_name(ctrl),
+					   PCI_HOTPLUG_CARD_NOT_PRESENT);
+		}
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
@@ -269,6 +278,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 					      INDICATOR_NOOP);
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
 				  slot_name(ctrl));
+			trace_pci_hp_event(pci_name(ctrl->pcie->port),
+					   slot_name(ctrl),
+					   PCI_HOTPLUG_CARD_NOT_PRESENT);
 		}
 		mutex_unlock(&ctrl->state_lock);
 		return;
@@ -281,12 +293,19 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	case OFF_STATE:
 		ctrl->state = POWERON_STATE;
 		mutex_unlock(&ctrl->state_lock);
-		if (present)
+		if (present) {
 			ctrl_info(ctrl, "Slot(%s): Card present\n",
 				  slot_name(ctrl));
-		if (link_active)
-			ctrl_info(ctrl, "Slot(%s): Link Up\n",
-				  slot_name(ctrl));
+			trace_pci_hp_event(pci_name(ctrl->pcie->port),
+					   slot_name(ctrl),
+					   PCI_HOTPLUG_CARD_PRESENT);
+		}
+		if (link_active) {
+			ctrl_info(ctrl, "Slot(%s): Link Up\n", slot_name(ctrl));
+			trace_pci_hp_event(pci_name(ctrl->pcie->port),
+					   slot_name(ctrl),
+					   PCI_HOTPLUG_LINK_UP);
+		}
 		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
new file mode 100644
index 000000000000..cf11abca8602
--- /dev/null
+++ b/drivers/pci/trace.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Tracepoints for PCI system
+ *
+ * Copyright (C) 2025 Alibaba Corporation
+ */
+
+#include <linux/pci.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/pci.h>
diff --git a/include/trace/events/pci.h b/include/trace/events/pci.h
new file mode 100644
index 000000000000..39e512a167ee
--- /dev/null
+++ b/include/trace/events/pci.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pci
+
+#if !defined(_TRACE_HW_EVENT_PCI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HW_EVENT_PCI_H
+
+#include <linux/tracepoint.h>
+
+#define PCI_HOTPLUG_EVENT						\
+	EM(PCI_HOTPLUG_LINK_UP,			"LINK_UP")		\
+	EM(PCI_HOTPLUG_LINK_DOWN,		"LINK_DOWN")		\
+	EM(PCI_HOTPLUG_CARD_PRESENT,		"CARD_PRESENT")		\
+	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"CARD_NOT_PRESENT")
+
+/* Enums require being exported to userspace, for user tool parsing */
+#undef EM
+#undef EMe
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+PCI_HOTPLUG_EVENT
+
+/*
+ * Now redefine the EM() and EMe() macros to map the enums to the strings
+ * that will be printed in the output.
+ */
+#undef EM
+#undef EMe
+#define EM(a, b)	{a, b},
+#define EMe(a, b)	{a, b}
+
+/*
+ * Note: For generic PCI hotplug events, we pass already-resolved strings
+ * (port_name, slot) instead of driver-specific structures like 'struct
+ * controller'.  This is because different PCI hotplug drivers (pciehp, cpqphp,
+ * ibmphp, shpchp) define their own versions of 'struct controller' with
+ * different fields and helper functions. Using driver-specific structures would
+ * make the tracepoint interface non-generic and cause compatibility issues
+ * across different drivers.
+ */
+TRACE_EVENT(pci_hp_event,
+
+	TP_PROTO(const char *port_name,
+		 const char *slot,
+		 const int event),
+
+	TP_ARGS(port_name, slot, event),
+
+	TP_STRUCT__entry(
+		__string(	port_name,	port_name	)
+		__string(	slot,		slot		)
+		__field(	int,		event	)
+	),
+
+	TP_fast_assign(
+		__assign_str(port_name);
+		__assign_str(slot);
+		__entry->event = event;
+	),
+
+	TP_printk("%s slot:%s, event:%s\n",
+		__get_str(port_name),
+		__get_str(slot),
+		__print_symbolic(__entry->event, PCI_HOTPLUG_EVENT)
+	)
+);
+
+#endif /* _TRACE_HW_EVENT_PCI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/uapi/linux/pci.h b/include/uapi/linux/pci.h
index a769eefc5139..4f150028965d 100644
--- a/include/uapi/linux/pci.h
+++ b/include/uapi/linux/pci.h
@@ -39,4 +39,11 @@
 #define PCIIOC_MMAP_IS_MEM	(PCIIOC_BASE | 0x02)	/* Set mmap state to MEM space. */
 #define PCIIOC_WRITE_COMBINE	(PCIIOC_BASE | 0x03)	/* Enable/disable write-combining. */
 
+enum pci_hotplug_event {
+	PCI_HOTPLUG_LINK_UP,
+	PCI_HOTPLUG_LINK_DOWN,
+	PCI_HOTPLUG_CARD_PRESENT,
+	PCI_HOTPLUG_CARD_NOT_PRESENT,
+};
+
 #endif /* _UAPILINUX_PCI_H */
-- 
2.39.3


