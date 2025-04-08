Return-Path: <linux-pci+bounces-25477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DEBA7F555
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 08:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34E13B6954
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 06:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBFF25FA2D;
	Tue,  8 Apr 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X/qcmWxx"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8225FA0C;
	Tue,  8 Apr 2025 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095266; cv=fail; b=HYuit+09d147AXX+MPQCioAi2sSVWviiJLw4wbp/4WyiiMkVTGO4fgWuqq67p0kPrJVLqFcR4N6GBteRHpqMnVZTVArihJeexx2/gNTyRljn49lXAuOf13hxfvVBVwEb/KJtqMSNBXcGm1OdXa0t1qeYwV6pAxtlosNiX9Ar13g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095266; c=relaxed/simple;
	bh=Ra3rGt50DuQOCQL4y6N6bn7NLoFJWFNLQcSlHbh83dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sM1oZeI6jOWB7LyktHs/s1WM/hTk3GMYwieFHJ4xyb4M/ZUVsH3zrmkPgMlnAccgFkD2FGl33dnc4WknkUPaS6eSDvdoZx0Ka/HzFPpIMCEWOn0tx+1458AMmVGxsEy3wvjpOl/MkjWZ6BPpC7zrx+JQzzC4pQlFyJmRH33UYmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X/qcmWxx; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2ruj9LA6mLZ6oKPwH9mJlw4WVX+Z9WPI+uBwkr7OESuhv/wcd/aozl35lzQnPCfCH77KvYIjuy+j5CDx4tMYquQW9wcSQlxyMAveQHJLZg6yZWIUfor0GEA5CZQp3EATa7qp9W7B2rcQyKI7ygYiC/5BiUWR6kPBKBuu4FA3fEKHNp36MDeYrCmLQ4qAUufnK4qyYCCABZb6w80WTItX5Co9ZYkmy1WDK+5nYI/16ZhtV9I9XanNGCHYSeWAIQm3DF6Shr+a2FbdmZ6KsqyynF5/nEZprd5zJ7+laHI+mZXBzPYdXcyxZ7sSs0cz4bcOw2L1aLeXJw/3z8Kjx5smQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKCbWq+Itvwn7lFE69Mw2AySBmN0yvbWmmXK/6d14Ik=;
 b=j/UTzQFeU5rb/ZW7NqwWB5/Tnh2LndbYgmqyThvXV/9m5ohURECrElZQgOxQtHu+eMGzNFYbwBPdJdfLOQ6P6OQ/m0k5jxCz+A9cth4ciQ+ARLEqV/twQFEyAzgdfW75Ram2viC79MgdOqI9KoI+uZifb8tVcGelEOHECRollFgzQ4R9NBxpdE7t/FgJVVQvBcMhXdRdWKSXhcex//DOGZYCwAGyaqbl09T+65UrcBTt9TQ/fUEWlp0dfFleAFniIcHUs8KJPN6pek4Rh0ZbSf8SCBJrFN2nFMgmsXEPCqaLBJIJ99ULrtYmdEGqNNi8yT1IKz25CmGhYvWUrH7TVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKCbWq+Itvwn7lFE69Mw2AySBmN0yvbWmmXK/6d14Ik=;
 b=X/qcmWxxkHD9hR/v+ga+HjViDq12nIPCZtfu7uxq/qgoVmOIF+x7nSOCe8bFypXmDyvLsmKmsnFYdqFdXIRfRhyvZsS1NdoF55x70wKTNaX3wEXa1vTsjmFPT0hIWAMS6vKc9jyDAlDb3H95YqHw69tc26Bh5Gloq9kspb9QGpk+yB2V9S1x3inPFcxR7Lj9o5nDa7viFyTDP6uYpYU3u4u1eMHQlsw4lTp3cnQayDYc02CnLBhkiMAyzQghd2XJQKJ/ZwylKrcIBHf6blC+3RhmDXDM87020SmeL/34q7QLMlUc98PXEiyGs06tiXadcW8Q9WrkKbprEZVGcy0q6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAWPR04MB9936.eurprd04.prod.outlook.com (2603:10a6:102:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 06:54:18 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:54:18 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 4/4] PCI: imx6: Add quirks to fix i.MX7D PCIe hang in suspend
Date: Tue,  8 Apr 2025 14:52:21 +0800
Message-Id: <20250408065221.1941928-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250408065221.1941928-1-hongxing.zhu@nxp.com>
References: <20250408065221.1941928-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAWPR04MB9936:EE_
X-MS-Office365-Filtering-Correlation-Id: fab96a16-a365-430e-3c3b-08dd766a2eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4JUpX9ZdOln5T2mz8Bd9x8sP6eeRyemKZJfPqsA15+z++9k0EoWlNQuJkEsq?=
 =?us-ascii?Q?95PIBV/YnUYKYxuPCulWK1lIWktLGAvDWlHqK/3gd1P7L+QOAK2a/xe9+uBP?=
 =?us-ascii?Q?YC4mhu3dIdyf2/f9SFhp9Oe9JdykrOHZit7TFxDDtSI/KX+KyR1oaMbJ6OP4?=
 =?us-ascii?Q?pYpriirc461wsZ9/fgNUQ6PfGDpddx+lsHcqrCoaagzk6LFnfDQfQEf4oW1s?=
 =?us-ascii?Q?o2X6IplYQeAR1ST0INhpHMxbsMhizgdgNGPzAMcb09R+cxCnOWXBNERlM9nJ?=
 =?us-ascii?Q?pCNYuTpO6LJ8wVaGFoAKW45jn5+fR5FH9unF47yyx3O6UOGq2D/ewm2ma+HL?=
 =?us-ascii?Q?QbvLWdH7dbO7+01yB0QWrygP/GiBSrtJpmNjYKOZYVh6F00kcoWS2Q/NhNuH?=
 =?us-ascii?Q?bvOGh6t3tErIL7F7GTbKd9O6lu2xWfldP54jo7uEUk3Sx1x850RjnQ1HhRF3?=
 =?us-ascii?Q?+70b/0s8QIq8tQDtJXXrGS1+KU++861hQoUtvaJ24tNX7rOBamH+yszmISav?=
 =?us-ascii?Q?v6mpNhkiScQghaOPw0sXr/t3m/kOqixKfCYZa+W3WAi2Ggejgeh6jOLoSb6s?=
 =?us-ascii?Q?rsSMCMLsm9VZU/xbK5Cos0jtCXQ2KpgF2ondOdttvPyvRV73zqlAdNxQLpua?=
 =?us-ascii?Q?qx8Jx3k3B2Qjxa3uP4M7hJ4MqDO3Q0PllmvjCH6vYPW1cUvHeKnk4tryazMw?=
 =?us-ascii?Q?2EyyLHBqkKDBtl8ccfWGT4BG/P69MpKJC3vx8dxWYQqUz1V19shVwTh/cI0y?=
 =?us-ascii?Q?GDi5cmPvu922GxlDtYzfxY2DtXRqzBh3GnhBquSK7Pm96mhYCTAZKIbjHWHV?=
 =?us-ascii?Q?5Q7QHtkzoyn1/bg8IfO7Ky05ZaFhiD6epzNlWQWNPZ48N5e8MzMDFoYeVUr1?=
 =?us-ascii?Q?oeD1YmUGa82/kluC/VIyB3BMczaoMIuL8VpsVGMlfBx7BaMYlRWbZieek3nz?=
 =?us-ascii?Q?tQ4EH3VO6Jy0wKWYhRoXxYalvX3kjAkQ3BmLwGgc8jNGOYunWFZ18prNJDBo?=
 =?us-ascii?Q?F0OKxuKlByYhngKCm0/tKmC0CLE/pKpnS4NmsY3Uefv/0dQFvUZw+XOZSFZu?=
 =?us-ascii?Q?GouO+3rzXk1nttuVLRaUMyFDGC6C1kQYdj3ui+fX29Y1FCrM2tlTp/ZYQbJm?=
 =?us-ascii?Q?lB7nnp9Z4fcrkf/T+3EJTyL1kZ4Mcq2G8KOvCb0WzaUX3umUGINqK0QN6vg6?=
 =?us-ascii?Q?WmAtQIkvPTC7vNhQnuAtPHSU3esnb8FilvSCnh+tTYcZUqYTRlpH5xOuM6CG?=
 =?us-ascii?Q?apUTp5i0YX8T7ao911zohNkLN9XxCeDzGRdue4Uq5SdUYQG72noYeykbWyqy?=
 =?us-ascii?Q?7Tx/AFOKF67h0ykNLzwBXixY8oT+ApU28xsUvw1bpSK96wSw9GgWLM6MCYrB?=
 =?us-ascii?Q?icQlEJKYALwkCJMkWoiub/yDuyBJnopL8vPuyOD4XKtznwYobf5mDWQwEmm3?=
 =?us-ascii?Q?G4O8pWkWiGEIFWh9wNUIcoVMlaHD5ZPgxllMTcHNMa3ahH00A7TCZGeNQ9B9?=
 =?us-ascii?Q?vederEexC+SWBso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cj0BNLcTk4mGretPSPn7P/dGERY9magGPTZ/SLLK19Cz450lRAa4f/J2LHjY?=
 =?us-ascii?Q?O/mjKTgl3e3tSNFRHEm+8qbRUGsV8KdYuMSHEqNpo30xwO5gL8yGWBtVAjCx?=
 =?us-ascii?Q?aFamEQSDRSJTjfwQsrlluwnKXqAtxCvdU+PaL+6/FIpptEl1C/3kRLeQbdmL?=
 =?us-ascii?Q?xueABeYdW5zj2aKy2mEa9bXupbMhl3gPT+ZBOUgnnAMRHoDpN+x2rta8qkFo?=
 =?us-ascii?Q?dUXMfEMxy/KO26iSePfm6ezWp1glpafCZ0MVQLk+B6fLFKs96NZRLHTBgH9Z?=
 =?us-ascii?Q?+JgpoeSoiiaTaNNV5ZAlrjrqRWYeqOARLOyXoiEmnSabWeYgjlV7XsC4ABOg?=
 =?us-ascii?Q?Pf9l1acgC+NaUlBk/xFOKZc45omNdpiCCxAJ3RyJfbIYgel+Lsw//a4QSP7/?=
 =?us-ascii?Q?DcxvmVC6WV82YCzJatPHVFj+uBWZbAg2MdqCDzPIKZLmd0qG+08LR69/9Q/T?=
 =?us-ascii?Q?S5WAPc36DBCQJyLai252wb0c+8vfBwPbHbUYDpiNFBydm3NEL2Vwlyft34xe?=
 =?us-ascii?Q?v2piNej4nEWPtRIhidXaxwwRNvbM+COQD76ZxyLXvvffB7IECQGuAGLJDG6K?=
 =?us-ascii?Q?He803R9hMiIPfSPZhIpMjchrRBIUqvcWe2L6hp9y1QD1riRTPNjUWCDLM2nD?=
 =?us-ascii?Q?63wuUsjg12iE+ja1popbNBbjjQFALoFFhzpy+H784QawJFdrreKvRYAzE2w+?=
 =?us-ascii?Q?ItfwBIbaqMJLa1/rlIn6Jr+DDR7B5w2aIuixHODZMdel3wYXDxDmsQ2uWz8t?=
 =?us-ascii?Q?EBR15AtLaE6qEAur/ldAXlVKg7X3ZkMvqjcNafQHUo2Bi9o09nuYcWcOCSzZ?=
 =?us-ascii?Q?7+Mkrnp0gMoZNsaP9/AlgTj65zzOOZilVI47nGdtjeq5sv5RFSBfpKzN9XWW?=
 =?us-ascii?Q?XbqefoJlZUXTtx0AbXlEnnPbeOfkLMHzZKaHe3h5lz3iZW8010DRKKsWiuNB?=
 =?us-ascii?Q?MKSxFS4ghCyNBivnRBhiu/8RXDve/0aCjrXqmX6jCZHIs+0Z0p5EWuTUNdpZ?=
 =?us-ascii?Q?WwUXyQ55YJhd8A0nefQ7sxrK/VOYrkhv4llX0v2arGw9+prSLVJ6BfYjnTh4?=
 =?us-ascii?Q?RkC1IdCtNIaaInBF+8RCe38mrAvtPEo45ndSY8FnZc2KkZaXemOVViD7Dk44?=
 =?us-ascii?Q?dgwdRIMxuDolZDyBu2378oI0OYlpljcklE8D7kR32JFA9cUZCQMwIUoxPRqx?=
 =?us-ascii?Q?dacukFxCM4Rcb6VM3u0an8L6qDMs9mGzzZczhm8RLU4K6l6B/k6MFu7sLHVW?=
 =?us-ascii?Q?beH507WhupV6u6t6abVrsIkZvFjgvyWt69hiYbbx1LeGd4u9jvnaqgkgZObP?=
 =?us-ascii?Q?BZmeKm3HVoNEJe2mB4NlvjlwnVOPl3j6VLZhATFsrozgEhr76Zc2GK1NsLKr?=
 =?us-ascii?Q?tlRN5hF1v01RU6dyA6dSQzwRUwCvTbAD670nteOzOSBh1+olyV1On9fIE1X5?=
 =?us-ascii?Q?YFm7Z4ec/4jlBXUhrZitMGJ4njMtjpBmwp7bVGotJ3PufenebtDu+QM7YU+A?=
 =?us-ascii?Q?4MRAuMkJ/15fG0aqPbCrFqa0TMT4bda2BAobXOzvqqtZ3zhs7eziJ4UPI8By?=
 =?us-ascii?Q?RG8Aztvs5r9GmydyVVTMGJoEuor+sStefVo+l933?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab96a16-a365-430e-3c3b-08dd766a2eb2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:54:18.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw+dQcGwkUXGo+DmsYihGXOXf3P0AyNcWIfomyEB7RM+VKTr0Gl+QA/jiYqbZn42AuPEcdY344fzKERXxmvdMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9936

When no endpoint is connected on i.MX7D PCIe, chip would be freeze when do
the dummy write in dw_pcie_pme_turn_off() to issue a PME_Turn_Off Msg TLP.

And, i.MX7D has the hang problem in the L2 state poll after PME_Turn_Off
is sent out when one endpoint device is connected.

Add quirk flags to issue the PME_Turn_Off only when link is up and don't
do the L2 state poll to avoid problems on i.MX7D platform.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index aade80010cbe..779b6c7a501d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1706,6 +1706,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
+		.quirk = QUIRK_NOLINK_NOPME | QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-- 
2.37.1


