Return-Path: <linux-pci+bounces-34771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B731B370DE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FD33672B6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5442E3B08;
	Tue, 26 Aug 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jsYbY/1S"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872E2E2DCF;
	Tue, 26 Aug 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227838; cv=none; b=sy/2rrweLnHC+1RaphjQsJOYAEgyhy9wMQ7HRQPY3IcQ63MXLbb5ZGPEVyLwjAzSUJgkI5gqErQwlJDp89ky0qYGmXxENo/rnKQ0RLy715F156FTe1nUh8U/tugFxBlff0mK/sa1U6ffya/La6+Ieqh5nLV7JUx17edOs1slgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227838; c=relaxed/simple;
	bh=O7cKFTO7QqpMBpb90+ZeyEjE5vWm5wRDSmrWherjG/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ea+65ui9GLoYdFRIFTHE4qsrpguCWjC7/LnLtB6geLe+HeYEiVHRVTJO/pK8R7YbJINsFjt6GyIgfJAf3MBnVptkJHVC61IZDbmXDuWFXBTsdovEj5/yq3HTqKUdh54NHKRx9kBOh63ohvY6uDg/CPiQvBhSMEtHD4fGPkwTBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jsYbY/1S; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IH
	Yy5mF+8CJT7S/nW24UwyCSGso7dtsA3nfIjCqd0D4=; b=jsYbY/1SjK+snDp4kM
	rD8IgDs2iCU8umBlPqnwS4FG7J6MiQkzWLdc39aIqMPvGzMowrCoujpBIsuT+8rx
	+J8YwCcGplyntYQSLlLr8ZyO439RK9kojvrH2kZ/b63s+fUANR4Vwn5oz3kSDeov
	WrmLgZEm4PGPtgBCe8mZDo0Lc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S3;
	Wed, 27 Aug 2025 01:03:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 1/8] PCI: Add macro for secondary bus reset delay
Date: Wed, 27 Aug 2025 01:03:08 +0800
Message-Id: <20250826170315.721551-2-18255117159@163.com>
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
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWxCr4rCF45KryfWF17ZFb_yoW8XF15pF
	Z8CFy8AF1rJa15Xrs5Aa18u34rG3ZI9FWjkF48K3sa93W3Aa4Du3y3KFW5WrnFqrWxXr13
	Aas8C34UJFW5trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNJP__UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxO1o2it3wnvHQACs9

Add PCI_T_RST_SEC_BUS_DELAY_MS macro for the secondary bus reset
delay value according to PCIe r7.0 spec, section 7.5.1.3.13.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 7 ++-----
 drivers/pci/pci.h | 3 +++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..c05a4c2fa643 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4963,11 +4963,8 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
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
index 34f65d69662e..4d7e9c3f3453 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -60,6 +60,9 @@ struct pcie_tlp_log;
 #define PCIE_LINK_WAIT_MAX_RETRIES	10
 #define PCIE_LINK_WAIT_SLEEP_MS		90
 
+/* PCIe r7.0, sec 7.5.1.3.13, requires minimum Trst of 1ms */
+#define PCI_T_RST_SEC_BUS_DELAY_MS	1
+
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
 #define PCIE_MSG_TYPE_R_ADDR	1
-- 
2.25.1


