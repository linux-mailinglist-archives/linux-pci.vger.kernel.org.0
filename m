Return-Path: <linux-pci+bounces-21859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 160FAA3CEA6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 02:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A6C7A61B1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AD041C7F;
	Thu, 20 Feb 2025 01:26:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027B3C0C;
	Thu, 20 Feb 2025 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014764; cv=none; b=tHI1G/R5FqSK9+LCkiEardBa3pJ+XKKFEnPi/SC7k4aPlKP1Q7mUVAf9bBpbDMOT0r97hhJOWJJC22ffxA43r7RWwCgGl8lJkaq19Ltnks0PUslwFhTPEc1upeTzTMSoIaSTVU1TOwn7zdHwLz5d9r0NAE9YoP1/QVfYit73Vlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014764; c=relaxed/simple;
	bh=CFHteqH5JuzuGRt5uAjjg7LwLdewMSv/qJaGd/TIRWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEVpwLNYFL0Q64LBI1Yuv41f78GzYz6SJgHxXNjBekW55SuQqyK+UeS7j24gAmZaSlPRXfYh+93ZkSmdI3RrDEkwarPHv4dpDhqDzh4iZasUvbTsc1seFcYuMwhhXwYXbl9J/7t7PVdL4M6OsGp+UtWoFSskpj6Q5RzBNEtEVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAHl8mihLZnrikWBA--.45269S2;
	Thu, 20 Feb 2025 09:25:54 +0800 (CST)
Received: from localhost.localdomain (unknown [219.142.137.151])
	by mail (Coremail) with SMTP id AQAAfwA3PIichLZnsMMsAA--.23595S2;
	Thu, 20 Feb 2025 09:25:52 +0800 (CST)
From: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	christian.koenig@amd.com,
	daizhiyuan@phytium.com.cn,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI: Update Resizable BAR Capability Register fields
Date: Thu, 20 Feb 2025 09:25:46 +0800
Message-ID: <20250220012546.318577-1-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219183424.GA226683@bhelgaas>
References: <20250219183424.GA226683@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwA3PIichLZnsMMsAA--.23595S2
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=daizhiyuan
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ArWkArWDGF1kWw48Gr47XFb_yoW8try3pr
	4DCa97Kr4rKFW29w4kZ3W0yw45K39rZFyrCrWI93sruFnIk3Z2qF4UKay5tasrJrs7ZF45
	tFyqq345ur98XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

PCI Express Base Spec r6.0 defines BAR size up to 8 EB (2^63 bytes),
but supporting anything bigger than 128TB requires changes to pci_rebar_get_possible_sizes()
to read the additional Capability bits from the Control register.

If 8EB support is required, callers will need to be updated to handle u64 instead of u32.
For now, support is limited to 128TB, and support for sizes greater than 128TB can be
deferred to a later time.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 drivers/pci/pci.c             | 4 ++--
 include/uapi/linux/pci_regs.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 661f98c6c63a..77b9ceefb4e1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3752,7 +3752,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
  * @bar: BAR to query
  *
  * Get the possible sizes of a resizable BAR as bitmask defined in the spec
- * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
+ * (bit 0=1MB, bit 31=128TB). Returns 0 if BAR isn't resizable.
  */
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 {
@@ -3800,7 +3800,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
  * pci_rebar_set_size - set a new size for a BAR
  * @pdev: PCI device
  * @bar: BAR to set size to
- * @size: new size as defined in the spec (0=1MB, 19=512GB)
+ * @size: new size as defined in the spec (0=1MB, 31=128TB)
  *
  * Set the new size of a BAR as defined in the spec.
  * Returns zero if resizing was successful, error code otherwise.
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7ed5fab..ce99d4f34ce5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1013,7 +1013,7 @@
 
 /* Resizable BARs */
 #define PCI_REBAR_CAP		4	/* capability register */
-#define  PCI_REBAR_CAP_SIZES		0x00FFFFF0  /* supported BAR sizes */
+#define  PCI_REBAR_CAP_SIZES		0xFFFFFFF0  /* supported BAR sizes */
 #define PCI_REBAR_CTRL		8	/* control register */
 #define  PCI_REBAR_CTRL_BAR_IDX		0x00000007  /* BAR index */
 #define  PCI_REBAR_CTRL_NBAR_MASK	0x000000E0  /* # of resizable BARs */
-- 
2.43.0


