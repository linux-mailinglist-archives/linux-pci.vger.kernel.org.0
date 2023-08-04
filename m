Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E8A77078B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjHDSIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjHDSI3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 14:08:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF364C27;
        Fri,  4 Aug 2023 11:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG2gdCol0fXv0tn6wr4gTaROqRhCMd6Q4z5RtalrXIt0GYd9yjxSNF8frzG+tAn9dFMHwOtVqi07VKyjAenAYL6OBVk2yDI6937AoXkOvrfSvwbthx0upkfgdF56Z8Are2CMWdhapugQg+sz78RioSvOby285bQEj15pkie4dTVJydmrdz/PnY75eVlQ4bG4ucB3NvXfFGRCSu8tV9IJ/bkBC0DZsNJmZXs8G5EAcfECXqi9FSt7E6oCQgvSXVhLryMbN1SJmCAVBJdzsyrECBl+5VWPz5gdBZTYD3f6oNwyHsc4qswB4oTeZsrT3bsp0QsYBRJNV2jM6YkVBCuaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD/znj39K7OopIjlMAM1QWmL7+eY1yePDeR4tqNfJ1s=;
 b=hBoJ5ORUSDn4jypmKxQtyrfK+L5EB71Pi4ml4sRdiZasTBVn+yVyTEXXqPJwDp1gxUs7lRopwf2WFYfZq5TcuA4mYmerKAEiKb2L9gt5JgavuXUTn2AVpUiSR+lqQpMo1qEKh5CtnHME9YBPTzP0sZOQzktvxDt5e35xmQDc74snTFV4kXVolXI7QcS6nJNQ0ClBVnbGs3Q4gDInELsaXx5bh7NMYN06kvb6PY1xX1kAw7V8a8Jp3ZF8JDFjZdMYjtrUO6ORFY4539geb6OW2ZJ1rocFZe9+yNk2vYe/dZ++AroRHMfYkLr/J7odKnHdYiPDMWfQTdOHCVZpNk+LMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD/znj39K7OopIjlMAM1QWmL7+eY1yePDeR4tqNfJ1s=;
 b=VALB3c8+iSUwknqaEbP5H1a3wGG1iMVTKIjuxWylXl2Ca8vb+jsqiVV6pB8W+qVVphUEqqWKEKN/lI/KKs2pwJPQGfcDTt7D3vRod565Qtk0T1bjUOWemcPbZdme9wF2O+8xTRLbq0OJTPXBxzgPJARWDet0vbnNk+w6BBE5WMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 18:07:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.049; Fri, 4 Aug 2023
 18:07:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     helgaas@kernel.org
Cc:     Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: [PATCH v9 1/3] PCI: Add macro PCIE_PME_TO_L2_TIMEOUT_US
Date:   Fri,  4 Aug 2023 14:06:35 -0400
Message-Id: <20230804180637.462573-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804180637.462573-1-Frank.Li@nxp.com>
References: <20230804180637.462573-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: a8088963-fb05-4277-1312-08db95159ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GIsovQA5fAdccs8fZ1FsTqNgqcloE7mPDQr7Kh3Q6v+E6gA/6mnGfccqNVEQvdmhBB/1meScdkjd4yKj27bZe4Q/Y8GqhWtR68OJHfF8pJUXutENuN6RKJmWlenT1c+eao/2xk4B9MvFNxIm7Ke9GWTYZOFl7AQa5iaDNL+jLbvRzpjc5Hp1IqyIL3paKSv0rEGRzRElbFF0ZIhMvh+0LU1JZjCPU33eUhzsIrJzm8+XWtxtrKEUnC4s8VCTtagFq6Gr+Kf3airGsy766INlyUGvWzPiK2LJeV73eROT8oohHL7iu3UAyWMUMOtEerEWQH3DKMcSUTJr9kUeOHGkjnuWplGmFHQUL56IaD/sOL/FHJNRm57DVo2uoHvUaISS6UsSyUwP2GqtT0uq0iT4KKcdFNslZ/PLd9yVEiaoqqbwNUw9mgleYNd6FrdCl7FHCG0KpUPabpd2J2n4PVj1Gh+dR2myn5a8SF01Thd2eU1svG0w+kIgt9Aw0IlMlQeEpGxKGqI6vXMHOQdYNnR0niOgGLpFYuYFu4Axh9v+3ew30N7cLNHN6d3BX+yXLUr+BMxKB9BFRSyMcIE0FIhbt7lM/OzvBm58AxWJWx/McxG41rdlKYZB7wEVzXK04D+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(1800799003)(186006)(1076003)(2616005)(26005)(6506007)(8676002)(316002)(2906002)(66556008)(5660300002)(66946007)(66476007)(4326008)(6916009)(7416002)(41300700001)(8936002)(6486002)(6512007)(6666004)(4744005)(52116002)(478600001)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mIgzLQI5ttdtju8JP9bwGS7ffCmKGV/qOnAeK9R0iirR8OxsdfgoR1Mwfk2v?=
 =?us-ascii?Q?bu6HMh1o/ItI4/V888QfYCIxzOdy2NY3E3x1mmSkmxjpt1kVJbT7HRXv0E2D?=
 =?us-ascii?Q?50oJQZPuUxkB1WmOTjsiDOILlzJuEsEEzfF6N6kE/G+n86An5qKVN1+D4GxL?=
 =?us-ascii?Q?IiJWVXodC8syd2kyrG9xH7+ckSvLMjXotUQFoxHUkKANlqLycGrEYFdJJhsS?=
 =?us-ascii?Q?8yTyffME85jBU9eXkcvaSMkLuGb5Mq9dyOt+0b1RQWUQTScrhw22PAQFFBGw?=
 =?us-ascii?Q?me5TlPC5Q1CLcFxqmJcg6RoJiqMTRN28MGjegmOdIiEVD01jYzdKV6qgLRWq?=
 =?us-ascii?Q?wAb/O1Wv12bMrwJwe3Djh/6kUw5SvptX+Zj2bQ0HFiLLfQdY/2/jc4rZSehb?=
 =?us-ascii?Q?o8OWVX4UH+DKYp4sjn/6/vBiUIGGM3I0llgxBWQdqijBrgauwboX1uBD7OCX?=
 =?us-ascii?Q?CheJ3Yn2HB1EX77PmYv+UWMWRESt5CkTRSptWrJIc9NxnCOPtEZ3bmcAOpBB?=
 =?us-ascii?Q?Wz/YFKiPJiESy8nwtDGN5ODVYUVtkxoSxreg+RBABPgP8IV6YmUQdxn9dVjM?=
 =?us-ascii?Q?cx8jHINOZOpkdfr1r4arFtnVg/p9Grx4rop0/4srNF7kFwH4b9381JIuPO8f?=
 =?us-ascii?Q?225bZ2B2h3C5x7BErodfzzOySGGGrOzv6S+PHcALhHmdGmBl98ftZT8dqOKN?=
 =?us-ascii?Q?r8WbER84K7y2Z0rPwO57lb02/K5jyTdrr7muom2q+cdnuywDc5/llfTqC93V?=
 =?us-ascii?Q?ePaeMYRhKdRq6hfXaFgS48Wcg1uk75mWgPxIIzoSJxYz0UF5s0+W4os4jPRC?=
 =?us-ascii?Q?EiTmRxTGTfTwRbtd3/iLlcCaDG/nXlxO75qpHsLlUUvEaTI0vfZvZMWmYSE+?=
 =?us-ascii?Q?8dv5hdWhwB883Y1FsLKSDJvrMDYgq3MqcrfXIOT8SRJQm30nuQV8eef/xe6m?=
 =?us-ascii?Q?7oPku9mtF0wtmZPTSGxFAKaRHNSKJvusAfnL8NU4zQ0gZJMPRe0jgshjzIF+?=
 =?us-ascii?Q?XpqFnF1QGDR9j+xHy+OnKk9HXC91FIYyoqA0WUoNHZsuu64zTzNbhe/AVs7r?=
 =?us-ascii?Q?qK0YroI35QdmKt/2U27IbCapNn2gcxwxuog5orNsbeGClXwBdExUSm/dKv9O?=
 =?us-ascii?Q?+OfzShAx25x/4yjlpnmHZN5+K2xruRmt/G0UtEj/eaZZRkcuRNFzt5P4tocC?=
 =?us-ascii?Q?fP/dIHxlFKbSNQEgosg2uCKznGL5pcS3ZR+ZExkb7sUEmCPkLBfw/ECyOLfv?=
 =?us-ascii?Q?hxS4i3WdzHKSHcncFMPXvC7a2BmvKToUFCbeBE0nRCAb6LiuAHBn5aqC7+my?=
 =?us-ascii?Q?4DYym9HctIxniSLmoa4wIOCRBiEDLBnk9srJvfGTb0uHV/luacK6kc1HmdWB?=
 =?us-ascii?Q?ef6MQ5xCtqhBeIGhEQXEvCns1QbDpWOTaDGCyceNZFf7YR8kwUOUlWfSdBIf?=
 =?us-ascii?Q?jlmuzVZqtRARj0+7r2axmM+od4dlVWpGPPk6WRRXmBvXY0dVc2LVSORsrrZP?=
 =?us-ascii?Q?9+uKQ4Qjno8zHsqH2TH0IR2xXvRqyM2CV0hS2e/a7EEKif/sXOSQjhNybaWv?=
 =?us-ascii?Q?h8eC2KKOfno9H7tx1VI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8088963-fb05-4277-1312-08db95159ba6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:07:04.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E7JEwL8Mu6G6zHW76lWFJLuXO+bpafDi0gbC/jvkcEp3jJ1SdoARyqiLYzU7mx7KunyuswRtI/ZfQ4xk0drIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduces the PCIE_PME_TO_L2_TIMEOUT_US macro to facilitate checking the
PME (Power Management Event) timeout in the PCI subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..da8156663c825 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,12 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+/*
+ * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
+ * Recommends 1ms to 10ms timeout to check L2 ready.
+ */
+#define PCIE_PME_TO_L2_TIMEOUT_US	10000
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.34.1

