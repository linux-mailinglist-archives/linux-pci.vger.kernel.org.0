Return-Path: <linux-pci+bounces-27548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08976AB2493
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3591A1B66B83
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C912472A1;
	Sat, 10 May 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PGysKsT5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2996D3A8F7;
	Sat, 10 May 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746893275; cv=none; b=QXfKx9sAljSS+1caIaC6yolj4sgNqegR2rDXiNlTDp16x4Er41OofCErcOW65lol4hpemOvj9k7nA7QnosHEQ9JFBfnNQEl+UxmA4Sxjf9j+jAMu8cOrOOvCcPSjk0XyTY8ku85VKW3h6edWuent/kzHqDiUzWjQSTGwhnOmKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746893275; c=relaxed/simple;
	bh=EyBk38F6ZK85gtv88dvrCB3ujD5xlH3Zy8D/bB1sHxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L20hO3tNyP9/HIeb28B5lKe3Y82OdAUlnZEx2SSSQcr/OSiZqmC/mmtcIpAyKm1wCgM0XvyiGYZaYzgHQlUtmF7CVNMGlEp2ZPK3RyShIcuDMhacAo/Q5B/BwwPZtaLO5S/AzeW0BkHlGfWx6qWoezKM+im2z8HdDanfWJM1yTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PGysKsT5; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hq
	qdK6+riiyILhRulkBMgu4uU7kcJMGEIBbmscsRpQ0=; b=PGysKsT5ERoK8btQi7
	66imDiC6sMwwV9IfWPpD/wg7vmTnXG/QXss8kQ2NztHTOzdHOlcHFQFWNoCGTaVS
	mVvexXxSm92VQ2Pr2FZhSh8kWVbKTh6yfWd9Dxtq6hKyUEYc8jeHc9DfB27mEh3a
	cmPv4CwMWeI6ekZSRy5smQP7A=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD36iuveR9o3J32AA--.26781S5;
	Sun, 11 May 2025 00:07:16 +0800 (CST)
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
Subject: [RESEND PATCH v2 3/3] PCI: cadence: Simplify j721e link status check
Date: Sun, 11 May 2025 00:07:10 +0800
Message-Id: <20250510160710.392122-4-18255117159@163.com>
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
X-CM-TRANSID:PigvCgD36iuveR9o3J32AA--.26781S5
X-Coremail-Antispam: 1Uf129KBjvdXoWruryDKrWxAr1kJF15ZFW5ZFb_yoWkJFX_ZF
	1FvF4IyFsrurZIkFyayFWayFyrAay2va12ga93t3WfAFyxGr4UAF1UZrWDWa4xua15AFn8
	Aw1qqFn8AryqvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRi-tI7UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxJJo2gfd4Y4tQACs+

Replace explicit if-else condition with direct return statement in
j721e_pcie_link_up(). This reduces code verbosity while maintaining
the same logic for detecting PCIe link completion.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/cadence/pci-j721e.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ef1cfdae33bb..bea1944a7eb2 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -153,11 +153,7 @@ static bool j721e_pcie_link_up(struct cdns_pcie *cdns_pcie)
 	u32 reg;
 
 	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_LINKSTATUS);
-	reg &= LINK_STATUS;
-	if (reg == LINK_UP_DL_COMPLETED)
-		return true;
-
-	return false;
+	return (reg & LINK_STATUS) == LINK_UP_DL_COMPLETED;
 }
 
 static const struct cdns_pcie_ops j721e_pcie_ops = {
-- 
2.25.1


