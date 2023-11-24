Return-Path: <linux-pci+bounces-148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFB7F6A3B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093E9281590
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 01:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F74646;
	Fri, 24 Nov 2023 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31B10C7;
	Thu, 23 Nov 2023 17:45:22 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id C27C924E245;
	Fri, 24 Nov 2023 09:45:14 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Nov
 2023 09:45:14 +0800
Received: from kevin-ThinkStation-P340.starfivetech.com (113.72.144.198) by
 EXMBX172.cuchost.com (172.16.6.92) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 24 Nov 2023 09:45:13 +0800
From: Kevin Xie <kevin.xie@starfivetech.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mason.huo@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
	<minda.chen@starfivetech.com>
Subject: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time value
Date: Fri, 24 Nov 2023 09:45:08 +0800
Message-ID: <20231124014508.43358-1-kevin.xie@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
time between sending the first configuration request to the device and
exit from a conventional reset (or after link training completes).

As described in the conventional reset rules of PCI specifications,
there are two different use cases of the value:

   - With a downstream port that supports link speeds <=3D 5.0 GT/s,
     the waiting is following exit from a conventional reset.

   - With a downstream port that supports link speeds > 5.0 GT/s,
     the waiting is after link training completes.

Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 drivers/pci/pci.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..4ca8766e546e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,13 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
=20
+/*
+ * PCIe r6.0, sec 6.6.1, <Conventional Reset>
+ * Requires a minimum waiting of 100ms before sending a configuration
+ * request to the device.
+ */
+#define PCIE_CONFIG_REQUEST_WAIT_MS	100
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
=20
--=20
2.25.1


