Return-Path: <linux-pci+bounces-27545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD4AB248C
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 18:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C317B0747
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90FE1B21AD;
	Sat, 10 May 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dGDgTEhq"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC50D131E2D;
	Sat, 10 May 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746893258; cv=none; b=DoR/yZw448fDqFGHTyElKIdJ27H7aejAwYny0+yeedzpkR5CDSAXHHMH/a0Yj4wI5PxKC7HVWcB3Pyme6lvYHWwiqEYcCjkthf7pSz2GHP6TzqBbcFfjkk8J+hgoTv9RX8CV6fXvaWUsTemrDbM4G0AN2d6lSMA+DY8Jtp4W7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746893258; c=relaxed/simple;
	bh=qCVTRsgOQXjYmdB23PKjKk0BOdh0WQKsUWE9X/Y1ZjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O76K0NX7YIhICXT/UHnH6bX3/IOB/FWDT0JZxxSoC8cg+TTJi90pGjO6y86hAV5KHrC8TVORuZbqxJ89uk8odB9N4/97XhfRAlwUJKYUpxVQi1aDMFlCCCnwkrDpXs5ujBQ3ceiNx9Uv3HedOSqPttSOmH5aiXA4SYJKqWpnXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dGDgTEhq; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gq
	o9rRKe5zM7oG8pB3jEkjnqFB9T7qs35E3i4W8LpTw=; b=dGDgTEhqLpq8aaGkUF
	g8CDXul9QjJ2qTCFrekpCdDLky8eFhGnTFbZXzF9l6dmJYk4bwv4dXIgIVtz5svx
	r8JbqPh4OlAe3LD+AD8JFRLYCZh4K7PHbr2a7zobIpTjr+I4GaAPWM2i0PqRGFnO
	L6j4sggw838asC+vCbAUP925c=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD36iuveR9o3J32AA--.26781S4;
	Sun, 11 May 2025 00:07:15 +0800 (CST)
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
Subject: [RESEND PATCH v2 2/3] PCI: mobiveil: Refactor link status check
Date: Sun, 11 May 2025 00:07:09 +0800
Message-Id: <20250510160710.392122-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250510160710.392122-1-18255117159@163.com>
References: <20250510160710.392122-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD36iuveR9o3J32AA--.26781S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF15Zw4kKry5Kr15Wr4DJwb_yoW8ZFWrpa
	yqyw17C3W3Ja1rWF15ZayrZFy5t3Z3ur9rJ3y7uwn7Xa43CrWUtFn8JFyftwn5Gws5Xry7
	J3Waqa17GF45XFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zina9-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwRJo2gfb9Tk5wAAs6

Update ls_g4_pcie_link_up() to return bool and simplify the LTSSM state
check. Align function signature in pcie-mobiveil.h to match the change,
ensuring consistency across the Mobiveil PCIe driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


