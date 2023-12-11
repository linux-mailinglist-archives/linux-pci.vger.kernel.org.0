Return-Path: <linux-pci+bounces-773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED8580DDCA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F621C2104D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8B5577C;
	Mon, 11 Dec 2023 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ss2Xytcw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC6198;
	Mon, 11 Dec 2023 14:00:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMwohfa6DxTuveYABOuRfjrbzmXBUGtj484bf6ezpWB+C6OQ7GMlyiThz4V4axPHgapAkDHIPdVvI+xknLSP9cJaoxQ1eUDG9qjilq/BTUmSmzvB0cAjfZMIwLnnyyIFn3Fgwh6IQeKTajeUznM9TSMUMI3qCSoe4O2/ZuUjy+TGbTDmb0d3EY7DrNM7sJaxemuLtnKzcO0gfwoB233fH+yJSJv7KW/kxNvlzMZKAZ5gWHRp9LhQcbTvFmyUXgrdUJwPANcIIIMNfy+EQZM2n4LvEws8pQF1XigP+wj67l+pckx/n+/F29m8DSvuWSGtQrVkFvKV5Al7SiqO6LM7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s21Kia+/R5w8iqiCe6NLmZKQK2ikhDltT6roB/q7rvI=;
 b=M5N/bn+csUR1oTv684mlOqc9zy0glIoi5JQgY/+l8rwR01f8dQaE9Hwbp0n9pLgSR8I7AwpncxpCYemkkldxHTuSQgP1cyPCWZnyu55+ho+m5WxhF1FrayRhO//S2FdlKvyXnMIcqDcBFKSRqdgaIBJUrWAHvELcXwECrvFBXrPWLAJ6eJxdjycF12lZ76cqPAsngJsuHqxHKVYj8bOShuLp2SgDJuWBhr2cUSTzw3jyStz3jNVcORjim+lESVncRjwa2TxIyddfEoIgbQeDbkORuo8xzUMHsFbVh14TaK84rTWaT7unpgOD1HV7S+hnKOp33ZWxwoAD2am7UdiKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s21Kia+/R5w8iqiCe6NLmZKQK2ikhDltT6roB/q7rvI=;
 b=ss2Xytcwlwutp0Ei0MEYKRIHH8hijq+VzBYJXC4E99y1WWLkGPxvg78cifKgvLiz1eO82cShaAhBDYq7gskoA69Jiy0/qaC/2exkIzeIBD2grgSgPKIoT3xkfNS1eKap+88hjPuHU29uXFVNWe7opKDq21tP1VxExXq3+A5kyzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 22:00:19 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 22:00:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: bhelgaas@google.com,
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
Subject: [PATCH v3 11/13] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Mon, 11 Dec 2023 16:58:40 -0500
Message-Id: <20231211215842.134823-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211215842.134823-1-Frank.Li@nxp.com>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 41636d05-49b4-407b-6f94-08dbfa9490e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xkY/sjjojaQQENPgiqAEsmqQWA32Vm1cy77MnYIL3pTHyuN71TGvfe5QjCW3D4M8JnbPQ4GMFEtkNcNKEBMDITuOjQxLCAGAFHozr7wskTWI2d7kcTWeOAKBlSmtj51r5A/NoyCiSBe1D8W+u8q2NUUnBg45CF6BKZTF8mifR4av3B+exGq8o4uCaGa7JXWdM5It3cvR2YRTcdcQikaoBJFPwpxqY2sDriLzmg5yRJHXcZzhDZHYmduN+edQLTHcgDAINeCVPTQh8/fc/dv3nIAlyZJiteYGeniYcJFHIbzn2uzahlsTBQhkVgnybyPOG25FFJgsbgjw58I3pVmw1wlKRVzer3Vd+4Y0UXkopnIYGTK4F4y06jco4MwgVeMM2qs3Qp1m+OgPrCAJqWGoQcu/XXidjmWfqQyCShcIaFKMm2AYrJ7pr70OgD6mu3aosp1xUbKwmwuXCNeSfR+Q+kYkjWzmMBZYhRbPgOs2F1S47NC/aJuXICBbTdYs6lfZbLGut7WXIsxM592qVkJ0vaeQ+Wg67u72HMGJTbn4DTv9fDfx+TTGcQ7T4dBHMjohkZyCnxXyP3xrtjQ260aRouMsWcHfi9zGKWvt1cQ1AIWa4bfCmDcTRtfSj1A2C93H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPGK5T44FVd+ySVZ256cT1eQZBestxU13kBmNkL3DWqK84Paq/TE6FcW+aEd?=
 =?us-ascii?Q?gpURshHATKvcVX+5ufq2GieIvhYkPBvzt+n1j19OEk9RuZgPJxhFqmrutvKQ?=
 =?us-ascii?Q?laDC8DQS6QSECms4783WdydukuReGJQzilRF8B8o1OlGpXB3H/RvzgWTUFEW?=
 =?us-ascii?Q?++dy11CEk+b57yt9M+NLvsjcF3I9vtzPTss0rQowwWUbQu/lfxfU920SGOI6?=
 =?us-ascii?Q?eqEUfdDmxN4skz+Oxrom0zTNNln43skikCafLlkE8tQK8RU5zXfhCuaeTRaF?=
 =?us-ascii?Q?8pTpaO/TvMagSd6Rq20vLyaN9cY6tj5PuaQWdA/unDGGBncxUno5XyOlHcYO?=
 =?us-ascii?Q?nKaqRBorju9QK5xc5OoOTgcMYScgNpqx20UMFwfCTu7s2AHeXlC/rH9XZO/B?=
 =?us-ascii?Q?rtILVgOcHbOmKtLO5XDcmWeY1suoMovVvenPdQBGpL9xX6fV8e1lOQIcX3P0?=
 =?us-ascii?Q?z3582j6NEOxaKByClWdrWEWWhcR4HHvEiUD1L1QjJ6DRcyTG+WTm7PtelTnP?=
 =?us-ascii?Q?VqxqlohmneAxk19Hz6jp0q8RAqVXXoTJP94/XIXZEolx7MIDzfAEU2uJXKNz?=
 =?us-ascii?Q?VvXPGmP0ZVTpVW6dRZz1OdT1nY8+wpsjz7C3gous0Ab/DGXV0JGUA81S1CmW?=
 =?us-ascii?Q?3MnF74B10aL/zD/x3bDMZfdDJxHy4WfOLgF3phBo/Pfv1HTKToHQqKR89DX+?=
 =?us-ascii?Q?bdVVVjDFZ10sy9UKdJXGXJhRSfGkMkHEU6uAORBfDg2NO+rNpOiOanz5EVRO?=
 =?us-ascii?Q?eMF5XWBb8kvh1WYUmDud0i3C0xFuDVaguiwTB0ht50Gp9PwQPBhwFR6Ai9+N?=
 =?us-ascii?Q?KXod9I/PHXeRbn9EOogIVdBK34YCH22vl+Snc07ZbTT5+BXbpuZCTFzsliH4?=
 =?us-ascii?Q?Wp452z9fGsdh81W80UMFOqwPMusv9BpOBSddjNqyqZgGKIjk1JCRmcE5e8dn?=
 =?us-ascii?Q?NShvYAEUM6K+VfiUX92y4XIBsP5ArwjQND8vcHMdRTFBH+z0FT9OtHwFqHSG?=
 =?us-ascii?Q?9s4grs9sb0g9VVfQrkjeU9aoWv/A2oQZaU1Rko+PtSVf+ugGrEQ23tnQjO8s?=
 =?us-ascii?Q?hOALUCSBR1DUUFIKBz/DCijn1f2OppVfEymgr1WTPBLa62RXMG3+xXgfRL24?=
 =?us-ascii?Q?MfmCPHzp1S71oVE4k9Ce4d5hbLlrfCAts6uEz17sNWLqYbtRZOIHtiIBrC0M?=
 =?us-ascii?Q?N/JvRHI0TIIxUSDFW6eqzVn6DLPxLBJaNl6nMkq2W65srkHWe/6ZteiGLXNJ?=
 =?us-ascii?Q?RJX6MiMusOnLPygmYj+SVF/kigvikkR84ul5NbTjybAtriI/j4rtEaUbQkFu?=
 =?us-ascii?Q?Xx6COwdsQkRNXR4sijK9kouIdQhzK6JwFuIKOZlx48CJZ8qM/qlG54+IJ156?=
 =?us-ascii?Q?dJY35N/qp/z06DwF/3zplviDlQMDkGrMrKf4zw3t/DKnJ90bb54WmNem6K1M?=
 =?us-ascii?Q?uuHsGRLUYu7OZxJONEq28fHwFw+ZIlKp3c3kvjjAKEWKF6RVvF+KLxH5CUkj?=
 =?us-ascii?Q?p06k77pYHeY4HJd511K6VHbTVET6TVys/Ca504RFpT7/drOvOw5CPMAHnrZI?=
 =?us-ascii?Q?O+Bs3GoNYr+7n9IjO7r0wbP+JZCkVwT8Kh6cl0OJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41636d05-49b4-407b-6f94-08dbfa9490e5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 22:00:19.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+gnfKIlfBRi53UZ951vShf2NK2xi3SKqVNCN3kSuYzyrphFsDeuGaVfACCnugQ2mkr3viCSJYgu2ryXERxtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

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
index eb4e954e3a167..8fe66d3e947a6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -104,6 +104,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
@@ -1101,7 +1102,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
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
@@ -1588,6 +1592,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
@@ -1598,6 +1603,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1606,6 +1612,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 };
 
-- 
2.34.1


