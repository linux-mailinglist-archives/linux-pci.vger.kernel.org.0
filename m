Return-Path: <linux-pci+bounces-11502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71094C240
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 18:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E558B283DAA
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9D819149B;
	Thu,  8 Aug 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gTDx8Voc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B819069B;
	Thu,  8 Aug 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132964; cv=fail; b=GRNitSfUgP/5j6Kt9AG63cehtJo9zIxNuX2F1HQ85m/hO17mvqDkO3AcS7KXMIoJ61nLduLL/NZnrCQu4XFaBukFwiBuFxb0CWcBHPec3/4Y8kSaRGMBePT2ZepP2PIqWKB78G4Tpl1MvGjdyEJ4KT4Q0bBI2kVT8zxEH7GOTmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132964; c=relaxed/simple;
	bh=PMkYu58lmGxlH9DFPC85iuILSX9uglBzTmZsgWUIv5k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f1m/K8K2Iz7mw9D2G1hPUrXPTiP4oWE7UTlgDqpQtvfGZ1Re/al2K8LiubQDzj5yRUad1x1xTn3S4jwQ/tDUECg+waU6ci0nVihrvAcs4XkHrE8IpFIYuEf+mgns3jirQ2DmS+sX1zJL9dluY/ZUCB7p5nR5IFJ5iNW4eGtcdSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gTDx8Voc; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMaJiv3zgdTLribbUlSkC71GCjNgiCpv5eOn6D2YzijZ4WPAUrBHR/MVbMfvjz9Ccip7wNfto3Q2wiPiU9k7p51k39Rr/mLoa5kdzEfds1bAOyvnkILjnMkLPWU5Mp9AWOxndK0KHzbLcaGAAw5ZS4Gia5Ixv3ilhczat9akQoByrWf1VgR//94lHTesDxuWlNiBOpPxTyiigGR353zRAhLJu7oqS2sBpCqzkZH5IEbXplZhHSQdMxT6R94hio+aDGwlmAuw04A3oQgiA5ZlgtKOJuaYOzijl9uVmYWgRbEFj3znk2Oc1/2smvwsJWXLXSMq42Y69bko2WIKMJgImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB+VqeCPbeBGpPDvUwKOxg/KL5cd5IULXRAS8th525Q=;
 b=PJvR95UoCQw0xdmUlzhk1q7R75o3GQr0Q5HJqxuYh7MOsj/7391bRFGtnaKw7Jblq+lNYBfJDPaDb8S/B9ccARryOcvjShKbiwTPyk11k5n3HbedhTYc3PjeQeNFZhCSQyZWxhv7HbeY5P4hFAopSU9WhyI36W/ZSQOzQUJLDe66igQiG5Bp4FTJxHimrCHiNJ0TkFuIGYdKiSpIf6hh1hTbQfoSZ1bEXxF1B03t5VjDt16r6zq58pohP7moyaNQeD7oZAdGpbaacQLGn0shhl2SLfyDNuNA+4mm/bx//GxEy3OFOrMhx+c17jVWIGRHKvT5JgmU1X97LDKmJyPoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB+VqeCPbeBGpPDvUwKOxg/KL5cd5IULXRAS8th525Q=;
 b=gTDx8VocRPTZX90qOMoBSxMitInz+jvjJhB4xEGBGfXI6F4gWGxhWllGsBM5VAWqbL2zvujuoi5CzyI92FPPtFARFaq1PLxc1q0rnp5ZHFjNr76RnqtIDFnFgSakjYkWI7HyufpzWuPHrJEYPaSJYojm7ZBE9iBzGJDzliKsiQaijBT7sk4ics0CzBsFZi5ldv6zGlbxnOi3sRCvtLUlO+SY8hM/z/5fr96+SDyTk7CDXr1sFGBqGZcxkcbI0KzTfKGd2CGpMhRU32PwKH9AsLT4pIXyDDDUU/+YOelWrfpSjQuglFgl756+Aq9bWcP6i6jBZ6hcw5CVdVISchnakQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 16:02:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 16:02:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 08 Aug 2024 12:02:17 -0400
Subject: [PATCH 4/4] MAINTAINERS: drop NXP LAYERSCAPE GEN4 CONTROLLER
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-mobivel_cleanup-v1-4-f4f6ea5b16de@nxp.com>
References: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
In-Reply-To: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723132945; l=1041;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PMkYu58lmGxlH9DFPC85iuILSX9uglBzTmZsgWUIv5k=;
 b=wyeptxaJag1gyafElON4apBrcT2a9nLyy8d7/0MeOwHZWI+f0jnq2cYjrb1o/fy1FTfMwZzhV
 q6Rju9WQyJ3Bg7ImI11yU6O0VHIFL2qe8LWYvdbihlaucDCmNzk0MHw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: ff22c4de-7edd-4709-a348-08dcb7c3880e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDI1SjRIYURlQzNiWGxnV2publpDOFZyM1RHSEFrZkpEZmh1Vk5XVmxJOGxo?=
 =?utf-8?B?S21iSHdFTVo3WEZ5cGNBUEw2ZUdYVlNTaTU1eWo3ekFFeHFqZVIrc241R1Bs?=
 =?utf-8?B?NlJjQm4zWWxFazFRRFV5N05UMXF5ekhPclNiWEQwQVBiS1V3MFNMQTJNN1Bm?=
 =?utf-8?B?TU5RR0pqcG5lVzMxWmpTbjl6L0xwbHpNSVNrWkhKcFUwcmZmT1ZlVmlTSHd4?=
 =?utf-8?B?T256Nm9BQmhRbm5vVVNVdkNaM2JlQU9nT3FudTMvNjhwQ09yaFlVUHhOd2FC?=
 =?utf-8?B?OG9TcU16VFNyOEtOempSR21yeDltWUhKOTc0YnRETUZGS2lRTFdpOTlYeTRQ?=
 =?utf-8?B?bHdHeldyZndSdGFsOXg3Ykg5NktVemRhRStZYmZWMG1ZVGFCamVKQlEyVUt4?=
 =?utf-8?B?aGhRUU1yTGdCU09KYVRuL0RCay9YQzZ1bjJFbGloZDRRUU5vc0RsYjMrK0ov?=
 =?utf-8?B?NkFuS3B1THpoWjgyVXFsL1J0dmp6RDNOek9lRUVsNHg2RDVuYk5pZzdrWjVH?=
 =?utf-8?B?RFExc2VWN2xiWTlSdVpyWkxlMTVUYktmdEdSWVljdVhIN3N3emFYMjMycFRt?=
 =?utf-8?B?em56amRWdjRaT2VldjNMenJtaE0zeFlmUE95N0g1R2RGUUtsMzQ0YnBBa3BY?=
 =?utf-8?B?TTlzWWh1TEZkc3UyaTlISkxJWUZNWTNDdWViUDBVL3JIS2tWNXRrcE02QTBG?=
 =?utf-8?B?VWZQWW0vSy8zcCtxeGRLRm5jdTR4UjJraG42STJLR3ZVeUxCRm4vNFBBTmhp?=
 =?utf-8?B?L3kzby9MdGhBaWM0TFNQc1YxcXBrbDQ1bjNodVlLSGwyTkp0R096a2wzU2dD?=
 =?utf-8?B?MGJyS3FXOTdJM1I3OHhoS3RHYjJNWUN2cWQ4K0pVbklTcDdBeGF3WnlOOXVF?=
 =?utf-8?B?c0FUL3F5SFM3NVQrYm8yd2d0Z05KNy9CVmhtS0lSN3JNVm44Q0h1cVMvbmZ3?=
 =?utf-8?B?QmZCR0JITmE2bzkxQjJDeXBoaER1REs3Y25sbGt4UkZERGlDYnJRVGd4T3RO?=
 =?utf-8?B?MEdSV3IvUTZUdTF6SXVhaVMwNmlWOVZ3UzVtVkVrWTdGMlNIeWo3NjhhRXlU?=
 =?utf-8?B?ckdlQ1A1VkpURHVyOEJxZm1YRGpiRnM0MzFhTnluYm1oWkdzclQzaTNiVzRP?=
 =?utf-8?B?UW11dkpVZzgrQ0VGVnhNSmZUUzdVY1RCMk9mVEFHNjB6QThRUkJ3M2xPVGE3?=
 =?utf-8?B?SkRadHJPTlFtclhNdmF1blc0VlhlRzFNdkx5ZUhueFphUi9OSVVlTExWUVQ4?=
 =?utf-8?B?RnNEZlNDeGVKdzJIa0R6L2RhdlprNG1VNGFFQXR5SFVvTW9tNzViMWd6MHR3?=
 =?utf-8?B?M081NVRsMFRvSUpjTXBXWnJ1UTlCL2NSZ3JrcmJ4dW9Xb2J5MlFqbm9HY2FO?=
 =?utf-8?B?V1B3eUIvK1dHdyt4YUdybFRPMktyVG9xeVVJUW5lRHUwaExnM01zTzZjOUcw?=
 =?utf-8?B?SGNzTXQ1QWxpRmtYbHJFOE5TaXNMM2NNY2dHdEFsMmRBUWJPc05tak9vazQw?=
 =?utf-8?B?WXRpUVdIZWVDem5UWmJ4L2pZbWdnK1M1elpIa005bkE5c29LOW9DendTRHlV?=
 =?utf-8?B?L0U5R3BUSHVRS0pMRDZEL3ZrVTNMd1Q0Q1Y5azBMZU1SaGUvQ3ZMT29DZWs0?=
 =?utf-8?B?R0hkU2UrZG1waXlDS1g5bGZKQmhQR2ozU2xzTXJ4T29tZy9CbXRrZTZsZVFF?=
 =?utf-8?B?L3lHaXVJdjZ3UE5uUFFPcCs1WVM1VHUySzRSMjBMZlIrdGI3SlR6REtnQm4x?=
 =?utf-8?B?MGxtQ3FBT1NSYTF6U1dEckYxMEh3RVdzaEtmUjcrendqbXpodVRDWUE0bTRE?=
 =?utf-8?B?OVI5UmhWQ2IxQmpGMjE5OG1lbTBiUWp5WStQSDZIS0VmNUpPOHlNdDZXWWJU?=
 =?utf-8?B?M2U3YkhMa0ZjUFVwUU90cjhmaUFKaWRmVkJaM2VKWXh1WGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3JEU2ZkQ2ZtREJVWDJGUDJRUXRFa3lWTW56TEt1TmVDeVJPc1hWbEl5VTUr?=
 =?utf-8?B?YlErQjNlY2ZGZGk2OTN3R0JES2R4eXMxb1NEdWV1VEdmb1lkRkhpUk4yWUl5?=
 =?utf-8?B?eTZET3N0cGs1dVJGMWkyeElGNjQzcnFNNWI4WVVLazZTZWRqRGNoWnRLZkty?=
 =?utf-8?B?dXJ2RmlIdG9EbnRXL2pmN3hxa0VIT0xEZm1SSkRVM1ZScUU3REhJd1RORnVX?=
 =?utf-8?B?VHo2bTRZWnRXaytBdWt5TnVSTEdiejFaT0FuUnpmUkx2aFVPSWdWWW5OTDlz?=
 =?utf-8?B?Q0x5Z0xVK1hNZmVnZndmd0pBR0FrK1pON1BHUys4RGNlR3ZQcUdIMDBQaFRr?=
 =?utf-8?B?UkRJYURLQWxlNm83SXlRejNhK1JaM0d6OG9tV1kxMGUvZXByU0s2WnVNZ1dO?=
 =?utf-8?B?TmRZN1Y2WHJST0xBNVh0NDhKalpIRmtwVU9BWjdCTTZWcWwyZXcrK2huVllO?=
 =?utf-8?B?M3FabDVrSHkya1BGV2I1K3JBUEhESmhJRHh6NjlvWE1TOVgvMVFvejRad20z?=
 =?utf-8?B?Q3Mvb09ldy9CT0o4dllYUmN4Z3RGcVlTQVJjR2ExNnZMcWVXZEVIS2wvTndC?=
 =?utf-8?B?NUVtdFhRU2pQbGplbmh4MnpIU3dVbXZ1cGpXT2l6bmtGajJmZmI0TjM2SkFY?=
 =?utf-8?B?bkZHNE4vcFZsZFF2S3lGUjFlSEFUNEJnSmdqUHBKTE5vZjRYcloxQ1QrZ2NX?=
 =?utf-8?B?NnQzd2hjZ0JuNHNZNlExVERoYy9XcUlwZ1crUjh5b3RCWWZEVkxDUjMvOTFB?=
 =?utf-8?B?cXhFUjJ6SmxJVXI0Y3k2SHJXaEVKTkRXRWtQSXpMOEJvMHVXOTFhNVo5UHJu?=
 =?utf-8?B?RmVQVFhWeE41RGVHWXh6R2dWVkEyRWk1TElBdjFaMzQ4TUVJTEwrRkxtdVNy?=
 =?utf-8?B?MncwejNsUG5PRjJCYXRLRjk1ZDgyOUhXWHdrMGRkVVFTcVZXQ1JJZnMvc2pk?=
 =?utf-8?B?eWkrcFpld25DVmdFblhJNTMwdTNGUWdhRzZLNlFaN1hsVnpHNzgzVm41V2tw?=
 =?utf-8?B?S3VKMzkvdUF2eFVRNU9wV2RyeTFmeHJsQzhjT1B6SGhaZmE2Z3hUemJ2cTh4?=
 =?utf-8?B?ei9ucy9SWGtYendDOENVelVLUjZBLzJWU0RqRklHU3VmMjRBMHRYTDhnOW5Q?=
 =?utf-8?B?bDc1d0ZOdzloNXRlTDYreVpIRTRIQm5kUUFFMnpOUmVSSkhIdU81d3NPS0lQ?=
 =?utf-8?B?a0pVUTFvUzRTSGdGNmthbGlaSmtxdnhqMHdZRVNxeGFuYzZGT2FzZ0ZwY2N5?=
 =?utf-8?B?ZDlEdGxOanZocFNYdlVmUUtZcUlDYVBlV01rWVBJL1dLcVpVd1pvSUlLZWpT?=
 =?utf-8?B?eFMyQ1NmeHpRT1NyZ0NlcUVrSGw0dUxmZ21NeWxrSVNyMTZEWEErOG1pQWhY?=
 =?utf-8?B?NEM1SEI2TFlCN0YxaG9maUxYUGZlajV0MktXT2tLblUrVGNQeHdqSnhpenJh?=
 =?utf-8?B?Ti9GQjJtWGxhbnJUUGtrNjNHREZoZFU1QTJEdnNqUGlCVEk2TVVBa3o1U3VK?=
 =?utf-8?B?M3Y5Qm5uY1N2TTFaRXFnSHlkdDhmTUtWQUR1Z0h1eTRiR3JOQ1lwMkFrd2hC?=
 =?utf-8?B?Mjk2VFc0bFNhK3pnQ3gxREF4eWlQTmVldFlnNFJyTC9NWHUvS0VGeWFaSW9C?=
 =?utf-8?B?bTQwUjV0eTErOWU3ekl1eU9mM1JPTEx5UGR0eHFMRmJQbUFNT0M0NW9tcFdz?=
 =?utf-8?B?YnFhUWh5TVFuTDRWMFVqSUpDRVNlSkNmZ3dCa3JOSisvM1RWd1hlQ2grU2t4?=
 =?utf-8?B?eVRnQmQ1SDBXVGxiUnN1UDFncStDb0J6M3BwUUlaNWZWYjFRU1J5UVRQTlhO?=
 =?utf-8?B?SUFoT0NDSDd1Qk42blVzejhTV2xOazFEd0hmamdQMHdDemNNaC9PS09SUXhZ?=
 =?utf-8?B?SGpsbHFkcWZtZ25PbUtpYitDVC8yaTdiOVRNbXk3dndqWXpHQUlDYXNrdVdz?=
 =?utf-8?B?WTc3TnlXMGhEaGxrckpjelZneUNKeWZyS2g3MkJjdlViUFRnLzFycE5Sc2JV?=
 =?utf-8?B?RVdCM2xjTlVYZzF1M3RzcjV5UktCM0R4QStMZWRRTkFFZldjYW9sMmlheDJV?=
 =?utf-8?B?eFRZbElZaHd5c0oxYTNmWjVUSVNXekxwSVhrWVpjeWVIbFV3VjVYSjlQRkxq?=
 =?utf-8?Q?lsHS62HHNI13gntB38O3EaS+8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff22c4de-7edd-4709-a348-08dcb7c3880e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:02:40.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/bziDW3Y2ohd3bBnVKb8w8gx+CvLiPHH44+Qo++ocYwbAgZeHZkn9x6keSL9NL5Tpf/RNnoPFJs6fwF2gBFlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

LX2160 Rev1 use mobivel PCIe controller, but Rev2 switch to designware
PCIe controller. Rev2 is mass production chip. Rev1 will not be maintained
so drop maintainer information for that.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e71f97fb6749..9b683899cd088 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17556,14 +17556,6 @@ S:	Supported
 F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
 F:	drivers/pci/controller/pci-tegra.c
 
-PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
-M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
-L:	linux-pci@vger.kernel.org
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
-F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
-
 PCI DRIVER FOR PLDA PCIE IP
 M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org

-- 
2.34.1


