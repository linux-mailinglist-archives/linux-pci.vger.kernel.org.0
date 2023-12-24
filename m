Return-Path: <linux-pci+bounces-1346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4324D81DBD9
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1466CB20AE8
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB92D523;
	Sun, 24 Dec 2023 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqd3pqoE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393891094A;
	Sun, 24 Dec 2023 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpURgq19hQgqAgS7jzvjrGp1+oKvtjrHjZM8r/uAlYm61/cSkQhyYC2tAxT1naIO5I8RWjyrQEBUcZaHMyMsHu/AUAyoXUp/slPtH+n/WqmewFKxiW39yAHMQaQSknmWhx/7gierY3jZuZH93MSm1d/x52OkJ6cSAVTqglxu1KTxHjRik9xaToT0nZg7+tQXhfDSV8xfC1WY4+iKsNzZ16c0CZKpD72eDxef/6RTiEBf/OQKuXY6AzZ4Vm3KlXaN7UyvZtc7+hEursZIQsb8oimkK3d05dz7ysolqCGRkoFzWK5ZtfUU9JfWy8EDG03UXuULUwZFnOr/Pf2t+y+D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RVrid8a+eD+TtnotxTbO7QIeCjkzOMmpoWCT3IQ2Ho=;
 b=jwNh4nDtyerMzA9aEacxs3I9EfY3VDmIfBfTKUbuQPF3/hvuz4no2CUfR7ntN4zEJQLz/dpttZX/ctp+eTBNHICNqu15sA9dZTZwPgyXXqoeQm6WUblza2bwnU/olUVkAhUQJ+g3j0dm/BWlyWltmKj5tDe2SvWJ6aShuqgLZapFYpbca00h0Y3VZmDPrD+T6YzrvBuirbe4YmtqBBiFF1POlcTzL31OEdJf06ybazuLFPc3rK9mXljaH+LiBUGGr7hJyUwubPCwjCKRTGFJzu86RsoR+SL/+AjXKQEfLDDcDU48VHZCdCutcEceTAoIUSmShwv6TM/26ZtbBJXWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RVrid8a+eD+TtnotxTbO7QIeCjkzOMmpoWCT3IQ2Ho=;
 b=hqd3pqoEdqSardA4H3uIKgCmjomn42DuZJHSM5QLAldl105/n4q6MTrtkey1XFVJkNF0tThZSJeomU96Js6pBZSsvWDDpa6nGDhBamiYzad6nOQh3RMNI/20pV/6DjG0ys4397AU6pSQPziXQFtn7wFiZwcv6cR9t4YGYEDT71A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:27 +0000
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
Subject: [PATCH v6 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Sun, 24 Dec 2023 13:32:31 -0500
Message-Id: <20231224183242.1675372-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224183242.1675372-1-Frank.Li@nxp.com>
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef71839-8de6-4cd7-6f7a-08dc04aed226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8vXvSQ0hulp/YkZptRmZdfZmVriO8C+qGNFeLXn+6d3h5oe9NXqZOhM1VqQE1FAtdNHK1lI+ekRxFkFvhRV69BubIbnH2x0GB+papu7OmB93vmZCEJ//dLQZesyZj43HpAiTWt5GtzbFF5fJ9yT5IoMJo2nPiW14SGsJIJkhoOB4QkV7/obC9PoZRVz76ru4iBr6AYOT57JiiQaduT/TDPSIBdheGRWJAoTm2uZKYfHo5hzGZmAsMW343o/H2EhfYFEIlumMbbttUkx1GfWd0nX3zCSXfbVHD4urT1VmEQjZJf5rlS4wQ3SDyFzqWlRvnSVnSmvuQ3eBcKidhpz+oWn5oUf0Ke2bOZ9a1MQUUufG5hkk5xCqkcI7jpvctdbq4ib2t9jMWayTfJQOIXTwhjFa3s840KsX9Tl4atFtopUk+HSVtYK4RGt/r/6WDrBvltJhcWXfjXBb7zsYk9O3gDJK4Wb7kwcF4pcXhCan02JFVrgqJlbH0VsAIhUB6+3PJQrdIWBH7hQHSXZGLA08sFOjbnMSdVGOAUbv2FtsxHVN8Wze83QyHr8ThgzltxqGV/+lr5YJT1qC+EFcc9nQ6m0wiP8fHbuiVoIJFEW95qtBkYItAk/aCUESj5vFoaWe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?umMUl1+SASAVuc+TMXzrdvpq1WpPWbEU6cWqTW8b8sqVPfYdrFs2iNroI34o?=
 =?us-ascii?Q?hXyFYA2pGQ3NOzWQ6CEyL6P85zDvkKfDA3Gwx2m9YjHBXLcxps9IFVlolZNZ?=
 =?us-ascii?Q?ZQxAI/XT3SpX+RDAxbFI7CHU+CNbrHuL4FB6+T2UCY7zfL9pQEAd850LvaDC?=
 =?us-ascii?Q?SEUd/GdgrPRFqU70mS1Vp4rXxEo7/1ps1TfJHpNjL6Hk+qhVaGo8kJ7K+GMN?=
 =?us-ascii?Q?cTwyVZIe6/Q7GtH2XqdkzJ5TVfUWD/vTl1W23n2sBylKjs8WczQkz59HCkmr?=
 =?us-ascii?Q?rzSNocF2ALnqtfey7KF1YQy4q2D6L6YSbGxeapedigLpmE+XOE3i97mjq2nV?=
 =?us-ascii?Q?lROFaNBPHHhKq9FpsQpkN4GJMo+tasiC3XodaRhLMTFmXiqVA94uH9J3fLH0?=
 =?us-ascii?Q?9d8SgAOgIQtCFHfnFULDBC625J5FdKbd3Pk3EnsbXypXT42CrGYfNeJgjT7D?=
 =?us-ascii?Q?O5qZNNZwBI0jyQ7k4OGI7VopDHV5yjblFDpVeQDol8NHx9+XmB0LzaoTIJfm?=
 =?us-ascii?Q?CsifjBdcVkilGCvqzEqIsFJ7Ns/6ReDcnU2QwvJE7xqp/GqeZOtX94HtI4iR?=
 =?us-ascii?Q?/Yvh5e8Egg1x1q0Qt4psl19hlcBMa7A3LZwNNMft2uCummRZ/sPjgp5cve51?=
 =?us-ascii?Q?pWE8EIjhvGSUx+kyUqECoN5psHK+T9mvqNd44bqSumrWNT4bfvcyrvcXa24D?=
 =?us-ascii?Q?wtRFMvqwjzf58Sxca+ol8xXPhIIAt2Ece8w+6hcCg2IEe3liE4U4aIYyetdD?=
 =?us-ascii?Q?hQQ1VcXWVv7wVtS2vhjqd0xv8QjXLWcLyu/1NSCiQN3KT9nzuRUo9rdF9RAy?=
 =?us-ascii?Q?Suip15x9hpTYeRxXMuNQ8cbU8p7XxcBmfuF7UaFqP5zhl58cV0svil+DuJqf?=
 =?us-ascii?Q?7NjyCfXpYPrhrPwnoVW1EGXPczqJfAj2NFTUdXYCrb/Bbq3psCUPTetrieYP?=
 =?us-ascii?Q?CXpPNTQkU5Xi11Wb7O9wAS+qxdSUbCOMZ1rgihoAxLS2EddVtVN6SfksrpeF?=
 =?us-ascii?Q?NbVhWXWm10C5PiAl9KQdlFhdzX5hHwYYehDVoYNMiYW6p6Y4Ply3cmNygAKP?=
 =?us-ascii?Q?h6M3xFNoSyC5G6NJBERC3P9AsQwzBuvbhf9BeuZNr/ZGWmEHeqCbJdL4jcl5?=
 =?us-ascii?Q?7lo7Jl2SkAuQ/+eYS1zZDDCJwhP18bHG868pPSYcC9wvm/a1qUyfed+sYd5d?=
 =?us-ascii?Q?2+TvZXpRczB0aTEEf1nusfx109T2N0uDb3+rHmMZ/a/yFYVHgdFOVv4X6pMr?=
 =?us-ascii?Q?NdZXvV7AyJHBgezlGRIE0Jp0Xu5rFnfzgJVNbkwQUv1j3ZkKCSm+CKpQ33in?=
 =?us-ascii?Q?gHuey5t7xeStfPZ07hD8aOL+wsjpShZhz69kJY6wSb/KDl58aq8JSlz0HBw2?=
 =?us-ascii?Q?n+W1qCU6FtlIghseWq6cdIeIlAxKVS0UUi/fn65rMFpMVBPD0WgHIg+Gc6mB?=
 =?us-ascii?Q?hfeJ6tozpCYLd1Gu0IF6R+Ntxqnfbgz2HHXk36dTElcMr/JVZi1o802LAgWr?=
 =?us-ascii?Q?qftYUrfBoAIYN1yFBbPjcYgmPl0gps/72IsNPtmTTYn4EC3dJ2zFOVWu08Be?=
 =?us-ascii?Q?6rLyHgDr7L3Omhbz78M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef71839-8de6-4cd7-6f7a-08dc04aed226
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:27.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQ135vNmgpMXRQ4c+3g+xbz4Ss7EJgNBnJlAGvqWXeyvBR6K9Jj2stKk4J9obxwTs3q4VVYjy5+EkcKIq/dUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


