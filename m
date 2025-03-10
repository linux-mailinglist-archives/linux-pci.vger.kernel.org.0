Return-Path: <linux-pci+bounces-23364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F4AA5A4A0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DA9171339
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4B1CAA6C;
	Mon, 10 Mar 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MEDKCh0T"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE51DDC36;
	Mon, 10 Mar 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637848; cv=fail; b=pPfEoBZJvAjib/RJNLurCMPrmFQ/ipCZvV+/t14sOvrBtt98Rj9Yv/gc8g/zwMz2rz3yWuDYH0oMgPTC8+o4uReq/wLtrD9F9NiPFObbqevQwqTKLTu2313EUqka90ZAdxKC8thQzbq+yqW4gZqvHaN7l2oxaty8y+Dl1KAKC/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637848; c=relaxed/simple;
	bh=GhWYz5HcYm3OAMKz2PmWS29ZgS7yWsv5STiuxZVCogM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mczRz5e2555oDEf8EalOt16X57wwHoNbzIlmf/8uW09DP2UumYd4fKdZhlflcrIJTQ6zHF0FOvEIukaNwCF8LaxzdpsmxgCHjidz1n67wdz2pwPz1aYUu2L3fj7hPecsG9d587MwaGa7hmXfMEoxZ3Fgj6PaVMZx9QmqArNbu3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MEDKCh0T; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soz2c03uUnKZL2jhyktvtmYgtPpMWqXZ7xJ4YEY2kswTCjKP7bt/n1f6NbZNjcE6OaOfKadokj0+6a0ytP0qJ2xVrRASuoljG4LzHyiYPQ49R7+4rk5B+fxabaQjv3Bm3OadkIj/5a6htSNV1K2o6SFp6RHF+CFdlXkMmiKQAsK6lIOUxF1MOEgJ6tLhSGejibvB14F+sHcZHibC0+UHFHwJUKxzdfBPxdTYcCi5I0ATAlXUtaQoAhpzgK0dEEj5pr7979Skhl65Pk/hi2yyhKqBCzsEgXh/d42VAneYTKGSwT09RabyLmZ6MhxWUGDBslC7UaMSYte2eBAl8loCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HxuOEZVhNafxiCmkc/toHtjLW4vDiGTAjHZhLP9vTk=;
 b=nZktdXheesE0DSBP5rGCSrm4bWr/+VghYlhC5L90pUb8390kxEPXZJcHbWt6UPLh1nM+JxMHqr/v8WS6SpLMpSwkVZ1mQeLSWKO9/ODq98Nh3mAHaw2EWiikm2jWR/nJlrCM09JNEuyqdex22OH59zNTqz13oLgaIF7zLA1ZVsLvgdpK9CEIdbrhHdJIptlg4PvkwHqssT4Dw/8gpRGnq7o3/WIBN8So7xQaGI5zsEqN0sgyyROU3vEp3UBEfXKiTDXIDdxWTPajeboijogRMVGYC/mbxCY+HPULZLKJiCnaCOHCv3Lo4NuiWt1jmBAhNYIsH1HNC7gwvCW8AB32vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HxuOEZVhNafxiCmkc/toHtjLW4vDiGTAjHZhLP9vTk=;
 b=MEDKCh0TCzpvy9XBvK6O3FsH6GoTBoZ196QblYaT2s9ViZ6Izm8MQErVyXWesAYPWG+Zvt84eACIsVjxpJuQAFWQiuabaZTS83kXexyzGaM7B67zSqUIHgoJbIpIzwolnZNlFBOz5tPcX5BDVw9RAPCZf9/40+hnnA2uQUn+2FoICyUsqfHTijXFIKZqxKVAirSr68D8WuQ6oi3clWc8k3HFoqoo+dzHUxaYAyeBSRrTkHhAbUOyd50jaav6/9BMyikHd5EJykKx2uqF60j+s0OjqfMShjs3ArdsvZ7GhO3GAqTa1fHUguEOM4d0bUAj8g+XDgyGEAq1BMqsKyORXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10682.eurprd04.prod.outlook.com (2603:10a6:150:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:39 -0400
Subject: [PATCH v10 01/10] PCI: dwc: Use resource start as iomap() input in
 dw_pcie_pme_turn_off()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-pci_fixup_addr-v10-1-409dafc950d1@nxp.com>
References: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
In-Reply-To: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=1364;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GhWYz5HcYm3OAMKz2PmWS29ZgS7yWsv5STiuxZVCogM=;
 b=WLcg7Pn7NMuD65venfBLnLYrGCBpC6jQLImm3BJIMxDeMMQS3o8c9wyYnRfN/OGiec//cTcdc
 R72DrgiHLRgAcSV19ztKwivUGQXtosNiUFEJl4yNGmpRSOwA9ys+9WV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10682:EE_
X-MS-Office365-Filtering-Correlation-Id: b9087607-f00b-4a2f-f6f4-08dd60109206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFhyeHd0VFYyWXM2V2Rxdmx6Ynl0OEtQWUh5bkFDYTB1Zi9xengzNnFQYmlL?=
 =?utf-8?B?d2FCRFc0bEJoV1Z5TE1ld2xzM0VjdWN5T2ZLSUZkVTlvekVXTkNEMnRreTEw?=
 =?utf-8?B?MUVEZGVWRlh5UGZzTTYxQTVJS3RtbDhNSFB1WmkwMHBIYjFlZXNLVzM4V01i?=
 =?utf-8?B?V0UzeFpSeUY2TW8rWUpRU2ZhemZRTlhSMktKaEJVVTRldlRDb0RRbkQ4dUp4?=
 =?utf-8?B?cUxRZjc2bUNXVWwzeUFZeGlNRGFSVitlcDBjczNDYU9HZUEwZWowOVhFclRp?=
 =?utf-8?B?eitCcHB6ZExMN3JncEVJM2tnUmpnNWFaVUpKTGsyUEdadFQ5azhOZnpMc0dZ?=
 =?utf-8?B?RG9mYTRlSjFFVUsvbXFjM2lHSUlodE01S1JpQXdNNjc0WWQ0UzVPbDBMd0Ry?=
 =?utf-8?B?SmpUeUhjMG0wNjIrV1B1aFJmUWhlTkJjd0RYVXZLMkRKQkYwcEpxelRkblQz?=
 =?utf-8?B?S0MzTWd0b0VyaFBvN2YrS1FKOVd3cjFlSnJQSnVyY05QWmhVRlZzbTgvVVQ4?=
 =?utf-8?B?ZlBpaG5BNUJMa1ZJMllpS29NZytIYUVEVzlueitPQTF3Um53ckRVV3ZDK2hK?=
 =?utf-8?B?Nm55dm1xRVN6MllnV2FoQjMxdnJxemFkLytRclpsWFBRRVlkcGxzdmh3VVBN?=
 =?utf-8?B?ZjY2YVNJeU9oMkJyeFlYQWU0UEc3d1QwcGtjUjhCVUZpdnVURW1qNHZTbXRB?=
 =?utf-8?B?bmExYXpHaWVmZWtQZWxyeXVGQVRpb1NZdXo1ZzlERlZFbHRaVThWYUVVWWlB?=
 =?utf-8?B?blJkTzJ0ZkdmMnFaT3g4RVUwNUM5a3I0UXlZdExqUi9SWnVVMXVKNFpmcEJ3?=
 =?utf-8?B?RUJvTTBKNEs0cUR4WDNEeld2ajZ6N01WNFJORlE4S1MybytUNlBONXZHcjlj?=
 =?utf-8?B?MWpidGtDN25mMW9pRGQ2cXJpeWlCcThBT05reDhYL1dtWXZYRUcraW1jZVBi?=
 =?utf-8?B?QzFqeWNvbXpMeFRadlNOeTVBL0NKekcrTkFISVhlUmtja1E4TmduemdsMkIy?=
 =?utf-8?B?RllnSkRYRG9vVDNGdllhTTdpbm1Nc2RLUW9qdnVHTDBHSlFZMGFSbTNBWGNt?=
 =?utf-8?B?bVFuTTc3WEpsS2dUdlpwOHBOdkR5M3dYUEJVTm1MV1RUcjl4MGdQRWMrTU12?=
 =?utf-8?B?b2dVM01JZVdQc0VPRDEwUTFqNkZuVnY3c3BTQUZyS3YvVmEvWXFkNU50b2dG?=
 =?utf-8?B?cStrN216N2w1eTNST3h6dGdHdUZya3AvK25TVVoxMzNmMnlYUjVYNndwWlpo?=
 =?utf-8?B?NXJCcjlUWlFEaUR0b0l4YkNpOU41VTJRTmcxcjc4SzcxTTRPTzZBaGZQTS9q?=
 =?utf-8?B?eW1qZnRWeVlDUkRLRDNTYzBkbkNxVXAwcGpqYXN1ZUtnYmQwdFdZajR5REdq?=
 =?utf-8?B?TkNJajAxM3czc1QxYWw0UlRxVUpFV1BjTzV5S1lTMXZULy82S3poL3E1dGgv?=
 =?utf-8?B?SFk1S0dJSjZXa0lHOHQzTGcxZDFRU3RXV1J3SElsS3I1SnJMZDhQdzlMb0po?=
 =?utf-8?B?ZXB5SW1Yb2gyZXhRdWpCNWN6RHp3M24wcFNnS3dFVE5Mbld0WTdXaTNqM0Nk?=
 =?utf-8?B?SEFnY21WMzRMTndITzltTUFoWi8wbFFtRzJEaVlKWDlFZDRIZUVyamhPckxR?=
 =?utf-8?B?eDV3a09kNmZMV0crWlN5YlFKYWtjbkEzczJIRUI1eHNoeG1YNUdpZzFNelBi?=
 =?utf-8?B?UUxqZHhSbEtkU3J1VnRnZCtuaGVqWCtpMlR3aVE1RWhUMmhnSTNlVkxKUUd2?=
 =?utf-8?B?MDNlSk5ucmtKS3NONld2RFEzMVRsZmt3bDhlaUhMdmpabmNrV1Zna3d1YVkx?=
 =?utf-8?B?WGJHWTAyRytjQnNnTnhERzJtSGNoYVFTU2pVSE9mSTlnZnZ4bklGSHFPMkwv?=
 =?utf-8?B?N3B5NHRseGl0dWJ1dUp0MjYwMnUrZ3BXcThiWXNUc3hBYjRzcEtzeGNUajN3?=
 =?utf-8?B?cTVkRGgzZUVJOHQ1ZXJSWEdRcmIwaDNNVW1WWnltZU5yK2lhR0NMSkNBak9R?=
 =?utf-8?B?ZGJnNW5NdkR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlZFaUZseklZQmtJcTRVYUQwQXpiSFBFVm02Kzh1RUc3dlhXM1dYeXpWYlU4?=
 =?utf-8?B?SnlpT2hHVmhWT3RMK0F3OUF1RTFxL3dwemNZOUZBVmNyYlV6L3E3bUdjQkl3?=
 =?utf-8?B?K3p3cTd3RitEdUduRjVXcXQ0TzZONE9NTWRVS3QrTmRyWXJpWXJTcUFDR2Zn?=
 =?utf-8?B?VVJtQy9JVDNFMGgrUS9hVU5lY3hLdC9ZUHlHY2RVRmZVRksvZE1tZ0hjc3FU?=
 =?utf-8?B?THVQcEVpU0lUNTJiMStJa2NWUzhUZEdWWDlKbUd6WmpSN2RGQWoyYlBJNnZn?=
 =?utf-8?B?dUcwUWpQRFZBRG4zeS9aMmFBWGlML0lYejZnU3UwQ1lMcWs1S1c4Q0FlMTFX?=
 =?utf-8?B?NDJmbVJiSHBvZndkVFNvSDAvVkFQdDdFMnlGVXVOSXJCUHNuUVlKN2FNdzlm?=
 =?utf-8?B?QnlmSS9XVC9rR3Y3ZXlxWnlLbEpYaDJqbDI3eDlWNmZMdWxBUTVYODhKbVdD?=
 =?utf-8?B?WmMxNG90MERvbzVUQlp6TG02V2R5ekptZlk2YlZGMi9CQ1BCWHVXMnkxZlF4?=
 =?utf-8?B?NGJ5NzhtSHh0Ris5TTd4QkJ3cUs4Y25iQWRPTE5nL1pXWEF5NWZxbjZOTWhw?=
 =?utf-8?B?NG13OVByUjhnTG8rUlRqNmdhcU1aZEJTb2JLaUFYWXZPQXE1WkdvRUpEbGZV?=
 =?utf-8?B?QmFoT1c4Kzd5R3lCekdnRjI1ajlJajlsUmRZanBnZ09Kd1BBNXd1WDRyM2N0?=
 =?utf-8?B?WE41a2xhSUNmMkFxTGlOQllYU3R2K3BndzFDZEhvY0NsczJ3b2ZzeUNmaVdS?=
 =?utf-8?B?MFhvU040TVYrMllnVzNtL3JEanRxcE1XK0xhaUhhdFZ5MlFpRmlkRVdRcWpF?=
 =?utf-8?B?ZS9lM043dDFiZEpucmVnMTZrSmM5UmdtOEhBWFliM2M2NjZuT0NTdjlDeERH?=
 =?utf-8?B?VTVxeXdlakFCc3NiRWdPVnEzY3ViSms5RlVUWmtzb1pKcGJYckt4d1djQTJ4?=
 =?utf-8?B?TkNhUGphSjZYeXVJa25SMWlZRzVETVFrODgzK3lGT1BTL3ZEblNUdklmRkdT?=
 =?utf-8?B?QVh4R0h0bVh4YkhVbno1aDVUTkdvb2NPN2lYaXUyMFlJeGtQY3A5WDJ5MlZW?=
 =?utf-8?B?cFBSOE8xV1ovWHZ1aTJJN3hneWQ0blJFNWtncFF1aXNGbFVFK002ZmpHVmpW?=
 =?utf-8?B?aHR0ZDhkVHNmRFRnVm1IKzk0VnIrZmZmQ2xIc3IzUFdHTzBpamRjeTc1MFpt?=
 =?utf-8?B?dmNreVVlYm5HYldvcGFhOUlqMlFHUlZMV1Z4bnhHSmVEbTVHYkVLbTkzSVhF?=
 =?utf-8?B?K01qQmcwWmp1RVBVN2JtQ0w2S2JIc1dzcmlCMXhoVkx0QUZkWFNOd1VMUHRZ?=
 =?utf-8?B?bFkrZnlXanBVMFBuQStxTHllM0lKbU4vZVMzUjdtSkJYYzhqQ0pvdklHZjZI?=
 =?utf-8?B?UTFWZlBqNS9yTUM4U0ZkME1jMjdFRlB1Tm1sU3U4bGE2ZTFscFhaczRzSjRq?=
 =?utf-8?B?L01kVWlqM1hvbE5DNUlwVDJ4U3BZTWxVRGJwekpldCtzOE9QNTQ0c1Q3RnBq?=
 =?utf-8?B?QWlhUDJwcE4wYm4xT2lhMlphQytmZlpFOEx5Wm43NnkvMy96emEzc2dYOTdl?=
 =?utf-8?B?c1FHQXgzaVBSQVVYdjZmZXhCUU12NnhuVkZYS1pCeStQSUh5MzZoamtVRjYx?=
 =?utf-8?B?ZzZMT00waGRIeU1aS1MwQitGN3lLRS9reEY2bllURyswTktOSlpja3ZZSGha?=
 =?utf-8?B?M0F2YXhKM01xbFFQZFViQk52ZXNVUzg2SmZMNUNYQ2lvWFdRUDNIcnF4M2Fk?=
 =?utf-8?B?YUY4YS9GSytGOFd1YzRPRm9RUXYxa2U5cjV6T2lFYzZTVHJoQ0N4MEk2SG5Q?=
 =?utf-8?B?Z085blYzYjRxbEM0dlZ0TlNCdDl6ODdkaDVRR1dVVGV5Q1pKM0ZrdW8yVFhH?=
 =?utf-8?B?MDV1K2RjSEprUXJzMlExNW8xOGFpNWQ2MFh4ZnlyQUlJd0J4NDJvV0ZWVXhy?=
 =?utf-8?B?a01NNGVXT3ZHMy9Sck9OUjZ0aHhMSXc1RXVWOXZHOVVxM2pkVlFtSUVGaWd4?=
 =?utf-8?B?RTZmRUZBTlZVYXBXeEtyM21yRFZGaHk4MFpEUitXOUhWKzF1N1dJT3NWdThK?=
 =?utf-8?B?WUpvd2NPSUN6QzNubFgzSWtWeThUVlArdXBHRUdsUmxXNVFVZWJ2aUdVbWpO?=
 =?utf-8?Q?L6cY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9087607-f00b-4a2f-f6f4-08dd60109206
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:24.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBs2XbWopM5yj/pxDdTsOmKASDkt9gv8r1YJoBPJ5WxsAt+GceOQzMnk0dF+hAOY9eMhKwPtWv67TEQgCbe0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10682

The msg_res region translates writes into PCIe Message TLPs. Previously we
mapped this region using atu.cpu_addr, the input address programmed into
the ATU.

"cpu_addr" is a misnomer because when a bus fabric translates addresses
between the CPU and the ATU, the ATU input address is different from the
CPU address.  A future patch will rename "cpu_addr" and correct the value
to be the ATU input address instead of the CPU physical address.

Map the msg_res region before writing to it using the msg_res resource
start, a CPU physical address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- use bjorn's suggested commit messaage.

change from v8 to v9
- new patch
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7b..ae3fd2a5dbf85 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -908,7 +908,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	mem = ioremap(atu.cpu_addr, pci->region_align);
+	mem = ioremap(pci->pp.msg_res->start, pci->region_align);
 	if (!mem)
 		return -ENOMEM;
 

-- 
2.34.1


