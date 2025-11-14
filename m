Return-Path: <linux-pci+bounces-41236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A28DC5D08E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 13:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48A1B4E5C68
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52330B51E;
	Fri, 14 Nov 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RQvAzlmu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49225.qiye.163.com (mail-m49225.qiye.163.com [45.254.49.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF22DFA48
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122156; cv=none; b=VP3uveCufJJ+UQPjT0NW69etEO1abUIdcjDHioVfn9heRJiZdWts1csN8bi+XsYSU6cW1Ty4feEHeQIIZUB25VWW06ayFEPvGkcClyR1ripQ/mD/qdsURXa15WKpP7B4GziXwFijWggmbBcoRLXOToRCLmr0rjsiZKUriAGIfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122156; c=relaxed/simple;
	bh=13JIV/jaIPLrPsylpynY1HZ3tZ7eRhV0QX6xCNOL8Bc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BUCK/tYhFGjjiKfc313Q7EkVzZg47mOpb3BJRKz5fwERZ74JoNxXsyISDfYCyyePHHICccY+0uNNggwDlSBQKDqgRlPJl8m9G0gXzZPPaIkkokHnuA6RhYEdWoJs3G/TWcB15lyBB/+1vXFLH3OYWRY3gYPHv/xmRFa6ahlo56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RQvAzlmu; arc=none smtp.client-ip=45.254.49.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 299e09f93;
	Fri, 14 Nov 2025 20:09:07 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: dwc: Fix wrong PORT_LOGIC_LTSSM_STATE_MASK definition
Date: Fri, 14 Nov 2025 20:09:00 +0800
Message-Id: <1763122140-203068-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a8244f0d409cckunme926b65147c498
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tMQlZJGEoZHUNLSk4fTR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RQvAzlmu8fKh1unvAo4zNQUxHXjI+2TOfbadOGzGC9D406XHPtfXLNB2cdgMufO85EqVkXpa8MdzktqBA7bG9JCdL28bw1EIVj3DwTNIC9EFdM5ycRmjKMM37ah/9oYO8j+R3ggBMqAmmTnAX38YjfesKSQoDz8ZO00BcQlnmgg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=d5nov799gYGIaGghLHkjJumHMWcc97PuPS0dFtwsgLE=;
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

Fixes: 23fe5bd4be90 ("PCI: keystone: Cleanup ks_pcie_link_up()")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- add Fixes tag

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


