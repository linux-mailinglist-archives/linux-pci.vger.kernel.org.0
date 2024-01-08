Return-Path: <linux-pci+bounces-1843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211F827B6F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8998628527C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588C56751;
	Mon,  8 Jan 2024 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtZFaY/U"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE657307;
	Mon,  8 Jan 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmKv0U/ub+vjNeUNRvgLG/wr4j8gXCCtr38KpGK9VtO2Ur7LjQe13xeU1OHfRC7CVytgoSycaxWzbX5ZpJIL+FRxPztqAooI43eOp1EWJgJrI1Fw+1uzqo9SiItE8SH5F2ceiuwxQEAwWo/4JsjMn9UigW+0SXDrfwXBgAdONUYusSR1nWf7mv/XRpaXg3cBhJZXo3gaxI4mj6ResaAr1qPVncVo4E7MjUoKNEmoofWF5jwzAVGhzeas3DTgxxvv0SpdeVLfSYslHYMtQjy++pxcoxc9bke7wAxPN0VtCnQbu+dUFt2D2n7t4s7oQmruwSmMitm5AkI6SrIerO2Zbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9/xEaUZJUf/Tmi2FrwYg9NCDYxwNjE8w1sHV8Dkrb0=;
 b=cBePiuWT/BLvI490AKDoeeXM/BFMIXJc3AZ3c8bY25vVK4jKcab0J+YqY6HXpFTYzLlxYXqUGizWux2UKj6x4MmBc2Sp/vXzr2Z570puD2GYM0xiyTH6Vv/zRPfvcqzG8tHuMu92Y5FySRM0uunJxETbh+7CNVGKXncnFX+IeEVR4wmmFOgLbHrVnd4rRxQKYq4H0j/xyJXBOet2oiywzR4FTmTp6c4j0F2YCRjdZlj/qFZT+ySgcug7Z7Bk2XpiKtzTw1+TXikC5PyUy5lYfjvNyo6Pc4JTj2tH1qQ6dnevzpV4SXVZvLRJPYCdwdKldsggo9M7k5rcGiHq6c/pzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9/xEaUZJUf/Tmi2FrwYg9NCDYxwNjE8w1sHV8Dkrb0=;
 b=AtZFaY/U6VKi1A4NO2PZvLVBgvtQlmq5pKDsYuMJShxvrrwN+fcoC1NqGJgxT/xypmiepCNH+6kz+FpMrMinq1bjXQjZQ4Ksxx2Be1rAma8ThxODdvEGLLFIbYleNkyFDJxZcq2AdyGyMHTxs5GfZGs+owviwhvC3SYD0sqsVV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:33 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:33 +0000
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
Subject: [PATCH v8 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Mon,  8 Jan 2024 18:21:34 -0500
Message-Id: <20240108232145.2116455-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b09406-13fd-4026-4b34-08dc10a0b15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FLwTqRoO2W2Rd8fKxkJKjxlRpDmQapGIb4h3u4zRghD2VtG3sY0ocGyVGL3kY5koNJwJJC9Kzz9oMxfp04gK7vsTZrQXc8rXnN64RSgqspLXp+2h2dEs63pIDCxnHJpZxv6tzMCAOmY6z39u98PK5F0gzJs18Q77NizSoAEmBLXzWMRD96RdnEXunYkjei9vKGtOFQXI4XU8bsEVmRsLE74Qwzlj0KaSeN8icuON7m0B9tWAQ9KZQcxrCHavytDWdkgYaZ6mV8VYlSrWNEj2R6E3v1d9dkW5EjBq1jljvsGE0hTq0SMcawrEEYlrf3YARJcN40UipM0NkiYhhejm3L7ksM4NUFMdgSiVAf4zUT/mU+CcC/51SQV91iT+xb+wQEcgNt/X+2XymNNchCLgBYguJ2rBC93w2k30fTeTYZiwo73p+rh5A5A7LuRq5+DEdRkGhwNCNZYAK2I3I/v6aTlTj7Iu6bK5KDl1a+eBvKji7QNU71b6J5en9x/KTpCE52C84I5rydYWH9w93teJONnF/xt08BhEJn+5CF9wjh/4iTN0kpgiXkHCrNUGz+MHYRKVlhJtEwSeIDbw/dIE1iy4xy4tu02gwQ0crl81eV3+IUSCPnNJMhEoz4s/PJhp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BUojhYJcEerQVa8+33rFqdYWyqX4PUzRQBCIBltQwGBnSqfje/STw7qsrD38?=
 =?us-ascii?Q?BHiF8SbmUcvQaZDAc6gw0rOqgDg00EJvxZg/aVwqs7Ojg2c3/EZzzkAhP7dd?=
 =?us-ascii?Q?HRw1mUNf+qipVL+4FzGcrV4x6tCvzGhr5Tx0NeEJCR1vba5sIT532f5lkBEx?=
 =?us-ascii?Q?VHTAdzQpamrHiwDsWxL2PBgq921Gz3F3BoI7CBbnDAJZ8mg36Xn8rAN6qbIQ?=
 =?us-ascii?Q?sK28IFO+HwbCaLt6G4g+odICJhmLHj9r6zgaBnkjjbdfS0ca+v74DMUKfVHN?=
 =?us-ascii?Q?LlhCuB0OoaVST6bvVVxm37t1kHTm0oaY/iin84TypNfpfHurOpM1CE4zl4l3?=
 =?us-ascii?Q?tm4TmedHmqs9nYG6TJ7mHtWARJCYPtHSL2GEefQMc/h7WbOtIpfRbyGsH2W3?=
 =?us-ascii?Q?yDxzkJ/ZJWY0U1v7dHKBUz+J1WU1JAbpqcHMFhNDkJsu1AAQzxcEG1ZzWKBE?=
 =?us-ascii?Q?mm8szBWG725No2pvN9ZwshEtsi+6/s1c1gxs9ho1KF3xo0Sfp8VhBFdAxN3t?=
 =?us-ascii?Q?tkU8wWnwbok/9QQutKwDumHWyE6xipXxwpBJZ20OevE6qlZ65wMeyjqzitYi?=
 =?us-ascii?Q?qrigC2Ao/1k8yMMc1anOJMeRSmmO1MXcGOmoDRR5OiVFKlDD0pSziIxqJLc9?=
 =?us-ascii?Q?gSXWPdBFfH7SLe+6NfmkC1WURZlK+khr+e84FcIdcvi04xQG4N7Kk7nCoTlV?=
 =?us-ascii?Q?vqax4Cdwbhno3EQFTRSCZrcWKNVNKdCrXx3g4lHY8ZSfY3DFCNJEFYxi1l0N?=
 =?us-ascii?Q?nKcoW+aQSGdYZrhyV91ylnBZpODw0Ko4X7PHXUAK+571wr1inmsTt+Tlea9W?=
 =?us-ascii?Q?MC+maEgAMWfqS3jIoiaYPeo5RshpmxEZXMwKezav/lbID3CsYCmo40vjMHjC?=
 =?us-ascii?Q?mg4GDk1liqz2kRAtGZuBYZ9N9B6IFXuj79BOaCfWjoNdPVP/tebRtNPWNpn8?=
 =?us-ascii?Q?UiKyN4y/fmaYSzG8uQihTOFcbYTmL8gIP1P7qkoPNyD2o5qSoeZ1fatzgYlp?=
 =?us-ascii?Q?ukZATq77fRwulxuKT3v49LyM4Gd+1S+jAVxp5xvM6te3QYETwKUe9/D4SzMk?=
 =?us-ascii?Q?3r+7JoF1EzuIdVIEuU5daUzp27JohchQbW+5hZ4PbR83RXb7CSNF9vLPs6Ll?=
 =?us-ascii?Q?He3QNm7buHP9SLjhed1GQIGPqqYG96xPDnho94uul8NrQELib47OFnJlozQk?=
 =?us-ascii?Q?Zy6p/tbvG2shDTNCZuzoknBnqZPiiUyjJy9kS7rd4QYTxVQBCyA0RYzM/fHX?=
 =?us-ascii?Q?rlcTQRdC9sgIR6M3baN1QxdYiGSU2ZsZjr1cqzCUp4lfib+2Ii4448CDxZN7?=
 =?us-ascii?Q?A3O2uKblqiUOl3RTulIBP8cho4NDwUsX+lvtE1Deuia13kidlokenbkpADWr?=
 =?us-ascii?Q?RjQutGE83UR4DPfmdLlvAj/I6/ixpwG+i2P6etPIALT5+Q/ktO/gq7Ewba7f?=
 =?us-ascii?Q?SrO18ZiGkG3z45kAwUZACEJv6Uh7wXySq4TP08wOFL+t3lG1AVBcIXygF7XC?=
 =?us-ascii?Q?pCbDcl9LbBAVVt2lz9JimCEoXTlcSS44ywB4yuzFP8NGEf6kbdpOM//mo7OA?=
 =?us-ascii?Q?e3AL5JMAfi9ZAf4TIBdaz35zjWtF7Sk8ZaXgDdbw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b09406-13fd-4026-4b34-08dc10a0b15e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:33.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMHlIm+xeD8zuEaLmGGWpiFW1VSBdEJxx+/BJKJJfuRejfsB9G/DEVvP4fQNxTibZmFq4BFLIwjCUg/r6d6ycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

Avoid use get slot id by compared with register physical address. If there
are more than 2 slots, compared logic will become complex.

"linux,pci-domain" already exist at dts since commit:
	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).

So it is safe to remove compare basic address code:
	...
	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
		imx6_pcie->controller_id = 1;
	...

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - fixed comments
    - Added Manivannan Sadhasivam's review tag
    Change from v5 to v7
    - none
    Change from v3 to v4
    - remove compare basic address logic
    Change from v2 to v3
    - none
    Change from v1 to v2
    - fix of_get_pci_domain_nr return value check logic

 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a1194f0a4c084..06aa40a185283 100644
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
 
@@ -1279,13 +1279,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
+	/*
+	 * If there are no "linux,pci-domain" property specified in DT, then assume only one
+	 * controller is available.
+	 */
+	if (imx6_pcie->controller_id == -EINVAL)
+		imx6_pcie->controller_id = 0;
+	else if (imx6_pcie->controller_id < 0)
+		return dev_err_probe(dev, imx6_pcie->controller_id,
+				     "linux,pci-domain have wrong value\n");
 
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-- 
2.34.1


