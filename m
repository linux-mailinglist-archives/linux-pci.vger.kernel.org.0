Return-Path: <linux-pci+bounces-626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33B809173
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF051C20A91
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFEA4F886;
	Thu,  7 Dec 2023 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S2HIdV7R"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2AC10F7;
	Thu,  7 Dec 2023 11:35:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFO2MVT3g3dFk5OeXH4aim6AwXS6NEDvmoB4Rin4BMyYLjKvQ6nSa2eMoX96TYL8+u8oCbbdifmO+/vilD3P5Akv1pNEnZf6sgi/zvjjBrImKx4BUjhW04VZayq7BuOgzjHqEpZWnPhLvMXgZXOQzVFVoG9Z03pkV1M6evzOvomrl6rRSsdL9C5iApN9tRVly+YOlK4TymCU9kdTtzmWMxIpf0LKKTuuvP//qVen3D0YT5KSjjaYvRH+11yssmFE4wF/2JPx9RjVdxwuf/t3Qz1Ca8bn30cSBNwfJxB+6+BrFW2bBWuxSLhI4AnB3cXFIeKGyvlruxc++9FoMpskEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s0+Que1s5W2eoQy/OJla8scuKmDll1biQwYz1qYmkM=;
 b=BDvvko15TWtZzLSCk3QGZgZGZD1LBwV/Vtq4zzVY+nfGLLg9zQTeZaB490IifVXqAysc1dlYpz4Z2ra8BN6hwnwcLTkCHaTT7eRf7JlpqXkMLXvAOv8XEUkZ4nb4dGyXupMljBXS+SWvYbwq+WWfY0sS6pij40uQZ7uDn/RFwMOPqjXgRyz45cC9kAcLf3wWjLLY8b4iOS6s6CyrajP52BHAIDOsKkz40SoqFZSiKF91Io6IasYtjeTfaP69yha7VgYwjvzMpPNM65kBwyOWSmhKCxOK85N5VQguagv787/7OajJpddXiZZSxUFXfyJPL19f/8P12UKn6XNcDHujlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s0+Que1s5W2eoQy/OJla8scuKmDll1biQwYz1qYmkM=;
 b=S2HIdV7RkAbQ5pXbUs6CoQr1x2l5ToxZZHuB8a5qLmkUPdeOSG6ntghv+RQYxsSR8rl9P1LjPDS1bgBjj3NSTHIKR2o7Tb50Lv2CJ9Z2u4v3oWLfIj7G/QYXLOE65h50ibw9bcnAu5uuGa4hRBaeGWFLZ/HqO/arJjQdfapLDX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:35:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:35:00 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
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
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 2/9] PCI: imx6: Simplify phy handling by using by using IMX6_PCIE_FLAG_HAS_PHY
Date: Thu,  7 Dec 2023 14:34:23 -0500
Message-Id: <20231207193430.431994-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207193430.431994-1-Frank.Li@nxp.com>
References: <20231207193430.431994-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: cf369fd0-fd2c-4bb1-e5f2-08dbf75b9a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3CFN51fs1QTPlCXkaGlX3N47QxS5ssPSo8BitNey98SXN39E5QHRgw/Pl0+X/j+t/9U804qm7UJVrvRp3YAibdbMCBXX8louYt5NGRVd/gGtz8ZZCfH6fcVgcoultJ9Hq0Y/sphP2Felyh352dAIJmkJTJTNSCSO6KrLPQE51Vw2XQt9oYHT5siRoQb1GwNXxbnhm2k2kFXqTHzM95/28eBfeCAec95O33caK9YzEYaNxEHHrmuSuMkKm++1i3SY2B15KDjUfrLA4dG/KLi9jHBGU1HBNA7sgiVWYOLMeNkh/W6IEnBDcAL4rtbbUmRHCYMqET0LLlBIUeEhcm88Aph4h2wRVxCzPaTjjDcoi2rXWcVmeKs/M/JVoPFXfMSt1Dxe2CUQQ4eUKWWBj5v88Cww2GT1UIbjsxxJyNHGCbIvN6RhYJI0VuJbJJi7rCe8FIR3gd/wy2aMrJs70wRRqZH4qn1rFfqnZNTDXLoUHWJWtfYDjA4x+wGxk5xjmR/uRx3vIOLdQ3B/1cOIXGd3uMv6XZOVpw8Jm1cgpZhsD+/wRjNOXWF0ANoq2f5r5e9TfBggWFrC8w3KEIoEoXwQWaR+1LRZV4TJSJBxeBbhdpXE6Kk+cWJs8z8Q6Rw3knD0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(1076003)(2616005)(26005)(6506007)(83380400001)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BENfIbEIQT2HBENpfyLXzeZybDeS0csajGcNPFGczPK2Fh6SS+xTuwu4F4lW?=
 =?us-ascii?Q?nn9dQcK6gZvZERG8+eF265vYB9BX/biXUrNHcLNqB2U3feMz2Sl2le5m4A4W?=
 =?us-ascii?Q?IPOyYdSmtnWGf8UaGTC4E3xaSFXz2NOlaxXfLshTwt4LF1UQCAJhzTk2pQ2x?=
 =?us-ascii?Q?x9jrglNotQ/BeHbUYBtqB4DxtkXIFuXsbyEBJKZhIktlwMFQCQCen+m9heYb?=
 =?us-ascii?Q?O/sZlZUxO8O7VjwOaJsX/8vqGOYapRV2ncQUmTMtAc60ylPXxatDoqrOii1z?=
 =?us-ascii?Q?jtkgtcsl71ms9DJJm1EdHwGsQhrltdb2fvUvMn1yGKgpvG/4oDXptRHCrAnR?=
 =?us-ascii?Q?axS6+DXT5V17+cpgjdLRl1LOZebo1GRl9Rp8XklQKTq5w9hxGSroZpfrLKUE?=
 =?us-ascii?Q?Iyrj/R8vsE7+Wi6neC6nsFkJ428HLCl1umhHCEEiUAcwNAmW5MbG1UdKtwjG?=
 =?us-ascii?Q?ioV50O2lLNoxHg1mGFRN7kCmHek24+vxj5l9lk8wf5wH8+bHX8LBcKMm3h3d?=
 =?us-ascii?Q?3YWVrKxs8ZXJz2YS3u35//F2UwO0+tE/w2zAEeyG20d1y4XCLmqE/8wMWU/I?=
 =?us-ascii?Q?WwoXin6Zt2kNVNGErwP/+ePdyuZzF03NSvhenLBErrQS0mNaXymSVMsOhBW2?=
 =?us-ascii?Q?rOkH5TLG+n4s/eMH/bmrc3LwAKnsBnY3dBQ/Isn+fnUN2nBGEKmbfSAJaWAA?=
 =?us-ascii?Q?gmGUNrtwwWO4/iyxlwu6tRkFVMDDf2ZPW9RMRu9r++641YHtULDugqH0KhF9?=
 =?us-ascii?Q?yGfzXVjbkjwlJF3zf0Qnwfa51261qk6g70etykQ5rjAQMNb2JfDl24FsCMOy?=
 =?us-ascii?Q?AFrpIxkbeoWUXwE6jK4NyXPCQFjr7UpTLWmpWc8e40ZGSoETW6lfdknPqgKi?=
 =?us-ascii?Q?/8ZL4JNdcfLXTBZwiTmP9wyy03dmwdtdo1zIFJ8QuHd1jl/PHHXntPFWUO0l?=
 =?us-ascii?Q?kUBqAecEFBDTa4L44oR5LX5AUZyfBZtjWmfBwVOlpV8/mNmeh+P2a33hror1?=
 =?us-ascii?Q?GpZvSrJnSnzxi0vWnzcIE9AADECpJswsCYpy9x8S2UCwkiht7oYGRNLkRNHE?=
 =?us-ascii?Q?CeUaz3pyWgs+OrgNnkk+/Va9cDGpcxzTD57c1P639AXjLYnWgkCRQFmGzdFy?=
 =?us-ascii?Q?wHwTTuGK6iyY8Ag9AI57xdPRpk4gcR17XUmo/DYucU+rxZXedjAUbirtcz36?=
 =?us-ascii?Q?Dz9oNfp2rbLqFz5Ub9slgESFdKYOieQDH+HR8zwluemn2S/3dr1phQaI+6K7?=
 =?us-ascii?Q?ymi1qF7SmZqG79Pik9wVJ2sq77ph2RlGSUO9z0Eomf7OJBh8I/h0J8kR3SuF?=
 =?us-ascii?Q?NwWJVYs7g9hlPAgeNRDw7/XuIdY1omqk8ymWjybEOZDCGb+BMJlLNHa/cJSz?=
 =?us-ascii?Q?YQwJJset2f3upi0B4ScLYXIuhd9fRTpG8m4jXjKJINJottlWIA3RFd2WCN68?=
 =?us-ascii?Q?DIP6/IsIfPRZttwmqO8dssd++gbl/d6+Z38JqKmjy+tOIWAQJkmJgmHXZgJo?=
 =?us-ascii?Q?/3Ya4Y1tghjz35pWbUR3EluSnRIQ2pzh/N01PqmtAubFoSTrRNe5xskPOND6?=
 =?us-ascii?Q?wkiDtaJ88EbrqZNi5zE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf369fd0-fd2c-4bb1-e5f2-08dbf75b9a64
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:35:00.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fGXmYEpTPoPH2KYq8r0PC7m2V9NUWkLT2cuSUFY5GjW+B0z7VhWHi1v9aW1ahfSfTfmGSo1KvikfcX7Z5hlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

Refactors the phy handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling phy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8a9b527934f80..bcf52aa86462e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -62,6 +62,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI	BIT(3)
 #define IMX6_PCIE_FLAG_HAS_CLK_AUX		BIT(4)
+#define IMX6_PCIE_FLAG_HAS_PHY			BIT(5)
 
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1327,6 +1328,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "pcie_aux clock source missing or invalid\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
+		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx6_pcie->phy))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
+					     "failed to get pcie phy\n");
+	}
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
@@ -1356,11 +1364,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
 
-		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
-		if (IS_ERR(imx6_pcie->phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
-					     "failed to get pcie phy\n");
-
 		break;
 	default:
 		break;
@@ -1500,24 +1503,28 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
+			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
+			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
-- 
2.34.1


