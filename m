Return-Path: <linux-pci+bounces-27881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC223ABA167
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C26520DEC
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA922F745;
	Fri, 16 May 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W4GHeuHb"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE3222574;
	Fri, 16 May 2025 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414575; cv=none; b=U/w0eHRJZGAlsHiQ7fZvwCiYNfnEStp94H80zYYn+2JgsVOLxDu8l09dnEbjjjeB/NgyNvBxSpQ7MfDMjKTbU62WFKG2ucaU5Vr+pPiZfqEHW4JyBzJjjltAKVhpA5d69cgrU+VyFkTk2HvcD7ejKXTiuWc3o6zeiE0tLimL4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414575; c=relaxed/simple;
	bh=TIDsyO8zNvHhbmAf26QKPKrH/NqAQswaf+M/Ttjj8Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCGPTKV9vU0psWeKY2trJdonk+2LRv+qd4YbN7Zy00zhieziwaNKnXHHUxZOteA4jk/cbtWl2FpmmPOKsK0tyOYv7q/oTV8ZbH3oiBZJu1H/RZww/592bXkyF4Cj3lO+60gVLb5a11RnFXhLjX2tZ+U/8WKQEzQHg354HRi5lpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W4GHeuHb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gr
	A5e9IizUHs6xNUrHdJHCEjg25RlCLjAgPs5bVE1s8=; b=W4GHeuHb8bTBki/Nz8
	Za443f8O0mNQTaO3Firhsddwn9orQGcVp5KhIHrcXZWCw758smz80EjA3ZTx6Kws
	lFyU3z+r4x+jRgjH+kC7ZPzNx+Ncg+ynjO+WQFDtdckb73ad/1JJDHrneudoFgtq
	2itaqh69516l8ALGVDw9oWDKk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3lOX6bSdoVElgBw--.64634S4;
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
Subject: [PATCH 2/4] PCI/AER: Introduce aer_panic kernel command-line option
Date: Sat, 17 May 2025 00:55:16 +0800
Message-Id: <20250516165518.125495-3-18255117159@163.com>
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
X-CM-TRANSID:_____wB3lOX6bSdoVElgBw--.64634S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18XFyrtr4fZF1DAFWDurg_yoW5Jr17pF
	W5Aa48Ar4rGF1rXa1kZ3W8ua4rXwnIq34fCayfG393uF13Aa4fJwn3tFy7ZF1xJrWkur1a
	yF4Yyr17ur45JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn3ktUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwFPo2gnaWRvgQAAsa

From: Hans Zhang <hans.zhang@cixtech.com>

Add a new "aer_panic" kernel parameter to force panic on unrecoverable
PCIe errors. This prepares for handling fatal AER errors in systems where
bus hangs require immediate reboot.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/pci.c      | 2 ++
 drivers/pci/pci.h      | 2 ++
 drivers/pci/pcie/aer.c | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0ce..663454135224 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6821,6 +6821,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "aer_panic")) {
+				pci_aer_panic();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..8ddfc1677eeb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -958,6 +958,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_aer_panic(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -968,6 +969,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_aer_panic(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ade98c5a19b9..fa51fb8a5fe7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -112,6 +112,7 @@ struct aer_stats {
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
 static bool pcie_aer_disable;
+static bool pcie_aer_panic;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
@@ -119,6 +120,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = true;
 }
 
+void pci_aer_panic(void)
+{
+	pcie_aer_panic = true;
+}
+
 bool pci_aer_available(void)
 {
 	return !pcie_aer_disable && pci_msi_enabled();
-- 
2.25.1


