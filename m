Return-Path: <linux-pci+bounces-8364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5E28FD68D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 21:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12D01C222CE
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F113B295;
	Wed,  5 Jun 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GjrCUiUR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D8E572;
	Wed,  5 Jun 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616050; cv=fail; b=Le6nasywSoo7MoncM7U+exqEY4DtdTEDHiejzfouhLLBVD/7IeiKaBR734ejdVU4cVnzef8ikmAMlSgU4fHaMCUjYksrJWlRb8Qw8tRTTSegzCvBn+5xD4xCzd8K5tsiW1108sRkLLtMJents3RUpE/FT28T3SWk1NxWrMWXAfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616050; c=relaxed/simple;
	bh=SfJ9P6Uu2o/xjPsA7uYeu8Flf7iRmDDsFYwI6jPIghE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a9T6xTmjIHhvaxjc8FXa5zGiK1Kt523OaMzj27Pxt7T/Rx7qX+hO1J2ZLub3mbth7hpsuQ41LdbXEE799NIQY5bh8VGC7GOfHFGO0Ph1QPjo8poZlq9vbjwwy4hedESaCwzUyf/sDByDjEwZy+IgZBmiB94yavlRQYOi/CxkzAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GjrCUiUR; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfD9o/FaEaUyHYZPKsge8yKtFklHpsUgiDh6qvzgzr75WBiVTPbEc460EmL2EITTAfPVwsou4k9rqRsZl+MHiCyVamStA9t6fGQ1beybijL9bAMexMBlHXMQHsxuliuY63MbcLpk3Dcg3lgpuplbyUTbg7XK/QLLHkL7VGtGjwjBAESzXypuWBSIY416vJnn8I993B9tkb240nbGMU01DpHWfbtYw5gWlGuL3QOZTt+50RjzCV6IQvuD5I72T34qRKPBWVrX/7kbFxyqldpKP/L3rRJJLQoQ1EmI6+uKLGvknGjT0PfNLF4cfWRT0ZZAphlROVQOK4UnGp+SYGfI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEjDw8pQbCggS4O0eRXO4vT7gbmW6sfsuyKDs6pYqv0=;
 b=KImxjKk66qilvLMU7bUB9pwhIJ3aLzmxdDa4tWaRCZ325v3TpoBPvJbJ37HBySyK3fwN36SFI41Mp02sbnfbYVeMTMtxhe9ExmqH6BVYh/Aad4xU7GZ3Ee606yp+J45eAPzYjnZ0FlRFsf6fHuF92fSfYfQiGTNFIIM5hu45CbFJoQ15CQ4hLqXQcwdaxB5XLJ4ODUu40ZOqDQbDruZ4ZQHaHZKc8TSJLwXiUMcf0PMDs60khYJP9/6L/KtVC6r44twAzKOO7AM7+YM1dMgidrfTQdSiIHm2AqT9FGTtXrJkY66MrSbYJFM+MjntNVr4h4nyOWC3YbUQAzIsTALDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEjDw8pQbCggS4O0eRXO4vT7gbmW6sfsuyKDs6pYqv0=;
 b=GjrCUiURr12flCr1OlPuMMyAiyHRu6abIOK5zD1Gn2khMkKcMGQyHoAB1O7RPaMZDDjz9Koh1SQFJMcKpnvJ0wTwHMN7hgnsvAhEaf/GR7v2j64kCxm0fdrrEa808vpDHVQjF+0lC3RUYe4H/LLC26exBIZ5LlHBOb0rGHLWQ8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 19:34:06 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 19:34:06 +0000
Message-ID: <3af40110-98c6-41e2-bd19-29a999f3bdcf@amd.com>
Date: Wed, 5 Jun 2024 14:34:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
To: Simon Horman <horms@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, bhelgaas@google.com,
 corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 bagasdotme@gmail.com
References: <20240531213841.3246055-1-wei.huang2@amd.com>
 <20240531213841.3246055-7-wei.huang2@amd.com>
 <20240604153028.GU491852@kernel.org>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240604153028.GU491852@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:806:120::27) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2474dc95-d3e3-4ae8-cc22-08dc859676a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW9SZTZEa1hUWFg3QkVMNGw3R0xCSnBReDU5Q21sMkFXMzJ1T2Y0T2wxRmFv?=
 =?utf-8?B?cE1BRXhhZldqT1NuVUFZUWJQTUw3WHhJTElmRnRGVFNPOEF6MmNWVmR1YmxG?=
 =?utf-8?B?eHEvaU9rWklmN3pZcVE5UkpnbDErVTZKUmF0d2g4QVhxamUzbkJQc2pTS1ln?=
 =?utf-8?B?TXA0V2J2NjJFZ2RpZ0F1blBUMEFNb0tubDRuMkNVQ3FVYlcrZ21BeDBOYVNl?=
 =?utf-8?B?SEg0L2NXOUtuaUI3YjF4NTMxSDdoQ1V0Qk1JTjVFKzdpWkxNeVJmYUNFZGcr?=
 =?utf-8?B?Z2F5Z1grU2JDSythRkNqZVk5Y3lFVWFwZkN1NklaYUZQWUFMZVlWQldNcHRJ?=
 =?utf-8?B?TXVldStwV0FYSm0vTnF3bTFpRmpYamk3VDhWQVNHc2hxczI2cnYxcS9kZ0ZQ?=
 =?utf-8?B?KzZmQmpqMDVpWHhncU9JekIzQWdXUEhwZ2dnVEVmTGhwbGN3SnBUYWFaYXZi?=
 =?utf-8?B?dkEyOTZCYTM0RmJTcHFYbW80YS80TEVvSFVuaGFONk1nekZpWi9FY2VBUm5T?=
 =?utf-8?B?aldPTk51WXFVY0toRkkrRG5qQWVlamtOVHZRbnhPRFh4SlZqTGo3bEtSNVVj?=
 =?utf-8?B?VTFlUXdwNUw2OHlRN0tJODVZRFdZS1k0ZFdQekxmd2R2a1N3TkFNOFZVRHBH?=
 =?utf-8?B?QVIyQmxEMHRaZ0NYZEEwelFqOXpxdUVlT1FZb1I4eWZwYXVxNk5YK204ODAw?=
 =?utf-8?B?SzhwZlVYRWNBRCtBUnA4OHhtVUxJclpPa0ZSS3hRQ0RYU05SSHc0TVVmOEd0?=
 =?utf-8?B?VXJTVmxNT0FzQXF5QklCK3JOVWhBdVp2UUZaUXlIUEFjczFRb092OWd0SE5o?=
 =?utf-8?B?SDk3M0owbTlOaktmc3RSeExvUkNRQk1QS3VIT1QxaEJHUEpBMjRFMTYvV2lW?=
 =?utf-8?B?Z2NUNTc3cWc1MEFqbEVYSjdXeGJQWDhST0RXdTR3ZXVDRGFTTWJzU0xNbmty?=
 =?utf-8?B?SFd2OFk0T294UnlTQ0hTNE1OY0RjV2RqUW5mYU5MYzVRbFBnUVpZZXNPZ0tw?=
 =?utf-8?B?VmhmY1hiZWxNUWU2NjQ3YmlqeXppdXA3VzloUjFNb3pDM2dMc2ZYVEJha3JF?=
 =?utf-8?B?c1VQVzZySDcwVVkvbWlteVk4cGNWNU1FUVE1dmdsRWpvWTNSK01xVjExSHVq?=
 =?utf-8?B?K3dnakZaaFlPSU5FdnA1eFNvRlFGM2o3Snhzc1BGV1VEaFRPYkFpQW04TTdP?=
 =?utf-8?B?V20zek1sMmUxelloQXBxVU1YbFBQYmFDd0RINjR2OEVKdnA3aTY3ek55NDdr?=
 =?utf-8?B?SWVFT3dseUMvT3ZlcDl6SlcyRWp4MWhTdURha3M5VEZmcW5zRGpTVDF5L2hI?=
 =?utf-8?B?bGZCZkpZelJpZkFVeStpY3pIajZQcUNnZnNNTXN5bW5TdlFPcmNhN1BpRGdx?=
 =?utf-8?B?SjdiaUtMQVpNYXNPaUtNdWxRRldGT3ptUEdGN1V6U0RETVRnVnpYRy9sNmVM?=
 =?utf-8?B?SnRjMXoyVjFrTGJuL1FDZjV6eXRxR3FZYW5NZjI0dUQ0cGJkazhwUll0dXd6?=
 =?utf-8?B?bG1Ra1hBdFpZYklObDIyaDVVQWd6ZEFSM2Q3aytwSURpS1dyY2l6L25SQ1Rx?=
 =?utf-8?B?ZUwzalFOeGE5a0lydGZzUHprM25xNHFiL0NKMVIrVXdBMThIU05wNGJadVR1?=
 =?utf-8?B?R3lubHZOa0ZwTEV4NlZQT0NIa0E3MG9KSk50c044R29TV3dOcDNaZzByaEox?=
 =?utf-8?B?elRpbTlTS2pKU2trNy84S3p1dHZ3dTIzZ1RYQlNoLzMwSm9CL08zTVZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjhTN1drdzcxYUhra0dPSk1wK1ZKTE5JdjNvbWNFakljMlZEK0NJQUc1WTVS?=
 =?utf-8?B?TWF5Nll0UFpvQ0VIS1UzbTRnNjk1R2E0SkV4VWhOUkxOTVUrT2NoeDJ2dU0w?=
 =?utf-8?B?M0RFSHAwKzRqVHkzRjQwZk8vWHJCQm9UYmVlYmZVeGFuZXdVZ1lDN1JyZkF6?=
 =?utf-8?B?Wk5kSW1NMWsxNHRaOVcxS0swSmVWdjh2VGtwQlpBaHBBMUJzVUJ5eDhmWFdM?=
 =?utf-8?B?OUkrZ3hZVnBVY0ZuRGF2R1NZTzhYcjlMVldvd3RjRDh4L0dxRXRKZUhGWjlQ?=
 =?utf-8?B?anZQNmNDRDdnYnNmaHFHRXp5K2M3MGY4YzdueWlzZDVNcG8zci9wU0ZXWXps?=
 =?utf-8?B?NUZneW9vSE13OWtieGZYSFk5RnJoSm91RXBDUlJnZ0ZrMy83eXlNK1VUcCt0?=
 =?utf-8?B?UmxvU0tNaGhrbVVHdDRXWVFubE9JaUNwditDWmtkckdiU0FNRmczL1NGZ0dH?=
 =?utf-8?B?Slk0OHlGaDFNeGJWSmV5aWJxL0ZtVndteEpVZm1QNCtMaXNlNEZaWE5EeTJw?=
 =?utf-8?B?NlkrTlJ3WTg3SFBKTytkQ1NMUGk1REVISndIUkgvUDNzNi9tMlZXdnQycW0r?=
 =?utf-8?B?MUUvNG1aOVphSnB3Y3M5Q3EyQWFlSUozTGNoUHFEQTk2cTdGRG9HVis2SFJT?=
 =?utf-8?B?ZFRXbUR2K0xORDhiRFcvN0gwRG1DTjRxMFZuellObkpWeU9EUlBOOVdjR2s3?=
 =?utf-8?B?N1VjZTFmbTNPZ1NleVU1QjlIK2ZNTXptcE4rYzBkcXFTazlkNXAzQXBrdCsw?=
 =?utf-8?B?eU5aa2FkMWNkV1ZYNVZ5V29OVG5MbitEcFRqY2lWd0Q5a1M3M1ZZSlpDMkxJ?=
 =?utf-8?B?cGV3Z0xseVZSUkcrNm9NWVlHQi9wRlF5YTZxdi9kcWNPY2V3bVhqR2ZoS2tF?=
 =?utf-8?B?d0E5cUJkLzkweTdlT1Rld2xEM3B4WEk4SEZVVnZlRzVJMVFDVVV4S1JsVi93?=
 =?utf-8?B?a1MyakYvQXBxUG1pZXdFZDZqVUpFcWVMZ2paMzc1YU5aZ3M1STJSamhNNmNK?=
 =?utf-8?B?YXFRNHFaQlZ5eUJiSjBhd1VETTJlL2xXNkxibzB5MVByMzFvSW1qc1JTWEEz?=
 =?utf-8?B?OE9Kb1crbHNkSGVYOXJ4Sjd2bVcrL2haQlpuNEsrak1GQS9qZlg4MEpRMUpH?=
 =?utf-8?B?MGIwd2FLNjRSMmM1Vmt6bDZLSnRzUEdoTTBrcjFvQXk5VE9zRTI1ME9VRW80?=
 =?utf-8?B?RFhqdmpMWkF4NnVlTDFZcjRNbXdJVTVSNU9ETTczbmgyOGJQVEJFYUJWK1Ez?=
 =?utf-8?B?UE56K3AxN2xLNlJ3NkYvN3RoMXFlb2NHUGVpQUlqUEpyNkc2OVJONHlBTVh4?=
 =?utf-8?B?NDZQMkNnMVkyY0p5U1I3SWt2dkJTc3Z1amlCZGN4cE9FTXVkZk15OUp2Unhp?=
 =?utf-8?B?am5GL0hyVG5qYUI0dTJka3dMZjlRZUY2dEsrL0FRZEtPdjdnVU9uRHQxZWlM?=
 =?utf-8?B?eDdHbE9JVzc4cTcwa2ZBUWdMUVFQaVNRVkhWTVR4d1NZbk5uWFhteE9JUW9M?=
 =?utf-8?B?SGVxR1A3M3crTjRlajc2UldyVUVsTG03aWNaTGl0TU9ZNnFhM2pJYlVFamJw?=
 =?utf-8?B?WTNWcFpsQ04rRmR3Y2s3MDcvZkVVRElzd0hGSUdBWVRWWEVpelkvMWMrdzEv?=
 =?utf-8?B?Yk4zekFlN0tDb0ovMTEyaU5ubEgwR1dtSjNzN2xmT2xoVHNNK1lGN2p2U0FU?=
 =?utf-8?B?QjBjZ2VXT0V6QjNCK3BaZGdtbkMxcXhISCtXY29GYUszYUJBOUxwNk9hU3Ev?=
 =?utf-8?B?Y3VwZUhaK1RGZ1lQa0VnWFk5L21ta0pDSWZjTm14OUhocnJadkpsYWZnYWd5?=
 =?utf-8?B?ZEtLZ3QxMkxqYTZzWkxabk9PR2JENkZsUis0Z2FHM1EvOEVIMGFLQ0JBWnlD?=
 =?utf-8?B?MWkzVDZTVGdtZzBSUDdVR3doamR0cW1XOTRsYnF3dUxjWUw4TnNNNzU5U0dE?=
 =?utf-8?B?OXF6NGRyNmdxdFRFVTBLZEpldDR3TzdLTzlTeTdzS0VVMGlLTkQ3YSt4MVhr?=
 =?utf-8?B?U3NKaGE5c3VLM2I4OVc4akl5Y0JxUWFVdklLQkxZRnZhQmhJKzl6ajcwWmNo?=
 =?utf-8?B?UEp0aS9qa1BmU1JUcFFiajdOdDlMM2pWSmJsU2FvWGljWlBxWm9QaTJ5OXhC?=
 =?utf-8?Q?y3jY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2474dc95-d3e3-4ae8-cc22-08dc859676a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:34:06.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj/qJ5O6xjXOwCNwZ7QgA2GcmPJB2xnv+zlmbjqEJHo05Z428cLJvmOzN94ce7HQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478



On 6/4/24 10:30, Simon Horman wrote:
> On Fri, May 31, 2024 at 04:38:38PM -0500, Wei Huang wrote:
>> According to PCI SIG ECN, calling the _DSM firmware method for a given
>> CPU_UID returns the steering tags for different types of memory
>> (volatile, non-volatile). These tags are supposed to be used in ST
>> table entry for optimal results.
>>
>> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
>> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
>> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
>> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> 
> ...
> 
>> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> 
> ...
> 
>> +static bool invoke_dsm(acpi_handle handle, u32 cpu_uid, u8 ph,
>> +		       u8 target_type, bool cache_ref_valid,
>> +		       u64 cache_ref, union st_info *st_out)
>> +{
>> +	union acpi_object in_obj, in_buf[3], *out_obj;
>> +
>> +	in_buf[0].integer.type = ACPI_TYPE_INTEGER;
>> +	in_buf[0].integer.value = 0; /* 0 => processor cache steering tags */
>> +
>> +	in_buf[1].integer.type = ACPI_TYPE_INTEGER;
>> +	in_buf[1].integer.value = cpu_uid;
>> +
>> +	in_buf[2].integer.type = ACPI_TYPE_INTEGER;
>> +	in_buf[2].integer.value = ph & 3;
>> +	in_buf[2].integer.value |= (target_type & 1) << 2;
>> +	in_buf[2].integer.value |= (cache_ref_valid & 1) << 3;
>> +	in_buf[2].integer.value |= (cache_ref << 32);
>> +
>> +	in_obj.type = ACPI_TYPE_PACKAGE;
>> +	in_obj.package.count = ARRAY_SIZE(in_buf);
>> +	in_obj.package.elements = in_buf;
>> +
>> +	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
>> +				    ST_DSM_FUNC_INDEX, &in_obj);
> 
> Hi Wei Huang, Eric, all,
> 
> This seems to break builds on ARM (32bit) with multi_v7_defconfig.
> 
>   .../tph.c:221:39: error: use of undeclared identifier 'pci_acpi_dsm_guid'
>   221 |         out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
>       |

Thanks for pointing it out. I will add "depends on ACPI" in Kconfig
which solves the problem:

$ make ARCH=arm CROSS_COMPILE=arm-linux-gnu- multi_v7_defconfig zImage
modules
  CALL    scripts/checksyscalls.sh
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready

> 
> I suspect a dependency on ACPI in Kconfig is appropriate.
> 
>> +
>> +	if (!out_obj)
>> +		return false;
>> +
>> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
>> +		pr_err("invalid return type %d from TPH _DSM\n",
>> +		       out_obj->type);
>> +		ACPI_FREE(out_obj);
>> +		return false;
>> +	}
> 
> ...

