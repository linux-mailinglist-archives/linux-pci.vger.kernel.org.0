Return-Path: <linux-pci+bounces-25645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4EFA851E7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 05:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B16016F877
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06E31E8338;
	Fri, 11 Apr 2025 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DEYbkOXq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15586.qiye.163.com (mail-m15586.qiye.163.com [101.71.155.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDF56FB9
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341041; cv=none; b=DesADrOhKx1Dip62eg4khN/DhZygrW2+XXl3U/Anh+pCq7hU2g25kImw4xOoPhoxlVcCNvgVoKDHXrkl9LEKIELVep+I+vYeVlX/lwNQ5i79wnm7wjp+WK5EBIUMuyPSG8mrZSefnOwEdBYxjd89CNTUgFcp482rsldleK/q3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341041; c=relaxed/simple;
	bh=afnVGyX/GbVQ5MOe3lPfrJpjyS8j3rNKIcDoveL8maM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GuF1B0wc6riBY30SnqaRoBMh5k/DJYxMu9aohkgoyrYGNE8YE3Vbb0ShovBcSuOG35mB8rpT/przNQK1EMjOP3iLs5esQmrut5iO5VaHyytds1XkED/s/ySrU2wZbO5BrG10sZ0xAQkknvxAZCX38wc1DqQfW9lCIEe5Wv5ZsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DEYbkOXq; arc=none smtp.client-ip=101.71.155.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1173be577;
	Fri, 11 Apr 2025 08:48:07 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: dw-rockchip: Enable L0S capability
Date: Fri, 11 Apr 2025 08:48:01 +0800
Message-Id: <1744332481-143011-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tJGVZCHhlNT0pNTktDSE9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9622517d4209cckunm1173be577
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSI6Agw6KDJIFjYLMzUvSxwq
	PAgwFBFVSlVKTE9PSEhJT0NDQk1CVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlNSEk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=DEYbkOXqgzukVwE3YP9MmCCjyDojosC0TIml55pd/opPYMdATgyQ0dfDsYby7OiXEV2et2uU73LP7c1xmcxxJPh07WFUPuB46TcEbUaq4kp2MQGVeFLdYHCqT9mqByM1k1rP7O4f9hM4IMbpHGSDMeKxyLh9kpwwq5BFLS0aT0A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=EXKzYEqYiTE9w2mRpKEMs5Wxk/nTiA8EzLVI2PN8O4Y=;
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
L0S and Recovery, leading to long exit latency, even fail to link sometimes.
So override it to the max 255 which seems work fine under test for both PHYs
used by Rockchip platforms.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- Move n_fts to probe function
- rewrite the commit message

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 21dc99c..c397f3a 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -185,6 +185,17 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 static int rockchip_pcie_start_link(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
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
 
 	/* Reset device */
 	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
@@ -598,6 +609,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	rockchip->pci.dev = dev;
 	rockchip->pci.ops = &dw_pcie_ops;
 	rockchip->data = data;
+	/* Default fts number(210) is broken, override it to 255 */
+	rockchip->pci.n_fts[0] = 255; /* Gen1 */
+	rockchip->pci.n_fts[1] = 255; /* Gen2+ */
 
 	ret = rockchip_pcie_resource_get(pdev, rockchip);
 	if (ret)
-- 
2.7.4


