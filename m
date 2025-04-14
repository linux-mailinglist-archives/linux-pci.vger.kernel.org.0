Return-Path: <linux-pci+bounces-25767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E60A87552
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE56167C10
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC59554670;
	Mon, 14 Apr 2025 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="b7SYh4S7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E9481DD
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595040; cv=none; b=Do02KN755ztAT7k2+ZoCBAzlFs0hm2zI5OzxsFMcaDbEzVH/bZqV5++eYqCwebyikRT4s7WUxcSBTKtJGLF5Ncix/XOzB2zlqED0lNXkrwlLywCfDu5zMctOoxcsAAV1ounirUbfk+0qek1uY5fGUCQBuJDY6bfGoWP5k2PCHLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595040; c=relaxed/simple;
	bh=6phk70bkPNyoAaUdpo9luKr4GLuT2+FZ3rmismzn9ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vw5SUt7K8quRuLEKi0gd8zS4UuWVvjLIvkZjJ7P2etRO1v7GtO0AdwtYuYAK9AZEvjb1VKEqTxjlmx8oE2RN9cOXKGiK+bFVCfCy2iVVfUZ/Ud+NMdNCt4gVUzlgaobifoVtu5usKixUtg3n35Lc3acKwEQ+9LhRym8UoNaGfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=b7SYh4S7; arc=none smtp.client-ip=45.254.49.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11ba080e5;
	Mon, 14 Apr 2025 09:28:38 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/2] PCI: dw-rockchip: Move rockchip_pcie_ep_hide_broken_ats_cap_rk3588() to .init()
Date: Mon, 14 Apr 2025 09:28:29 +0800
Message-Id: <1744594109-209312-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1744594051-209255-1-git-send-email-shawn.lin@rock-chips.com>
References: <1744594051-209255-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgZQ1YdQ0lPQkxLGB8ZTh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9631e9a7a509cckunm11ba080e5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Njo*CjJNAi4VThlMFDxI
	ED8aClFVSlVKTE9PTkJPSkpCT01IVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlISko3Bg++
DKIM-Signature:a=rsa-sha256;
	b=b7SYh4S7XlMIKDKrrUG0lH9skDFqDH2VaFj0s4zgM3uINWgK6ESM6//jDRu2YTC/KcjecZW0BVPhLwCmP5U9g8n56yw6G6MPh9hz8HiaAPY8OjcZ5ZEFyb5nOQ1kXEq8e/f+t5vC7LbbrjUTE3lq5Yxv/MpGTI5+DjRWbv0URrw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=5A4TBHvuXi69hu9oUHOU20qjziwkwnj8HnqCaEmrLaY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Iif there is a core reset, _init() is called again, but _pre_init() is
not.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 922aff0..b45af18 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -278,17 +278,13 @@ static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
 		dev_err(dev, "failed to hide ATS capability\n");
 }
 
-static void rockchip_pcie_ep_pre_init(struct dw_pcie_ep *ep)
-{
-	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
-}
-
 static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
 	rockchip_pcie_enable_l0s(pci);
+	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
@@ -359,7 +355,6 @@ rockchip_pcie_get_features(struct dw_pcie_ep *ep)
 
 static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
 	.init = rockchip_pcie_ep_init,
-	.pre_init = rockchip_pcie_ep_pre_init,
 	.raise_irq = rockchip_pcie_raise_irq,
 	.get_features = rockchip_pcie_get_features,
 };
-- 
2.7.4


