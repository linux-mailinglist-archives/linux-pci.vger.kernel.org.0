Return-Path: <linux-pci+bounces-1457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FF81F142
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0DB1F21368
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE849481D7;
	Wed, 27 Dec 2023 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n5TxEjPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06167481D6;
	Wed, 27 Dec 2023 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdwYhseCLSeSpPa5ribMcvVE2P67xusRZr/Lu2/eVx9aQyLEz7zzw1pjfaPRK00tuSfR+KIYQXM7cXRe+Ak4RryLhLOUF390YqOYauqcfmSgnwQ1m9vYX6Jc8h3tl1r6wOpfMLfOz+/Xd3iv0LIUciieXZlFKFifau6YBKDl25sV013HPONkGuwH6LR/t1B/vQWF3G/LqcLL5oTfjI0AZilIbAsUcpg1IN/KK00HJXN5zpxN+PJ0kXrXWcPN4BWxcjk4aKJORyZG5AfGXYG67RKePvH0V+GV4Ue1qVbDqaR1AvaQvNF03Ne8nZ1E/vCITeR5IZWjLj4k+zYqXPRTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RVrid8a+eD+TtnotxTbO7QIeCjkzOMmpoWCT3IQ2Ho=;
 b=oAN6iNz3k3xJhl79sCP7MBjR3RgpwBfFxaqqq4GgCjrNZq278KgA4GYVD04xUjTxXJqYnl45aTYf/OpRNGLQGHI5703HkM590Q283VDi/X6/RP/8pNPMzT71ucdjUQ77OmIfQ+clDZC7k8rtPwkhFj6/9eKoZ0Yzy6lR5MV5+71FnD/NxdsKRlsyzs9HYoA+k8wX4PNmTx4xKs8MedIe4TEoF3AbXDNYfLrt+HczKCtn9HPkmvaVOjDzA69QZJnGrNjomkYqqHF2jN0UXyskQjMiDmy6tgZ8Eh/zUHao8BhW4YLhPUXFWvOzDOBHAoFZRSqIrr+CN+EEamS98bc9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RVrid8a+eD+TtnotxTbO7QIeCjkzOMmpoWCT3IQ2Ho=;
 b=n5TxEjPHD0YZyriXR0s+E1mhZq4oo3GNFArC3mTcutNbuNUHFBxR3cfy2dH/ViIjQG4eD0D4U1v50F6+eIa63iejdPCIJN7QLVEGz4zxGTv6M7k7JtWQ/vseioUUgzEO1rgaOxF8GNyGx1Fn9Fp4s1EY3xOpsjUVKudDNh4b1vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
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
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v7 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Wed, 27 Dec 2023 13:27:16 -0500
Message-Id: <20231227182727.1747435-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227182727.1747435-1-Frank.Li@nxp.com>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a90c3b-fdca-4c00-4fb9-08dc0709979b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2nx37v6Qs2mL7y1jNiMIR3/AhXq6UgxLE1cMR5/mNm6cmsGfsMBFABCiRiVZqmiw54ScqZIS0SCBfXCw0d+Vo8AxRr21d5Jr+qrxQj3YcthHs/bX5E84N5ci3b1dIGj9B7aFWboCyNKrsXTPTePfltMBrkG7NE6TS7wBJLP84/4v8wocRsA+rzIRR+NWdOxb+ConAthMyvaGhyc+eQHT4/U4aXg4dtUcexC1swBBOaCbu98/5sQ+Jo7Ryp2rGzTITuCQis9Ps0v495O1Lcm7jt/RjZVnyu3YRna8SWGjT/Spg4ezZ/K+QSTiWAxhTHekYaYDwM7O2s2wLhPsMw/JvtJMCv4hxXcBxItx6/JhSHdjKojl5OR4mf97v32kNDcnYI+yj+fPDmLqcyw8ugyaqqvuRnsiimyoLdTw5z3lY+cJihNfxl99RocZbcBeq8khHxWdYJhY/BPwFCLgl6ZwZpFI/R4mDYH9O3szJcY7eqsmDZLAz7kLAyQSGR478JkuJWSK5G0epnsEXQv8XfkRwRKgbfA0MJKhrRspw2MnhWLdopQh1uvITkzRm1zwhFKQyvYNGv6mGlH+2YocuT9VvZn79rtG1sY/YPo9g2u6aiDyy4+1k3rK4vI3tl1zR5Gs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5OuciWYXMu0zddc8RrreJNJjPR/Sa2gFoFSH+ZUzr/IUdzZeVz5sHkcIKz69?=
 =?us-ascii?Q?YdN2busIWZg55LEhVyq1/Ri33tM7wFvgYW3DyobH9YwuDYTB7Yp/3oJon8zH?=
 =?us-ascii?Q?wlBUDGENdeoLTmn30KGH2hacJ/mhQCVU8GrFnLHvd+YW0w3u/+d5AjoBM4pr?=
 =?us-ascii?Q?XCdniN1cLrfpwroRK4MLFPJBTADhfR5zRU3nEOpg1lmSFkyxYkoTMaG3udEz?=
 =?us-ascii?Q?xLb90W/cIxngoh1NKelui5J/BIK5vDgthd7KY8kAAosoR2Idlcfo5wywk8UG?=
 =?us-ascii?Q?rXOYzrOT2qQqiKyMdNujPZP3/ujf7j9OM7QlBYDAn6SgS5N0uEZiiZk3hu42?=
 =?us-ascii?Q?2+pwA8bhePzCJzEuPW3hUQ9qXWAPVw/gytqX+HADEl+b1BAdfvTnvOwqY/Cy?=
 =?us-ascii?Q?ZQZfyUOnnyLIqIDNxgjc568QeMg1bSERDO2hGkd+n26VhxtH1k6OScNGy8Ln?=
 =?us-ascii?Q?EkMRV3jR05tyyTNS2txxfQuaSVfPmYGKq3DSEHf5hyfAtayHholmRemHf1Ea?=
 =?us-ascii?Q?uG99wvinrmZu7IVmXGMpglD4ZJOI7yfLRV+U7SgxYtBJXYt3Ree7IG5CB6mv?=
 =?us-ascii?Q?7f+uaPNMDLwJMoSzClH5dUaCZBSx506oQAiiT/KFvplQNy5pWriaDPyHxC0b?=
 =?us-ascii?Q?vgSQFXD5Xx24T0gwTsVPi+4uG+iOzcWPb4LHhEF4jRPFRdh6YW6C4+q3rcSQ?=
 =?us-ascii?Q?kY3r6TFGctOvAtzAgis8RyuPEyHXXdEfmcR/bec9DJK10DgHGwHJDFxQg5MI?=
 =?us-ascii?Q?iLr7kKK9Ko7JezNHPivztI4zw69cra12qofnIynhsHNbKI3WFuLExk3Nf9L2?=
 =?us-ascii?Q?z4BviSkbNEsp0vnr5LUM8JApWPu1smYzzxRbsGBGecxJYmH2lMi/XTmRXtrt?=
 =?us-ascii?Q?9EJ7fb6ewg8PSXOMZJwtRgftgPEUO+k6Q55HlkUhSXg0Yrf4+GXyEOaaIHxJ?=
 =?us-ascii?Q?LFRbiYho3WxFZPiLLssUy2C9gqOa8scv34zpMSrHCZWSHGx4JMv2Rxf3pBg2?=
 =?us-ascii?Q?tIiiEShDH4XU9LFpQAw94zLE1jJc5vjaVCXcrxM08RN1LVQVe5x/MqNsFA48?=
 =?us-ascii?Q?y+nTQnX386jyjJnZT8au9RXrF/4/u5EbKySiQaj39wSeXMve3qMnUrKd7pQ1?=
 =?us-ascii?Q?dsIDzHbaSla8WCAK1qtO55EgrF64kdRrmFNXKa1Q48InQj3uF35KsXYebvht?=
 =?us-ascii?Q?Ruw95937bbwaSF/sRRC1cAxa49RiA4MYsaYYerhv4RsmWMYmgZpKdnxeR3Tz?=
 =?us-ascii?Q?ARhf27k0+Nr65unTzow1UZMx6Nqb1esZPXe0ar7JA6Nm8e0iK8DaDpyr3bie?=
 =?us-ascii?Q?ZxXTZ41NGBV4jDDvsfDw5FXLGWgra0eKO0s4mVTed3G0r5982ezotsqC9hpA?=
 =?us-ascii?Q?hEVVPm+7xbnsEOkw2cvh+ftOz8PLo4XAFfPD/FxFymSUTzGM6RiORQcRkniq?=
 =?us-ascii?Q?kCACZfyONFZzMNM4172LNEJYBIG3QV0J3bh7GZyWf5KKU2zae9D0ad3peiTv?=
 =?us-ascii?Q?vXZG90dWwkDUNt1J7Csg2vTl0crKdkcuDPuZdPKiyMcmRiEVnCe8YTO+o3mg?=
 =?us-ascii?Q?Ru5cJVte9a00OGERu/g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a90c3b-fdca-4c00-4fb9-08dc0709979b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:16.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqDoQDJQwgvkj8U6cPZ66V+VWDqpdhjOMVWM0T7vsRChglyGtM+CZLQdO+Ndz/aHbj8nbfAnb0aE4KQPkSwaLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

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


