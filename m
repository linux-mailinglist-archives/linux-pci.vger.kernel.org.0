Return-Path: <linux-pci+bounces-24376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0659AA6C033
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D34A463802
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480722DF92;
	Fri, 21 Mar 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S3r1+Qz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF2722D4F2;
	Fri, 21 Mar 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575122; cv=none; b=DpgG4NOX7lLs6r5oPLlLxjvjdRNTbpc3dzDffajhP7YXzcp8ItsX+vhgMTtJ9udTWlu+ioYNZy/8ThFcO0+Ei4Iwed3/1jdvehMeDgVQ/+X4QFKGznNPPPTNdu+/BZ9My4b7EF6HRyqlKnGgYNbLKgOF9IpMtkJXK9LVWD1xs9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575122; c=relaxed/simple;
	bh=oASh3wy+6Zu8pjLdWpIKMk/D6S2LV1BGssmHptzQW4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jvu+/kUZdnFOoH8SfcFpPIyyvI8nad9wl2yTwoNvoXtdVAoJFYDKEQq2XXOeEi9WPErpANAroHQtLuTucSTQ910S/UbgrSuRtX0B1c4SaK4LWk7AB7WCf3UPLlzXAkao8IYGzpCBtf6VYUxQ2gO8jZuhDUB2lcsCysrLpALWhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S3r1+Qz5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OjpOK
	cGhBDXFINK3Wem/YiCNyIuMSE6KlB+23VVaVHA=; b=S3r1+Qz56alnhogjCzuo6
	6sIwig7VKxb6gU+dQzAk43vYvBMA6KpjOmBCMsvOmw+5BvDv0tBifxk8Im358ehO
	E3PUt9GvW5VL9+2re5Q5lH7TIZUpI89u1sGotnO/JdkolPoBaLrTIJKyRyezC0bm
	I3Xnw/zhZtWUu1P7qWo0wc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC30e7sld1nnmPrAw--.48109S5;
	Sat, 22 Mar 2025 00:38:06 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v5 3/4] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
Date: Sat, 22 Mar 2025 00:38:02 +0800
Message-Id: <20250321163803.391056-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321163803.391056-1-18255117159@163.com>
References: <20250321163803.391056-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC30e7sld1nnmPrAw--.48109S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyftr45GFW7tw18Cw17ZFb_yoW5Xw1kpF
	WUCFyfCF1rJrW7uFs3Z3W5XF13tasay347t39ak34fZF17CF1UGFn2gFy5tFZIkrZFgr1f
	XF9rtFykKrn5tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR9FxbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw0Xo2fdjwDOzgAAsX

Since the PCI core is now exposing generic APIs for the host bridges to
search for the PCIe capabilities, make use of them in the CDNS driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v4:
https://lore.kernel.org/linux-pci/20250321101710.371480-4-18255117159@163.com/

- The patch subject and commit message were modified.

Changes since v2~v3:
https://lore.kernel.org/linux-pci/20250308133903.322216-1-18255117159@163.com/
https://lore.kernel.org/linux-pci/20250321040358.360755-4-18255117159@163.com/

- Introduce generic capability search functions

Changes since v1:
https://lore.kernel.org/linux-pci/20250123070935.1810110-1-18255117159@163.com

- Added calling the new API in PCI-Cadence ep.c.
- Add a commit message reason for adding the API.
---
 drivers/pci/controller/cadence/pcie-cadence.c | 25 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..329dab4ff813 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -8,6 +8,31 @@
 
 #include "pcie-cadence.h"
 
+static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
+{
+	struct cdns_pcie *pcie = priv;
+	u32 val;
+
+	if (size == 4)
+		val = readl(pcie->reg_base + where);
+	else if (size == 2)
+		val = readw(pcie->reg_base + where);
+	else if (size == 1)
+		val = readb(pcie->reg_base + where);
+
+	return val;
+}
+
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
+}
+
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
+}
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay = 0x3;
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..6f4981fccb94 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -557,6 +557,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 }
 #endif
 
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
 
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
-- 
2.25.1


