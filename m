Return-Path: <linux-pci+bounces-27174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DCAA9943
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9141884B50
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5F77111;
	Mon,  5 May 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pNIhhw9Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C626C3B2;
	Mon,  5 May 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462909; cv=none; b=qqwzczuIRROa/5nua6D49Ajl8/xg2tCTMqwyyMNxAbp6RKayJwq3PmpNGNVUH+7nMtWNyQadnkxl3aTez7IxaQIL9YaNyMBpGf5GQRXWFitt1hR1xcS/M8Ov+PxnWp9cbd/oNmd5uTMK82fcZJ4GmmgrwbZyPblwOHJfX/ZrUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462909; c=relaxed/simple;
	bh=ngbHOETLVG9cWTJhT5BSru7xH+CdbBGKlB3/+1DsWqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1GRCCreddh4sucq6F5pJufTdCGWTqbJN2YG5unVT3P2b2y/ilbAJB3RX3qLNbG3ivUdzDVdvQ9fEHm1p64k8iDztEAooSjdtL+fz2KzBsD3ldrUfpHHx7SHFnDmhM2QMvN4mMSxWuD3Wi+AFVxw+aR6ihEPxnTqfyc+Jsz6aeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pNIhhw9Q; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JF8kM
	Xkeg981ItdpJyZMD6/FpfMNcAlvk5L8cK//WKI=; b=pNIhhw9QY9lAiapb3GPOK
	sxlMVn2+AqwxbOCU309KAkffpLOjQ6X65PnbEepozRT64iq2/Ts5KxUhO72gUZ4Q
	BaS2GnaYLPELXKQzGYhyd7/414tYhpfciUeImhO1Qpt58U9/rczY8gapD6CvvJqj
	48Vylw+IUXVDw3cAHc/ryA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDn+lmO6BhoumvGBw--.3540S3;
	Tue, 06 May 2025 00:34:24 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	kw@linux.com
Cc: cassel@kernel.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v11 1/6] PCI: Introduce generic bus config read helper function
Date: Tue,  6 May 2025 00:34:15 +0800
Message-Id: <20250505163420.198012-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505163420.198012-1-18255117159@163.com>
References: <20250505163420.198012-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDn+lmO6BhoumvGBw--.3540S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18WF13CFW8ZFyfAF4rAFb_yoW8tFyUpF
	W5AF1fAr48JFy5JFs5Zay8GFy5GF97tFWUGrWxJ3sxZF13CayUAasxKa45Xr12gr4DZr18
	Z395GFyUC3WDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEf-BJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhpEo2gY51gYzgAAse

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
Changes since v9 ~ v10:
- None

Changes since v8:
- The new split is patch 1/6.
- The patch commit message were modified.
---
 drivers/pci/access.c | 17 +++++++++++++++++
 drivers/pci/pci.h    |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..603332658ab3 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
 
+int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
+			u32 *val)
+{
+	struct pci_bus *bus = priv;
+	int ret;
+
+	if (size == 1)
+		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
+	else if (size == 2)
+		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
+	else
+		ret = pci_bus_read_config_dword(bus, devfn, where, val);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_bus_read_config);
+
 int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 			    int where, int size, u32 *val)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..5e1477d6e254 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -88,6 +88,8 @@ extern bool pci_early_dump;
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
+int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
+			u32 *val);
 
 /* Functions internal to the PCI core code */
 
-- 
2.25.1


