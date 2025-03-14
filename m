Return-Path: <linux-pci+bounces-23756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F810A6145B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 15:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31157A5048
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AB61DD0F6;
	Fri, 14 Mar 2025 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="cSDebQ9z"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2112.outbound.protection.outlook.com [40.107.22.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FB1FAC34;
	Fri, 14 Mar 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964388; cv=fail; b=P74niEhUoGgkyn3joTwasGfWJGJGecqpgL79JKoKyUoyqlK7VE3JUaRE4OYeTqnuB236zgfLZRCCnWQckJTJo06nl4atjai5p1GzZFcfTtcu4hLmmAso39wQZDW3NSoN5Uo8Zi9bbOTyv5I9z77RfH6qR0c8LvbMTY9N0yb2q/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964388; c=relaxed/simple;
	bh=P7y4qHBgmJb+H0e3i6ZBmNN49EDLy+0nzJvtfd7XEJI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=GIRoGVkHIw9Mk9Et38/TeA/o4cXLNBbaPsPW8AZwgnDpm097VB63hKY93ky3E/lactrzaOor6qLLJdyDYxi2rl4G3jKKa5mVYVaCLdxLv/SuVGpahdCfKOZGsWwVN9tQzVwjUadkrffaRKrQDoCynT5KhZhwMiZd/RRmcKCkpW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=cSDebQ9z; arc=fail smtp.client-ip=40.107.22.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO2BIhMqHZVHIOJbwsCGjysNHxNRHfGdDBpWeW1VpZpn7yvrc6E/WSQgQSuxb0WRtaAgItR5qtqI8Bx3ea1y6ELDhv5FBVuXOjNRBFUHROTebxFRmW8oY5qV6LlIWTQSMgC0dKODlKBbP9Cg46YL86osmtn/9oiShvh+xwaN5nChImj/od37LnFoTQYQVwaOqx5D9FaoUPTUy0Mx7ibHM31oVFf+g+N7W2CPifIXmWBZWaoJj1vqheu9gZKcS8wYPpYwFpdl5pPY3kIAVXNL/I4pjUxumzKK0d2WWRAStXIaZBEurinENoVM+ws4PVCrj420xSy/Qn1qQR0MoVu75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DasCPADCDjnV2jDDFR92iEghmdulkaTefmYegBGMoq8=;
 b=KOpBtHb3zo5/Rs2D6KfYp6sPLOBR5SywGWX6QRsStSZT8vYC0hvDstO8Tp/Aan9m72GoCaJw7ba2gqJNZxfJ/R/m0Ou8BngNysoIznVtjmZ80py3JDQ/b1AdUIbjcnZtgtCLLvRWOpCEdYzDpXvuinhBJbFeidtSurlZ5evx/gCLSiOw9TyBK4tPct+7bFoYCEwrhClf6Gqv6ZLOO8GuzFvgkhvL/Ci7ZayYgBP20Sg62YUTrYuFiouJ5Pm9X1ASuM7QbH5yRiFru+wjwF3BvQGvN94KRuJBUNYNZcg+g+c5lAc4KW2GBOsgCJYn0ZncLWOg8+hRxtweCqgc61FgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DasCPADCDjnV2jDDFR92iEghmdulkaTefmYegBGMoq8=;
 b=cSDebQ9zag0fleVIarqgBRZHG1os8lTuC1cfk4Oly1Wf9z6hTUahrxbMuhA+rW0jb/11v1QxXlpgIcl5II5W5BN3XYY4Ce/S3gbKqLsx6SSh32Lwb+9lxvlvyI26+8iNUB5Ec5IIIHA2dNgANmAi6jKdREsw2WHVyhQehxC9WhE5u9SABVBzvSZEydU/tdJ2+n8ccgBhigi+qSMOm/MuKhRMeNeYKB4AYKv98/fodBbwoNXkg5dLG7HhM6UU1h49Db1XekmYLAl1GE7ZDi6es1BBQTQfChhchQpQFT/GApvnCbaXdSvbNyOMqC9aB00rSKFsNy8fkdHKPX4Y3kujJQ==
Received: from AS9PR06CA0422.eurprd06.prod.outlook.com (2603:10a6:20b:49e::6)
 by AS8PR04MB8120.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 14:59:42 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:49e:cafe::93) by AS9PR06CA0422.outlook.office365.com
 (2603:10a6:20b:49e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Fri,
 14 Mar 2025 14:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 14:59:41 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.9) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 14 Mar 2025 14:59:41 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DU4PR04MB10483.eurprd04.prod.outlook.com (2603:10a6:10:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 14:59:39 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:59:39 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pci@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pcie-xilinx: Support reset GPIO and wait for link-up status
Date: Fri, 14 Mar 2025 15:59:02 +0100
Message-ID: <20250314145933.27902-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0126.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::43) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DU4PR04MB10483:EE_|AM3PEPF00009B9F:EE_|AS8PR04MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 0369ea7c-3f6d-4f0e-c500-08dd6308d9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?JZS3fSnyBQntrSu3919hOoDYRHOW4is1FdiUw+B4ieLzBiJwlmxXY1p/UcfH?=
 =?us-ascii?Q?V+lJv62+lld293htehF9SdgrckYwPj0F1oDj+Rdl5Esh3h3YMeyEpyIN5Qis?=
 =?us-ascii?Q?NSSbpHGthj2UU50Wjwp+A4OPWZAI4lm87YEqx7uWDN0NljU5RLkCJjpx32RV?=
 =?us-ascii?Q?KMW1EKwRs7bbXvcxUGEwovTuyZr3LutVTsNjglkRSzg6GHdMovel9cuw6Ea/?=
 =?us-ascii?Q?xpqA/nnwol34myuYA//Kqhpl2/hJNrqIi4t2AcgsQJlv7RcPWvtfQYkwRLUB?=
 =?us-ascii?Q?5eWi3lNiXskyiqZpOdqGubaONF5X74EPpsRcWLVUgXnrCwQOMT8yhNvDqsvB?=
 =?us-ascii?Q?WG8PJPyhID1NP4yaF7SSh2HehSwcJyI8syKMG0PjxZyMuxlre+JEtvUqiPQx?=
 =?us-ascii?Q?3Lg4WzKnksqJqrzBrRNSGWcHzSMeGV23Ic2IcSWY6aS7iJ0ytEmHhicps4+7?=
 =?us-ascii?Q?GQ4iSk9gcnTw9AfVlQECZxXo0zDSFNTQAc/yXqmy/QBnBR9gQPch/rvQM98c?=
 =?us-ascii?Q?9KFBbtAPQJ4/oAWbY4adQMzRbR6U9HECYxRdGDXirPUKUhVtJMsP/xb9fdWN?=
 =?us-ascii?Q?4xb7vWGzLZ6vT6oEg5Mjs+aK1AZo8Nfu2tm1O8uHUumU6UCzJJ31BiAcWG8J?=
 =?us-ascii?Q?lr/Wm8Ar7OfjNDeUp1gSklW5UM0Qpx130JS/O0ITkyBlhXPeFmkfbhtrXlj7?=
 =?us-ascii?Q?tcoMe0FJa9Hm2J6kxMqs7CXmOYkU4LFs0Q7wRKtpfEJqlvzzi2xhxq+jmNLF?=
 =?us-ascii?Q?AYxUFJosUImhRNRpc2prlEAt9G7ojOBuQRvYRekDFGAXIKqgB4+Q140xyyGX?=
 =?us-ascii?Q?fMl3UlOSCsZU3JwCEzvDmXQ1lKQ/QIe9iLmv2AG9ma8X0QEJJR6/hpWSdrDS?=
 =?us-ascii?Q?V7omkLb3EmSCwmucnt0Tc0X/Fe8urhfD91pZdBqdohdF6OF/NL+FRd5Jdp13?=
 =?us-ascii?Q?tW067fwB6713fz7mXgKCnmdWnE/lkAWl8mPeWfxL3v/A4+GjhiyZ9Ws6ei5R?=
 =?us-ascii?Q?T3K192YmaFL1krMvKO6jIV5JvI3WizSXEMmG9hFCAH2J349CGn81rdekWzN0?=
 =?us-ascii?Q?cuXVKBjKJrNwmzkMKIttHWMTXSwGLvDxbYbgM1ndBa40uYFY9UeWK/4IZ+PR?=
 =?us-ascii?Q?j+TfhD//Sqhphp8OZqbQP4rTLWGzQ2ODJfGu3NLfjAx6kFnI2Mn4ypypn8ga?=
 =?us-ascii?Q?eEhQV0hTLez3SMDRZjzjuoqc/dMbXw4Hac5jJ6TWFBbYen6289n5BcPQclKX?=
 =?us-ascii?Q?iaFtxN33gUN6f8zqn1rbdYH7FUBddLDkqegu++DHl0z51IFVrozCAR//+yhj?=
 =?us-ascii?Q?/DZrRi+IRM4tmy8v+95+Ta8nXckXbmwobOxUflf3a4bR2Ptys4cvBV4x4no+?=
 =?us-ascii?Q?GFFI7j+mvK7qzw3cq1kp9bL3o+toSIm7+NPDUEjiYah9uZUR+Q8eYkAUZvx1?=
 =?us-ascii?Q?kI/HOEcXHvKTvXrmC6+BRW/COsil2wUd?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10483
X-CodeTwo-MessageID: f3928d99-3d05-4cb2-aae3-0b2d49200134.20250314145941@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c4ab15e9-561e-402d-bf39-9e852485e4fa@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	06cdbf93-5668-4437-9c56-08dd6308d813
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|35042699022|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rlVh9MODRyPRFUeLqN5eaGNCJDbJOSd1zTa7Zja3i8HqtqZn5iGr91nsl6/1?=
 =?us-ascii?Q?gKMeaqba5+hzlcW07xk7x2M21I+zVjvcUIjcw0YcAqV5cNt4ojxRTbYJbdnV?=
 =?us-ascii?Q?PitcVmrFpFOvxiHPQETphp338XmrQwG4hmpXAfKFO2ScLDR7vpAHjB5ViBor?=
 =?us-ascii?Q?26s3AAwKbQuUCaxsHREIhcWrgQuqof5oG7INGENAYadskb1MBadFktIpCg8Q?=
 =?us-ascii?Q?VdJGCfLmPa9KOisDkU84MYQlTw2awNrgePw/Me7G+26Zkm6Xu++g4dyRU+n9?=
 =?us-ascii?Q?VXee7IlpI10Z0A3puDwwGJnq4PGZ5uVU+uPJ4vLXYp9O4L+0aKx+l46bmr23?=
 =?us-ascii?Q?Os4D8qRaOGWfwiDsE8DhU9Ej/zRky2ARFFxHN5qJrFSpOOhOR4u5o3TJCPL9?=
 =?us-ascii?Q?kkxZncoThUhx4eTZkwCfy94vce0YVZXgf9/VO2FzGDD6JkOT4HX+1ZBvbRoV?=
 =?us-ascii?Q?jH4sJI32+/a9BzsKkrJdYYLD+zgypmpP6WIO4DDpH2RNkdrQBHzSDsInPyLa?=
 =?us-ascii?Q?HCOKQCcUXlRimKfI9/5RL7n005tPYJA7lPXpscQbJwVHMZgpP069g3NCLpjt?=
 =?us-ascii?Q?+IhBt/9iRqav4Y220ZeFecbqtCYc3NIYmQA7CtDZRk0eIuq6JO7OPOxsR0wh?=
 =?us-ascii?Q?XevAsbdf/N8mLhTYeBEVd6gTHzS6yBPbqBasB9sfT0yDrH65U7hnO+ElxLM3?=
 =?us-ascii?Q?0v/4qzlHDiRsatEV0hWoCOZhfC6xA+KAwMgPH0dnYBggqkT9Y6jof0VaKuJF?=
 =?us-ascii?Q?G2cRObek9YYzL2JsEVFcETkKZVLEDXI+l9NiB7nQ1yiPIJY33lRQBew7It8B?=
 =?us-ascii?Q?ozlJSfxNdbc/CISZi2LrkH0Tk5CvD+Wbwnu669Wo9wtibEEyKi072nUZ9bAr?=
 =?us-ascii?Q?fnksspk5zwRK9fe8p5A+BJESYWS1jrvIzbTjWDTlMM4gFMlL1WFQnsu5tcXc?=
 =?us-ascii?Q?Uy2Ff+pCH0qMR94r/K0JXxIZ93c3DBoyqRnQLrIn+XtD8w/W/7INd3Jck2U7?=
 =?us-ascii?Q?gQrRZAEMjoaY3YaG6lpk1eFPwOFd9htrX6hFtemB9wAbTzaIe64igLYQggrK?=
 =?us-ascii?Q?WncoUEEMKdQ9EEkVD1uc7CuV5vTi0Xy9FEqCbsFRJm07N+PPS++u/TxrR4Ep?=
 =?us-ascii?Q?NIXgm3QhW7TKOfnjMfrx3wPtNw8fX8G+beAeGWlS6xaCN/4PgCirozNmAGGd?=
 =?us-ascii?Q?O7bDcmVca9laRraZCXBir2kFXTa/9d6DOzZ/InZZGtYEBzfKIAC5UWsmodHZ?=
 =?us-ascii?Q?uCA+9ZglipkpEozTJgckeKHCgcG4ALgJ0nEWTHbcGxhnCc2guYxqWMqSbPtG?=
 =?us-ascii?Q?kI9PbQHuzLjhJF9uvyHli5uMQ/+IrEHVHYdrg3JV95vCsi9FIzNMiA2naDAS?=
 =?us-ascii?Q?TwkJMzcTDKCZIwD1t4zek5HxDJFvffyj7TaCLwS01fSWHEm3Fb1qEsYy5HQ2?=
 =?us-ascii?Q?48lYMRoM2L4=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(35042699022)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 14:59:41.8533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0369ea7c-3f6d-4f0e-c500-08dd6308d9a2
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8120

Support providing the PERST reset signal through a devicetree binding.
Thus the system no longer relies on external components to perform the
bus reset.

When the driver loads, the transceiver may still be in the state of
setting up a link. Wait for that to complete before continuing. This
fixes that the PCIe core does not work when loading the PL bitstream
from userspace. There's only milliseconds between the FPGA boot and the
core initializing in that case, and the link won't be up yet. The design
works when the FPGA was programmed in the bootloader, as that will give
the system hundreds of milliseconds to boot.

As the PCIe spec mentions about 120 ms time to establish a link, we'll
allow up to 200ms before giving up.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 drivers/pci/controller/pcie-xilinx.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index 0b534f73a942..cd09deba0ddc 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -15,8 +15,10 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
@@ -126,6 +128,14 @@ static inline bool xilinx_pcie_link_up(struct xilinx_p=
cie *pcie)
 		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
 }
=20
+static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
+{
+	u32 val;
+
+	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
+			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2000, 200000);
+}
+
 /**
  * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
  * @pcie: PCIe port information
@@ -492,8 +502,21 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_p=
cie *pcie)
 static void xilinx_pcie_init_port(struct xilinx_pcie *pcie)
 {
 	struct device *dev =3D pcie->dev;
+	struct gpio_desc *perst_gpio;
+
+	perst_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(perst_gpio)) {
+		dev_err(dev, "gpio request failed: %d\n", PTR_ERR(perst_gpio));
+		perst_gpio =3D NULL;
+	}
+
+	if (perst_gpio) {
+		usleep_range(10, 20); /* Assert the reset for ~10 us */
+		gpiod_set_value_cansleep(perst_gpio, 0);
+		usleep_range(1000, 2000);
+	}
=20
-	if (xilinx_pcie_link_up(pcie))
+	if (!xilinx_pci_wait_link_up(pcie))
 		dev_info(dev, "PCIe Link is UP\n");
 	else
 		dev_info(dev, "PCIe Link is DOWN\n");
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

