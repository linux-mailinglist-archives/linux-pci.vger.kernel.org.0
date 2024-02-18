Return-Path: <linux-pci+bounces-3682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B413B85966A
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438FD1F21453
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D984EB24;
	Sun, 18 Feb 2024 10:51:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BF28DBD;
	Sun, 18 Feb 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253507; cv=fail; b=glC2h3T7k4ZHeL4J7cb6YxmPDJd/IGRBl6JNjDe87jvm7o4EIGfwykVJTzysVuj2WWSyA4lKJNV1bDPwU/ns0xqy+Jtb0iwd+TZbfOXe2tQdQ0PMldXa3hDAM2DQ4Ieuzq8UBIfKtBjjqoCLdUnyyC9ocHrQiDuekiVJFnSDUek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253507; c=relaxed/simple;
	bh=Zr4mWUFXYvtyxcrmFpVmK+dYKLWMemI9hE1iMc5NAH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hU1MVrKZin31bdSGOAJUzqlKrqUB7j0KtmjpByyKSCEMxdLPyX4PujQT2hDZusFNnC4EPfOsxRlHmLIQPG2kv6mERVGFDAVZ3+4FDsogB1eT2RQPqk3t032/K2+ioNt0adY8n+GnSu7mzIq5/0fhcYCYhIl6/0bJASUu8NnJ6e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We/Y+QJQTDh9CbO5ncvAtjn0IIAH2n8YdaNiy42rVl4ybBHrQ0noBVxCCdQfgpoyQuKuVBJ+RS/gNbKedqZQcfkxMjDUC0uur/EljoGjBj/9QhiCo1ql3OrwFv2V3VnAqVboqsRiN95hm/vm8nPnFSscRXBvjHDjSovsilOX5276OR+WYtrM2Pz1QWmugPCuSAc5A1C1YiHPEvmUe/D/Tm77AM7bzkHVzguO2vMCbZGQfx5tq1c9ViMCTaRD5GrnzF9a3cwLVDC3FhZQP2CzpD+Gs8Dj7ivlrpawo5UKcS7kRl1mw1MOwUXe0zbpU4XmNEd1NhhRWw3/rCgaeeblDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTje0ALVDFVTLXaFJ/d5aQDDyaSpWhyjgAzo6CfB/Hs=;
 b=Q6aDJQauFIDmFmADYsMV/BgaV9absCiUWx9R/b0PgMBpjVnk3cRH5r0ZGHtmvRhKSZUA5WqdO9Y2+9avT7sOdgfUMfZRVbcI9Elfeqz8GZQB8rnIATFdDduWeWjovGgvL3ZNUg0I3WBatRmKy/e1i2f+GYRg+Idm5TTDsLXA7jNFL0vmF7Nn0bF0+7Zve7uzuarHXQ1Ttr1uGH8FZP2x2wm2MARyZk8uH1DbLZa+h6k5cf/5fNvIy3H9sHrV5Zi1Ei0ZY25Wp+0PTR4hhMO5AkSCAuzq4d6aBYdBxQFzzpzh9zmIFFqG29Bk1NeYh25niDO3QrRTKnaiY2/uRvNi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:42 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:42 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v15 06/23] PCI: microchip: Move PCIe host data structures to plda-pcie.h
Date: Sun, 18 Feb 2024 18:17:25 +0800
Message-Id: <20240218101732.113397-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101732.113397-1-minda.chen@starfivetech.com>
References: <20240218101732.113397-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::31) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4c0f1d-1b26-441b-c084-08dc306ad799
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OoEyl+j4j6o96xYgljpcozLdrzCCDdbBXClAlyUeVlGdhUreJkRsu620Ja8KhcSVFCgl5Xsu53m+SV5xXpGydj/o5hmu50uzLS6ixLR0Z+fwqRsUC+9auroa7W/cJs/8/dTOKgHA9o07WcNGg5V2kpyFvtH1n6BvMXb72NsqyB1cfZ2rlPgKW2ffVQnJQT9w8U63QCe4dLNI8BvRkCZoGrEGeGQFsOEoomkJ2X/tS74exAMOCMCQLSYwBmgWxnFoQBqfSRIHvA7r39pRM3aHk7Uor2xkTGGK6mqdgjLYgbuCUHbzcFQ4DQCV6gs4JmxHbyYbJdwDbO6J7Oh7NCUxXVC4+5ewkoUIV78+dRTVtY3AE8A0xN5fPd9Ib3X4jZCfYFh2ikzE6eEDHWAaTAR1F59vr0+d8Jq9u0CrXPpZEnuaR2ydq40ZjU/eIf/ZWZpr4ax3XnRcleRd2uGRYUxqbWdc/q3EzP+LyPk2CJnQnCAlUdo8hiVbZveOF9ip9MG4ojEKvFfpo7N6p541yEXtG0prG5mpHbLZi8BrpuUJYXBdl3UcDqsyFnoc/UwGqM60
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xR9liw3jYkrolLGsqe8tumHKN4adOLKqQhM/ERSl+QbR4deU6rBf001eMayG?=
 =?us-ascii?Q?O8aH1A3S3joakOv+88bzawos4NFbamI5+iA+HPIvlwkwGlcX7HJRZW6s3C/S?=
 =?us-ascii?Q?zL6mBsnYh7Yp4X9/TBtdkWs97Nb3zpR4otDdITvCz8uObqRdRknUViF8AMD0?=
 =?us-ascii?Q?Wd+rK3sQdRP+6SO9jh9e8ftGke3oKK3cg3ig4LlJXrNwq+9JYzjmNDceiPBF?=
 =?us-ascii?Q?UJpWtHnPdBa6B2ly6JhRXs53K4WLzsIMnSxCg8JYVMxYB0xKXJJrw/4JAVEY?=
 =?us-ascii?Q?saj9sBW2fUCktW4UPgyTO5jxQ9dEmJx/9QE1gatIboDl3h1NFeG/5gng0SYF?=
 =?us-ascii?Q?MfIKgCCX6vZNJoJQdMhRvQyNZVyE87P933+lSDxUuSehnRhwi9QuIM9BvGjL?=
 =?us-ascii?Q?5KmEJfOH2bFn6feR2ok9eU7rIHDbeVs+yu4070NXsOWlVhSyf/iwbB2JuagL?=
 =?us-ascii?Q?97RhsvqfdfFbewT8tcYUDr6CH3PydClUi4BfpWZkL5ds9QjgBjA1YsFpHyVp?=
 =?us-ascii?Q?qT4QfbJMcqkvaosrAy+oLCcD79KqxrzzJ4JPLfSxFvR8l6lqJreHBMqDlm9b?=
 =?us-ascii?Q?/fmTKK4wQ6MyKbwaE5+7tAy1KEn65OpAau+GFtOFIAlJbTL533Jw2fp5DHFL?=
 =?us-ascii?Q?vJiFKt8CWzaDVDXN1CS1Hyhd68S9izMP6IGsAYSW6Qe0kcu6Zoe5vNvEGeBA?=
 =?us-ascii?Q?VaU4guoEzN5btHgYHHrmYlOXi/KPmk955qOr3rn4fnO4ZIvdwsZRZ0XMIjHc?=
 =?us-ascii?Q?QfrjLItaK/Llf88Liof3odf28+v2ECLxrl9rfTL96TYol6A9D5ArHBedhhUI?=
 =?us-ascii?Q?944CG6V8WUlMYYAej79JGGFM83rTaGW2LUTfmQ8lZezTzPiT9bIxRI990i4O?=
 =?us-ascii?Q?kN4cQJieIcJCg0uVwhkqGrIbciO+jjVKX4oclpLs8Pjk9UgMhAeEwUaY6V39?=
 =?us-ascii?Q?sPCK46VBPfUnL/nxFNR04vaizba9bWOlrOKn1F0zqNy0M2oTEGgs4/yp0zAk?=
 =?us-ascii?Q?u7oW1MabCaK/bH1Yb2DTyxU7oXlTD3C5hjikzt6yALrpouk33wv17amNmyfs?=
 =?us-ascii?Q?J8FrG7JTGfD6VZ0r9wIhAK8P+JLdB6lCKC2/zs9yxbGX8vSiXj1lInKgTaNf?=
 =?us-ascii?Q?gELLlMUgF6ha2tTuCT1jV+dSwbLxxaNpGoY+LJC3hMEEyK39G9uxzZ9Qym2m?=
 =?us-ascii?Q?AY9pxuMx5GzXlg65kpCMBYo4ZYNpqexgxLTObXhC9vEL++Uwzdmo9OJPp1f9?=
 =?us-ascii?Q?2PTYctGgLOJPWbGcBoLEzINnVakVZ5jDKMYjpYpIHPeZxXhsC2Sn6O/Bz4oA?=
 =?us-ascii?Q?6ljfMznlE5kSADdPBBreI3fGqlrRzYQ01c4TCY0WHi24wqsKEEH8Ck5rKy+g?=
 =?us-ascii?Q?YXOjk8yoYUhLJQfxZ3t1I8oFrEVtSlhPzPiOwj85a65up2cTEy2I/KcTeCLl?=
 =?us-ascii?Q?BKuPYSPZR5ZYaoEMbWNRBG9h7wCsB/IbcATqpIiAQx6jtqnf+FRcCWUh6xjP?=
 =?us-ascii?Q?SKrJyVPfSFVZikIBCrEJDamBiZjYGsUW8J3CJ8dznLj+RXj+4uDGbLmgH0jL?=
 =?us-ascii?Q?kZP5h+6VeKGh8n5Gq41/CU16fwqr9UNdxHryeCzCZxAfv3m6YTUtq5rdo+b2?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4c0f1d-1b26-441b-c084-08dc306ad799
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:42.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iM8awgOHD2kzXN36DiYT8H68wUT5exmGAEP1Z2pdVjWaOYc3InMXeWwPK2tD2meiLdGc6QIOHT2U4046Nkc6mIg9wqBIinmN+SRWmFxKM74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

Move the common data structures definition to head file for these two data
structures can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 20 ------------------
 drivers/pci/controller/plda/pcie-plda.h       | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index df0736f688ce..a554a56cc0e8 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -21,9 +21,6 @@
 #include "../../pci.h"
 #include "pcie-plda.h"
 
-/* Number of MSI IRQs */
-#define PLDA_MAX_NUM_MSI_IRQS			32
-
 /* PCIe Bridge Phy and Controller Phy offsets */
 #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
 #define MC_PCIE1_CTRL_ADDR			0x0000a000u
@@ -179,23 +176,6 @@ struct event_map {
 	u32 event_bit;
 };
 
-struct plda_msi {
-	struct mutex lock;		/* Protect used bitmap */
-	struct irq_domain *msi_domain;
-	struct irq_domain *dev_domain;
-	u32 num_vectors;
-	u64 vector_phy;
-	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
-};
-
-struct plda_pcie_rp {
-	struct device *dev;
-	struct irq_domain *intx_domain;
-	struct irq_domain *event_domain;
-	raw_spinlock_t lock;
-	struct plda_msi msi;
-	void __iomem *bridge_addr;
-};
 
 struct mc_pcie {
 	struct plda_pcie_rp plda;
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 65e0f3b72184..9ca66916c609 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -6,6 +6,9 @@
 #ifndef _PCIE_PLDA_H
 #define _PCIE_PLDA_H
 
+/* Number of MSI IRQs */
+#define PLDA_MAX_NUM_MSI_IRQS			32
+
 /* PCIe Bridge Phy Regs */
 #define PCIE_PCI_IRQ_DW0			0xa8
 #define  MSIX_CAP_MASK				BIT(31)
@@ -105,4 +108,22 @@ enum plda_int_event {
 
 #define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
+struct plda_msi {
+	struct mutex lock;		/* Protect used bitmap */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	u32 num_vectors;
+	u64 vector_phy;
+	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
+};
+
+struct plda_pcie_rp {
+	struct device *dev;
+	struct irq_domain *intx_domain;
+	struct irq_domain *event_domain;
+	raw_spinlock_t lock;
+	struct plda_msi msi;
+	void __iomem *bridge_addr;
+};
+
 #endif
-- 
2.17.1


