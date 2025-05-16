Return-Path: <linux-pci+bounces-27878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B4ABA114
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA8CA03A89
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126071DE4CE;
	Fri, 16 May 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P32eJtuW"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB519CC27;
	Fri, 16 May 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414394; cv=none; b=o2BNqE2JvAVPP6ikOpS6HF7KWvvvKHRil9bRqzP5LMTAElJR6OKoFCzI5ZX0cwFInMCs4jCR+Wpv0cxKKcnEDWOsnasoXE8tdy7Q8iKcOWIK293OCgZWNe/39KOMvqg8vbpoHaEHgZWUeOY9QP8U59vUDzU8efz3PEsP+rtvsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414394; c=relaxed/simple;
	bh=BsSgLnE6h6bvF6fJpIVKnxDPCk+WSApp6tFuzlSbHQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYvSm8ihpbO70TG9dmy5U+6heYnJTwazhaFHvOigaUxTn/RjKNLbOYsZ2ylCDDs5GZzU446pTp8jr/UCXczEHA1kCHOLb3vsddEHxxYgvWutH9jglajVqBaJ3TOKS+5HyUCpxT3OKD02ST9SWNn5+V5NcS+a9Rce/JRYGwRWapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P32eJtuW; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=W8
	Wyc0oz1RiDi99p1fQyjPjdTuXAIjZu9RzRSofe2HA=; b=P32eJtuW6/Bp95XoZs
	IcHtRPN9qh77aDMds9OrXYMKKewOwUCRYtNzFvkxREWbBQ+mxlmJeUo7y4yDNWyY
	S/NonKKTjar+aksUkUVMKuxVMsz7mL5jl+xkdT1wkPwmizOk6FLqWDm+ICdsh0xn
	nCrX0Xs6HDoHoUmmS+Ja1Fhlg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn1+RLbSdo12CoBw--.59952S3;
	Sat, 17 May 2025 00:52:28 +0800 (CST)
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
Subject: [PATCH 1/2] PCI/MSI: Use bool for MSI enable state tracking
Date: Sat, 17 May 2025 00:52:22 +0800
Message-Id: <20250516165223.125083-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516165223.125083-1-18255117159@163.com>
References: <20250516165223.125083-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1+RLbSdo12CoBw--.59952S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWry7tw13trWkAF1DCw43Awb_yoW5CFy8pF
	WvvF1rAr48Gay8Gr43Aw4UZ3W3XFs8Xa4xKrW8G345Z3W2ya4ktFn5tFy7W3WSqrWkuF13
	Arn0yF4UGay5AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0hFxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx5Po2gnaWRfUAAAsk

From: Hans Zhang <hans.zhang@cixtech.com>

Convert pci_msi_enable and pci_msi_enabled() to use bool type for clarity.
No functional changes, only code cleanup.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/msi/api.c | 2 +-
 drivers/pci/msi/msi.c | 4 ++--
 drivers/pci/msi/msi.h | 2 +-
 include/linux/pci.h   | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 17ec6332cb1d..bf7ae69c142b 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -401,7 +401,7 @@ EXPORT_SYMBOL_GPL(pci_restore_msi_state);
  * Return: true if MSI has not been globally disabled through ACPI FADT,
  * PCI bridge quirks, or the "pci=nomsi" kernel command-line option.
  */
-int pci_msi_enabled(void)
+bool pci_msi_enabled(void)
 {
 	return pci_msi_enable;
 }
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 8b8848788618..82e2d13ce816 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -15,7 +15,7 @@
 #include "../pci.h"
 #include "msi.h"
 
-int pci_msi_enable = 1;
+bool pci_msi_enable = true;
 
 /**
  * pci_msi_supported - check whether MSI may be enabled on a device
@@ -928,5 +928,5 @@ EXPORT_SYMBOL(msi_desc_to_pci_dev);
 
 void pci_no_msi(void)
 {
-	pci_msi_enable = 0;
+	pci_msi_enable = false;
 }
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index ee53cf079f4e..fc70b601e942 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -87,7 +87,7 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc);
 
 /* Subsystem variables */
-extern int pci_msi_enable;
+extern bool pci_msi_enable;
 
 /* MSI internal functions invoked from the public APIs */
 void pci_msi_shutdown(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6405cd..b231cbc67a35 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1671,7 +1671,7 @@ void pci_disable_msi(struct pci_dev *dev);
 int pci_msix_vec_count(struct pci_dev *dev);
 void pci_disable_msix(struct pci_dev *dev);
 void pci_restore_msi_state(struct pci_dev *dev);
-int pci_msi_enabled(void);
+bool pci_msi_enabled(void);
 int pci_enable_msi(struct pci_dev *dev);
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 			  int minvec, int maxvec);
@@ -1704,7 +1704,7 @@ static inline void pci_disable_msi(struct pci_dev *dev) { }
 static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_disable_msix(struct pci_dev *dev) { }
 static inline void pci_restore_msi_state(struct pci_dev *dev) { }
-static inline int pci_msi_enabled(void) { return 0; }
+static inline bool pci_msi_enabled(void) { return false; }
 static inline int pci_enable_msi(struct pci_dev *dev)
 { return -ENOSYS; }
 static inline int pci_enable_msix_range(struct pci_dev *dev,
-- 
2.25.1


