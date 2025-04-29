Return-Path: <linux-pci+bounces-26996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA2AA0B47
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 14:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67245A0A53
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F92C3757;
	Tue, 29 Apr 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XQBkijQH"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684B27BF8A;
	Tue, 29 Apr 2025 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928714; cv=none; b=WompjQi09EvgcwcUPeybBYACT/EoS+i3s3+NTJto8VSHBMMFDsI8bJsmn8dN5pVYFhc+JsBFseYUgASL2A4szf8jHuWxrvoKo2NyY0gFxA0O830XTunAlzctlmbJBkZLXtyXt3oqQzRY/YhluoG/bQp1DlHb5NTWMcm/iSgD4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928714; c=relaxed/simple;
	bh=B8lWk3gb7w31KdYHngZOLT5WFfzL8kSbVmi+aQzLG8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNVJ/nCr7NHGREi1HE/G4U9gjmTDqu8yyFBuUym+Y5RUwSGO0DhBGwAo7Ra3k+Q94PhdVsIpzYXAURfSuZVnOUlze2z3d8DjLm4fMffeK69W+pjhAHAV2LNmyzRCpdPFw7j7+ugpKoAKtNTQzAo7IivEZQurjwlwbXepsQIc4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XQBkijQH; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Tum4K
	/CbqYUhGYnJ8GFo7ngbhq4ZDFew8CuChjud+OA=; b=XQBkijQH1229QEnM9pFb7
	TFINt+2er18MsGBZaBqYVJyNfcfp+zHT6xPZRUm/pbI557ouPKrekxUmJnSa4LuW
	VWjJpb4/8q8HuvEp+a8iXmsrl1Lj/psG5e3r50zHNLDlqz3sq1rV54txKG5CyBBr
	4rPbDRHkVo1nZwOSSDnHFM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHUkXjwRBoU_m0DA--.22532S4;
	Tue, 29 Apr 2025 20:11:20 +0800 (CST)
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
Subject: [PATCH v2 2/3] PCI: mobiveil: Refactor link status check
Date: Tue, 29 Apr 2025 20:11:08 +0800
Message-Id: <20250429121109.16864-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250429121109.16864-1-18255117159@163.com>
References: <20250429121109.16864-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHUkXjwRBoU_m0DA--.22532S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF15Zw4kKrW8Aryftr4kCrg_yoW8Zr1fpa
	yqyw17C3W3Ja1FgF15ZayUZFy5t3Z3ur9rJ3y7uwn3Xa47CrWjy3Z8JFyftwn3Gws5Xry7
	J3Waqa17GF45XFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR75rxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxg+o2gQv-k5PgABsm

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


