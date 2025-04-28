Return-Path: <linux-pci+bounces-26946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7DA9F6FD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494103AFFEC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC728E60D;
	Mon, 28 Apr 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Lf1YUnb3"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A828B4F3;
	Mon, 28 Apr 2025 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860316; cv=none; b=HWNvvIUua+sW5C8EmQikqeWv+njbE/9gx5CxCke0v/qnghsVDy3ElLG3IEHQEqPcaeH9zWFzTmd6E46YV2o+hXqzpCBIWNC5/wSALzLKRS48fBXeA3S5OaZdtAk1rbFt7c+RHrnV3/1n0EedGIUX7XcP9P9NpbSlhksrTWsuGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860316; c=relaxed/simple;
	bh=B8lWk3gb7w31KdYHngZOLT5WFfzL8kSbVmi+aQzLG8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeTnAXYnXrDhfHl/iCpjlB/GZ4AIokzF/yNnP6Hy/9DZjHVt5eUbDfgwToi/gYrfyK8Jrex/jj3eqQCmZ0gx/sPM1DFDAoVWw7CPZlehYuLhf4PjGzHnf7XGYI2RCDlP2PgsHWgqsIqnm7DhDYep5+B+ze80u8ak/p6qlbeHUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Lf1YUnb3; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Tum4K
	/CbqYUhGYnJ8GFo7ngbhq4ZDFew8CuChjud+OA=; b=Lf1YUnb3fH75uWDrI/c03
	kBc718ArKIBT0IA5Fv5njb3fyBY/Xn2wLZD5yGw0tjuH5KAqrdiYJPxf57BBZS2x
	/pw2ZEC0o5Fk71MpEVvUFC9d/CBqXvAtcdPobGMeaFXuR3jNl6nhikc1O55ELv7z
	i9Ag7W0DDglUZR9nbBCi2Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCH4haitg9otPCfDA--.1694S4;
	Tue, 29 Apr 2025 01:11:00 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org
Cc: cassel@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/3] PCI: mobiveil: Refactor link status check
Date: Tue, 29 Apr 2025 01:10:26 +0800
Message-Id: <20250428171027.13237-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428171027.13237-1-18255117159@163.com>
References: <20250428171027.13237-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH4haitg9otPCfDA--.1694S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF15Zw4kKrW8Aryftr4kCrg_yoW8Zr1fpa
	yqyw17C3W3Ja1FgF15ZayUZFy5t3Z3ur9rJ3y7uwn3Xa47CrWjy3Z8JFyftwn3Gws5Xry7
	J3Waqa17GF45XFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRgeOXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgk9o2gPrNjzoQAAss

Update ls_g4_pcie_link_up() to return bool and simplify the LTSSM state
check. Align function signature in pcie-mobiveil.h to match the change,
ensuring consistency across the Mobiveil PCIe driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 9 ++-------
 drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index 5af22bee913b..1cf014051296 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -53,18 +53,13 @@ static inline void ls_g4_pcie_pf_writel(struct ls_g4_pcie *pcie,
 	iowrite32(val, pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
 }
 
-static int ls_g4_pcie_link_up(struct mobiveil_pcie *pci)
+static bool ls_g4_pcie_link_up(struct mobiveil_pcie *pci)
 {
 	struct ls_g4_pcie *pcie = to_ls_g4_pcie(pci);
 	u32 state;
 
 	state = ls_g4_pcie_pf_readl(pcie, PCIE_PF_DBG);
-	state =	state & PF_DBG_LTSSM_MASK;
-
-	if (state == PF_DBG_LTSSM_L0)
-		return 1;
-
-	return 0;
+	return (state & PF_DBG_LTSSM_MASK) == PF_DBG_LTSSM_L0;
 }
 
 static void ls_g4_pcie_disable_interrupt(struct ls_g4_pcie *pcie)
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index e63abb887ee3..662f17f9bf65 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -160,7 +160,7 @@ struct mobiveil_root_port {
 };
 
 struct mobiveil_pab_ops {
-	int (*link_up)(struct mobiveil_pcie *pcie);
+	bool (*link_up)(struct mobiveil_pcie *pcie);
 };
 
 struct mobiveil_pcie {
-- 
2.25.1


