Return-Path: <linux-pci+bounces-1237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E0581A82F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D4EB22F40
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A94B5A4;
	Wed, 20 Dec 2023 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kjmqv/Ff"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29184B156;
	Wed, 20 Dec 2023 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHs7tlKqAUZMztR1JC7EA3sbSVk6NRdeJ6DNU4oD4/dP8kog/7dXQyyv6pP3R8yQlguGUS23EDW3NV21o3h5CtWzArAhpuzRXwOtuXykXlIGogGnToWhu1waHBGMlqfooFv8PxxdvTGmixnbStCBqTjtHDMl50h7023wGnH9stm4GEhCQUexkvO5ryso4z5fZ9DmvlShav57BPDQcfA40M8p7UdxojOMCTDpgK/gmZMJqOZ0txwXpS0aFTWzzIQ9+gBZQZ/PUsIQd1o80MPJ3TF9sUisI0GbUj1SUodFDjkmIVJP5K1GdxqwMENfTLxGwzk7GV/wlHXjBOc2D9TnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RVrid8a+eD+TtnotxTbO7QIeCjkzOMmpoWCT3IQ2Ho=;
 b=feE0SnyXWN+pJcahAe/KDfC+aXlM64vuFz6Krbx8w4RvjBkg+P8zwRiDcOGJSYJYQUG84rDum93jt7X6q0SboO76zMrD+97eKz8ZrNJV+yETETWyLTuTH41VQWABuU6KIWI0AqsqnGzwwa5rcz9SwEVFYeGh53L1uD6+JO+Sd7hZwrVVtIdaPt0JBXFe8HIB7Cz5qGpilwcbikL1vvg8RqfMuqm9qy6jqjxb+wBjJhO51hfYxKxqSsAd7TWnIHnQrcKFSnIX9S0wIOi3qgX7vTHsLZMC3gvneXNbXQTzW1YXvULdjo0aJy6i9x4P5JN0TRQCCZJxlcp0fU0eaVtTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RVrid8a+eD+TtnotxTbO7QIeCjkzOMmpoWCT3IQ2Ho=;
 b=kjmqv/Fff5C+oHbXLMV59iQKRAQ2PjZ55WHoREn97ZsvvE4HetWjzOOy7cZTNHkzsKUl4Kq5dG6RVccFmz9ENOWmeo8tIKjfIVHSj4GJi3f2Lz7SlTGUJCaVtvteCfrHri8YhIMjK0izd/Dp/2TONi3aOuBqTvyFeeKF6ldET9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:08 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Wed, 20 Dec 2023 16:36:04 -0500
Message-Id: <20231220213615.1561528-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4245c7-f30c-49fd-bf95-08dc01a3d111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8x/tn90TYRDNpeH/crRcJo2GSn6lpHXJuPbcQ58I5jGJcmtikp07/lDBqtJSiHzkGJyKS40/BndDNzn+xiPtADfyH60EUh3Mmi+OGfE31Sby2O2mF1v/cG0cGU4I1enwIiags3A5GI7BLP6A3HKQLpUFDC6E9yiURiPj4I02y8tPYFw/PYcWotV/R9e6QPgK/SGhkHmobSF0pZmWuzhN79tiRjnIQ6WZJ8yb/tcxwxWbSiT3KH6hUkNqbjG4LK0hLWFjkQ5htvY651xE4fCKFDuzQQdKqwL0HIl07Im5ZrnlVLjIOqTRg4fJ5/otl15565Rf/1XvBTeJJgGXBppzL89M4gip+pBNK+QGmpinRc9VkywZEoP2nlGfDe6NNlkXHOjEPOl/BlATconlQxPHFjrLpmzNDflMCrTp+e3GcfezQG4+vfJHJb6Pf/igvmI18mTiHGyCHflMre9m6K4IZLQM6w8c3eN3oc2+VE18hjEEMR05rIJ+D/scZbFSHCuAkHUq8IbbLKCbOsbmfgIrhRYjW8kF0g7jrToXkSj/8ZZ1PTzVkDibQGPvPLPFNeX5WQq+GRexKOQfcaUVmVk3Qb7y7cfWpZLC4TWNq9yLYxTknQNyEauDd2xxEJc8L6cf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g12RHZLVeMQolJpiUhVqlKxWtDyadlR26jSzYSV+O/a0jgR54y0eIWBljdGR?=
 =?us-ascii?Q?NVczG0R++eXEZpDAdVkBRedf2PhsKMhEuOIsug5ZUavYJY1hw+apvVHfgfoO?=
 =?us-ascii?Q?o17EFWXicWGvbZAeTmiN80rfg32zMiCb971CJZnWWsQx6qRFcYRuUthwE3lr?=
 =?us-ascii?Q?jLOtFKZLzjbzzCQLKDgT6q1XE+5EYPcvzqLUIKW6YAG0E66sOGwA/DlDU366?=
 =?us-ascii?Q?e3fm7p9QmnOBh0/b9OAoZRytbiv+g/0X6qB8j5iJY0XVY633Ps2MyYSYhGj8?=
 =?us-ascii?Q?Z20X5mBeiHqJXCPXJUmKHGmKz2wfndxgj4fZMw0AAWqQkV7JkgkW1efbFLS1?=
 =?us-ascii?Q?G9D/Fc1Ot2nzjJ+YMLWXI9sULo/iLM2W95PCG7DAt4KqB04pklvptoMM1H78?=
 =?us-ascii?Q?6WaALfWAdrcqYobqGrzEOtWlC1FcOtf0BIp/ex2qwJaVv6NpXg7r27FbgXHN?=
 =?us-ascii?Q?aH7ykb3uPl4JxuuxESoPTXiEjxHb98nzAC9fOSW/1c8MQuoa1ZHTPCFbPtXi?=
 =?us-ascii?Q?J952I0v2CYmq6nOdnBODaw4ikYa6fcnGmuKlzVdo1wMxtrUVDdPd7pWzDpBt?=
 =?us-ascii?Q?KEjCRYl1xMBEa0uc+fUSXjTYhib50JSgGCRR8O81Vs1NqEleIZ/DrATh5f64?=
 =?us-ascii?Q?78snGIYJhWTqBGKRFpHO0TodMcuOFTcrdC0CJOSpUEGaDHlYGVCBmIgYrI2r?=
 =?us-ascii?Q?utTfWga50lOSUrB9QrgGRpsNhi+6Jbznf8g7F5xBIKSnztcdkDRYCrTi0fOt?=
 =?us-ascii?Q?D7u/+9RpalqtZ5IWEa3x/gjcYmNnVmgrBRsQ9pJ033S2Sr12e9LugidCVCsO?=
 =?us-ascii?Q?FO+Vk9ERYF0pVkSVetNSdCU0pDTBcE9faaWCEoLtrFAUTJcI+HMIU6yUtQzC?=
 =?us-ascii?Q?/fGZQ5DEzrdy9hS5Tqhzq3r98jyiyy6prr0dijCU3X6Dpcj0vI3RAG7GOwkw?=
 =?us-ascii?Q?NBa+MmB2KeXGJz8CVSghO3zACyOO2qPyDL97i7YW/pe4DjoCafVE2ywKpbDs?=
 =?us-ascii?Q?dIDKaRZIbi0q5A4JtxrU1sr+7BIuBKSReiXa3cvFw7dusmMEI5dK2PoDzs9N?=
 =?us-ascii?Q?B0yY+NcAeGZaQZQHIbZFI3kZGl/81EITKLEHkeS8FhGqvpJZk2FzsJ1Vvy7W?=
 =?us-ascii?Q?ZfVf5ox5pbbCBQRwZYmNNYcd4bR98p77t3RbvIDF9B2AtObHanYllY7nJj1O?=
 =?us-ascii?Q?oG5CY7H4bpBwcfsaTeCBfm6v2nst03d0ZFRrGOXdvxu2hA68oWe+rEwIbITh?=
 =?us-ascii?Q?SV5gkKqH6aQ5zWROVJGTeA6qfyTxppBT8P6jmnfOrqRlc5TPtA0sMG5iqLRY?=
 =?us-ascii?Q?bvY4rHaBpAPeOj2sWgUWaqj52XA0w+gxQJv6AlS/DvEM78LBsD9nxhPu/5R/?=
 =?us-ascii?Q?kNcf4p64ZAqoDOv8GcVwfeOrq7KPL16PNgVkSg2sBQOyY1X4E2Fcz+CzA0Rf?=
 =?us-ascii?Q?dEXUVx/jYfNce7au+TNb4+u+QpyQFaiouOfkYCNXUAaH36q+f5upc8oCtgFE?=
 =?us-ascii?Q?IuC5szUorES9ny13Gzwp5ZPCBQvE++042/27kILx6Q1gdudScnYELMPbCT5u?=
 =?us-ascii?Q?4dxrkDeFrqxebV6m5rQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4245c7-f30c-49fd-bf95-08dc01a3d111
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:08.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7pfJjUGHYOWNyYIhlCOziIqFcYO01Jh7pVfV++wC+dF8uYEyXV2Gz0tS4QckbG09O5Ht7gWDH8ktUSFeHEoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

Avoid use get slot id by compared with register physical address. If there
are more than 2 slots, compared logic will become complex.

"linux,pci-domain" already exist at dts since commit:
	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).

So it is safe to remove compare basic address code:
	...
	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
		imx6_pcie->controller_id = 1;
	...

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - remove compare basic address logic
    Change from v2 to v3
    - none
    Change from v1 to v2
    - fix of_get_pci_domain_nr return value check logic

 drivers/pci/controller/dwc/pci-imx6.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 294f61a9c6fd9..332c392f8e5bc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -33,6 +33,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -40,7 +41,6 @@
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
 #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
-#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
@@ -1279,13 +1279,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "Failed to get PCIEPHY reset control\n");
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-			imx6_pcie->controller_id = 1;
-	default:
-		break;
-	}
+	/* Using linux,pci-domain as PCI slot id */
+	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
+	/* If there are not "linux,pci-domain" in dts file, means only 1 controller */
+	if (imx6_pcie->controller_id == -EINVAL)
+		imx6_pcie->controller_id = 0;
+	else if (imx6_pcie->controller_id < 0)
+		return dev_err_probe(dev, imx6_pcie->controller_id,
+				     "linux,pci-domain have wrong value\n");
 
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-- 
2.34.1


