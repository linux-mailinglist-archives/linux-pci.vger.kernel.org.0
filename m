Return-Path: <linux-pci+bounces-26051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86CCA911CD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 04:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606521907391
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F839185935;
	Thu, 17 Apr 2025 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZeduLzrj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49225.qiye.163.com (mail-m49225.qiye.163.com [45.254.49.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099A42A97
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744858675; cv=none; b=FBHOcuTDFJko+JJMLlTTiNoT7Gri+ilRJq1TTli0YOAZe/pH4GRQ50lQ4QhdFANmdJ5iexUgrdLn+h8nd2nZDbRbew09kJAEncEHjA8KbAv25U5oBJlPKqnp3uKQIs3WkE7WNNITSV3ESIHW/0mqzgPuEmTsY+GbLfrRGbFyaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744858675; c=relaxed/simple;
	bh=bAr+kjHhgBzynygLxrZ/spJhCuPBJs3/xuEJy5wLyH8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FbTA7Ir/nNdruTmAxer+iquXqHO7G0B0Z9lnHf+Bv4HSzFX8z6KYR/aq0MNbz0+e2PfmK4YGMr7L8wN5SK/r0amuIweWxqbBMMu/zVcNRkLQGtvJjjq5ub8NSnH3LYhrugT1cJe8QYOK68NngGYX4EmxkvFKgT7jnBXIVKNuD/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZeduLzrj; arc=none smtp.client-ip=45.254.49.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1224c9fc8;
	Thu, 17 Apr 2025 08:35:20 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 1/3] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from rockchip_pcie_link_up()
Date: Thu, 17 Apr 2025 08:35:09 +0800
Message-Id: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9DGlYfGk5LGUxLSxgdShpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96412bf0db09cckunm1224c9fc8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6PRw6KTJCChJMTlE5SRwQ
	PjxPCR9VSlVKTE9PQ05LSklKTE5PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlJQk43Bg++
DKIM-Signature:a=rsa-sha256;
	b=ZeduLzrjIPy5pH1Ewgvw5Tf5y1+XXufBjpE3azg6NjeweB+zZdorFsSaQXMoP4TE0fFiZfdOv7f2TzwXTHjlu+BG0ZactQTV4XlAdgYiZqqtetJQaIyfiKY4lzKaR2XxZSlyxeswu8LZLWSr0bBh/tJq2P8l4ZWO6i6qQCB1fNY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=fq/Bq902UqO4acjVfAr3JCalQ1/clSsH0CNvIUMs4hw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Two mistakes here:
1. 0x11 is L0 not L0S, so the naming is wrong from the very beginning.
2. It's totally broken if enabling ASPM as rockchip_pcie_link_up() treat
other states, for instance, L0S or L1 as link down which is obviously
wrong.

Remove the check.

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes in v4:
- add Niklas's review tag

Changes in v3: None
Changes in v2:
- add Fixes tag

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c624b7e..21dc99c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -44,7 +44,6 @@
 #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
 #define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
 #define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
-#define PCIE_L0S_ENTRY			0x11
 #define PCIE_CLIENT_GENERAL_CONTROL	0x0
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
 #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
@@ -177,8 +176,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 val = rockchip_pcie_get_ltssm(rockchip);
 
-	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
-	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
+	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
 		return 1;
 
 	return 0;
-- 
2.7.4


