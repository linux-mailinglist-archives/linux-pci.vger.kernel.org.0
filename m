Return-Path: <linux-pci+bounces-32113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B278AB04F65
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 05:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808C24A73C6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 03:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19C2D5C68;
	Tue, 15 Jul 2025 03:43:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49C2D5420;
	Tue, 15 Jul 2025 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551024; cv=none; b=MNHD0VnT9CBfzrvB6Fsm5Q54+k1Tjo3QuBOCT6pgE6L2fjHQ5M+Zap2ZtTjhX/vTvi6sbuPWzZ14y6KGrlvEN+gnncJvh6Sz1jMiE/xbHfPEcVGpFCyItypNR79LfTRqG+87JMJ0y31F9Ry5VfFwqAAa0tOGLDyhfeDF700Drko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551024; c=relaxed/simple;
	bh=1ELj8K0qv9rwEYVoYILkFh2eTrCj/a7OU84C6H7sm6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVMN7cOLkURFRcofYQvADSWP6KgKfAEpcrDaHk22BhT/fyOMbraqRnf1TAzFY/gUmU+7eoChmidyfyg1vE1RFy8tGtknELYnnrMXZR2J0rrTgxaH6EBShPdxEBEpKURgEsIcWq32YyohA8JNwwvOZFsxGQ3RuvrbsDG3AsZc6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 15 Jul
 2025 11:43:21 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 11:43:21 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
	<linus.walleij@linaro.org>, <p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 08/10] PCI: Add FMT and TYPE definition for TLP header
Date: Tue, 15 Jul 2025 11:43:18 +0800
Message-ID: <20250715034320.2553837-9-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

According to PCIe specification, add FMT and TYPE definition
for TLP header. And also add macro to combine FMT and TYPE to
1 byte.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 include/uapi/linux/pci_regs.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a3a3e942dedf..700b915e00f5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1230,4 +1230,36 @@
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
 
+/* Fmt[2:0] encoding for TLP Header */
+#define PCI_TLP_FMT_3DW_NO_DATA		0x0  // 3DW header, no data
+#define PCI_TLP_FMT_4DW_NO_DATA		0x1  // 4DW header, no data
+#define PCI_TLP_FMT_3DW_DATA		0x2  // 3DW header, with data
+#define PCI_TLP_FMT_4DW_DATA		0x3  // 4DW header, with data
+#define PCI_TLP_FMT_PREFIX		0x4  // Prefix header
+
+/* Type[4:0] encoding for TLP Header */
+#define PCI_TLP_TYPE_MEM_RD		0x00 // Memory Read Request
+#define PCI_TLP_TYPE_MEM_RDLK		0x01 // Memory Read Lock Request
+#define PCI_TLP_TYPE_MEM_WR		0x00 // Memory Write Request (Fmt must be with data)
+#define PCI_TLP_TYPE_IO_RD		0x02 // IO Read Request
+#define PCI_TLP_TYPE_IO_WR		0x02 // IO Write Request (Fmt must be with data)
+#define PCI_TLP_TYPE_CFG0_RD		0x04 // Config Type 0 Read Request
+#define PCI_TLP_TYPE_CFG0_WR		0x04 // Config Type 0 Write Request (Fmt must be with data)
+#define PCI_TLP_TYPE_CFG1_RD		0x05 // Config Type 1 Read Request
+#define PCI_TLP_TYPE_CFG1_WR		0x05 // Config Type 1 Write Request (Fmt must be with data)
+#define PCI_TLP_TYPE_MSG		0x10 // Message Request (see routing field)
+#define PCI_TLP_TYPE_MSGD		0x11 // Message Request with Data (see routing field)
+#define PCI_TLP_TYPE_CPL		0x0A // Completion without Data
+#define PCI_TLP_TYPE_CPLD		0x0A // Completion with Data (Fmt must be with data)
+#define PCI_TLP_TYPE_CPLLCK		0x0B // Completion Locked
+#define PCI_TLP_TYPE_CPLDLCK		0x0B // Completion with Data Locked (Fmt must be with data)
+#define PCI_TLP_TYPE_FETCH_ADD		0x0C // Fetch and Add AtomicOp Request
+#define PCI_TLP_TYPE_SWAP		0x0D // Unconditional Swap AtomicOp Request
+#define PCI_TLP_TYPE_CMP_SWAP		0x0E // Compare and Swap AtomicOp Request
+#define PCI_TLP_TYPE_LOCAL_PREFIX	0x00 // Local TLP Prefix (Fmt = 0x4)
+#define PCI_TLP_TYPE_E2E_PREFIX		0x10 // End-to-End TLP Prefix (Fmt = 0x4)
+
+/* Macro to combine Fmt and Type into the 8-bit field */
+#define PCIE_TLP_FMT_TYPE(fmt, type)   (((fmt) << 5) | ((type) & 0x1F))
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.43.0


