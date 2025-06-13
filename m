Return-Path: <linux-pci+bounces-29673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CF4AD8950
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4C416713C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984E2749DB;
	Fri, 13 Jun 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvr/67nK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512B25A320
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809957; cv=none; b=I4CTOmaYPWfBB9Uyct/6qhvPowF2k/9/EBCvxBtJjQuNSoV+Fg6y3dUpjC5hM1ZSoS10HtK5PYXFoghCJahLLHA77Va+wGa/4yFgm4hzM9JGfbGJj6RRRTCMRb6XSnQs8pe+UqkPFVncpGM9hoOlqdcZ8NdKw9m/Fie3JJslLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809957; c=relaxed/simple;
	bh=njX/mlzpKVPxzlfofqg5PPE565FrxEuTn25GxNu82eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZdzJdaqy+pe/Y04DUgPxeRemdJdlywOE2WpoU4yV43QInZN4RUKzxEVH5BhIafyFY0HgfunkaTKG6Qc34pdjYnQeDalfvrkhY2PmvY/RtgGdNRKVwPZZMrautP+dOPloaAioZlYgHpb/DYqqhRGcC8nKu1dnv/vP6gy+4ReaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvr/67nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6607EC4CEE3;
	Fri, 13 Jun 2025 10:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749809955;
	bh=njX/mlzpKVPxzlfofqg5PPE565FrxEuTn25GxNu82eI=;
	h=From:To:Cc:Subject:Date:From;
	b=kvr/67nKdYCR8A8E5zE4MaNfG5/hUQr6DBWoU6y1SMGIeiILwGzQPlWj9QfrESUSz
	 dHO41Nk3z4NMpQGhh2JETtD4PNSlubutNUESD3p1ey0DotXhlPsCLPQME6s/gr2q5e
	 kCB0jCFjU6yWFyEpWWQ6ihngnoKCmabZ5uq9wdhRtVFwPCYFbW6f5Ks796IxjlJzHw
	 E+sB9mLssVUzswmUoN7cojG9lU+2pT1+qWxbd516WAaI9YXYskvVSQLuFy4Q4tEOWE
	 TVhJNOnCfX6XvXx/UMsSoDAyDjTJRUNwaDRQ57bcF1SvkJ+u4SkHvUF83e2ikxo3MU
	 PSdBdoM99vBRA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2] PCI: dw-rockchip: Delay link training after hot reset in EP mode
Date: Fri, 13 Jun 2025 12:19:09 +0200
Message-ID: <20250613101908.2182053-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218; i=cassel@kernel.org; h=from:subject; bh=A0LONFhSyCrAhZKTdpj0VQlSUgSYu5k5R0omco5tlfE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK8f8vEWi+vadkicULgWd1i302S14oWza35oK+26e4zI yd9iZthHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjI5KkM/91+LfnhVHzwYKbo tLAcRt1Nk237UpQedZgtU+nayj1b4h/Db9aPZlGFJ07+jsmoV6gql/Dqe9Dtq+76u3j9ZR9dTi1 ZPgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

RK3588 TRM, section "11.6.1.3.3 Hot Reset and Link-Down Reset" states that:
"""
If you want to delay link re-establishment (after reset) so that you can
reprogram some registers through DBI, you must set app_ltssm_enable =0
immediately after core_rst_n as shown in above. This can be achieved by
enable the app_dly2_en, and end-up the delay by assert app_dly2_done.
"""

I.e. setting app_dly2_en will automatically deassert app_ltssm_enable on
a hot reset, and setting app_dly2_done will re-assert app_ltssm_enable,
re-enabling link training.

When receiving a hot reset/link-down IRQ when running in EP mode, we will
call dw_pcie_ep_linkdown(), which will call the .link_down() callback in
the currently bound endpoint function (EPF) drivers.

The callback in an EPF driver can theoretically take a long time to
complete, so make sure that the link is not re-established until after
dw_pcie_ep_linkdown() (which calls the .link_down() callback(s)
synchronously).

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Co-developed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Rebased on v6.16-rc1

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 93171a392879..cd1e9352b21f 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -58,6 +58,8 @@
 
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
+#define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
+#define  PCIE_LTSSM_APP_DLY2_DONE	BIT(3)
 #define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
 
 /* LTSSM Status Register */
@@ -474,7 +476,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	struct rockchip_pcie *rockchip = arg;
 	struct dw_pcie *pci = &rockchip->pci;
 	struct device *dev = pci->dev;
-	u32 reg;
+	u32 reg, val;
 
 	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
@@ -485,6 +487,10 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
 		dev_dbg(dev, "hot reset or link-down reset\n");
 		dw_pcie_ep_linkdown(&pci->ep);
+		/* Stop delaying link training. */
+		val = HIWORD_UPDATE_BIT(PCIE_LTSSM_APP_DLY2_DONE);
+		rockchip_pcie_writel_apb(rockchip, val,
+					 PCIE_CLIENT_HOT_RESET_CTRL);
 	}
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
@@ -566,8 +572,11 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* LTSSM enable control mode */
-	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
+	/*
+	 * LTSSM enable control mode, and automatically delay link training on
+	 * hot reset/link-down reset.
+	 */
+	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_EP_MODE,
-- 
2.49.0


