Return-Path: <linux-pci+bounces-1354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BAB81DBF0
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87691F218B2
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC2FC12;
	Sun, 24 Dec 2023 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EHmxOYAh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7DE182A7;
	Sun, 24 Dec 2023 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kujnsLJzML297aIYC9J/7ol75kkEJtNEfgSqblcJaKfodqNY65FuU9poQ2rEVtPYRJpvbPL/jra0OOyHFQLhgVDnDzImhrlaHSgN8SpLinBRy8OrKZ+Zx7QHtcNig/8KR8BJOGPR/xHHIyAAI/tPnChmBknjLsYMw4y7rJAwSrFsvrPjq9obddGwMr8owAj+U2k2/Ti1dPSXvpdvTt/ZwUpQdUm+6wtDWX53nf0q4a4hXjO/Luvy2hVHfeoA3xVlmbJkafa00QUWimTwJkhTm+Xswfc3SP/B++yIC/0auyCStJ1SaNJwim9PzhRXsbrOCpmNN8LDV8fAfuHPrP2pdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pouqXGwboygEHGEyEH0UcBGMdn3xWvJFgCWv7qfcMzg=;
 b=lG3j29C7KXzS8tmW36+2yV6SOx7ud49kv+WcOA2qDpxtsQBuKULud7ancxsJyuulYDRvMp5i5eK1m6LbHG5m6IdyFhNu6M8Ej9JdAU25mLeWpEgZ99rCjiRV4Fh1sNT5n/TqevOqDhM6g1rwY0J1P7Uv+Cn8qKJeScgjXVXTT/t6k8wAVLnOMMf5e/H0LBuepG3thlwFQW/1yowqRtTfwjh7y8F3heH4xbpMPekme2uyNgLz+6T5+2owa4dP1ZA7zgpwdKcnMJEFZiYQPMBXSjJTpqUkhzVmXrUo59BzZq7wEgj0vXSXUTQfSSz0fOQJOtu6m+94LlTObQmcqXsAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pouqXGwboygEHGEyEH0UcBGMdn3xWvJFgCWv7qfcMzg=;
 b=EHmxOYAhybhkAEcNPNWkuQGiQU2eywU0vzwQfQB4uvyqnu4QckA+8ef155bSLbVI01NoP6yHd/rcPeLE2mv5KrbiGT5+s1IP8/RkX/HzIG86nZkbRW1aKM8+zG4otk1UVqbdGCqgtOuiLan3lsKH0BrocaW7Ec/z2jtKezyYhAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:34:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:34:10 +0000
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
Subject: [PATCH v6 13/16] PCI: imx6: Clean up get addr_space code
Date: Sun, 24 Dec 2023 13:32:39 -0500
Message-Id: <20231224183242.1675372-14-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 269a5393-62bc-4ee8-ed00-08dc04aeebc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	90DU2PkWJx3kv/VfXXnbrEAgPrcvMYV1eE9Fw6WVP1O0gP9kF2eN4Kl6Q2L+RolGsqJhJo8x9URiYBCO0spLjdUvJo5A7D2EezgFev6VUZkhafYpa235Db9B/TFeZ2knHNC/LeGMrBvnxQ3Ty++suQUQ6YQ4JAw1xOPBQQpdxBt551js4pPwVXKAURCHK5d7YNVWn5F11sdZHZF4gsImi3JeHrSnnsKKsyQx2ztn8uRHfaza4KE1C9y/Gd4hmhrk7OEQZaVExNVWCzH6LYoHfDsKGcuVDCHOeoknbD/HT1VASg/ZhN2FiFSIsIsFz0hHkblc0PnhPGEhT6bQDH1WeOuA+Ee9kqFgM3SLPboi98BG/AosjubKSMHZCEZBB3SUHfus0UsP5i4PtvHfsB0pENFHV2aFrsV8VykKio3PkulDlbEF817IChY342LROu0vVq0mays7a5QWfthqEF55nJi4ZgUXZT1to7rtJ/iDQ+fBbgKFDMOGc3twA9N33d7LQGUN9bOfN5abIsrUJDLO4qaBBKgOKiqg950hxyBhKA+Wf6VZ/uR0oxbl3ur5s0ljARFlLnNIMKI+q/7F3JCcNp6G3lxDufXzditzjwzBvsxXZQctA8ouZjAX+DXjUfEG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xNGadCEpXySaa1Mfx5yRD02Bx+J4gwixPeZfxb79yYBn5zCtWMksG5LA+ULu?=
 =?us-ascii?Q?VYmqarC7H58AkMK9eiiv+Kx2ju105I9YCG+UZ7AFrEjNGvRAIl53A0S7K6lR?=
 =?us-ascii?Q?LSi4mFrm9Vg653AIIIGQ9obJ3UMmXeSwXwGAMR9086dDRzOLTlEubQXDw6Se?=
 =?us-ascii?Q?Sg6KRBjrFyHvZm2FBKES5NU6TrkpUEPIOWtyWXn3LJydlsacrV4/xhqz2+Sl?=
 =?us-ascii?Q?uJa4V8akUb6Qq9qGHSx74gm4aEkCJhokwGve87pTuQCYlK2VtBPzVxvFABvl?=
 =?us-ascii?Q?5IBrCzP2fApyrbzfnMM29XZacgl5RQJgAuql2HqS7YyBnUhcm2Q8RVXXpOLJ?=
 =?us-ascii?Q?N9VoCe8UFNyEfL2MABiMK1fcw6fWafXiKJvyLimjWtlg2d4RaSp/Jz8HJJXV?=
 =?us-ascii?Q?mjMZ2h8quANz1ZNjYc7YC9PQmuoiHpwGsBgc5ihc88kKKiASRanYJAWcxAIo?=
 =?us-ascii?Q?NHD05d+nLWHFBBhMMINIfFHBvbmpURkyjINU1CL+LywefP2ORddXu2ccuwnd?=
 =?us-ascii?Q?lzBossvB8XNR9fEKsLytE7GG9mX4FQX1LBpDcF4ADiwP0OGse+3L6OEfZvlR?=
 =?us-ascii?Q?tpqCZ34ZpI3jnTV0t1S/Jqyt6391pq0PQUNjmJ6IdsbVE39YrkPTx9T9K55A?=
 =?us-ascii?Q?YHbGXg+wY4bnAQCnnJLx0ZxuwdzziaWg6zAl/Jyef6KKz9ovQwg4bHa8vgy9?=
 =?us-ascii?Q?brtjbCmhllfu7N2Egk2RMRP8Yy5NYxuAt1CEeH4L8hnbbgtlyVBJilLTTO4A?=
 =?us-ascii?Q?510Uu1ICznaVgRuD515Xz+ABfpKTEuV0bQB2RVbTlb9dqLMgGNSBdQoEScWw?=
 =?us-ascii?Q?UpLUdWGcDrRBjU3/OaxcoQhIezsDm3nxsvhLMu4atwyeg0EIpaDmWQCkgZ38?=
 =?us-ascii?Q?lxAKZXjN3R7FjTTJ+fZoNF31pk0eyEhX7mXjr3JNFyydkQRCSLvHagBuJLbv?=
 =?us-ascii?Q?uuQO6jzlO03NNTdGpNU8tT5p7qkzJPDirsvzUK0cr8M06HuOHMz7GVgpPmHf?=
 =?us-ascii?Q?6biuCuFp+tqG/OwBhOBO/dDl5FVq7TnivwJF18H0oXitPxlEuD2tdMdqpvvx?=
 =?us-ascii?Q?vVNZhSMAcM+OrkK+dCgl2fKOTs6VIel2HyoMspM1UPjkh2ZE9L4z9D0mpLVj?=
 =?us-ascii?Q?+O1xxIV7FezzLLlvbKXGzuRSxTs8mQxWvKqLq21Cc4R4vzoiad0v2xutQlaH?=
 =?us-ascii?Q?BhH1zFcwj3+0sKwZ1SInMCZFMpKToTZCUvB5RetuJuRog5X62Y3Gj/ry6W7q?=
 =?us-ascii?Q?3Y4Te8C71kOM1SA8HigqgHo7JD2gpFa3X2y+VLc2/S2PLVyj8VBj2UalI9M5?=
 =?us-ascii?Q?CNokZVYQQDGPrAkavXXNXnVS/L099h6S0Jlhjuv41DUBB6Tkq4aiIl3WOx17?=
 =?us-ascii?Q?R/zhzSOgI4gJgFPwaZz7w0c3nSTnSNDtkII0hlZUqpQeow5vGwwwQIcIatXn?=
 =?us-ascii?Q?21D2eIqmODQMUgYmdJIufxC1AeApQzuEkXUYkxYvkdsiv79uOaU03VwXpoi0?=
 =?us-ascii?Q?omsZtvh6SfKTReYcCEq3o7FmysskosH0fLF9GMIttohQ446CL4L5oNfa5W/a?=
 =?us-ascii?Q?QXD+5Gl9uzXMfTC/Ti4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269a5393-62bc-4ee8-ed00-08dc04aeebc2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:34:10.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D22rRk2JWjoqhVKOmQN4guxKt36/oP1G/gqOMm6UzY0VDQgDK6kerZ2xqdVFxkZyqiZMLK+SrOAiqscJUywquQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


