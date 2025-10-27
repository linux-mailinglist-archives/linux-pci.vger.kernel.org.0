Return-Path: <linux-pci+bounces-39408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D2C0CD5C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEF3434C58E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6691E30F81B;
	Mon, 27 Oct 2025 09:58:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2330F806;
	Mon, 27 Oct 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559123; cv=none; b=g+3d8dJWJS5oz92nHYeZEGblREzRWfATKVIR2KEEDGfTJ9TnsARUOwx9r+OiHUS/kJT9uNzxuvcyUYMdXSNiPQ9/oEOq2bWDl9qAIctr8wb6FeHiXskd1ikSCcAUnnbUkXbEqQ3BV0XKiuxTj4ltyBlpWOo8+HeN3UKKBvZDTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559123; c=relaxed/simple;
	bh=9zDNU/650w70g9sIKWCMcvhucnMsWrZcfBD0B8rP2kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGvJwfTqmHLTbuqrPInjetKSTETYmjD9MD0XN0b3CLQBVzH9F8dYLY0Bj2Rm8UaCStPHE/0qtQXfUSqlRhixWrozjXAlRR6OugVX3LI7TMwFAJeNEoVrTY4IwSzkdqP94x7heGLr45ikRqQYTbRzFWSbXIRNRaXt1RBc2dzL3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 27 Oct
 2025 17:58:26 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 27 Oct 2025 17:58:26 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<p.zabel@pengutronix.de>, <linux-aspeed@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v4 7/9] PCI: Add FMT, TYPE and CPL status definition for TLP header
Date: Mon, 27 Oct 2025 17:58:23 +0800
Message-ID: <20251027095825.181161-8-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027095825.181161-1-jacky_chou@aspeedtech.com>
References: <20251027095825.181161-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

According to PCIe specification, add FMT, TYPE and CPL status
definition for TLP header.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/pci/pci.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..9e5cf35409c8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -88,6 +88,21 @@ struct pcie_tlp_log;
 #define PCI_BUS_BRIDGE_MEM_WINDOW	1
 #define PCI_BUS_BRIDGE_PREF_MEM_WINDOW	2
 
+/* Format of TLP; PCIe r7.0, sec 2.2.1 */
+#define PCIE_TLP_FMT_3DW_NO_DATA	0x00 /* 3DW header, no data */
+#define PCIE_TLP_FMT_4DW_NO_DATA	0x01 /* 4DW header, no data */
+#define PCIE_TLP_FMT_3DW_DATA		0x02 /* 3DW header, with data */
+#define PCIE_TLP_FMT_4DW_DATA		0x03 /* 4DW header, with data */
+
+/* Type of TLP; PCIe r7.0, sec 2.2.1 */
+#define PCIE_TLP_TYPE_CFG0_RD		0x04 /* Config Type 0 Read Request */
+#define PCIE_TLP_TYPE_CFG0_WR		0x04 /* Config Type 0 Write Request */
+#define PCIE_TLP_TYPE_CFG1_RD		0x05 /* Config Type 1 Read Request */
+#define PCIE_TLP_TYPE_CFG1_WR		0x05 /* Config Type 1 Write Request */
+
+/* Cpl. status of Complete; PCIe r7.0, sec 2.2.9.1 */
+#define PCIE_CPL_STS_SUCCESS		0x00 /* Successful Completion */
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.34.1


