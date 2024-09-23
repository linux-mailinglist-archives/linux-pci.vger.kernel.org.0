Return-Path: <linux-pci+bounces-13387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5997F0ED
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 21:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594F7281DCE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA61A0BE6;
	Mon, 23 Sep 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XdpthIi+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79161A0BDE;
	Mon, 23 Sep 2024 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118023; cv=fail; b=TkkXSIP5K/tZbHPs1q7vpj1xUC5ewcZvPSR/l/62mqd21M2wX3VwjmfpGrUAN/UKTP+U1UE4jgewYVj2kDgCWdYpDhZS9lXJAL208NORTd0P6dG684m1dEGJKySJj3KQry4QFwrKaP8ruxH2eXndgSkUMZKMOqzd+jYK8CE8Xds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118023; c=relaxed/simple;
	bh=xBMVKn21RPS80T4SAkqfwyKN2vEMUSzyklVzf6tRkTo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AUtEIl6vkipI+WM976Fw8V2PQIygGV9XV9iM9RnFsyNSQduNbz0t1oToCA6jnw8QV/nXmVixrb0RUbruZrcL72BAF6yZl+vwKjdc2+GnkT37S/GRnQv7w/oPkiQfoLb7X+25dGaE/xh7ezwwYKkyfrtZ0/ytmQC8B5OHUMvgdTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XdpthIi+; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxK+wRI19KHGNCtazkBgAU3d0PjlxkLl79qnhZnfoleck2v4120Y+NDQ7PmqV/vfKfdmIVvG3Wejd8h7Nz3I66c+J+NEuCyujeHCQMBqDwQtOnP3l0tsNEMLuI+cW0maZNInyYcwCzbF5iDg4WpTI5Ki4MeYx7BHCFngjFLmve7nGus3+WbcFLZfZ7lYukuYhTUKs9fqz9NMhNKrDnXaVxU/8Ac4ec6kP/r9dJruWvzwgVl+OqMfgXLIwFHqWDruJsayEvQFy3Byu8JbZ6UExurt9C8iFTREeDNgp4meZrzqemNIUnpoV2i6s/dBOUK/hH7t7oFBLDG8FSVxNsezbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzUSrlm+zJ/50bZADmWnNagaGfKuzqI28+YUGF5rjhw=;
 b=OpWQK5zweH3hRrFT4wFRaFgvwEsADcpz0t0SKU8BHAxOvfiKJQH0bidraKejG45eVR5V0Gjb+Y51o6WXrW7XNDhZad0JxesTLleq3su0AI/NFBjjYEBrZMvs25opOlqYL88/qWw7sUtdwXACRmM3qLR8rmeifY4JZ0fk9/q54Zeg8rOI02EWHkXi6pE8qbOVGTD8A3ajZNu4JJMPPdE2EncFuov9hir8W/P76jzrBBQYaeRkZFKzaIHm2rbw+LDTvy/Y3+a8pUG0XiRNxNNY8Wl4Pdj197gUCP1FofoKauOglwtFohczfqABtFMNhtN9Nbf/7lF9mxjYgGfV9gqw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzUSrlm+zJ/50bZADmWnNagaGfKuzqI28+YUGF5rjhw=;
 b=XdpthIi+KdM2mjIggtuwin976qtPf6jdmVMDvJEFSUtOtXIBi0eS86i3FbE7xno5TPEpdbfsKO3wn4yVUdUGZTovpser9wkKMgqrw1hPYKyZKsilU9c1uCT6k8ZYZC+LCPi4T0EpdNZ8t0AIOoPVnk4J06z/xc81JwwwCpgVAyKE7k8SBlmBoTqHt8eas0wvVaYvum0xNpiIXPq2Vzmk578Y+UjfW8XfAeq0f41QnpZOXm/ex7KnqA2AQnpr9QgiRxRZS5VXL47NiIW+PVv5NPM+/nrQO9DDcFADsQUKcFZ8JJIkMkDEwiEr76Kok1UuOsvy83G8JUO6FWr+7ywOQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Mon, 23 Sep
 2024 19:00:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 19:00:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 23 Sep 2024 14:59:20 -0400
Subject: [PATCH v2 2/4] dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible
 string fsl,imx8q-pcie-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-pcie_ep_range-v2-2-78d2ea434d9f@nxp.com>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
In-Reply-To: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727117997; l=2111;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xBMVKn21RPS80T4SAkqfwyKN2vEMUSzyklVzf6tRkTo=;
 b=FR05rrpUQQO86aIYr2NrF1V1AbdgBT9zKqDtShSLI5OhRFLw3ZX6PSX83c/OvQ7qlx/yFG487
 A0TlTWIhH0uA90R2FfJvWNWpe5z8VlFDdOBx0sA6GDvM0i1JJ6tt/7M
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f8eaf8-6797-41ab-c2d4-08dcdc01f55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yy9jREN2aW51akZjSVhNa0g4NzgzWnlXUzFySFRwU2lkL2RwdWxFQXp3dmtv?=
 =?utf-8?B?NlIySHEwTzVEdmVNY2dRcSt1MmY3NmdlN0VLdGJ3UExZYmpkK0lKWDlrUks5?=
 =?utf-8?B?aG1SbWpRRm9PYWptaFlZa0VEZ1NPSTVjU3dVNjYzc0ttd3R2VnZFcGVPL0ta?=
 =?utf-8?B?SHM3cFF0ZGFrZXJOQ00xcy8reTV5OEJHS0lDM0pYTk1qMk1FbVh3a1haN1A3?=
 =?utf-8?B?UGd0SXNkbTNBL1pBbGIrcjVCYjVwZ0hNdGFMMGFidHRyOG5nOHFqMEQzVU5U?=
 =?utf-8?B?K3lrR1h4T2ZFL1JHZG1wSFhnL0I1ZVRoT2hwS1lieVM5M1VYL1NGL09DTWFw?=
 =?utf-8?B?NWs5bk1OMUg1SzBZM2JvaUNBOHBlSVo4VFFSMGp1TFF6OHk3RlZNT2xFL2Zy?=
 =?utf-8?B?YnRyV1hZdHIranhJZzJJYk13Y3MzYnA0NFdpMDc0NnMybWRlT3lZSjM1TEV3?=
 =?utf-8?B?ckxiYnpPUldWd2l0bEppRytIWUFCejV6NlBQV3hOWE1LdmVHaUlqU21XbDMy?=
 =?utf-8?B?TG1LaVBaK3hVYTFRVkwrcHdyaWtzMFFwbkVmbFg2VmlaSEI1S2ZuYmphNUQ0?=
 =?utf-8?B?OFdPTFp3OFVHcWJsaDRvVlhaOThodmh2S05xZ1duYU1aMHdkWFJ1TTVLQlJW?=
 =?utf-8?B?NXZ1bUtzVTQ2TGFWellMOUk1WWxBaHk5QitNYVVkQ3c2L3JnSzBCQ0FjZkw3?=
 =?utf-8?B?WFlkc3p2OHB5Q0hHMTYzYU01cURtbCtGdEREdHJFK0Fua2RXT1VNSndzaVJh?=
 =?utf-8?B?eUFRK0VlZnBrS1RpeUgxODVlcjllRm1WeEpLRi9INFo4NjFTWHNNQVhTUU5w?=
 =?utf-8?B?WVV1NzQ0a3BLajlsVjFMU0tnTjlZU2JSVTVJdnFiMVh4ZG56MFp0ekF1eklp?=
 =?utf-8?B?dEM0SU55b0MwOWE1ZXFCTUVIWlQrNVMyemlEUkdSQi8wUVBrSjRaOVRiUXJH?=
 =?utf-8?B?blhPdSt5MUw2eC9sQkc4alZRZUYyZVczY0g4eExoSlROUEtoSTRIMDBZUjJx?=
 =?utf-8?B?MXVDMVBjLzEyWW40ay94M1BheU9GeVhodDFPeWhMb1ltclZYd0k0VmFvS3Vl?=
 =?utf-8?B?bVExb2lFK3FiMXRXR0V1SUQ0cHJQSmhhT3FzeStoZzJOUVA1UFgxc290TjlV?=
 =?utf-8?B?UG9Vd3pvT0tsU1hGek9LNWpOY2UrQ3lUalFQamdaRmdHY1ZOTEhYZS9KTmpv?=
 =?utf-8?B?b0dZcEVmRTNaSGlQRE9VZzd0MFcrWThsSFhjVXZ6UHh2eElyRmRHMG1RTXdS?=
 =?utf-8?B?SVZDQkZqZ0dnUVN4MURjQTZDRis4MzBMb0pKZTRHUy9xaXVpUFJxMDhkWW5N?=
 =?utf-8?B?Ui9ZRisrZ3c3K3FKT3lmRlZuV0xiVkVnOFRrOXhtdjlITWI2VkRMdGVmZXFp?=
 =?utf-8?B?V09zUHNISVdJNTkwNkppMHQwVkdDTFFYUHk1NzJFM3JJN2VmY3I2dkdqMFNJ?=
 =?utf-8?B?OGUvdkFRaU9scUJPcDl6WG0rWFBlTkpMS250R1JqZzFkWXRKOHBIYndPTkJr?=
 =?utf-8?B?bE4rMDAvWDYydTBFTk5HOFFLTC9ZdW5qUHRKMzlGcTFFUERScGJvUWQzK01k?=
 =?utf-8?B?K2RkNnQ1R21uZlBuRW5ncTlFc2RlUngwZ2pkb0xKRDJBeEVKYjlWcG1mMk50?=
 =?utf-8?B?SHdXbERMVDQvR2pzbUZERFAyQldEaHljZUZ6cDJYMVJsOVBlWjZzenhDTEtM?=
 =?utf-8?B?c2Y1S3BIY3lnSUF4NGtkUWFGYnVDck5UODFZUzYzUzI0VVdlbFBpbUkyS1Y4?=
 =?utf-8?B?QjJKNGQ2VXpBZEdoeUx3ajFOUldkQ3FzSWRpb0I5K2NhdXJOK04vWXlNOU9H?=
 =?utf-8?B?LzM4LzJ4UW96MHBab2F0VXBrc3NSaHM0Q0JDd25MRkZ2R0tSdzhORGpveTJ4?=
 =?utf-8?B?SnFoTTV0S1g5eGlKS2tkcVExMExWTDJIdTg4VFlKRmhVYlpmT2xuaFRhT25t?=
 =?utf-8?Q?a3KfhT0hU7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEQ3QVFnYUhyM0Q3UzlyaUtBT3lPSWpScFpqWE50OW1VSFlQMDZVT0JqLzBx?=
 =?utf-8?B?K2hOK3IwNTdNSWVRWENsY1ZFUVIxMitwOUJCSnpnbHRKalZKcFlQQ21YdW03?=
 =?utf-8?B?d0krTVJWRXlvb2k4NGNMOE5MV1E4MDRtQWJTU0hYSEFQbmVlVXgvbHdjVzRP?=
 =?utf-8?B?ZTgxQjBEV3JaQ3dwTjFMeVNkUEVxbXZRZmhPQ0RRRUFuR0ZydG5KTVJqdWFV?=
 =?utf-8?B?Y3BCTmdQU0YvaHRxQVFhcG13KzB6Zy9IOC8vMWl1eXZnVEoxUDNOcDk0SFFW?=
 =?utf-8?B?RHVLTit1ZEI5aFgyeW5oN2tacm5zQXptVC90WkwzTkhqNTVkblF2QktuYnVh?=
 =?utf-8?B?WXVPcWtvN2xEZ1BZYVNwTUt4NzdEMGw1bEF5WTN5UUExNzZYbk9Zd3V3bjNB?=
 =?utf-8?B?OElHUzVUdkU3M0hDYlZRQ1EyMTllVXFBZlpZbVNFODhGSHFwMmJBRnJEWkpu?=
 =?utf-8?B?OHJxN2piREZkKzh5eDdzRW5XM0JLdkd1eGpJZnpSWTNyR04wRE9hQ3NsWGhQ?=
 =?utf-8?B?K1V6Uk9vQlRPbU04aEVTRk43bUkwdlJKTUJObDdKa0g1MS84K2xTZEpFcDVM?=
 =?utf-8?B?emhPWFZidU91YUMrVzBBdGV2NE1wdS9jcnVXNjhKOUtRSncvSysxYys2Q25r?=
 =?utf-8?B?ZHI2dnNjVEJZaHg3V2pnVWtQVEdLWW4zRzBVZDh0aW5sdlJ1VURpMUl1dkR4?=
 =?utf-8?B?aDgzNEZ5WlF4aGRubkFSY1h1L0h4QTNYQmVQNGF5VmtydDR2blp6V3luMmpk?=
 =?utf-8?B?ZGF4MkpOQ29zRUxJY2RHMXFkUUlHMkhZMUVGV1kwYVJHclpzMnUwYUdTQU9P?=
 =?utf-8?B?bWgwejJDK2JqTGNWZUFVSXlrMDNWaHk5MGxGUEpWcUozcHJyMUxOa1ZXL1Bw?=
 =?utf-8?B?ZHlLSmVkQTJSWjRDVDVVT2trb2t4NlJNNzY1UDZpajU3NjlIZ09STmpRekNC?=
 =?utf-8?B?TGcyclBZcmkwQkwvc2tiWWh1VStXT1BIdVIyUlRyR291TW16TEEzUm9wcC84?=
 =?utf-8?B?eUhvekdXLzh4U0F6OGJ1VHk5ZDQ4MVBTV05QRVZxRExsdEpoNmpDU0c4WFd0?=
 =?utf-8?B?b3JScktGd2t0NDdwdW5YSmlCZWtHaTJhK1czdGVsMVNwelhremlSN05YMVBQ?=
 =?utf-8?B?SzRUM0licHp6Z1RNdVp4ZlhsY1FPYTZuZ2NOYkxmSlE2Sko0byt3QmN3cTd1?=
 =?utf-8?B?SmhtOTFSenBKK0F3M2xlWFZyWUk0NTRLbkNJREJXQzM2NnF0YlFhMEJ4eUFH?=
 =?utf-8?B?RDFqakJ4c3g0Vlo0UXZVNGtmVXE0cFU3RER3cEloOXRYcU5EcVFPbkZTMUVn?=
 =?utf-8?B?Nzdkd0ppdC9PL0liREh2NzB6SGJSZm5ySnFtVURLZXEydjl2TGtHTFpjZWZD?=
 =?utf-8?B?SkN0TVd2ZXphYXRvR2NZaEdYZVNGQjRUcHRtcDN5cjd6SmR4S2JGamd1dHhq?=
 =?utf-8?B?ZGdwam9HWDV6WlRTZEg0MEJ0dnlDSE1ybWxzMEY4d0dDT2d4TGFLRXBXNWpD?=
 =?utf-8?B?c2pwS1JlT0F5NWpjcHJneC9EMXFEajkxQW5tT2Rlb0hsem5lOFk5TGZSOWND?=
 =?utf-8?B?OGdydlQrdmQzaGx4aTlCcElaQS9jZGUwU0ZXdlNCeFY0NTZlT2VrTWhBV1Nh?=
 =?utf-8?B?QXlOTGNOT0lqdmpsSHlaVk1rb3g2T1lnY1A2Vmljd1VsNXA1djZjdDhyVGpZ?=
 =?utf-8?B?Q3AxV0JpbllVMjUvOVBSQ3E2cHExeDVkM1d1ZUhmWmdqbHNoUUU0R2VFRXhK?=
 =?utf-8?B?UjlrRTk3TURVdVd4bkxRVDRBN1QzV1J6RVRpWUZZSHRRQnZXYVdYNnJLcHBw?=
 =?utf-8?B?WlJucERJMFNVNWs0dllxSEVVMWtkcm1hRnc4dDlhR3NzejdXeEY5Y254akFF?=
 =?utf-8?B?TjZFM2REZzBwZVhuSW9UaFc4Q2lQUmU4bE5hMHhDclpwV3hoUkpRWHJKU0Yv?=
 =?utf-8?B?OFdYVVFKcmFQR0pjVkNxTmdzZnR3MzhvQmlrN1NRVVppd1JNRkdTL1ZlYkdL?=
 =?utf-8?B?RHBPZFNWbUpGQ1RvVkFqTTJjT1JxRzFFRm43RGJESzdZaW5TQU1GRG9rZFU5?=
 =?utf-8?B?WEg0WG85aW5GWEw2WFQvbjBHVUtXVUk5L0U4NUlnQ09oZzBlaUJqcDV3NmVk?=
 =?utf-8?Q?m9Tc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f8eaf8-6797-41ab-c2d4-08dcdc01f55a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 19:00:15.0036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ob/c7yUZwsGVS/HV9ppGjEUeM/7CepG+PwSNOYRW0SEmDNnH+/c7KG8e3eOeRTMqFG3EBkcOglvulWVh3sHOrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9562

Add new compatible string fsl,imx8q-pcie-ep for iMX8Q. reg-names only needs
'dbi' and 'addr_space' because the others are located at default offset.
The clock-names align Root Complex (RC)'s naming.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25be..7bd00faa1f2c3 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
+      - fsl,imx8q-pcie-ep
       - fsl,imx95-pcie-ep
 
   clocks:
@@ -74,6 +75,20 @@ allOf:
             - const: dbi2
             - const: atu
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie-ep
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
   - if:
       properties:
         compatible:
@@ -109,7 +124,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-    else:
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
       properties:
         clocks:
           maxItems: 3
@@ -119,6 +141,20 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imxq-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
 
 unevaluatedProperties: false
 

-- 
2.34.1


