Return-Path: <linux-pci+bounces-2381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8390D832DCD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349A2283CC0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A85789E;
	Fri, 19 Jan 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L5TLtGSp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322DE5788C;
	Fri, 19 Jan 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684343; cv=fail; b=pMVeV50MAbxu6XH9mVkThteyJWNeWIfuE9xXYKR1AJuSdx/+B0Yg//S95Mef+Eh+EfJdDVgBjcSZOcZ/IxLGjMYVz4NzW7r1pYM5ctQw23ViWFCQL8B55z8DeeR5zvR1uQNEs0aKbG7y/DfLubWOONf13Z+0XHynYvmIcyRsO4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684343; c=relaxed/simple;
	bh=tqqQO6zPYzSAQmrziKnypvH6MSbxbykgqrfwDHHhugQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAILS8kon9CY2+JWOGSdnpCSa1dT18lsOH6DY8hKzpXvO5+mcPzZholkUWjW5RDDssJFQU21oZ0sFN1SEZEy0zWI/0sXLSpBKLrwcnDiBtkZdtKA1ePTYJSaEJoyF9Kw6/Zk6szflBGjISPXnwrP/S47G3zbj7QKW+wF5dq5gPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L5TLtGSp; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT7oKTKZFn1uz945Sfj3C+q+guTt5kdjHLjTxz5Pvd/+ShVDiwFaEqHXyVKF+g9aUw0JflGuf0wdPHzubspQTmLVrwVESycSXtEhONXzoYCV4y4PaaO3dUS0X+l4aWYOtRr+GpEguyEJm63lruEOPbwrM9HtzTX8aBofN4NKeujQ1mzkJygd17FM3UtXoKhI7SWVc38EHNApQwekTRHYKNHOXPriJJoEzpis60RnQrapKUZ6yQMSi1o0Xrocnqpln0wSL9sb5WZnRCmByuiHVfQXHQ9edmr0oHcik4T/IzMOirhLyM1fP1WkdZjqe1E8y234xBRV7Q9sYMayqG+wYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2bqYwVm2k4EwolqOV+jgPm8xypDCufJg5Q3cQdyl5A=;
 b=TiKU67p1Vq6IbZ/Nv1eHZdCM1y2Y1z4ngtU2hYMloI9I7eYKZlyuZQ5K5GwgV+4aRBuDGABHuOyCMppgh8zzjsiE6P451Sx5geVW0v664w+ag3fpgtz9bps0hfmnJfbjs++3OLwi+PjFnC7LrjaYRCpRRXzjuntSQdmfXBjdXzTiY6AXEVL5kbL3HDltFkVxqbfd/97x9D7Oml8JW+17u0zBCtOLUNVeIbmC6yMHSuyLBIeoz0RIDy1GPc0iER6EOE/DtJqqO9E73UoMDOAfx/lB0T+muo9/kfmijY7Lq1yzqFoT9cuaeL29cvDelLHNeW0TByT/afDpbBiz1VEytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2bqYwVm2k4EwolqOV+jgPm8xypDCufJg5Q3cQdyl5A=;
 b=L5TLtGSpM4XSBWE54RFWoTBqsjeyM9pSO9U1LdEY8B1m4m6HJ3iC4YcPaVhJowWIAIhBOWawcmJ06LcObXPmti/9Nc/Z7a5F8zUrgKjFRqhmBZlSdfmO0VLBBD1hi9VlkqRgxlVvIliaw3qhIKBh3GXg4WB7Zw1V1m821dIb5b4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:19 +0000
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
Subject: [PATCH v9 07/16] PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
Date: Fri, 19 Jan 2024 12:11:13 -0500
Message-Id: <20240119171122.3057511-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119171122.3057511-1-Frank.Li@nxp.com>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff28796-fba8-4295-efa1-08dc1911cae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4rIYcFlYWyatXECbk1dQkFA63n5tr/aZs10lFTvz4UQd4k9Ybpskm54HRbea96UqHYO1p78FCPxAtbU969gA04W9hyAVq+tJ9JFA3EzZ/TqzBKilXzzLeMKscY3NAG2gKRS0yxqCXNkTj7sIfoct97Bqfs0qIS4HWXDkA7mMcNU6G6rwb6tT69KE79hnOlRcbw3CK9cHqx+ICYOSsih8ld2toxCDUgrSb4e55Z/2e4qHf20IdpYGb1tcedBkBIe/aXhS1oJ8GiD3zYQAlgItCy6ClspZDVLFE3iu373D82bQsHcJQipziMD5GHjjHi/PHLTo9l8nMa/QgyCsLWEwhwMkAt+Qscp7iwrq0hL8CmA8SybFmips6yiED1MU4+NASl+sfGXZ43jKYVZ/yPq963heiEV1oV8nF4+uTTzceeJCcOvtwZSA/TIwq75PfU7jaB6itq0vNPkRgeAVUnaai+6169MDrZvBHEzSkpjNd+ZCfqFR9PezcF4xUfUBcv3mmuUr/oKnHiI1zqlkbNirxr9B6ZcfhnPiWxXFTDlcVrkJ9YhZ+kIx9xzottlpaJjg4GixdFFSvd2WHAISyZOwM1dWcOObc5RIHjWMwtgqZlXAK9PlFFWZHgnj2hjYHttN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VIEq/MpElqM6xiK1VC32ps7/3nAM52sQArtchuOHn/4XzgwMXRLuUByXV6es?=
 =?us-ascii?Q?cBZar/1ERcROoTpTexPFI7Xvqcg3ZoiIaXOSMTk23+p7NxyIpWqAE2z5HP22?=
 =?us-ascii?Q?htI8A1I49ZEX2b2qg3OE1bMtXbyvuaIKTE1hSlD6lSwFj6nvLl62k7h4c5cZ?=
 =?us-ascii?Q?RVCPC/8Np7smz/U62ez4uh7rU5OtTJTjAEArEloY0frqgwzaxG7wGctIXPpV?=
 =?us-ascii?Q?YcOOEOiJeJsLZazYdfG2ajJm1McTl0nIYymYPcybFe9qJQBicQ/9xF4QzOmi?=
 =?us-ascii?Q?6we813uorhKrecS8zLhtbfwknZHIxBJlfzwndMb4+wPn5WPttIQODsdCA/er?=
 =?us-ascii?Q?mvjklVAw8qAVN998A/MrAK2X9MCh0mPpmtbFD4KBMMZmVSAAi/IqoTzLLPyh?=
 =?us-ascii?Q?lFFnRZOESnj3YQktpK/vOIvK+OETjYyp2j3lXO4qTGTwP9ZhTvcECC+XDtDT?=
 =?us-ascii?Q?AxSg+fp0iMhcRF5UDw1t+kpnEZjR1piQsMqpLseliGPsHLmjSDjl7fdDacr8?=
 =?us-ascii?Q?etp0hIpBzkctSO8EisopAptLhy+0kkUWqZY8El2Ha5PKhMDGnwCVUuL5qYj7?=
 =?us-ascii?Q?O3rZmVjmdEvN/FYtVZs/l+0OPXNo7J8LuSorTU24P4nkA4eHNJwnTReRWXSa?=
 =?us-ascii?Q?FcEjt3LW+a0piFkt3iORAaHELzI9C/tzqdGGlBia4KegIU8e7EJS5h7Mb0rp?=
 =?us-ascii?Q?5e5PPBJq4JmPG2HOXFmXCEGC/J5qojuaBnSijq9jYOqP9KhaiaYQxS5MnQJC?=
 =?us-ascii?Q?kXxf6nBR0A3wwJdU2pVF2W0bfov+wLW/rF5LX5/gcu2xqdGA2C6iayszxwBe?=
 =?us-ascii?Q?ivn1f45pMw1Rym8ZxUSXvQnbjxn+RjHSOsDKcCAgagglRxpBDfv01aKvM4rY?=
 =?us-ascii?Q?mfAH5CCBOc0zQHuL2H2o4xKkg9vAsynfUUaBw0QNxaAJ1Xdj9o6t5Lzkrbss?=
 =?us-ascii?Q?7/wmmDxvHwMp/PUuTcMzWOEcMHdJ3DOWJmLfNY3RExGuEzw9w0AdVJIdsmkM?=
 =?us-ascii?Q?2/diAZZW87rUIkekLVy2PH2nPv60SV8fMP5oLIWV69AqL4gih27zLXEsU58l?=
 =?us-ascii?Q?LdxcRQW8ugmZzwooLDvLqmFekOTICQrb3o4LGmYz1xBvm9iN1hOffv8PqQy5?=
 =?us-ascii?Q?8ud6Us7gQHPGJQ8YkE6gPCBZEi+sZLb0wjznCKD5+Sche8wOCDG7RYoqmG3y?=
 =?us-ascii?Q?BgQigalMHCMMlBpYL+3uPOAry3Nh2IvfRMbOQjdp+/vP2Dv4cwPhGQw/S6RC?=
 =?us-ascii?Q?dSkVcxGWRZUwQYh4iptyiENw/fDQszY0ONx/HYp8rl/eZhtcWcRjcHL14jTw?=
 =?us-ascii?Q?f6iwW/F2TrGSWbhZNEh7UGUbwu/Kmb7cn4YJHadhgNnKsQrsu/BdU2LldmTA?=
 =?us-ascii?Q?Y4AobqH2q+1R6RtU+pHZl2X1z7dBnOaUjavXgcNPUnMWdJU9W54osRFAHauM?=
 =?us-ascii?Q?SbYapzASn/DhNsCYq6IY7+846eZCTKVywuKNLjety3aOCZTn03z54F4YuBrB?=
 =?us-ascii?Q?fusKsyqQaO+cpgjnYQ3vsOaD7gDrCOIqUquZan3eSgoGBQ/o+mAeDcIalPhl?=
 =?us-ascii?Q?gLBiUE/TlgrfcadKDQ0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff28796-fba8-4295-efa1-08dc1911cae8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:19.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPp5JriasvkZVsqLhdTDk67LeOGw/LMI42oRxOQ/KdolhQQK7snMXm573pdZ22HBy+5+O+4Ic6AQ7JOkmVRsLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Add drvdata::mode_off and drvdata::mode_mask to simplify
imx6_pcie_configure_type() logic.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Chagne from v8 to v9
    - add Manivannan's review tag
    Change from v7 to v8
    - replace simple with simplify
    - remove reduntant comments about FILED_PREP
    Change from v3 to v7
    - none
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.
    
    Change from v2 to v3
    - none
    Change from v1 to v2
    - use ffs() to fixe build error.

 drivers/pci/controller/dwc/pci-imx6.c | 59 ++++++++++++++++++---------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d19fcb54fde0d..8df07b71c93e5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -68,6 +68,7 @@ enum imx6_pcie_variants {
 
 #define IMX6_PCIE_MAX_CLKS       6
 
+#define IMX6_PCIE_MAX_INSTANCES			2
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -78,6 +79,8 @@ struct imx6_pcie_drvdata {
 	const u32 clks_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
+	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
 };
 
 struct imx6_pcie {
@@ -174,32 +177,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
-	unsigned int mask, val, mode;
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	unsigned int mask, val, mode, id;
 
-	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+	if (drvdata->mode == DW_PCIE_EP_TYPE)
 		mode = PCI_EXP_TYPE_ENDPOINT;
 	else
 		mode = PCI_EXP_TYPE_ROOT_PORT;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		if (imx6_pcie->controller_id == 1) {
-			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
-			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-					  mode);
-		} else {
-			mask = IMX6Q_GPR12_DEVICE_TYPE;
-			val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
-		}
-		break;
-	default:
-		mask = IMX6Q_GPR12_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
-		break;
-	}
+	id = imx6_pcie->controller_id;
+
+	/* If mode_mask[id] is zero, means each controller have its individual gpr */
+	if (!drvdata->mode_mask[id])
+		id = 0;
+
+	mask = drvdata->mode_mask[id];
+	val = mode << (ffs(mask) - 1);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
 }
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
@@ -1385,6 +1380,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1396,6 +1393,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1408,6 +1407,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1417,6 +1418,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1425,6 +1428,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1434,6 +1441,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1443,6 +1452,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1452,6 +1463,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.mode_off[1] = IOMUXC_GPR12,
+		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1460,6 +1475,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1468,6 +1485,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
+		.mode_off[0] = IOMUXC_GPR12,
+		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
 };
 
-- 
2.34.1


