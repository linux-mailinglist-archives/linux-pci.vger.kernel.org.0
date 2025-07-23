Return-Path: <linux-pci+bounces-32770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D91B0E919
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 05:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2B21C832FF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A591247283;
	Wed, 23 Jul 2025 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m9JoGrYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B193246772;
	Wed, 23 Jul 2025 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241497; cv=none; b=I8openSgiXkwd5UxDfnE5NQJDm4DPA6xS5etgEY4AA9JOKetcvylhFYZIDBCvLAPDU9UPPNLxYwENa619w47LVhN9M5u5wrQWyPlLwNHAYgIGnC9WhsY+Yjp6EiYOVj4lK6TZrFLakTGJSTziKXopj7U0ewNCwYBvfPCh7rVzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241497; c=relaxed/simple;
	bh=e8i5hvMewpM5WhmWIf81bh1V/+nLOoUrOKoPhXM0Cpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9g2jsABf6lxDicBlL/RjHSZVjoTw/HElYO2JvHeDVbKOJgPfA9FZx8OX/RvfhDSD8iP0KRNraryLuyDbuvKSwNlmtQt9Tb9FYcdoGXeXkfJmZpiwt5j9H0WA7U9GdNB0ZhBJdWNXql/9N1L1ry8ZBdaxAWdMWcZp17BddN1sDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m9JoGrYn; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753241484; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BUXbFKuhUPKjwkP0e/ba8Z6kdLZ3HLdqyrAWba7LI8I=;
	b=m9JoGrYnc8CiFo/y6vHd8Z5HylHBc/uamvvwzpAfQxLg3hrLMLXlBolVCO/8e5ZDMsmuUfc0z8QYxtjKxWv+9ZFcQ/7GSPnMr6Ln7iXElnT/SuQsU/uCoWsDdFRZ5kh3WvuCzCBFHyqtvXzZj5KVvSL8mJTOF7791+tuQL36lWc=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjZukuI_1753241482 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 11:31:22 +0800
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
Subject: [PATCH v9 1/2] PCI: trace: Add a generic RAS tracepoint for hotplug event
Date: Wed, 23 Jul 2025 11:31:07 +0800
Message-Id: <20250723033108.61587-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250723033108.61587-1-xueshuai@linux.alibaba.com>
References: <20250723033108.61587-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hotplug events are critical indicators for analyzing hardware health,
and surprise link downs can significantly impact system performance and
reliability.

Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
for hotplug event to help health checks. Add enum pci_hotplug_event in
include/uapi/linux/pci.h so applications like rasdaemon can register
tracepoint event handlers for it.

The output is like below:

$ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
$ cat /sys/kernel/debug/tracing/trace_pipe
    <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_DOWN

    <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_NOT_PRESENT

Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 33 +++++++++++++---
 include/trace/events/pci.h        | 63 +++++++++++++++++++++++++++++++
 include/uapi/linux/pci.h          |  7 ++++
 3 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/pci.h

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bcc938d4420f..d241f270c8de 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -20,6 +20,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/pci.h>
+
 #include "../pci.h"
 #include "pciehp.h"
 
@@ -244,12 +247,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
@@ -269,6 +280,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 					      INDICATOR_NOOP);
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
 				  slot_name(ctrl));
+			trace_pci_hp_event(pci_name(ctrl->pcie->port),
+					   slot_name(ctrl),
+					   PCI_HOTPLUG_CARD_NOT_PRESENT);
 		}
 		mutex_unlock(&ctrl->state_lock);
 		return;
@@ -281,12 +295,19 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
diff --git a/include/trace/events/pci.h b/include/trace/events/pci.h
new file mode 100644
index 000000000000..208609492c06
--- /dev/null
+++ b/include/trace/events/pci.h
@@ -0,0 +1,63 @@
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


