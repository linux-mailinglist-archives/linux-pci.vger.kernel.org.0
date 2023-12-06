Return-Path: <linux-pci+bounces-580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A280744C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76CEB20F1E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D90146424;
	Wed,  6 Dec 2023 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GxP8OESl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3336DE;
	Wed,  6 Dec 2023 07:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlPWqQWuo+LHBRcodRRzt5eVEYYCNC+s5rYZ/RtrWObxbHL/5T7Z7v0MHyR1jIORRFS4S2jWToYEd59VNq9OerP08vnfz2ozh8tOAEYlH0ANcBgM2F9UsT1CHMjW9lV3SdGojnTiV4XFfxgAwAVBfoPFdqN7EPo2vH/HQmBXYLmL1I7h66O8g16hR/Xjs7ixTgmm2u6SFoDlQxJ3ZstcI5x1osDqhKDcb5qivx8t4VF2rJaHbrDRhfbn6CxvFapMOw9Yu4AeGhKKyLP8ZZVFgJ6ZdEuJolCuZ4F2Rb+wV3WRqQ35dVpnAgh/BiiFoP1LRrGVosQxAhZiWLA/TTPPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5NIuLeVp3iR5mD1f+eXr/6+AuJLS8coAopSUYMz9wo=;
 b=eL5+AZQsqsb5HdzW4L3jELTFbuqceQopU5PKHSBCNtK9NLqtyeuIuYQmS9uOXsyD3B4o1V4xau16EEKlGKn3Frw1SeCpgQyddtnZyyNvH4pS8b+MUD3xIXHVEqtkVkG808EkEJL3YY5szDVL7gaAI7UqFtp1HRhmknGCfz/JIs+uYl3Kg8icKoH6ReJqyKMGVg6IHhF4y/9eBp+0pKQSKjXhk6510UV9/MSp/eSsOBbmsG3KkzOOkf2fhl6/7D0MSOptdJMceOVSC6CoIb0qsZK8sY2c3DOILfB4mpQnE07ibFzWv9pOxTUlvjk11v6brWWtzZJdX1XoCcy9npyh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5NIuLeVp3iR5mD1f+eXr/6+AuJLS8coAopSUYMz9wo=;
 b=GxP8OESlQxcuqWGVIDCAQoAmgr3ebFmj76ycPw5JgUswxNCDVQCQWZg8pJiiAwQvl1Hk3r8uQ5rV960qVc0+WdCh2B5f+yt1F+/VHBBDp4E/LiRKYHGEtdUQk1ClF1HOigWTiYoFfLo5pXNUFAZBP2J5DliHZy+kcZWLfFnDPv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 15:59:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 15:59:43 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/9] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Wed,  6 Dec 2023 10:58:58 -0500
Message-Id: <20231206155903.566194-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206155903.566194-1-Frank.Li@nxp.com>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: c8263097-e6bd-495d-4058-08dbf6745c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jZ8A/HbTnwd8EbCK6iWq74W/5UNL78sx/AZTHXPNuNxQhLRShVgQ/jZT5TCaXOh9J2DbtGOI90U/AK433nX2m8kUVZTnq1GBt3BFW9xtncgPQ2bj/ejjgICUhU7YudYuTN0zfTvMFm5c3dqmN1DPjdW2zeMr0CxleLFziN9kMrMfeMrWnc4oA6vH6Bg2Moqk+j24Otky/dgR7yKeX5CicTSuWTb79yQqtjV1BXxt1JnOlZl63bPCNTXD7IVuYv6A8+i46UxbgAwEEZ+f3AuJB39DqDr3e0mhxR3L2YWbRxqnXYs55S4sVbCfs3PEKcu1RTcKCL0HNIfDgJz1mg44LODb2SdipziysuIU2sLP1zdrA6XzWZ5q1Vq+OPRRPzARIIn8tvTRFSNSxipjKv8Hw4ivZTEoXEtUvHwEY2quUt0i4LO9uTRc3Ig4Inm0+TupV49ozwilYJCqjx3psG/4uhn7nJVaNAgrsLNcDHnN4qOnNHjVYBNVcLxfrELk34qMff6P2H1nzoOzrgnjL2qKGgYW9sHf9omHeDyyEHCCaQ5h2GeEU5iClupS3syWODLfurUTQtKh6YiNYamyOOuJ/Td8Akkoz74GjKxJGpHnESobLXr6FUZFmUvb+6g5tvIk06SZATmM6xDNG6WDEJlT3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2TXuLTOTG0QNSJZwEe0q9y32FDDZ3SCDdnc0WerFjJCW9lD2Ka3iylMNKGm?=
 =?us-ascii?Q?++oX9smq+QlfkGiwy+GD9dyP2wBJx3YNnsPhJdm2fTApqi7tAsVv16PuSI/G?=
 =?us-ascii?Q?QSrGaLEO9R9nXkVzttC5l/h1uoItBW0TapsHssDlBN2DmzfGel1hUNKagC4y?=
 =?us-ascii?Q?mTN/usM4yUehzuytY4M9fDmesl2w9yJeHJfrGxnlAWSuUNP16QmUukpGMWpD?=
 =?us-ascii?Q?2YKRRDTV97LQPiJIGLPI1vKzn8Qw1HNQbxd6qDkwXHRTOiIqL1xgaXXFKWb8?=
 =?us-ascii?Q?NyBeudq/APoq+HgktKf/OWWXga+uFUpt2ORncuI+RX7poBmKFWJZ42JlaESU?=
 =?us-ascii?Q?rMhITCWz/PD/ukaIZntyzL1ozNFqOFVoeJlW9KajLr6XtBSMuHqor3L0Lc3C?=
 =?us-ascii?Q?V9uP0yml9Zy8vgJP9OucF/lbVb7OsUK3ilD6OvFsp/SMnW4K6FqHKQ2f6N6J?=
 =?us-ascii?Q?7TiiFllscK6yztG1f6PPyjZ6Qt8ts7KUmkK+VwCXYfkMa+ar58nec/vqtFUa?=
 =?us-ascii?Q?9gQPwoc/AmzMIUJSZcDLeHBEwVSSgy6Z+Ip54r9MiJg5P6LbbswxdAdRKBPD?=
 =?us-ascii?Q?hgFxjSShiCTlBOCwea5D9s9OKs6W4oW39JhUND2DZVoGpQBE6SdW8NDK7D4S?=
 =?us-ascii?Q?WJX1AVOt+g6TKGBHC2391Tn12Ox9VqNB10+Cz2cWjikAo1xbwN4MvDJB3np2?=
 =?us-ascii?Q?1TYnrdg6L3GC7kEoBeZNotQ6vLficxH3vH5kvGynh8qppAQR6JQuHUR9uUcH?=
 =?us-ascii?Q?pnIR8d0nh+BYE401OXDSTg6Ih8Mr7FbY6VGvTCzbr6oOAc3V+Cc944PM0TFf?=
 =?us-ascii?Q?OhnjCyk9ouF/IKmDnDwxQ7uHoctuletDbXfBbcv2Qi46GrUV4DumZi6RBhc6?=
 =?us-ascii?Q?KYDEEH4j4X8eAEl8r7pGVD99mbk6dWjC5qaVcNQEqak2Ac5A0BziE/tK+yQk?=
 =?us-ascii?Q?BlCeZWD1womjWvrXbHrLL7hofnw8bNgZmCPJwj0XiLcFDrXVbGcahkdIVUJ+?=
 =?us-ascii?Q?9qC4TuD45pE2yaAv90PZHZXffJC9oko9cmwVpsTulN5LBXAuGsNP28U1PQDz?=
 =?us-ascii?Q?QcjAkbNvFodGXePoZ0lJSUGgBVQVjCcSUd8xbMSeTYi5nXt1SwHrS/lZNzz9?=
 =?us-ascii?Q?WuFVGZikpq2QqUN+VhI7HNhw7MiK3vKGffB+O0hvZZ8T65SN1viLepzG6I6x?=
 =?us-ascii?Q?2csQeRK+G0kuMsm8d+Xo2dBCwerpPjetArh8z1nrN/JOXA7lO86/RLoII95e?=
 =?us-ascii?Q?BWSzrKUwO9c5vujeAY7nN7Zkglc49Z8ZoScM1iEFVGNB9/bEfWOfRKf2a4Fm?=
 =?us-ascii?Q?RKMiFTCWRL8ajvr3ld7zkb0mVqJZIvg27xNJtTpiHqKlM9+6O4+rkV6KP71b?=
 =?us-ascii?Q?wWl8B0d7yqKMM70VlnDs4d+gc9b8OIyIf18U2dhpqUjZCS75sys3C/5Ey12g?=
 =?us-ascii?Q?G+tstm4B0+1mJ3995A+KsVqS9xmuZTldAzA58nFT61sCm5orXqJPftEwY0RH?=
 =?us-ascii?Q?EdUFB67JmB8BG33l5/1GOvRnFOTuwMxoyx9+pkQ3CSD9kBLSDmsI9Ma2ORzm?=
 =?us-ascii?Q?XKc6oy5VEw1GrA/3Hbg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8263097-e6bd-495d-4058-08dbf6745c43
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:59:43.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG0S614hd29oi2NxI8Rmrd3ckCnTiHdKhirUMEG+qr/6RXAT6+2Dncn0lh9y1bP3yOkhfhfSdE8sCqmNGf9Bsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

Avoid use get slot id by compared with register physical address. If there
are more than 2 slots, compared logic will become complex.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 62d77fabd82a..239ef439ba70 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -33,6 +33,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -1333,6 +1334,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "Failed to get PCIEPHY reset control\n");
 	}
 
+	/* Using linux,pci-domain as PCI slot id */
+	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
+	if (imx6_pcie->controller_id)
+		imx6_pcie->controller_id = 0;
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-- 
2.34.1


