Return-Path: <linux-pci+bounces-35306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7EB3F777
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C667A53EA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1002E7F14;
	Tue,  2 Sep 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BfY1VLF6"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776512E7165;
	Tue,  2 Sep 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800173; cv=fail; b=RG3BMKlBc06pLMFSxluoFURPaI9cA7gpW/vSVfCR821bZ5sbDk9eXY/V2/C6HLvlppDrfhIX8TIP0nz/9ToE/KymUW8mV7yYSYAAZopNpq/6WtK6DVxU7jqCezptdEsO3I5wxPh1avwkUE4galvV8hJFq5H98NmgQQ4o4P8HklM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800173; c=relaxed/simple;
	bh=mn29O5BgNUWG32s0bXTmAlP8tCusv5U/cRdkdnQmKFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ftGn1IZgNgJFfomTu5mY4+daQiBc5WUmMxfdMoKCXqngnxA8vRK3vjAu19SYdEd58fTWjBVH0T046wTQOKKNOFlGQW0mnBGqaC7RJXzfVNbQVDB7b2GzEJ4fHMA/VbO4K+NFpYY6i67MDBSZtWufcT8XEYJGFBb7Ndi3SmT1Dq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BfY1VLF6; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt8dXHpD4V2Smc7IzXCDv/5Di+gBCeIfsF9heNcwPnjo8xQP7C4u7hWnHOBMUpAvWFLksO4Zos+uWeEXo1v9XTg7hU0FKq6C3Svk2cpZ1SVgKAc7uzjgjTrtSF7cR7FgvLXRaD857ObjEgF+lFNp03HVNGiUrjtG1/DgbS9scB+2gQe0Rc5SGX1fNkYAgXO5ws/ebZhXSlEzMA2apXki37TE9yr2WOAgUfBe36LYmrigPAgrhoH/BnyECVov9DVx3HfEv6ZPzxPcxqVOe6j05qWxbuEUXu/B28jKBSsc/ZLUimxbYJ7RRbJQTy9pRs4pk3M1wk0GaIbOi/yQQcgsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLuOXSxne5EWH6xcHAhsV9Q+5wlu6zOOV1VfsEveTCM=;
 b=ppgnrh48BARG7McVVlREd1Rg+s6/CE+aCineXp/+c6ZfQSkkfggV7popmtFy6KhDt0B6X0IIMBudhiBiLxK9f6kEffECRuiRQ/rJlu2eDI37Xb4KBwU0yx+EIOSUNzNFvjOUy3QmQbLlDBjGKEEyCLVH6o1XtkhATci2iriJQW1H/D6NGvNnKWZsJ4Msfi0Nmc4BsX95s7xOnnjmZZJKTOC1+yO2A08meN72Oy+JfrNuqgECDzYEcG8SnkyFPC00MLX08wsGSVROpU1lG204IEsUDOcmsKh7F2oqjzdH+7tJcCkP5tTiGWc4APzX+0oTfGrU7XoX/0lNwhjUoA/THA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLuOXSxne5EWH6xcHAhsV9Q+5wlu6zOOV1VfsEveTCM=;
 b=BfY1VLF6+N2B3ZXfXvPXCCeskwBr56IiklELkBiHxQEM0WuJXxnRsyFeDlTq7JauP8XqdlX9qaOpYEPZNmTXDdMR9LkllyI5Ek57lJ1oJLwEcBUlYFPYyk14pt3tEJKXcCJIKgkL/hYmK3FbeunemyF3kXp3/w34ONc2sxSqKE+qJ7U/2ZK/IUEPaC8kABfCJ1dlb5IyoYg+NEuD1cHUoZK9pn9C+fZCK1vd/8QuSuOHvo12w361LAHVkDpjOR9iL9iRxtF4knyvfD0f8JB393B5No+Gd+uRysmdt+JhrOb4CksfuPd5uZQrpdIM5Bxss1DSiiKIs65T6egfjwMeUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB9PR04MB8265.eurprd04.prod.outlook.com (2603:10a6:10:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Tue, 2 Sep
 2025 08:02:48 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:02:48 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 3/6] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe in PM operations
Date: Tue,  2 Sep 2025 16:01:48 +0800
Message-Id: <20250902080151.3748965-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DB9PR04MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: da518978-526d-41a9-b741-08dde9f71b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZI9jLOzZnXGHX7uw3At/Dr22+vAoc8Yo/dDpH+HUTPJx7ha9Ob/78Ev//ad7?=
 =?us-ascii?Q?Y2eCI6W6aGl/o6srdeVX59q/D8pklpzYmRq1lMWp90iuE8YBzvKR2Tq30/hI?=
 =?us-ascii?Q?cmrz2AT15iwItUheLlVubhXhtYUYYu5PWy5cPxhzVUVHYwTBe/F0qv4u60Dq?=
 =?us-ascii?Q?ugbbkvM7vhzumNGahNHx6w2NQTZVO+hNGr1GgagMJMU2LT6aypJ1rhw6/98l?=
 =?us-ascii?Q?JjNUndhgfjYEXmhz5tIltUeMMaCmosNGnskkZHgEeqYwggEB6JymBINALFaq?=
 =?us-ascii?Q?3r5P/jby/3GCcOXTC3JAXgdz5BxYbNyTMFmIcw0xJSi9JOeO4STPHNj1zTr8?=
 =?us-ascii?Q?nIWlJ54nm11QhwpImjUbFp6A8WCbEC0sAZ5G75ViqRL0y0PcciAAsQsQkeUc?=
 =?us-ascii?Q?sSnETnxQcf7qH11PSv6zQgShz+eQpC1n+gR7Fz4zKJAcMGBSzIk8ykr3Zg67?=
 =?us-ascii?Q?4oPDSO7SXADrAggTslJoK6Zty3gbpcM1KRmYpOjC+94VYPbFNgzY9q7QSVWd?=
 =?us-ascii?Q?1uQIt1TgOZZF2nA8I4d6wL1XKI90NndPOV7qbP81F7Gx2EMxj+hSZ+phniun?=
 =?us-ascii?Q?il+TQ+oQbT+hsA0uT2FSMkniuz3njfUq5KXvm6Rg0oKI7vEQc112hFNsjbXB?=
 =?us-ascii?Q?HvOhY8fYQivj+9ZeYqPHpAqyZLCOSW8QCvW/hItkOvnuuBwqIxBcePgJpItD?=
 =?us-ascii?Q?zXYy2fAuSUDW0884zAL09wxg4m7g4jfsPURVR1ymS6S2qj5lJ+moSga5ul11?=
 =?us-ascii?Q?12PwramDa/ETqj9EXuXvQjc4a30VMeWqWGWdoH48oJ6B3Gdo3W80aHkW37R8?=
 =?us-ascii?Q?eQfHXYXsxhmBhJPDYZmW6HPHbOwIaBA9FW138YDrSc5s0TOi3AqOTQetg6HU?=
 =?us-ascii?Q?YBsaqRTyg3UXCPTMFapaRq2+oW+vixjJH1p/K2SEuvS1HROsvko0vktGncwV?=
 =?us-ascii?Q?xRgPnoEVw/zrujI/ibmBV6gB8fZS5Za/jZx6bg+JYiUz/4LQ6Fg/CXQFl5Vf?=
 =?us-ascii?Q?a56ZljyvA0Qs5IDnGGCCd8q1SyEUtuvCM9Onq47Nn3bIq+Buu1u7cT2OUcbk?=
 =?us-ascii?Q?AbcyQKPTi6fAkl4cOo4dghID7DjUJXeyppRm/TNwcpWAjG+B8whoEqyXOweL?=
 =?us-ascii?Q?aTmOMqYaWhkBdWFQoZgsoWov+U4KvAsozR31kmy5k/lrixn8WOXryYFCsuz+?=
 =?us-ascii?Q?2RuJvNHvZRkJjgh1fNx89cesMuo3iWU5m0Ks0DCtlm1nKWrQcMRmsBSBj0Qd?=
 =?us-ascii?Q?EHWXO/dEQby7YQ4GW1gVzVWplsdHjNUbMJQgX8yZ/0hzaXIWAdZ4T+H/MCNZ?=
 =?us-ascii?Q?/0tKYF99nb/If8hysRBaaWx0V6yXw1BkpGKsekc2qPmGEghQxlX0QAUcDhRg?=
 =?us-ascii?Q?uh+3KFHa3qNqn7iz5LbpqcBMQYhLL8wcOu0lhuy2WnjarxKeZ78Fqs1yAq1v?=
 =?us-ascii?Q?fxAQJGuzCVSh45kWrTFfdKPR0xo6zbz//KnCJSAdKIIgZvLCOzKAWhzkvgC+?=
 =?us-ascii?Q?nY9jQQKOxbJqZzM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?POlHnA7oSu0QV2rfh6EO1IiPSPxKEH7mSvUJ7icAIcRdU5XFIPl8rx56m2jo?=
 =?us-ascii?Q?oyKLmtVaajWd2FxfNXIPSy2CrRjt9m84PX1PvZbMbcZtpCFmKdYlv34ZgI1s?=
 =?us-ascii?Q?2VBjkdDVedP7roV44ckxqya/qoKkuZUpTr31fQIt96kwyg3LoVnqXzbOgBSy?=
 =?us-ascii?Q?SoOLfj5SdlWDlwIbsXXtNQeCpLjHhQckWghYmmjbobQlF3mqHvAEbUVCXr/v?=
 =?us-ascii?Q?GHhiCxI2Do0NpVWfvc72xXCvTvGRjMOTitxYX8YlZR1k4WaYHRpvt4Z0PHdT?=
 =?us-ascii?Q?4EOFp+4ZGlF/aWN66X/SrLjWW+BaPqXBGeWSF2K4PO+1XuERclKRLY6Wm31w?=
 =?us-ascii?Q?THY93ieFeHs1J4DKIF1uedxfL9/pTgWztBO97zHBkn+YyrH5zd/+KtjmjkF9?=
 =?us-ascii?Q?lXBrl+3zZZeeaq2EufIJdGzYf9EOduZoO/52psdpKl/HXdowLioTeRog7h56?=
 =?us-ascii?Q?83UlXyWkh73FHfSC8sgHgDO5d5yQAL80bY7YvnstcLJHm+pnn/u9+ePx/4U9?=
 =?us-ascii?Q?z6+R/MxuHzx/um0jpTWBo+jXnVBLHYBW53ZFGEnR1HCnVyC0KV09Z3cm5PSC?=
 =?us-ascii?Q?TPPNGInhf52J8LVLSXA0sXG8/mROuz+RzjeD4j4wWnl+PE+lkUba3yk4Hn4q?=
 =?us-ascii?Q?bMNDG0qSdR+QerwegDd5WMFVt33J7FDkWYUTBuj37FDuPhxadtV7zT3osL/k?=
 =?us-ascii?Q?ybyuFbD3K90g0kXQOI+3tUFK6qgpUtG0+W7XH98KBfbpRlazaTF4JE7iGBpQ?=
 =?us-ascii?Q?7fKZMxWV6tn2OJANMwlGFLGp/k5nJOdDRXP5Qbm0phhv6k6vAlhcXVj7n6cN?=
 =?us-ascii?Q?GJ/QImAThEs68BOxhKgEEH0OzbILQNb2q+ynMeI2UfMUBrJtcsD9DFtk4yVm?=
 =?us-ascii?Q?KSbLJYINFDOaQECZVor4yNkCLr9tdcvasZHqaCRna1QuNkMnQlvG36gR0NZV?=
 =?us-ascii?Q?bWEsMVvhjYOQGvEYM4o2r+HH5iFmexEOUfjZejbDKtdWy91C24BHQP4OqbKj?=
 =?us-ascii?Q?s0gPt42MgpwwYqP/XUAcicBfGYF0zgrAPKaGZI3PH8z/SLIkcsrghUFz1zCi?=
 =?us-ascii?Q?a1wUN6DQoEC+YKqLtt5XjJAePSWAAhzK25WtF1FNsSM/Dm4366c69QrVmeLY?=
 =?us-ascii?Q?OxAM+Q3ODIzu2cQ7vOQ//gFdx/oV27ezVGluqaY8/WOu3HcWPt7ZLrYu3X+c?=
 =?us-ascii?Q?OmxU4Z1VBc4uzdE8QMmJccJzpCQvnuR4nn8eNmDC1hlXrXNIfM0DQM08/ho/?=
 =?us-ascii?Q?jdirOSe6zkKBplvxjy+l6zI6zQw/znbA3AGxaiqjdeSzypYO9Et8JNTim6yg?=
 =?us-ascii?Q?15IeqfCXCk9ZvkRGkbFWfEL5fx5IBs+hiJr0jmXRtry8a3+1nvOTWfJBjYpu?=
 =?us-ascii?Q?vlIWATxK7iMqDjZ9mpqO2eWQivUTkGI779JFzY8fOSucvOs/AxUcS28ttyWM?=
 =?us-ascii?Q?/Fkmt9VhKEb8aJE4iV6/JQSFCFp9FX+GmWOkM+WZrMsYTNxBE15ohgfsP7N0?=
 =?us-ascii?Q?Nsl1OeK3ar1JLNH2tMFSmoCS4sg72j/C7HxQdhjeUQrUOpE/UiXrYYCp6jp5?=
 =?us-ascii?Q?HEvrahC1V8mnvaM7MJdUA5lKH6EPKJ6POSUWZ8OA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da518978-526d-41a9-b741-08dde9f71b75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:02:48.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7AT6E9pFDAD7Xd5e1Upn49AOE8QaBXASsaF7YVYqgZJjgLSAvi5IV0tjplXOrVE8F3py0ARULT6TYge+/Rkbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8265

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe are inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..18b97bd0462b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
+	u32 quirk;
 	int dbi_length;
 	const char *gpr;
 	const u32 ltssm_off;
@@ -1765,6 +1766,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->quirk_flag = imx_pcie->drvdata->quirk;
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
@@ -1849,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


