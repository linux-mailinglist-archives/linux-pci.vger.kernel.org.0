Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4996EFBB6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 22:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbjDZUfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbjDZUfO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 16:35:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EAE2D49;
        Wed, 26 Apr 2023 13:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdH8WJTOIxTxH5fnHFcD8xvTTwN8MrGC2o4PO+Pu2quBcqPFodaUrHfWtL9EgdRacw0zUonc4gf4QMHJkowxE5iqSd5TeuYq8mkuQAqGc3SGC72rK5TPB6I8LIohF1eI1kAudoDJgKd5/YCu66kO4PRCGsgBAXZARDLzHsW2Lu69Vz3s3KGmmVgAdZobDHwGGFpkpgOwVGSPDcDuaWc6I3Rcq3Zqk0Oq+XJDF3l/WRAqxSxQKMrhsj+f1qyaAAzOrBxwi6kYfd4WpeTf4Fm6eHete5VTq2imgypFV/P7y6Lh6qlFy73ZeqxZ+hxTwubAFAdkm6W5TDMIjUgIZO2GwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHKcp4gjYuw06RQS2IYRVT6NPTbhBlaTn2UgMBi694g=;
 b=RqraUFcH88cinyRqz5h32wwTzzHSNSg2stea2IPq17WXq/kDWJjdPW71TkU4nymdilNGsPStBMNI8yx22WLABvIHr2x1ZoiEeezn76I0wEa09oPHPVfWj155a+Oe0A4Y5W3IWEbXxMkdJhgwUaroTxS2FppQ15OhAgLHqpVhbMFOIwU6KD1ziAI6eadEuIKM3RLsYovfaB5oD3Gz43Gvhdy3nqM9WdjxjTkVev3q8J6TmHSWFJndgJTSDf2FBjgxWS9/+oMbt43iL+XVLuO1ocf55dNp/yMVEv4d7dfKxHYKD6clWA3w+kYpJal1E2UAmGBZxp1X58UPuvs2t1rcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHKcp4gjYuw06RQS2IYRVT6NPTbhBlaTn2UgMBi694g=;
 b=mCI+Y/nptCDBD3eys4wJKpif2+KwhdF/Ch1S7AapeNrI0JzkeaCu3s7bMRWgARXIxaX2PLOipqZ29bBd5DfXl4DVxwsnFodSqg3Y9t7gYFRNpBKFZN7bXYe/l4gXtMYYDSKoiHv4Z2CKpFFw3rFzibc2rtluJr/sJa2/snSFejk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Wed, 26 Apr
 2023 20:35:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 20:35:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     tglx@linutronix.de
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH 2/3] misc: pci_endpoint_test: Add doorbell test case
Date:   Wed, 26 Apr 2023 16:34:35 -0400
Message-Id: <20230426203436.1277307-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426203436.1277307-1-Frank.Li@nxp.com>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f7863d-1886-4211-b475-08db4695b95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhMvvkmLDZfH5CHwTzwB0bpkWJMELY+MjSlRcBPxOHToz6O2hzlGeOKwL5JD7HFQnCKnDvSNpGje/cyd8KZKR5Jnn5+rV4SpUtEX6uMQkxWAUtqHdMSPvJvviYUEeLfebkwmO65uaVR3bRB9K0XfmFdHSmZXOFoDUK1UEFtOmjCs9guqHMn/euu4cDC3YHrbiJOh+huCKWKzS9TvxzLox0y8jk9Swh5UmXKfJsYp0JfPS3HjFRA34EgFoQkh+y5F1rE0rv+RVxZG/s7QfPVEah6At7yhW0Ie2bnNBNF2QU+OTqGbAjcRvE3pczt14zrJhDt13WftEJxdaIlabCDmVhsSAFmCzCAnb+wS6fy/qg+9Bm7mIzFOAHWA3CJ1eCafO36FuZiAY/HfD8TIKN9NPcxjqUZ2q9PLSHXEYd9WtdoJqK9HDLI8HkgSwNp+7J3hMPYrLdFHgZHclqFAKWVtHZhbsIZVCp1aEt+3rN1aYrVCuq/kNfOhuHsCPkaql5iOKq46lPCQqjceECHkFRfirbsvH0PiUuyP0D47s5vV8dBywp8zPNpCmBXGZVg5BHbLIYonaOjfu+Wy7kE/NWGMaBwib5OmnQiuNaKiyGsnbp2bkI/KxfdJ2seJ+Q8eC4V4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(38350700002)(38100700002)(26005)(1076003)(6506007)(6512007)(186003)(2616005)(7416002)(2906002)(8676002)(8936002)(5660300002)(36756003)(86362001)(6666004)(478600001)(52116002)(6486002)(66476007)(66556008)(66946007)(41300700001)(4326008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GyNNU/YRh59MPiyDJnRG9pmg3ajK3gYoh8ku8vyo/tU9gwlGrwRe+xGoqE+6?=
 =?us-ascii?Q?IV0AejuRNqRw/b75gzD7szGn23HPsDAn5l+aRWX10Ymtl9oTm3JBjUgjxG4z?=
 =?us-ascii?Q?WMIn1rd5jJNAldjnkecsiOLykQWIrIyUZoj8PV3bJx7w6/JJHVYSUeF+u6Fv?=
 =?us-ascii?Q?NEhwKGvvFhLsoqCQlT9wk128U2bFrpuC1vNi3CGqZisiSCud+bVELpjN3OSX?=
 =?us-ascii?Q?TH69cCzsqHfqO6YYdEZT2laH6mFa79Cj6ESpFVtO2Qq1blh732QUfqlSOEeI?=
 =?us-ascii?Q?yTB2lbQ/xspgR1YDjL/Pxwvf5n0wzoTGolzZjgHOBNFy3zagKeKqsZ1gaDVk?=
 =?us-ascii?Q?lMOO3Mq5KQVxEmFQf0enDEL3esCmRC8jl5rSY56+/+cKNln8+k9ugih8tH9a?=
 =?us-ascii?Q?u1C1+AmmewyOX/vVjMPYHoVa+DzhddNNe7aPxKnp7kvcvYkOnZI0fR4ekfnH?=
 =?us-ascii?Q?Nc7a5nLbN5IR8hzqFbu6QHSRmQuazrWDLHaygaH4sUNYSWXvn4vYUPE8syOT?=
 =?us-ascii?Q?OJJoFYOExFynGqp1viRFF5xKayFJ/FSi0OrtT28UYHywvM6xQ2agBcAw6y26?=
 =?us-ascii?Q?g4dzc82e5GwN+PkmJdREdWxX8qpm9FIX0BkvGcTh29qAxaL4X2Loy74it9d8?=
 =?us-ascii?Q?KfSJKZsgWqAA6armjjeCW5LCuhKU3OhVOAqgVEvTGUIM/FgBPvCOMz8Tst4d?=
 =?us-ascii?Q?k64RosNZ4cCEiiQvzXrealS7v5h57WLwxf5NjR+WRNDLfEW8GlFb8IDFXRuT?=
 =?us-ascii?Q?dPAVtosLFV7tXDWAms2qwb4geZXRTgZLw9RwqA83/1+FhNJONDm0UgSSFLQl?=
 =?us-ascii?Q?iKb+2cAWjpgkQW4uZQ8M6BXBNLQbECEhwMvtThg5NyKX2HNm9vXJYzIDo+ip?=
 =?us-ascii?Q?HWJuNAfMtbHHXsy9VGzC7dABzZBGYDDr2UgdWLbIisR6v/7oC4PK0G8ljHrn?=
 =?us-ascii?Q?LNUhh5Xk1RDIPcAD3PLbxhzIsLmyKjlyyZyMZzg+wLUpWFXlaQ9P70qMwsp+?=
 =?us-ascii?Q?i4RT4FLVRNSPdudtSn/qnRT+TgXkmf8HpvJg2qHudTt1lmKH14V5H4TAxSz+?=
 =?us-ascii?Q?AKGW08YQbaZ70GVtrUj+Lw5xrHhcGoZugxjuJlNQKF+sx6W9fmGr3D7qbF7X?=
 =?us-ascii?Q?bZKTj5kO7rK8yAg/w2Q4l5eJPj5eEzTTPRmg8OtZNZZWUtG1oXV8erevtlfP?=
 =?us-ascii?Q?6UkmtFb33/+ZBHAYBDonSLFxJwqMUGjyyb8QSWws1J2Ah/ss8ESMwFCBQPCP?=
 =?us-ascii?Q?5awNa0T7KLpex2EKw6AtKCBO4ZBjjKCHkQLN2buyhPL2rkmVivm8sJQG6vp2?=
 =?us-ascii?Q?tPVB29aDAlzp7uP0MTARHu5I+ezsnsUn14PnksM/AUfNZWnqI/bH9nogO+4J?=
 =?us-ascii?Q?I8/hl2IhjYsXsQ60QRvj4pEBhilLyfm6PUAzUZEHgNFtily34H6fFeJSk4nY?=
 =?us-ascii?Q?nPsDNedVUKvceOf37+JWelzzSyXfim9r68P6/kike19H0NhXSjgIehTohNP8?=
 =?us-ascii?Q?HBdSZHRBBfkzTHcrrDqbPDvhXWLIG1DyLH3xJluuBp9CsIGG1R5QrUoMy4PI?=
 =?us-ascii?Q?9D/ALifitwbiS7fuyVgmcYXyS2kHmQwBJJggyS49?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f7863d-1886-4211-b475-08db4695b95b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 20:35:07.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wy36NECQqfgmfmNtzQZnNstNmxK1qJr4KRYx4O8vJfRC4hBNvsSME52vT+NwIkjmHT58F8UaCRFBzgr9uvv1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reused flags as capability register in pci_endpoint_test struct to
support older driver versions. Save capability flags to 'cap' field
of struct pci_endpoint_test to prevent reading non-existent address.

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
PCIE_ENDPOINT_TEST_DB_DATA.

Write data from PCI_ENDPOINT_TEST_DB_DATA to address from
PCI_ENDPOINT_TEST_DB_ADDR to trigger doorbell and wait for remote
endpoint feedback.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/misc/pci_endpoint_test.c | 41 ++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index ed4d0ef5e5c3..3320a3334594 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -52,6 +52,7 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -66,7 +67,12 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
+#define FLAG_SUPPORT_DOORBELL			BIT(1)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
@@ -102,6 +108,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -118,6 +125,7 @@ struct pci_endpoint_test {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
 	const char *name;
+	u32 cap;
 };
 
 struct pci_endpoint_test_data {
@@ -713,6 +721,35 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	enum pci_barno bar;
+	u32 data;
+	u32 addr;
+
+	if (!(test->cap & FLAG_SUPPORT_DOORBELL))
+		return false;
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+	if (bar == NO_BAR)
+		return false;
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+	pci_endpoint_test_bar_writel(test, bar, addr, data);
+
+	wait_for_completion(&test->irq_raised);
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (data & STATUS_DOORBELL_SUCCESS)
+		return true;
+
+	return false;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -760,6 +797,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
@@ -887,6 +927,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	misc_device->parent = &pdev->dev;
 	misc_device->fops = &pci_endpoint_test_fops;
 
+	test->cap = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_FLAGS);
 	err = misc_register(misc_device);
 	if (err) {
 		dev_err(dev, "Failed to register device\n");
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index f9c1af8d141b..479ca1aa3ae0 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -20,6 +20,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
+#define PCITEST_DOORBELL	_IO('P', 0x11)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 
-- 
2.34.1

