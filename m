Return-Path: <linux-pci+bounces-16525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5968F9C5944
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 14:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 211EBB2949B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E5E1F77A6;
	Tue, 12 Nov 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NxR/95k/"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B061F778C;
	Tue, 12 Nov 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412756; cv=none; b=QAj6vUzHo2/Kvq0QzHpk82K8SVV9tjRzWH3AayvMgQqLkmVF/ExktonBL0a9kL0QOD9DCUaWfFIKvTkJVz3X8GGB9rDaUtT7ITOyMSxKEJpzCs9EMHS2gcvcnMnVa3czoasiUP8anxWkTnxpnFvidSh7XtG3wxKBCDMxYWuw13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412756; c=relaxed/simple;
	bh=MZPW3KmuIhosXQiR1sUnukYbEwz7Ryg7lEeyBumQp40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq1Ik83ncUoB5KpXZ4KwSF64IuwrQ+uJ5yD9que9bVxNVh10/LBssavEHkRHJ6d+mEAUyvUS2l+51G2Mqmz/8JQsPsHXe3uFf5Qxrcdd4f7Fqh/ybWNwBrqx0oBLVikpDyeatLtCYnQSLR2nAV+3FzUR5y/hbc2OvpHOa/jOl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NxR/95k/; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731412745; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7E4XIGVwFEQzfYl+p4x9wcXN7MWG+kSABSQ6uIWRSCk=;
	b=NxR/95k/U6jw94d2UPcWCY1K3lF9uGrIE7e183A1FdtzswL2uOyTKGBtk1ykqjMrlREU1W5FRlaLk0x6D6afQqrBK6bTer/ax/79XkplSxmjpYG1yTNOWvdFO1Wyt4HUDz49ziseVRoFjMhBZOei+zaYRaJ1G0+f/8YoNE4zsXs=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJHYqx9_1731412744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 19:59:05 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: bhelgaas@google.com,
	tony.luck@intel.com,
	bp@alien8.de,
	xueshuai@linux.alibaba.com
Subject: [PATCH v2 2/2] pci: pciehp: Generate tracepoints for hotplug event
Date: Tue, 12 Nov 2024 19:58:52 +0800
Message-ID: <20241112115852.52980-3-xueshuai@linux.alibaba.com>
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

Generate tracepoints for hotplug event.

The output like below:

$ echo 1 > /sys/kernel/debug/tracing/events/hotplug/pci_hp_event/enable
$ cat /sys/kernel/debug/tracing/trace_pipe
           <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, trans_state:Link Down

           <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, trans_state:Card not present

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 33 +++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index dcdbfcf404dd..ba099cb19f5e 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -21,6 +21,9 @@
 #include <linux/pci.h>
 #include "pciehp.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 /* The following routines constitute the bulk of the
    hotplug controller logic
  */
@@ -239,12 +242,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
+					   PCI_HOTPLUG_CARD_NO_PRESENT);
+		}
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
@@ -264,6 +275,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 					      INDICATOR_NOOP);
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
 				  slot_name(ctrl));
+			trace_pci_hp_event(pci_name(ctrl->pcie->port),
+					   slot_name(ctrl),
+					   PCI_HOTPLUG_CARD_NO_PRESENT);
 		}
 		mutex_unlock(&ctrl->state_lock);
 		return;
@@ -276,12 +290,19 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
-- 
2.39.3


