Return-Path: <linux-pci+bounces-34772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F36B370E0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAB51BA2541
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2362E7648;
	Tue, 26 Aug 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JyKHiyez"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E72E2DFB;
	Tue, 26 Aug 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227839; cv=none; b=YZUOJV+2kOrv5jOREd2wvK5aDN0mPDSLm2TaCM58E8WBXt8StGYdtEBFmfezD7OzvRUGF5OnrZ5JfOOud9lXSPkzoA69D/5uGv5pFzmL674tv0RtPPMaQSCF+G9it/RS7NYreRwdDF4vY4Ao74wsHT6bQowsDxTSfTSDRcq0HsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227839; c=relaxed/simple;
	bh=8SeQr4D4EiGpfposJmSR0Ueorh7PiGNe8AHplaaSQBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASHbcoXZ6kWqDni6TjcUny7Feh3C8ZK20GspOVNE5uFRKrSPjC7y+tjBI2L9M99N7LdvbUFS6TaWIzPIyIdDHUfYkSWrNNwKN91z4KGnGnpwuuBEZxT8ZeGvTsYrQsaoXM6MloXGmr0JR7NDg/anfWN+pApcgQ7B77QNXtFO2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JyKHiyez; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fI
	Ms65ZBsalDj93zvT/al+hRSFG0BgGv7ziNOHFxRQ4=; b=JyKHiyezTBkyMrWUer
	a540WorBsVP9ri5h10uj7VGqLQn6PYu0795qsY5AiiY0LRVw6qwpoY5SqNL4jMkM
	VGFoNnBR3w2wkJC7DPuvDiAiODY4Uwl1w9xrGp3CQ/mJRkclH/9ldAHcoXan8dSu
	gh1ITapaIEKu/WnL00IpKfN3I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S6;
	Wed, 27 Aug 2025 01:03:43 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 4/8] PCI: rcar-host: Add macro for speed change monitoring delay
Date: Wed, 27 Aug 2025 01:03:11 +0800
Message-Id: <20250826170315.721551-5-18255117159@163.com>
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
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW7WFy8WFyDZF15ur4rZrb_yoWfWrg_u3
	4a9F4xCrZrCFyakFyjkw4aqr90ka4jqrnYgasYqas3ZFZrX34kJrs2vrWDZr1rCa15Ja4x
	t3Z8tr10kr47CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRGfOzUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgK1o2it5y8lJQABsi

Add RCAR_SPEED_CHANGE_CHECK_MS macro for speed change monitoring delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index fe288fd770c4..77f45637b0fe 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -34,6 +34,8 @@
 
 #include "pcie-rcar.h"
 
+#define RCAR_SPEED_CHANGE_CHECK_MS	1
+
 struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
@@ -339,7 +341,7 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 			goto done;
 		}
 
-		msleep(1);
+		msleep(RCAR_SPEED_CHANGE_CHECK_MS);
 	}
 
 	dev_err(dev, "Speed change timed out\n");
-- 
2.25.1


