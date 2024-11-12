Return-Path: <linux-pci+bounces-16526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C179C5724
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 12:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE70283488
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E041F77A5;
	Tue, 12 Nov 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nMl2PzJO"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634251F778B;
	Tue, 12 Nov 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412756; cv=none; b=kSXADqmRA5D9GglMFBz0AZVLvVQcHqGPEGHjwioibsxTy8Mjb0K6IMURhygSbvHfGLU9Hg7ZKqDWMGitBkRWEH/gVYPeSwti1roZhwpRU2wHtuN1fTEslfXC0oTnO18KyvAi2JbAaz3Tv1ZKrqo8VGeiH6OEEhbP3Jj8EUp0Pr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412756; c=relaxed/simple;
	bh=Ap/l3omHJrawAz/AJvQPhDYsp+GUXJzj9zpoEP54D5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEwuU1FQs7UuqCA6+9okkJAmOQBUdv6kP7/S4oT41SoIc6UPA63xHqTFKsOHP8QJ+WTENdgS7LauxWKYJ3+CJs2E7Jes2ZRxdX0I+J6y1UdJMTSA3I39dDERIXQuWN7gJDyxZjIXxRif/ZRNG3gJWvr0IH7xwB5KwzDZ25cYc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nMl2PzJO; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731412745; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=235CE37JET+UgH7IPnuOtnr+0hOs1QWXhkBWfkJD5SA=;
	b=nMl2PzJOAvABO6xTPixIuXGLAV7BgUProlcz0rM+dwSQs5Scxk5U4TrzeRLk9Ype6bJXwcJmCzt5yU2QYFkFkcumsCZxVfNbTVvK+Jt+8FSP4n7r0NNNYFIQVMGNntraNvVzIGay8wRMxbesKz0SDJokBWIdiPx/JVpAlCkdvWo=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJHYqws_1731412744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 19:59:04 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: bhelgaas@google.com,
	tony.luck@intel.com,
	bp@alien8.de,
	xueshuai@linux.alibaba.com
Subject: [PATCH v2 1/2] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Tue, 12 Nov 2024 19:58:51 +0800
Message-ID: <20241112115852.52980-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241112115852.52980-1-xueshuai@linux.alibaba.com>
References: <20241112115852.52980-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hotplug events are critical indicators for analyzing hardware health,
particularly in AI supercomputers where surprise link downs can
significantly impact system performance and reliability. The failure
characterization analysis illustrates the significance of failures
caused by the Infiniband link errors. Meta observes that 2% in a machine
learning cluster and 6% in a vision application cluster of Infiniband
failures co-occur with GPU failures, such as falling off the bus, which
may indicate a correlation with PCIe.[1]

Add a generic RAS tracepoint for hotplug event to help healthy check.

[1]https://arxiv.org/abs/2410.21680

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/hotplug/trace.h | 68 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci.h    |  7 ++++
 2 files changed, 75 insertions(+)
 create mode 100644 drivers/pci/hotplug/trace.h

diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
new file mode 100644
index 000000000000..a56e22534bc0
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
+#define TRACE_SYSTEM hotplug
+
+#define PCI_HP_TRANS_STATE					\
+	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
+	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
+	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
+	EMe(PCI_HOTPLUG_CARD_NO_PRESENT,	"Card not present")
+
+/* Enums require being exported to userspace, for user tool parsing */
+#undef EM
+#undef EMe
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+PCI_HP_TRANS_STATE
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
+		 const int trans_state),
+
+	TP_ARGS(port_name, slot, trans_state),
+
+	TP_STRUCT__entry(
+		__string(	port_name,	port_name	)
+		__string(	slot,		slot		)
+		__field(	int,		trans_state	)
+	),
+
+	TP_fast_assign(
+		__assign_str(port_name);
+		__assign_str(slot);
+		__entry->trans_state = trans_state;
+	),
+
+	TP_printk("%s slot:%s, trans_state:%s\n",
+		__get_str(port_name),
+		__get_str(slot),
+		__print_symbolic(__entry->trans_state, PCI_HP_TRANS_STATE)
+	)
+);
+
+#endif /* _TRACE_HW_EVENT_PCI_HP_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH  ../../drivers/pci/hotplug
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/uapi/linux/pci.h b/include/uapi/linux/pci.h
index a769eefc5139..1f751785a43d 100644
--- a/include/uapi/linux/pci.h
+++ b/include/uapi/linux/pci.h
@@ -39,4 +39,11 @@
 #define PCIIOC_MMAP_IS_MEM	(PCIIOC_BASE | 0x02)	/* Set mmap state to MEM space. */
 #define PCIIOC_WRITE_COMBINE	(PCIIOC_BASE | 0x03)	/* Enable/disable write-combining. */
 
+enum pci_hotplug_trans_type {
+	PCI_HOTPLUG_LINK_UP,
+	PCI_HOTPLUG_LINK_DOWN,
+	PCI_HOTPLUG_CARD_PRESENT,
+	PCI_HOTPLUG_CARD_NO_PRESENT,
+};
+
 #endif /* _UAPILINUX_PCI_H */
-- 
2.39.3


