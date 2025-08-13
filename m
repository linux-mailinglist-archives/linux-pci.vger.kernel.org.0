Return-Path: <linux-pci+bounces-33912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6AB23FC5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A5D627AB3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432226C3AE;
	Wed, 13 Aug 2025 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UuVKibSi"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC43F9C5;
	Wed, 13 Aug 2025 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060350; cv=none; b=lvTU65mQPPBi1RFtM6exlRKhr47A7RXHGQ1LX4HwX/V1Rf7bX0LUDs3IlMJy+DKXAH3mBOKDV8mBzIkCco5UmWWZt+OyA7g1F6vavjIJ/E7w4DvJNXbE2DcoQzx+YhwM0drvEWAZJoNH5QeatPjf8F9vCPny5MBXTdzzcyYB3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060350; c=relaxed/simple;
	bh=/htFq3C225G6SCLJc+IhPuq+tv4ZoMVqTHed97yz1JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oU1+WhgXGc1hML0sK4Nk73PX3eSgMrokUgAu2jpI6TT4r0qp1u1/GDhNBJOVaNz2Z+bvzesL1doVx9aNAlHb0H3/N3nl7D5+J5RiKosDGRfPHB56UoHiMV4a6uVCYe5lyy+69Aq/7ETX7A5zewdm4KnsRYonfcu3wB1KEMW7AE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UuVKibSi; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6e
	9Phov1O/d0G36G1Nswi7Zr0Mrnuv8K6u85JeFHT18=; b=UuVKibSiGE/pUEpwFu
	tXBOOduEMCj1rn07DLdI36Dp6PhHhYR5UfssLtZoZWZ5D1GIWke4h3EL6qbsJ1wf
	wZpJeuj0qgVR1oURmqwdKWrC9aKzq8bD38i2BArdBwL/4GoTQwAIMkkyZBd/7zo6
	VAlxLg3RGGEyz03e7aMF5HZN0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ErhtGJxo3nYVAA--.2375S3;
	Wed, 13 Aug 2025 12:45:35 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for register bit manipulation
Date: Wed, 13 Aug 2025 12:45:19 +0800
Message-Id: <20250813044531.180411-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813044531.180411-1-18255117159@163.com>
References: <20250813044531.180411-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ErhtGJxo3nYVAA--.2375S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr18uF1DGw4UGFy3KFW3Jrb_yoW8Aryrpa
	y5KrW3CF47Aa13uan8Aan3ZFyYy3ZayrW7C393G3Wa9F13ZFyqqFy8tFy5tr93GrWIqr12
	gr4UtayxWa15AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pKLvucUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh2oo2icEADVJAAAs5

DesignWare PCIe controller drivers implement register bit manipulation
through explicit read-modify-write sequences. These patterns appear
repeatedly across multiple drivers with minor variations, creating
code duplication and maintenance overhead.

Implement dw_pcie_clear_and_set_dword() helper to encapsulate atomic
register modification. The function reads the current register value,
clears specified bits, sets new bits, and writes back the result in
a single operation. This abstraction hides bitwise manipulation details
while ensuring consistent behavior across all usage sites.

Centralizing this logic reduces future maintenance effort when modifying
register access patterns and minimizes the risk of implementation
divergence between drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..08856f957ccf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -702,6 +702,17 @@ static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
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
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
 {
 	u32 reg;
-- 
2.25.1


