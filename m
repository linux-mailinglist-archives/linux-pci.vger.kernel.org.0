Return-Path: <linux-pci+bounces-30075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C51ADF11B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 17:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D131BC0CE1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F42EE99C;
	Wed, 18 Jun 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e5FBv7Dg"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE992EF672;
	Wed, 18 Jun 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260095; cv=none; b=gVG+jjb7zMybBhQIBajAQEOuaAZNONuM+5pyQkC+trP2Md4P2Nl2ja7t7B0B/e2a8AzbOeStcxYTgRL3kszZ2mz+eZRXjefy86MDa35wOX5Y66tzdbx2/OxKF0hfaKrqQpO3fl59fURV2uq1trWGRyVNqnWU9HmJhbLRv/Tg/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260095; c=relaxed/simple;
	bh=JvVori+RjvHe3Ol6doOrMn5EP3oQaMsrZHnK2AFmnfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWeuBaonJEPg0fJbedPge1Mc72CvY6lXtObDefZcZht1JeuenOpz4mB2T94O09d4JzTZ+LqCWHFq65gz6l/CbKbCBbPvf9Mabpwa5bSxgC3LgIMNcWmxXESBdA+uxN8X6fh0qdrwwdauHUB98xxet6GwpRPIgDJ9yWUObpIzRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e5FBv7Dg; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IS
	tFwGQpYrL7Cj3+R2jV60PlExYzDBLd2Wp6pOgZwFc=; b=e5FBv7Dg5zM6fHIXC6
	inxXU2xnKhxqRBcp2fPUgVwLYqnppL7sPPq8p0Yl4UlqkOmq1piEwQkNqOYVW3hM
	ZDbADlRmD69QJDZ6ipYWeS8s5KCeuiF6+74fedasBE0NzRGfHEjs2UFY4T3Synns
	mFsXi5SnkdWY+ADu4LdCwAh3I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHoedq2VJo3qQFAQ--.15407S3;
	Wed, 18 Jun 2025 23:21:15 +0800 (CST)
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
Subject: [PATCH v2 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for register bit manipulation
Date: Wed, 18 Jun 2025 23:21:00 +0800
Message-Id: <20250618152112.1010147-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618152112.1010147-1-18255117159@163.com>
References: <20250618152112.1010147-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHoedq2VJo3qQFAQ--.15407S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr18uF1DGw4UGFy3KFW3Jrb_yoW8Aryrpa
	y5K3y3CF47Aa13uan8Aan3ZFyYy3ZayrW7CrZxC3Wa9F13ZryqqFy8tFy5tr93GrWIqr1a
	gr4DtayxWa15AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_4EE5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxdwo2hS1CZ5SwACs-

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
index ce9e18554e42..f401c144df0f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -707,6 +707,17 @@ static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
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


