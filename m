Return-Path: <linux-pci+bounces-44453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4F7D103EC
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 02:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 114A33001BF4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 01:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97F42222B2;
	Mon, 12 Jan 2026 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fxmbcvl9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m822136221.xmail.ntesmail.com (mail-m822136221.xmail.ntesmail.com [8.221.36.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCF217F33;
	Mon, 12 Jan 2026 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=8.221.36.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768180843; cv=none; b=MCqdpyqJ7UoCUcEU2Q5u3CTwHtmClg9v5QK44ifN8+AZZgLUUMTYsfyuKK4WrsvA5WsMW/N8RvtvInogL1lOyhQPa1S6DNsrudXmzfRFZsIVifnY5TQl562mKFowLS2/HWNUgsFYDfWUqYPsuxQ3nhgXaD/NPcV+n88j1PPMcr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768180843; c=relaxed/simple;
	bh=e21MoubmoqmD+PI+iPYoPux/N5nXa+TpIYPyt0GmOL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QgWQIqrIiRqade7CfHAk3z03qnLNT7TVKGGa5M/6E6quHfjplHkTUoP68k0TfK8fG3/1rTKWuxquNGuOFltyNp4oG1FRAvp6Sis1JmQiUuIyScR7BAklgtCOBqymvpFmZWAHN8Izcz72P42vWhOSqfOlPsFspvIOENtRPEpVkNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fxmbcvl9; arc=none smtp.client-ip=8.221.36.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 303e9191b;
	Mon, 12 Jan 2026 09:20:27 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/3] PCI: trace: Add PCI controller LTSSM transition tracepoint
Date: Mon, 12 Jan 2026 09:19:58 +0800
Message-Id: <1768180800-63364-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1768180800-63364-1-git-send-email-shawn.lin@rock-chips.com>
References: <1768180800-63364-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9bafca448409cckunme7c7221b25b1e3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4ZS1YZGhpJSx0aGUgeTUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	pVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fxmbcvl9QU7SQ960M8nAwr/VIUbe5NvESmiUx+PmKotOuoeblAq0CiYirx4jKgTjCn5TNq8jStqyT3zbhKGQWqxe6N1/YSpdTbSNkQfCQu1qH9/UrupucJTM8UpJBdOA293C1pux521fxpMhugcaTy5SU9el55au+OgrUE5d3aE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=NJvs7o/RNR1z93AUHCN9w99dXiQC+cJHE/GqfadvgSk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Some platforms may provide LTSSM trace functionality, recording historical
LTSSM state transition information. This is very useful for debugging, such
as when certain devices cannot be recognized or link broken during test.
Implement the pci controller tracepoint for recording LTSSM and rate.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3:
- add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)

Changes in v2: None

 drivers/pci/trace.c                   |  1 +
 include/trace/events/pci_controller.h | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/trace/events/pci_controller.h

diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
index cf11abc..c1da9d3 100644
--- a/drivers/pci/trace.c
+++ b/drivers/pci/trace.c
@@ -9,3 +9,4 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/pci.h>
+#include <trace/events/pci_controller.h>
diff --git a/include/trace/events/pci_controller.h b/include/trace/events/pci_controller.h
new file mode 100644
index 0000000..f38eedf
--- /dev/null
+++ b/include/trace/events/pci_controller.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pci_controller
+
+#if !defined(_TRACE_HW_EVENT_PCI_CONTROLLER_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HW_EVENT_PCI_CONTROLLER_H
+
+#include <uapi/linux/pci_regs.h>
+#include <linux/tracepoint.h>
+
+TRACE_DEFINE_ENUM(PCIE_SPEED_2_5GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_5_0GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_8_0GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_16_0GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_32_0GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_64_0GT);
+TRACE_DEFINE_ENUM(PCI_SPEED_UNKNOWN);
+
+TRACE_EVENT(pcie_ltssm_state_transition,
+	TP_PROTO(const char *dev_name, const char *state, u32 rate),
+	TP_ARGS(dev_name, state, rate),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__string(state, state)
+		__field(u32, rate)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name);
+		__assign_str(state);
+		__entry->rate = rate;
+	),
+
+	TP_printk("dev: %s state: %s rate: %s",
+		__get_str(dev_name), __get_str(state),
+		__print_symbolic(__entry->rate,
+			{ PCIE_SPEED_2_5GT,  "2.5 GT/s" },
+			{ PCIE_SPEED_5_0GT,  "5.0 GT/s" },
+			{ PCIE_SPEED_8_0GT,  "8.0 GT/s" },
+			{ PCIE_SPEED_16_0GT, "16.0 GT/s" },
+			{ PCIE_SPEED_32_0GT, "32.0 GT/s" },
+			{ PCIE_SPEED_64_0GT, "64.0 GT/s" },
+			{ PCI_SPEED_UNKNOWN, "Unknown" }
+		)
+	)
+);
+
+#endif /* _TRACE_HW_EVENT_PCI_CONTROLLER_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.4


