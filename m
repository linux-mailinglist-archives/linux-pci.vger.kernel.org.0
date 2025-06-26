Return-Path: <linux-pci+bounces-30779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D476AEA1E0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DE34A3683
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30E2EACF4;
	Thu, 26 Jun 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="II0XmZOZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E032EB5B2;
	Thu, 26 Jun 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949533; cv=none; b=Az+k2tyB+VId8ALP2+wIkMPgdaC7xRiRs++y14AmBMaHaY5VKsX3BHlEqG5CiV6atK08slMBQc11btDuyKdV7I9hwOT/tryE8Uv2YQG/7l4LSpoebECdXY4z3h21bkfzHLE7NKXurD3ohBHBHr9leOd7Uzv6AU12r70nrpB6P1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949533; c=relaxed/simple;
	bh=JvVori+RjvHe3Ol6doOrMn5EP3oQaMsrZHnK2AFmnfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2a8D6x3O3Os3ppCB9Ef54X/FzaFrmjB90d/MgGjvIY6/R33zdA+13m3NtkB/XtRnGlIpCiWb1t7JkB6Tmy7EzL59p2n1ABFXfOtKybC4hjX+RcGbX4Nx7MgZccT33g1im08yqk81Bs26KNokEnZEgUaB4brOw8MCedkP0i/x7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=II0XmZOZ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IS
	tFwGQpYrL7Cj3+R2jV60PlExYzDBLd2Wp6pOgZwFc=; b=II0XmZOZ5BHm5Swydq
	icoc698G0+rOewtpP4btJ51lTsHhRs3YOMnoO5f0RJ6pwn43RY1Fvnqc4hiNLpwW
	AVJNu0p1AhsZOCRii7HEq8hOxlABU5f9Gq2beLOOCZMRZYd+RluXdffyDSts6dil
	7lNAfnqYRJmjJ/T83r4WfeLIg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn7zyJXl1o5R7ZAg--.58392S3;
	Thu, 26 Jun 2025 22:51:54 +0800 (CST)
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
Subject: [PATCH v3 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for register bit manipulation
Date: Thu, 26 Jun 2025 22:50:28 +0800
Message-Id: <20250626145040.14180-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250626145040.14180-1-18255117159@163.com>
References: <20250626145040.14180-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7zyJXl1o5R7ZAg--.58392S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr18uF1DGw4UGFy3KFW3Jrb_yoW8Aryrpa
	y5K3y3CF47Aa13uan8Aan3ZFyYy3ZayrW7CrZxC3Wa9F13ZryqqFy8tFy5tr93GrWIqr1a
	gr4DtayxWa15AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMWlvUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhJ4o2hdWexoSgAAsR

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


