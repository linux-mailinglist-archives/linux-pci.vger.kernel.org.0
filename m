Return-Path: <linux-pci+bounces-15776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D39B8B8C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5168A1C22384
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7614EC4B;
	Fri,  1 Nov 2024 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AlTmyLu/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B813C8EA;
	Fri,  1 Nov 2024 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444187; cv=fail; b=jRp9Xt9Zm8iohqurXbD/s2vNZ5aSML7vdnPVeY7zCl1cBxvr5HaXhwTnZnd4zLjnoD2fpFOunK6HUbOyamlbmd1FLOV1xdlrr/TljwJS5/pjqSaI1qZRci2VxcZxopEISz+yiKBdvRsdcu68wQEY1w4y+nOcd4x1zwmyxFV6n8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444187; c=relaxed/simple;
	bh=nXZQyhhYYR56EBvbHVy3WB9rSLIxA6OWcmwjxPB4DnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DwFQ/YOV1XqRVEt/mgqp4SQHfFBVVNgIotnIRfV+O8VOdAIWHYvZIxxipj4Bd0EIgZ6MLw9NNphfZ8w2jKuEgTIH4LrN0SzsKVqpIT643ZzsUpgkri4r6fasgqZJbNi4zChGANFvpVm6Bd+nGH4W1AO9Fd4NLWOmtprKh1i/G7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AlTmyLu/; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReL77fiEU+s0RMNYqTQJhID9APwfbeoBBywQ14hyUsXSrlRaItwewZLZSRbLQvDfLTv+ftFyA5cOBKYKJPYkfZQrnhkF17bzkGsJMY51iLdkfbxS8CGB+q6m/r8hnDCaFKpiw6w1ZuT0YCLMx/Y2k0gBM2Uh6/UJ5kxrS5oytLsODx45SBXYXHPx9L0jCESA43YmgrS1QInkQUhRdKw/dROaRwxHESQRVYzbThDSIT0vqRvot9yoVNa4QsroEMtcdIcz3UXeaButySwQQwXyfXA/loAtGbegapFGYqPeRKaqyFmw1SzDJkpgfnzzE19a3OUzSDT2X2mHsPfXokYsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjZl9+6vE1JCtXhWoF+Jzfv4ovkLxdt5VsJGIUSS1fA=;
 b=qBUgnIUBflhfIm8l8t9K2Q5Bal4nYf3+8Z+px+H7gA6viVtj0n388kjoo7FdzT42uvy/G2sj4ky8u75mBhfT3J7+78FOTMC5NRqvo9fvmvhbXd2MFcRnL7vj7IHjEC7QZQITRuTOm3m2hBQivsgpQbdPqAU4FSfWzF7pBIeobo784ODasiWIXai7t/HbdGLLMOGIVn5HB1E6wyeWZzj777Y+H/PwKmk4OVbv/gBeUiRUq31/Z7e4qumTr2c55Ihip4hcf596jfR6i+7gtLkORbxiq1cq3Geu4cLvRDQl2ygdHSnWV7y1LB1ds9Asf5B7jNhKibGJqzjsReMoNEYrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjZl9+6vE1JCtXhWoF+Jzfv4ovkLxdt5VsJGIUSS1fA=;
 b=AlTmyLu/tA8FxOgD1n6ZRMpSoEKcvBNiKUg+dFnANu20V95+83ffdeQ/2Bb2dPsqVgOk8IcmahpNb4ut8oyOJGQDT55zbimmFw1qYqaBPtnXw4Olz7GgPHENNUgaZAlqCbV454AbON6+sGQbPki9oFEC+mS8aDdnzH91q9Vi2q39gNDhCpVw4uJua82OqiZ2yqQ5Ies7ISIM+DZIp5Atqw1l/E2FkNZkVwh6OlVZsRTuWIaS0mvAMvRhAXlnSAp0XgotcCZ4EdKPdXVzbe5vPJ/CxTbRkyEy95/qcZBkWJTZdx8rum/tHHp78dTuhUcpzgwAvSWjeSN5badwek2JWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 06:56:21 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:56:20 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Date: Fri,  1 Nov 2024 15:06:02 +0800
Message-Id: <20241101070610.1267391-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 46311ece-e334-4ec0-2562-08dcfa424a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bp7GU4PkSxwU3W1qvT+1yq407fMvLtvh1weGPYgf/fxAvstOR4XPMa94Lfd1?=
 =?us-ascii?Q?MWAj+g9tg2W+8iVhd0c3IgnT1t0EXMq/Ysl06jsz7HtVUrYDFrQ2oGbZkodS?=
 =?us-ascii?Q?x7D6FnRSrAvasYtuVez4jEAe972ksGvMPqyjo9b1yqk78jUt1+h2XDKiQ3x7?=
 =?us-ascii?Q?HYLtkr5WA7ALkDS3QoUQUyX4whd7gOTw/DciD5sTY92urZtAM1hSdVK/AOTb?=
 =?us-ascii?Q?+nXivpBmwKSp05et5aRNMXpZ/Maiciw2eDVdiTObWINqzBGW3ejZhuEkFlU4?=
 =?us-ascii?Q?GPd1eSzzxmsjW4fr/+xDDIvLF7y4Swsg6VubbiUce/ioWX28CpNojerveJLd?=
 =?us-ascii?Q?rGRy6Qg/QgDbcGCTzFqlm33MGtuR/rt3zZB/I6V6rma731Pwxhmx3QgWi6iX?=
 =?us-ascii?Q?xCkojySQxL+1sfwJ/2CoY9c73ThxuqZMZ6bY7+lcDfE3gtoCQuD1US8ocZxJ?=
 =?us-ascii?Q?vdXab7/UVnbscg93LV7Lg3eSfzupjDtYHc046QaBt4thd/Qq+JnIQxuG67kJ?=
 =?us-ascii?Q?Bm5Lmmuoepk6KYvf0sUNjYzbX3JppwTKKZnYj/u6CN553i3xZaMolcpylgHI?=
 =?us-ascii?Q?TJCfoamu/0VyXbBy+fWVkjXiqhP3rLnKnCJy8NvT14siAjAd3q+X+RaLWxMf?=
 =?us-ascii?Q?hhVFbnD6W20zniwtHL47ZFMLWiVM0ByGS6AvM+BY0122M7rz1zH+iAb3CPEe?=
 =?us-ascii?Q?iN4qVOutYvznCQ8qyifQ1erCZbaPptek3jnTR0Hx7haf/zBanFfS21nOS64o?=
 =?us-ascii?Q?W7Hmt/VBvqHzjwG1bQMDgM5SA2ML+NztZMeQq7pV6mQh7nhF6+ybW6t2k0+E?=
 =?us-ascii?Q?1NJAGW/jyeWRd0GPAE0IrAdO+/ApT0fmZlooszA3iikqxmpT4SdvJjF+fsjR?=
 =?us-ascii?Q?tdLYDNYrPHxHRB/xTYoPQ9+J2zZ5kzruKa8wJALGqnwdOHrg0gPMPqoUrVzl?=
 =?us-ascii?Q?A1w2bQKe1lewibQRUoRbrG57MPOZ9f7uAPpA7YA9pyz1oZa0DxRmE4NfhcA2?=
 =?us-ascii?Q?YX75SFHc0GH1zt0mcc2Q5HDFAjfLZ2oINFKC2Sdp6hIzfSOZncPyzkExilxO?=
 =?us-ascii?Q?mHV4jHuAiqv7z4pXpNpkrJfVWaJdBr8cVWmgYsz2SWyOW7xVXndWDDZfSYDi?=
 =?us-ascii?Q?v85lbo02WaA1JJEJ+qxvDebhupiWfNPxtS7xo3pyBcq1vX1pyp8cLkssxeSV?=
 =?us-ascii?Q?O7A9a6xCaXzj+VOJFaxTquNnCf6Y/WANcYrDZpaQlvY7kduKiII9x1BWJrsu?=
 =?us-ascii?Q?a6wZSPDH9+jB0FFmQrugIaC0aubIZPvDup9uGvCRImbEDeBkFnOkQBJZnZPp?=
 =?us-ascii?Q?yNymdtDKjIbOw8Jcjkeop+z+g0eVWh3Vuq7hC3cTUpMd0XlcTkvvTjVG8gx9?=
 =?us-ascii?Q?Yuaa8VoRo5TRaSOnAnmLsBpvhqTR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6rmuBE9aL0oeF+5Bv1DYJt45sicu3bFxK/eH1THi7Sv2wfh+HLeo8vKmuU0j?=
 =?us-ascii?Q?ZHeYWEWueO0qQGXBruaQrKAx8LkFNT9nrEbN77c7p9yV6Ip50NBDWwjSDlKX?=
 =?us-ascii?Q?sBMSQPVnWxfDAAoOhPlTyVXFFbKm7dlr/tUeIK75irL25PYLhsCrb/3bTUfv?=
 =?us-ascii?Q?2IKmCoUpKgC4oo4PrCT5uLMtC3Yncxv25jfkAPm27cJLJZku9vrIlZ4AvtXh?=
 =?us-ascii?Q?2FRWx6HnEbB75gSuUevzrbnGa5BPcva8qoqnfy/hZ/Erlqn2LVV2TZeVGeB6?=
 =?us-ascii?Q?IKUIFkolie4lPRBGMURLRf2PYiE/lPKxhk85mn+WV7sKYfmkDyMSFPqgw7SE?=
 =?us-ascii?Q?+UMDjNIEM71w2+C8vAGSnr9jdToHJEebk+hG/N5kkKZlJ662cBB7WReJ/Cyn?=
 =?us-ascii?Q?zc7TpiB2kH3xqtCb5ibE/5gfmt+thK1evI58LzWS7g3cDY1Q3bhd7BPengrz?=
 =?us-ascii?Q?Qhh1FaUzhfInxWoYLQXEDu5aBT1URqPjhhK710jC+6ZN5XS5Y3zrqrtBkrxJ?=
 =?us-ascii?Q?IEaC1iTTk4rpKd1MGr1zkWE9mdPecmG2raEFAA5KlQCkqsr+F/6X8fcZMzWu?=
 =?us-ascii?Q?gKwXnf+2FHcG2c3ciiuCsJxcdLHzdk6qA/6qhrSyanq5nfD7lP4xjtaPRIMp?=
 =?us-ascii?Q?DIeRm+qZpZMTswaQSFKzm2D3YoqypidbFYE3MHaUkn52hiRBI57VObylurHm?=
 =?us-ascii?Q?WCgA2KPockOOO9CecRxynqjYueKRkiC06hnduvkSgACneiHa7fc95isIPlTO?=
 =?us-ascii?Q?afb2PxgPk6ZZDrgNAFQR1KzqCp/dGsNzWIRvzOUndZopPNiicIe0IPamniNM?=
 =?us-ascii?Q?6nl1DL+la5nX/63sew6IuVkSClyIU0V6QylUUba2cslhOw8E4DX/14IrmlWf?=
 =?us-ascii?Q?iT+ZAKILdR20Cft3lqvFwF41fLOb3pLzeTnJxnod82/IAx08O05CoGX6EuIh?=
 =?us-ascii?Q?cr7fPSCeAQ/GLMHSs06unM2F81MxH0iM5Lep8CzKC6r5zXtFCxE0XkNyeHOJ?=
 =?us-ascii?Q?/vCDpj00ghfIyjr/lzTf1UglDffaATk2C4yihza9QciHYQz3PimTEYfYd+R1?=
 =?us-ascii?Q?w0akFbLi7DcX1ISy+mFzHwEtBaYThaCdRBxlcS0czgfAn3EM4/mPHwd+Kg0Z?=
 =?us-ascii?Q?4MQFliU0u00k9ErI3DRSzbX3VBshQFZZz2VUJ4a9HIY9p7nBzfgWjE2qcZd7?=
 =?us-ascii?Q?5MbgVqfXXkGh7k+0RUI7kR/AVsiSwPfL3XGYvk6mwX69dbYR7TOLY7UsQ/xO?=
 =?us-ascii?Q?M77M5gTL6BJ6G9srViGQyTiAYNMEd6sYiAvXdZnFTKylOCjPIWvhJW5uVKyf?=
 =?us-ascii?Q?NRu8O4/k9lJ3RRVmCz68Cx74Mj9uBfkTgqYpQbgaHkUEQpwzgFrruOmctU8s?=
 =?us-ascii?Q?7UfyAnDIlvSz59dH+Z6bWQBTRfJIhU+B3sXUnzmHahbr4YZ0/DStXPzuBLJV?=
 =?us-ascii?Q?xR0XiPcY+AkcKmbV1n5Sbpz1/8cg5GK4H4Myf8jv0eR9b6F1d6HH6I17Df2H?=
 =?us-ascii?Q?xr/LuDVLipdeqtQEv5OyYlVxRuSqxKgvF4SKb/X/JzL4dayAgvPi6kM5rhLG?=
 =?us-ascii?Q?TjzgZOTBXPSkyatKTFezI+fus6CkuBEax3KhkV3/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46311ece-e334-4ec0-2562-08dcfa424a9f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:56:20.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BjGrQu/2mMw5t3BRjrDsj3Sh8bnQP8WSWCMJl7ByIp0mjcp8G+Hbj/hjF861E+hCapn9bQ/LY/10jZbMOq7yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Add "ref" clock to enable reference clock. To avoid the DT
compatibility, i.MX95 REF clock might be optional. Replace the
devm_clk_bulk_get() by devm_clk_bulk_get_optional() to fetch
i.MX95 PCIe optional clocks in driver.

If use external clock, ref clock should point to external reference.

If use internal clock, CREF_EN in LAST_TO_REG controls reference output,
which implement in drivers/clk/imx/clk-imx95-blk-ctl.c.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f105417..bc8567677a67 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,6 +82,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
+#define IMX_PCIE_FLAG_CUSTOM_PME_TURNOFF	BIT(9)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -98,6 +99,7 @@ struct imx_pcie_drvdata {
 	const char *gpr;
 	const char * const *clk_names;
 	const u32 clks_cnt;
+	const u32 clks_optional_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
@@ -1278,9 +1280,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
-	int ret;
+	int ret, i, req_cnt;
 	u16 val;
-	int i;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
 	if (!imx_pcie)
@@ -1330,7 +1331,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		imx_pcie->clks[i].id = imx_pcie->drvdata->clk_names[i];
 
 	/* Fetch clocks */
-	ret = devm_clk_bulk_get(dev, imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
+	req_cnt = imx_pcie->drvdata->clks_cnt - imx_pcie->drvdata->clks_optional_cnt;
+	ret = devm_clk_bulk_get(dev, req_cnt, imx_pcie->clks);
+	ret |= devm_clk_bulk_get_optional(dev, imx_pcie->drvdata->clks_optional_cnt,
+					  imx_pcie->clks + req_cnt);
 	if (ret)
 		return ret;
 
@@ -1480,6 +1484,7 @@ static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
 static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
+static const char * const imx95_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux", "ref"};
 
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
@@ -1592,9 +1597,11 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX_PCIE_FLAG_HAS_SERDES,
-		.clk_names = imx8mq_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.clk_names = imx95_clks,
+		.clks_cnt = ARRAY_SIZE(imx95_clks),
+		.clks_optional_cnt = 1,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
-- 
2.37.1


