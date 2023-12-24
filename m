Return-Path: <linux-pci+bounces-1355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E281DBF4
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA061F217C7
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD2D2F1;
	Sun, 24 Dec 2023 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKCPRhE9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73A18C15;
	Sun, 24 Dec 2023 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ9tjf/9zXDS8pGSne7XsNKhqYY2tqHBwJ7bDQQw84XSoLkNG86wxdjObfclqQQZnlD0tG9Tt/gpfy8+1GWwotPI+S8CW0m+L2cpV1EoEMlkqBpmtomF6HkBli9OqdcKwe4Tc2KAVrd7wWuOAJYMEiSQPvX1SXqcNzK3eNStTs32nDLNo3XVbZSHdVpQqAFzQaTvdOhoLvvrN4BV4yIw+H+aPR3VxHxplMGCxHdIFNedEZTMh/ESStayuT90dDJNfic6bGFRKwp3yMhuHFPwZdoZDo4X7E6qZyJjhLWbo7KyCwr7FLDvL53u/K6ukAp+CDZYPAhctXYaFzkGnutLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YQHpyLDTwT3wFqJLJaY+UXcCMsgHUVOZ1xcNx2P6fU=;
 b=Sh+fQD0SXdfDXWOzpz25tMyrByh+fGYSZ8S7zJcYWP8rDGBSlNLD2G90ytRtiSxPb2sWWcK68ay3SoJYiIbEUKpYyCvQ1uyR2rzZmAKvyNtitNXUJNoL2mBgyY9O7lH8hxuW7x7MjxkLxW3Qirwot0wJPA5b+cOVnVi/5rfxgsH3MKlJmBC6qNYSRLxA5kB7rPASwW0abndBAuzPUvzeijHxpfiSpLj28ELpEYc8r2lWHvc5K1x6X7eW0HIMNd3w65Wr73EFAESyQ8P5r9ie58Ywz0tpCSX/dNe9sQdL3AxyWeuHemL2H9IZK4XwHtnbYE6YoiYEcj+Bzq8tYh0Hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YQHpyLDTwT3wFqJLJaY+UXcCMsgHUVOZ1xcNx2P6fU=;
 b=aKCPRhE9Lfdlmr5UcWonXNvl6HULKG97ifZP2gQy3kTbeujBu5qSJziXnZ4tb79aRvi8CbDSw8WU45TFuOFuc3bftrWrDCy1noQadhfD1n81QJ5Ys9b2e1Q3K9Zob/R7j9EYu27YA0iEgg9yZfg0PMfF1Z0DOs2Ewdq/YDfP8KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:34:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:34:16 +0000
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
Subject: [PATCH v6 14/16] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Sun, 24 Dec 2023 13:32:40 -0500
Message-Id: <20231224183242.1675372-15-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec15b194-9342-499f-8a5b-08dc04aeef0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t+24VW9j+YOSLEMTxx1dFMCnYdIFEHQZ+LNsoGihKGgZ+8iw1A7hQIVxSzNgq94pFfYo4uG1lu662ViAvMYJ37t0wQzROHfsC6TejCnaiFhgxDSaS/oAzvnUZmbhaoctfom4Bfad49wsBMjyVJiiYg63iubu1sAMaABmTffKH/8Q7l9mm/LE1IxnabtSYbUmCVzKLeRdhHKzQgVnplJPq/FfwWUxe5w9DZtoBi4Mf1BbNs4tEvVl0TAR85TXo/8J0mPcpzxrlVljmAFbDM1ChqQfm7AL0gq5WrDRA441Wyl1gZMd8/8ICAN+1EKvctDSHTivtOWHcAldsOeiONE4yh/3fp1Rlfkfmk4iDoBXYi3m5sEd7F3tV8vrAvjenDf+vnCsQFYrC6DMURkYMQUdwMETNwB8qfRPU8PtcYh72P/U7fKlmmfjsQ05BfJGxmdwi4KssSTaoykfEd0ENh6RswWzhADiEkBoMci7ES8oYLzBcaA/WnJ1f8eBspuU3OjjtzMHqf7lq+0DzNJtstzHiHJOMkyoV1EOXJjmQkk7IIGV8LbmVTgCVIve/1uyS5gi8g6cpjK4DmreSS94vpUYsxzXfPZYloXuTEFD44jqGv7qvgxYLrpOGBGvLiODK48A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHWvrnsV2KSxWMuru2F8pbTxBjV5AkuOSzbmqmQ7LGvqikS94R/mWfreYH6I?=
 =?us-ascii?Q?Y15tlelyzu0zV198oiTqs1h7TWQcUFmPVXXFbhKkn530xgcl2l4jPwFmibBN?=
 =?us-ascii?Q?TLbcOemzataL+IgQF72hAgXXa5HVg208OkYtlglwYodQeOEfnzQYeqfugwIe?=
 =?us-ascii?Q?t8meu2POmyfjoE2c3YiVUYoP2Mq5db0Jtq4e8+HWLSDPyP5nnYWaYVYyCJlL?=
 =?us-ascii?Q?oLL6KuTyXIJJKjhXzgRkClPNFm/bThESDKfPqedU88yVX2KL+igfGsQF+C0N?=
 =?us-ascii?Q?zRJaLR+VYsZGjriSbyAUr/A+Ceiu3PaCdBcwi2N/UkX27ymrs1jkPemV0xkH?=
 =?us-ascii?Q?YsAzcQXZOt6VjlgE642CFRDL7yMPATnMLUvKI5SLdeq33TM/RCsRRn+depy3?=
 =?us-ascii?Q?uA1QE4ywnlzQKxr0zhRfQWndnx2BnxfakrBUQUvrA9DTlK2JM+hyhA8oFOw5?=
 =?us-ascii?Q?Hax4pjvRcgw4LAQSRFwOEIHXkLqsSyme39wL3nsBRY5W9wwrqO/YOAN5ZuOP?=
 =?us-ascii?Q?21esAeJlqRxo8pOZpinODPMd12AhuJxLwR51o9jfSvri6mprz6xn8wctbA1E?=
 =?us-ascii?Q?krLiiUFmS9SbwGYYVp2rSj4J8Vdj1gM1jr75KKUpdZ1mSUbaJ75gxdZwer6n?=
 =?us-ascii?Q?qWWsVYXhdaaKil+kAdUjKDaT5HlAnS4oR2aQCXrizDPOIIzsblwCzPyqU3hR?=
 =?us-ascii?Q?EVXWRgPespdYdXY5GniYhv3kcUpXIP8SYny15CCIheqCDXYQKj+db5/zOLEL?=
 =?us-ascii?Q?FQdTf9UxXxZqveBschAAR+7Xm4iQLe1sZRwW/4bkmps4BZptPnXUrXA2JoU2?=
 =?us-ascii?Q?WgB3oqGLfqmK5i9rOOGOh2YbTBxMZifOfcEM3FO4jWPhUZN5ewB9bDl4O8lo?=
 =?us-ascii?Q?bV92UEtFtlOXu9x9l2C4o6V3LnCPMKXtDMHKzkWh7dJoNNAC6Myhgif87ARh?=
 =?us-ascii?Q?vEAHDnKwdVbdYyOMnqAkMBxhOfGZIgrBoPl38jf3sjXkkLHOwkYCv3RBRITS?=
 =?us-ascii?Q?oLlKqdjK5panSznPJm2l2PGQq3Tjb1xzc5L+okTvrxB9sYp6QLINsdEgqJR6?=
 =?us-ascii?Q?snrZnK3UEuMaaZd9/Ov4HUipPRJgUkjulemf7i/k931QGJyi4rjiYVbTJFlF?=
 =?us-ascii?Q?FDjFo5FfANiyv0WrZUQtBtEekjY+AKmtMf2sbKNWo5rk0linsozMW/iY49lj?=
 =?us-ascii?Q?iTza/qbKcTPMYQ6gn6dASVY8xNzrYuubZyrJY19pOJNOHON/6ghnPjjntwP/?=
 =?us-ascii?Q?1YrFtyFb2eCf2hofU9T72pojc0Zc7Tr2AcJpXAqZztPRnm5QVo4/l3zZZv3S?=
 =?us-ascii?Q?Jdq1ELhASZnlH7EFIWHVom+tGxIlgFImMWngM7uCi+15l/Gb6iYiBJamk6U7?=
 =?us-ascii?Q?zBfTeDZAFhYjgAdGXiomliMbxaKqTBH+ezIYbZbZmGu4u7WWBOYnY5RpnFAN?=
 =?us-ascii?Q?NDK03O5U1saL5Zti1i+xwYJ2tFMotXLs8UNPaXyIYaiXgq4uLK2cyrEDuNAm?=
 =?us-ascii?Q?7yriIeIgyHIsMnwihHznfo8UaNsQEDCkIdlmdn7ag/VJ+KTI8RS5MbuZZ/Qn?=
 =?us-ascii?Q?UG+hyJdD/MiR25p0LAc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec15b194-9342-499f-8a5b-08dc04aeef0c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:34:16.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkTP6jDM272IYaOIDgX3toBJef+beMjbOn5GbmARCNviAvsprQCAM8GU8X2IwpHbJKYCbttSGeipB3QKMN9nLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


