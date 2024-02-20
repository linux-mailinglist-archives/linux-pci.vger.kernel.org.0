Return-Path: <linux-pci+bounces-3783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7279685C12D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979ED1C21A28
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788A79941;
	Tue, 20 Feb 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fw5PWf/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484877A713;
	Tue, 20 Feb 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446047; cv=fail; b=NzupGmTkHkLLRx+2uVVPwvmOmb5Yf2cw0NY39iJJXuqvy/siIjoUbzijcASp4KjraJhKiDn8QtfZ+nkznz6AZsSxxGzs4kbRl30UbOoDfi+P54l72UsVjvYDoOFgOdBtuwFM7Vqlz64yUXf99WaTceVTkkinIAhkkRddzU8VfZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446047; c=relaxed/simple;
	bh=Xo1DFZV/NdoH187fBr+bZ4zTQ3LPtufk2YnmM9cOJnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RmdnNxwvIZV0F+BDiUYN6hzFLUHq5ojaaZdHwh4V6Vj6LZowNsytR5Y+gO/wqyc/b5ngT8giKEf5Ajz+FPogNWcSaZJ9Y2vz3gOal1aPgxFqUEnJ796X3kQhND3XPbg+Cyvgeob5DxWNxE1eRR5N1aQ1u/rnYiM1xwqCGXhSCWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fw5PWf/R; arc=fail smtp.client-ip=40.107.249.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBvcaxF6van6IT4l3ZEY8H/dOza5dhgL2xnWzIvjhXEK4alIGFpcYzJrn0DXPelKVZE2aGUsJFZp2iFYKyfIMpnjkTW80mohHLy9nKlJ+p5/WkQEWZh71PM4DUfcHe6BiPXMjWdnZLsrV3fu+aezDMe11+rmlYlTeie77yvOIQw+r9WzNDp7yhYRopzhFHsZeSw3NKqWUa2LTaqzNnlyP9RnBXSWOyYXfmNmEqTz5S7MZD4TtB91XY9Ezq3+3UUG4a4lctVRrFXrrOU9JgNBO3craMn6DN+AqPt5J+qW2WDGRsvtGFsdKbf9rzlsYWGE21XQD9p/ngQvrhRoxbN/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ8rmPtlwKUlEL6m3xbs5MpZ8Ok5KVMQlceNwACttyk=;
 b=ZUTZe8FKCrnpIgx2PjcUU89H3wwE3OEbYQVe3NlpfgleLIh2epck7ehkQK3EoI3gTpUu9Ztfjl/GQyvJ9bSU7cioqXeSf7rAyjRGiNM22tTBYh/Q6rmTQ9HNDjtRCuVoaHldFNOj6exwEuMmPZxldhuWcaYOOGlfzGEZuZZEuuhKZbDKP7uP0u3ENIs9QiaSrTY6ClDvATGFYcxc4h7sUFel1kMlaAEF4K4/DqusJ1HSVPHJKwUm3xQqqVGTWH+Y7r5jVxJOrTkQ2rZdTmksqaar5X3lLozKQu3CuUbQUJMzNu6xon3Qdn6fVyKpLq+0kvz69t3j1R47oaGajdEJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ8rmPtlwKUlEL6m3xbs5MpZ8Ok5KVMQlceNwACttyk=;
 b=fw5PWf/RPw8faPUvtg+EZjIonT3uLX5bCAwUqBeNv1KF/0rALdy+LL1M3ZSb3h2Ck05p8y/oOsIN8tpYrE/wU90084kNOncNFRVnHAIa2ASP/rKFj0xCZ8CW9ZnLkBlEqk7r0a+4zJeYzzJUqGjk+UY5zkIMpdExRQiMKEB3Jq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7295.eurprd04.prod.outlook.com (2603:10a6:800:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:20:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:41 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
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
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v11 11/14] PCI: imx6: Clean up get addr_space code
Date: Tue, 20 Feb 2024 11:19:21 -0500
Message-Id: <20240220161924.3871774-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220161924.3871774-1-Frank.Li@nxp.com>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: de002cf2-3ad0-42b7-b123-08dc322fe1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	46O8jZjLC8PVNzzJumXuOkjOrAbYXaj3/aSY2iVSG5wVZlvmGi5X1SMneYgXJxALX1lmsgdg4J3hQtPKwm7QRdMMhMLG6e/4gKv1w/bjvvXCUeHW4vqn6N0QfbA1cWJvpnZlxcfNPs+7flXcjGvRyxNnx6zBa7tSlINYHQlRHCRSLBKbpXGMvIr4/xriRF4N7nhIlErsNcBWHdDo4H+Jw5lSyisvdUDFEsGL363AtAjrKUmxi81wh2sE/vgecQdAi3VEiOl32RdfMeEGfMLlAnlziSqREf3dcTocbBH3ia87Z7jo9s4fU4DStkQInGds1/3rKBd1zddfABLgwFRrO3DGxwvhwhmNo64mTFQ16s6Uex4/y2g2NwvooBXjkAhVnoeJSCpLw00HLNU3xp7rtljJUlMElQbKbuXUGH+pcpaBCrnyUUleLh3RSDRcVt27HTx1MHN+HAQUI9vcLk0rxNRkRDeA5LP+rC1NWs1k9EZm+JQWhyiUaCCrCZStKFUH5xrkxz+RgMkXBAtZ/cRDYP6kSTojENRtbkMc04lHOjBpNiLYqRbxMU3johZgVqjuSuV2+Afsz1ZmdF3A1xf5HtQUI3UvEBTmGVwRDzqn/7SRmqlDXvFUJbCGpD0/eHVc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tSwQqC7dVQE7kYV4tzEHt4QM23TYCwGyZRLCE3EINUfgjiU3jiBwyRNukoRD?=
 =?us-ascii?Q?EpRKSCrVijzuETIbe8edd7YSCYmoKHnuwUCgnjHUcOdUIHPdWt9OAvgeJauM?=
 =?us-ascii?Q?Jx3WhEf7PqMGofY+SVz4YKXmvcHn6lWKzhL1BW7t+J1MOC0PRgimdUDC5eyE?=
 =?us-ascii?Q?WZqXtSVlUQRDAXVVSXRkQ0NX0FHXleK84RrxkrL5FVQd1XhfSWoMd4y6m790?=
 =?us-ascii?Q?LOrud43ZNOEVKABDC69DcAXSM61PD1yjN1xpUGGRgzPFhYGjHErpeY96KEJd?=
 =?us-ascii?Q?YQayuZbURTNUJu+X2D2F95+0xs+YUwZJF0xocEIvhNarM40ObnXCswt0EPGf?=
 =?us-ascii?Q?PxJAGGxb6Pd0AJtPSRB5fIsXuaINO+KwOSV/LqtejVqmIRQKhpV+g02XWnEM?=
 =?us-ascii?Q?eMV/LM8hlKKWGM+uooBuAgilHgUllgPaPv2jNihhhuPicfc4uo8667uXa9J0?=
 =?us-ascii?Q?jEKVPnx37F7i+gievKKTdJ87mWiqe/R9XUVYOvfHDIxpKNjdU+AJzmmMAAS9?=
 =?us-ascii?Q?oPv08+xN+8AF0+b+vDmcWoIyfxzPED5c0B0xc91m+8T7ogm+c5gyhPbG+8vL?=
 =?us-ascii?Q?AUIcjtlJCIAQm2QqQJgaLjyKCg9H9e+ma7TCvOO2qMOQBfkKNJDtpl5FpkRP?=
 =?us-ascii?Q?1hVVPFr2BkicsVwPPXXUJezLxon5bTvQfovD6jnWxLENgMuEsXgtF4k1Fdfa?=
 =?us-ascii?Q?zNcV/L4z0pnAPX5YOVUiuYWip3v/gvqt1t8UXXIjjgW0n/R3VVF3Rt5iG7Zn?=
 =?us-ascii?Q?3AOGEbtEkpPNB8ZF/yyQWGK+UfuCeln/BcPSZUOIcEkHlSiIgVxld8suYnYK?=
 =?us-ascii?Q?kB+2yqb5tE9taiHAjQgAQiv4z7MjDI486V3OsFAY2F7kgSCgMYOneg04AOfu?=
 =?us-ascii?Q?+TFU3AodFpzGbfJviW+2epA3+1fJdj6nipEYndiMDlA3csB/vTYGscw0NWa8?=
 =?us-ascii?Q?wpIA5JkhHP0LvRI1v0k1cnmTjTO3DZlRtGeqrCBNeWvXKY69QLDCLenjrgQ7?=
 =?us-ascii?Q?m2XTuswr83SY2WJojz0zDclruq3tRTWn++Ok8tnAfF9+fVPGVNJz5TW490NO?=
 =?us-ascii?Q?8rcmn+SjU9Ua9Sd6IMi/U7tkGlmBkRYo6JpSPFTRsVSU1vvgFhfvCSuwCNOu?=
 =?us-ascii?Q?pRgOwsbD8aIfP90czHScwN/8mMLmQzo0WoiM8miEHvBzbv33pOLlhy1BGFbF?=
 =?us-ascii?Q?4UYO+eayljO/ucMhZE7bdcv5/UnjxvO+f8gH5lR3l7YRTgg60wZahPK2W58U?=
 =?us-ascii?Q?73sVobwXlxMtfvyfraFyLoLj8MXDI1/xzO/2SbiLvFD8anGZj/m3a2XS3fK3?=
 =?us-ascii?Q?LsO7ctVyR5Qb0PH8W0l0OOoxdl6jtPJvCQf/B+TKYSxjU2t+Ebbv79MnvjrA?=
 =?us-ascii?Q?lxWtQbn29C8tZArDO39FXeTrJvi/z0WPZbNmeJ31iLAQNbpcFR7dJ4W3XI8g?=
 =?us-ascii?Q?B/v57jbyQK6BHllNUYv0mbevE520dVSOwV8TA7yfPayZf5y3ZMx99od/D6F5?=
 =?us-ascii?Q?3tKKDSeVpaQiC4CXG7wHJ0VLn25x22jonRdJWdTACMgd2WQ+ydHTTU0HTEtq?=
 =?us-ascii?Q?x22B+owRD2rULChxld7hWfmGY6KScTJm/mXOuLNy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de002cf2-3ad0-42b7-b123-08dc322fe1fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:41.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sG/quSK4CnUZRUq34zy1RQ5cgeOqNr7vV4ig1MVJof92weIY+svNRaKkxLWXBTAyfhHuDSoSdG67C2az/x2w3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7295

Since the dw_pcie_ep_init() function is already fetching the 'addr_space'
region, no need to do the same in this driver.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - update commit message
    - Add Manivannan Sadhasivam's review tag
    Change from v4 to v7
    - none
    Change from v1 to v3
    - new patches

 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 582ba00d628a1..3009c3ffa1415 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1068,7 +1068,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct resource *res;
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
@@ -1087,14 +1086,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
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


