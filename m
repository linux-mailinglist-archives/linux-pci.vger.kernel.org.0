Return-Path: <linux-pci+bounces-26049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53013A910EC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 02:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D92617E8CC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 00:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A638F6C;
	Thu, 17 Apr 2025 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ll+f3hVi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com [45.254.49.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71907747F
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744851052; cv=none; b=Io3htySxjXBbSCE6VKQkOqH1GQ5UxapJvyrKIlo5nPhdkLJ8lmVnx38ggipPl7p1ldautZasxJsHwVHJ1EmnhFLccUZmRw2Lg9kw2t6irdIGJ7K/i8oHbtLzbWPYgV97jx+ksp5MEtOVL0lqk6eXDCT0WdCA3FmCIyOac6Xu8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744851052; c=relaxed/simple;
	bh=/LIhYUtWCc/WbPgemz7WMG4qL/YHS6J7dOb5PnZq1e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=s/iOGJMj4HKsaBtkABn9+cAT9hApgF1ijd4VSft+8FB5WyNo9Xld9GqtlkAqehhObFWYN8bwk3uZA1buzx1DmxzkgwsCgT0GynuKezWnvuV+Kw3YCTyzxnXSIzyc8n5C+YIFL8sjFG67e9G2s9qwQkBU+4UWQn96j2QZGsy/S/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Ll+f3hVi; arc=none smtp.client-ip=45.254.49.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1224c9fcc;
	Thu, 17 Apr 2025 08:35:22 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 2/3] PCI: dw-rockchip: Enable L0S capability
Date: Thu, 17 Apr 2025 08:35:10 +0800
Message-Id: <1744850111-236269-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
References: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUoYH1YdGkJNT0NDSUJDHU9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96412bf76d09cckunm1224c9fcc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6Fjo6IjJPQxIsN1EaSRwU
	Mk4wFDNVSlVKTE9PQ05LSklITUtLVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhPTkk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=Ll+f3hVibvz98qjZUuX4AqAybXXMLdFBMW0bQ6td5t6TEeCzB1o7vSTxcekXYN16M1aC8Q8z28jWsZrQdNFVmyURC817M6PULpJk9MRrPOX9YNC1J4LkIwRBOTyFxtj2UMelxxP7B4tpVZwvXuIbNsACp9BvRQoMOFBfeH/wL/E=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=3zV4zLHBFMBDkTaI0ymuEzaxulPPeYl/7men0nXYlkA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

L0S capability isn't enabled on all SoCs by default, so enabling it
in order to make ASPM L0S work on Rockchip platforms. We have been
testing it for quite a long time and found the default FTS number
provided by DWC core doesn't work stable and make LTSSM switch between
L0S and Recovery, leading to long exit latency, even fail to link
sometimes. So override it to the max 255 which seems work fine under test
for both PHYs used by Rockchip platforms.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes in v4:
- Add Niklas's review tag

Changes in v3:
- Add rockchip_pcie_enable_l0s() and called from .init()

Changes in v2:
- Move n_fts to probe function
- rewrite the commit message

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 21dc99c..e4519c0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -182,6 +182,21 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 	return 0;
 }
 
+static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
+{
+	u32 cap, lnkcap;
+
+	/* Enable L0S capability for all SoCs */
+	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	if (cap) {
+		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
 static int rockchip_pcie_start_link(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
@@ -231,6 +246,8 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
 
+	rockchip_pcie_enable_l0s(pci);
+
 	return 0;
 }
 
@@ -271,6 +288,8 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
+	rockchip_pcie_enable_l0s(pci);
+
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
 };
@@ -599,6 +618,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	rockchip->pci.ops = &dw_pcie_ops;
 	rockchip->data = data;
 
+	/* Default N_FTS value (210) is broken, override it to 255 */
+	rockchip->pci.n_fts[0] = 255; /* Gen1 */
+	rockchip->pci.n_fts[1] = 255; /* Gen2+ */
+
 	ret = rockchip_pcie_resource_get(pdev, rockchip);
 	if (ret)
 		return ret;
-- 
2.7.4


