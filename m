Return-Path: <linux-pci+bounces-1115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A4B815D9A
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80B1B22971
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC717E6;
	Sun, 17 Dec 2023 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RRG1Ti7R"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFD1094B;
	Sun, 17 Dec 2023 05:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/s0gMTRqS6L0JWd+g+WRI7c4jhg8hWkXck2d0bBw/b2MilU3FYsnaZvnLsNoSB9h74REJeGck2lmdN9+Gzq2ccLi6JXiQ0/W5kkTdrpZPdDPRG42WBX9WSwgtR9M5znRWdk+8hUqO+FD+HHUQrgyOFin6wB8gArlJRXv0HE4igZsGD5QwSsbcyCUlQQu/BO1fPwsWZS+uyMWL1cuBE3C0VFTU5J9kW++1dWbk+kPt6LaXXzNe3amTyrUzf4V6SPL6I+kQtIOQ55eMi3PjJqhYDwEK4SfeUvg54ys4Z02Rn4xD3AXn7O1Ppq2d8xdfNM5I7mXFHNHayu5JLQ03f3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaVaymDjBZxuN0yhhxY895cEC4CgIhCZBTzk2RtRaGk=;
 b=KVpfNIkQmeeLNu7N8dKpdegZdi2TSDZjv8IiCqf2HZCvSQJeUg9rytgjyhBfCHGVGln8ykdRQcPUhelNVoJa1IQd5PBr6H5lpmfq1UxFHS1hsjCHsIPPydKAIx/vI8/adbArbW5mFIYrLNClr3pqDtov9uk2IFYiT+TF1e8zpllbFts3v3UnPI9Ef1hIes+JoYkAGt+pu9S7STtd1iFT2s+p31M2IVfi1X5SW/5SuipwlR7Q2Cvm9MbthUBhOmcuZTG01FWPsIZVnhGbJDq//Ly+ffR+/fnzw4OZS4BFA/KRKadTy9hLnptlA7QzP0gnmeHyIPCG4Fycy4pIpKeXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaVaymDjBZxuN0yhhxY895cEC4CgIhCZBTzk2RtRaGk=;
 b=RRG1Ti7R2RVxIzv/JVT3ofjMG7RKXhXOvSkh06Kzv22+/pQtrT8PUieIRMHQVqoI0EfaE33Wm/7Ya2B0bKInnyW4EMk44wI/TtIx3SXaaPzy6K9v2m75jFVLHaswPddxepQ8dg42MnxsHk3NAKc2N8SswOD5Vadf1ac7h900CxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:41 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
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
Subject: [PATCH v4 13/15] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Sun, 17 Dec 2023 00:12:08 -0500
Message-Id: <20231217051210.754832-14-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217051210.754832-1-Frank.Li@nxp.com>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbbbbdb-b094-4bc0-6409-08dbfebeef2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FVVtuhI5wiieLW7u+D8A67s2q4uIzUiVKi93/BtPIQDcYmQRi0/4wGUn1tKhSo357lK7LYhKpU0vHZEKNGe4H0D7Wy+GIKLO8URfXUK8Aw0lHpMt+JOtf4MzDkrcj0jG9gp0K37MUgrs0hLJXVmbORN66h1g/ADdWRdmqek1cz9HfR5vOXVhmNCMS/BhMAuJ/QWzRWYdwXIuOhikASaGqJbXIQ7xObgSMmMdBHwmzIDUP8Z1VlW7x4rFwc809gOcAy/KxGp8IHaulh0R7QdB9OATsaKjQ2fdNFr3NcSgro7HqR+e0gxbeI2j6uSCK8XogSk66jtS9iyerJgVtePbW217bBnDxJxHrXx3JnDdQ6MaQi20e3RKeNz8CvN26CUEupj9wGue7LqywZiqH71G8V813DiLdovbaVwZBoG4bOAsKYT2J8Cq0re98zvcfjLsl2a/kP4RJx8Ww7RPrQvEB54Qd1GTJJJYO8wfqVsaJg1miV/dCDvdi7Jt+LGjpccAwbCMIMbSQSNqcVbGTTSQ06OcJlKupOCnnSeC8OD/qYydco9Nzw4ujIZ4c/azsrhe0URVbWjuGMggXr6WcKJPlte6ZZGG7dWRqaM68VO6bLXU0sBYl3sykiE7E1VgZ8nT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gue2lDNCKXWiUkuBp2VhsXyqs/jmijfFrG8FhX3lD5irm+y4jTwfyT1rUmy2?=
 =?us-ascii?Q?vH/uEuxjkB8PNn/gre+n9yr4Q//7e+cRJ2R943VRqD7CQEfmT23e60ylP8oS?=
 =?us-ascii?Q?leqTn/UiwBdYfNBfGRX6Kyj7+UskFluVLVKeyXoECsuNUI3bcTEs1yAcZl1k?=
 =?us-ascii?Q?pH2+f/pCvrtdzMBs6X+5NaI1jaSmolJwaOMFe0qUVfp4++PYqM07ugKJfyNk?=
 =?us-ascii?Q?fZMa8d/h668qmSck3taBOXDkIqsw92y8m4MIeriQG21uMwkBFk3f8ZUU68Ub?=
 =?us-ascii?Q?O+7No0h9xeTGG/82iFRaWEgC1O0rioqVLiRGm/kUi/m12Nwv5inFSI+DH8Bk?=
 =?us-ascii?Q?7rXR82irP2ymzy34hJKf+RzA0arXp2/ZeurJ8wyxJJjrpR+fMIacAA3qnJpi?=
 =?us-ascii?Q?C1kUfEIsLo/V5Yh/WKjrbo3K8a2C7m8AHM0B6IW7wG833cVf1kgBMs2f+SCH?=
 =?us-ascii?Q?fstGo0d/aNIDz2I/T4QTuCSLf6tJ3QYkYj/qEzBxxIAI9VBHolc1gEAnIncX?=
 =?us-ascii?Q?Tdp+9LlyH3eT6b+CBUv2Cs0fV8foYitiCfCNfm5DK1RJSoYot4W8oQlwOEvN?=
 =?us-ascii?Q?bfab+yAXcqFC+IlqLCPNEOQvDPa1E83esHnhi6SswLFe3JxUGOxzNKA4PnWz?=
 =?us-ascii?Q?MUBpiS4flw2uSXQII8Y6lP9BDWj6Bf5iI+ZSXf5OzrwWvpZDLlJ5Ik/DkJEw?=
 =?us-ascii?Q?jxSZa3iARB6qHbGlA8hn2Lyol4KToso/OcHHqlgwhXuEphjF0D1L/hDxTNfR?=
 =?us-ascii?Q?lH7fwyEyZwKzKHddJvnUsPtOzRlYLNHo0u1Rmzvqcz80y0koIx9KqEVvtQD1?=
 =?us-ascii?Q?AbjyNVMZkADA08vzw3fIu8+AIbcFSVg8LX5pTMYanK/ECSvT1c9wfLVEPkV1?=
 =?us-ascii?Q?8ftLaLJ3YubGDwFx1TwtmEDkR9gonKrSZxBjL8dRn/kG6yokm1nCPoll4JK5?=
 =?us-ascii?Q?McuijSDRM/yL0g1rOcKp2flI7dWBAt0ckW98xAf45xyQC0nVB+ONPGoEPKxf?=
 =?us-ascii?Q?NzDSyMeE4CXjNsqyu+L1gnL4TGhFsf0ZwZQJno4fw3/rWe4yvlcM/Fst/uBp?=
 =?us-ascii?Q?tALyEvIK6YaAVeNWiKfoNaVcaOtCsF/Jig+V4Tzm7FUu5FjiBtZGas/61zuR?=
 =?us-ascii?Q?ENp46nZKTw6F8QBWscnNqta4z7LR0O89U2bbjqKJ3+dfENPvELIvD3KSldOE?=
 =?us-ascii?Q?A8hYeYMJV404883SY91JtIuc5Fo+iRO8ugrQzruBM7nAsIYtSRf/YXPpxntx?=
 =?us-ascii?Q?QvnUnAMuaJlwRow7yDb/9zsiIfVQBYfcbgJ+eyirYX618s3jbTCNEeetSbJy?=
 =?us-ascii?Q?FUMWVOtdyXvTiHSppySLEu9p4rmG9wVgG/xW7lFZpkipPNFgGwUXoiglSlUy?=
 =?us-ascii?Q?5eQoZoeR9n+6GS72+Z6wZA16x0R6xqYHQCJALX7QOnVnFsNvl5SpiNM/bt+3?=
 =?us-ascii?Q?+dnZwAmmI9f0p2maluzimAbLD+fmGu9AMH9Kma3XMj/UAkVa5oTieqAGlfVF?=
 =?us-ascii?Q?3vqAVLYcBinNR1IkJbH9epiV9LaF0cEmeaUbo+7+/qC1vdlo+lTrvQylbIEa?=
 =?us-ascii?Q?aNxXkJl4KfdbkY3MJss=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbbbbdb-b094-4bc0-6409-08dbfebeef2b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:41.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWUGO1xfTXJxji05gIvgf3bqmltgf83j3qV7d9XcRJwxbfg78LPg9bpQfmtL6SR7qwAxkNDczVMiOFOHpB4pkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

The i.MX EP exhibits variations in epc_features among different EP
configurations. This introduces the addition of epc_features in
imx6_pcie_drvdata to accommodate these differences. It's important to note
that there are no functional changes in this commit; instead, it lays the
groundwork for supporting i.MX95 EP functions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patch at v3

 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 54b90f8576915..8f7b1533e2869 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -104,6 +104,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
@@ -1065,7 +1066,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
-	return &imx8m_pcie_epc_features;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	return imx6_pcie->drvdata->epc_features;
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
@@ -1530,6 +1534,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
@@ -1540,6 +1545,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1549,6 +1555,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 };
 
-- 
2.34.1


