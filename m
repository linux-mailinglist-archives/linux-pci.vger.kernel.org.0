Return-Path: <linux-pci+bounces-19109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5429FED6A
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 08:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6553A2929
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 07:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473511714A5;
	Tue, 31 Dec 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JRP8T35x"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216D29A9;
	Tue, 31 Dec 2024 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735628908; cv=none; b=Uwuh5UZogHzoI3Xr77o0LPiKFeRtIZ8r3y/KGOVGrGuUirU3jVRNXwhXr4R7T1uVQtjaSdk0HV+nzr/KX5/tceGoj8xf3E+W6JofSoNEH+GI4/yTb+zh/D/JlDBgJmQ+PtQIOSehU8Y1z1ZDMsEvFJ4ziKFCn9q5UQDOgnHDmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735628908; c=relaxed/simple;
	bh=+m4kq9RhF0sySrXt/vast6hn5HGdBdRo79zy0v80Uvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwv1RY0VIsXUsl5DWe4vobG/VljkBvufNHhRsv5AsJeLyPlEQ/ggmcBWWGI1kYm9X2jMRWyVA9Wtgxpu/l2ykhgZN6wQ78i/nBdRKOqcRuvLB8pvcD6BmqYoYru2hLh+sO36jcrrBSzx0bLnGMwQGaLaOQ3oUZ8U8sTt/vBrGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JRP8T35x; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TJEsf
	mKAZNzobHSS3eFH81hG1bSBk5WyXde/ZAzioR0=; b=JRP8T35xuhX0zIkusc1JH
	T3rgFANb4Kwv/1GENmPUbbnrqiqPWdMr5usfshIilwiIzilg0Xr6jszqcecKhuV+
	PD1mqt43VONVpLBGhRUlljfLSzg5OJvGwGEZNxDGt76F7drtCZ3XxGYplyWnpqvL
	l4Egh3oWyS46U8GzCbkhAk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXgv4RmHNnlTsQCw--.49907S2;
	Tue, 31 Dec 2024 15:06:58 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	bwawrzyn@cisco.com,
	s-vadapalli@ti.com,
	thomas.richard@bootlin.com,
	wojciech.jasko-EXT@continental-corporation.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: cadence: Add configuration space capability search API
Date: Tue, 31 Dec 2024 15:06:53 +0800
Message-Id: <20241231070653.177373-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXgv4RmHNnlTsQCw--.49907S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryDGFyxXw45uFW7XFW7CFg_yoW5tw1xpF
	ykJFyfCF1rJr43uan3A3WYvr15GF9Yk34xJa92kry5ZF17CryUGF1IkFy5tF9xCrsrWF17
	XrWDtFykCw1ftwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPgA7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxDGo2dzkT-NRwAAse

Add configuration space capability search API using struct cdns_pcie*
pointer.

Similar patches below have been merged.
commit 5b0841fa653f ("PCI: dwc: Add extended configuration space capability
search API")
commit 7a6854f6874f ("PCI: dwc: Move config space capability search API")

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence.c | 80 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  3 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 204e045aed8c..ebb4a0130145 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -8,6 +8,86 @@
 
 #include "pcie-cadence.h"
 
+/*
+ * These interfaces resemble the pci_find_*capability() interfaces, but these
+ * are for configuring host controllers, which are bridges *to* PCI devices but
+ * are not PCI devices themselves.
+ */
+static u8 __cdns_pcie_find_next_cap(struct cdns_pcie *pcie, u8 cap_ptr,
+				    u8 cap)
+{
+	u8 cap_id, next_cap_ptr;
+	u16 reg;
+
+	if (!cap_ptr)
+		return 0;
+
+	reg = cdns_pcie_readl(pcie, cap_ptr);
+	cap_id = (reg & 0x00ff);
+
+	if (cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
+	if (cap_id == cap)
+		return cap_ptr;
+
+	next_cap_ptr = (reg & 0xff00) >> 8;
+	return __cdns_pcie_find_next_cap(pcie, next_cap_ptr, cap);
+}
+
+u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = cdns_pcie_readl(pcie, PCI_CAPABILITY_LIST);
+	next_cap_ptr = (reg & 0x00ff);
+
+	return __cdns_pcie_find_next_cap(pcie, next_cap_ptr, cap);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_find_capability);
+
+static u16 cdns_pcie_find_next_ext_capability(struct cdns_pcie *pcie,
+					      u16 start, u8 cap)
+{
+	u32 header;
+	int ttl;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	/* minimum 8 bytes per capability */
+	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
+
+	if (start)
+		pos = start;
+
+	header = cdns_pcie_readl(pcie, pos);
+	/*
+	 * If we have no capabilities, this is indicated by cap ID,
+	 * cap version and next pointer all being 0.
+	 */
+	if (header == 0)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < PCI_CFG_SPACE_SIZE)
+			break;
+
+		header = cdns_pcie_readl(pcie, pos);
+	}
+
+	return 0;
+}
+
+u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
+{
+	return cdns_pcie_find_next_ext_capability(pcie, 0, cap);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_find_ext_capability);
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


