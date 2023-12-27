Return-Path: <linux-pci+bounces-1466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0B81F15E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FA2B22975
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C747F66;
	Wed, 27 Dec 2023 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DX7tn6mD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F044AF7F;
	Wed, 27 Dec 2023 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApX7n1gm+M4bjbRJqTXkGiRStMjX3QffupNU71iLHrlXGhd8UETDZD7ry7hZX/VGVi8MBH3I1ItzWxN3JAH7Q6DG3iradNNk+XgfSDzoAC0aHy9m+VnkhltFV2+AZVtRpqeyI7kyMaPaqgRhz5efnWFyabuMufrfejsM8f24oIZ9sPWCpi/UQe1xMrwA7/w3OnD1CSUXNEMWvRtxzrZ6/N+FvsPgiwr1Lvtz2JQhkkQEKq8yeyJc9HhIjFHFPSW3xKbjIGsTVlBXDa0pZKDG2BVNRKX4PTqRGZbTbqamIMiqYEULtUhWSSfYQW81iauGwPxqjLX9pJMITL+K9TalzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YQHpyLDTwT3wFqJLJaY+UXcCMsgHUVOZ1xcNx2P6fU=;
 b=gwlfqjAX/bJm8kDQQyaHKohZWfUbxWlgi4hxX39gwZS8R+kG9P2fYCQ/4ytGuBMuQYO6embQIb2n6PNbLM6mT0GXNpkV+f8s6/m1kIpo/TXu7CDRiIp3NzkTXkhDLBbjK1NQ8KbwFRNFcT0orJnLlhdntPMwVfmFTLV+lmuVKdBm4FtjbhxSBhdQ25sxTj49qUohGagjr3xpyKYr0dC81cllYjGie+2AXt/heKPgc9P5jW1RJSf5arCaBL3lZrWPlFqrN/6rbL5Az6F73m9AOCOlzf3DN+qQNHgYeHA8Hu8gPfVK0uQPYlygqfKIcDU2J4cPVrbNc8kocaIqYwVodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YQHpyLDTwT3wFqJLJaY+UXcCMsgHUVOZ1xcNx2P6fU=;
 b=DX7tn6mDunehZo450N/sAXCGyL1DydmdeD195lbVfEp9EetDeMtZwd4pIwUbRoLDitbNaR7KAOxtce4N7CeEWSBcve3Y4H1PJH3c0X6TtlsZ6DnpaDAzrxMeRMFMJZB0qshsiAkbliauHsKFcujSfrX6lDKyAVG+uw7Jjyh7hBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:29:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:29:03 +0000
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
Subject: [PATCH v7 14/16] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Wed, 27 Dec 2023 13:27:25 -0500
Message-Id: <20231227182727.1747435-15-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: f07a7711-c5bf-454b-4841-08dc0709b3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FOJG+DyWS6S74BlfG+fXvXrGvN1jb9fs7GzKEH0j2ULP76MtX46DsEr53iu86SHdqBCPd94lxWU1eHbT7A4Q+LXiyyX1QNdyY/EQk/Qx9r5ksPpDzQ01RV7Y4ki+U6NSwUNtKQF2DkGzzywQWU+6j2yIVQ20AAiIpLEbS+vi1kzkvUbr82HTo+7z6WEG2QjXj+odh4SmKbVsY6seOFodBjOP8q/d5EdEDwQRPZm8t2Sb5Jj3C8dpwwQBIFw3ZI66PTQFdcTQ3UlPV1baVyR91l0y/am74xSVZhXQy5wYBo55tuBBBIsxmsN/HsU8T7Qc0mmH/8aPBu6pY+BHTr/sl13g/HtzVx1fxBZh5D4ueLQ9pploU/B89mrAytH4vT8rR4cqUG2zeta2X73F33T6NJ0MzNHtFK7q2zDDcujrHngKjU1CiwQ+X67HCvQ/XUGS3570LWZ8iwaOR64xyAe33HU7zAnf9LvSOLo5jNBCqAajWQaUzof4HTHZiLBRUIfsKANWMDUdYik2xwuWczFvMNt9Cxn4jAWdAn0np4VCC+/Js6nNSEDgNh2C6DAjnNffJgpx/TFFI9ZoKa/hYi714vxJh6ezW5GooAW9izyQMxI2TfpVd03s/gwmO4Qvr6ro
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(52116002)(6666004)(6512007)(6916009)(6506007)(6486002)(66946007)(66556008)(66476007)(86362001)(38350700005)(26005)(38100700002)(83380400001)(1076003)(41300700001)(2616005)(2906002)(5660300002)(7416002)(478600001)(4326008)(316002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NvyqK8ISlswTG03y4kdQCBDYCEYB8NMm3J2Mtmw6lIdVL+MJhDEyxQ1c7sLa?=
 =?us-ascii?Q?W3BCU1itnIj4F+022DBorYsqmsQE0lnLYJRaGLePUgiomiq9FOgfku3YIlNs?=
 =?us-ascii?Q?gTS68l0jsbv444Z5p10lWlat4ZvEyIB5lOTXdeCcG50Q+viwVM8XucZVWxj9?=
 =?us-ascii?Q?yRdwcBJI3YfFWgklyBcNhLbdgNOQ9DPD3JtWcn/GUoQBfJIzdtF4v1GAIiUz?=
 =?us-ascii?Q?mS9q5l3IP7SHbc0psUZDD1Hbk0m9iBU2NbiajN0EFAHtM0pScCUtlMTTG2fF?=
 =?us-ascii?Q?YOWgjO7Pk+yOkFR9YnEI8fQBvW5rzkW6+xddyHZ0/KXRvpVLSl6wBEPEnITM?=
 =?us-ascii?Q?xGDVxxIZp8oKCqYz+rCaB5CFEs/h2OjnshI0O6i47scSL9TuFuXD01qjdmQA?=
 =?us-ascii?Q?a1E7ujQsJMHTNR5PC5jLODjxZm+/b95ynu0fsmGFBzovbm7W1PG85OdvbEos?=
 =?us-ascii?Q?ZjX8mTv/TZjfaZeS6rIlgOdcctzk1UU2TwUWM18dWx5NfDBnMq7aAc5h2Lfg?=
 =?us-ascii?Q?kSupFckG5FVIlO2VHCx7OshnsGXvXd5am+rbzUUTRF0GeNcekqrQbIz2Lit2?=
 =?us-ascii?Q?t6rFNmkvpw6V3q3e2Z3NR/DKFeLaWZXWN76scQWwYjwyHNb+qYx7qllxP5EI?=
 =?us-ascii?Q?6ARaQA1Pe2aYYeEwYkhnjuo7qFzxtqUtdacla05JYsPDmWcuw6W32wr1O/cb?=
 =?us-ascii?Q?vH2jNodluZTbcd3h/6N79iTDf6ET9soMbyVfcyJmA32sQz+RJcYYzIMYKQGN?=
 =?us-ascii?Q?BMB+m/9Xqbj1/nlCqIvNzlRcaaCXbB8tqsnbrZDoMt33NMIIgKW5HHXG2PyC?=
 =?us-ascii?Q?teI9AAvci/9lQKJNbN7Lkk6bYRtxTAZL/XlxuQ+ogGhgJMORIzks+oqGg/6q?=
 =?us-ascii?Q?b7ajiXj4HQfe0qLNhHV7v2WirQI9wGThLBIIM2+w1yS94+py9NqVES348soS?=
 =?us-ascii?Q?1Qhm8gEqyZ6FUc+D6TYkTTCIzJXANJJzjHROhvreFN+0Tc1a8xmwaOMbt9ec?=
 =?us-ascii?Q?ncYknwR7i3l2gPtLiErWDrT0ofs1V86fKeh9/kMuxv1cLmanfEunCxusM/vt?=
 =?us-ascii?Q?xl93XLsrf9zn+cfJ8IinMEssK7gWr7xeoVSm4wJkBRx+LTpklKc1z0qsDydJ?=
 =?us-ascii?Q?DLjO4bHRagJr6Ig8BhiZDkj+ZX3aFygR842ug6x1sS4NaefEExqqy7ZAboZ6?=
 =?us-ascii?Q?hAmTWVyI3JY4rr9M/2qe4RSZHlq13lBnCJvS7Dp4p8kIQbJ2CzpI0p4rnqa6?=
 =?us-ascii?Q?GWjhIqFHREiuO4JqgDoNVUC8D5POY2mO0+/TFYhsPyK43gOLIscH4F+BiBB3?=
 =?us-ascii?Q?bj04eMWCFtZxLxfPgZKK81XX6yBBS9tdTXnlGkImx2orrLEo4/bp+PVMMcOX?=
 =?us-ascii?Q?lEa+NEec3OSbMXdysCLi8XHJRrZKs5m4HdRYlO8qjjYf1ZyQam/x4bIOanEl?=
 =?us-ascii?Q?hcvZP3luId0FBQl1moMa8gEAqXvwv0jjKGB376VtJPitzsRDITVA0GLWEbyO?=
 =?us-ascii?Q?WzRLyImksY9t8PSXoJ5P/6kEh+y/kPSUQN8bnQEHX+ioFAHO+D+ls+/63FYu?=
 =?us-ascii?Q?bqlgXILWXpXfvKn5QG0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07a7711-c5bf-454b-4841-08dc0709b3fe
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:29:03.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzs3oUCiUEAYmIUi5by6VpwMUmSK8zHXPN1FSf3K9/Y9iIJ5DHUb4TccBhWoYzfY+Npdi7FRykQdiZf3UAf3Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

The i.MX EP exhibits variations in epc_features among different EP
configurations. This introduces the addition of epc_features in
imx6_pcie_drvdata to accommodate these differences. It's important to note
that there are no functional changes in this commit; instead, it lays the
groundwork for supporting i.MX95 EP functions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v5 to v6
    - add missed maxitems.
    - add comments about reuse linux,pci-domain as controller id.
    linux,pci-domain have not defined at PCI endpoint side.
    
    Change from v1 to v3
    - new patch at v3

 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4b2b9aafad1b4..6a58fd63a9dd2 100644
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
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1549,6 +1555,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 };
 
-- 
2.34.1


