Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F6F73F1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 13:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKKMcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 07:32:47 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:18268 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726847AbfKKMcq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 07:32:46 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xABCSTYv014927;
        Mon, 11 Nov 2019 04:32:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=AUb1EgBNSdM4nv3tLdJUts/i5VUltTmA5qzuKz56n+Q=;
 b=rzK6DsotUaVbcUgbcVqpdzOGRzF0cA3VkGvY//JwThCeaE4CiKAYqRPHeNvvHpa4WQu+
 XDCRvYX+33pqDpfFe17HDY5dzo0MBrcbz0xX5WJkC5y3yqt6BTDKJgcGua78Q3tmtaTH
 e4kAceHs/RKC/51PBFg4cK8P/RSxkxIWwl9bI+WrdyAnkzBZszye6B3uY4JOnfPK4YIj
 XVo0p4U7VHcHkDAvtphfEGyR5izioDBbhoO2ZUQCPE/dXD6oHwSXthK4005bYKTdomjo
 ZbB7u1rywMi9MxxbCJ0ZeaeiHkVt9Hig9/o4q2g0q18nmU+AUHar+kU4TNDVoZeUGaSP vw== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2w5swy90vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 04:32:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRiRbbaFMa/pZ29bXQLAdPJ0RgWlkyWpYafJ3UGI5d2ov/71OxekVTVqB4h1qAwStwdgHT+WtXB8+Uyd5rP7oQcISZJDRo3iYABfLymk5O305bVDh8daszPqfouO5M5iTmqkJukC5NE/vlYa1PcRXb3MjkEDPmD+ro6MZHjBKFXIfDvv51eVQVW72gCd254RBv300ugp+syRTqK4FLOquUzA5ysb5cB7ZCEPMDkAtmKDK9b10IuaefHzSUyNi7N6udxGrGtP9k7J8MqYaQKn/JE7mjRvqVCxn+BOTK9wvNicxpkJf9GYWbkO3xotjjXojIMxwXCU9q1Cj+evKBfJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUb1EgBNSdM4nv3tLdJUts/i5VUltTmA5qzuKz56n+Q=;
 b=e0riRPfZc1dkJycGZhWeIWDPwDgw5BLphNATMTobTPV4pnRL8UUVmp2FtM9XEAbn5jEel9ACcXp0tEqD6CpBf1vx9DDNqJ4ruo/Grg2ToArONCo4XRwwbu+w7BEuBFqbAsRNAFJo+mYuYstsEjyRY5zbmAoy7P5ghRwa1mvIUKfAeULXfsI5UsopT1ulN3DUqxAxThl+e6fbP4pGyr/KwFN6XHOarRB3v86Ghh7wemvO2e/t0lkJZmSX4toajbBj5BybpjX2K8Idyw3SIMyDsq7fG496xatwvVGxH8+lQirUXkdnpqT4CPBElCFp1YjeV8uLYpAtMwVDG40vz5Cbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 199.43.4.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUb1EgBNSdM4nv3tLdJUts/i5VUltTmA5qzuKz56n+Q=;
 b=MGfFl4c4AS+zYxId9nGlOJfHgQ5FkhsBLy9VI6NGLR3eTxJTfOA30YCsJYCIAWkR+hMCf4t3QOWUPBUoJcAwgHMh/4g8KgmJD3d3ABLKgMfO/BaTrBeQKje8pJU77FAzvbhyWMCYTankL3YHdXA+Muw6peWILpCdxQfdcrLvSaE=
Received: from MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33)
 by DM6PR07MB5052.namprd07.prod.outlook.com (2603:10b6:5:1d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Mon, 11 Nov
 2019 12:32:38 +0000
Received: from DM3NAM05FT062.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by MN2PR07CA0023.outlook.office365.com
 (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Mon, 11 Nov 2019 12:32:38 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT062.mail.protection.outlook.com (10.152.98.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15 via Frontend Transport; Mon, 11 Nov 2019 12:32:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xABCWYmu002266
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 Nov 2019 07:32:36 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 Nov 2019 13:32:34 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 Nov 2019 13:32:34 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id xABCWXwt022586;
        Mon, 11 Nov 2019 12:32:33 GMT
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id xABCWXxM022566;
        Mon, 11 Nov 2019 12:32:33 GMT
From:   Tom Joseph <tjoseph@cadence.com>
To:     <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v4 2/2] PCI: cadence: Move all files to per-device cadence directory
Date:   Mon, 11 Nov 2019 12:30:44 +0000
Message-ID: <1573475444-17903-3-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1573475444-17903-1-git-send-email-tjoseph@cadence.com>
References: <1573475444-17903-1-git-send-email-tjoseph@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(36092001)(26005)(126002)(70206006)(486006)(316002)(8936002)(81156014)(186003)(81166006)(70586007)(42186006)(476003)(8676002)(54906003)(16586007)(305945005)(50226002)(6916009)(36756003)(2616005)(356004)(6666004)(2351001)(86362001)(4326008)(11346002)(48376002)(2906002)(336012)(76130400001)(26826003)(426003)(446003)(107886003)(87636003)(478600001)(47776003)(50466002)(5660300002)(76176011)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5052;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75a92c61-3878-4eb4-0fba-08d766a33c7b
X-MS-TrafficTypeDiagnostic: DM6PR07MB5052:
X-Microsoft-Antispam-PRVS: <DM6PR07MB50527F1A45B2F5B538116E24A1740@DM6PR07MB5052.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:289;
X-Forefront-PRVS: 0218A015FA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwH13DEsfZ37/+V16OuuL5K8A66aBdOdCkk6uZBP5heTJXlzXF5946uWqaf+RVU+ic9fD/KcgNYlb6NRfPwBIaihKbtrgigcEDoYuWRLPaA0zztrpJdpFsi9FJSdCwBwgThGuKMe6JDXx+RarjPWKmxGIgZ3UzYJuJjixtoLrm8tEKJPTd4u9+RbWdS7q0OBVe3IJYtBTtln2Blv5AGJ0rN4fUBqAmEF7hyAsnDKig+agm0m/B9peh+0QZfZx84e2koxh3tcuWzJ5kZwllWk7pBvl+gCa5qgbus+t1+yRq9/OBSFcHIbZnvXCrMK95IPD3m6LQKVyZZrDNhDEH7EZnAZLnVWGNxhjpku+dVMw8CPWPD00jkL3qeB5u+8AnR5Bd8eIvY5tdlcZdfHvl3it7SeTRBPZEEKYiRx4oQtlDmlZkEjVv0HRDHJK0v1tRJWUe3+MBqlMVSxnwLBXoCpVg==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 12:32:37.5654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a92c61-3878-4eb4-0fba-08d766a33c7b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5052
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-11_03:2019-11-11,2019-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 suspectscore=1 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911110119
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence core library files may be used by various platform drivers.
Add a new directory "cadence" to group all the Cadence core library files
and the platforms using Cadence core library.

Signed-off-by: Tom Joseph <tjoseph@cadence.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>

---
Changes in v4: Updated commit title as adviced by Andrew Murray

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

