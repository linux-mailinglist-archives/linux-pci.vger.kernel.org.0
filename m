Return-Path: <linux-pci+bounces-35028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC3B39FA4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1293417CCED
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901543148D1;
	Thu, 28 Aug 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M9WTGrxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7623128C2;
	Thu, 28 Aug 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389664; cv=none; b=nI8scv9toAuw7ECr7WWN+G/gm/+E+DHkvN+xwKwt+1nX2PxJJry6n+OjqkGj/sO+46602qTOOGKu9eJtgfL9dczeE9rrh6i07Q2Q/jsIx9MInBb6u7qwXPpTKMy0g3/8l3TN4xVoDvoFHcqWFdrcUvI4lVqLDmiS+oF3RtITduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389664; c=relaxed/simple;
	bh=I3kiFpN5hU0JGnnLGtkwKKvrN2TxdKRl9JuJaqgpYUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtFBKBJoDTrtcNUXFBBcaoHExreUBd9cLiqIh/pj/LNHw+DEwQ8vfsN5YxUuDHhI+d/UcHH2AHmpY0SwCHtcWjkfx/X3zPYOJKWwYUbLosQKoWXwzEJqDpHQKXPVelVRuKBeTklIYhFp9eWuYT9GBsAOA/taX+SjqD8x4Uc27B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M9WTGrxI; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rX
	r25upQbRLDCWYow996mEZMVoZsxtYisTv8mNbEQJU=; b=M9WTGrxIpDtIC56lLr
	8OOh7yDVJcvX67JQfyHknBDnNe7EM5ZBTFfIYB0flvmWMhLjyC17vaNJbkqO9bG/
	fcDufU0i0M03Vhxnv5aXt2OujaDrYUx8hdKRGeMSbFiRNPK68ooxp49vPZdF/1jG
	jSY4H8AgLC+Oe7UUMlIFiPTj8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXJYwNYbBoRejWEw--.829S6;
	Thu, 28 Aug 2025 22:00:48 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 12/13] PCI: rcar-gen4: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:50 +0800
Message-Id: <20250828135951.758100-13-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
References: <20250828135951.758100-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXJYwNYbBoRejWEw--.829S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFy3GFyxGr47Xw1xZw4rAFb_yoW5AFW3pa
	y7CFySkF1UAw4Y9F4jqaykWr15uan3C3Wjgwn7Gw1I9ay7ArW3X3y0y347tFWxGrs2qr45
	Cw1UtFWUuF15ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinmR8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQw63o2iwWuaYpAAAsB

R-Car Gen4 PCIe driver contains multiple read-modify-write sequences for
speed change control and lane configuration. The driver manually handles
speed change initiation through bit set/clear operations and configures
lane skew with explicit bit masking.

Refactor speed change handling and lane skew configuration using
dw_pcie_*_dword(). For speed change operations, replace
manual bit toggling with clear-and-set sequences. For lane skew, use
the helper to conditionally set bits based on lane count.

Adopting the standard interface simplifies link training logic and
reduces code complexity. The change also ensures consistent handling
of control register bits and provides better documentation of intent
through declarative bit masks.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 23 ++++++++-------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 18055807a4f5..67be0aeaa7ec 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -107,13 +107,11 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
 	u32 val;
 	int i;
 
-	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_clear_dword(dw, PCIE_LINK_WIDTH_SPEED_CONTROL,
+			    PORT_LOGIC_SPEED_CHANGE);
 
-	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_set_dword(dw, PCIE_LINK_WIDTH_SPEED_CONTROL,
+			  PORT_LOGIC_SPEED_CHANGE);
 
 	for (i = 0; i < RCAR_NUM_SPEED_CHANGE_RETRIES; i++) {
 		val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
@@ -565,11 +563,9 @@ static void rcar_gen4_pcie_additional_common_init(struct rcar_gen4_pcie *rcar)
 	struct dw_pcie *dw = &rcar->dw;
 	u32 val;
 
-	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
-	val &= ~PORT_LANE_SKEW_INSERT_MASK;
-	if (dw->num_lanes < 4)
-		val |= BIT(6);
-	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
+	dw_pcie_clear_and_set_dword(dw, PCIE_PORT_LANE_SKEW,
+				    PORT_LANE_SKEW_INSERT_MASK,
+				    (dw->num_lanes < 4) ? BIT(6) : 0);
 
 	val = readl(rcar->base + PCIEPWRMNGCTRL);
 	val |= APP_CLK_REQ_N | APP_CLK_PM_EN;
@@ -680,9 +676,8 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 		return 0;
 	}
 
-	val = dw_pcie_readl_dbi(dw, PCIE_PORT_FORCE);
-	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
-	dw_pcie_writel_dbi(dw, PCIE_PORT_FORCE, val);
+	dw_pcie_set_dword(dw, PCIE_PORT_FORCE,
+			  PORT_FORCE_DO_DESKEW_FOR_SRIS);
 
 	val = readl(rcar->base + PCIEMSR0);
 	val |= APP_SRIS_MODE;
-- 
2.49.0


