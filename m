Return-Path: <linux-pci+bounces-34776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC27B370E8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E802367291
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D58350D43;
	Tue, 26 Aug 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gf00mUz2"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A33164DA;
	Tue, 26 Aug 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227844; cv=none; b=o34oD6wDsgVLPi2tESNSS+ZyerAHwzuE81lxzUVEZmsm0hNRUUCZekkfEcePv/jbEGZ3cugsClAv5BCSQUmfDQPDkRxN6iUBfr29NgJt5D5X+WBpG6iwhFeRlt8dqDfq0acMRpyD/Oli3dVIlRY1qzJzmfkSoSg27DfUVoC3DGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227844; c=relaxed/simple;
	bh=5NR28lI11iFijrgUk/8tzY1zztMvrg2JzA0KBOA00Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9Zg8pMzC0OwvGACDSC0C6B3K+L8/jtwKHYjILzJTTQ/1IaWQf9ftjlqubo0CunJ9IvvydSVwRC62LYncCB8xPtM9d6k6gVhKFLmymcMEsMi777IaIdwUf2Mfq8Wa/B9Loa3fEsv867WDH8C3P/UaKRe1N71oOWaL0SH8Ov5zPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gf00mUz2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ow
	MJQKXmGYRfKLERYLkLgzgQGOHR8lVXvt5FN5sY0r4=; b=gf00mUz23/HIqu4vYg
	lcQjrlFhgpQSnvkh0fLXz2prZUmbmOshgDClIlYKHqW/nroTC4IcV52NDqvLCez6
	uXJOzgxWlegbfT4HRjQZLgZsL52/V8xGNniHXHtkaUPL/WjzSGHLLVGk0uRWxrT6
	M539tFBNknxP4uNeR11+d5qs0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S8;
	Wed, 27 Aug 2025 01:03:44 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 6/8] PCI: rcar: Add macro for PHY ready check delay
Date: Wed, 27 Aug 2025 01:03:13 +0800
Message-Id: <20250826170315.721551-7-18255117159@163.com>
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
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S8
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry7Zw1fZr13uw4kAw4UCFg_yoWfWrb_u3
	yY9a17CrWqkFyakF12yw4IvF95A3WSq3WDXa4rtFyfAa13X348J3s2vrWDXrZ5Gws3Jr17
	tr1qyr48JrW7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_F4EJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgu1o2it5y8lQgAAsN

Add RCAR_PCIE_PHYRDY_CHECK_MS macro for PHY ready check delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rcar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 7583699ef7b6..653f13d82934 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -11,6 +11,8 @@
 
 #include "pcie-rcar.h"
 
+#define RCAR_PCIE_PHYRDY_CHECK_MS	5
+
 void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, unsigned int reg)
 {
 	writel(val, pcie->base + reg);
@@ -39,7 +41,7 @@ int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
 		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
 			return 0;
 
-		msleep(5);
+		msleep(RCAR_PCIE_PHYRDY_CHECK_MS);
 	}
 
 	return -ETIMEDOUT;
-- 
2.25.1


