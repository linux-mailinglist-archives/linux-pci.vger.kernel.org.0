Return-Path: <linux-pci+bounces-43642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA172CDB90F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 08:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2D6E300C55A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C578329E72;
	Wed, 24 Dec 2025 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gVu/zbvW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32116.qiye.163.com (mail-m32116.qiye.163.com [220.197.32.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013AF329E4B
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766560320; cv=none; b=XN92PtZOzyeM5l/RBV9/i9z5qm8T8JiJijrOcfENTzHaxtANfghGlX8Rs1c0kt860vzD8G+bJpFRrPl3ny3OjoBETPZgPubyCoEPikc3+KCFPfnnaUsnP9o+FNAuGW/BgWIgdbjZ+KxEKmK3qaVKmxRQWHP3A6UyPmOX2mHE5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766560320; c=relaxed/simple;
	bh=SbmjS4u9EcNkPuX9o86tWTppDTWRFfSB06cMuIcNhrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lrG6X7xqkvnfpu4qGM7Q0s9b4z/XmyeGfTThEv89LF5JhzZCl1XZiZZY0O+BqseoQFygtGrNp0YtBn5Qw+6m8kn3qLFgC0VdYcOSWUOqT8iU04r3CA6TZd+K2edsjRGpu3UOjaRcer1qbd5PRBgRDDP0A+ygVe2ehrud8a5FNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gVu/zbvW; arc=none smtp.client-ip=220.197.32.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e63ea8b8;
	Wed, 24 Dec 2025 15:11:47 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/5] phy: rockchip-snps-pcie3: Check more sram init status for RK3588
Date: Wed, 24 Dec 2025 15:10:09 +0800
Message-Id: <1766560210-100883-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b4f33194209cckunm34e2a83f3c2d73
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9IQlYaHUMfSklNSEIdQ0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gVu/zbvWd/8GCESbh2vOYfC51To7UeQxB63FDvltrcm6hxId/Zn06xL7C5iKIkKlHC9feGPtXgFvC24lcZ56B07t0wHxxCS1W/ZRuqLXrYe2kMHwP4ZLWrZBwkNK5g4QnwAZ+ewZBmf9PyoxgrRhAUHqb1sMqz65+ZQSX2hIi3o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=EruBuD3DV9D2zUZnQ8r8fDZq4vTwMkgX5kghIQwvukc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

All the lower 4 bits should be checked which shows the mpllx_state.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index f5a5d0af..6cc38e3 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -43,7 +43,7 @@
 #define RK3588_PCIE3PHY_GRF_PHY0_LN1_CON1	0x1104
 #define RK3588_PCIE3PHY_GRF_PHY1_LN0_CON1	0x2004
 #define RK3588_PCIE3PHY_GRF_PHY1_LN1_CON1	0x2104
-#define RK3588_SRAM_INIT_DONE(reg)		(reg & BIT(0))
+#define RK3588_SRAM_INIT_DONE(reg)              ((reg & 0xf) == 0xf)
 
 #define RK3588_BIFURCATION_LANE_0_1		BIT(0)
 #define RK3588_BIFURCATION_LANE_2_3		BIT(1)
-- 
2.7.4


