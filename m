Return-Path: <linux-pci+bounces-39707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABE3C1CA5D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBF184E8B2F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61313559F4;
	Wed, 29 Oct 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nLgG/oWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A89351FB5;
	Wed, 29 Oct 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760631; cv=none; b=CQb1BoLhf8ii5Zu2AkFy5rSv2vPkUJMoexJ6ruqhwonKv/SnwMbk+Wxo6llGHWZ8JUSkDSbMS9WTSla4nSfKgEJW3tr7EN4zpApvJt/k17ww6aTmf8lAt3sdHJHubPzV1Dttzxqk1hgFUcsOrpATptIXMUrKlt3eqqRfMdA7ThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760631; c=relaxed/simple;
	bh=P089A2E+Yx4OzfNu1PedtURbJw0D3+0WliIVTgNh9oM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eReVkJflMI3vmna9YrD4NK3OjFyOx2ZpLk9cYmHNuZ7bD0gCEOTiBZANIlAdmjtNeD5+E5q0UmV9zMpd20vbPG+1GBE19oba0tgKpPIvTCya49osnGBYQVCaHa3+Ot8KCaJCqnjx+r3MX/EnDSD1ETPvuyhyupT0TmnorFPk8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nLgG/oWa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761760622;
	bh=P089A2E+Yx4OzfNu1PedtURbJw0D3+0WliIVTgNh9oM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nLgG/oWa8uLS1lDc6moMj4xLneOSVBAen/YSCWNrNd3s0lSOyZd0RRnq9y/3CgHpI
	 jt+9y4KUL3RZBAFAhk5bWFP2R9c8rqBuPM0ONmq24+6N8z6Z+v3tPoKf1VmCFlQEkB
	 Nf1D1rbU+WjSHYBgYR5QCQxqXWXNy7X8wRxMZ56KQzYNRg+6Tfok6lEBKz/2oEiXll
	 33RjIeisikpwDq7UO/GHHJ4VSzlmD3cQp99kySNJjUdTpLqm3oBgPcaRSHk8DrbqQe
	 vUtk+tfffBl87053UkcF/k7v17JincHeHhC4kgrkUTsMLSw6ZLZiHBYVUT5mEKOytL
	 p0KvpWnwOhhyA==
Received: from jupiter.universe (dyndsl-091-248-085-053.ewe-ip-backbone.de [91.248.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC20417E1406;
	Wed, 29 Oct 2025 18:57:02 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 23994480065; Wed, 29 Oct 2025 18:57:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 29 Oct 2025 18:56:46 +0100
Subject: [PATCH v4 7/9] PCI: dw-rockchip: Add pme_turn_off support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rockchip-pcie-system-suspend-v4-7-ce2e1b0692d2@collabora.com>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=P089A2E+Yx4OzfNu1PedtURbJw0D3+0WliIVTgNh9oM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkCVW1Wt1a/xsLih4NUKwQilYZGT5JbSjfLy
 F+sq7zgeGgJV4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpAlVtAAoJENju1/PI
 O/qarBYQAKRbmJ3JJI3lbkEWqfHq5RikyR+GXm6YOa3t457RVmznsMBtGcpWpVEvy//BBlKOigh
 wxWhnqT98WHoDwJrvt3HoTWtJS+8f+xYPZIn4JQKtnXU1RQiTIFhK5Xjor1JhkTErPJJnO/69Pf
 /U9nP8+xPlXvmV5jh0WydvgE7UaZcjqoVSVi62O2FyrzJZhwcVyEHQkFf9mOzTOoVJoVVWE3x0P
 LCld4ZmDSUeumXiBDPRBXIUnLnB+6Oa+lTydcn0i/wSeQKnoU9DU7d79E4JN0v7mfAVkYG35TmW
 Uv+jtKhoKsSVQ8m5JXlw7eb+IvpBUlWZ0hcDLDQMaQJ7fD2zIJlNtMoC3nnfCCkQi9LCnC6cKoh
 J4EyQHfI9ekNe6qQlXEDyYomFs5pVoDhOcwiLON3Gsf53E7lDN1z77XX6nw+zeWdueLTBwig/UE
 6Ig2MRx4nsmVFAPzBaCsi9ObqmPIx0ALxYkVKl1cuRvNFpTUaOPxfiZ0Pc5W9uTqnTdLCAi3F7y
 rH43eo68SneRceVeT4jRWBSCBnuZ6oPddoZ+uVQvRVklsyRSY7hWyGy7EGRlkteROrr/r1ErnRj
 nYlvWGNvw4AxGOmOjS/mm1JS1dJ6Nbdl+BgSG6fUvSi09b6NJmKaBRjZY50MT9JpdM4ozhDTUKz
 RIMgY3HmK+Sk0t3u/RUssxQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Prepare Rockchip PCIe controller for system suspend support by
adding the PME turn off operation.

Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index ad4a907c991f..d887513a63d6 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -42,6 +42,7 @@
 #define  PCIE_CLIENT_LD_RQ_RST_GRT	FIELD_PREP_WM16(BIT(3), 1)
 #define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
 #define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
+#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
 
 /* Interrupt Status Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
@@ -61,6 +62,11 @@
 
 /* Interrupt Mask Register Related to Miscellaneous Operation */
 #define PCIE_CLIENT_INTR_MASK_MISC	0x24
+#define PCIE_CLIENT_POWER		0x2c
+#define PCIE_CLIENT_MSG_GEN		0x34
+#define PME_READY_ENTER_L23		BIT(3)
+#define PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
+#define PME_TO_ACK			FIELD_PREP_WM16(BIT(9), 1)
 
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
@@ -277,8 +283,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	struct device *dev = rockchip->pci.dev;
+	u32 status;
+	int ret;
+
+	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
+	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
+				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret) {
+		dev_warn(dev, "Failed to send PME_Turn_Off\n");
+		return;
+	}
+
+	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
+				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret) {
+		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
+		return;
+	}
+
+	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
+	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
+	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER,
+				 status, status & PME_READY_ENTER_L23,
+				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
+				 PCIE_PME_TO_L2_TIMEOUT_US);
+	if (ret)
+		dev_err(dev, "Failed to get ready to enter L23 message\n");
+}
+
 static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
 	.init = rockchip_pcie_host_init,
+	.pme_turn_off = rockchip_pcie_pme_turn_off,
 };
 
 /*

-- 
2.51.0


