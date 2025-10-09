Return-Path: <linux-pci+bounces-37778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FBEBCAD98
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 22:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BE15354639
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 20:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA292773DB;
	Thu,  9 Oct 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G8gLNZtj"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC82741D1;
	Thu,  9 Oct 2025 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043312; cv=fail; b=rM+3h6GP2lULfya4Gnq0NrnI0Fhu95Fs0PaGtL1tv+SFF0r7BfKAAuYCoAStfTMMGp5fHJAP9MFXgDrPd+DJzu4DhgEkcuZ3zQf/r1xidxL5TjTbz7A+KSWRQ6Cj8i8DTT/wtwmH3slA/6I9QALcgJgO+0fAh/tgTvxaxCpvNl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043312; c=relaxed/simple;
	bh=d0jjuVYo95icEyMMHbl1KpYVYqWEhYeox4Hu6bQaCUA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=byPlUUfxslE84jScld/PAAjezeupcOoj2RPiXkdJMQaaltD5yeFJYF8tAjEB/MazaKtjaHybjIZ3OOwvtKcji8NVbiVVRWSk/h1H6q2evFAZk/6O9CAI5FPQ9Tnimb5w8ILAx1Kl45UCHt/KJ06iYjDmQaD1EH4dG0FNFgZrGVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G8gLNZtj; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHnpfnpzXCNKXRNu3KnfFeduQYErnIb56yWxu42Dy/HwV9vm7iVf6cSucxYSMX66deH5vi37s8m8ioA/Zt8Ki+a8ImVQ+pFGe9ylqmsQWMG+wmfhMy9l0YjX1PnQ5rrOcZxOI4mx8H9kWe75s4OTmfDqvD7BGAw8PMDZiDNTZKFvt4UtXdEKebGjGXdH9JhRkFVCef/Clyz1k7jkPgLRKJ0EWhLci9DkasQBc0cbymPW+U+3ssnGBQID/CEJUuic7wyvn7kDnjOxoL41cdOMCafHgbR1B8krOlzYE/cg4NJ84XbdTlBc09HuPnAAx8vL3wDKMiOm5SmYCVGazxT1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y4e4S+bLanAvLAqO9fT65YPozTC12pO5ZF5Aywb35Y=;
 b=xsyBn/2Nw85EOpQFqF2d6FsplJziKXiF+tFg8Sr8b4R751At+6g1evO6beoyd71cnRfvht+CwBubmVwQ2TdPxJLMZr1QMjUEugUc8iO0RNZ9NYWp4n+U5qnD705EQpzntZN3iobKd2o4Ya2Y4OUDDvRNPJPuJnicFQEv38sBwUjdIySJKyMA4hrH1m5QlOXp13wppiFK336Z4LgwSPuItSvoU8Bq81qaKIkJutbQ9jrQ6ROocz1xpmVuh1RdvvvaDS7YHSJUtmvGS20/afMSVxQP2xuaZGr9xASVXlwTmi5rd855UsZUFmSXt7bq8vt/Vj+aW6BDaeIrM0fvcW0/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y4e4S+bLanAvLAqO9fT65YPozTC12pO5ZF5Aywb35Y=;
 b=G8gLNZtjrbQ/hK+38QWqXX7u8hz92GBNVFclsFSZpP4WTCbuNwt7xgWXE2KMtypasL22IZIFg3+vr5cMZuEiQlxs/BdkLcyPTmXo9MxiDph63s3Ypn0cPsTVf6vv5b+mSnCaTvymAywzHSvHtGsdoeYtiovOEDbhqsQPv5nJIa0tXSysiImd6EFpnwfFCUGqaHcVusfqjH+M+drvWKOAvDsOm2zSCpPNjVvbgm/SMIBg09iVJRyfsCoU2FlyFWS2aiF4kUEQMWBcqC7tYcSAepPaMUq5DGsH5qzYfGU6K6kqA8FoRjuhdBbtrG0HKtdiDjqEWn3917mk14p2KhBu2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 20:55:07 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 20:55:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 09 Oct 2025 16:54:38 -0400
Subject: [PATCH v5 4/4] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-vntb_msi_doorbell-v5-4-4cfb7b6c4be1@nxp.com>
References: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
In-Reply-To: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760043291; l=7571;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=d0jjuVYo95icEyMMHbl1KpYVYqWEhYeox4Hu6bQaCUA=;
 b=x1uJdVUi/XziUX4sy3QHK75pzEVnu8ptVk/sGp+9PirhWyVPi9oQcWCyR8fEcJyesQaxNPpWM
 JUKj8EyXSPECi2cuFEaGXAtvOTbA5LDWmLtvvNplQvD3H7IQtHd9zxm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 12111187-6993-40db-979a-08de077620ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1AyUTFqL2RXaDBQUFVFV280OUtjTVdTMkUyZUdhL3FzWFhSS2dld3dDQjBx?=
 =?utf-8?B?cVN3R3dqc3lDTFI2NHp2VDR2RGJoZHllZWkrUU5zUDV4Nmw0WDd3czdKcSth?=
 =?utf-8?B?RklEYTlBajJaNHpza2FXNnREN1pyeGlUYUFLZ0R0ZGszaGVqZHJjcTUyMC9O?=
 =?utf-8?B?QWo3TkhOTml3d2lXWlJxS1Y0Z0k0QTBvVzRVaEJNSnN2L2p6eDRvbWI2ZUNa?=
 =?utf-8?B?OXN2SGkyRTJsTGRrcGc3TmZ6VUdpNll6NHNKNHJRSU9lZjljekJEekNVSnlD?=
 =?utf-8?B?SXNlQVM2WmxoSjRpWWpobUdHb2ZBWWdDS3Z2V3M1M2x2Q1RBcEJwTm9kcVRm?=
 =?utf-8?B?VVp6OVpheHdHYnIvN1VUckN5TWZ0U3VqZ1hzSlNwSmJVSC9DYVJOMWplSlMx?=
 =?utf-8?B?NjRHYWhvcWdEd2xUb2hQWVJvMjhBci9uYTY1M015UjVLU0sydjZVWHBqL0lI?=
 =?utf-8?B?RFZXV016WTJoZ0lZQXNHaW1kc1lOQ3FJcDJHamhlcDdRWUdsWTZGcFROeURW?=
 =?utf-8?B?RFlJOGowT3Yra3ZDR0NhL1Y2Mi83My9TSkJzMXVWZnBCYklvcVlKQTd2TXQ2?=
 =?utf-8?B?Rll3eEFLYU1XVDhacFpTbmlvSVUvd0dibUdTVk8zc0dyRmN0a2ExMkRRczZL?=
 =?utf-8?B?ZjlWUkVPb1ZUazJnNDdnSm1QWDZOcDhNY3I5SWlLTmVWSk9obVhucmZJSnlh?=
 =?utf-8?B?YjFyOFdCQkNSTW55azBuV2UzQVZ0N00vQXI3QWluNXRkaGNVTy82eWY4czRu?=
 =?utf-8?B?N1RRYXFiZ0pITjV6M2ZZK0pSMHl1b3dQM1I3Ymx1M3hYUzRaSmExMzNhSEoz?=
 =?utf-8?B?UmVvcmJyVHloSjg3bm5UZGtucFJsOXNqcDNERHJuanNNVndGRlh0bUxybGtE?=
 =?utf-8?B?eEdXczE0UVpGKzliRTN5QzB3UVJ4Y2ROWW5NN1FXbk1wL3g3eWlJdGtWWHBl?=
 =?utf-8?B?RStHSEFldEQycGtBTERxeVZFaVU4enlRMGZ2SU42NHhLaHZ2VHFmcXJ3Z0M2?=
 =?utf-8?B?elMvMnRQZGVPOWxtMW1rWENhOTg5MzZEeVp3M2pobTNNZnhZZ0NLc2k4NWNq?=
 =?utf-8?B?NVhFM2ZJKzdPa2xHWHRzL0RqLy9La2loU3VJeHVXZzNtc2I4dU1Jb29NNWwv?=
 =?utf-8?B?M2VZV2tMR0NKZHN5TDdEK1RXdHJCc1VkZmVGeUVjV3JUTmJZcno3Q01tNUtt?=
 =?utf-8?B?RmdEd05rZ3JCTFNkMFZjR25qZmR3SUNJN3RMekE1azMxNDRWaENsekM5cXZa?=
 =?utf-8?B?RFVCUTBELzNRWXBONVF2UklVN0x3WXRhMGpmbEcwN0RVdS94bGlyblFuYkNx?=
 =?utf-8?B?QmJLL2h6NDhtMGtReXVNb3gybnBkQW9wdWtXbVZSYjB6MmJaVjhrdmtUMksw?=
 =?utf-8?B?WnovQ0NjbkFJRE1mbVdWelhzL1QvZXVjWFI5d21MaHZiZ29XZkZVdDFQTGg2?=
 =?utf-8?B?am5GNUxwc1M1Z24yODROWWdNM2ZINExJbzhHbHlTb3hmSENGMThOSGZmSWta?=
 =?utf-8?B?Snp4YUwwcFhGcUJUQ0N0NGVYYjRSOUFCelVsWnB1ZDZ0bWo1QW5jOVBQazd2?=
 =?utf-8?B?c2VndTZmUFRtYlRrdjcrWnk1ZmJ0dkhLS1dDU1IwSldOTGk5ck9zRlNlL3Y4?=
 =?utf-8?B?ekdiTTllc0hVNjZsUmpFZ201dXQyenh2Sys0Wm43R3pscHltYUFhaFQzOW1a?=
 =?utf-8?B?UEpScm9vdGZoZUQyRDcyOTNCUzNGa3dOdkFSaE1ES0phcktmTlUxUW05Uk93?=
 =?utf-8?B?YVd2NkU0TUdvTUYxZHhYN0poNFV1WnZXaHMrc2d0b3grbTNrdWVMZ2dTSm13?=
 =?utf-8?B?dlFiek5QMzFpdVlLKyt0UnhrUXZxNkQwYTZGdWM1K1huWEdncCtuZVg5UWYv?=
 =?utf-8?B?SDkxM2tDVW1RRTRIYVN2MEFncEtJRXVDazBkK0VQQkVJSVQwdVJKL2U4aSth?=
 =?utf-8?B?VENoUHQwTG5CSmw3UWFIV1pqNWQwVmNkTGxzRE4yQUZTdlpvRVhubkRXV1dp?=
 =?utf-8?B?V3hnTE5zaHdsSllhYTllT1pGYVFjOHZ0cTVyWE5iUlh4c0F0TjVQUUp5LzBD?=
 =?utf-8?Q?0W0YoR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUU0dWNDZ1JISHhQKzdYcE9ZWlVlRnAyWncwUmgzUjltUWRxNVZFN2VOM3Aw?=
 =?utf-8?B?Q1loZEUwa2lGQlRsTE1qd1dDRXBDQnRja1djVWJ2NlhTRGRiQmU1VHJLZkdQ?=
 =?utf-8?B?Y1ZYc1hPUHV0bk9tYUZCd0krY3N4ekVNVnA5QzBuQ213RnZ0OHkvUFRudFdz?=
 =?utf-8?B?Z1lObnhlbWlnNDc0cTQ5WFl2K1k2Sk84dzFvSlYwVHJWUGVIZjhQZ1B3RFNt?=
 =?utf-8?B?L29SQlpWUjQxczdSZlRrdnJ1UTBndFhFTVhCZ1lZdkpSaVh6UTFxMmZ6a3FP?=
 =?utf-8?B?Nm1QeHozOUMwaXh1OEZaTng2ZUIvUFhncmpkTCtEcytmN3lLTDgzRGpsdGtY?=
 =?utf-8?B?bk40RnVtUzczV3BCYjk1MW9rVWpJbEV0OEpaWERtQVBsVVlQbDlsYjI4TUpW?=
 =?utf-8?B?WnlCa01aS20zNlJrRHkvWEovZ01KTmVBdkVieUt6NXRDakVwWm1nUStDUDFQ?=
 =?utf-8?B?Vnk3c3VueERXQy8veUhOd3ZlQ3praTgyVG9UQlFVdVJUQThOYzh4TW95UmEx?=
 =?utf-8?B?MzI5WjI5RFRVYVdUU2pOZ3JsQTB0RFdHWGJjQ1FZZWM5STRhblAyUEhLSDUw?=
 =?utf-8?B?aGtXUzJEZ2tWNFNaWW9neFFjdzE3M1ZNdTRncFFhWWVValRjenZoaElvdi94?=
 =?utf-8?B?NWE5UXplMGo5Zno4bnpmaTRubzBNMlQvUlVtbk1WdHNibitJYURiMklGQ1hL?=
 =?utf-8?B?NjBJam5WOVRid2g0a3FVdGIzRXZKZnIwRXZiaElpdXl1TmVjYkpxakZOUDZi?=
 =?utf-8?B?YWk2NzlrWTdPQnJMcDFqWE9KcFlnRzJ5R0I4VnVCdXdnWDViSDdTZ3Jvd2dU?=
 =?utf-8?B?NUM2a0pxRFpkNXJkM3BwT3IrSXdhL0xsN0FKSWlvY2ppWkJxMXhnODh2LzJH?=
 =?utf-8?B?dnA2QU5saVlGbDZ6L0RJb01SUHVYVEZXa1FtUUFvZUJIaEhMNHh0Q2VmQTJm?=
 =?utf-8?B?V0NrRkJwUFJHN1hPVmxRTnNzMXVnK1VUamd2ZHdJVFFTUWc4cGE3RlVMdUpQ?=
 =?utf-8?B?RXhFaERGRGZKQUg0ekh5N2x4ZVduL3JsYWx2MUU3MHZBN0E3VW8xeHBsQzhl?=
 =?utf-8?B?T2hqUFRjWGc0T3NEdE0rTm84eE9oQUIydGhsWHZkNjJGYUV2OThkemZFa0tW?=
 =?utf-8?B?K3RHMVRDVGh4d2hDa1gxVTlmNDNoRjVWWG9vMS9HR0I5b2psd2VQdm1qRENO?=
 =?utf-8?B?cGZKaERVWG4wYlBzWklOMDBXOW8wTGlUcmNzVlNxYkFlTWs0V2lVMlAvMTdy?=
 =?utf-8?B?ejVDKzZ5UzlSUWlrMjV4T0E3aXdJYWlTdXdpUGMwaHBrLzFXMHBibW5EWjRO?=
 =?utf-8?B?THQ1clNtSUtBekx6WDQyTlF4aWo3Vm9SczBNNnY5N3dqa0VvUXI5SWpwejAy?=
 =?utf-8?B?TnVTZDdmUEtlYSs5VlVNVWM1bW1YcldBWDlPUnhqaWZkaFlzbXdUOXEzbTdE?=
 =?utf-8?B?K3c3d1QyMVhkZnl3OXFtT1RnUUxmejdIY0J0YS9DMGRUODRvRG9QSDRrTklw?=
 =?utf-8?B?V0tOWk1HZkVXTHdqNkJDOU8wUmQvdElvM2NIdURDMzJDYmV2L0VJMVp5blk4?=
 =?utf-8?B?NlZXTThZZjJIaTYxZGcrdTJEVFg1RkUrUmdOclJiVkdtT3RuRkExMDA5M3Rt?=
 =?utf-8?B?NzBoNkN5cWRibXZRc2RoNFo4ZzI4bDNBWmJqV0MrVVpDWm9sNEkxVThBRTU1?=
 =?utf-8?B?UW9nYi9pRkFvdXRsc2Z4SHBHRWY0RW55blRFYTJNVHNiNW96djVmbG5XL3Nk?=
 =?utf-8?B?UVlNR0VSMXYvUzZzb3k3WEsvUEZiUUplUkRzRktQU3ZDZlJ2Snl4cVJsd1hG?=
 =?utf-8?B?OUJyV2dWdExoaU1RSGIzWHBnWXp3NlhPR0FIUndBcEd2TTBOcEt1c0hGYXBm?=
 =?utf-8?B?ME4xUHBENVdrdXFrcFVIeVo4VEJ0cjd6R0kyTGg2bWM4RHZNWGMyMENWV015?=
 =?utf-8?B?WFFkMTJZcUttYmhkTHl0OGtubzN2VEVTUVFvNXQ2ZFRtbTB0cnk4V2gyOC9R?=
 =?utf-8?B?T3QvN003clNpRlN3Vm1JbEVYN2VmbE1yUTNpVXlOUldmVzYrVUF4WU12ZDlN?=
 =?utf-8?B?djJZU2tlUzlvbmoySnZZVXdRQTczL2RZSVFveC9ZelVzZnpqcVRyQ094a3gx?=
 =?utf-8?Q?zdNjn9sowxNdn8EnckLoIDt+q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12111187-6993-40db-979a-08de077620ab
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:55:07.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQ8kTSGN4/IOfITa5fa1mJxA9Er0HySxdSq/vF5MxevV1jnstnJMs0hZjHCspU3IXKgNSkXt9HeTHYqgS5DF9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906

Add MSI doorbell support to reduce latency between PCI host and EP.

Before this change:
  ping 169.254.172.137
  64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
  64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
  64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
  64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms

After this change:
  ping 169.254.144.71
  64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
  64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
  64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms

Change u64 db to atomic_64 because difference doorbell may happen at the
same time.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- none

change in v4
- add check of return value pci_epf_assign_bar_space()

change in v3
- update api pci_epf_assign_bar_space
- remove dead code for db 0.

change in v2
- update api pci_epf_set_inbound_space
- atomic_64 should be enough, which just record doorbell events, which is
similar with W1C irq status register.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 152 +++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4fc2b485d5463faa2172500f12999..6e48a1efe1eb267c4c80c7c09fe1c6f73c7ccf44 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -36,11 +36,13 @@
  * PCIe Root Port                        PCI EP
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 #include <linux/ntb.h>
@@ -126,12 +128,13 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
-	u64 db;
+	atomic64_t db;
 	u32 vbus_number;
 	u16 vntb_pid;
 	u16 vntb_vid;
 
 	bool linkup;
+	bool msi_doorbell;
 	u32 spad_size;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
@@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count; i++) {
+	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
 		if (ntb->epf_db[i]) {
-			ntb->db |= 1 << (i - 1);
+			atomic64_or(1 << (i - 1), &ntb->db);
 			ntb_db_event(&ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
@@ -319,7 +322,21 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 reset_handler:
 	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
-			   msecs_to_jiffies(5));
+			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
+}
+
+static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
+{
+	struct epf_ntb *ntb = data;
+	int i = 0;
+
+	for (i = 1; i < ntb->db_count; i++)
+		if (irq == ntb->epf->db_msg[i].virq) {
+			atomic64_or(1 << (i - 1), &ntb->db);
+			ntb_db_event(&ntb->ntb, i);
+		}
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -500,6 +517,93 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
+					    struct pci_epf_bar *db_bar,
+					    const struct pci_epc_features *epc_features,
+					    enum pci_barno barno)
+{
+	struct pci_epf *epf = ntb->epf;
+	dma_addr_t low, high;
+	struct msi_msg *msg;
+	size_t sz;
+	int ret;
+	int i;
+
+	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
+				  0, "vntb_db", ntb);
+
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request doorbell IRQ: %d\n",
+				epf->db_msg[i].virq);
+			goto err_request_irq;
+		}
+	}
+
+	msg = &epf->db_msg[0].msg;
+
+	high = 0;
+	low = (u64)msg->address_hi << 32 | msg->address_lo;
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
+
+		low = min(low, addr);
+		high = max(high, addr);
+	}
+
+	sz = high - low + sizeof(u32);
+
+	ret = pci_epf_assign_bar_space(epf, sz, barno, epc_features, 0, low);
+	if (ret) {
+		dev_err(&epf->dev, "Doorbell BAR assign space failed\n");
+		goto err_request_irq;
+	}
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, db_bar);
+	if (ret) {
+		dev_err(&epf->dev, "Doorbell BAR set failed\n");
+		goto err_request_irq;
+	}
+
+	for (i = 0; i < ntb->db_count; i++) {
+		struct msi_msg *msg = &epf->db_msg[i].msg;
+		dma_addr_t addr;
+		size_t offset;
+
+		ret = pci_epf_align_inbound_addr(epf, db_bar->barno,
+				((u64)msg->address_hi << 32) | msg->address_lo,
+				&addr, &offset);
+
+		if (ret) {
+			ntb->msi_doorbell = false;
+			goto err_request_irq;
+		}
+
+		ntb->reg->db_data[i] = msg->data;
+		ntb->reg->db_offset[i] = offset;
+	}
+
+	ntb->reg->db_entry_size = 0;
+
+	ntb->msi_doorbell = true;
+
+	return 0;
+
+err_request_irq:
+	for (i--; i >= 0; i--)
+		free_irq(epf->db_msg[i].virq, ntb);
+
+	pci_epf_free_doorbell(ntb->epf);
+	return ret;
+}
+
 /**
  * epf_ntb_db_bar_init() - Configure Doorbell window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -520,21 +624,25 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_DB];
-
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
-	if (!mw_addr) {
-		dev_err(dev, "Failed to allocate OB address\n");
-		return -ENOMEM;
-	}
-
-	ntb->epf_db = mw_addr;
-
 	epf_bar = &ntb->epf->bar[barno];
 
-	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
+	ret = epf_ntb_db_bar_init_msi_doorbell(ntb, epf_bar, epc_features, barno);
 	if (ret) {
-		dev_err(dev, "Doorbell BAR set failed\n");
+		/* fall back to polling mode */
+		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
+		if (!mw_addr) {
+			dev_err(dev, "Failed to allocate OB address\n");
+			return -ENOMEM;
+		}
+
+		ntb->epf_db = mw_addr;
+
+		ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				      ntb->epf->vfunc_no, epf_bar);
+		if (ret) {
+			dev_err(dev, "Doorbell BAR set failed\n");
 			goto err_alloc_peer_mem;
+		}
 	}
 	return ret;
 
@@ -554,6 +662,16 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
 	enum pci_barno barno;
 
+	if (ntb->msi_doorbell) {
+		int i;
+
+		for (i = 0; i < ntb->db_count; i++)
+			free_irq(ntb->epf->db_msg[i].virq, ntb);
+	}
+
+	if (ntb->epf->db_msg)
+		pci_epf_free_doorbell(ntb->epf);
+
 	barno = ntb->epf_ntb_bar[BAR_DB];
 	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
 	pci_epc_clear_bar(ntb->epf->epc,
@@ -1268,7 +1386,7 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	return ntb->db;
+	return atomic64_read(&ntb->db);
 }
 
 static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
@@ -1308,7 +1426,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
-	ntb->db &= ~db_bits;
+	atomic64_and(~db_bits, &ntb->db);
 	return 0;
 }
 

-- 
2.34.1


