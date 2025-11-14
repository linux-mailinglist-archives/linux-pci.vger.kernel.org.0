Return-Path: <linux-pci+bounces-41212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE7C5B969
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 07:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71F564EB45A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 06:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8862B221F1F;
	Fri, 14 Nov 2025 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YfCS6q7F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com [220.197.32.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8121EDA2B
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763102225; cv=none; b=LUOLU923JoyThbq11oGJR/4V+DZM1TFq8L85lIi3ZFvEx8wONZfICvlljxleIwMaSumooaXlFdRHqkHVHjWy2eKQpcet3DkB+Y6nyS3/lSeoSjngT4nfLkJfZZtRSy34oLuhaSxPZYehdi/32mUujodQje80aaPLgKAcOswkU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763102225; c=relaxed/simple;
	bh=9MyLV7JIMIpNcoOyFCYojRhjh87+feXb1nmpyV9Vfp4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QnMB+TV3HrEXHe+DFnPuAq5xkb6Hqvje9koKUvQF6yikMMzz45uBx96SMFsOUk3SGc8FcdhTh/q5RSra9QLrMhgILl79zmHWS6/9aduUY91ZSd3eDqIhZoDrgV5AtVjTI2MDzo7tYfPoYi0QVHY4sv9gDgjAv2GhX+Xx5W8yYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YfCS6q7F; arc=none smtp.client-ip=220.197.32.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29929327b;
	Fri, 14 Nov 2025 14:36:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition
Date: Fri, 14 Nov 2025 14:36:37 +0800
Message-Id: <1763102197-130089-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a8114b69409cckunm41d28b3740b812
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhgfSlZLTEtIGklMGR9PS0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YfCS6q7FJAFrVTo/FdKh3bWEvYZyt+AUBgw7hD23qXtX++7Z+NFVlRaLPWFp9+J04innFuxkICHIPkSyWC17+YT3dY7J3BjbVZFngCrcGZcjvdQfX24KDZGC+HNw4oqwtCzhhXundTFFpi8El+gCi7JErdbrN+sFhYrLqhE82mQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=YHvgYQXCJLpDciqo8Hkn73Jg9qA/hTh76Nb3TtUyzGc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Per DesignWare Cores PCI Express Controller Register Descriptions,
section 1.34.11, PL_DEBUG0_OFF is the value on cxpl_debug_info[31:0].

Per DesignWare Cores PCI Express Controller Databook, section 5.50,
SII: Debug Signals, cxpl_debug_info[63:0] says:
"[5:0] smlh_ltssm_state: LTSSM current state. Encoding is same as the dedicated
smlh_ltssm_state output."

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ec..24bfa5231923 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -97,7 +97,7 @@
 #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
 
 #define PCIE_PORT_DEBUG0		0x728
-#define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
+#define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
 #define PCIE_PORT_DEBUG1		0x72C
 #define PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
-- 
2.43.0


