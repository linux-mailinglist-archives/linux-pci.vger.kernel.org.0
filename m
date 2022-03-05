Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567554CE2BD
	for <lists+linux-pci@lfdr.de>; Sat,  5 Mar 2022 06:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiCEFNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Mar 2022 00:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiCEFNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Mar 2022 00:13:47 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2062.outbound.protection.outlook.com [40.107.101.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3571A6328;
        Fri,  4 Mar 2022 21:12:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX844+PonHnfTa4XVygu3trYQYOtWs9KjTssq4LM40JaJLczQ/s9ZvXZUUvKY9PTwZaBiq9NVYYLN63kOTsHiIl92ySpNU43rBqCqz9KeB/SwzwcQt/bGOda9+gsF2hAlz1PWzKXq9C+3M5WnF1xVqSdew7tfR8UoEOHHbW6a8cg5jKmYKcF8uVWXaPSjcAimcAs6xVQSGyVQkOnjwJmeqHHmEfOc9e8k6/rqoLpnwe/kt4Zm5hajrCNRp9FGl+fzjTqdQ/Cd8epCNKsydMTzZfGtyZn0Cx9i3JawFHUgX6CxQfUWlMm54UaDEhBSugpdAf1hEk04LvDYqSHo+/RbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc0SpTpdIrx0OGld9RoOfkU9CGjX+wp30x6rP3/Av+Q=;
 b=TR0+fKr8D4gDgJYtQkNfO9HuG34aISs7sKP+lpQTpKsJPrPaNDMq7NX3/0LKqbFWDG7gT2ziFyncjMW9Vc+MEOPKW6lwbJQAECY3bjv/sqBjHpTVa9/i39GiLowbKUD3ITU87usAJ1EjLDrt8ArFYOEM7/pSXlHK0JrNdottfjT7O+5kTGmvIw/OBftdgNp+vdpKdrJBaNVicpjlljg86AGjYWqPA6txGHO6Yq6vI5YJh5zoPOoaXlLwYPXw0cYw2CmOFbCbzIDnhN2ymFA+EGJJaFsWzkw5U1W4Ky9OvInObszMG4ADXGl8R9d43izZymym9fUz4l6HnEi9/bfJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc0SpTpdIrx0OGld9RoOfkU9CGjX+wp30x6rP3/Av+Q=;
 b=s+b+6CCe3po8CWSWAKcZhp9hkHXj2myEOJqon4oqYk4uUG8DIeCyHsjl3Jtx/DX97PflXIPiYBwNWzg7Dl1U6NTpgE4nTL4Ym9lsrG39Olh4hAHJHVwJyvrwSuwpRhcWJVno12ZRbDbWnWXxtaOw6mj07o34ccmCtXpw1IJjsto=
Received: from DM5PR13CA0032.namprd13.prod.outlook.com (2603:10b6:3:7b::18) by
 DM6PR02MB3929.namprd02.prod.outlook.com (2603:10b6:5:9f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Sat, 5 Mar 2022 05:12:53 +0000
Received: from DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::d9) by DM5PR13CA0032.outlook.office365.com
 (2603:10b6:3:7b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.7 via Frontend
 Transport; Sat, 5 Mar 2022 05:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT003.mail.protection.outlook.com (10.13.4.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Sat, 5 Mar 2022 05:12:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Mar 2022 21:11:56 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Mar 2022 21:11:56 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org
Received: from [172.19.72.93] (port=44418 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nQMhw-000GyI-NO; Fri, 04 Mar 2022 21:11:56 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 755CA60019A; Fri,  4 Mar 2022 21:11:08 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 3/4] fpga: xrt: management physical function driver
Date:   Fri, 4 Mar 2022 21:11:04 -0800
Message-ID: <20220305051105.725838-4-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305051105.725838-1-lizhi.hou@xilinx.com>
References: <20220305051105.725838-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68b07a5f-d7ee-4c56-99c4-08d9fe66cd58
X-MS-TrafficTypeDiagnostic: DM6PR02MB3929:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB392921E8D093025657A721EFA1069@DM6PR02MB3929.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECYFXmlrDL4T+ZHNf7PdAPbYqoEMwn0NQ+4aGcMTOwo7OwbcC9ymlrKlGoEydaLxqoq5iFuxVmxNUb7YjCJovLcCM7k0sBGxnd3FERD0u1ZgIFjaS+c7jqdRRq5tUstFo/txRdS1dxHaV2UdbZ33XYVi7IpAR4mQa1U1gG2W+BAFBOJc1V2Ch1xMbfghBHhSCtYiaSSDYEJv0GOimF5Ws1qDpxTE8H9J0gf0WFLjAZZesZkR8C6lV9zvZSbvNbdvM5XXeIvM/aqAcz8WTjTM+aM+vHumzz/2x3Hv1i999ZeFM4Gn/ws2kI2qjo5FGU8jz5/naEUOwn9aI+XJU4m1F8cOcI5VJ6m5xIFpFqV1aoclOPIzU3pe+GOxdYB4quKw02BJNWEPQR7JBgE7orbHwStcC0It8OnbFYO+cqeFYiKKCVegE7QIuKjdAx3ZGU6Ds0Yb89+1eC5KDE32KcEReiiOBWby79Qkw/pitE2YtiWtQkKlN03DSkFbOOKAo7PqRNGAAVQQVDBcUqkHpIP9iM/5kszqzYk2KImYp2lmlxUXwVQHTFzv9dppUf+5YqtN6OHL8H8KlZta4pWoalSKIomRPzpUHNmkJyq/zJsEuLLa9Fw1ShKoqgLComeEpZMk1qzrKTBGCAYolV0z1uhR0A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(70586007)(4326008)(8676002)(508600001)(36756003)(316002)(47076005)(36860700001)(83380400001)(70206006)(7636003)(336012)(8936002)(356005)(6666004)(6266002)(26005)(186003)(42186006)(426003)(107886003)(5660300002)(1076003)(2616005)(44832011)(110136005)(82310400004)(54906003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 05:12:53.3953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b07a5f-d7ee-4c56-99c4-08d9fe66cd58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB3929
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe device driver which attaches to management function on Alveo
devices. The first version of this driver demonstrates calling PCIe
interface to create device tree node.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/Kconfig              |  3 ++
 drivers/fpga/Makefile             |  3 ++
 drivers/fpga/xrt/Kconfig          | 24 ++++++++++++
 drivers/fpga/xrt/Makefile         |  8 ++++
 drivers/fpga/xrt/mgmt/Makefile    | 12 ++++++
 drivers/fpga/xrt/mgmt/xmgmt-drv.c | 63 +++++++++++++++++++++++++++++++
 6 files changed, 113 insertions(+)
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 991b3f361ec9..93ae387c97c5 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -243,4 +243,7 @@ config FPGA_MGR_VERSAL_FPGA
 	  configure the programmable logic(PL).
 
 	  To compile this as a module, choose M here.
+
+source "drivers/fpga/xrt/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0bff783d1b61..81ea43c40c64 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -49,3 +49,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# XRT drivers for Xilinx Alveo platforms
+obj-$(CONFIG_FPGA_XRT)		+= xrt/
diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
new file mode 100644
index 000000000000..47efc8f71cec
--- /dev/null
+++ b/drivers/fpga/xrt/Kconfig
@@ -0,0 +1,24 @@
+
+# XRT Alveo FPGA device configuration
+#
+
+config FPGA_XRT
+	tristate "XRT Alveo Drivers"
+	depends on OF
+	select OF_EMPTY_ROOT
+	select OF_OVERLAY
+	help
+	  Select this option to enable Xilinx XRT Alveo drivers. Xilinx Alveo
+	  card is PCIe device and has two PCIe functions. The first function
+	  performs board manangement and XRT management driver will be attached
+	  to it. The second function performs data movement, compute unit
+	  scheduling etc. And an XRT user driver will be attached to it.
+
+config FPGA_XRT_XMGMT
+	tristate "Xilinx Alveo Management Driver"
+	depends on FPGA_XRT
+	help
+	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
+	  This driver provides interfaces for userspace application to access
+	  Alveo FPGA device, such as: downloading FPGA bitstream, query card
+	  information, hot reset card etc.
diff --git a/drivers/fpga/xrt/Makefile b/drivers/fpga/xrt/Makefile
new file mode 100644
index 000000000000..2d251b5653bb
--- /dev/null
+++ b/drivers/fpga/xrt/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
+#
+# Authors: Lizhi.Hou@xilinx.com
+#
+
+obj-$(CONFIG_FPGA_XRT_XMGMT) += mgmt/
diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
new file mode 100644
index 000000000000..b893c7293d70
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#          Lizhi.Hou@xilinx.com
+#
+
+obj-$(CONFIG_FPGA_XRT_XMGMT) += xrt-mgmt.o
+
+xrt-mgmt-objs :=		\
+	xmgmt-drv.o
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
new file mode 100644
index 000000000000..60742a478a43
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo Management Function Driver
+ *
+ * Copyright (C) 2020-2022 Xilinx, Inc.
+ *
+ * Authors:
+ *     Cheng Zhen <maxz@xilinx.com>
+ *     Lizhi Hou <lizhih@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/of_pci.h>
+
+#define XMGMT_MODULE_NAME	"xrt-mgmt"
+
+/* PCI Device IDs */
+#define PCI_DEVICE_ID_U50	0x5020
+static const struct pci_device_id xmgmt_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
+	{ 0, }
+};
+
+static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	devm_of_pci_create_bus_endpoint(pdev);
+
+	return 0;
+}
+
+static struct pci_driver xmgmt_driver = {
+	.name = XMGMT_MODULE_NAME,
+	.id_table = xmgmt_pci_ids,
+	.probe = xmgmt_probe,
+};
+
+static int __init xmgmt_init(void)
+{
+	int res;
+
+	res = pci_register_driver(&xmgmt_driver);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static __exit void xmgmt_exit(void)
+{
+	pci_unregister_driver(&xmgmt_driver);
+}
+
+module_init(xmgmt_init);
+module_exit(xmgmt_exit);
+
+MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo management function driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

