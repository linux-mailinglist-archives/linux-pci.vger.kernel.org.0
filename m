Return-Path: <linux-pci+bounces-44456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D97D104B0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 02:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3A98302628D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 01:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B623AB81;
	Mon, 12 Jan 2026 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DDJXQQXX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D31A724C;
	Mon, 12 Jan 2026 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182964; cv=none; b=oab+lxjnf1xTKWLDgmXlZ4IjYSvtNnWRb7V/iieEHpq1dIUn7qZPkdAjtDb9iyeZ/UjSCtfodjzayUOjBpWf1JhRF98+tbQ77EMhEP/1NXwvKeQ8w0puDLpy6iPmuNws62PFgX3dw9GszEI6WGSPcFvkwQFItCXmkWk9RQaxjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182964; c=relaxed/simple;
	bh=Ji3o3VTdkNoMJrT598sG6cuYDK2tWPZdX9NSUfmDoHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I6yugWDu5tB/GUDnUJzWHhkfkjycU+TEZj7kvDBTI0Wgr8CPQ7uuYgtLQIxpqtFogMV/2qHiPfgIY0ZFXLS7vGswvr5UGWj10JGBG9KR20GBe+p82hDcCoQX+1IZn1HrD5vVsQWnRJe9q3IE3u9HNp9LB+CpLPqau1nwFsjLkBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DDJXQQXX; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 303e91922;
	Mon, 12 Jan 2026 09:20:30 +0800 (GMT+08:00)
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
Subject: [PATCH v3 2/3] Documentation: tracing: Add PCI controller event documentation
Date: Mon, 12 Jan 2026 09:19:59 +0800
Message-Id: <1768180800-63364-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1768180800-63364-1-git-send-email-shawn.lin@rock-chips.com>
References: <1768180800-63364-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9bafca4f3c09cckunme7c7221b25b204
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkdGVYeHxoeGkoZQhpKTElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DDJXQQXXevGUrEwIRp2Q+7eNb9izplE0xp8Pm0od0lIqhT/HO0ICHV8QiivaqcP/ocs1q9VFwscyixbDBthnVwElUHYMVWi+yZxvP9VF1d/NHzdG8QlEiyP7DAWg6Du9fvTxMTC27zpLL67AnGUN4Qg//ajDlEY+RQX3DkwzUjI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=jrtqB0XixpQ4tlxWZHgOuOxBO23AIyReEKgVZo9dQFk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The available tracepoint, pcie_ltssm_state_transition, monitors the LTSSM state
transition for debugging purpose. Add description about it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3:
- Add toctree entry in Documentation/trace/index.rst(Bagas Sanjaya)
- fix mismatch section underline length(Bagas Sanjaya)
- Make example snippets in code block(Bagas Sanjaya)
- warp context into 80 columns and fix the file name(Bjorn)

Changes in v2: None

 Documentation/trace/events-pci-controller.rst | 42 +++++++++++++++++++++++++++
 Documentation/trace/index.rst                 |  1 +
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/trace/events-pci-controller.rst

diff --git a/Documentation/trace/events-pci-controller.rst b/Documentation/trace/events-pci-controller.rst
new file mode 100644
index 0000000..cb9f715
--- /dev/null
+++ b/Documentation/trace/events-pci-controller.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Subsystem Trace Points: PCI Controller
+======================================
+
+Overview
+========
+The PCI controller tracing system provides tracepoints to monitor controller
+level information for debugging purpose. The events normally show up here:
+
+	/sys/kernel/tracing/events/pci_controller
+
+Cf. include/trace/events/pci_controller.h for the events definitions.
+
+Available Tracepoints
+=====================
+
+pcie_ltssm_state_transition
+---------------------------
+
+Monitors PCIe LTSSM state transition including state and rate information
+::
+
+    pcie_ltssm_state_transition  "dev: %s state: %s rate: %s\n"
+
+**Parameters**:
+
+* ``dev`` - PCIe controller instance
+* ``state`` - PCIe LTSSM state
+* ``rate`` - PCIe date rate
+
+**Example Usage**:
+
+.. code-block:: shell
+
+    # Enable the tracepoint
+    echo 1 > /sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable
+
+    # Monitor events (the following output is generated when a device is linking)
+    cat /sys/kernel/debug/tracing/trace_pipe
+       kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 0a40bfa..6101317 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -55,6 +55,7 @@ applications.
    events-nmi
    events-msr
    events-pci
+   events-pci-controller
    boottime-trace
    histogram
    histogram-design
-- 
2.7.4


