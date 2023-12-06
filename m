Return-Path: <linux-pci+bounces-567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A03806D1D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 12:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702AD1F2167F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B07315BE;
	Wed,  6 Dec 2023 10:59:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C910D10F1;
	Wed,  6 Dec 2023 02:59:11 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id AFA7880ED;
	Wed,  6 Dec 2023 18:58:59 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 18:58:59 +0800
Received: from ubuntu.localdomain (183.27.97.199) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 18:58:58 +0800
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Daire
 McNamara" <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>, Minda Chen
	<minda.chen@starfivetech.com>
Subject: [PATCH v12 19/21] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
Date: Wed, 6 Dec 2023 18:58:37 +0800
Message-ID: <20231206105839.25805-20-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231206105839.25805-1-minda.chen@starfivetech.com>
References: <20231206105839.25805-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag

From: Kevin Xie <kevin.xie@starfivetech.com>

Add the PCIE_RESET_CONFIG_DEVICE_WAIT_MS macro to define the minimum
waiting time between exit from a conventional reset and sending the
first configuration request to the device.

As described in PCI base specification r6.0, section 6.6.1 <Conventional
Reset>, there are two different use cases of the value:

   - "With a Downstream Port that does not support Link speeds greater
     than 5.0 GT/s, software must wait a minimum of 100 ms following exit
     from a Conventional Reset before sending a Configuration Request to
     the device immediately below that Port."

   - "With a Downstream Port that supports Link speeds greater than
     5.0 GT/s, software must wait a minimum of 100 ms after Link training
     completes before sending a Configuration Request to the device
     immediately below that Port."

Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 drivers/pci/pci.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..06f1f1eb878c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,22 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/*
+ * As described in PCI base specification r6.0, section 6.6.1 <Conventional
+ * Reset>, there are two different use cases of the value:
+ *
+ * - "With a Downstream Port that does not support Link speeds greater
+ *    than 5.0 GT/s, software must wait a minimum of 100 ms following exit
+ *    from a Conventional Reset before sending a Configuration Request to
+ *    the device immediately below that Port."
+ *
+ * - "With a Downstream Port that supports Link speeds greater than
+ *    5.0 GT/s, software must wait a minimum of 100 ms after Link training
+ *    completes before sending a Configuration Request to the device
+ *    immediately below that Port."
+ */
+#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.17.1


