Return-Path: <linux-pci+bounces-44315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB8D07009
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 04:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EBED3019B52
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 03:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5116A395;
	Fri,  9 Jan 2026 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hAva6aqc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49218.qiye.163.com (mail-m49218.qiye.163.com [45.254.49.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2333987;
	Fri,  9 Jan 2026 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929736; cv=none; b=NaBTO6Tv+nVjeEkDy5ZS5J3FHxyxph8ZeggF9QUoBZNdCZLuyylQc6WawAyAezdpN6CO2D9i0wxIMVVgdwKfRgdqbcmNW8p9eUpSTA8mpRIHCjaD4EX7FA6Ujf7uzXaXDsLuDlW1Tl1QY7bOzc+xvJvoeUANOw/06iXr6Y80Mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929736; c=relaxed/simple;
	bh=4N9eocZwqn4fYVwLR2fw4gvFv1i7FjnDCcjRAD0TKi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jXBObHULchbeIOkKta9VTgky5LiZAKJbcd5Q+nr4BxpDqIFwweCPIyo6K24P8Dg5Lsw33BOIfFqdJIGp7mdKGN8Sjc7/jWyFqyMj04xdPAis9OYNSTfoUqAL7RRDYplL1S/Eamc22jNsoWlutM7X18RPQmUdZfqDHFHcc5pn04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hAva6aqc; arc=none smtp.client-ip=45.254.49.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30079381d;
	Fri, 9 Jan 2026 11:30:14 +0800 (GMT+08:00)
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
Subject: [PATCH v2 1/3] PCI: trace: Add PCI controller LTSSM transition tracepoint
Date: Fri,  9 Jan 2026 11:29:47 +0800
Message-Id: <1767929389-143957-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9ba0ce046a09cckunm22b4d6c66b9d0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9CTFZNGUMYGk5DS0wZSExWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	pVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hAva6aqchK7biBwKARd9U+DIFhw2WoW0xYi4NxqBCnWAOOagk3ChaPdqJtC4KAikjAvFWNZENgqwq3JGOY8m4OOpmGOVJlIMyzFZLHsAYZvFr2Lo3fHrCeW14J9nCCsVgWt9yBjQawyJKEbqnF0lfPDkfyRucrJjHpOfsR9jO/k=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=i08S/nmL7O46KuoZksfkUSbqUI8SI00SQLBmIK4mKe8=;
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

Changes in v2: None

 drivers/pci/trace.c                   |  1 +
 include/trace/events/pci_controller.h | 44 +++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
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
index 0000000..47d54c6
--- /dev/null
+++ b/include/trace/events/pci_controller.h
@@ -0,0 +1,44 @@
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


