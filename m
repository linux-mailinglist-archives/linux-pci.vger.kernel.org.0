Return-Path: <linux-pci+bounces-27562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701EBAB2D44
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFCF16540D
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008098633F;
	Mon, 12 May 2025 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C0Ms8ztr"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66265BE4A;
	Mon, 12 May 2025 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013927; cv=none; b=KC0AhcCr9Jw9yxt6VopFbMmcWLMgYASlJeSdhlstr1bnsncyS5PYTt9SvPiARmnamUPu3Jfsebmde/WzIe5eXhXmmmKvOb2p9cCwBNAqIyQ4ylG/ol23Poie07bjpAZymX6tcxZyFFmj/2xTVyVipIUGk5uq22RAI4j+hZ0JfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013927; c=relaxed/simple;
	bh=uSZA2lmYixoSogdOaDu8s/wyNYgZcvJd8hzamOlPS4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyvA0RtnjGOcM/wyEu/IXC3RYEbDfBFYwdEmN1G8NIwPsYFn394GhpHPgQqrimeb7GC3dYOZVUYtnS3ctmTBiIdTnxJY+NLSQN20dIurx60DrhI1V+DpgC/XV2QCaWxG30mdkwkyLHBOW/AiYJlEx25Pkhf8TfsiUhVBF8zLVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C0Ms8ztr; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747013922; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=V9q0sf3g93s0nWBse7LhUuLgRfg0z0G5/pexwXedHVA=;
	b=C0Ms8ztrxXDAvsi63F04PtSmKC2BKecPwPw6bLrMFMH83vUnEujwkY/k2c7HNekXaEPhqhTX4OEsV+mMXHHcb3S1WCGCMlbCq2Kw4fMFKcF1SYK3iRGEHN5pTICqEn9Y7ivn8MViISTwP42L66a6zumA/73c+IZMCqhW3WzEMp4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WaCSN28_1747013920 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 May 2025 09:38:41 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: rostedt@goodmis.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	helgaas@kernel.org
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
Subject: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Mon, 12 May 2025 09:38:39 +0800
Message-ID: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hotplug events are critical indicators for analyzing hardware health,
particularly in AI supercomputers where surprise link downs can
significantly impact system performance and reliability.

To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
tracepoint for hotplug event to help healthy check, and generate
tracepoints for pcie hotplug event. Add enum pci_hotplug_event in
include/uapi/linux/pci.h so applications like rasdaemon can register
tracepoint event handlers for it.

The output like below:

$ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
$ cat /sys/kernel/debug/tracing/trace_pipe
    <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down

    <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present

Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
changes since v7:
- replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
- pick up Reviewed-by from Lukas Wunner
---
 drivers/pci/hotplug/Makefile      |  3 ++
 drivers/pci/hotplug/pciehp_ctrl.c | 33 ++++++++++++---
 drivers/pci/hotplug/trace.h       | 68 +++++++++++++++++++++++++++++++
 include/uapi/linux/pci.h          |  7 ++++
 4 files changed, 105 insertions(+), 6 deletions(-)
 create mode 100644 drivers/pci/hotplug/trace.h

diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 40aaf31fe338..a1a9d1e98962 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -3,6 +3,9 @@
 # Makefile for the Linux kernel pci hotplug controller drivers.
 #
 
+# define_trace.h needs to know how to find our header
+CFLAGS_pciehp_ctrl.o				:= -I$(src)
+
 obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
 obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index d603a7aa7483..f9beb4d3a9b8 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -23,6 +23,9 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 /* The following routines constitute the bulk of the
    hotplug controller logic
  */
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
diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
new file mode 100644
index 000000000000..21329c198019
--- /dev/null
+++ b/drivers/pci/hotplug/trace.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(_TRACE_HW_EVENT_PCI_HP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HW_EVENT_PCI_HP_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pci
+
+#define PCI_HOTPLUG_EVENT					\
+	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
+	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
+	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
+	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")
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
+#endif /* _TRACE_HW_EVENT_PCI_HP_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
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


