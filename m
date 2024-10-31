Return-Path: <linux-pci+bounces-15732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF0F9B8011
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B781C2194D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8451C2DA4;
	Thu, 31 Oct 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BaeYmn5c"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E71BD515;
	Thu, 31 Oct 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392046; cv=fail; b=Ig+0dsTaKGCMEs5EcXI2EotUDrQMTE9D0DwIIeOyfuObiOQcHa97Kh/6lC2IZVLSVRcuyOfmOMZFMGSr6qR+H64UJPwc9+5uYRlr8BLvw6uaoqhv/gq5QRZm0Tzg97+sw9MPQ3LJx4SQpIroO6ie1nSeIQeiWCo8LKQepyn7RG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392046; c=relaxed/simple;
	bh=/6ZgUJNg/AjeYkLGZsTbnY32/IdmcaPg9IbNO9whdDk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=AldiKY8BknPUfI8vuGYjcsvkDZhrraKP1/x9HjsEbUM0j6G3ZA+kjLcwn255JhTfXEeHa9/CkGY8lztSKOVuMmNCN6mRffH9/F597c3S4arFyoNcE6y3LwQn4BvuUUuz3EzWRibxc3hT4omRvaSvJBJbaAZ3y5CoZqq4YWZtb2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BaeYmn5c; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK/MXD+AfD1Zm26u+UABePR+1Z1NZCc7qn2GBzDvpoQ1+4v5UPy/NQOe17Tc9rKg4j62oyg44bSw7yRCRtqKP1Oll6DGM+vfKVjDXGPVoqyzkATMi8hGjPCJzCQLuI2JFS43xrag5/P6h+daR60v6uLvluVRa8gQPjqrDj5cVSNlLiyeInFEWrHhfA55/L4y5ZqWR91f78zwJZU9B88rvDkh5Qraxh9FIXwqMDRdkPWC2g0xXiGDFFOEkjXc0dF5XcVhk4R0WZ2qvB+i7rHSHsvFOsCSvT0KF8Swc3sZHY3tn13Jzowdk2pkUI3fbKARpl8LUmFg2zAxYfatb8Rw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa2KqR4/jTiyg0U8vnCyoR0HU8noSpZtDXRMnV0Gw4s=;
 b=alvwrZkC08Lj8G1u6Lydih96mYvnBvXKTI1b7yqW92EnhlqpoM6H8esnVsKjcu0vAYp2aGqQ437SeRfYlTQqdMgdpAxnpsWXqSvU9dGYTSPz76t+K9BhKLjGc+AMkWxTdSjCm4X/RHTjWGxlS4ZUUNVQ+z9KHWqp+Att4+fbzh7NDsLZ1wEWqK/zUzrmPVCq3aDzfMHcCF+yoYXJn5kFnpAaNwPLCgUIh6FDWQJAp5ekzplmnPQdWzXnXnOV9YHQppY2BjcMW5hBlzaBw4SZ0NZ7M3MIMRcBeIRUbvx+TkCn0EjYOyGoLKPZorGvEwasXLg5qPvMvqW98ur9tgcVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa2KqR4/jTiyg0U8vnCyoR0HU8noSpZtDXRMnV0Gw4s=;
 b=BaeYmn5cKyWyV4/DOWuJD0sg9mPkvViYmcyU1AVcMoUByZ5fTfCqiSdv09VgVr1JaXRc+I7vizOhbvGDzLwCkkjtA6gLuctK+QbWoMiSXxqXl5BNxoPkgxBUCbiIFM2Xp7YJSjFHwSnyLV8U5wt+gsh/bxu3p79FhTthKmVzFBusp8wnf1JknqtiL30Mo5zr3c+CthkUM9hfRKdjGgD385nb0/UXUL7j35DfFsj8fLfR0iRIfPTEE6oZEsYmi4547X1cdDiP2SnWf3qwZlFmxy8UNl0Azg9qUrUxuRgxNtMHM9FHUMzlRFLKV85vkLcvfLzB8KrsS3Av7qUSLfkmqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 16:27:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:27:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/5] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Thu, 31 Oct 2024 12:26:59 -0400
Message-Id: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANOvI2cC/zXMQQ7CIBCF4as0sxYDBU115T1MFzAd7SwKBAypa
 bi72KTL/+Xl2yBTYspw7zZIVDhz8C3MqQOcrX+T4Kk19LI3SiopKIolsxicQeu0dsoRtHNM9OJ
 1h55j65nzJ6Tv7hb9Xw/ichBFCymQJhxuVl1R2Ydf4xnDAmOt9QcZ9wrMmgAAAA==
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730392028; l=5981;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/6ZgUJNg/AjeYkLGZsTbnY32/IdmcaPg9IbNO9whdDk=;
 b=7kQjszHaR850zARy0kXF2zGwV7sXWlmAqZkqafBhwQOHSQ3C+rfawLmq1giLY4FtzOaxBcgQh
 TNYwkBoA2G3DdpqUXpoO37b5Wb54+06lf9U619XQaO11KuS1hlv6nQz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ab7dbe-91b1-4265-5508-08dcf9c8dfe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnFiYUpzRDgxckhTcGFzTDQ1V01ia0RKWjlUYWpMdjZEUVcyUVpVVEJqUmVj?=
 =?utf-8?B?eC9vbng3cm45R1N3RzYzM2FtTklGMEtvMG80c05scXM1Q3JqTCtHRDRQeHZl?=
 =?utf-8?B?N0cvL3c4dWhNM2d6bUdtcENueTg3UENkTldtWTBjcmM0aXdkWWttZWo1NGhR?=
 =?utf-8?B?dGg2RVZnM1d6MG1uZTZqeVRrbkZudUF3R21VSk8vTnRBSjRDenVvT0RxNFNm?=
 =?utf-8?B?b3JNZWo5Y2pNR1l5cWVaOEY4UGh2RCtYaEFCa3dOaTFnRUF1ZkNFUmZCUzVh?=
 =?utf-8?B?WFNlOEVkSGY3c29Ed3VvSERrZEd0azVlaFJMVjRtRFNxNWg0UU9jZnVYYW9n?=
 =?utf-8?B?bWwyUWh4NjVnQkcxSkhHM3dXWmJXM1Q4Uitab0dGQnRibUhndFZ0b3pHTXVn?=
 =?utf-8?B?VmJYcE9BNVBwcmVlaTVER2VlRFNLeUhUSzFuR3BSRjVnRmczUTFMVWlVa1oy?=
 =?utf-8?B?LzJPZE1IZ2VPMUNsRDlacXQ5cGxlY0swZzdxdTdDNUNvdmMyOGQ2ZHp2cFE4?=
 =?utf-8?B?WUYrR20vSGlZb2ZyaHhKQThJcWtyVnAwWjJOZ3Yxd0NFQjdqM3loZndNQUlt?=
 =?utf-8?B?ZUlLajdrYisxYk9ibENGZ0NnZUhtemRjZVZZUDRWNDZCMVphbWt5dEhQUnFi?=
 =?utf-8?B?MnA3NjQ1c0NNbkdJMStGTVZzdzZHU0RMc1ZPM0VjdnhDZWtZN2N1S2RIOEJu?=
 =?utf-8?B?SmF5bUo3V20xM2M2Q2d6ZjZ2cHB5Zy9VNEpnNTBmWXVhemlZNDFhbTB0Y08z?=
 =?utf-8?B?a3AzRjNxcUs0bThNTlFwRDFMbE8yMy85SEoxQWVjWE11L2FWazh4aXVZa250?=
 =?utf-8?B?LzdMc211WXlPYXdWaW5SYmZJbDhPNzI2ZjlSeU5UQ2F6ZmZXYzNZN3lrKzJj?=
 =?utf-8?B?TXgydGw1QTl4RTc1R05aTExWWXNDaGMwOGN1eU1NMXV0QXhQcTZnT1dPRTNX?=
 =?utf-8?B?QWNTL0grSXNjN3lwVmJNalBxQVJvV3BhbnJja3MwVjRwRzVkWlZ6ZkRlcWJZ?=
 =?utf-8?B?Y2tDRStDN3h5dzlxby94QkhCbCtQYnVPQ1RUOE9rSzFlRzd5QTRIUHIvdDlQ?=
 =?utf-8?B?c0lwQmpsb2YxSUN6NjB5Sm9DNFVJUEJ4WmFiZEJmSDhCQjBNVjVjc080OU44?=
 =?utf-8?B?Tkxqa0VHWVlZWDJtR3l6a1U3SjNkbjdscHJLY1Y5Ny9UU1V0V3kzbHNLTFJR?=
 =?utf-8?B?bW0vcW84dmIrQmYyMTJjcG04WEhkTVZ3R2FBMmF0ZGhxT3BKWGY5QkdPS0Rm?=
 =?utf-8?B?ajFtMFg2dW9QWE5aQUtDbjBEWlc2TWd5QWc4YnVQU0dsUTBLRXQvMU83SXdF?=
 =?utf-8?B?RlY0ZlEwcDAySlEyMTBJc2pHZll2ZE1TVUFlQ1dRbEpLVkJITGlUVnIrU0dw?=
 =?utf-8?B?ODZzTWRCdXJNVHFmam9TekpsblNrSHlGMEhsRGRKalZkbnQ3WjV1eWJnZDNJ?=
 =?utf-8?B?ZHVvV0YvMkNnUjBMNlZOMXFIeGlCdmtHWUJkWkMrSmw2VnhJN1ZSNjJWc2M0?=
 =?utf-8?B?TmtkMzEraXZVaG9tT0t2My9vbEIvVVhCVm9FdGNxR2JQMjRwcmxaVjl3SlJS?=
 =?utf-8?B?WXQ1aXNJL0ZPdzg1WTAreGlPREJPRjBTaHYvWVFxd0ZUdk9tTGhpVTFZYWsr?=
 =?utf-8?B?SVRoaE9GaHNTNDNtN1ZtWEh1VEUzNHhoc3p2NXM3VTJKeC9Pd1NwamV4R0FV?=
 =?utf-8?B?Wm9HZkdoY29oYTNvY2MrTHB3T1UrT3h5cHpJYXE3YmFJbGJrMFNIQ3VDeVAr?=
 =?utf-8?B?SlJXZlJBbU1WUTlETFZBNWhOU25jSzduL051QjdFNWo4eThuYnBRUFNLcHc4?=
 =?utf-8?B?aFIvc2Q1cFJNVnJXZmw2QTdUTGladlBpQXZ1UVU2UmlWRHdvQWhvYytTbUtj?=
 =?utf-8?Q?xcx2s6vdbZDL6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3lLNUljcCtpWlVETVRxNzJNVlV1TnRHZ0tmQlg3OXZXc1FNeEQzZWZsS2ps?=
 =?utf-8?B?QlBZTmZRUnFncm1YY3QzekljcENKY3ArTEZLb0lzRktJaFZDYUlweEl2MzFL?=
 =?utf-8?B?eW50Z3p6enc1K3F4bVZjcXZQWHhTbFRlTy9JWFhFbkUwUUlVc1dnemdNVzBC?=
 =?utf-8?B?S3NWaGUzclMwWFlITVEzMHRMUXZpa1pON2s5bDV6R0RCaWF3Qjd4bFZ0Wm5W?=
 =?utf-8?B?TlJJcm9RZzZyMEtSREh6ZU51QUNVLzBGZDJONEx5eFVaRmpLTjBBaWhsOUdt?=
 =?utf-8?B?QUNFZnBiR0JsdGx4Y1BaL0JFWWoxdnpHT3hvY25SWEhOOVZsb1h3WkJzVU84?=
 =?utf-8?B?MUNzYTg1MUJiV2pmTXVuOHFUQnptQnRUYUl2RGVQSXZ4cFNQbEV1aTRoQytQ?=
 =?utf-8?B?QWw4Y3dheEtJQmowQk1mTXlMVXViaW1xUUFoRlIxQ21XMmFpR01RT1hGd2I0?=
 =?utf-8?B?Vi9NMFpBSkkrcDA5N1YrSXpZcFpLeXFPZ2tyRWdhcGsxcG5CSnVZaWgrL3Zh?=
 =?utf-8?B?U3c5dmo5bnpJWGsxdjUrU1Y2NEhRb21lSUNhd21lSjFZQWVLMkFxUnhGSUYy?=
 =?utf-8?B?SUJVNXhkTU9mOXdiMkZjem5mT2JNMDdsUGFJcjZHejJVWlRnd3g1K1NPM2lk?=
 =?utf-8?B?a3BEQmdaczgrR01vMURvYldUdE4vQU9LR1NhL1BlQ2g5QU4zNE1ZWDdDbXVx?=
 =?utf-8?B?WEFJQUZteS9pV1pLWTNXTGJHai9HTVVBdFNoTVNpc0pMMUFibjI4b2VFVGVn?=
 =?utf-8?B?WWg5eVJGaWg0QVYzd0U5SEVHMk5xM0RNdm5xOEZXUE03YnlycW0vRUM3dFZj?=
 =?utf-8?B?dThkK1lYUFVocUNvQVR5VENSZHVqRTRmS0tFNndRenBObzMyckdLbENoS2JK?=
 =?utf-8?B?VEdUTWw1eDJKQnJiTHZGNHg4aFNGd0FSWi9salYrSjBCS1Q5c1FNcHpIdW9K?=
 =?utf-8?B?YnhObWQ0WFhsa2V4cjZZS0txRHArdjlVcXlvaThtRjM5T29wSzNad3d0ODUz?=
 =?utf-8?B?aFhJY0VYRjAvOTRpMmZNcFVIR293MTZiQmdBYzE1cUFYMmRFRWp5UVExcUpN?=
 =?utf-8?B?WkY0dXNxcG85QmJzK2l4aTlZRThKR1I4c2MrcTJvL3FWM3V2WVN3cUtXbWQ3?=
 =?utf-8?B?alpxMjFKVnpXQ0pnUXhhODRTbGtxTEtRSDBuMktvZExuVllQdmFjUEVnaUow?=
 =?utf-8?B?ZnNPTzIvMDZKcFdScTU1bE1JMWxaU3RCTk1vMElzbVU2WE1TSHdLVGpGOVFQ?=
 =?utf-8?B?b3BScHFmY05RVm1mamVidGQ1Y3B2VG9JRXFPMWI0OFJMK2gvNlhJN0o3ZzZZ?=
 =?utf-8?B?TkI5N2xqelo0Z3g4akZIc083enNmNzZDWit4S1VxMEgvZW4vYkxldzhqUFJ4?=
 =?utf-8?B?SFA4R29JMzg5d3A1QUx2SVZ0TWViZUhFRFMxNWEzZmJoK2s2WEtLY1kyWEFj?=
 =?utf-8?B?ZWdhNlQ0V2xjZU9kdzA1NFFKdUpYRjZaS2NSYWt4VTVLY1pxc1N4YUg4RlNj?=
 =?utf-8?B?VkNKd1FVa25xT1Y4Vitoako0L1IrTWwzYTBnRlhuck1QTDUyK0JIdEZxSFQ2?=
 =?utf-8?B?YjJzZEFwVzVBaUhPTllXYnBxWUs5VHkxLzhrUFVmWXFnNm1NUXlqc0twTS9k?=
 =?utf-8?B?TXFlYnM3OEJsR2liUkE3Q296K1RKZHMveWxYS1JmR2F0T3hjVCs4UVFUZTM2?=
 =?utf-8?B?WkVSbCtOaFdVUlF0S1JjODNtZDQ0VWZkZWs0WnQ4WTBUK0Iza09IbTVmNjdm?=
 =?utf-8?B?V01CNElrL0VxL0JaZUprUUhCbFhTRTFoNlJCWGg3ZTI2WG5sc09HUVZQOHVr?=
 =?utf-8?B?OW5Td0V5VUV2eGcwMXd2bFZTTkMzaDlrMWgwMVRKdk1BT016UGdvWmVOL3ly?=
 =?utf-8?B?MmZqZUkrRmxnd0NZYjk5Q2JCOVJ0Ry9BdHBqelYrS0NYT05RS2xrQTlXR0Fz?=
 =?utf-8?B?ckNHNW5ySzZGY1pMVVRxSjRhaVhxOStObG51N2J1SDJpMThEb1lCVGVCa0cy?=
 =?utf-8?B?S01iWEVWdVFvNjY4dXBBeFo1MlNQVGkzaXFRT3N0NUMrRWQvMkg0SFpFektD?=
 =?utf-8?B?c0RybDNFWFRabWdUTVoxWjUrVXlIbTIrNzUwalhZNjlLUWc3OXlFbEZiR1M5?=
 =?utf-8?Q?9dbc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab7dbe-91b1-4265-5508-08dcf9c8dfe0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:27:12.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SN21zDEsJ62kzUx84UOBKOdG1ZDTvdJQcGkPNhiqwSyVQNtixQd7s7JZolMn2Q5cwyIKeY0kXda3J2njPZToQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: cassel@kernel.org
Cc: dlemoal@kernel.org
Cc: maz@kernel.org
Cc: tglx@linutronix.de
Cc: jdmason@kudzu.us

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (5):
      PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/misc/pci_endpoint_test.c              |  63 +++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 104 +++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             | 128 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  23 ++++-
 include/linux/pci-ep-msi.h                    |  15 +++
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |  19 ++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 +++-
 10 files changed, 369 insertions(+), 4 deletions(-)
---
base-commit: f231847d7f5a171be4566099f654521606b3ec37
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


