Return-Path: <linux-pci+bounces-27883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C88BABA166
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9081C0381B
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7D2135CE;
	Fri, 16 May 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="paU10sG4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C71DE4CE;
	Fri, 16 May 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414598; cv=none; b=QSVaYlmRJld37C44/QT9RjQJc4Y8N1+srXuQUJjv3fo5zpbXAnKKEQ9Z0yUzQWOAbQSFq6b5Kb8JknIm4k5vzWC/YXEi++eD01Wfs9ykcGEQMttEDz/LrkhSCcI1UwzYrm2EcktXD2yU/9CplyK0RkSmz+15fIF2RR3dLuH9Y3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414598; c=relaxed/simple;
	bh=sxk47qLZQGS5eU2o2fnvdm0YGf8LXnaJBJAQVWreRlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sK/Ee1n3JGhPe9vLlHkUdJBszZ/pEI1vc6aES29HAtP7N1Q45uG8mCAAKADY9xpNwlvHo/kwfsy+K6chPMls1B7iuPi3m2MRL5CvdrpewyGMCoFQoTtj9vox3JKwX6SSisEoUVN63eqO0VNqO5WwGs3JeycLCPjSt9pMcJCXi1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=paU10sG4; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ct
	nFyydU4fr89wS3U8rjM2P3apj75aODrTPV9Nlg/9Q=; b=paU10sG4czve6u6TW9
	Www1Izjma48yhpYZWV9CNfchPXUSpiDjZvbkroqrtE8hhV9OorB95yW+2PenX1aW
	LG764BB3rg5xTqRPIetuVVl4qmusY0yWP1lhlzlsfnjLw7eXT5mxblqCnLLoFaK9
	lfr/pvUHZ1fjlqEBPLoeLkuds=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3lOX6bSdoVElgBw--.64634S5;
	Sat, 17 May 2025 00:55:24 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	mahesh@linux.ibm.com
Cc: oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH 3/4] PCI/AER: Expose AER panic state via pci_aer_panic_enabled()
Date: Sat, 17 May 2025 00:55:17 +0800
Message-Id: <20250516165518.125495-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516165518.125495-1-18255117159@163.com>
References: <20250516165518.125495-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3lOX6bSdoVElgBw--.64634S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1xCw1UCr4fAr1UZr48tFb_yoW8ZF43pF
	Z5J34rAr4rGF9YgFWkZ3W8Za4rZ3s7t34rJFWkG395uFnxAa45J3s3AFyUXFn7XrWDuF1a
	yFy5tr13WF4rAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jmc_fUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwlPo2gnaDaNVQAAsj

From: Hans Zhang <hans.zhang@cixtech.com>

Add pci_aer_panic_enabled() to check if aer_panic is enabled system-wide.
Export the function for use in error recovery logic.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8ddfc1677eeb..f92928dadc6a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -959,6 +959,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_panic(void);
+bool pci_aer_panic_enabled(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -970,6 +971,7 @@ void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_panic(void) { }
+static inline bool pci_aer_panic_enabled(void) { return false; }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index fa51fb8a5fe7..4fd7db90b77c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -125,6 +125,18 @@ void pci_aer_panic(void)
 	pcie_aer_panic = true;
 }
 
+/**
+ * pci_aer_panic_enabled() - Are AER panic enabled system-wide?
+ *
+ * Return: true if AER panic has not been globally disabled through ACPI FADT,
+ * PCI bridge quirks, or the "pci=aer_panic" kernel command-line option.
+ */
+bool pci_aer_panic_enabled(void)
+{
+	return pcie_aer_panic;
+}
+EXPORT_SYMBOL(pci_aer_panic_enabled);
+
 bool pci_aer_available(void)
 {
 	return !pcie_aer_disable && pci_msi_enabled();
-- 
2.25.1


