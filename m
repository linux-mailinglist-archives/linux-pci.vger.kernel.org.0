Return-Path: <linux-pci+bounces-35834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D8B51E79
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 19:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2763BB044
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3681E2356BA;
	Wed, 10 Sep 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KdXQMH36"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF31329F1B;
	Wed, 10 Sep 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523730; cv=fail; b=St3wgJvRZ5mzyI/LvzMOTbb88X6BXD4+0WH5WT91TNRb5P79fgFolkqWqp3up8xPewf03c+k3aHkoGqNuOmhS6T/+PIMnHcgNL3lkB9MQZhJ1/5qh36LJGNmXaKkPQuAGGYeFuV0OkO0KiPM8+3s8ly7u+QfzVRCMu4fecMqiN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523730; c=relaxed/simple;
	bh=ZCkIhl3x2Ycb2y0kuYxfaYhTfgF4XP1r0EhQMPICFUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jR/IYvQC4VerWHT9OKGYZ8zWJSPvqiLSjWkOyZmO/Ot4LkOHr5XgeGOMi98CqTd851rwFa7NSExLnIc1PNEr9sRiaGKruz6S99IA5VbmcVcI6t7RRTbIhc45fYAuXG6//Ar/Bs3zaJC0pCsuu9RSB8YvfVghy5Z7BBCvVkxz66c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KdXQMH36; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfAj6HcvDMv7bjeWzUp952WbfRBFO0NxufutDZ5gaBufTooXmZike0xbxvfgYiMwivHu1NmFRBAwpQ/6hePMQnoH5HrfHJ7/5XamHdvDNnmb0Wj3FInnFGsLDO0XU2JvrvxPGnmKuI7xNSdQPMPm5DJ/QgBqb4nExcvgDU0lZEOJKdhkvBh82ywXK6CUDE8RQ2TAUzdAz5avVBLx4i4RObWEHcaBnK2qpcxegOXYHxpfPTkJ+QS+aK8Vi02LYmPvqNnEv7GP8JdcdBIBgeT/FcbWaS/dpvdYckeNho+CIE49vPh880kJyOjHY7gK76ttfbjvBWl7bQTBzJWdWRUG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpFZzGlMPAqxAQ8z1zV3vpdvMgopDIoysC/vJBvLK8g=;
 b=q8PnzpEoi6DrT5dnUPzXy85vUPqIRf3EoyMaDR4xtaxKoe8ET4H7+w2IIfOJ2k/W2Bq/VDvVK0n1spopvw/1COW8yhFOF/wNn7Fcq1t1tYWQxxLqUft6INzRfkurqvdjjf4WLfovyuNuRLb8X3OeV8lJaDt4rToD6Wbje4rGKUYO2DtXELYl19t5VQlivQ2VkuX1pZBifH/H/KMiX+6upA7pDqXMGLFrkdzL3JCFJa1pttb1kfAjb9Oazjx9OFHcdjFhSVBW7p9nVJsAPPEEyFs51kOgPvPz8deIxUHxGRMYSORVuSNcGh6nUlxjTKchv+NlLEqKC3B/0JJGW6w3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpFZzGlMPAqxAQ8z1zV3vpdvMgopDIoysC/vJBvLK8g=;
 b=KdXQMH36hp2eaa5KrxrRx3X/Ki2Ze6jH7oPU8DoJ5o/qOyOw2l444AUrkX8JTc9+bPyGo64g0dsO0QpeTuu/JhJ2oDdtT1mbnMvT0c/QPvFr7YcMd2PrVlrGpdSUSd5nCkNcR5+ifKVyNfZLbkGdyF9pXVFiE/jMXD3ZCo++o/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 17:02:00 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 17:02:00 +0000
Message-ID: <d7d395e1-b5f2-4897-a6f0-4d503e0fcb66@amd.com>
Date: Wed, 10 Sep 2025 12:01:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver
 for handling CXL RCH errors
To: Lukas Wunner <lukas@wunner.de>, Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-7-terry.bowman@amd.com>
 <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com> <aLFnKbWtacLUsjAi@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aLFnKbWtacLUsjAi@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: e92e0510-94c7-4945-63af-08ddf08bc1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzlqMzBYTitXRlhIcytQUUpMaXRCOElBNU5mNkhPWFE2eW1rcnJFMFFEZVMv?=
 =?utf-8?B?WTRpUUl4YXBTZUZ5NnlETkZLK3prd3R4TURRbmF3NWU1ZmNoektIa3llSjg2?=
 =?utf-8?B?azYzZ1FqNUx5U200SkIwdzN6akNwUENoRzlub2JzMGJ2aGV1NFZQRmZ1V0lT?=
 =?utf-8?B?V2VKdG1ydGdlUy9EWlVFc056ejNFUzZUVHAxWWY1a2lQYWtQaG5RWk9VZGFp?=
 =?utf-8?B?TnV6UjAwaGpqbWFRMDBGY2J3QVdkZWM5NUFDaUlqUjd6TTZ2RXZhVjlZL2dk?=
 =?utf-8?B?VHA0VnQ4TzdKVkp1a2xqcjl5NWFqZ3dJT3BwUkJoUmdoTXExZzRJOWYvSzJr?=
 =?utf-8?B?a280RGIvMWhmdHYyRkk0eTBkVGdyMnplczZ6aHViRmRRTFdaRU51MXd2VjMz?=
 =?utf-8?B?QmsvSUV5Z3drOVA1d1VJYzVDbUMrZllRK3YxMk9OZWh5eS95UEExUXJ5d2p0?=
 =?utf-8?B?b0QvSXhpNW9SSFlzcWhmNVF2LzE3elAwUDJDY0RqdG9IWmlTSkJ4dHdSSllL?=
 =?utf-8?B?a3ByY285VlNzMWpzbVpwSm15ZTBuS0V0ajFwT0ZrZ25hRGZRdFhDeVlFdDFl?=
 =?utf-8?B?T1ErWE1IMDRYZysyZjhoMWJrZXIyclJmeGlnUm1CY1dobnVpdVpWSnhMSHVl?=
 =?utf-8?B?RUc4TWNxek41RDEwWStJSHBRczdjSE9Gc1VuZVE4bUZHR0NOdE95RkNGSk1S?=
 =?utf-8?B?WW5QT3lHV0tIYXljbTgvSURodDJ1eURjOUlXSjBXYUdUQXhRQWQzdzduZmpD?=
 =?utf-8?B?S25vV04yZTM0YU02emFYM2Vwa0EwS2FkS2RoVVNLWWpiYnoxTjBkNUsxaGE2?=
 =?utf-8?B?ZnZDWWEyZDNTNklENEhjdC9jTlltUlVla0ZmSVlwZkNKRFE5a04wam1makRi?=
 =?utf-8?B?R1VNNHpzdjFnVHg1cmUydy9ZcXIrVjM0NnVZRnl1b2grNk91c2N6YjBhYUFP?=
 =?utf-8?B?ZkljczhrVkVvcnFrRlBnaks1cE5ZeUJzWXpXaklzVE1WcktBWGNYZXZvV0hi?=
 =?utf-8?B?aTRPajVkL25WZ2tDWU5XdU5EZldkdURndkVwYjR0aExHekNDbmF3N05uZlpK?=
 =?utf-8?B?Q2g4djJRNW1PVTN5MWNFSUx3TkZaNERsa09SdCs0cnVtVWt1d0RsMDdjdU9i?=
 =?utf-8?B?TWVkSDVSdEM0QmNiMkdnMEdQaUdBUXg2d0U4QnZ1cUhnYWhJVmQwdHB0eElD?=
 =?utf-8?B?N2sxNVBycFZ3R3BEZktId3oxa0lEMXY0QzdyckxyemtKTS9ENTNpbGJzN0RE?=
 =?utf-8?B?QUEwVUlJaVpzczZjUFhuRHlMbEpUUmdrZnZPeFVOOUVnNkhxRHFUMEJVckNj?=
 =?utf-8?B?NGUvNkRreXlKVFN3UTB4VG16S204TXgyeGFJb0J5Z2J5bFlOU3dGRHNHVVVE?=
 =?utf-8?B?VG5PSXFWS1F6akN2VHFoZWx6ZjVOdFkyZ05sQStYaEgyMGhrUU0zR2tmeDFk?=
 =?utf-8?B?WWRhUXJYMEJRWk9xOE5xSW5iK1gyTVVsRkN0SVZnVXIrR3Y5VXIxMmxuWUJG?=
 =?utf-8?B?K1lKT21OVVZWV3p5ZUhtWVpMQm9XR2JQZmZESU56TTVBQVdBY3AyUzFGTEEy?=
 =?utf-8?B?TTZQTi9udFB6MW03akZLNUZWR0hNNmk1TnFlWTc5ZUVJV1RPVDBVWVd0Y0xP?=
 =?utf-8?B?eVVOQzdJQmV4NUNhSjU5RTdaN0FZMitLNDVia2xyQVh4VWN5QmVSSktaUXNm?=
 =?utf-8?B?RmJ5bTZQZzlTS3hnRS9MR2RmWHlBOFJxNDdlZzV6eVBzT0FLYU5BSDcyK290?=
 =?utf-8?B?ZmZIc1liVU5xbU5hSWVZVG1pWWVqNTNKVmdzQ1l5TWc0eHNkL3BoTjl1WitH?=
 =?utf-8?B?ZXA3RnhMWndyQWJ0Q2hYNlBxK1MwWHg3Mnd3aVZ3Y2xKVkp1UHI5bmhtV0Rs?=
 =?utf-8?B?dmhJd0JiUnNPWmFoZkxBanJlRlIvUzRSL0pLOHRLbWxaSWRlQ1NiQ0hXTU02?=
 =?utf-8?Q?QulOypU/SLE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUFPZUtWeDlJT1orV013b2t4WFNETXlsbVlRdVl2L3NkZ0ZVcWJqQkh1MlJH?=
 =?utf-8?B?Y3lEU3p4aVFLSk9pU1lIbUJSWC9DVHlYaW5RVVY0ZmdBbTRzNGs1MHIzZzgy?=
 =?utf-8?B?ckZJOFRqUXdydTZrWHpBRzlEY0lOMXJITTBuVHVOUi9SQ2hOR2hKT2J1Tkxv?=
 =?utf-8?B?U0J5cytFWVoxQVlGQ0VhYUJaWUpyZjBjdlU1YTBaNVk1ZmUrY2NjWEgwR2dI?=
 =?utf-8?B?cU9nRWdkbVBBUk00Q0RMYko1UWNvQzBFdFZWNndUVDB5T0UydGNzdVhnTUtq?=
 =?utf-8?B?ejdIVm03UUppK3BCUmhzdWVHNmxMU3J5b0RBaUxmMUNmZlh0KzJsVHgyMkwr?=
 =?utf-8?B?OWZKVmlNdTFmWGJ2aDh3QTRIcVRlN0FrVkxucnM4NTYzWVduL25BOEgwNDE4?=
 =?utf-8?B?UTEvOHFpUmpvRkgrS0hIV0g3TTNTL1B3UHAzZXNuOFp5dDcwSER1VXFDVC9V?=
 =?utf-8?B?aldOWkJQY3V0amVCQ0IzdkpiUVlXY1hRSjc1MitOVHVBTG9nbGJkOFczazZE?=
 =?utf-8?B?MXlCUW1waW5SSzFiSSt0MzZWK3F4S2hoSTJPSm5DQy95aVVKUExYYVpPR3o5?=
 =?utf-8?B?TzltZ3VGR1VvUk10a2ovdVRGOUJmeDFLK0dqTWNwSW9yaVpXMDU2SzlvbjNT?=
 =?utf-8?B?L25iT280cEJvSlBzZG50Y2hMNUdlLzNxdy8vNWpkckFOUEhZaHkwVzdXRCtR?=
 =?utf-8?B?dnJZSXE1WnJWVm9zWkF1YVlPWlV1WFBSRjFpR0wvNlZ0dWNKR0p0cHh1QXV4?=
 =?utf-8?B?SnpGdTBOYTZlaks5ZFd5d1ZFNm5VdkJZa2w3VGlncHJWRWtlTTAySWlwaEdM?=
 =?utf-8?B?VEZrUkl2QVRKaGFlSDF6amFkdG90ZzdZZzdWZkFrNnIxUHF3Yy9Tc29VdGlY?=
 =?utf-8?B?SHhOWWEydWxVcElnWkJQRk1ueEdCZVgrM0o3UzhSUDE0dmdhQmZuek5oRXVa?=
 =?utf-8?B?cmNYajR2Qi9SRytwUDRyZTBKY3UxT0ltVmpvcEhYSnV3Uzl5NnlweWJybDRB?=
 =?utf-8?B?YmlFSG14d3EvazRUR0F3RUlYNis0NnBJZDFOK2ZNUzVaMkR2UW5vM3p1dUZ0?=
 =?utf-8?B?NG1GVmVzSEdMbVNvMnc3RFJDYzN5ajlxU1VrOHhqRmFDQks4Y1JRUllhWjhP?=
 =?utf-8?B?eTFzOWNSbGFCQ3ZCUE8rMFhUQ3RwRXN4bzIwV0hZd3U3Tm1UOEJqc2xsaEZZ?=
 =?utf-8?B?UGxuTjBMNGpiYnlSK3BUNTZOWE9qRTBzTzlYWVVXYUNwMklLZEM3clk0ZG5n?=
 =?utf-8?B?eFpnNlFoYTR3TDRlZTMwbGYrZjNPVE41ZW1OdUhxb20yaVhEWmc0NlJ4cE5Y?=
 =?utf-8?B?aDQveERhQytWU01qanBaVW9TQmM4MjZ4enNWMlIrTXhaQUFWbmFpMUwza1BL?=
 =?utf-8?B?d0hLbkdQbXRDdTM3cXhmS1F3SEgwTVdVU1VBMnMzUmp2UmhHd1l0MERHSmJu?=
 =?utf-8?B?ZGlCSWs5Q1dKaERxMkVGb0hNbE1DUGxxaThOdXNsYmV5V1h3M3Q4NGxFeDdH?=
 =?utf-8?B?NVFVME0vRzBZbkI1UlF6dnFkaFF0eUIyeGpYbzJ0eVRIZUV3bndxN1JwL1BY?=
 =?utf-8?B?OUg0czlBd2NjTXlCOFlhYjVkY1NpM2hTWWlGbHRJK2MrNEdISFFRMmxWWWVU?=
 =?utf-8?B?aE5kT3JQcG5mZ0JBcXFzSGkrelh3TW9vQ1dvRDBWU1JBRi8veWJScDl2RGhU?=
 =?utf-8?B?anNINGFTYTM1VG13SWx6V2svUmdIT2FsR1pER0xrdTdKbEV6V3E4QmVPNTdQ?=
 =?utf-8?B?WGNwWGdITXA1QXVubS8yUVMxanJjb3RuUXNIdUk1djFmcGphaHFuZ01SVWRv?=
 =?utf-8?B?ZDg2a3grbnM2ZGp4TVIvNnZuUVkxWWw2eXU4K3h1eFVaK3dZVUpHME95cnZG?=
 =?utf-8?B?eWRYZ3pnYjJtaHVZNTZva29UNHZmeVJZVzAxdWRmQ3ovS2V6YlpMOHd1S1Bm?=
 =?utf-8?B?dm9naEpRK05sTmtVZEJaWmZqcG85b3d4aXlrSERuQjJ0NkFsejdKaWl6Z1ZS?=
 =?utf-8?B?RlI4THpuaG8xMm9Rd1V1YkFnVU52SmpoSWRCZVVOSGlJQXdiY2FPbWltbjJI?=
 =?utf-8?B?eThRZVliemxOSkJZcVo1RDdrT0ozMjFpN3dORXl3ZE1Sa3FRMnVJVzhldkp6?=
 =?utf-8?Q?CMXn28KrG3M7zFZi5Kx3++nuW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92e0510-94c7-4945-63af-08ddf08bc1e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 17:02:00.2615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1d6NhoVfqzj4b/IP6eMjTjM2rksRDOcpuUoNUpg2DIGSHp2gD0Eyfx8fyaTEKLjzf1lWuDdRcu1uFtYdenLD1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429



On 8/29/2025 3:39 AM, Lukas Wunner wrote:
> On Thu, Aug 28, 2025 at 01:53:35PM -0700, Dave Jiang wrote:
>> On 8/26/25 6:35 PM, Terry Bowman wrote:
>>>  drivers/cxl/Kconfig        |   9 +++-
>>>  drivers/cxl/core/ras.c     |   3 ++
>>>  drivers/pci/pci.h          |  20 +++++++
>>>  drivers/pci/pcie/Makefile  |   1 +
>>>  drivers/pci/pcie/aer.c     | 108 +++----------------------------------
>>>  drivers/pci/pcie/rch_aer.c |  99 ++++++++++++++++++++++++++++++++++
>> I wonder if this should be cxl_rch_aer.c to be clear that it's cxl
>> related code.
> I'd prefer an "aer_" prefix at the beginning of filenames,
> but maybe that's just me...
>
> Thanks,
>
> Lukas
You guys let me know what to rename it to. I'm fine with either 
change: cxl_rch_aer.c or aer_cxl_rch.c.

We also have the VH analog of this file currently named pcie/cxl_aer.c. 
This is introduced in patch 17, CXL/AER: 
'Introduce cxl_aer.c into AER driver for forwarding CXL errors'.

We may need to make similar change to the VH file name as well to 
be consistent.

Regards,
Terry

