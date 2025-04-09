Return-Path: <linux-pci+bounces-25537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B168A81E0C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 09:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB274A45D1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 07:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EEC17A2FA;
	Wed,  9 Apr 2025 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="U+9QVT+v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAF82899
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182975; cv=none; b=Ofd1uvWsyXfiIdiGivg6cZdRFCfCI0OQ5ZtVk6nNDFkNX7h8PlKzcP4u4nAdRCjw3Efxu2H6YK9MfO7FZ3GMStY31nVmrTJ1BNlz/XMwveQXkboacF1SzU6sYJT0M2L+QEdopwRkyTjLtqMQwI396UBgC90/yHOAd8myuPcTZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182975; c=relaxed/simple;
	bh=TVqLF3+NBvCIsBeOpSXaTEYY0ntJSlzJjplo9Xe4JQ4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ujozHwynV3G/Rmh9oME+f2SCXu8HXIRdZsAIsJYFcxYdvPtR+87zShw5f7cCJKInalHHUMfAh8Bf4Lmz8VCnQ1gCJBtvCbN9v7k0efmQzoTYaKepUPwY6NSOgB4TRDWClHxGeaov90y6oAaEMhM8ahWQJdVLtYqOjKM0t/n4JHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=U+9QVT+v; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1131237df;
	Wed, 9 Apr 2025 14:40:44 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from rockchip_pcie_link_up()
Date: Wed,  9 Apr 2025 14:40:33 +0800
Message-Id: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk4aS1ZDTUkdQkxDTUNOGUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a961947984109cckunm1131237df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6PCo5TTJPQz00AkoDARMN
	Cx8wC1ZVSlVKTE9PSkNLQ09OT0hJVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlLSko3Bg++
DKIM-Signature:a=rsa-sha256;
	b=U+9QVT+vPn0NNG1i8hZqBJxLkXebHlBBlFXiRCi3qd4iTifhai4dqLptWHQrnQP66LP0jEoZUXMtjOD/ke/skQf+gURqBHgIi+eFRE5gLmO1rywE0zWp+Nxm63P2S30wgUdt3O7+mtevh3Td8TJ9RgUC6NvH8kbKBTdLMNNbC24=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uL3yYBFNwU3CVG21BFbR1AKc8ubqHWPS1HF2coHLyYQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Two mistakes here:
1. 0x11 is L0 not L0S, so the naming is wrong from the very beginning.
2. It's totally broken if enabling ASPM as rockchip_pcie_link_up() treat other
states, for instance, L0S or L1 as link down which is obvioult wrong.

Remove the check.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

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


