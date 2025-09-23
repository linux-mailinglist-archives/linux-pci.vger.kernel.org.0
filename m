Return-Path: <linux-pci+bounces-36745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE672B94D21
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6F57B3261
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F669315D4E;
	Tue, 23 Sep 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OR7nVc2i"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9931691C;
	Tue, 23 Sep 2025 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613223; cv=fail; b=Z+2fjKKnlXjpOQBSQePqdRX4KQOTGVc8evcTUPWaDCjFS+x047+4chIEPshmdLTkvHvABWgmLTj8sU6BUrUsl+iZBaxNMUF9SPxvDwkUhes1/GqXZJw9AVVFz2KybkuAFTsbL6vptvSUAwWSiV5c2FE8LFp7Yznaul1vQz3b6Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613223; c=relaxed/simple;
	bh=XtX0fQped+YoJ24bvmOVtHljtGkvZ3QPISgb4qMqSvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXwJ8ufkJ1GlPiHmQC2zLU6hhFuntgJSlqcA5R0DlI1s4x4YVnw/8LvP/1zU45/h0PzKSDJA2bHmwx0VY72g0wXosOUWZCD9TMjF4xHHQOJpgs9FPttEGPU8lnDgomZjtVL9p/8u1gY/4G4NEOhv7EbMTu5RRP6iH7SToxwSgHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OR7nVc2i; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvOC5EoDs8p03cYfZqc7dlnxnNCqQiAKfmWZQn5fE1+04Rhw0t+bQEFXPNK4LOPOTMUTII0YVCnCHqrtcwPXPs3C6XnptVxZjCAA8Ma1n1rqLtDTuBeZ2sRY4Qet84eZ8jyI7YIevooqU3vqg8W4OIqz1NdHKEAUONNbTw8GQHFBnuOsvs4iRyuZwLT8DcsQih61oi6U8gBKU3gK6izh+k7DJOh645pIMTdW3cTqKOPRESxCmH3xsYdZiuyGykPoXypsXU7AD1KMDh991b1E1hDDSEOa0yNOaYyFsQ32VxthCZXj/dfB1BBYYFj48A+Y/EpCWtj5L6tk/9GUnh0lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0lHJleKKp1sduRWliCKRwCZzKVaxlmJiyfuSv8pyDw=;
 b=wB1SdanMn5807/5wJqd6kHkb2AfysVCej5gPkoQYg9rVNSB4LGcqMPsb0aqFZSBe0KWF9hXqRO7UATewZQ3cA6qeZphYY1nU3meAYfV20oCGNdksnBEFMfGFGuV8IrmFI7gAnCnBbxyIYNtDNy855OEIRLIySk7orXh1yexXevV30HXoqhbvKgB9PFXZIwLBZnGyc4QOhrm0qHZgFMtAXtRMoCt5VfDvJHnyEuCz7ZFFsSZGB3keqJOn8Jn8LojsIdUMD2UNk9ArgIzBzghzJYCkecoJ6WBFE6k8b+o+oFy+xhu61bqtW4uUiMED6FrI6JtNllpMgH81u+HDSizFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0lHJleKKp1sduRWliCKRwCZzKVaxlmJiyfuSv8pyDw=;
 b=OR7nVc2iWdBMrBwdSsNgJxHIu5wknVTF39BQkXuW1U4mX5jZ6RLmsWElZeyWr/eLPGK9AiFI7Wh3bkkVSQGWmDKKYXI9oLk1mM5P8k50SvsaI4SxE+cmdluDgVO16Ap9AJ/BTb6AUMyGcZ3UVmU6+5h6FoU2a0c4z9eO+HOgLiFCjGlEAFVMxsnf+gRVRqxUyorAGvg52pNaTNl2fyWCzeaZlieTnM4h09Y+9i44c81zkoLzU41ZXY+TPyxzfy0mgflObPR/pwqQ1ASevtZ83agQDiPArLlowWQvWj4rH34cWiHA0WUUnlF/GvnYDVqdU8fioE/dvRjfqteIDqtj+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV2PR04MB11446.eurprd04.prod.outlook.com (2603:10a6:150:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 07:40:18 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 07:40:18 +0000
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
Subject: [PATCH v5 2/2] PCI: imx6: Add a method to handle CLKREQ# override active low
Date: Tue, 23 Sep 2025 15:39:13 +0800
Message-Id: <20250923073913.2722668-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250923073913.2722668-1-hongxing.zhu@nxp.com>
References: <20250923073913.2722668-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV2PR04MB11446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4399d5b7-94c5-4c8a-3dad-08ddfa747168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kO/CbCnWEwCIWdyU6hcOiOk/cFG5/COoINsm3g7k83XVYbf+IRIWx2ynN+KX?=
 =?us-ascii?Q?XDMq2zo9pH5vN8jc8H+ehRtiqSLqx2r+Spqz6d5at+Pvt6khJFpkV9xXDnYx?=
 =?us-ascii?Q?s9EiGIyL2PHE/I0g17O5bVea3Qn1LT9oBtVDLmge/PCyViM7l9FyM1icBp48?=
 =?us-ascii?Q?+5rXLZ6CnXBbqLtAlVeL0Tm6mNtIiquwBMlzIGxkSc0dTAGD+zPhDvIeeKYi?=
 =?us-ascii?Q?ef+FmhcNTAJApfugWlcfJ3qOi/dSUgEmKgUrL3ZvmJz8YPRQh+/gipcSgHZ1?=
 =?us-ascii?Q?b8pbwNbnDhP19WI9jXW2dKX39CpTVtbfmNqaVeEoCtbJj6dSfBwNjxecGwWb?=
 =?us-ascii?Q?FAKBtcOG6C6N8vZAoMhn58/x7gEVu7e9i20m7+DfzJDzfz1Bm8HuVSd3BazU?=
 =?us-ascii?Q?eGIN847p/NXsv2Yma1UqXYVlo/DeCGuuXaSwiVpJcgcJqiSGtY3Xwf8sHpRO?=
 =?us-ascii?Q?ursM+0d8ye8aCZIQfq2iwyPsYLl5sIu3PWsnxrfEvi9DP139aReKf/Vn6z+x?=
 =?us-ascii?Q?3wt+UF8NvzSDKc+brQZBez+Ew8CKRhkqnhG/1DcJibMBiFZnDGbFKQy5yOtH?=
 =?us-ascii?Q?UFq2wElaW4g4b01YEPXo5+Wgz1Q2WxwW2lXaqcgWpw14k0AhBnC25/6MFvYK?=
 =?us-ascii?Q?4GOfLfqKAl85ML1zQYu+NUJ6jQgRmqFvDcxgZywg7DK3eYleDqeSMRECZHRj?=
 =?us-ascii?Q?oUQfOJZi+uvyWuQNsGYQbEoH9l5cuq1kIlmP7yb9Hvr9cMf2EYwMmdlPJwes?=
 =?us-ascii?Q?pnFVnAkwu+2QVHysLRwfxD02X49nftumyOmzWmCtHGHVN4N0O+UI3hZXhl1I?=
 =?us-ascii?Q?mY9dMN4doKQdV9LqSZ6MQOc0ja/9EzFKhcYGqJaQU0rFlT2RBZq1Gp2Ukq24?=
 =?us-ascii?Q?RUDn1/tTQSV9QkAGFocGSqscFBIC8WcEbyks+goAjiXp+2mZyeUydTdOkzmL?=
 =?us-ascii?Q?Bgl3BfpGmfhzb8ox7cWEXglIkFX/O6aTiT+8Lu61CSFHGR4SgHamM9dOPSC5?=
 =?us-ascii?Q?TrhQk78GIRBwExoKbnd9Zbw/q79KPygbMo8TA+xtUYtFvJGdWo3Z3jhPT4s9?=
 =?us-ascii?Q?U77+ZZc5BxBZyRsU0nj7+IoKz7YQR6z6vbzzQzInxrpe/pw0Cj03iz5r8aLc?=
 =?us-ascii?Q?giIkMMsq6LSBHoB0Pjt3H1zgNoCJnjSYhsmY08K/ORZ2EO5oOUO0NX8VakEf?=
 =?us-ascii?Q?tltJ26JQQJzmo3lXRD6EhauSS1bmi22Yj49pKZ6/4WgLbmj5P+4Y5GvYWDww?=
 =?us-ascii?Q?Eb7WhvPYOBlKZXNsq4F133OC/KsNbovWYgtXsMQcIfiXGYFNP1U9UOzT2lHv?=
 =?us-ascii?Q?rV6/4j7spnHMtLjm0I0tRBGeBts4Z0xU3P6lJrdEUTmlLwvr1FpMvqBX2Lde?=
 =?us-ascii?Q?zeZtdnFoBc6/X0z0UeBl4AhdYzp0N17igYATFiWktH8xQOFDfyZ1Coc4W9zr?=
 =?us-ascii?Q?waRZOJbOBvEkmYKA4LLypkcq10aZaOYsm3y85ICDea9PqF82wWcjeXzYUvHK?=
 =?us-ascii?Q?b1xZfr49RPWRs0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkRBiwbPIE/J/G3TqjaIxXmJ+xbru1cBbXeB18BHUUnOqfTdOmGUFR6cpGtd?=
 =?us-ascii?Q?FcQAC3HhDQjHEjyuzwzRGzQHGjprhJtiW67OuOVe2QUxbhn2RjCOdw/zMNAl?=
 =?us-ascii?Q?GsccTxgCRnHaH+uiWD8lsMVfhXiYvAKsCDpfnJuSF7VRiv9p6k0T9OCyaLMx?=
 =?us-ascii?Q?PK+dpxn5YmfpG11381gExl5NITCeVK5P8XFZ/HOEpXecAQT35zz81NkWDPe8?=
 =?us-ascii?Q?qYJmtpSB/3ImPgttdBFClbK258OrhorscRrTeQgXSqFNNGOUDuo3Yae8lF7p?=
 =?us-ascii?Q?xFrowFMcUqyrvZ7xaTWzAh/KZj7/q0Cjqa6fjWbw1BvB/G2uq6hE5d7JH77Q?=
 =?us-ascii?Q?XihtZpiVjQxD+yMvR54CGVSMYkBZSRaYMv25GzPfvqbt6tV/nvsQBImMwXoD?=
 =?us-ascii?Q?29CD8O+hFlc11lFDLV4cnjZsCSWALnvURWVUo7Ls9oUP8yFMgRZPQ/aKcJVp?=
 =?us-ascii?Q?zNDStOWy9K7GT1yfz3byhyqjimrhg+cdGLpvS/fCJfGFJDo0utpjjy3k9PxB?=
 =?us-ascii?Q?KqxumJLEOlP1OIiFNiy9YKUTuvBpRYI7kXES4dWNZjXhnYRw+FJgGdC2bshl?=
 =?us-ascii?Q?84BtoUv5VYav2qAIKvPQCNSS6noQwwKh8df7aeKtt/gOIsX2mGFUg8C3MuDN?=
 =?us-ascii?Q?Uc5CES8Gp5gWmkiHzJGJTsMqDHK8VLir6OslSX0D7kiUu1XGLczyzsF33cTu?=
 =?us-ascii?Q?GBzQijKmhuWlzQhLE0mSp4Stm9oifxm4h8F3QQ8XK5RlF4GrOqveocEqjB63?=
 =?us-ascii?Q?5fRei3p78aKMix+FjB5/aB8+Y1Yhrg7AyO5VEbh7YVNeVfAbzDlOrKGarO4m?=
 =?us-ascii?Q?6Hb2kUAvbFWEM19aF9TTR2sEsNq5a+oMw6xXcqf+yC8QeA6Rgq4B5+isv9XE?=
 =?us-ascii?Q?q2i+tgOISrcXxEOhd6L8iaZIN3bCFS3WjQXDfJNC9dsOWVBzQjN0E4GEMHgV?=
 =?us-ascii?Q?7QbAK3XlVEZTbnq31BADAjr9GDTov/E/P2cQyCR7615WZjsLr2bZakc22vfJ?=
 =?us-ascii?Q?cACEdVOLhP3qAMDr164sYPBwy9Cp2RXNiobfF7KPYWwn+BqxR4NWXMD4aB6f?=
 =?us-ascii?Q?DSrevH6RGm1QgOyPxACSF/qojc27B4PLHA2VlQnekxTP5OfSPkG7dvYUou71?=
 =?us-ascii?Q?P3/KH2SuYjgkVyIrGR4I71xn0ivOQIVyQA971MNLhjkBage7nEtOtaZ9Vue2?=
 =?us-ascii?Q?jBQFyDXU5Iy6p4KNFlqYtO45OlDkYSTk3hcBrnZBch2zfiCEimQhvA6fIiP0?=
 =?us-ascii?Q?Sa2/DT8yuwugMVtUD9y020f4NLaraUXJdqHXB2qXQhpkphTE+GUq6AghYAWB?=
 =?us-ascii?Q?Rm3ncJR34kahDGZ+h0PGeWzJa7K73ZNmiYq/OYlY8hbKOwY+j14oDapAMiuR?=
 =?us-ascii?Q?n2R9QXv++nOusjfeOOhZdRzRQnvEQIo1uhCrfzn4A1EBYwFpoDPOX4Qx54mw?=
 =?us-ascii?Q?c3C3ZXczhy+GSNUbQko78g37OM+MgcTJdHtTTv798wtAAjQgKzr0oKwdcA/B?=
 =?us-ascii?Q?k6B6P1xmW+AiTU1Nns7RiUz1on0KxCqU3duluqs0SZE4RktkhhLYRWt68jri?=
 =?us-ascii?Q?KfSW78SNJ8DPIrkQ4u9keOgHsGgPODE2O7iq3K9D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4399d5b7-94c5-4c8a-3dad-08ddfa747168
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:40:18.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vcs7EtCo0qtbfS7oJ5pagbBGCQnIrhEALDMpQemQopeohePkZ+4ktZ6y+ljP0c13vZF5Qzd+AORhjJCllFsfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11446

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock. It's an optional signal added in
PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
reserved.

Since the reference clock controlled by CLKREQ# may be required by i.MX
PCIe host too. To make sure this clock is ready even when the CLKREQ#
isn't driven low by the card(e.x the scenario described above), force
CLKREQ# override active low for i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card at this time.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 43 ++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..6b03b1111d06 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,8 @@
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
 #define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
 #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
@@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 	int (*wait_pll_lock)(struct imx_pcie *pcie);
+	void (*clr_clkreq_override)(struct imx_pcie *pcie);
 	const struct dw_pcie_host_ops *ops;
 };
 
@@ -149,6 +152,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			supports_clkreq;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -239,6 +243,16 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
+static void  imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN,
+			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_EN : 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_VAL : 0);
+}
+
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	/*
@@ -685,7 +699,7 @@ static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 	return 0;
 }
 
-static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+static void imx8mm_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
 {
 	int offset = imx_pcie_grp_offset(imx_pcie);
 
@@ -695,6 +709,11 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
 			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
 			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
+}
+
+static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	imx8mm_pcie_clkreq_override(imx_pcie, enable);
 	return 0;
 }
 
@@ -1298,6 +1317,16 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx8mm_pcie_clkreq_override(imx_pcie, false);
+}
+
+static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx95_pcie_clkreq_override(imx_pcie, false);
+}
+
 static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1322,6 +1351,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
+
+	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
+	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
+		if (imx_pcie->drvdata->clr_clkreq_override)
+			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
+	}
 }
 
 /*
@@ -1745,6 +1780,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	imx_pcie->supports_clkreq =
+		of_property_read_bool(node, "supports-clkreq");
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
@@ -1873,6 +1910,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1883,6 +1921,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1893,6 +1932,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
@@ -1913,6 +1953,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-- 
2.37.1


