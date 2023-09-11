Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31279C204
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 03:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjILB5G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 21:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjILB4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 21:56:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57FD18E070;
        Mon, 11 Sep 2023 18:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/a4LdsjP1nC3UfbmZV6DReBouRjOkcEt5vvkuBMETUPMf8aL6wL5jCvkXpB71aWJGx7AxVFHh09o/ziRcI6aJlryI5Q9WJPNDOM6PlRiC63Cx7BrfuoKmGql0qjakYqyOt5WiBV6q8fG47/70qXDI4RMrK8a6cxB+EQHSocvxs9yNVQ0uCeDcIkVKIJDLtrhvRhPl+rGk5qpecFC6uzwEsGsxkkUFKgHQ9TzXweSI/ArBw9r8dFuWWfD1sFURT+MdKu0LMYsIlhOr3TTnVzPU5+d601VYsdwht/lBsBBNA1vDUbXgK70cvaKh5aSfsyMYgibMo/6+DkwzaRZOBFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pawYnph2SHbrEHaYnXZY+4i/Sym/OYJTMb0F57YyL5U=;
 b=C3Q40CQkxYPAh8oELfmQnWTgWniOfR/xjAWYyID5B4YhwwBzKoenK2F/kK5RZVsqyeu/3imMxpZ+1T9HQEXy4sPlx16tgUlj3AsXcJhulnVTpzcFJMCE/fl+Lg13YQ7VWuubpQgqGm48m+y7/UpQikholygqlRa59CzGpN2SJXVlpLiFnpPK2cNBRk/qwYLrLom1oOTcwLCFWl6r6meNK+x1UdQKfsDy73DbK0+56jXCkbir+beOaVHOvsom4TD/iWW15Khcu4O+7LqyMWbNsX1N7pBN0E/7yhdylCiKdMIItsU4KYPsuUvS4v+TZZovmKh00sD4DFD7A8GDqWhSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pawYnph2SHbrEHaYnXZY+4i/Sym/OYJTMb0F57YyL5U=;
 b=MU1Ihhggx4KY7TkbpWmdLa8s/7V1QVsZhVtuTsRnZRSLsVrzDUBCFbm8rhX2PddOJ591ezWNkSJCJqF8p1IAAJ+k6A/5dRLDU0+CnDa9nqLHC3WmCzhB5nuZf9M/OSamd/fDIBKPctpN4ka+vtBYrajqsj0whoB8Egupbbydkx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8125.eurprd04.prod.outlook.com (2603:10a6:102:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 22:10:02 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:10:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     Frank.li@nxp.com, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 4/5] misc: pci_endpoint_test: Add doorbell test case
Date:   Mon, 11 Sep 2023 18:09:19 -0400
Message-Id: <20230911220920.1817033-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911220920.1817033-1-Frank.Li@nxp.com>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 36faf6f3-2e1a-4a65-fb7b-08dbb313d893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxI3Vti50fbk7fKFU2rppYOY7945uq/oB4MyyXrjgCM3czHqXP2UcNxaDkvOvhX/6LSg//7wfyqRyr1VYqAlXJfmwgFCKFMTyflLLxa4WT1a8btHqt0sw24u4gQy+Tck2a18cPirT5JBwfbjcgsrX8EAEZNGAqRNL9eJAhFq5LWa5E+f2m0JOrAOAeGiK8WC0k0A/GMX0rvnKfhZNGNFQxhHyek0Mh/7V28OR9QWxZIEzyC2yc2yGloqT5haCq12NF9lg/zzgGoMB2U+3QcbPhosd3zG99KF1LBQb22fcDKH3Wb0Tlba7kZsHaINhCiiXBqcuJWe1WUoQnq+FrmmgmQoNbXcW4c2LwGGFABAzto3h7w/cG3btAvJkRrcNFGc3/fbMTbbX3x8WvQHfkX2X9BcrExRg4zXgNIPEpHkkZr4O3l/JzlHU38aOdXfo1BJvHHGLFO4JQRZxjXIykIOCQkvMZQjUvJu0cxL1HB8L1XNl45qzzvR+zcxCqHIIBCzgeeh5PFWhYs2vi1PLnfyLUD7zjRoxKJkMkZlU1Pi2ucSMuo01VYiCbprMpNNw1UumtOYOzTCwh85nHr1Tt5e7JTZkEZe7J+2c84G+cIcU+lc0bLY3S/HvexTEXWf9wjm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6512007)(26005)(1076003)(86362001)(2906002)(6486002)(2616005)(52116002)(6506007)(6666004)(7416002)(38350700002)(478600001)(38100700002)(36756003)(5660300002)(8676002)(8936002)(66476007)(66556008)(4326008)(6916009)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxi+KdXfdghFQcabBU/ZI9LsPuWSwJWMt+PJfb3+PJsRWCETtfya6F8t73ny?=
 =?us-ascii?Q?OYJwsjvwqi6sSvkEHP9AS9DMPjXRkxT+cB4+OEoa5QqseJoeD/9k9BoF60fe?=
 =?us-ascii?Q?8auQlq6iV81ab3aFmRsBUKQxkcB5ST6J/eL9eZwYZ0MN/Qw4B42xt1gOZUII?=
 =?us-ascii?Q?k+h6dCmZJW27KThSSyLBO8vn0gV8tsvgtd6eH1gRA83nWXY9h8v5vYuJ8RKV?=
 =?us-ascii?Q?irlNXOgb3HpQqSKnU5u69s7Dli6zJuo1MimOxSAnjzb+oF6v0HFpUsvxGoUw?=
 =?us-ascii?Q?FVLWyzz5EodKnNbGAuLit2WVqMMsuBmIl/BzYlQQsh7/dalpdfgnxXGbQ1J6?=
 =?us-ascii?Q?+D/OvNBGBdyK3VpGRcmEyeaKeM/sgjmAwvcaHwkcEyrac62xxMt+SgK3wPzS?=
 =?us-ascii?Q?u8nz6BB901P1/2FSfRvPxmREf0PdP30LXuhJ2JcZjzupYzuLXPKSReJeiA3S?=
 =?us-ascii?Q?Xt9Skd3jJx0ZZ6mCTRqLCzbdQacQGfveci84Zhhmk+QhsHf0xqBk8/68Iffy?=
 =?us-ascii?Q?GOxV3fsfLIYFN4UuGmFYHGicmhBsXC+3FH0JZMz4tTntKY8IXynw6TWcqnQK?=
 =?us-ascii?Q?5uwxm/VAy3KO008KmBgSoC5aVYmGW4yu7Zw7W+9ZBoRnpVJof0r2fdddty0x?=
 =?us-ascii?Q?4niXsxa9C24x31hyiYFWZfz4RPrgwMXN2kNLjA65Ea2k9hYCTB/Q2K4fbbck?=
 =?us-ascii?Q?rde0zbaOTB5eViWKNH97I7UIW2Is86Q7WuJZzoL3o9FQ/yh3YyUOlWl7ce/6?=
 =?us-ascii?Q?k5BXVBU0v/ZElh2Py8/0raW03oRkKoauXnxFjEYgwLT3Odom2IDx+d20yFzq?=
 =?us-ascii?Q?0Kk33azcw7za+HkrPc352CXhqFtCP9z0o5dmKt1A0bUcWdeO5IwVVk8mv5aD?=
 =?us-ascii?Q?dwHQ7EmAbv82K1yJqoqCkM8y0NUBh7AbXIf3SK2ZpJyGZ/8EXMAfbID7YEmm?=
 =?us-ascii?Q?v6Lh3vB4yZ3hLLIG+NBV8U3PjDeYPr28TJZ+8RPendFvLaz7Lq8bLIV7t1f1?=
 =?us-ascii?Q?KTRLavLNubNt7HQgOcpg+iRC6GfNg2QnNelTkdoAaHfLvv5Y+4IWUy5LpWKS?=
 =?us-ascii?Q?2JqQRu6ZZXtNY3i95fqhDxyt+sbfKUUccHtgsfN4u55okSGSw/GsYJr14aoz?=
 =?us-ascii?Q?TNie/tV4dwLtiP7yNuU/7oJls1XR01PrwIP5XgQsNDwWZopb1demvJfJftCe?=
 =?us-ascii?Q?8qNLjSdhJcoexlJ69cky0CipgA1VUsPbMN2LrWrh3RQZP7A17TQsIqv2B2Ax?=
 =?us-ascii?Q?Tu9VpYZPb9gKyD7NDYzod6uPmGrEWrMDNGvG1HqrIVdndIVlnTuLxbY42x1G?=
 =?us-ascii?Q?0jP/lA6PRJx8V7oWg4FPtR5yKpxLkmUE4RqByIsBq5XV0d0i5+1km8b42XN9?=
 =?us-ascii?Q?vfaxHBnnLLwFz2hmmpgz56UXplYn6PBsoADa1PFVX5KYRdbwqNjgb1Wn1HS8?=
 =?us-ascii?Q?xWs/+V5zr56Uf2i/ovv9OOIkZ+6NbAhYfuTAWUPwW4cTKqo64m3im3uq954k?=
 =?us-ascii?Q?a4GisI28ZbkZdRS6vqBLAi/7lhb6mKlXHmncH6RfnZFWWLbWRi37fu0DrGg0?=
 =?us-ascii?Q?Mx9I1nQCkomxIqCbk5h0kLkA0RXBzG4jgV/7ohQ7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36faf6f3-2e1a-4a65-fb7b-08dbb313d893
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:10:02.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETRiofgDtryzdrvW6eIJke6pBJScHa6INpxOByGPhOMiUKpRC9/QAdALBSgXNli1jaGcJEY7PFooNXUM/LYo+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8125
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using bit 0..7 of magic as version number in pci_endpoint_test struct to
support older driver versions. Save to 'version' field of struct
pci_endpoint_test to prevent reading non-existent address.

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
PCIE_ENDPOINT_TEST_DB_DATA.

Write data from PCI_ENDPOINT_TEST_DB_DATA to address from
PCI_ENDPOINT_TEST_DB_ADDR to trigger doorbell and wait for endpoint
feedback.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/misc/pci_endpoint_test.c | 48 ++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index ed4d0ef5e5c31..ed0b025132d17 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -33,6 +33,8 @@
 #define IRQ_TYPE_MSIX				2
 
 #define PCI_ENDPOINT_TEST_MAGIC			0x0
+#define PCI_MAGIC_VERSION_MASK			GENMASK(7, 0)
+#define PCI_ENDPOINT_TEST_V1			0x1
 
 #define PCI_ENDPOINT_TEST_COMMAND		0x4
 #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
@@ -52,6 +54,7 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -66,7 +69,12 @@
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
@@ -102,6 +110,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -118,6 +127,7 @@ struct pci_endpoint_test {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
 	const char *name;
+	u8 version;
 };
 
 struct pci_endpoint_test_data {
@@ -713,6 +723,38 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (test->version < PCI_ENDPOINT_TEST_V1)
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
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+	pci_endpoint_test_bar_writel(test, bar, addr, data);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_SUCCESS)
+		return true;
+
+	return false;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -760,6 +802,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
@@ -887,6 +932,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	misc_device->parent = &pdev->dev;
 	misc_device->fops = &pci_endpoint_test_fops;
 
+	test->version = FIELD_GET(PCI_MAGIC_VERSION_MASK,
+				  pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_MAGIC));
+
 	err = misc_register(misc_device);
 	if (err) {
 		dev_err(dev, "Failed to register device\n");
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index f9c1af8d141b4..479ca1aa3ae0b 100644
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

