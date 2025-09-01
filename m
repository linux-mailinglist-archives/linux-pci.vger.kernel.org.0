Return-Path: <linux-pci+bounces-35232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7371B3D95E
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CFA3BE0AA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 06:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89180267387;
	Mon,  1 Sep 2025 05:59:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358D26560D;
	Mon,  1 Sep 2025 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706381; cv=none; b=V9s4y4d2Qw2fgJFTAssi0Ty2jfyVOcx4zWVVGnHY5To1Gx9nqqS9PfhRy9xBZdEDQ1CKTU5X9eCdbzCbbaTcF8UdFv3vcGTO8TbUYjD6vSEtD1FXh3ER0Q9VnVPbTS2rzPpleVvacoBnGm1NVOFpBp6NUY0i2y07YJikH/3+P4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706381; c=relaxed/simple;
	bh=IH5XW073DI4C8Fo3XpjfYJDP0x6AgX6FrVwhZ5Ommus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bd3pxRL/vVGFVKH8Z1ydaO1Zyv4CFJpc3VzbLXDxKCtGbh80wpRs+pGHQB7+c7CvTK2ZJpyWxPtHI3xdP5rWqfr3wo2+ZOvsfo1wkZb1wXw7UTPc9fQ1dtuLPlh278Sop/sRBLzQahEtAVP7jcqaCSuCx6EnvVLW6WBhsQS2dBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 13:59:23 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 13:59:23 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v3 08/10] PCI: Add FMT and TYPE definition for TLP header
Date: Mon, 1 Sep 2025 13:59:20 +0800
Message-ID: <20250901055922.1553550-9-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

According to PCIe specification, add FMT and TYPE definition
for TLP header.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/pci/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..45d47d6c4f53 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -81,6 +81,18 @@ struct pcie_tlp_log;
 #define PCIE_MSG_CODE_DEASSERT_INTC	0x26
 #define PCIE_MSG_CODE_DEASSERT_INTD	0x27
 
+/* Format of TLP; PCIe r5.0, sec 2.2.1 */
+#define PCIE_TLP_FMT_3DW_NO_DATA	0x00 /* 3DW header, no data */
+#define PCIE_TLP_FMT_4DW_NO_DATA	0x01 /* 4DW header, no data */
+#define PCIE_TLP_FMT_3DW_DATA		0x02 /* 3DW header, with data */
+#define PCIE_TLP_FMT_4DW_DATA		0x03 /* 4DW header, with data */
+
+/* Type of TLP; PCIe r5.0, sec 2.2.1 */
+#define PCIE_TLP_TYPE_CFG0_RD		0x04 /* Config Type 0 Read Request */
+#define PCIE_TLP_TYPE_CFG0_WR		0x04 /* Config Type 0 Write Request */
+#define PCIE_TLP_TYPE_CFG1_RD		0x05 /* Config Type 1 Read Request */
+#define PCIE_TLP_TYPE_CFG1_WR		0x05 /* Config Type 1 Write Request */
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.43.0


