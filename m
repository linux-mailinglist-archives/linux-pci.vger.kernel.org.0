Return-Path: <linux-pci+bounces-11498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21F94C234
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 18:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BB6B2657E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3018F2EE;
	Thu,  8 Aug 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iU2bb4e9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C308003F;
	Thu,  8 Aug 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132955; cv=fail; b=WkYRzPvnKJizvMKJD8lF7nAMDifQ3NOit8+Jy7fMUsYZkMOLcbdS+UspNueIkSG5aPPtnkAV5KITHmJSP1PF28JXxILAvVtUQkmDqwaoKGwbv5+BByeDqGgutj3VjGq181YrDrSHsLAS0wn3239SWaBD3eCS0dgLM6VVzVOC4f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132955; c=relaxed/simple;
	bh=8xJhXEGNef1oFZrgUzTA3l/zAK0Yrnl+MC2iBo/IpRE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=K+I7zBiVE9wPnfH7k3OwAHzVO+VW3MwMe5yjUleNs1r+GcXEU4AqhH45XIztQVFrAOfdtFOwJSW3GoNs3768Zd0J7xaPOcCE0Fi7ZaymPmEDfEPUOXRPl7JUpRo753vvAFkgO9GazyKQY4mnXUUlCKtyufo+25IKcPoGgRpK8YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iU2bb4e9; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su0fRU1zMY9jEwTbyFjOW3eoaZHs7MhTp3EU7P7+T/Sht9+Djxq4OH5/uYKf7bp59Cfausp6NZO8FUuLF7Y1jnw33v0F6WPBf9KNEo/A8JI4pLwT1Ge90xhjr8tCgzpPk/zdLdMnxoSX01Y84ka1McpG2GulylyT3cEhn4PN7oJc3isHg7rM2zr5rKV4PNxFblDupBvseNmdeeH2LSJ5qgpLKjBVkqUMTEOkhks4aXMl0qDtveSsB3L4ljtxMN2xu//kPNH/hhAYO31Ynq6R/oCEe4Jv06vuRUGfXUNkvVEmIRImPD/drLpqQrGfQPFELhE4tJpg6RkcIei7voqBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2RWsWEO2+ihVdgvDuX19DBm7wWEBkUpmUUfXIm3pW4=;
 b=wR/PWd5YjA5YCbMImk7HOR0C3Vrj1rh7t1mAJHbkbs+eeDxR85tQCouzhRWOZKHOAHFOjItxVgri+R/V+QjAFftEKkrFNdGrU5cnF8fn4oXY9Xn1lcIyc7MSxudj2L2wYHYjcUP0fwW1ZTS+MXc/SmgO4Xdk3K2JCcDemnqaml13HJH7X4Zug35CKenEKd/ROCgTsEAQXobUDuziuMqnh9+Hyp/Xp6BryN9uylprt8nMSBOL1zMMafM6NZ41vEG/KkrEM8jwnRQVOmmV7BqbxE/+Vdz9DRo/LyQeEFo+DXXerZlKw8RRJpSrQBSoHjkJzm2e/JGUwtPAhUWkrg3Qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2RWsWEO2+ihVdgvDuX19DBm7wWEBkUpmUUfXIm3pW4=;
 b=iU2bb4e9osdORCFQhHK2Ujl2WmYpeX2y7/KBk40nWWm1n9Nux7C+evb05NnRBVDeZxsLpHZNUOfyh9bbgp/ZQu73ZNnhhz9abPbQ48WQSPKmo3d12DMWRImURPl6E4HT2rEXVba+TdLHlTJtAkgt4rEAhjEb02qga5j84INlxB6s5qAUp0T6oQLvj9rVd5fQWPd1hthk7CJTt4HUoQb94kcYJiiqBiYmV/Vx2qh7mP9IjJKi5nbUV5cgtxNpMcyN4iI1IGA+qhN6g4rt2hmMIJcyS1V6AG88ifZA7D18KdpWU2FACF4Nc3aaoKeibVg4NpdFKr+A03g+rVsul/W29A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 16:02:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 16:02:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/4] PCI: mobivel: Drop layerscape gen4 support
Date: Thu, 08 Aug 2024 12:02:13 -0400
Message-Id: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAXstGYC/x3MQQqAIBBA0avErBMsorSrRMSkUw2YhZIE0d2Tl
 m/x/wORAlOEvnggUOLIh8+oygLMhn4lwTYbalk3Ukkl9mPmRG4yjtBfp1DYaYnWWN0i5OoMtPD
 9H4fxfT/L6LeCYQAAAA==
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723132945; l=1548;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8xJhXEGNef1oFZrgUzTA3l/zAK0Yrnl+MC2iBo/IpRE=;
 b=QojBwUUcylfBJYYh6OCYe2rWeXCrroJRt75XUQhaaDwO1JyX0+OZ+Rt1bJADLocQPfhggT0a+
 asazjzjHPauDWHywi9ZcLRaL3QEKndZbuQcuRk1LX5co0WhPa5M2LOP
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
X-MS-Office365-Filtering-Correlation-Id: bc7c5f4b-fb69-4156-7030-08dcb7c380a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGJKcUI0ZG84VEV0ajV0aFhXQjJ2YTlEN0dWWlNOUDh6ZDExekVGMU1oNTJZ?=
 =?utf-8?B?RnllbDNUL1J6OEVMWmNNRk5veEl5VmhHUGJjbnhXMmc2aEZJQUhDaUJsNlJa?=
 =?utf-8?B?WXVFUkthTERibTVzbVNQcXlLektMNDZJNUovdWtGcFNFRGV4VlFLaklFWUlI?=
 =?utf-8?B?T2tJRFIzSnBCdVpwUGFxc1FUSWtZemczZFFVbFFGeEFXV3ZPYk5SaUxCUXU0?=
 =?utf-8?B?MGl5cmZjanl1a003cDgvV0FodWduWE00Q21qemtuOGxFQzVMTTN2Mnd4cFpP?=
 =?utf-8?B?MjZNS3EvREljMUV0WE5ROTYyL1pubVlzSmFya3dJUE5nZ2ZFekZIRUIrMWl1?=
 =?utf-8?B?TUhQSmt2Um1mdjc4OWIrNFdHbEF2a2xSbFdoWjVycnBJbkRtQ1dzdWlnN0Ru?=
 =?utf-8?B?Z0JTWEN1RGxIelI4eHVhblFBd1FCaEFCdnJyYzN5WWQxTFhTRURhWjdmRm1l?=
 =?utf-8?B?a2pTM1pyTDhGWncxcnNHajM5WUhZQllYTHE0aU9tTk8vUnVFRm9oWTI0K0FU?=
 =?utf-8?B?bUJaK3RmWVNHQW5GVm9xck1kYlJDeU5pdExGT0hzSktxMGZtV25OYVFaWTNt?=
 =?utf-8?B?dmY4L3YvWCtRV1Jsc2tCamgyUTZPUG5ob1dMZjdQQityMDhwMEpIWUZwblc2?=
 =?utf-8?B?M2JwTWFlUjJHSTBUS1c2YzFRMWZyN2NxeEt1SWFUZWloUUFnbWcvQnMrNDhi?=
 =?utf-8?B?ZmtjaVRWdFRwYmU0NkVXQ1N3SkZBTXNLVkhGMHM2L2diTkZHZXFRdHlpcjJj?=
 =?utf-8?B?REt2d3lhSEMzNE9Jb2R1b0JKMzIrNmVBenNXSDN5UFZJZW1JN3JJUGkwQlJm?=
 =?utf-8?B?bFNQQXpEMlBQMnkzcWVXWFNrdkI5ZHQvdnlLVWUrbTVjRDlHMUI1VGoreGdp?=
 =?utf-8?B?cmw3b1lYVFlRYW9EZHd0YnZTMWw1V2VHMHBEcFFkckhIY05wdlJLaDNPTlY0?=
 =?utf-8?B?V2ptUWNMbnRhRFZJbWpvQmtkeG50N09mSmh1UUZtcEMxampET1NNUVFWaG5J?=
 =?utf-8?B?b0NoaXRwWG81SlBuRFNTQjhYdTR1d29FekJScXBuK2VxenFsTUI1MGt1Tjdw?=
 =?utf-8?B?NFgyamJYb05qQVJmN2lIM0xZeWV0U1BMUDI4K21nTXFtV25yc1o5TjYwRStM?=
 =?utf-8?B?VjVHUFd4N01sS21laWltaHc4bE9yWkNyWTZ0ejZVMWZyclA0NHp4SnpmSDlq?=
 =?utf-8?B?VnJxcGpIZXVrOERZYzZOSEhTQVVpMmlJQVM2cWE0a2w3TGp2bDZoWENDN2tw?=
 =?utf-8?B?YjZYaVQ3ajBkMjZCKzM4eU1VblVnd3lQTjVydGtsNzg1MHdQTDQxMTJQTXZL?=
 =?utf-8?B?M2ppSGZDY3NMNldBNWJHdG5CU096dnRpZ2VaUS9Zb1ZOWCtNMjR5TmpZbnVr?=
 =?utf-8?B?bjFuTDh6dkpCbHdhd2dpdEJhWW1tN2g1YXdFSlJSeDNVM3R1VTFnTlQ2aXVr?=
 =?utf-8?B?eDZLbm5rcUtYR1JscmEyR1FQNjNrYkRZUDAxK1JlQkt4dE9EaXRNN0FZbDNM?=
 =?utf-8?B?Q2JUY2hmMHRhdXRJNkk5NG4xOWR4YmRZbVNpODhHU0VRbEVVNHg1K3JkbXFx?=
 =?utf-8?B?WXVuUG1NWTVpV0FtdUpTb0FPdFcxaWh6N21uRHpYcHBDVnU2WVROekxmUW5z?=
 =?utf-8?B?ajRxb09wUHlJd1B6QmI0T25tUXZUeDJuZHNEclc0TytSU1A0QlVLK2QyU2Nq?=
 =?utf-8?B?ZTNwTlArZCtJekhIL3BpTDVGVTdYZnYzNVVZU05YWFB2Zm1PK2JsS2JYOXdD?=
 =?utf-8?B?NExQKzR1dzVkalhtMTQ5NFN5YnI1MkczeitkK1FraFpUUW5rcCtOd2RiZVZ6?=
 =?utf-8?B?QzFuRVZyYVg3S0FUVjNsUFJwZ25nY1o4QmRQL2hGYkt5eWYvcE44TDU1aStC?=
 =?utf-8?B?MWcwbXhyTmthZDZEdWVyYmdPK0JRWUlneTd6ckhtY3JmM1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akFINTRNV0g5R00wZTNxMXFHVmo3UnVFZkRoSTZKYm0xeGVYYUlLajhlUkFJ?=
 =?utf-8?B?TmZ4Tk5zbEtBTVFuek1OT3BHZ2duWlhOVkVYdUFiL0QwbFpycjBIVTdxakF4?=
 =?utf-8?B?STU3VjJKbHlmaVlWaUFlRU5MSUd5N0tuNUdEQVhZcUdqamttRUlyOG5KeStu?=
 =?utf-8?B?U3NzRkczVnZsZjJuT0FmWVlrWW9aamsxdkNVeW1XUXBxMnFOT1RKVG4vejlX?=
 =?utf-8?B?aXZDRUFzYUFEYnlpSGxPM012bThIZ2wrTEhiZXZMeHlxOW5uZXVTd2J6STVi?=
 =?utf-8?B?V25lanhGMUxLOGQ3NEFpeXpURGg4SnNFR01Xd3BHcGlZcW1mZk15STFpdkNQ?=
 =?utf-8?B?eE9JbVE2alhWbVRrNDFQUWJBTkg1djJWSmJqTWRHVTRzMGpJaUhIczZtVk9K?=
 =?utf-8?B?WFdpb1llK2J4N0hERURMWDBMZmIvaW56YzAyK3BqUWdNQmFlRFo4enlkcGNz?=
 =?utf-8?B?V0kvZDNuWEZXVjdOc1dzNjBPTjJKTjVoU2hhUE84eFNyWWFNU25yQ3l1OHhG?=
 =?utf-8?B?UHdxQnVidUppQ01kb0M5NVdHS1JjSlVKdzJ0akRKTmkxdmk0VTlYdlhGelRT?=
 =?utf-8?B?NEdaUnpzTUN6WnhRR2h1NzdKdnRuelhIc3B1eG1xZ1N6MExOSHU1Ynl3aXlD?=
 =?utf-8?B?ZnVGU2Q0RlZNeUVSSFRmaVpQVlBQL3B1clZnZVlxWTAyMG5Qdk5ZVHlGUGFI?=
 =?utf-8?B?WEN0eFJ1Uks1aHdvNDRkcGVyOFlxWEY5RlNXU213V2ZWV0orWUU3Yk50NXYz?=
 =?utf-8?B?MUUvTVJQYWhxU29wUk5wYVlJRithZTl4ZFJOeDJtbFFEODR4emdneEUvV3BS?=
 =?utf-8?B?K1hOazBOYzh5OENKc1lmMHJ0UEQ3ZHpwZmhxNTVlZFlHVE9mSThCMlhCeHh3?=
 =?utf-8?B?V1NtNTJPVmZnakdaSjJnSUZGcnhkdTdNZTRpQmZJdUQxaFRyNVdxNTRMZnZh?=
 =?utf-8?B?aWdMUVYrcVlzNUE3YnptbnA5NUhlckk4QllxMERNQmZCaEpWNy9kR2tHTVFt?=
 =?utf-8?B?RW1tVThMKzYwT3RKZktjWW1Ra2kwYU4zNGdTeXNWeHNlajFyNFh0aUduNTg4?=
 =?utf-8?B?RkdJcWJNb09lM2MzdmM2RzlWVUw0eEF3WXZyeUxlWGZPSHZLYzdkL09nVSt6?=
 =?utf-8?B?cElOazNGb1lGblBiVERTNmlYMmcydVZnV3crQU52ajhsQ3NqNTljQk91OHhM?=
 =?utf-8?B?NzN3bG0zM1IzVlpUa2tId0JvVEN4Z1B1L3NNUVRFZUprY0VCZVRkTzE4U2NC?=
 =?utf-8?B?Q1loN29ZNVE4Ulk2VlpETTZZMTU2STJKZ3pEbXI2MnE2cTNwZllPS1NUemtn?=
 =?utf-8?B?NlRyVSs2dkdkUEdQaTZUVFJSNGRlSGh5SnBSNDBhUEdBeGM4cmJLRWtDeWVo?=
 =?utf-8?B?d3pHZzdma2FRS28zQ3ZVK0RKZXlkL0QyWjJ3UEtaNUhOaEZCS1BiTDJ6ZEc5?=
 =?utf-8?B?MFRsaFluQzN4TWNFZTJFczZHaXBpOHNobjkrbWZhQm5GMWFrN0Vza0RPekJq?=
 =?utf-8?B?RE5jUDJrcnJvSXVibUtsVUw5TytDc0tzQ2JBdkNWRmtkZ2w4TjV1cGdacFNr?=
 =?utf-8?B?dGoyc3JiTU54emw4NU5VRXIvbDRkdzNqalh0YkhmWWF4dk12R25oanFmTGVh?=
 =?utf-8?B?ZFdwS3JzN0ZzclYrNHdidFJjOGtJSitjN1pwNldkcTl5RHpvQ3FDekZ1MzRM?=
 =?utf-8?B?S1JyUjFTQ25VcW5GczN6Qmx4UE9lSE1YcFNXT1R4Q1YvVHBka1F3TWg0V3Bk?=
 =?utf-8?B?djRKREc3b2FxUzVOS2E2RlgwSjZPN3FIL241VlczS3ZLc3cvU3BNdUVmUlNt?=
 =?utf-8?B?TkZVa1dOcFg2dkJnWXBxeW5HZkV1OHhsRFhVSnR5eHBoNUxONnBJTlJ2VGo1?=
 =?utf-8?B?RVBKRDAvRFVTemI1YjREYXFWVTJHdnJ0WEFZbUxLcXhiQ1NXZDYzYTRpY2pS?=
 =?utf-8?B?MjZqeXZSV2xJKzVFeUMzVXNkc2ppdU1lWWZ5TnBuZVMwSkNOa1d6ME0wejl6?=
 =?utf-8?B?UHErUHp0b3VFVG5vbHd2TU9Sa1czWExuUE04WE5QQ3o1NldGRUtQMld0dXNU?=
 =?utf-8?B?Q0U5eHBLeGUxdXFZSTRXRjh2N0VqSlJpOFFIaVk4Wi9BN0cvN3pyc0xLaEdj?=
 =?utf-8?Q?keczE2Y7cyIkj7x/tRIUpTdLW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7c5f4b-fb69-4156-7030-08dcb7c380a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:02:28.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLQeH1eBSns/G1ISciOMZZ9c5fg2kWusLRBDR5pTvouzBL/sCJ1Yp8rC4N6WbceWW51QAAyqz0AaYMb6XtHKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

Only lx2160 rev1 use mobivel PCIe controller. Rev2 switch to use designware
PCIe controller. Rev2 is mass production version. Rev1 will not be
maintained and used in future. And no road map to use mobivel PCIe
controller. So drop related codes.

To: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Zhiqiang.Hou@nxp.com
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      dt-bindings: PCI: layerscape-pci: drop compatible string fsl,lx2160a-pcie
      dt-bindings: PCI: drop layerscape-pcie-gen4.txt
      PCI: mobiveil: Drop layerscape-gen4 support
      MAINTAINERS: drop NXP LAYERSCAPE GEN4 CONTROLLER

 .../bindings/pci/fsl,layerscape-pcie.yaml          |   1 -
 .../bindings/pci/layerscape-pcie-gen4.txt          |  52 -----
 MAINTAINERS                                        |   8 -
 drivers/pci/controller/mobiveil/Kconfig            |   9 -
 drivers/pci/controller/mobiveil/Makefile           |   1 -
 .../pci/controller/mobiveil/pcie-layerscape-gen4.c | 255 ---------------------
 6 files changed, 326 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240808-mobivel_cleanup-8a790adcd96a

Best regards,
---
Frank Li <Frank.Li@nxp.com>


