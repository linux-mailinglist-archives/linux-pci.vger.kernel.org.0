Return-Path: <linux-pci+bounces-27738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB3AB70F3
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4058C1778
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BF27FD4F;
	Wed, 14 May 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ejb5XTWg"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF67E27E7C6;
	Wed, 14 May 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239236; cv=none; b=aE/gXsHDispzld2jCZCIkIbZQmJF4d4yb8ldhOrH3LKG6sChmPvs7Ai+2diqCrfkbp+D0w27WRHMf6jrG7G554sDzBAfn6YtZ5K3jqT3LdjQFaXC+iEyaOz0bNK9SsIC19YTB//x3cWYlL+hw6lRR4J1C4pK8WdbPl3beJITCqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239236; c=relaxed/simple;
	bh=a0IJ7Y8Gcxga/WUahonkPZOQm3+MVRPFt4uQgezB5Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYFWzJRtOoKGuSkCrpJpg7U/XKE5Yc3eSH0L8isKGYhtSbwiED9oL6ygPqIMojchVsDKMebgAZvW5bWgnAquZmu9lSTj6ZHI8RNrQUUkL6lTSUiaegCpXiKQLUlixroyQzHkPM8giXhYwB0oRXjw247+V4rjnszw7GugKh4kXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ejb5XTWg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=z3
	tVYKhVSnBxgz7QO8X1J6BNvx8MlgHI9dpWaxnt6sU=; b=Ejb5XTWglM4HYo3TOv
	KI6gsbgSaomA3tF0SVeGWVaL3M4O/pK6d+6F1vUT3DQG6szu5IHCRRsx3KySws9P
	+BefZnxSbJOQJrrKx1ZT+RSw8r1DXVtXRSvVQ24xiDWaWJzH0JOiJgn5N9f3S79z
	6iG7+OSWzl80BjBdLj0Uk0gU8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3VU0LwSRo5cN_BQ--.35962S3;
	Thu, 15 May 2025 00:13:00 +0800 (CST)
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
Subject: [PATCH v12 1/6] PCI: Introduce generic bus config read helper function
Date: Thu, 15 May 2025 00:12:53 +0800
Message-Id: <20250514161258.93844-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250514161258.93844-1-18255117159@163.com>
References: <20250514161258.93844-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3VU0LwSRo5cN_BQ--.35962S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18WF13CFW8ZFyfAF4rAFb_yoW8tFyUpF
	W5AF1fAr48JFy5JFs5Zay8GFy5GF97tFWUGrWxJ3sxZF13CayUAas3Ka45Xr12gr4DZr18
	Z395KFyUC3WDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zETa0fUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwpNo2gkvuBv5wAAsx

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
Changes since v9 ~ v11:
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


