Return-Path: <linux-pci+bounces-29146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3FCAD0E71
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A623AE2C5
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31E91FF5F9;
	Sat,  7 Jun 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QXYFZYT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE321F4C99;
	Sat,  7 Jun 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312876; cv=none; b=gzkcAayZ18/XtQqiq4w+6wJ4CK2TESCA8SDzG+bh6HUsshWykMTqxo8QeNu99SMDCBDw8EWw4hEZxn+bXIhxMBINfa2fibx5LsNSb4vgd4BQCXNdd0xERH+NsaPbmkseuywbXwG6x3mAucWVQRPlMl6ujOyFiKVwOvxy267gll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312876; c=relaxed/simple;
	bh=G0QfCGxaqWNayXdyhW3Ow5IbHfbUKjnHQJqqEiy6ICg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgRk1rh8ZMqTHkv89fKYkNBhm5C9D/rVe3i8MZPQ3HZf4mkVEkS9ZDbiGzUQS3uDevoPeP+qpUnl+JD+IJO3TK4wprqZAADeHbOgI911bt59O6FDm0YAZAaxgE56oSSsSleWB/7cXBrtc3N+xli5yggRzNii8dk5CTZ/VHcaqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QXYFZYT8; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nk
	c98BRkE6f3SlJs5hyrJtJfPxAsb/yrKLilb5D7ZlI=; b=QXYFZYT8tVGVnDUhF1
	fF/CrEsUhTKu4eAXLk+zX5Aw6gurtwmml6LlRuprb7H+2Kdn3bndhYGAgH7SVici
	ieliJTm/OSAh7olbuhHJyriHwIzqK6lerr4cUdO/XSiv1ibQLTrra8AZ8w0/oT8x
	cHkJOm/syAi8PvMEZkTSPDM4o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHuXJPZURoL9paGw--.4161S3;
	Sun, 08 Jun 2025 00:14:08 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v13 1/6] PCI: Introduce generic bus config read helper function
Date: Sun,  8 Jun 2025 00:14:00 +0800
Message-Id: <20250607161405.808585-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607161405.808585-1-18255117159@163.com>
References: <20250607161405.808585-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHuXJPZURoL9paGw--.4161S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18WF13CFW8ZFyfAF4rAFb_yoW8Kr17pF
	W5AF13Ar48JF15JF4vvay8GFy5GFZ7tayUGrWxJ3sxZF13Ca4UAasFgFy5Xr1agr4Dur1r
	Zan5GFyUC3WDAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zER6wXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwZlo2hEXgmroAABsq

The primary PCI config space accessors are tied to the size of the read
(byte/word/dword). Upcoming refactoring of PCI capability discovery logic
requires passing a config accessor function that must be able to perform
read with different sizes.

Add any size config space read accessor pci_bus_read_config() to allow
giving it as the config space accessor to the upcoming PCI capability
discovery macro.

Reconstructs the PCI function discovery logic to prepare for unified
configuration of access modes. No function changes are intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v12:
- Optimize the function return values.

Changes since v9 ~ v11:
- None

Changes since v8:
- The new split is patch 1/6.
- The patch commit message were modified.
---
 drivers/pci/access.c | 15 +++++++++++++++
 drivers/pci/pci.h    |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..ba66f55d2524 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -85,6 +85,21 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
 
+int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
+			u32 *val)
+{
+	struct pci_bus *bus = priv;
+
+	if (size == 1)
+		return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
+	else if (size == 2)
+		return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
+	else if (size == 4)
+		return pci_bus_read_config_dword(bus, devfn, where, val);
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+}
+
 int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 			    int where, int size, u32 *val)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..e7d31ed56731 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -90,6 +90,8 @@ extern bool pci_early_dump;
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
+int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
+			u32 *val);
 
 /* Functions internal to the PCI core code */
 
-- 
2.25.1


