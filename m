Return-Path: <linux-pci+bounces-25526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20028A81BA7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 05:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75807A6C87
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 03:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEC1D86FF;
	Wed,  9 Apr 2025 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZgVdxCBR"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA01D6195;
	Wed,  9 Apr 2025 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170159; cv=none; b=B81vVPOoQZjQ2uzMQsgCJeNQH+5wOpbac6SEnphhIaCAXaLRcVQhpYDpKAkRB13ACfuzL3gllkYzQQ09MkJF/hM7Lt6cjaIZEqboMOti1SMF/M7xIKp/zbxUXf9KlscgbCzlZlWpNrwcdVcA0aPaarHTm9mII8l+NZT9dc2o0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170159; c=relaxed/simple;
	bh=0pFq+tUzBJXpqVJru5uQ+iT2LEHKruLJ6ze/L//1PA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Btl2Rr5tQkN2uXmo2ZTuYuRn1WZf1saJ/ff+ncrp5ilJlGSlP5SOP2yY5rG7QEVtGeZe8Mvh4LEUdmWlPC0g0UtS0Sa6NcpdIfHq/hEa17sDUw6zS8v5kW1+zwxElB+RQEW0gmhz6T/YTwxWHcP06XcQAjLATwHfpHNijZuyKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZgVdxCBR; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t9goI
	IdCZPlAHILa8GBZNLDBq8hqVNXvTZZGrRvFQPY=; b=ZgVdxCBRLPj5PutZRpBsL
	tJGU09bNEivS+ja0LsP+xP6ciRIFE7TfgjsAKLgKxaGiqtfh/Bo46YR29FvltkOz
	sriDzP+LD+XhNaSiTSq/VeJyhaXSFj6CwNd8O+VWAQT6V/Nu0BHTe5bkma9swt5N
	AWjzzxH091T+oDmG4rngf8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHD3GH7PVnbwQBFQ--.4446S3;
	Wed, 09 Apr 2025 11:42:03 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v9 1/6] PCI: Introduce generic bus config read helper function
Date: Wed,  9 Apr 2025 11:41:51 +0800
Message-Id: <20250409034156.92686-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250409034156.92686-1-18255117159@163.com>
References: <20250409034156.92686-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHD3GH7PVnbwQBFQ--.4446S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18WF13CFW8ZFyfAF4rAFb_yoW8trW3pF
	W5AF1fAr48JFy5Aan5Zay8GFy5GF97tFWUGrWxC3sxZF1akayUAasaga43Xry2gr4DZr1x
	Z395KFyUG3WkAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zico7AUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxcqo2f164krrgAAsk

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


