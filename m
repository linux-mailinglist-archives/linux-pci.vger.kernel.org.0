Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB54B62F8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 06:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiBOFjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 00:39:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbiBOFjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 00:39:20 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10061.outbound.protection.outlook.com [40.107.1.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD261EC6D
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 21:39:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4ODvL7OHwsD/hsRjbcF5QjFepaqKTA4RZbnnDsUQ5DcL9aMquAh1aGDWikcIYRZAbzyuUNkSLc/PYHmYrPU/XkPVwfENaSpPkNQLn1WaVeP7l14BFnZFGNrdhxNK5uqXBT08xRNL5AVXzatF22gEuRZ0zNTD4HXX1zANzGtiuZDNXTQd8zk7XpAjCTwfVlSLAmkIsWGH23LVGT9JvhWVXjPqINQxZB0g2XQJ+r3VmXdm+fbny5chd1SwWIw/d7D35fLGCPRWuBYnfktXLBCktMt7dV9DKe3QGr8VUuX+Elx49qU9RcM4HrmThRInv6hylAfhiROZWGT98aFYg+Kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8s3psJlSNwnPzoLzfkQFszGNXas8HAemFD8x+GvoHU=;
 b=hXfxZxWiOYNFJ3q9eUFXlCQR7VdIONMnfAgd/Ipxp3LeN1CGaVpKJPgWa7ff3HsAC1tqdMlNEKQpDrU/UZo670djVc4oXUQkw/Tvmfpyi73L9HRQRzcgsyW6Vv7n99EOGIyI+wemwfbUkN1UkhuhGaLTLHdVbJDMFfAqhZPiGOWeZ907IqqnfJMzI/sbVkn7nqyI9QOpT/rQcWAncCc5sls8b6nPuOVqza7igSQqNomMe6th4f72IibcKuo0T8yGZrpq2cuB2E9jydpXFS6itxnkyoRTaPbqnRvVDmfvai4nNyUJFOIVeHUWdmy4Ma5fl/pBdNTr7NiLu/YqZe1ZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8s3psJlSNwnPzoLzfkQFszGNXas8HAemFD8x+GvoHU=;
 b=CtVxHwuhKRh/jaANPlTiaJWxtIV9pDW7iMLpNQr2i8R4KLx7YMFb9s+TDIuxr5FJQ9RUKWoZNRJUvt+KOlcJGKPO60oZXWeLLQo1XZWHnPfsikjevUqMNan8chgc/yEeQazRrqsRja05NSqEAi1resaiwoIL0WKjtC0UxHiFl+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB2976.eurprd04.prod.outlook.com (2603:10a6:802:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 05:39:08 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e%6]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 05:39:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     linux-pci@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lznuaa@gmail.com,
        hongxing.zhu@nxp.com
Subject: [RFC PATCH 2/4] NTB: epf: Added more flexible memory map method
Date:   Mon, 14 Feb 2022 23:38:42 -0600
Message-Id: <20220215053844.7119-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220215053844.7119-1-Frank.Li@nxp.com>
References: <20220215053844.7119-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9489153c-9a58-4871-85a7-08d9f0457c6a
X-MS-TrafficTypeDiagnostic: VI1PR04MB2976:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB2976AD3D9936BCA062F1611888349@VI1PR04MB2976.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40vZlxYCYFX2N/0f77F8pdAqiqwlWLTLlxcTDOlwgT1aeN4pBDeY/cRyCKS3vO4zsyKgpnwgNFZBO/ja9P068vGooFcDo+KxI4TNZLAh1LJj2Vz/kmvJLRauyc2ryKhaiAdjTn1AsSXGc8+j2oWG8JhSFaHXFO8cPXKDW4ypUFkrYUaN+h0tAUF0exF7vDyACBO0jJSZRMwuVCMJsofVeeg/9VGf3eseTA5jR3odimzrH+SszD0Q++LY5HWpcotwM2PXUPtXnZ1d1pQ9tPvhIfIa2d0mLSItcEdfyjoQyIqjdeG+NPweWyvG/0TqNQIbxZYxzm04jAyLOEDogcIFr3xCsnZtuY0j33x47SUB67FVGL0z3MUeEew5U8gzTCxSpxQtUNqEpSHYLTT2n8HLSk7pajyRR/7yMHT1tSocpaa/rHY/qqyV+ELuTVlManSJYo4Ef3Y2VlVkB61RTSOyzfiUoUKDXH8sU2SAnf3sMhBbSeCpeIV1vZ//bVC0Mh0WarO6sWDnXumdgwOS+y+zo+IugOKk8xPqTKimG83tGN1STAuTT/VBfrASNaPa7NgbnNK2JTmmY+6rVXQrOQb4wgzFUwPHXiQpfgBXiBrdTolcK/36lH4q0r7jf/A6hHg1DHx4FP8TqvPWdS6x1c/w/L9X9qYXnHwlfS13UmISNMx0WuVimp4tB/BHY+hn0nfSU0NS3KXrkhQNHE4oFZvVhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(5660300002)(26005)(52116002)(38350700002)(186003)(6512007)(83380400001)(38100700002)(86362001)(36756003)(2906002)(8936002)(8676002)(508600001)(66476007)(316002)(2616005)(66556008)(66946007)(6666004)(1076003)(6486002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RHK05TZ2/CUbESqoEcy5yMoJI7N/AOGycYF5xWWOGE1RR1vdCHEYWGvwZA0m?=
 =?us-ascii?Q?xGLHlCkN5hTbx535WKbVJmTddpSY47yLwGJ3gisiDtsfrtVcA90RWiEchNvg?=
 =?us-ascii?Q?r1vJrIxTVDracRzI9exKw6zVzT4WNCtagROZKHJ/wa4sAdZGgNoFxUN+6NmY?=
 =?us-ascii?Q?39rnqozWuMnmn9VZb5X4BgY/n5NRXSgrrKmSghmQuu7wtOfP6/uUts2Yco4n?=
 =?us-ascii?Q?zTRdNjIARDfM0zsw7rffpePtNnBLdvuORgAgerh5SQJPwBqSf4brbXA/v1pa?=
 =?us-ascii?Q?PmF+8zos5JNAQBRRxasDRUkFXzovlw/x4cncTcCUe1Ogo4q5HTPEokQsMXfb?=
 =?us-ascii?Q?5jfJ52GVuAptKot9WdIHxb+LJl8UqBwp20It27TyGIV2YnKcn0dkAQ7kjIrG?=
 =?us-ascii?Q?wGFecFqfrx56s+BZFXoLmJ2O5jQ1q9Zz6aw05MIeKJDC8R9QLUfURjBGLYBU?=
 =?us-ascii?Q?RT9uP731ixMrB156SmHGo4zd525/ufQ4qavjqE+cajiDUaDaePeSy4QlYogU?=
 =?us-ascii?Q?NBv9Z/f6272mhE+PnycpHp0XzGWQafloU7bv5MeM+AxO5eRAyYcvSWK+iV7b?=
 =?us-ascii?Q?7Ge3m9l6JdSaoIwzOmzianFUvxdqU3BmFUmlRXv3Me3naTIQSP2kMPMVDVTO?=
 =?us-ascii?Q?giey/E3TJVukK8ZZH/1y+37DMTVAo1dOWj3d7+mL0yF5QvKlfHSjmgdkVsMR?=
 =?us-ascii?Q?az+u58WDn4RLF1FvVscnO9E3CCp2ov9L8yXYBCMlixS4sXz+HwtKqufBS43V?=
 =?us-ascii?Q?ZPw0T84VbUyJcmn03YcUeDZLe/lNuS9IbtdNm2NXfMv1N0RLiYphjvdTSRD5?=
 =?us-ascii?Q?7LUyJogQ8uYlgCWxgXxNtPSD/e2RNOSxoyxZ54jgnbpz1SZ5pTs5ihcaOpKB?=
 =?us-ascii?Q?BcC7EfGU+wL/kcuFZBLJSyJYl/FhPSWgPgL0JOIi+p7qoWwKznNiWYaR28X3?=
 =?us-ascii?Q?v4vB5cWrrATOhIs0YjCs4iRQ3O2SBDMdsgJ50a3wkcj7ufnl3DHKuLLel2LS?=
 =?us-ascii?Q?yLoUMWEeREIPAZJ6XtrSb7Csq8mVNlJad9gKTZFfFszsq4m1AhFlrf9guwdK?=
 =?us-ascii?Q?DZ9bH2akerIdipBETktF4iMXCZV2/PjmhzJkECSqp981pi49+rYk+9xTLIoU?=
 =?us-ascii?Q?+qRQd9pBMHlTwW5XhkL3H2BSq08u0Zkb0ofOc9zp1DgyTGesCcZvQDFSpTii?=
 =?us-ascii?Q?1FgnH0V8Ze6swGKrWkcL/1RM+OuI143+vKiJYK0r3hfnrEyCnAt5oZT7bE/2?=
 =?us-ascii?Q?JCW3Mbj1DFJtKZlZrZJLux0JgMM7uw9AWiThrOZFafCNEXt8zGvNr9pnx+BV?=
 =?us-ascii?Q?8sxy8KWTGm1ibbWIqlWzAwkEMnfjPQ5RikOjTtJiKy/pUC0kMua6U8KwaX3s?=
 =?us-ascii?Q?CYNPi53AGL9NvjAfMcvnr3i+nWf7SwpDzlgrg4JP68yh8QeBA5giiH62Cb/W?=
 =?us-ascii?Q?eeScf+72U86//D7Kjzs1yuYYKONcmCwvF4Cl2/IGdtaJ0jnjna9yag+tZo0x?=
 =?us-ascii?Q?2Zx5PCbVb181n3WI+dJUlJPLS69zJ+L3iHz4E0rF49145GTl/nCVlsMKqV08?=
 =?us-ascii?Q?dBdAkhSFk8p1yb/j99Y+M4m3T8eChDwyq8HyZMcLQs1/RyF2EszDBgrLunWJ?=
 =?us-ascii?Q?e97+hqyYmDimfb9qvppImis=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9489153c-9a58-4871-85a7-08d9f0457c6a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 05:39:08.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn9tIsbqWj0w8tXqizrm1VAKJgkcT6Q3aIOXtScq7R4vM542lqfrXILd2Ijew01rJK2JyL0tWxT5VVpwxLMLkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Supported below memory map method

bar 0: config and spad data
bar 2: door bell
bar 4: memory map windows

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 48 ++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index b019755e4e21b..3ece49cb18ffa 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -45,7 +45,6 @@
 
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
-#define NTB_EPF_MW_OFFSET	2
 
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
@@ -67,6 +66,7 @@ struct ntb_epf_dev {
 	enum pci_barno ctrl_reg_bar;
 	enum pci_barno peer_spad_reg_bar;
 	enum pci_barno db_reg_bar;
+	enum pci_barno mw_bar;
 
 	unsigned int mw_count;
 	unsigned int spad_count;
@@ -92,6 +92,8 @@ struct ntb_epf_data {
 	enum pci_barno peer_spad_reg_bar;
 	/* BAR that contains Doorbell region and Memory window '1' */
 	enum pci_barno db_reg_bar;
+	/* BAR that contains memory windows*/
+	enum pci_barno mw_bar;
 };
 
 static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
@@ -411,7 +413,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 		return -EINVAL;
 	}
 
-	bar = idx + NTB_EPF_MW_OFFSET;
+	bar = idx + ndev->mw_bar;
 
 	mw_size = pci_resource_len(ntb->pdev, bar);
 
@@ -453,7 +455,7 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 	if (idx == 0)
 		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
 
-	bar = idx + NTB_EPF_MW_OFFSET;
+	bar = idx + ndev->mw_bar;
 
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
@@ -565,6 +567,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 			    struct pci_dev *pdev)
 {
 	struct device *dev = ndev->dev;
+	size_t spad_sz, spad_off;
 	int ret;
 
 	pci_set_drvdata(pdev, ndev);
@@ -599,10 +602,16 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		goto err_dma_mask;
 	}
 
-	ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
-	if (!ndev->peer_spad_reg) {
-		ret = -EIO;
-		goto err_dma_mask;
+	if (ndev->peer_spad_reg_bar) {
+		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
+		if (!ndev->peer_spad_reg) {
+			ret = -EIO;
+			goto err_dma_mask;
+		}
+	} else {
+		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
+		spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
 	}
 
 	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
@@ -657,6 +666,7 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	enum pci_barno peer_spad_reg_bar = BAR_1;
 	enum pci_barno ctrl_reg_bar = BAR_0;
 	enum pci_barno db_reg_bar = BAR_2;
+	enum pci_barno mw_bar = BAR_2;
 	struct device *dev = &pdev->dev;
 	struct ntb_epf_data *data;
 	struct ntb_epf_dev *ndev;
@@ -671,17 +681,16 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 
 	data = (struct ntb_epf_data *)id->driver_data;
 	if (data) {
-		if (data->peer_spad_reg_bar)
-			peer_spad_reg_bar = data->peer_spad_reg_bar;
-		if (data->ctrl_reg_bar)
-			ctrl_reg_bar = data->ctrl_reg_bar;
-		if (data->db_reg_bar)
-			db_reg_bar = data->db_reg_bar;
+		peer_spad_reg_bar = data->peer_spad_reg_bar;
+		ctrl_reg_bar = data->ctrl_reg_bar;
+		db_reg_bar = data->db_reg_bar;
+		mw_bar = data->mw_bar;
 	}
 
 	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
 	ndev->ctrl_reg_bar = ctrl_reg_bar;
 	ndev->db_reg_bar = db_reg_bar;
+	ndev->mw_bar = mw_bar;
 	ndev->dev = dev;
 
 	ntb_epf_init_struct(ndev, pdev);
@@ -729,6 +738,14 @@ static const struct ntb_epf_data j721e_data = {
 	.ctrl_reg_bar = BAR_0,
 	.peer_spad_reg_bar = BAR_1,
 	.db_reg_bar = BAR_2,
+	.mw_bar = BAR_2,
+};
+
+static const struct ntb_epf_data mx8_data = {
+	.ctrl_reg_bar = BAR_0,
+	.peer_spad_reg_bar = BAR_0,
+	.db_reg_bar = BAR_2,
+	.mw_bar = BAR_4,
 };
 
 static const struct pci_device_id ntb_epf_pci_tbl[] = {
@@ -737,6 +754,11 @@ static const struct pci_device_id ntb_epf_pci_tbl[] = {
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
 		.driver_data = (kernel_ulong_t)&j721e_data,
 	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
+		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
+		.driver_data = (kernel_ulong_t)&mx8_data,
+	},
 	{ },
 };
 
-- 
2.24.0.rc1

