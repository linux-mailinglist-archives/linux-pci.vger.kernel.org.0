Return-Path: <linux-pci+bounces-21782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A37A3AF93
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701F916DA9D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9D16F841;
	Wed, 19 Feb 2025 02:27:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4D15B543;
	Wed, 19 Feb 2025 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932062; cv=none; b=SvR0XvM8B//94rwpT2fkhdt7KsJT09x7sZ+FUBgEh47NmfR++qx2+7JRkH0cRVYlT8Xewt/3TfKZJEnszyELSSkrhovIGXa8Aewhx2FKMibrhmi8joo2IocAB/WqIQ1QM2ol3nV57gzWXzHfjLVCTOCcEn/m1NtIzfFkdxS7D9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932062; c=relaxed/simple;
	bh=GHv/arb+LD6QvPJoEEjCWKKQwB2btzeVJ/8m5os1omg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc/BE76ycWDO/Gu7f1miC+B0cQuMc2lE2HyY+cnO4OYnXZaOshaa0dgxoK0WK90aCDlcnEjEx0nW2yQwlbeQCT/T7MkHwdMijXeAlZ59/pN974tkyrFLkLqzCkyqxL1uBFd5yYdsJhqUpwkJjnN/19u/u+5RDqI0mcsfR/wFwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHaT6KQbVnOSWrAw--.23116S2;
	Wed, 19 Feb 2025 10:27:22 +0800 (CST)
Received: from localhost.localdomain (unknown [219.142.137.151])
	by mail (Coremail) with SMTP id AQAAfwD3+ISDQbVni6wrAA--.6812S2;
	Wed, 19 Feb 2025 10:27:20 +0800 (CST)
From: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	christian.koenig@amd.com,
	daizhiyuan@phytium.com.cn,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: Update Resizable BAR Capability Register fields
Date: Wed, 19 Feb 2025 10:27:12 +0800
Message-ID: <20250219022712.276287-1-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218202545.GA177904@bhelgaas>
References: <20250218202545.GA177904@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwD3+ISDQbVni6wrAA--.6812S2
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=daizhiyuan
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAFWDXFWfGFW3Ww1fGF43Awb_yoW5Cr1kpr
	WDCa97Gr4rGFZF9w1kZ3W0yw45K393ZFy5CrWSg39ruFn0k3Z2qr1jka45Ja4rJrs7ZF45
	Gr9rt345Wrn8JaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
but supporting anything bigger than 128TB requires changes to pci_rebar_get_possible_sizes()
to read the additional Capability bits from the Control register.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 drivers/pci/pci.c             | 14 ++++++++++----
 include/uapi/linux/pci_regs.h |  3 ++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 661f98c6c63a..8903deb2d891 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3752,12 +3752,13 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
  * @bar: BAR to query
  *
  * Get the possible sizes of a resizable BAR as bitmask defined in the spec
- * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
+ * (bit 0=1MB, bit 43=8EB). Returns 0 if BAR isn't resizable.
  */
-u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
+u64 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 {
 	int pos;
-	u32 cap;
+	u64 cap;
+	u32 cap2;
 
 	pos = pci_rebar_find_pos(pdev, bar);
 	if (pos < 0)
@@ -3766,6 +3767,11 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
 	cap = FIELD_GET(PCI_REBAR_CAP_SIZES, cap);
 
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &cap2);
+	cap2 = FIELD_GET(PCI_REBAR_CTRL_CAP_SIZES, cap2);
+
+	cap |= (cap2 << 32);
+
 	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
 	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
 	    bar == 0 && cap == 0x700)
@@ -3800,7 +3806,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
  * pci_rebar_set_size - set a new size for a BAR
  * @pdev: PCI device
  * @bar: BAR to set size to
- * @size: new size as defined in the spec (0=1MB, 19=512GB)
+ * @size: new size as defined in the spec (0=1MB, 43=8EB)
  *
  * Set the new size of a BAR as defined in the spec.
  * Returns zero if resizing was successful, error code otherwise.
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7ed5fab..345f45264567 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1013,13 +1013,14 @@
 
 /* Resizable BARs */
 #define PCI_REBAR_CAP		4	/* capability register */
-#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
+#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
 #define PCI_REBAR_CTRL		8	/* control register */
 #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
 #define  PCI_REBAR_CTRL_NBAR_SHIFT	5	    /* shift for # of BARs */
 #define  PCI_REBAR_CTRL_BAR_SIZE	0x00001F00  /* BAR size */
 #define  PCI_REBAR_CTRL_BAR_SHIFT	8	    /* shift for BAR size */
+#define  PCI_REBAR_CTRL_CAP_SIZES	0xFFFF0000  /* supported BAR sizes */
 
 /* Dynamic Power Allocation */
 #define PCI_DPA_CAP		4	/* capability register */
-- 
2.43.0


