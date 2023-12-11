Return-Path: <linux-pci+bounces-765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E821E80DDB7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910981F21BFE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 21:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469854FB4;
	Mon, 11 Dec 2023 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CQw3FDUX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE5DB;
	Mon, 11 Dec 2023 13:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlEoDjYISoVPDCCrfMvSrDVEL3loJhbnocL4dKaB1rCstPXBOhSr6fyevnEQ8Sy6cmWqnkFz9I5ld9ZlBXxjz941mCUnzPY1hhr/lWCRjSAxAAirrHvj5XW/99Ep08aUxparfA6nD6wsjRPTfFIco8C6a9ECtjRjp6Pt6egvtZq/c6D17JD4cG2b3ypIM427wtrAglhb1SDk3OiVJneBoteJE0tUDeEFnXmzXMyu9tX40z8WwPWWcdJKG9kyEZFVqCTZhaP/omg8ACS7/F9F3fBtmZH4wpXwi5YrYPfyxbJE6vaQoAcK1NKIJ8xx3zQ+QWLCMq2iKV+KBG/pQRgapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+3r8CcXpGad66WuoaRxM6UCy26WD7n3iKnspLejRlA=;
 b=Zhp4jUtSzCcB0gfKK+rKRI4HVsLp/zkBmdCfXVRckBOTKTjMmRSiu7fRZEV0C54p0fGtvqqqFM4b75K5PHgOLg6d1F4wWyAacVzwnI3e0J4qLQ7iz/aemWD4PuXvBZzP4RlTeaFpabZzryF+2piAYRHUL45oOsW5uenpXZlil68+xuLDJ38aarzjWm3KyX0Z9vn6sbio2Wy4Vf+mVl5Fjb00fWoRNNT4V3MKbZcXbqirNVwOh2DF0NJUVGywRN60Ve1dc7qvEnD8W80mVYwvQ11mwgiQ/FK5y+NGPdhmN9TCDMqrG7UCMTrzt+kBqlyyDcRqjcI/dcxLXvVM1HJrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+3r8CcXpGad66WuoaRxM6UCy26WD7n3iKnspLejRlA=;
 b=CQw3FDUX4wlwmbibf9DfpvMvLDGCEWKykNDb0nh1Rv0RxkUvd6ylOkRNT4au4wyoKXRkJrvP2gEdngjZtI31lrnbINaPT22ug3k+/tJHB5LPl2myH6A8vZClSPotQpt/PQNp52rpc7CJa2f2vyjBnqvvRoTv2D/zLBxQdfb9ujY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:59:41 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:59:41 +0000
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
Subject: [PATCH v3 04/13] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Mon, 11 Dec 2023 16:58:33 -0500
Message-Id: <20231211215842.134823-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17711b2e-47d1-4d95-2715-08dbfa9479c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gIevpNTnG75s1QmudwRLMN0KjyiZf/SizH0Bu0yRSeL2fy8JOsbBQIj9hAQ5QWAWiOrL19s4KWwT8/IeKxDOCsu92thgBkVH803v3UehQAKkrxS+ekg1fbrvf7M+rlZsE9lo47wRCobHT1yqUyBBphZxruwG+JWxd5G4rQe4fQfunlQbjerobSygTEELMee7npyYDt6AScZsTtOdNOdmt3A3Xdf3IhNfxLeuFaLk65gT5PzIb+N6xYA7SSQTid8w1lPsirTJvXAXt/rMd29dnCIQacfqd4B5NTvGNwnzqcGuqZdDfeJxMPvIFjIvM77g+8j9bdzic3xy4soHI4e/WQCyCEL3QWTpV5ikuk/E11QrsdcySWimIFbEOndU/BwlQJckuSLQT7QnmkUYIONH6zJpPhhDnveqt2swGJYN0KWiiAzaZ6fGZd1qimAe7lsTaIu0AmGbm0T8lGROKxF1oUPmFdKIqlfzO7NhNZ1/Lz0uTY22XrWwLDPiDR7jfAsWHMcDNLPKXBL+nG+fbPZkz0jtnlV4oYaHKSS4o3LlVjAztS1BM6uMu0eUEBWeKpM92+9SxcEqS9Yr1EJ5M/Pb3F7nXo7oMwshtMCwc9HV0hqMLcDaYVSjKlVEd4RbQuG5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2zriirJaXkLMfW88lHg4YZZncS9WHTzKfP4OUWXA8ecDS18tnO8dKnl9FLEw?=
 =?us-ascii?Q?JcTXAnWIE2hw9IdYzWzu6LWBrMaKf0SAxMBTIliXJnlDbdjcXz1uDGOmLA2m?=
 =?us-ascii?Q?CUlIAEe9Yptj0uDfjeEHqBSCznugOAyZPzK2pUG4GbBTNhhnjg22VmCNEGIF?=
 =?us-ascii?Q?MMR0qbt0R3LxMK+UBocqyct+zPxqg5D7j68hbmHgnk1pvvLitIZJfiNnXEo0?=
 =?us-ascii?Q?gnk91kES7IdO0ed6KREKC3rG9G16w+A7576SvDFhHWRX9WW/7LnxuqwKObmA?=
 =?us-ascii?Q?RCs39lXGdlOpj/4X4MNRAy0BY70wvKXorkEgME6OJk4x4bCOjkypJY9n77qd?=
 =?us-ascii?Q?/axhzuaabK4Jnf12X64rIjNMBX8jBQSwvg8lRRVVnysmaR2VPS9JVo95CUbF?=
 =?us-ascii?Q?CyDU/woG8j+t5IqhHqDm5f1HQOK4pEKbGFVvNZBZrmRoiDtC81TAz/ogSArh?=
 =?us-ascii?Q?qGZ8deZ1YGWtdGYjAenB6nqvrjKe9GzQgJWVIwPpmI1ZPD6CfDNvrfUaO19l?=
 =?us-ascii?Q?fqTqa0cWgB50aK9jCYF/L+70WnTeUbwoV3f9t5YQLKc6OIhPBQjfv9yw+lS/?=
 =?us-ascii?Q?RXzz43ZJ6FujrnjPh4ehZiQ15Fonh2XDaglOCaJwMvKpqoPi407ODqA8z2VT?=
 =?us-ascii?Q?MwcdyLsj9iQL/LMirZdjt+6WTOda72qeFSjTDUxn6/S8OP/6sgrjk4548C2D?=
 =?us-ascii?Q?VDwtjVXxEdF6UDo0raneT13f65O/b4ke83N6OKpX8OBrVwhVc1kmzln238vv?=
 =?us-ascii?Q?xznAVLKmZh67rvie2lp6JZRicyE1ogpsTaUD2FvlpVsXGO/lkciIrax5YeaX?=
 =?us-ascii?Q?nCfRvDdpMXlWw3Jv71jcl+rLGKQDVrxtVl8YWmPG3FxBclu3jtUW8htMhLl5?=
 =?us-ascii?Q?zehahGMFIu67Rw2osmcpKdIsi5TvqIIWzgnSNpANK8U7XbKuJYShGM7kauRC?=
 =?us-ascii?Q?wxxkGZRxrSBSwwO4kkagyBjlhSoUKE88nP+pU1tdrpkhvePe0YJALgQvhpJG?=
 =?us-ascii?Q?EnOlJJKsBozltlGnOjLzhmgSjMNoxsCcs44KO4BSIHTOv//AZfvlAtHso/Hx?=
 =?us-ascii?Q?kikOrMGO3mnip7Um5GPUED7/C/ITF7Kw5BVBoZFlV50mlo7e8S7qWBUCFZVX?=
 =?us-ascii?Q?42DQaLSP2p3nyTPmYv6kmS7pN7d+HniIfglK+ZHCvzvKJ8/5uAD7RZv8B/si?=
 =?us-ascii?Q?jDP7IHPJ2RtdgQ3a7lfd5aUe+INdyokQDx4oS8j1fYgFu3G/yf6zaHs304WU?=
 =?us-ascii?Q?SWcB1nY+ZeQGp8g8jzmLCkOwqZfMt2pyLwl3Mgpa2WWM8tWNMkVc6OwxCpTs?=
 =?us-ascii?Q?cEHihbiBgFJ47NGcM0Tb1AopYAH6+ZHOz2tH4RPtlvPtegZInPotJSIzX230?=
 =?us-ascii?Q?AnCH5iuWtDXast8o+fpocauj5a3UTmQ/HnxoNAjTcFyoyH7aqpT7RYRKow/f?=
 =?us-ascii?Q?5jOeiM7+zkL4j08+6TmKolG3iNwRH5rFiRumYgbQjyW2QUuzp+JpUXV4Iomv?=
 =?us-ascii?Q?3Qs5dgyek4aZLVL17mkXJ9kNLh/19R0Xp5zJKVqjwG8hUr4IU9mcMjvOSKwx?=
 =?us-ascii?Q?6OJrocHoO+uCAFy5cV0EUyPS56fpOEPgL14Uji1F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17711b2e-47d1-4d95-2715-08dbfa9479c3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:59:41.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UKnPjSkGyheOZRgQkRiUKQCR7S0RQNbITawmplWRkL3GNR4mvGSPwDx+ngnFI8dGEtqC+199DN0tGGHg9SxWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Avoid use get slot id by compared with register physical address. If there
are more than 2 slots, compared logic will become complex.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - none
    Change from v1 to v2
    - fix of_get_pci_domain_nr return value check logic

 drivers/pci/controller/dwc/pci-imx6.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 509d459bdc5a1..548034151ee1a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -33,6 +33,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -1327,6 +1328,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "Failed to get PCIEPHY reset control\n");
 	}
 
+	/* Using linux,pci-domain as PCI slot id */
+	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
+	/* If there are not "linux,pci-domain" in dts file, means only 1 controller */
+	if (imx6_pcie->controller_id < 0)
+		imx6_pcie->controller_id = 0;
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-- 
2.34.1


