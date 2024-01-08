Return-Path: <linux-pci+bounces-1851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3453827B87
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B38F283220
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38B756472;
	Mon,  8 Jan 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nioc+jll"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549458225;
	Mon,  8 Jan 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuW9fhDL4NOQxacUAVDcwBXQi6xVYOFLLHPxuJ4QTQjFRkWiJiKBcSJVUNKD/Otghj7mR3D3F7VLFubF6VPa6QiHErJPnmMpJsw4SQJzYLrfF7JdIknGdtm96UmGylaJqTsfLJOOGpMMdK/mQ+YgiC/K2OGk1nLD1f/rZS4qMbzFRsa4gwkC7R0Ngf7bmIGVGV7VzG3iGoIRYq8qd1aJ5Mei/bIj07HQk20OYpy/dqHZe8FBwOwAdGvulCXezGHdHL3SklQY6E0mh81A+x42ljhzQNQGH7Cy1F6ow+CaU1lAdgba8aqhbSI01YHT+6mSKcB1nVOaqSZ5Kabm/Wejzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS8GOBtjyYsM5TTt9VOeMwD3uwYQ9z5yK4nGqHNF3Ww=;
 b=W0BXGgQK1dgPesKlyEtudh8t1MulB/i/5YNlQM2pLc5f9UKEjZy/ZszRivN6GAVN3LqGCciqYgwszgW2JLtmuWAqYhGHRRmdHT5CoCatrFpQWzxRDxoRg80bfGrSfr165FM9Li/78l8/h2lg9/5w1D1Hk7rgS1HD3N107j6vIFaB1QWSodzX8ENLXr3gWr2jG1Lxr0LItT2oIxvPZ+ZLbSqAnzRj7x+Hg6VMTa67ViN98p8rSqVQtlfoZK7t8Ri41hkLMHILjXu0IevJCnkujmwKo7gf3IZdTrNiXiysN4UW/Ocnm+TyVJuK7qfbZgesuOu1RVFniJOlPz5WhlWgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS8GOBtjyYsM5TTt9VOeMwD3uwYQ9z5yK4nGqHNF3Ww=;
 b=nioc+jllbinh/5eHj8DPwTC8uF3zPbT+HweX93OlSDWWQN+EG1c9ksgSeIzl0vFevlaJoMtWz8Xr6+2a9DD2qKK5p4w+1lcOXo2jp45kSLpXlvD9mL+Fe7+GqgAt4TEK2u50gBJ6BedM+HZVPCKq/XDSXDZpADa8K7f5zWXYXXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:23:15 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:23:15 +0000
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
Subject: [PATCH v8 13/16] PCI: imx6: Clean up get addr_space code
Date: Mon,  8 Jan 2024 18:21:42 -0500
Message-Id: <20240108232145.2116455-14-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 9010b052-e6f6-4825-22e3-08dc10a0ca0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ui3GAbNUcqP+dexQrFBe/z64EJGtTtRyCIrKjNJl6wsgd+L8qDPVUaOuYqY5zlNluXqY/nIhslz0W6LtoSGbIYx0UgXvpAZU+qWJO/sDIJrMB5AULPSH5yhw8HW9dYikkolUjXU+rCbXxlj1ZN6UN89sYwz2ib5g7x9yqlTTpZY0/8RiAEoUG8+SHji+e8dZXompcdX/KtBV5cZss/6tekU20/y2yqe0opRzu80U/XAaLf9OtIm/VJS6C74M08CAODZNYX5negezxnyt8zWub7ztlGXksOMN8n0k/KdWz3OzlX7RdS4vOmBK7FcDZMfjHCJoPbsbw1eRW1ZhPELc5aehhKT2GbXGeoasT9PImIT5FUoh2JBWgU+A8IqTOK68YJdFe19c/dHszeMyT8AK1UYkQjz19/qih2ls+LMwoJNiONcPfw3sRwfezjx/t9E7W8f1Yi928esTvYOPA041pnk14AtCVZKIV3wt1YX/C+SvVddSVE1tcO7T4hJHoHbu/sNg4C9Wzj3HN/D1a7osIPR4pQq9RvHKW0S7TBkhYUCi0T2VxPYyMOvO0cWvU0YoxPqch3qUVarh2CsKpLHnv3Ne4N99FzxKKp+z1ZMUhfU0wJMjEYToQ8DXfdR7ykEH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K/SZ5BkdA+5vW5+Yd0EhvyETMueHkGyAc0jRp2OY5s7dOopl5X0TEqUtZfmp?=
 =?us-ascii?Q?ACtFO3yOmoGDSPXPdL7pWEeS4u7NXTzoSa6JKfB/vEUyUv5UGcaUhb75Flfm?=
 =?us-ascii?Q?A16FV6VP9VzgrDH08yOOKuKLZ6uSF2iWBQRSoJ+Rx8Btq0ZSVn0Zcy5R3c2a?=
 =?us-ascii?Q?3D4dzKLCPv+yIO76+foiYNfya92vTE1EtrcuPatKADhZSaRvf1Gn34HerkWv?=
 =?us-ascii?Q?L5e6wD7vyUkrqf7x+8evUB0oUOU/Eby5rWcuMXZZZc7s59o6DAKYM0/Hk24b?=
 =?us-ascii?Q?Yd9cLKdoBfQDuMoRV1BcV2XUnQjt6DVPPNfyEebmqRtl0/x43ncA1gDRTQ3A?=
 =?us-ascii?Q?28MVeUI3qsohGjmQWMw+4jjgG7hBUtkXgD0kENn5jT/WBWqjMQGQLKSLlKfx?=
 =?us-ascii?Q?7xOKhiTzEU2VdcYlnflgUB6cMqpklKbGJKWH29YnXsSAxZIzIWn7A9d4oVOc?=
 =?us-ascii?Q?pYF1vxTozcODV1OKLkihWL6Z3ayaCkQ1n3luQjjlJVHG2IdpVtRnKfnPoay3?=
 =?us-ascii?Q?Rr+sIoiUDrA2hA22ssIFnO4/fqV4cp9QnrOgXrGTg3nDMRpKE7ap0IYpu/zq?=
 =?us-ascii?Q?fsmLKzo5nZrFCJAcIbEHbp5rlV8NUNS8E2erP7Btq/NQZTLcoNhJkGDI2+e+?=
 =?us-ascii?Q?Aljd5m8ynxldyPwWJXQvi98Auitob6alZZIZhXYIbOklQ/HKiV8No5Hd+CTU?=
 =?us-ascii?Q?CIkpIBniPDQEz579t2d0P0i/B6rY2t5XrHnDdZIN7Hr10hybePU67hL8l0pt?=
 =?us-ascii?Q?w+S1piySygmY/yGvbDM2pV+UYuH4jikTyQdYVh2mtZ0W+Nrt6XlmQbqZA6t4?=
 =?us-ascii?Q?F9wcgbpb+Gy1uHwZeURTQXlvPl6+BSVnvgRMkLHcFX1SCPmVXHI3GC+6rnzI?=
 =?us-ascii?Q?j7Eqe3Uvr9xSIauZv1IGrOqHC1HUS0LyfP+yV82BLIsoM88tY3BreTtVC8eE?=
 =?us-ascii?Q?N6AGGdA3Mh8JB7EB00sbztwpuzvG3ux3sKp/StVvEFL84WlqJNjxyqVqW0cZ?=
 =?us-ascii?Q?wZwID48BNHavG+RAvGQGMVJvTQo3LDGIlYsp90iE7aBQv+Ydl5r3rTF0AqSp?=
 =?us-ascii?Q?mVcBOl5oP4U40QKlrFXWayy7/66pZQtDYVbw4TQuLdROpUrInV5UWvAx2HTE?=
 =?us-ascii?Q?vEqFxDTygaaRBkwHkvhma5eBs6x2BsWlk96aE2gDvC7e3OAb8uRXgEUKaSy4?=
 =?us-ascii?Q?n4tzmd8rpUA/FwrcjBR62tumqZr0eyYmzoZtSqGDwQtdNWs8TdtZudRwbza0?=
 =?us-ascii?Q?lNPHZ41U61rkLJazL+8CX4ezkFLTlPwQhPb/ZvNpIOs9Rb0Lnfxu3brj/hNv?=
 =?us-ascii?Q?zwY96sybSf1u0zikePWS05+v5zkyT8vvXRuVTAX5hEY1Y1MFv2EbH7jPUCqc?=
 =?us-ascii?Q?xUjRwgkvXVarGDZFdzUCBRABPWG4LWqsYYSPvuTVms22fOgP903Cl5RE6ctR?=
 =?us-ascii?Q?WDjVl9vgiv4dd6kDJQcbbvND+xAmxJqTvBx2yGhecJ2woEVHF4wUAWmXSXG8?=
 =?us-ascii?Q?Od5q+NQKMHL9H3VPJydasCBe+N/xUdqC7Ff3QxHs5I1P2efjW1zb2k09IKvT?=
 =?us-ascii?Q?osdIXg+l3BDgloFV4uGVSJqUR5D+dNqj5YDcP3/t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9010b052-e6f6-4825-22e3-08dc10a0ca0a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:23:15.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +39VItxanu+vlhWtxQ5XPWCTNhMrR1CRXEk2teC58qAMQfSuM7HRYPCg9Yp/f1WwJ8mFhiSbF8YzutWKaJEmaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

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
index c0d08cd55d681..1741af88040be 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1067,7 +1067,6 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct resource *res;
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
@@ -1086,14 +1085,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
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


