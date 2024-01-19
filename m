Return-Path: <linux-pci+bounces-2379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38025832DC6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D08F1C24CE1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2155E6A;
	Fri, 19 Jan 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ug77Bcje"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9A56B8B;
	Fri, 19 Jan 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684333; cv=fail; b=lPY5fvmmM/ZZd+Aud7hcxnCafveOKFuruyBXDmRaM48Cto0ZSFREVVCW36w/pm51qf7JD25P6ZlQQlIufe6JrupnzFK9fcrY8JFuJc/zsr3GOhuVXjuwMBEJ2GzX61jZ4JIZqH2Ubu3yK/r+uiVWkxgBYQy0OxhKDG9aaNo68pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684333; c=relaxed/simple;
	bh=+9kWdYC/LpPzVQIsMrtpit46ZIqe2HL+j2TqaHj+FzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYRU22bpoSVMQQsRfjiIy7T8eDjFDdn8larOgCy80HCabnEcUpYu2AZ1R4lCdbcbhUnUkHhqkF5yLibZMtdFKtGm4Cieupf+WlBXyb5Zh5ecd4aDq9pOJzntJaLFSyKbozFkq1NmmtAeNRwpofFCeVweX6DFi+Fz0fSTwaQHo50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ug77Bcje; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEOyLz8YwsE2HFkBT8PTJqZOkXko/gdbu2MZ09zW39Kd50qgKcBYRonOhY+l10frfL2eHTliCYYXSveQuy7jpmincj4V7TYehF+6i+a4jQKBPF7ZuT6fcQRQPa5QZPDurDS9K5H5eiul/7tismwb7ArSSepuAK7eAEVMx1Iutoczi9W/9O5lkkJQmC7Fdis3d+wtY/kyCVX6//iPUq27nfQ6M/RKkh2GYz797Xp3Pua9x29uE/Z6QybLoUv83nGVSJY+ZM2NcLoukBjq3/NKnifhnmTA5S7gGHlUxR8rLpUKvxJ4585d7MhmUs2yOp/ST1KYt3WWW003uA/3qTPO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b7EirohT6QhiK04U8yzpfL2SyTiOsPrO4dYhLXTLiI=;
 b=fNPZmmvTfd6lVYbXVb+aRNJBhS7zNrXRVLjvZt+glbzinQ1YjS5Y0OZlWNIQ2YZ8IleumQ6D/RRGpw/9RHMTDH8nEaPi9MNfnt0qWEQDou+iKTvi87JBmiuGa2WVKk8uFGjpc0T0rE8R80N6ZxX2swlBh7D2aChywPbsawCLPc+OoG5bm6f0VoomcTgz11bqb7VavKULg4o/yldcWvqzkAEx7atJpyhybEWU7XjAQiM+jzhv3ARKC40oFiwCLMCoT3sDJeaezlBANDz20oPZN0ySXtBrHKXfouROED4Yg5OCEdQ4TrgxaNYCHRjvsjo7qSxGrhHHGr1DKzfA5rLZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b7EirohT6QhiK04U8yzpfL2SyTiOsPrO4dYhLXTLiI=;
 b=Ug77Bcje/DzZDi+HChPP0tw0rZ8eTyPMJCPkNKA6aS4Oy+Ny7zoLRrPpCiWpHTDwvbEteBu7fO2XV1dTv/1Sf2uiwY/Pt6fWuMv320hnj72rv8GXbdO1syqAQ9vG6sCFXaR/sItEmjEJx8hvT6VzGmcMDfSdYftdYezTvzfAvvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:09 +0000
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
Subject: [PATCH v9 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Date: Fri, 19 Jan 2024 12:11:11 -0500
Message-Id: <20240119171122.3057511-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 833e3fa8-1c76-4099-2f84-08dc1911c4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cB0OVSKpOSLOCQZtp0GIfE16kJKeoz+vLhZhVZ/H4nEyUdlRpVOFpWxLNFbqBGAN5+rIz5t8i3h9sRGruGSem2BH0bP/DcUQ9TW3zfaS9aI287YS2fDlTmYKvLUWq/qX45kzhNXMilVZsPTkEHtCJK51t/AHb2TXyOJ1wqS9ZeHRmdJHLIDLtMH6cZJ6pAjfx96JOoSlEmJyVgRc/rbElS4eRW9Zdy3zBoSujwvmcK/VnVXdRHAOmkrZCDO3Sg9p0ZCTikQ2P/7HD9pSq7AKtz4bUDWBVZbwkP6jMcfQeMFctMi3FheHOnLcfHQo8VqLxZD5uTAj9vsxHV0cDSqIxk9yEBMSO6I74K1A+0ZSItQrwSO0TmP6ytOTymNsJ3ZmXhaO59LjTrr1oaWaibeU6j6jOyJxu35HyeHou1FEHLnTRwENNNGf67P/TQ8v5KNuSviKdo60XT8aS4qVN9JEe8szSXg7Wn6rnOVt923eu339wJSXPuuunt49K4FIlShtwrR6DXfx9hf37Z+mLqdlOXnPde1lVAuorjwEF8vNVG34S4NhnkCiZaPFD+pP6V1K+AlG62mN1DXoaGSb69KyAD4Wqx2sUm5HO7qbVs+NSLwt2M5UkIE/U5IsmwHh/X70
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RwIKRR5Jm96WHnR0mais9rv6pP2nIMyWMZKlphVuDXOYYIy7+Cr1k6BzU6AO?=
 =?us-ascii?Q?LSIR6/wU0PS8R4aKXoFoB6kfWvEaZqC/Q2hYaEer//VMQ4s8rkrTflJbPG8n?=
 =?us-ascii?Q?DKir2gq0rTC36E50i6hPO26jQ+tvcO7vq0Y0r1WnH1VkphT7eoRGP004IDeh?=
 =?us-ascii?Q?v8gSpURZlNCPHWVlucAKu/62ejXKCTCPaJ7DUHxb7+q6xS6rP+M6bCw+S48t?=
 =?us-ascii?Q?mfEH4Uk7eWsba1N0SoJwQAWee2oYN7vzBaZao2M5wXTO0aX93ZhSRZJkxoTd?=
 =?us-ascii?Q?aUiouhWQ5JcwiS9arVhBY0duEFStj+5MoKs3ku+MqUn+hmRsnSgMcNpNmcxI?=
 =?us-ascii?Q?cON6YDCAPC85PwnOcWS0ZpIy6fTrDpU++oRb1RB4nojpgmDW5ejKYAG7yLsN?=
 =?us-ascii?Q?Fw6YnHhS/9VoR4uro396pJ0RGd+zEAL+5O7vbadCElS3kQ5KEHlaorUMcTe0?=
 =?us-ascii?Q?Ge0z8uTnEowUngNnz/ViFHPPGmLx56s9ZFgYIpFs3a6oGmi4+cC/kpy9eu5K?=
 =?us-ascii?Q?Pebx2+4Q3/LSOgrjoSgtvjShfPBff1C2rzN1MhdqGCvEfze0Uh1vI6TASn5X?=
 =?us-ascii?Q?jHwDxuadLNMTYRDNuQTNHwX9edWP1nUnLOT5B8PTZoCQO/n78c/EvAth4r/+?=
 =?us-ascii?Q?yVLVZyvjJjYl3kLk3MPy/EpROvueBS+CU74MxCWMU6vpQ7xh/ETrmcV4lm4U?=
 =?us-ascii?Q?QfAsfFl1fimPbdg/jexdIMV2ij8fv4sf/TVuF7KRw3SrrYphnl5RwpHP30G5?=
 =?us-ascii?Q?uvrokR1WVaxAVR64r0dy2H9lgQyEx8qe+uC291Homc51jwgHD4Np+LyDhcpW?=
 =?us-ascii?Q?PGZRh2GfvNiO6z7B+OHA4akkP9MT86xwf0Rm9j3Esgwwi2O3NfVjMPdnOSUG?=
 =?us-ascii?Q?Ple5CUQNEEyP25TNiqU23WiK7izOQ7Usu0xoD9hHGVMxUCbLvFAwbXXrRyN/?=
 =?us-ascii?Q?MM6BCh+4j1iuPmJUz3Zt2PHeTWM4dj9EwTMYVT1W05LIC6y8+Hf/Gw+eFv9h?=
 =?us-ascii?Q?+aAwDlWrfiNz+lzjqPe39HSfkDYKCUu9De3Fh2DhSN+cI/xsfCyPXbQ7ucJP?=
 =?us-ascii?Q?rbvPgZnYAGejUu8d6hMGhfupmtpk1AMefTChkVaj5PimuYYFKPko9rQLKWw4?=
 =?us-ascii?Q?qOdlogo5EfQYTg78eIXEGwxKearYlHzyUDeJxB2Elmf6ew2nXrG0PPm5enMM?=
 =?us-ascii?Q?ChQRt3kWRdXVDajQlYssRR4S4VlXO0l+43YtIpsalQy2OQvGWjmJKDFgfDWR?=
 =?us-ascii?Q?IZsneTUI4R4ycG0J/fjTVlusT7DTcn2HYMKubfq3T9sxT+vpSkj3VRIT3nPx?=
 =?us-ascii?Q?adLPQoHnQ+72WgJBG9f7hwNkqg/ivT1T/LYFwuqoPR3TYxR3L1NGjzPI0YkC?=
 =?us-ascii?Q?n6OBiJ3K1gASD7mGloIzgMKba56xWfLKR4UePb8gG46umJi4Rn5k332Hr61R?=
 =?us-ascii?Q?SVOct0ksLbZerCpCpD/Rr5O6dMmResqrQgsE6aFjBEh2a1mAtVKQOwIMIlfA?=
 =?us-ascii?Q?0cFc7pqiVPioqtSenwk6btY9UBmU5NliT8USlM+yH5nsn1WAD9jYwHor3zME?=
 =?us-ascii?Q?fEk8PVTY2F/E0BRhAoM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833e3fa8-1c76-4099-2f84-08dc1911c4fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:09.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meO2ZVmzJMitdrN2AU6Bi1rcKTsmkiO0LQgRuQ03CU9HCW+TbxSl5o1P6w53F3w2Jz4oIFvs9RPl397x1tqGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Avoid use get slot id by compared with register physical address. If there
are more than 2 slots, compared logic will become complex.

"linux,pci-domain" already exist at dts since commit:
	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).

So it is safe to remove compare basic address code:
	...
	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
		imx6_pcie->controller_id = 1;
	...

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - fixed comments
    - Added Manivannan Sadhasivam's review tag
    Change from v5 to v7
    - none
    Change from v3 to v4
    - remove compare basic address logic
    Change from v2 to v3
    - none
    Change from v1 to v2
    - fix of_get_pci_domain_nr return value check logic

 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index eda6bc6ef80ee..773411d20329f 100644
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
 
@@ -1279,13 +1279,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
+	/*
+	 * If there are no "linux,pci-domain" property specified in DT, then assume only one
+	 * controller is available.
+	 */
+	if (imx6_pcie->controller_id == -EINVAL)
+		imx6_pcie->controller_id = 0;
+	else if (imx6_pcie->controller_id < 0)
+		return dev_err_probe(dev, imx6_pcie->controller_id,
+				     "linux,pci-domain have wrong value\n");
 
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-- 
2.34.1


