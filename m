Return-Path: <linux-pci+bounces-628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0C80917C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBBAB20E7D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEBB4F889;
	Thu,  7 Dec 2023 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hIZmxiON"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCEC10EF;
	Thu,  7 Dec 2023 11:35:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6OVz3C7Af4n+P9GQkg34AnCKTHOjDlGs7o8BzYlsg654Sy9dFUWZl+sTmkkYph4VI7+V8CtrGkGGIl/LV/ngWFdq34FTvZ/fWeWBRFRXkB8+f3OSewK+d7mOKgSKqeD6WMo3PtjsnflDGvTYzuHf2vlvehxbxCQ6gA58BKzXtSGd74AcjjTs3an/F6JQQFKMmkgpI0B1IIONZ1qrmQaDYEW7Mc1WdKLC0RcQlIYunO0iAQUuQat7VaWQVs0+kZWNVUZFQzGNplpwQePrtytN890vTcIOtr2up2gco5pMI2fK8Rm8xy9FiBZ9ckOE6+XxzAAOKinLtqjxHv2aAPblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSuEpyyki/DfByE7OzgHPt5qCHhxy+0xcoGs2kkAca4=;
 b=G+VwYZVR1Nzb/oXyKJxIiSyixd+NOfuphZs/9Xh/NApnvf5qr8B3S3TNyrP81rBAj3Bx9WsqKPehvIqTKV59niqI9INibNoJLnAPtHn+rQZlG2RyQix908nJ+WV2MxJfUTs2Tu2aJD5/dAq9Mv277vlSdZuLiWf043ECgyjqiv9/oR9LgtjeC20+8/SOKjESougCxlBNMKz6YfzUwxVD4g05KWWKR30osuQm+pxE7SG9G7wvb7O6mn+JEatYpKKxQzQ46dCQRhBCl/e1jtQPWc4CqSg09MN0icOTA2yrP2sShtGfFosFc46Fc0ICP6b4sl/WPOf+OvGf/StYs5cmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSuEpyyki/DfByE7OzgHPt5qCHhxy+0xcoGs2kkAca4=;
 b=hIZmxiONyJeeneS436du8QaRY6W3Xt8GNZIoUPJPpV8vD3jz3l8sBptAj9MGYkaQr523+KxRaeYAv7Rd18ryaLLMkC+bbdKMub4XZlpt1cAaC/J16kfTyNTETOVZ08t5wMXNP1PNreu9d2JlV3F2vOnqzPAu4+nAWy9+sEppG2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:35:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:35:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
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
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 4/9] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Thu,  7 Dec 2023 14:34:25 -0500
Message-Id: <20231207193430.431994-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207193430.431994-1-Frank.Li@nxp.com>
References: <20231207193430.431994-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a12733-ad45-45de-8714-08dbf75ba09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qUShCUzxsJJ97gh85RLCO/Js0gFilIZmBwMYrtPT9czeHqv0/DogzTUiljGj8OHBROqYZSMogIAzVRs0WUX0FVwONYQAhkSgRbZqa2POLZsJe2XGF7raoHCWLlkh7clwmKoBAH/avUfIz3JWQgInqo87a24hvaf55vl7JIpDQKnO3SDtVepIaOU2AALfHy8c+y3kaP2PnHJvqSwlFT/yZAA2Mr5fv4vkTSaJUPvKQ6ExXU1uBHj7TkCtnm821SMKWwKKIOoyHjXp/EzzEsbRYN0OpPcaNRR3X66CedqjEwLJTTYQyrq93mAfBpsl5Ce+FG59nN2PLJ5ahrTrRpMJe8Yp3IXo7d+wJOnnAvN8PyTfFKlonhG0eU0HVssHZsN+YHXcX1MFezzbMQrFzvM1Rbkk7KnmFBxoEjMDD1bS/LC0Tsr2a2oU89eOU9D0ywXHpzzmhFs0qvX++u0hCxCOVrT99CVppEuqNOsxnXwoZP9s1TPUE/t7vAYqYVNxHfvA439aRKfXuABlQssHCmyf46v3PpvA7z0NR556XpxZP9YL3Eab9Df8Z+E2sBX1KDuzdsS0uTQwh2iCHqE9/tHScDCnWiiTIZ45+wK3dBaBUKlbnZoNVYzosqVSz1eZ7h0r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(1076003)(2616005)(26005)(6506007)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RYEEm0cvGY7z+LeeZX/elhvAQ7mJvEOAiwIbTLtiPEsRZCXbv9rktnYw/n6F?=
 =?us-ascii?Q?ANjF12gLV1B3itwOqYmMNodP5t5ez8wl+cBmT4HbIeJhAfXpLKQtFeRi8/fI?=
 =?us-ascii?Q?pbkY8+96vUbMF6R0gPVrh6odE8KhXGVomvY7DSXaoqYqW9ueoA7aJwX+CTQg?=
 =?us-ascii?Q?p7kpJGa7iLMB6+63fAiW1UpBziG8BYn15Rg22f+ftYFRHw2Ia4rwjUeGhaAL?=
 =?us-ascii?Q?fUsvFmpteHzLbu31X8dlTLGB/zyfL1kQyNlrCdxKVL3BEz17PZH46aA2kq8G?=
 =?us-ascii?Q?9ct5aKwZSb4ieMZLVwj0ZKaltcFZlHF40pivmWjLXaOycw7qJYZn9T7vAPcJ?=
 =?us-ascii?Q?e5n8TiI9xN3+nTXmcEgpgx5dXAHoj7dNCAVvRuxnraWCm+epda8Kh9IE9EOZ?=
 =?us-ascii?Q?iOFnsL32sj5Cx6dPcCO4YVmUB/5O1/mlxQ+Atrmns13fpyP6TKuDVJCZCSOw?=
 =?us-ascii?Q?zncYlik+orxz96UUQO6zJKNr5RckkITyBb/N9g8GRz9f1KMGreX6cR39VdGh?=
 =?us-ascii?Q?EzyJvlIvgQ/3+XGMnraeI+jdaPCzCRduIBpRiUVsoa1NuRLExqxEFQYtncCk?=
 =?us-ascii?Q?sk3uYGs2SAV315MFzDVndpnPqMATNhAYricLGJ3kdp2qyelxBfngqar2A5ZL?=
 =?us-ascii?Q?nL45S1SBoO51Ig+ByW9J2aCFkAMFclzIhX1s8+aGSgMPpTqXLn67ki8hs/fB?=
 =?us-ascii?Q?aKjbHUX8qgIsPd678cWvN0UHLZmx254IdwbarlzikS0rzfPC86vcboSRYlRs?=
 =?us-ascii?Q?JE6JUFpJrETFA8B6FsqC/9scNjesPskCKH7leRyqkbSyGWt7fht1RoYV4Box?=
 =?us-ascii?Q?Sac0zise79PTlRSpe+aUdmD2RFv3fNZuamtqmKIg1hwYV4o6/bvu1rMuDdNP?=
 =?us-ascii?Q?LDn/8ntAF2KoVjklx+bAp/aJYGjplXfyh+gULyWdBIWQJv2g3jy5XjBmY3vM?=
 =?us-ascii?Q?jzCbmukdxglD4GbFyzeCFQxFG3yZz4m6yx78mUlfSkhpI4BDponlcoK0UT2+?=
 =?us-ascii?Q?B8ugHnnS3N6aMrlr2xK0r/jblLJY+5usZGVYKz7B9v9QSOzWUetQHz1MPPXz?=
 =?us-ascii?Q?vpwBN6PquD4/JABRysRGHabGQIB/8fmmdkdEbuFLkQuONDwGSMgXRePqKrl0?=
 =?us-ascii?Q?BxyWUff2wZPAQY9yvgZ/dRGk4MNxCcymKEhjSKV97dXVdw9VM6ospIQfUdNJ?=
 =?us-ascii?Q?AC3/SAySCUMmS2umZrZVeB5mUgGR1ZSiyrmPez+fINGNS1/FhRDQs2ZcOuin?=
 =?us-ascii?Q?9szY9+DeHh9ZtP2bou8a6VbEcQQ1EbJXDJarNHsMUfkKo6qOuZ4ScYk9EoFf?=
 =?us-ascii?Q?LeOhm421uy/MKpFA3pmqFhcNABdjvtB8G+sVcpM3bWysGSAE0ZFDxInWZwmf?=
 =?us-ascii?Q?UEwtguR+baCbv6hgqUFd9yJUjgGMwOefdL0qOkvpWb5c6zn5/9Q8s9D0tepd?=
 =?us-ascii?Q?58PcZttHGM9GSHdWWRkk4WkkpjSaSwTTIr/dBP9tSveOB8ooSbXsuzuez1kn?=
 =?us-ascii?Q?e33ybDZPU+vm6j8zfdJsB1SM4f5zPsDiWA19WsWvJG8ACxpKH+OTFBelavGD?=
 =?us-ascii?Q?NeEnFtafpOV7nQcsBQo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a12733-ad45-45de-8714-08dbf75ba09d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:35:11.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YOmhfl8Sj7x/wLu7VSAD3hV3+3oZc6CKn0xRfNKnhJFnxNtrFgRnC/F9dX5Z1939sNUOE5XRL7vOQF2btdhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

Avoid use get slot id by compared with register physical address. If there
are more than 2 slots, compared logic will become complex.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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


