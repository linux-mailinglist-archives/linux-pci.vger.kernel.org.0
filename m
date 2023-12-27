Return-Path: <linux-pci+bounces-1465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FEC81F15A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C921C2256B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2247778;
	Wed, 27 Dec 2023 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e/QdcYeI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF647F66;
	Wed, 27 Dec 2023 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLWqnPXXqj/+Tx208pO1CddN+VCrmKkAB924WdJcoyweTAgRXxLZTtNMGO7SzB8JBdxTyRYaD/Q6mJ35zTRVATAOkG/A0yiaY8LO13i0LYr/sOSYXHu1f89HSSFxK8SkmHyEuz79xAeSFgZrw4F2LzYV9iwzx0lLhbHKd4Tt4Nstq8xKk2P9WPJ1Wh/u6qfQeGb+yWHC1g0c4PwCvRmEMqSgL0wOeXugxB4pKciROpHsAZwmHmL+g+dV/F11I5Zqia3dVrU+iiIPfBCZE8fYngezdR2IjtzqCBCTYbbebguGCrJbp9lgOQUotFzgh5FOr8DbIkvSuZhXHUiwAjDRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pouqXGwboygEHGEyEH0UcBGMdn3xWvJFgCWv7qfcMzg=;
 b=ToEsJ0ir63eXajvlNUxOZ3wSsDdQTj6XV1DA5GEfl5nbjuVRi4AeQXuEkxNj1mCx0AQMg8uirM4TpufNhdC5jGzQyUq8QUAzQ37mWfxN0lUnp8Y/oJTRWlFU7p6Ezjsvzj68e7KJR0kwJhRBXffdNR5Ah/wRZvQ4lpnilLkNtyxtmP3Qf3IOcy4QVprmizMbckIY4KQz8dvh/Bun1wg+y9qwbokaY79yGPtbKHR1y1p6hub5M7HmpTL3Yzom6KyeXMouFsVN6LXW63tZG7tZl0fsBLKAJLSiribANhGQqxSERfAHnM6tRs/ypPlZnO4W1g9SJABGnCl951a/N+rmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pouqXGwboygEHGEyEH0UcBGMdn3xWvJFgCWv7qfcMzg=;
 b=e/QdcYeIoBZ/rUqYbaL7PW4aLL3wJciFxbCCSQmN5nzllxWdQ/wCt66PWCOh0eVl6g1/cxhlRh8ZE58gVQO2kfgin4uwnxBGr7G/vIAtsLt8f5CbdU0fx7roaKM5I+p7K4Z2/uFDyDrsQOkqVyv6gl0VIqsNFdKVSwyHMbAOTMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:58 +0000
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
Subject: [PATCH v7 13/16] PCI: imx6: Clean up get addr_space code
Date: Wed, 27 Dec 2023 13:27:24 -0500
Message-Id: <20231227182727.1747435-14-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2147a8d3-9d2a-48df-5b84-08dc0709b0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JCLNRTPv87Qrst+9KLNGvKXi+S8oXe4EyK4Lh7bmb+cv4ebm7Xt77azr5SAmtgjoPJ+F22SbczWqkRVK1OXgOzsirFeHL2EBbBmdoDpNItflMMUztpw2SIWv3RNK8KlOWW17BPq8pa3HcF7rkBoufZfCwY+MtKovKCvl5ZihQ1keH7meZH93T0+bclKSjMNg7Y12yPNaa2MDj2MOfVtq5KqLUVnA2ZbujAnyqAycmFmWy+Zi4P2/Z5F3nefRmZhRjEcyjyQ6Mwdq5TcYmBgQsaANoaNeetp54+J43Xevla6+z8mgoB+nTo7B22kOs46aW4onRVhrTWQ4nMrov3QYQjm2hDUoXx6nFasU0fvtnuLjXOzxyn/ltSW3FHYagA+tcNtg9csjFU8osnA/7hHHSOvOESlWyTiPW9pdS4Ub4IdWOZlwaf1ViMCBKwxPL/SZ1qt0nU9FyG0agGWsnSWTmtkHqkRd2ZNBochXH9qpIUNE+vL8WpdoeyvV+Qpr405LImtbKjPAVU0Nx9Xdso+GCMSqnX9TToNGUwiv+Djb45m4LrczyXxMEww7E6igGG0tTV5BQ56Y4a0BN9kLd2VlVTvEP6yaO32Rf2bJcErvofyJmeD49CkwazxvZoMZ/BZU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCnbbb39zlxNL9IHmBiOxmmOFakr+IqIZSNgXEqK7UZsapjaOK63gyC912Tg?=
 =?us-ascii?Q?YQFA9wiw0/tJaem8x5NFm5IKklY0ySDsElED/2jAzYRfOoy8lsJLfOq/e4PO?=
 =?us-ascii?Q?G0yukyuSOp0En17/OICfotDy/yuJXQ8bJjI+jAFiBb2yAf4Gs77mgFEuJ/NT?=
 =?us-ascii?Q?40YMxA02DvlFguW0w9GS5OxsoZPP5+6LpK20tS9oJuqewcUtFN0ZwR6eAsEb?=
 =?us-ascii?Q?m09wGTU55ngwAQkEjStFs4bR9/rcg1MJc9qh3h3inFX+mBsjkROXNoLT3CbB?=
 =?us-ascii?Q?Sxeomi+ruPaRHmO2E4Z5H6eVNt02cZCOlGA2Njl6vNwQFhd+KEHrlGRm/iMa?=
 =?us-ascii?Q?JIQp9LxZsu0pg+HJl9POtpsi0nnlSDZGI+ef0ILU9zPN19YCJU1k+w4n7JGS?=
 =?us-ascii?Q?xLZQrYHp2lvMVaYIZ/W2xcxIbSQyXPm7afjixIMXu3gYzTBU0lNKEM0EGYIk?=
 =?us-ascii?Q?1PyOIU7yHcS4JDHw7Kt5vt0sK69pEJqi/W5/O3ER//bM+yWD883uY4GxplRT?=
 =?us-ascii?Q?p3OfBnDUVRSlGqLfTNQQxPDRHql8+YUOoDI+yfwglgzN+G989abUBtu/QTGs?=
 =?us-ascii?Q?cpGlBGGSxSOBVaEUXi4DrR1CUSn3M7LGRA0UOBMSWLUb2YVhEhlZelMn7vbl?=
 =?us-ascii?Q?cy4SI22uUPtj+9TVJAWE0+bN9r43myl0txRcbndtxMPn8Op/hCTsFSBgSPKG?=
 =?us-ascii?Q?9j0To1DMJ7L/ijNSjtg44C2k1/8STorJIC7WXDxECOCxGwT65BYhb9r04T0/?=
 =?us-ascii?Q?c9uMlbcbRvUdj9yJM7ZPPeiauBFTVmImmP1LNJCbLRjN2mwWo+bGMs5hG4UT?=
 =?us-ascii?Q?rop62yWJDqzfF1aXH1Il0mDrhBM0uI5rW2mhVLqp7gjzOP+z+GkdzQRDTjQN?=
 =?us-ascii?Q?X0WBvmbnNlJgU6XbJIt45WlXC/4VeH2CUX4T1Z2ZVOpQPQD6aCksP9t631rT?=
 =?us-ascii?Q?cSEsk+07NBw3Lb0A7sfqy7zg8Si7niEywY8ZE/080zGevhDF8xdLSwn60Qm4?=
 =?us-ascii?Q?DMo/ubTWcgn0qlqCqWQ2Kz3NeFW0x+Th0z38uH3qhWCs/MPhTCot0b/IWeLK?=
 =?us-ascii?Q?3l4Sw132GBWbJZs/GlqVA2vPzRouvN5YGPpbwS/wMEyOKXvdut5mzK8NgPAI?=
 =?us-ascii?Q?IMIFYbnQYty8FMXpPCPSlfq/Q6UTEE/62j6oEm0ys5JqXyCweSt0BO3fdXv6?=
 =?us-ascii?Q?7IOxQhbLiwWhrwnZMfoU9337+Nte9PUTEhX67fb9eE/2u2pRDNcXkNCv+N4p?=
 =?us-ascii?Q?c75Sh+MZ8AEBY/S4rAeGLkOEV/Alq2eSlv7ZA6E0pcRQlu+X4IAm0K3girvi?=
 =?us-ascii?Q?ajH0TaYMiDuRocHLF4SV2u/9WhKaw4rTYK5mWEBLoWqidqX5xzpB2R0cu3eR?=
 =?us-ascii?Q?dBRXkhsNQ/qmrKGl3/ZkGvlmsS43wJ1S5Q4CSj5R6gc5v+yvSX/0CbgCdbCJ?=
 =?us-ascii?Q?LyKA2BEmNNzk98TNU60oal8uiEzLEZuBoaQqPIPm/OI+zFs69v4McZcyWUTJ?=
 =?us-ascii?Q?szgkC2PELxZ3uCfSS38VXnjT/q0DB/nKa6ZlKiSR87r/GkN8ZwMIuloRHHlf?=
 =?us-ascii?Q?uTf96NApvJVivzowgwc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2147a8d3-9d2a-48df-5b84-08dc0709b0c5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:58.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbbWFmsxdDyDS7Ce0g/HqvoIUpfY3eTv+KFFnIr//vDpEUy+ll4j5wYN0dN/lbwIBWDEYQRDcR7HeR6wgAVg9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

The common dw_pcie_ep_init() already do the same thing. Needn't platform
driver do it again.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patches

 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9e60ab6f1885a..4b2b9aafad1b4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1080,7 +1080,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct resource *res;
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
@@ -1099,14 +1098,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		pcie_dbi2_offset = SZ_4K;
 		break;
 	}
-	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
-	if (!res)
-		return -EINVAL;
 
-	ep->phys_base = res->start;
-	ep->addr_size = resource_size(res);
-	ep->page_size = SZ_64K;
+	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
 
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
-- 
2.34.1


