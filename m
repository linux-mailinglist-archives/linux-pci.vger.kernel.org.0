Return-Path: <linux-pci+bounces-34265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00BB2BC59
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14272178083
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41B315783;
	Tue, 19 Aug 2025 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KGqaAElp"
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013036.outbound.protection.outlook.com [40.107.44.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE742056;
	Tue, 19 Aug 2025 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593973; cv=fail; b=fipCNbROlTmkvl0CxrqSgTcn4aT+DOIVNgN2zMIHsX9JWNqRX5aWTxLP8ka+3337CbekVSYLM01VpZmp7l1A8lE98SFBC0XcIBmit6KL+oqK07fCBxSjW6QLl/sEKuSpGUgB2m8FBpAhPqipaLM7OgrkzU+CRm+m5y7nv5fe0L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593973; c=relaxed/simple;
	bh=/sR/uVmX3rgyN/GArZ5nr1o5mESqYbQjR8wlVJAOkJI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dhLsh/1Lw+NMgXKUzt/AeXzVcy/f4d6mWjS3PvxDfjeIRu9vIUO5AdGt8uGwqP0t63hU7yQQrx7PM7Tkki9Bge30+bq7CHX3Hbh0Jkd6ZQL+b9Z6I+BV2kUqaeaawDRwCsKDekMS7iakqXcX4sc+CHzA2QNqPSm8x1hlw2QD4js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KGqaAElp; arc=fail smtp.client-ip=40.107.44.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYOBb9svfzLK/xjIXaqV4Usl6JkD++AVhP3ocZR3Kf9C3ds1pNGNJkTYup0MyH0+iCgJQUI+ucMiKgXelkXolY1gY1ojGC/cxlCG3DZoOK4ZynnF5b8KjDFpOWTzKOL/x92IJaPQ6wMrTyWbhM9G9kOpzD78CekiJ47wsqhiF2ZSDPEZXtjR0yD/4Srn5GJojnqoTvmdLZTMVzLNnRydpnmDVAIUJXmNPWPBrcRrUny6G1wT8hl3w/YLpiO8rAy2GothE0sjiHVHgh3pCgy8LyhSIq+dfGB7+S4hKzQGohsq4QhrQOu0x6mDhyWc5UXsLbQ6TAKyLXDRmECnwAHT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv16V9v3RK54AEQ5MqjpoRGZ+wIPu4rEQiedwikaKEw=;
 b=fYEEMwRHoDX0o5guInWjRGm0/b6jWAUnpmhnU8vYig2VMxwFrtgs3W5sO6I9RMZATUm61e6pXsbp0lXss+H71BE5F4rL43Bidr1ocrlPNSMydOzB3lNtEm7UjkrYjSDPvk6SweRd59cGI5phUPut+NFELZ36Qe8UmQOkQSkzsakFvmiFPn+jJfOTjT5dD5TLFl95SjsqAzcvMrZwtFjKWkeVf4Q/vmHiLh6JEzOxRu3/1yN8dKSwrdg7QsPiz0NxOU3RyAXbaBemwK5KL0cuD35SIVrcMr7FlzE+X3CfoR3I+yypGEB2j0uAq/6U0p0YSBz/vum4zAOBG+jj8v8MXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv16V9v3RK54AEQ5MqjpoRGZ+wIPu4rEQiedwikaKEw=;
 b=KGqaAElp7OYITge8bI5f3DO27U2W+BqjdGA8fN6uYGiw6vE3ihCEJggcp30YYDYhEHgRd6eoLvHlFTaMFAzuwl9HQMAx4rDvR8oUWcrbop6WYjzYUEqQHLMGszASY7eYGq5kXijwfYCsnxoKYJ0sO7JeHoGUn4V79vnzn++Plj6kQ+uvIPa43qaVvbGrDnZ1Tf4qguu6G0PNOh7j5PdNbVaaPD+lB2YPghmJgq4D+5YXYS1SKVPTrrn2e9FkDmzvf5ye8Ku/eEBFM0xEY2+lPmg5q155F4x1zIy6+cLhA2gWs9kr3wGse2ICD9UHXzPlhGxLZKhzrfTXzG1frULXJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6345.apcprd06.prod.outlook.com (2603:1096:820:cf::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 08:59:28 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:59:28 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Hans Zhang <18255117159@163.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] PCI: keystone: Use kcalloc() instead of kzalloc()
Date: Tue, 19 Aug 2025 16:59:15 +0800
Message-Id: <20250819085917.539798-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0165.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::11) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b08542a-2929-4bbb-1083-08dddefeb440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AoC/ebvnNQc0MxGAgqCg56+SfYpxkBmG5u9eDGjZhRdVdIG7RlfyttTma/yh?=
 =?us-ascii?Q?S195jN3bH25IrrD2CWKjjcwxbrTrWaKih+9ApaMnlXXXPHkSjAHLW7+lbZQh?=
 =?us-ascii?Q?MM43QpNlFh4DItYfXu9pP7e/9hz1cBqTwKXK/EYGINvtN2U9mYpFnYKkl17B?=
 =?us-ascii?Q?hFQx56zoz3fyJe/DSStN2npYe73nfz4jFUYKwBa1Kz3dhNaYda8tcDkgLLwO?=
 =?us-ascii?Q?uCjVxCAunDyakiJdFZXgd1HOyEaTvd6oW2t8ERpLbGSiCR3F4l/tQieEckL8?=
 =?us-ascii?Q?OlENiOFsx1lTkHNfoFyrnhtFJNS1HVAIo8G9DgKbAwSQp7OTRvKkCZ8Kfuru?=
 =?us-ascii?Q?07l8bqdhy3I7IMaEoEMPdf509HNwSVIgzukukEI1klTKRcZHyCrMQxjBQA8A?=
 =?us-ascii?Q?vBVmylNrzyfMUg7ib7r03C6IC2FwTrFEKfDgHD8bAA/7QJnoA2oRnb5JL1Cn?=
 =?us-ascii?Q?8A1Xs1Y9AQJKf8ihhqXyTTap0WTcd3JypmdOb2T9ZR5uxIJabdfjUv+xzOpS?=
 =?us-ascii?Q?4KjXnlLye2QWy1EzQtVukQThWU0rhV5RhO5ZIG4Ir60SP9q7JpFylj+eh4GE?=
 =?us-ascii?Q?QJwHjckMdjlNAOBzMYaPdsvrIU+/aHvvEox/rhIT218/DccWoWp/hTB3RKKL?=
 =?us-ascii?Q?IL8Bdt+a3vU1ISRY0CzWrbO+ECC+aTd/62vQgrhcxdHqQd5B5/EHaiKd8ra+?=
 =?us-ascii?Q?eIvZ5/A12bETBqOjRt/w0cheLaL2HXVQHjcP4A3PuKIjzWMX1h2aNiN1xTxA?=
 =?us-ascii?Q?y54i3KLhcbgBw5/myn7TT54QMAErlVIL9DVFqBwxQvy37uJAH4vePdxXXMw2?=
 =?us-ascii?Q?jwBrwiXQWP9tOm0LyxYT+U0AENq312ZJZJ9r+IRnF/VL96IyGJmX3jQT3LT2?=
 =?us-ascii?Q?FhYY0UpxzbzWADdGVgtw2CFLpB6pZoCfDqvUCEIghrBWhqVKbPBUNoltPAvA?=
 =?us-ascii?Q?CCK9pShBF1YLOp+DIdzajN7w0fXNqgXwl/URVfl5a33R1UX9Fiq3XfvNuQHf?=
 =?us-ascii?Q?/49JwiRSt67yh6YFKqapzehNnbmT9RFN7w7+Yofp98enNZjN3G6KqzofKv9i?=
 =?us-ascii?Q?KPCBUF7IfI7tTGbpHihpL5b/B9dWZmm34+iUYno136goSyIqRk0ZSazEy5BD?=
 =?us-ascii?Q?bB9lIeE9OpsDZxfLggU5rLGI7bI/QWAfjLh5ApPXrbmSyyYSFLrpXyExqFz8?=
 =?us-ascii?Q?nl1LA+bk0Tt/IkqRQfOzL5YpahbdgkIi+efaONKxQ1XS7j2Oxit48Kev9iVf?=
 =?us-ascii?Q?HYvXD9wIIkSzBUqfwjzMUILlrvVdSNxmW0t3uYPqhR6Cao9tjR6jcs/uXLuq?=
 =?us-ascii?Q?AiMaom0GbmzpGm4inhUdeV5R1oUqBYwM+1vcLmkSdQwbj0jWYeBxTz3OYHKI?=
 =?us-ascii?Q?yPbVWC+3OimXgT8h1Rk0ytCBUhSVnNmk1QjXidQYsx85WE79f13x/YwKQAwU?=
 =?us-ascii?Q?i+JK0vil0y/ylqd1sX16kNZAAtFwgf8dg+75d6yuC1fXT/OBFD+Tgi2Qy15w?=
 =?us-ascii?Q?/X15aDo6uQ/XJ04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JivGAjUwP1Mrc7OMd+3H9MIpKlDCC/YNB7EXxZHwsnB6YufPHbxaHsNZ+/tP?=
 =?us-ascii?Q?G4G0pSjgRKsuD2EQHRGRmEXHJFtkCC3MIzV/p/fyS+4v0+g5QEkXBADwDNLt?=
 =?us-ascii?Q?yqEu4Tv1kUXEQ5APerxlc+50C6a34THXghH3+wLqStgQ2KuR23ObGkvtm9Vp?=
 =?us-ascii?Q?dOAeaxCeAgbGyiLO4l7D5sv21rKo40ZjX05CPRMERNpL/hP5ag9MW9TKlCMo?=
 =?us-ascii?Q?V46WDdpRILJbkICTup4y5UFL0Ibmv6vOCPfW68mDj2v4wMr0GqH4eTHbGZQw?=
 =?us-ascii?Q?3QxzflpMiNsiuFgKSKJXJKNwNx5pgwR0okFWGvUTxlB51pl2d1RKgh1Z7V9k?=
 =?us-ascii?Q?HD0E2xYBxthK2bStDon+2Gszb5SoYejzBAvNc8XOwsYljOD4pVjOre22WV6S?=
 =?us-ascii?Q?Itsi65VADPisfzYgfj22wjm4Sw3ZCJ59hjoKUm2JgrUjuHt6PSg0b4OsU3lu?=
 =?us-ascii?Q?wibZIU6pPq2O3mkGFocQl5pLVMbUvEgyDy/ZhspAVwgYkBw/i5uFhDSiyTiP?=
 =?us-ascii?Q?Y7S5w/rI5mdlnDmHEJUU8sH2sadQX/PuEkvLyd5RMYZ+4uKLzMVM1RkAlz4o?=
 =?us-ascii?Q?khxmhBHlLseHUEjeN+HKLJOA/RzWIDVEtojkby9L333wCLhsEIR/w6/NHnbE?=
 =?us-ascii?Q?2FHRhQgbHylrwQfXlheYGgupxaDCPePTXxuauSsnETg4nvDGVZyotS7WJgSF?=
 =?us-ascii?Q?dPs5z71R/UUHlafBW5BaYxnKGHrE5oKDwSJy1PbuctN5jRo1aAkGyep2YHlo?=
 =?us-ascii?Q?V4HMeKkaT2sWEvnyGsW4ca9lqMLOomCkGHBvvQT3KyVxa0txO2Ewu4R3pA3W?=
 =?us-ascii?Q?XB/GlY6ZFHpV5Xk8WLXiWMYxU3RVWkm1s9VJBO0Y7BVIYaa00VizaE9/Xf5b?=
 =?us-ascii?Q?o2efAkYnuHHyiHOtDx3dYsw94LySnXNHNRNgO8ojtDcBYxcJQHsJySLCkgNE?=
 =?us-ascii?Q?4gkcHDq8eWEkPXjXEHqVyehQBtRLYFUWSqt8kP+7Wsley1q9pShglbLQUXIj?=
 =?us-ascii?Q?gQHU6P7m67eL3ja7UC8NxrstN/WFDMvEz5u5AZR10Mw+6qwTGZ1tb73wS3FT?=
 =?us-ascii?Q?0GSLOkIN09kbSr9trXWk0w0uxb0aehFmV3eS/tSuwdpShQ7saFdI/3DjJRKX?=
 =?us-ascii?Q?xtaszJ+9HtH/udWdnrvNnXLVDeQw5gRC5BPtBZ0Laj0e78LxnkNRzD9a4CXV?=
 =?us-ascii?Q?cs5ufbB4eYEgyvs8d6x7t8+xrHIN+KakRKlb9VoiWYyaoyJgideGtmTla/nS?=
 =?us-ascii?Q?zAKOCk4P3ucH3UXXXO/nH3T8ptJHAz4oSd6Ty5tFtnDOIiUxnvSOTvupv0+L?=
 =?us-ascii?Q?MsxJDU5zS3opjCug60n9Lkzs07iFCv3fvokblO4rG70UAfT7vvUmRpZ9OT53?=
 =?us-ascii?Q?LR0D7+2b+IdvaMBBICIuYGN7mnCjpxtO2/h/mSuocEFT+pwbTT26JLkORj1V?=
 =?us-ascii?Q?Rj1OlztcFEfpU86d9C8I0aejBr6NYAmQ0h7rNrSmO4+VYOfScPl+gIo9P08K?=
 =?us-ascii?Q?/IINdOJiDbJa4nGd+ls3Z2pqOahZRl9mQRXPHviFs4gm3RMap/BDl285W3nW?=
 =?us-ascii?Q?O0zzZC+CTCacSe0PkhnkTWv31W3ijjwqO/7ajuep?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b08542a-2929-4bbb-1083-08dddefeb440
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:59:28.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50lSDNl9HIuFlkgzkTbhGgs6HLe3VTMlRcgU90YkxqRrqbt3ZF8WYgbkUAAuy5MxIvTDlmp2KEQ9emqCZZIKEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6345

Replace calls of devm_kzalloc() with devm_kcalloc() in ks_pcie_probe() for
safer memory allocation with built-in overflow protection.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7d7aede54ed3..3d10e1112131 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1212,11 +1212,11 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		num_lanes = 1;
 
-	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
+	phy = devm_kcalloc(dev, num_lanes, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
+	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
 
-- 
2.34.1


