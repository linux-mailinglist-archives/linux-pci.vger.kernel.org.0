Return-Path: <linux-pci+bounces-16305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEBA9C146C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 04:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8891C2172F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 03:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DC142A8B;
	Fri,  8 Nov 2024 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nOIMcS0E"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6023AD;
	Fri,  8 Nov 2024 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035397; cv=none; b=DavyqPsEpBuP2u++1YBqF3wrKXtkazGlVtChngRz/mJv5LKC0YVcmTHRgjRcW/AlbMhsUzk6unqhrHYC6NeRtv2ujB1Ab5IuwjA6bXJBBlZC9SPTs0wL0wZPyfZlHBeL7Rl/avJ48ai1KpPZ2Tp7q6adoLcsXhN9sv1Zr+iGp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035397; c=relaxed/simple;
	bh=tM1pR8TKK7ZKYeegcfr244XmLHwNyRm9IzTCiFMK1AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RhUTcNm5cahoIn/X3PZQKV2WiWN6S7OcDiXW/XZVfaVllxGZ22Kf9QnI3iZNhwHo+k/mnSO4DHwS8kM7ELmU06YUX2lVHN8Z0i8POCl808QRIJhgyhwJA/4/MM4Ny5pj0pHhp3PNBOCqp7Dx4oFhNMmTiu3ZNd+VyfRZj1DdG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nOIMcS0E; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731035390; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hI81Djwcg6ZZcAshpSQgUj5LCMyiBG92gqnXt5vhYrY=;
	b=nOIMcS0EmFEjzrZL65BJ+QK22rL483IDV1hV1J1FfVZExV+g+JhhcFx0tBfOgS/hVO+x1ZbeJMHTMrGvJlbIr499EFPwsB91XsVprQULoQjQJJcmRhzK5fNHpuYx0+xRhATlRrgxjlEeuz17AGU7kvruC3VMe8WLgfoHSTBD5oc=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIxQzNA_1731035388 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 11:09:50 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: bhelgaas@google.com,
	tony.luck@intel.com,
	bp@alien8.de,
	xueshuai@linux.alibaba.com
Subject: [RFC PATCH] PCI: pciehp: Generate a RAS tracepoint for hotplug event
Date: Fri,  8 Nov 2024 11:09:39 +0800
Message-ID: <20241108030939.75354-1-xueshuai@linux.alibaba.com>
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
significantly impact system performance and reliability. The failure
characterization analysis illustrates the significance of failures
caused by the Infiniband link errors.  Meta observe that 2% in a machine
learning cluster and 6% in a vision application cluster of Infiniband
failures co-occur with GPU failures, such as falling off the bus, which
may indicate a correlation with PCIe.[1]

Generate a RAS tracepoint for hotplug event to help healthy check.

The output like below:
$ echo 1 > /sys/kernel/debug/tracing/events/ras/pciehp_event/enable
$ cat /sys/kernel/debug/tracing/trace_pipe
           <...>-213     [001] .....    43.762740: pciehp_event: 0000:00:02.0 slot:10, state:5, events:65792

[1]https://arxiv.org/abs/2410.21680

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |  5 +++++
 include/ras/ras_event.h           | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index dcdbfcf404dd..ec9285e3b9b5 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
+#include <ras/ras_event.h>
 #include "pciehp.h"
 
 /* The following routines constitute the bulk of the
@@ -245,6 +246,8 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		if (events & PCI_EXP_SLTSTA_PDC)
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
 				  slot_name(ctrl));
+		trace_pciehp_event(dev_name(&ctrl->pcie->port->dev),
+				   slot_name(ctrl), ON_STATE, events);
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
@@ -282,6 +285,8 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		if (link_active)
 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
 				  slot_name(ctrl));
+		trace_pciehp_event(dev_name(&ctrl->pcie->port->dev),
+				   slot_name(ctrl), OFF_STATE, events);
 		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..5013d6ff920e 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -338,6 +338,35 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 
+TRACE_EVENT(pciehp_event,
+	TP_PROTO(const char *port_name,
+		 const char *slot,
+		 const u8 state,
+		 const u32 events),
+
+	TP_ARGS(port_name, slot, state, events),
+
+	TP_STRUCT__entry(
+		__string(	port_name,	port_name	)
+		__string(	slot,		slot		)
+		__field(	u8,		state		)
+		__field(	u32,		events		)
+	),
+
+	TP_fast_assign(
+		__assign_str(port_name);
+		__assign_str(slot);
+		__entry->state		= state;
+		__entry->events		= events;
+	),
+
+	TP_printk("%s slot:%s, state:%d, events:%d\n",
+		__get_str(port_name),
+		__get_str(slot),
+		__entry->state,
+		__entry->events)
+);
+
 /*
  * memory-failure recovery action result event
  *
-- 
2.39.3


