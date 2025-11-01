Return-Path: <linux-pci+bounces-40036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419BC28248
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91D9D3468A3
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09281C860B;
	Sat,  1 Nov 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MFxXnYMe"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5AE34D396;
	Sat,  1 Nov 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013779; cv=none; b=jZwwW2NYl6+eEHH84DKuJ6XMInHIFiop1ZZ5Aojtc7+oSWa3GA+m6ONmHRkMsIfO1o9H57KvKElcBZ1fIKPZ2yBdmI/geIaui+4WeSMuV6xZOOEUioVcgfIA+JzsPP4/oKsQhF9YeebcNEG2rYgeWS5FnGcCsFFdO2DjA9JAkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013779; c=relaxed/simple;
	bh=XoO5+IbnE6sXWF/C3GHFRnBv/TwY7itiqHDwdJ+uuHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnRYtbsuQIHQshs7QfauaA3VH6zLs1/CrKniseZkkHvvM5P9w6hd4Br46QwchlKI0dtRFjM02CFVzmQtVe9Bn0dqs9/rBz/C4vJNtmKg+jeGsb2s/HHky8O9mzaFKVHWxKSCCzxS1oeJ5zlHNJMbAd9s4TTc8G0j/vUYvwpBjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MFxXnYMe; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pQ
	VU6nxZUMfUMAJNSV13l+ou9BHpN2WCNClKQeJz+pw=; b=MFxXnYMeloGTf04oDM
	Vcq3Ong0ln2HRxvTp9mQab4fNR9g9qKYwhO1Qo/z2V+TzVBUYfU+W/nN6E17SQA9
	EQQ7Wr3nVqL52Fi+dAI+ceb/4UCsG/xOunXy6S0sBLbRAygCaFgn3s4ng3DTOJqG
	X8lU0aqFxAsRuUd13xIkZ4HPo=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXL4nTLwZp3qOtAw--.844S3;
	Sun, 02 Nov 2025 00:05:40 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 1/4] PCI: Add macro for secondary bus reset delay
Date: Sun,  2 Nov 2025 00:05:35 +0800
Message-Id: <20251101160538.10055-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101160538.10055-1-18255117159@163.com>
References: <20251101160538.10055-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL4nTLwZp3qOtAw--.844S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWxCr4rCF45KryfGF4fuFg_yoW8XF15pF
	Z8KFy8Ar1rXay5ZrZ5Aa18u34rG3ZI9FWjkF48K3sa93W3CFyDCay3KFW5WrnFqrWxXr13
	Aas8C34UJFW5trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_mii-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiFRH4o2kGJKfhJAAAs2

Add PCI_T_RST_SEC_BUS_DELAY_MS macro for the secondary bus reset
delay value according to PCIe r7.0 spec, section 7.5.1.3.13.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 7 ++-----
 drivers/pci/pci.h | 3 +++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..86449f2d627b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4912,11 +4912,8 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
 
-	/*
-	 * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
-	 * this to 2ms to ensure that we meet the minimum requirement.
-	 */
-	msleep(2);
+	/* Double this to 2ms to ensure that we meet the minimum requirement */
+	msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS);
 
 	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..31f975619774 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -63,6 +63,9 @@ struct pcie_tlp_log;
 #define PCIE_LINK_WAIT_MAX_RETRIES	10
 #define PCIE_LINK_WAIT_SLEEP_MS		90
 
+/* PCIe r7.0, sec 7.5.1.3.13, requires minimum Trst of 1ms */
+#define PCI_T_RST_SEC_BUS_DELAY_MS	1
+
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
 #define PCIE_MSG_TYPE_R_ADDR	1
-- 
2.34.1


