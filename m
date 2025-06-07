Return-Path: <linux-pci+bounces-29134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D082AD0E4B
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C23B0687
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A891B4247;
	Sat,  7 Jun 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fFsnUK2y"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656A6184F;
	Sat,  7 Jun 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311785; cv=none; b=UfUQuFuAA3iTAIHr7rY1pfDj/Zy8GZHOmty4tQWggPnjKCubRR+P8q5fHKiRRCprDQovIx+Es6NEGaoHcmwM98hvo2RBPm96Es9D02EAHiQoGfUAhNMKVmDlqqalpfIlklbFmrdv8mdfWtn1Vq6EuxUsY3EtBzuu1amiDn7xMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311785; c=relaxed/simple;
	bh=WsNR2SmiSh7BZPADmuWTrFANirlmqcGhSK4rh60bu+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOSym98w78a67q5xwuoH+MZ9lDmEiEWQPqfW/PV9D5nQ95hdhdKdyw7TDM7oF7e1GxZmfpkVT4zikE3aqnrFJB4qqrJyB9zM5aacGOte+zz6zXNg0sxDB4c6GOkuJFhgxiXV+hUQfAge4yy2DDhyfUzJmDLNhSkicnDoknN3o50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fFsnUK2y; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=X/
	WBIqYRbYLnjTD8APSSM3WfSwD1nNWWxZufGQx512k=; b=fFsnUK2yIOgJZkorYl
	GCPjegiph6oCPmTU5UMWVlXANrgBU1TaHN34xz3qqDtKJEj3NssPYqiCkDSzyBs8
	LICfhZInKRqFAZn2pct5FsUgNYSbWj+2CkRKpgktEpCQlPaagrGIyTk8nYHk/axM
	r2d7rzrFZwLsvueMcaNGdx4c0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3dpsKYURonH09Gw--.59622S3;
	Sat, 07 Jun 2025 23:55:55 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/3] PCI: Add PCIE_SPEED2LNKCTL2_TLS conversion macro
Date: Sat,  7 Jun 2025 23:55:43 +0800
Message-Id: <20250607155545.806496-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607155545.806496-1-18255117159@163.com>
References: <20250607155545.806496-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3dpsKYURonH09Gw--.59622S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry8uFy3Cr43CFyfZFWfAFb_yoW8JFWxpa
	47AF1UArW8Ww1UAr98Was2qa4rXFZ3GF4UuF47W39xXFySya4kCr12yFW3tr9rZr4jkry8
	Z3ZrKrWUCFyI9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piF_MsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwBlo2hEWUa55AABsm

Introduce PCIE_SPEED2LNKCTL2_TLS() macro to standardize the conversion
between PCIe speed enumerations and LNKCTL2_TLS register values. This
centralizes speed-to-register mapping logic, eliminating duplicated
conversion code across multiple drivers.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..b5a3ce6c239b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -419,6 +419,15 @@ void pci_bus_put(struct pci_bus *bus);
 	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
 	 PCI_SPEED_UNKNOWN)
 
+#define PCIE_SPEED2LNKCTL2_TLS(speed) \
+	((speed) == PCIE_SPEED_2_5GT ? PCI_EXP_LNKCTL2_TLS_2_5GT : \
+	 (speed) == PCIE_SPEED_5_0GT ? PCI_EXP_LNKCTL2_TLS_5_0GT : \
+	 (speed) == PCIE_SPEED_8_0GT ? PCI_EXP_LNKCTL2_TLS_8_0GT : \
+	 (speed) == PCIE_SPEED_16_0GT ? PCI_EXP_LNKCTL2_TLS_16_0GT : \
+	 (speed) == PCIE_SPEED_32_0GT ? PCI_EXP_LNKCTL2_TLS_32_0GT : \
+	 (speed) == PCIE_SPEED_64_0GT ? PCI_EXP_LNKCTL2_TLS_64_0GT : \
+	 0)
+
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
 	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
-- 
2.25.1


