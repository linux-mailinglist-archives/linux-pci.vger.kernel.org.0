Return-Path: <linux-pci+bounces-1106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2F815D7E
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134CB283A3B
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEAA17F6;
	Sun, 17 Dec 2023 05:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kRjZZ8ZA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1205396;
	Sun, 17 Dec 2023 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPab8BXt2f2FsiGgexleeMjgPAJN77lBnCkuLf0YUjomc9xSbo51oXh7QMoci0vGlWDmMKCVKhQM27fTxfnYF1kyB9SDwpK/7lypeeC65zYEq66vv/gUirvzoxCBvpGXgxMx7D4dRAo7pVOnqeqnI6avNv4R0W8GxI62FxbhYTYgcgZRlBmvljfsaOEnwPLU7YvYlqLwz8JAKSr6Gk8LO3HHVcBkm93C+Hjs04ccAE2KZxNw59MFkkVyG0ciSinFI1o7AiF6BPv5KCWAr74b8qq/PGJcZeFV8V5lYV49t4wANqaEGx8Ojq/R/G89Y3pxSEPkwGcyogKLLFDRkl+FfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+OyrxOterLF5TTnxpzEaPhKfuFvMf6YfVEIZYVks7A=;
 b=Zfol0vCDuFsBndXSqVl5NRGW9/KtqE6jesY+XmOcJlLQl1ILMgbWpzCzEfZLE2IbWDVVldizifv5p3z/ufNa1eOjH765nmJm01ruU+PP+TB1eV6zd7rHrjki8xoHaLj1wVYW/95uwJEXxysLdQxq3IuORGXVg06GwKxoJXKkdcprxP51OnnBEjcZVh9pz/kcan1mSJWIVKpRz5k4UOsYzS4+5jjSgit0dDFGkxN52UwFE96IhO4+cO5ofxZyXCe8SMFjLCfjxE/qELXln/03knLGgQF41r92z4r9f7MO6X/AoFqJHsCMYEEv4QmnZ9r0K7cVciZSvdx6wZwTeadIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+OyrxOterLF5TTnxpzEaPhKfuFvMf6YfVEIZYVks7A=;
 b=kRjZZ8ZAFZ65ScBB1s/y2LuqIfHD6zSn33nuFiUs4iVYyoI1LByq/6cWgmDHh+Ruc92p4f0YPjdrqJm9xt5Tl+SHmhMXrtqUj9nL6eFjUnvr+LG9ws106FOBSh0ziS2MT+MPfZpHIUqXY4xO+SVnynrrrxIGlTSKqueP+QKDSxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:12:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:12:56 +0000
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
Subject: [PATCH v4 04/15] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Sun, 17 Dec 2023 00:11:59 -0500
Message-Id: <20231217051210.754832-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 033c5254-2f27-4389-fcb5-08dbfebed3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Y5oDli3TnLnc3RHGbbyXYTKqicxHXll8caQDBa06tKjjSMrvwXjJ2JuMH5CQWCV5TwFhVlWmhF/yLyZLTAK/BRtB6AptonZsERGJAWUKwCX6xSmkwbNUzUVqWfZu1/x4zPVwTCgKw6Ox6f4K2KUmK1Xhdt86GPdCqk0oafbvLePhqImrOGsCYBou0BCOO/VgtW8s29n8mmY0lk/TzFnqyVp7eptp/mKvbJQDmx+BsiUrvL3xm/QOs2u/57J7oF72aYW8lVff1oRC1vniF7zmhF5V8QRQ3QmnTRMonw2RWhN6JJQchhkTh4JdFyVxjQxdy7sOLmmFxNzivIeRdZeqFT6i9C2wrBQEAmbqlojd1TTaNsX4v2+TBmkbZ2mZ3OysfOVQ84YmiT48j8BCCJMv1xZmpsCHmBZoUO+OOsUqAYLUa2iohUky2zrY+KQ+DfJu1VNSJi4rtfiLCHRUbFREQ55TiCPJ60GvrHFZaZzExSGVkdtO2hLjkbc8f2tDlCUj/Jq5kzQFzavcork+/sMvHgaMeYIBlMiYr54urS1eQP0FMrSwwku+hLSa8YH3wy9gR9b9+oHAm+hIE7PUXtWX/3wv23pw5xIZ4VRO5K2CM1iP5HVlXIsUlXkA6xjs2uL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fLdr+2yO9FfW//1WNcFaTwArQLozhJd8e0MfMmxGefg/0pFGOHUwecxAFeg5?=
 =?us-ascii?Q?gohu68gcYj5/1HvUBTMBaKYGzAjRFsaJnbMZ/oDkm8t3F9LWGAszkG9JulYV?=
 =?us-ascii?Q?Mk55lhXEmGlfgNO65a+O/nz/h82Tk3Gyr5pAlwrw0LAsDuyos/gc8vjnsuH9?=
 =?us-ascii?Q?P1b2rP/mVQHWpAwS4dHPa+NhoXH6B/pyb3C3yADdly7bLJngQLPeS8xJkMWU?=
 =?us-ascii?Q?3OZFOUkNDOEpuWeusYp/Og50mUsYAEnToYopelB5Z4G5a+cYcYbbfS33i5gp?=
 =?us-ascii?Q?Q+wwRzXSNycoi0+n8w4guP0CtAQUQu4kC9B371MpU98fzDY2NmvxbdWmOn+B?=
 =?us-ascii?Q?bL20hqORsfvTvGLoWbQFSgqdc2Qc7nf//K7FnKCOHoS4vO4lQ5PdmNd3NStx?=
 =?us-ascii?Q?U4I9aTY6pGZdyImG/VRFi46VXCFLBOioMfLSsaRwixDWKZQNr2ZVsHNmnPJ7?=
 =?us-ascii?Q?s+ViSaLXl1Qqxs7qOeNossyOxrhMdzc52it3UsUubrT3l50jMKVfjCYHum1i?=
 =?us-ascii?Q?TC9j5s6vRAixAMgDBUfsmVBM14pr7m/P3Sp/i4G5IMhIDbDbE3oGbjHI6YL6?=
 =?us-ascii?Q?FAqYFGh2P8ieaQ7HX0kHJbNBrSwBCca060rvPAx9KdfPGibZ/RPyxLsqxoxP?=
 =?us-ascii?Q?OnUZXdWFtsh1/aKcdCZS5G44VXZV9GvlfBBA1eb2MyLBCNxTgmnt9fHtk3EJ?=
 =?us-ascii?Q?4isWzu70FrIU1+oqBhJq6bGx4geTqWlyQ04ewBctrGsrCd9w59RsQO+9kxnM?=
 =?us-ascii?Q?WDqdd9gEbW8jVllKV2bjExm7SAUEYc4iJFbL/egv3jd0x7T0JmrqO6/sO1zI?=
 =?us-ascii?Q?kOfVr5bDSDSaBjq+/DKlUoMAM+7knQAZPN2pu2qHK8YAmQmpRNLzNNxFi5ds?=
 =?us-ascii?Q?MRo/aJ6qijx10Yd1d4uMx3kWj3HWyisodLulCi5F8wxYkY07sOaM7/rui5UA?=
 =?us-ascii?Q?sxCBTMBZiI+wlTeGZf5Rqw/qNbMr2+1zodYj3H/7TSQreRyFEjY2zB9Lfo8G?=
 =?us-ascii?Q?Xc+rLVn8CpVQk+2WwXMgQnmWs7yyArngKjQl9nqc9MG+PCltmDNpuJB0eX1W?=
 =?us-ascii?Q?U9z7O7rs1oLU3jIUuM2X/WPh8DNhTttQKDcy1laUXHK1gNwpWoFqGIUJptK+?=
 =?us-ascii?Q?q47Q9n+9J1xP9HKLbG6KktRwfaXs9wZ30Dm2iIoAP8p+DTlUw9L5GbVhwlhb?=
 =?us-ascii?Q?uWYJS9WIUNzDTWTUFv909Z8mjGxQOZj+m5hkBSu/sRmmgZeMSAx8HlRHGBeJ?=
 =?us-ascii?Q?k1gPYpTVnQCXU9jxS7+JoTOyfjlR+hI5k0filJuaN9VeU60j6LS9ScU4nd5H?=
 =?us-ascii?Q?Kt7KiwwUjdlVmlsjOuNfpGgq1Wp55h9buXK11/swsHIEb6Mqb3G/4KAs0LXN?=
 =?us-ascii?Q?XSed3cVjthQDjQdwSoHX+/579EthPG6yskI6mURcSS2CSw3fyn5yPT50Zvr9?=
 =?us-ascii?Q?rPEntbzlImmZtEBJLQEIQvbJRRu9u1Jyvv9+xruxwQ2xJKC/13LdkD6XWhQa?=
 =?us-ascii?Q?9ze9OS6MkAr3PcUrpDRvoD9ijeydlMmL19CacbbkFIrStzPujMguuPUNg7Wd?=
 =?us-ascii?Q?/Y2+E0gQpEF1PZzgqMs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033c5254-2f27-4389-fcb5-08dbfebed3fb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:12:55.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp1a4uON7Yop1B6p2R7rcZ/ejC69B2AFV+rw9vgmz5+DDH6O1MuuJYrMrgIlzQ4F6OlBccQKiRxruTjkup9RyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

Avoid use get slot id by compared with register physical address. If there
are more than 2 slots, compared logic will become complex.

"linux,pci-domain" already exist at dts since first commit:
	commit (9e65987b9584d arm64: dts: imx8mp: Add iMX8MP PCIe support).

So it is safe to remove compare basic address code:
	...
	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
		imx6_pcie->controller_id = 1;
	...

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - remove compare basic address logic
    Change from v2 to v3
    - none
    Change from v1 to v2
    - fix of_get_pci_domain_nr return value check logic

 drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c1fb38a2ebeb6..7145947e21d92 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -33,6 +33,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -40,7 +41,6 @@
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
 #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
-#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
@@ -1279,13 +1279,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "Failed to get PCIEPHY reset control\n");
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-			imx6_pcie->controller_id = 1;
-	default:
-		break;
-	}
+	/* Using linux,pci-domain as PCI slot id */
+	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
+	/* If there are not "linux,pci-domain" in dts file, means only 1 controller */
+	if (imx6_pcie->controller_id < 0)
+		imx6_pcie->controller_id = 0;
 
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-- 
2.34.1


