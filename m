Return-Path: <linux-pci+bounces-35029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFCB39FA0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7732B987373
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD7314A66;
	Thu, 28 Aug 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NecW1Km4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304A313E1F;
	Thu, 28 Aug 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389665; cv=none; b=gQZCywYwQFE14pvGs6axxOYkAbC2uKlp1nGQ5LB0X2yJXIESU1aBLaccg8ByolVQOsxqBhBbNEB6EBm5U+Udry9RF4uVJmm4jrDymRXxF4jBhRfCICArJDXv8mt+dfaQHbK1ygPvKASD8zNOKGxmGDdJRuFQxVAE0THhR5Alam8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389665; c=relaxed/simple;
	bh=qqr07bOWFXFo1de483KKM0R6r/8XR8QBS/GymmOJMEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8/tbARssS+DdReLIJQEVldCnPtUrOGnzYuAPhBlLl0r3A/dpWVm7jAN129I3Hy0Wu6FIQ2A/WaGz05frpeLmBDtaj3qptXa4AdbXuYpeYm82Hkm49srE1/sOdwioeIf233jfJbZKalBxmN3eYucbXDN4zs1kuH3jOBRcCWfTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NecW1Km4; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CM
	hpxNJlxWk8k4Tu3vBM/b3KUER7t/n0NRgjW9FcPXU=; b=NecW1Km41cshUxLKXe
	WctpXqSxBrDDPToFwmljLKR5xsGsWxKA0HIcFuL8lJxBb6BQPWR9iyKl2LFNldf+
	poWXcwGU4+aesdcmG27AJOJraplUCpFP65sH/ef4dZ8Fp/U4JaAp1pdnrvfAlTzU
	AuvTSv5KJIwPmWnI/RGuIF7Vs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXBtYDYbBoN0ahAw--.5480S3;
	Thu, 28 Aug 2025 22:00:37 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 01/13] PCI: dwc: Add dw_pcie_*_dword() for register bit manipulation
Date: Thu, 28 Aug 2025 21:59:39 +0800
Message-Id: <20250828135951.758100-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
References: <20250828135951.758100-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXBtYDYbBoN0ahAw--.5480S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr18uF1DGw1DGw4rGrWkXrb_yoW8ZFyUpa
	yUtrW3CF47Aa1a9anxAan3ZryYy3Z3AF43CrZxG3W2qF17Aryqqa4rtFy5trn7GrWIqr17
	Kr4Dt3yxWan8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pK9av_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh23o2iwWw2TngAAsw

DesignWare PCIe controller drivers implement register bit manipulation
through explicit read-modify-write sequences. These patterns appear
repeatedly across multiple drivers with minor variations, creating
code duplication and maintenance overhead.

Implement dw_pcie_*_dword() helper to encapsulate atomic register
modification. The function reads the current register value, clears
specified bits, sets new bits, and writes back the result in a single
operation. This abstraction hides bitwise manipulation details
while ensuring consistent behavior across all usage sites.

Centralizing this logic reduces future maintenance effort when modifying
register access patterns and minimizes the risk of implementation
divergence between drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..ae18b657938a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -702,6 +702,29 @@ static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
 	dw_pcie_ep_write_dbi2(ep, func_no, reg, 0x4, val);
 }
 
+static inline void dw_pcie_clear_and_set_dword(struct dw_pcie *pci, int pos,
+					       u32 clear, u32 set)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, pos);
+	val &= ~clear;
+	val |= set;
+	dw_pcie_writel_dbi(pci, pos, val);
+}
+
+static inline void dw_pcie_clear_dword(struct dw_pcie *pci, int pos,
+				       u32 clear)
+{
+	dw_pcie_clear_and_set_dword(pci, pos, clear, 0);
+}
+
+static inline void dw_pcie_set_dword(struct dw_pcie *pci, int pos,
+				     u32 set)
+{
+	dw_pcie_clear_and_set_dword(pci, pos, 0, set);
+}
+
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
 {
 	u32 reg;
-- 
2.49.0


