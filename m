Return-Path: <linux-pci+bounces-27004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3CAA0C2A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 14:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896E198010B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713AA2D0267;
	Tue, 29 Apr 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IyxRGzjy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448A20E023;
	Tue, 29 Apr 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931092; cv=none; b=YK7bY/nZjWxAs7Z9m6FHL64E1HvL4VkzIdIGYxhV5xcLfIBGFjcv9E9MDG4xjC922Hu5gZyKeys2bb0kUyIDikTicNRMm+gLs1fl3xI5j6mq+JLSOt75Im+kKF144MsQnjeNJE1ARaeRj/zFIFZ85a5hMIBxdHeRa1YyfIfsUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931092; c=relaxed/simple;
	bh=J2jKQJBHaj6ec7/MlBjXVZ4a+VIqlvn1ACEf66l+0l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qqin4+eXogI3/HmXFnMVUEkKYzzz00/9Vnuag9CGnWsB+Z7miIkFk3txlGL9ZEbtB8X1k/Sg4i6pS1yV2eXmvmGecLZgDHIDRORg4xvlLtfWdswckjN9+O3CL3TodAceN+IyXKfaEBJkt2eHNCmIXEtv9JmXHXQDb5hFippuixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IyxRGzjy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=haJr+
	Ji0+AgbErl66drGXSA+m5yVDrg1sOKRRvEKpXg=; b=IyxRGzjyAlIUtn/onz47g
	vp1dpryZ5Iu8eAGZ7OAOe/EiP80LMzwHFhufy+AvLZIWCc8+/huY3eMZZbFdzzD2
	CZHuFuXwxTpsJcfhqJ/+9xZ7kiLQOTZi0E254GxXRV6ii1TyRg1ze5l8ZuJJg9vA
	IoD7vD3TmbTyQwvYPMB3gY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3DRQeyxBoOlBzDQ--.23007S3;
	Tue, 29 Apr 2025 20:50:40 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	kw@linux.com
Cc: cassel@kernel.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v10 1/6] PCI: Introduce generic bus config read helper function
Date: Tue, 29 Apr 2025 20:50:31 +0800
Message-Id: <20250429125036.88060-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250429125036.88060-1-18255117159@163.com>
References: <20250429125036.88060-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3DRQeyxBoOlBzDQ--.23007S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18WF13CFW8ZFyfAF4rAFb_yoW8tF43pF
	W5AF1fCr48JFy3Aan5Zay8GFy5GF97tFWUGrWxC3sxZF1akayjyasaga43Zry2grWDZr1I
	v395KFyUC3WkAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1mhrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhc+o2gQxspzIQABsX

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
Changes since v9:
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


