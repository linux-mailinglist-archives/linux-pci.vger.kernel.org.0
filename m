Return-Path: <linux-pci+bounces-1114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06392815D97
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD51F223FA
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DE15CE;
	Sun, 17 Dec 2023 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ojdznu8P"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54528101F0;
	Sun, 17 Dec 2023 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxkOq7GVpxbbAWhDl0i/Q1bdK7vY5pnM/AzKLriypux/aOMFcGcVFAK5wru/+QYeaWeMoDFQ6sFElc8SiNnVX88tnVA/LXqAedXlc3LYRus/bnrWp46gHU7DjhFs5ZzYTs16MyE8kosOE4ivr6rVMh0Kh2ajQfDE19wWamVDuxU7BqBf6zx3exxvlv/KDMMxOxdbyMpMlviXI2yYW+l55nVfr+OrZNEzqsP2ICII6pR8pr0TjIv8wJdvt5QSCE1Ge5WnA7+7mSkMmDXF9sHQcfpEK7AZWyj930c3o60mRflQtAJaEKVHK96rdcFu45gyGk+Z8GK4VN1rNAvUVIoL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huxzAgtOfR8eufcHlwd/FrJVMvnlcg7jp5zNfrc5qrM=;
 b=JjgvEn3BWdZKn7yLh5b6hJgRi1slA6f1JHR27q6RtaynVddUMWnFgDiWP6BUoSaB9YDbvvqzgeaY0+lbjHnd3MDJ3yrJn/Zw9OJVrj09IzpYUEwOjptWWp2rPFv1FXAsM2n0J+xGXLoGSaeozml16+FHSHLapLUTlwKTvLZxQRXZlYvNd3cECRSCBgQFlsqG2N7umebdcl45Bhqt/AGifyAPja6kl69UsT3GE8i2zy01uFsLC9p9UpCJXsTb8+shtvIxT+DxmfVbSaWUgH3vK3YlEN/v3ZxoZKeSqid3lpTRLtNsMZv+tti6Jbstyz74wZuHBgQK7Bj9tMb3lTwvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huxzAgtOfR8eufcHlwd/FrJVMvnlcg7jp5zNfrc5qrM=;
 b=Ojdznu8PRfK/bk0MaoB2KFVlg67giuQ8P3N56RNmnOSkNdFtyiB4Pivkks7EDmnsmiXUvALo7mo0Te1ojAYomaiJ3JIu4qeb6GCxYxabgabuNkCcqLr/Vap5ey7j1qZxpFKzP19r/g58Z/B+P4q0LtwZf5yyoBsmu2XcqJYXylE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:36 +0000
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
Subject: [PATCH v4 12/15] PCI: imx6: Clean up get addr_space code
Date: Sun, 17 Dec 2023 00:12:07 -0500
Message-Id: <20231217051210.754832-13-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e91e04a-d210-4959-9ced-08dbfebeec18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y2YDxLxjUMExj7DJPqfI2Fw0RmxNXHCDsf1wKoHYCr2S7uCUTkSgn/Hg5nkfvHaG7Prk5gq13Z4HV3rRK5Z5J8x5fU2WWQPfzkprbdTjvqZDzsuKypUkFtX0MgdfatJFQcmY3cY4wvQz3VBOQ76MP9gqEtTACJL/lgjhb2aT5Ij0idkPN25HGYuPaWKPV+BtooOZLmBCROvR8nP/RNL/BGCpzlC5kwDTKyvoacZb6QFd9qkC4Um0m54aPZ2rEMWX5VZzaWON1abcfDnRGEiJAX3eFOktKZZT2QdhtSrlOlJS490PnozQ+jfRkrkD1fmEWwzTT9rv7fHsBhgmyToLdEp7xHLw6k7hF/GJD35+dJeETHAn498+StAZ3aeaPldCYrpzvuK/A7ZqxULdH9PBc8KbYtNOHC8VulFcLVhwWKwCDcujjwe4dkjACuhCYGh6GFMVStuOgGSZDmRBk5LJTXQ4phW1uqrX/DM/+AK4kUKPJuKwnkvedVBsJaM8Qjc0TIo/TpYrfz3vA9pISSLB9arvxq7/bjo8uovqFUFYSK2U9PhvICfZkfMcSDIRaPZbwVocD4NOwUETmXsHJUnxyfI9MhYFf77ebS/B3oVJ8iLXFF6N1uZ3oPZSNuRX7jHJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IJ3j7R+LR6ONaqVlybREoKWZAnkIzGsQT8Wcn+Fwuh5uuCfVnIEyD/W7ThRx?=
 =?us-ascii?Q?ZzxKSDQJ0mc2YIqSTZyD7JRyQHfCV7HSHIZBl4kRNtRyHd6c2F8fPNFIJbGP?=
 =?us-ascii?Q?AA+ZXo0rTC3cuQ4jxj9KiIogufGnt6Vqa04S8KY0Jbl6cqMwG9Bt7WGCdnhS?=
 =?us-ascii?Q?INVTTuS5j78fWFFvGQEfnMbvsqbMAl1Z10xqFW6thmFNuhmbioHeFy4bPPlH?=
 =?us-ascii?Q?ZO6r5Mvlrvh8AqgNvvI3XCV93DckRI3HD3SyZY7qASo86gqkHKdTUz8FIvs0?=
 =?us-ascii?Q?aHImoJ1GjJtDsy4VDevkjGhtbhaHoRn+IPawL1UcO4ZOWsQYn2kOlUlP9VTx?=
 =?us-ascii?Q?4Z69wrktBDNBz/YRADByK3adVxOv7Pi1Nm/C0421au++OPApNyy+c6ldGDDT?=
 =?us-ascii?Q?y8PmG6oelKWLuSWyVx+fiNWQY5tHKDgmVDwuWQoYjQY+nX40UNn7U5ZrrYui?=
 =?us-ascii?Q?y0+fx95Ik6GaDb4H5DAPLma2rkT+52XQ4J6Q30UjuN+hmEmnObfck+DV5Bd9?=
 =?us-ascii?Q?2Qpe0pO5nfsASUl7HElX58Ho/yp8dAjRVdQhSx4LVlguZUy92CrdJ6RpKywj?=
 =?us-ascii?Q?xN0v978gvxo3qrt2NXUg3zMlvERiwN09ADp+pJwQkkyt6CKL0BAtVXcMFxcF?=
 =?us-ascii?Q?tqtwBNsUSOe//oGulMgT6HUz0ryesRbOOANYq21Aa5gSC2qpJya7yRb676c7?=
 =?us-ascii?Q?mmgIOsFjxuyEWcNUqWuWHfuWU3bxhLSBFUxeCAGeLeFYJ6OG/sWz+FcR+m6j?=
 =?us-ascii?Q?UPDfaOm9UMWMLD65ESfMcNb5YUK3gMkOVR7BuqmyG3YOZSvddFaxm1TiHrme?=
 =?us-ascii?Q?0ZFA2dT3pDf7abICLucZRMQJ2odfQBemgt46q3fPCrB4CUdoU0RnVY5PuGQi?=
 =?us-ascii?Q?+BpG7VCjwC7RCqxXE0mcBUW74tdV+ebi0I2jeInvYUzUpKpVQPln994yk99B?=
 =?us-ascii?Q?65u6E4WtSIxSLxa7UYh50ibG047C7QuIZmVlY5HKqNVunTa9BjUwkkw47uBf?=
 =?us-ascii?Q?wB3joVVSU7mhCaShiZ+Iq4s+quOfn7dROeqs2OEJW1f2JNeqOtu4MZW+hA4U?=
 =?us-ascii?Q?CFmc9DfnLTcGGj/SkEAKjcnYdeMdL0sDBbs2U0T0LEn+H5vylMjf/8sXmdzz?=
 =?us-ascii?Q?MZZTIS8qqPs4DGypFDnellpodpcCPo/+0nzMue9ZWnr0YC9QeKD95H2Dujhn?=
 =?us-ascii?Q?Qu88XwMx3haibWxRybuJ3rur/uSttTfQWbNtg8bbaaMPfm1L/5dgFGkAsjti?=
 =?us-ascii?Q?zgXuQ0N0WLcKRMA62WjvB/60i4px56B1x5cMP4qvYE5WhMFtDr9u3HdW9yzM?=
 =?us-ascii?Q?34goPxW7nRlTZOe/0KHz62Tkzw90rmQSipKF22ltJ8+a+HkI2NJXj+OwQXIC?=
 =?us-ascii?Q?65Sq/RtRV5+rwYBwGZLS+lRMLYVJsMlEV2gH0QSJxCn4IhOdslelctB5PLiY?=
 =?us-ascii?Q?rnYoQI3DEz1Pn0wBnBtpjLm0BXZSwogD2+lkRbh2Muuuuh65vP8IKllVvm/o?=
 =?us-ascii?Q?SRmuIczeK1w/xOQ0NpsUsLZN2bWA1Kxdax4++Z192eTAAh/sn+/q6M3UVcaQ?=
 =?us-ascii?Q?c6CCkDZgqvddL9h3C6c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e91e04a-d210-4959-9ced-08dbfebeec18
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:36.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKsIdPfVxVdKMfq0RAGXISRzTrUYnqOA2rG4UiHjd6t4jCI5Mmp72kQMmDZJ7CUt6/v9R+dQUbxcc1uOdpDv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

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
index 324c62cecfa5f..54b90f8576915 100644
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


