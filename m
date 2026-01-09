Return-Path: <linux-pci+bounces-44313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CFCD06FDF
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 04:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB5A23019BBD
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51002235BE2;
	Fri,  9 Jan 2026 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GRA+VPa7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3294.qiye.163.com (mail-m3294.qiye.163.com [220.197.32.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D861925BC;
	Fri,  9 Jan 2026 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929429; cv=none; b=YGOauPanHur365QfRJErYfmCkXyE234Lf0tXGwm4UdmU3SajoVZV5NutDrwv58rY+6eTYTXzPhnEA0zYuMa1mJutupx0c2ylMyPWu5NyFtCEDU858/aeHw5f8WTwqas6GuAVVqXI1wj9sPApBAPbece+XX+LVZH5nPqWvd44FOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929429; c=relaxed/simple;
	bh=Z2AOheaRyTKoa4eKdWLKbN6ZlONk4KlQ1HzH3j78jD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JhM6h5XpAZpc8sKx50y1DMsX507Dy5grLBs3T1pf1VKLlV9zdSPQDnalBI9ylOgBULT+hfiBy21xcr1DhlRW5TDWG2MPlwQvohFCW6jW/P97oV7RhVNOXCi3E1V9y0YrrcignkItMSyYs9D0CRPW3RN2QoZ94o2wKge7Z78rDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GRA+VPa7; arc=none smtp.client-ip=220.197.32.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30079383f;
	Fri, 9 Jan 2026 11:30:20 +0800 (GMT+08:00)
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
Subject: [PATCH v2 2/3] Documentation: tracing: Add PCI controller event documentation
Date: Fri,  9 Jan 2026 11:29:48 +0800
Message-Id: <1767929389-143957-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9ba0ce18f709cckunm22b4d6c66ba24
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpPTFZPQ0seSk1PGk5DGUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=GRA+VPa7x561UGIY01XJaPAMGI6fxMn6JuSCwA9i6CC2NZ+320nr5ZKJBGUr7WyZ93xKVoGm3JRWgyMmIpyLIQVCCWWwQpi0mnCfhy6LaIzyzWk1TeQbq+q2Sh2TSekmdZ6M5HtAn6Z/1G9JfirhEcBMriFqbDl9WmQdJ3osbS4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=KJlKjShPuR5n49PnlmzBndjHgapvw97Q1f3mXNv5yPQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The available tracepoint, pcie_ltssm_state_transition, monitors the LTSSM state
transistion for debugging purpose. Add description about it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 Documentation/trace/events-pci-conotroller.rst | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/trace/events-pci-conotroller.rst

diff --git a/Documentation/trace/events-pci-conotroller.rst b/Documentation/trace/events-pci-conotroller.rst
new file mode 100644
index 0000000..8253d00
--- /dev/null
+++ b/Documentation/trace/events-pci-conotroller.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Subsystem Trace Points: PCI Controller
+======================================
+
+Overview
+========
+The PCI controller tracing system provides tracepoints to monitor controller level
+information for debugging purpose. The events normally show up here:
+up here:
+
+	/sys/kernel/tracing/events/pci_controller
+
+Cf. include/trace/events/pci_controller.h for the events definitions.
+
+Available Tracepoints
+=====================
+
+pcie_ltssm_state_transition
+-----------------------
+
+Monitors PCIe LTSSM state transition including state and rate information
+::
+
+    pcie_ltssm_state_transition  "dev: %s state: %s rate: %s\n"
+
+**Parameters**:
+
+* ``dev`` - PCIe root port name
+* ``state`` - PCIe LTSSM state
+* ``rate`` - PCIe bus speed
+
+**Example Usage**:
+
+    # Enable the tracepoint
+    echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_ltssm_state_transition/enable
+
+    # Monitor events (the following output is generated when a device is linking)
+    cat /sys/kernel/debug/tracing/trace_pipe
+       kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s
-- 
2.7.4


