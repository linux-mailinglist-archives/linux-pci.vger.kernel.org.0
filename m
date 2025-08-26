Return-Path: <linux-pci+bounces-34774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D392B370E4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4457E8E4020
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBB03314DF;
	Tue, 26 Aug 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mE0XzSHl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65E3164C3;
	Tue, 26 Aug 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227843; cv=none; b=VXhV0Cmr3aVOgdvfS9w1bqbHcoM1v9IxryDXWf6bj05Q4fK35faYHzZ5ebMErr7SyUOsr7IVxVPaUrytIwLzzUsjPhYpuPb8S8z95AjGuLGg9/JFkzMUdXsomAGNXrj4l+A5wlTP644ncwozSyeiUDwmlE8tiDWIyT9RrLTYldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227843; c=relaxed/simple;
	bh=PzxB7EXeBBq9X2O62z17uIS37bPvHgJop7R2XpFEmRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBEe469ZyDq1tiMLlegrNTvULuSpuEAMVx8RWyNNhw/C/HiVNXfiBD7pADIR2jZP+Mr5aem7zxghSYvNEolNpgJcXigd1T0CSbNkz/CbJENH5RCzljh/arI/znLD+6mh7XDozgtmKza6s4oZq8SXYacHNGaiK26ElReupAQOYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mE0XzSHl; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4g
	5VH9wjrprzlXPzrZWyAbKi8qn1R+gMZhJCUpetlS8=; b=mE0XzSHlA938S0khqF
	VJvVS+1HYEKH/oBmJ0LKacE9nYG23k7CoU2LEDPSKyrDHZ0eRskyBPlJfPiIogs2
	v8/aKvKuzIvdsSxIZKSDJoqSbKVJb4MkGPBytuuWBngQEykC2co6L4wDZhC3xTog
	QifynpIF+m/kx+4gDSgx1UwMg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S7;
	Wed, 27 Aug 2025 01:03:44 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 5/8] PCI: brcmstb: Add macro for link up check delay
Date: Wed, 27 Aug 2025 01:03:12 +0800
Message-Id: <20250826170315.721551-6-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826170315.721551-1-18255117159@163.com>
References: <20250826170315.721551-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF48Ww45Kr4xWFW3GryUWrg_yoWDXwb_ua
	yjkrn7Cr1j9ryfArnay3yFvr9Yy3WxXr1vv3Z5KF1SyF9Iqr1kZryrZrZ3Xa1kuF48KFy2
	yFsFyF1j9FyxAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRdWrX5UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwi1o2it56YclQAAsQ

Add BRCM_PCIE_LINK_UP_CHECK_MS macro for link up check delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..dd682c5e5f49 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -214,6 +214,8 @@
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
 
+#define BRCM_PCIE_LINK_UP_CHECK_MS	5
+
 /* Forward declarations */
 struct brcm_pcie;
 
@@ -1365,7 +1367,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	 * total of 100ms.
 	 */
 	for (i = 0; i < 100 && !brcm_pcie_link_up(pcie); i += 5)
-		msleep(5);
+		msleep(BRCM_PCIE_LINK_UP_CHECK_MS);
 
 	if (!brcm_pcie_link_up(pcie)) {
 		dev_err(dev, "link down\n");
-- 
2.25.1


