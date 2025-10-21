Return-Path: <linux-pci+bounces-38858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF3CBF518F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CDF1886A9A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EF9299923;
	Tue, 21 Oct 2025 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ddgCww/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47676302144
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032957; cv=none; b=rbZGIRFYVLeBju/YMeMGzt35Zxwnqn278nnK4VuX4TgzbdW7FhpKHy8i8LZt2dqoljG0Ihag6gM2FEl9vDxylUbMXizz5ppIl5JTQFPkkQS+SqK4SRW3qTOnkmWBzFykTDTyhOBpCVwOgLVkP9s4AaO0Bg6jDHuJ1Xb/0xZKJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032957; c=relaxed/simple;
	bh=JGJANZsTQ+vs93vGh/dd3uqntSQZUC+7BijNjk7JnPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CTBU9TuP6BmRINgtJuBPKHJfrVunoXLCTMgSd036ZwPc/VOefpYvCojvqGqQtfwCZnPV3CuEgOYJvkr/SXblGtwZq/fxr+AX6XnNOs3JSBc8mRSTZUAAnzF+CtlYWiJQAxpCmoPtGseo8JOAR3trYe8WqJWXVVDaC4AtcH4SNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ddgCww/y; arc=none smtp.client-ip=45.254.49.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26a1f52a0;
	Tue, 21 Oct 2025 15:49:04 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/4] PCI: tegra194: Use of_pci_clkreq_present() instead
Date: Tue, 21 Oct 2025 15:48:25 +0800
Message-Id: <1761032907-154829-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9a05be39e209cckunm38953c586480f8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkkeGlYYSh9ITk4dQ0lOSBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ddgCww/yC7uFtFO7BjsjoC3ZiNcvp2aVVgsrSbTqogSsUFkKXupys9+hv8rUSGjN1tH+NKEDEsFc7+IH3DFePEg0G/iRypmUxOq6RaqYnBh99VTh4UaTs/ul+82BvX9ESahWOkxH/VN7aIHluFCRRU3xfBnn/YaFpAylOv2QWkg=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=4dvvzsqNL6KyJn3Dsf5VauyFQnqLWPdu6/TmuPxHihk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

No functional changes intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 10e74458e667..7a82a53e7c4d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1161,8 +1161,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 					      "nvidia,enable-ext-refclk");
 	}
 
-	pcie->supports_clkreq =
-		of_property_read_bool(pcie->dev->of_node, "supports-clkreq");
+	pcie->supports_clkreq = of_pci_clkreq_present(pcie->dev->of_node);
 
 	pcie->enable_cdm_check =
 		of_property_read_bool(np, "snps,enable-cdm-check");
-- 
2.43.0


