Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A934BE876A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 12:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfJ2Lqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 07:46:37 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:29214 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727799AbfJ2Lqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 07:46:37 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TBTOb0031762;
        Tue, 29 Oct 2019 04:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=hQVsUeFtqxsHIaYCqrB/UXL/kyIHdIT2J7vjJrMzfmI=;
 b=sPhcVJrMgewkHwX3GWiCdWdFDb86aaIcMms9kuuhk94zSBQNunGxZan8DW/wSoGxaJcP
 +Pv9JEphYydw12cj1bSZ2mqucuwS6Dy2kKMXfv82n4fFpbqXLeNnbAXuntMneb2LBoZH
 xJbKndmSLP4R0roqFw5VwZdnlBvnsxydhAPvhQZJbWHTMjcG0sdX0UeL5AjhF9v+dmOI
 3WBqko5JTdFyHjBmRLEonDthmg+ZJQzadXIpSYKnFuWjGapkQgRJN9YRkmKFDthmjJWv
 vd3ZedsAmEGTc5NgVZWByEX8BYehRJSQIkzRE3wwBqZ4ygjMik+rCJ/ogYDPlJSwm6L9 IA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vvhqx9mbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 04:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li0DSdDHxxJqAdAclI7H//if9pxurWJspzby49vGVsY15qaK4ITXZAv4kG1KtcPlcO7AqFkRtSeutUEOW+OYBVJXVJ2+MSnHqyTYiysyaVuf/qhB/IcHlOrf1pnQWxOHVDrO+V3czxfLBW+hqqlAIjG2OYUillu+dzXWy0nnIkg8GQQaOJ6d4IgQnmSgUibdnK80xzwH0YzkUFdE+iImAYiPrQPN+MxOacaml7B1azBXd0RcKa6MrXXQ18DK5dW5Yd9b7QXFmPOkBKbde57FMqdg6Krra1y/PAjViWQe3JyiE8ydFb3ZL1j0JUkESgPJuhpiiDk1vS2kqPdxxtn3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQVsUeFtqxsHIaYCqrB/UXL/kyIHdIT2J7vjJrMzfmI=;
 b=k96xnKUtHAn76O5Ij0iM3MO8FTE2PB6yCR7LmmQzmVYPAXhxUA+/kqBgy7oNQI0Vn//oIzpWdJ8LYy3NGzChUXIeJzLDIpnp1AQttOuTJfyt2fOjZSK9YHl9Dznu3nAvknOwAMlFTSzmUV4bJLgZMH2rpHgpC93rzJ7/1+sxTTWINrNy616mQ2LtC2i4Img47sQoQkMHow1k8Qk91QZkKh5d/AAYiWvOphF13NV1oFVqmInDe/Va6Hkvg0tgKXGUkHWhFwCg2y2iyygs0ceYD1JhCzSwUETAaRuh4KfT614kF3v8f11fuW7dkYpchTzak42K5djJ6j5NViqkB220dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQVsUeFtqxsHIaYCqrB/UXL/kyIHdIT2J7vjJrMzfmI=;
 b=n7Wdbb28qnd98qxqnqGt09XvR+aIIM3wn27kyupX9HQD7PgSxzL+vOxyh9Vnd1/1HnMSqwYCToZuyIincttKTiRUU7miS7Ze1SXzlQ8lkIAbuYrGx+7QU/yqt4ivUIYOZu0bp3Ckle1AJQgE8Cx+B4KUegcjjThvWlBpuC1IxZ0=
Received: from CY1PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::41) by MWHPR07MB3568.namprd07.prod.outlook.com
 (2603:10b6:301:64::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Tue, 29 Oct
 2019 11:46:27 +0000
Received: from DM3NAM05FT013.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::204) by CY1PR07CA0031.outlook.office365.com
 (2a01:111:e400:c60a::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.25 via Frontend
 Transport; Tue, 29 Oct 2019 11:46:27 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT013.mail.protection.outlook.com (10.152.98.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.9 via Frontend Transport; Tue, 29 Oct 2019 11:46:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x9TBkNP9027344
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 04:46:25 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 29 Oct 2019 12:46:21 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 29 Oct 2019 12:46:21 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x9TBkKkY008888;
        Tue, 29 Oct 2019 11:46:20 GMT
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x9TBkKib008881;
        Tue, 29 Oct 2019 11:46:20 GMT
From:   Tom Joseph <tjoseph@cadence.com>
To:     <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v3 2/2] PCI: cadence: Create new folder 'cadence' and move all cadence files to it
Date:   Tue, 29 Oct 2019 11:45:12 +0000
Message-ID: <1572349512-7776-3-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1572349512-7776-1-git-send-email-tjoseph@cadence.com>
References: <1572349512-7776-1-git-send-email-tjoseph@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(36092001)(189003)(199004)(446003)(11346002)(426003)(7636002)(5660300002)(8936002)(498600001)(76176011)(26826003)(186003)(87636003)(36756003)(50466002)(246002)(47776003)(336012)(305945005)(4326008)(51416003)(107886003)(54906003)(6666004)(26005)(6916009)(2616005)(16586007)(8676002)(2351001)(126002)(2906002)(48376002)(86362001)(76130400001)(50226002)(70206006)(70586007)(356004)(486006)(42186006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3568;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f320ea-304e-4bda-ea05-08d75c65a205
X-MS-TrafficTypeDiagnostic: MWHPR07MB3568:
X-Microsoft-Antispam-PRVS: <MWHPR07MB35685CEC55230132EDBA4E05A1610@MWHPR07MB3568.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lACyTPIR1heLHL5w9a6HGmSg3QWoq9bopLbfom/n18+DngWMg4wVy8u6tFjP0kpw7t4y8/324D4fRgH0S6HdeAUToZ+4QxvdS+0BKzG8Sxn+ZMqqtrf4PQ6SyiZWCP6+TIPFbJPcjisbun9OSlgDfgWwHVtvh86G07Rc2LSqJhX51dRfMmkZ7yYy0QOAUPKPSBJfXwd/Avk1THCYNtJcu1TVmIhvg+IAuwaIQ16rvwp53QYcj1MLyAr5XxljjwmSLm+eLJAjUpZmIhFtE1aWgFRN2y+bL52arGvzHeqQQyLH/ctKPOGEIbpaYns77gf6cqhjb06Eihz/fwxg4ZH6X6B29HK3u1noM5qJtT2cdk9XGUdxaaQrJxAVhdPi/L23t94Pnag6+tn2xP96vdaRNZVKaKpsL41WDQ7NG14tYVbWcltVz/YIzV2MerhPS6Cwc9/qC9ClxdbjRQwXkCDyWA==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 11:46:27.4852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f320ea-304e-4bda-ea05-08d75c65a205
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3568
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_03:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=928 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=1 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290118
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence core library files may be used by various platform drivers.
Add a new directory "cadence" to group all the Cadence core library files
and the platforms using Cadence core library.

Signed-off-by: Tom Joseph <tjoseph@cadence.com>
---
 drivers/pci/controller/Kconfig                     | 44 +--------------------
 drivers/pci/controller/Makefile                    |  5 +--
 drivers/pci/controller/cadence/Kconfig             | 45 ++++++++++++++++++++++
 drivers/pci/controller/cadence/Makefile            |  5 +++
 .../pci/controller/{ => cadence}/pcie-cadence-ep.c |  0
 .../controller/{ => cadence}/pcie-cadence-host.c   |  0
 .../controller/{ => cadence}/pcie-cadence-plat.c   |  0
 .../pci/controller/{ => cadence}/pcie-cadence.c    |  0
 .../pci/controller/{ => cadence}/pcie-cadence.h    |  0
 9 files changed, 52 insertions(+), 47 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/Kconfig
 create mode 100644 drivers/pci/controller/cadence/Makefile
 rename drivers/pci/controller/{ => cadence}/pcie-cadence-ep.c (100%)
 rename drivers/pci/controller/{ => cadence}/pcie-cadence-host.c (100%)
 rename drivers/pci/controller/{ => cadence}/pcie-cadence-plat.c (100%)
 rename drivers/pci/controller/{ => cadence}/pcie-cadence.c (100%)
 rename drivers/pci/controller/{ => cadence}/pcie-cadence.h (100%)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 57d52f6..2aab586 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -22,49 +22,6 @@ config PCI_AARDVARK
 	 controller is part of the South Bridge of the Marvel Armada
 	 3700 SoC.
 
-menu "Cadence PCIe controllers support"
-
-config PCIE_CADENCE
-	bool
-
-config PCIE_CADENCE_HOST
-	bool
-	depends on OF
-	select IRQ_DOMAIN
-	select PCIE_CADENCE
-
-config PCIE_CADENCE_EP
-	bool
-	depends on OF
-	depends on PCI_ENDPOINT
-	select PCIE_CADENCE
-
-config PCIE_CADENCE_PLAT
-	bool
-
-config PCIE_CADENCE_PLAT_HOST
-	bool "Cadence PCIe platform host controller"
-	depends on OF
-	select PCIE_CADENCE_HOST
-	select PCIE_CADENCE_PLAT
-	help
-	  Say Y here if you want to support the Cadence PCIe platform controller in
-	  host mode. This PCIe controller may be embedded into many different
-	  vendors SoCs.
-
-config PCIE_CADENCE_PLAT_EP
-	bool "Cadence PCIe platform endpoint controller"
-	depends on OF
-	depends on PCI_ENDPOINT
-	select PCIE_CADENCE_EP
-	select PCIE_CADENCE_PLAT
-	help
-	  Say Y here if you want to support the Cadence PCIe  platform controller in
-	  endpoint mode. This PCIe controller may be embedded into many
-	  different vendors SoCs.
-
-endmenu
-
 config PCIE_XILINX_NWL
 	bool "NWL PCIe Core"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
@@ -297,4 +254,5 @@ config VMD
 	  module will be called vmd.
 
 source "drivers/pci/controller/dwc/Kconfig"
+source "drivers/pci/controller/cadence/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 676a41e..8a59829 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
-obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
-obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
-obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
+obj-$(CONFIG_PCIE_CADENCE) += cadence/
 obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
 obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
new file mode 100644
index 0000000..b76b3cf
--- /dev/null
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Cadence PCIe controllers support"
+	depends on PCI
+
+config PCIE_CADENCE
+	bool
+
+config PCIE_CADENCE_HOST
+	bool
+	depends on OF
+	select IRQ_DOMAIN
+	select PCIE_CADENCE
+
+config PCIE_CADENCE_EP
+	bool
+	depends on OF
+	depends on PCI_ENDPOINT
+	select PCIE_CADENCE
+
+config PCIE_CADENCE_PLAT
+	bool
+
+config PCIE_CADENCE_PLAT_HOST
+	bool "Cadence PCIe platform host controller"
+	depends on OF
+	select PCIE_CADENCE_HOST
+	select PCIE_CADENCE_PLAT
+	help
+	  Say Y here if you want to support the Cadence PCIe platform controller in
+	  host mode. This PCIe controller may be embedded into many different
+	  vendors SoCs.
+
+config PCIE_CADENCE_PLAT_EP
+	bool "Cadence PCIe platform endpoint controller"
+	depends on OF
+	depends on PCI_ENDPOINT
+	select PCIE_CADENCE_EP
+	select PCIE_CADENCE_PLAT
+	help
+	  Say Y here if you want to support the Cadence PCIe  platform controller in
+	  endpoint mode. This PCIe controller may be embedded into many
+	  different vendors SoCs.
+
+endmenu
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
new file mode 100644
index 0000000..232a3f2
--- /dev/null
+++ b/drivers/pci/controller/cadence/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
+obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
+obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
similarity index 100%
rename from drivers/pci/controller/pcie-cadence-ep.c
rename to drivers/pci/controller/cadence/pcie-cadence-ep.c
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
similarity index 100%
rename from drivers/pci/controller/pcie-cadence-host.c
rename to drivers/pci/controller/cadence/pcie-cadence-host.c
diff --git a/drivers/pci/controller/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
similarity index 100%
rename from drivers/pci/controller/pcie-cadence-plat.c
rename to drivers/pci/controller/cadence/pcie-cadence-plat.c
diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
similarity index 100%
rename from drivers/pci/controller/pcie-cadence.c
rename to drivers/pci/controller/cadence/pcie-cadence.c
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
similarity index 100%
rename from drivers/pci/controller/pcie-cadence.h
rename to drivers/pci/controller/cadence/pcie-cadence.h
-- 
2.2.2

