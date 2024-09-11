Return-Path: <linux-pci+bounces-13059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7907975AC2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4811C22AAC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B415224CC;
	Wed, 11 Sep 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gg8PIoQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F311BA273;
	Wed, 11 Sep 2024 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082220; cv=fail; b=OrVWgUNAXsyuSD2Kp3wlQRQkHEzfcAs4ISMJHwdToE+SnVXrXliPqinUkNbm9lETxD0H5jLtQVXakLxu+7rMV6VOsuzcIm5sMovEeEA4aRjWMKJHhE003kL58cvbT/jzZzw13eIzBpADSutefRk/tdKV023s8fGrtueNvl2jplk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082220; c=relaxed/simple;
	bh=opjRmszI2OvXVy7c5DbVq7AjrC77jdi8/o7uHf7/w14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VsLBcQ676+vTVhFNlCP2a5irzR1aFvXWMUPn6rkC8H+LBPVePTNjU4cg9LHnF4VPsGV9/sjmSE3IYle01Vl3qplAwIUUuePgrToITvqTVRA3uyHjgRd73wbwMvJ/wb8AkgJYhBRrD+PS7MeJ/OHNke2xXxfONRypEQ/MBLvbntg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gg8PIoQh; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoCXywbS/Q8qDQ1iXu8+4RzrKb/yQDlRP35AWIApvnMaUf6iyh0kV3Tnx3cXcxXtqcAroIPVcv78YfHPgdXVVbdNLinzimIXnhCldm6ldEGqbNeuWwB/jQ4jwxzW1OmmVko83lk3EWUSHmt4byxnf953h9c3fC7Ahi7yWY6zITMdXqN+NfZ4gJgHFboD6NVqEtyeWdKGcE5ayMcrOg+eCXqERHIWrpt2pqYVOmEadWpUjFRIZ2gE26XXLjqbVI6Eqs6adakNgsh8sfFNeIPuQrVeOD6uE8GJGO/qcALYmXAqcHvYwa0vDHSBghiUwebn4+8VnEZuuehzostPq3gPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIs3MdI3zKkbVzv6HKcA7vGMVx7Q/StynUuPboiA/ds=;
 b=Mp8j/lAtgJfntHc1vvYgEQPzVQ1hThGPDM0WMAnSoMVXuLHX4Se4Q4aAMXrdD2tjzvD1DzidHxsGTXaVVT+00GF7ztRt3TNjPPH+UV0NDHgvPB3OESS4eRvDptHmB5KuJSQsviguOPm9464y07dgeJTGv1Pqw7IuyRsR5UyNw8Zzoke9nL2pwBcqYFH9WpsnEX4vs389Xd/5073D/x80F4gAlDBK0+3toPnaWJXCqt+2DfiTpH1jFBjcm5YXByAV36amZHDVdi60McYb810mAMm0aFmz35usJZ8jHtJrwP2WQr4l5To8gDo3vfffszwJslEUezlSJDwCIlMGXXOydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIs3MdI3zKkbVzv6HKcA7vGMVx7Q/StynUuPboiA/ds=;
 b=gg8PIoQhxvcK2qrcNorVgRHXtKq/09JBcwCfrrkVBsDlSUFPdWo92EkIY/0Df99hX14AGyCRsdBKi+IByFCXeM4f+oTda1+GyLdAsTbO+2Ug7OFWXB19PMu7Q+Kyp8tIBI0nXtfrNNB8+q2qCN/Po3xzjkURHbnyHrC7ZmS6Ed4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 19:16:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 19:16:54 +0000
Message-ID: <319e5419-3b12-4672-9f51-f90c5e142e29@amd.com>
Date: Wed, 11 Sep 2024 14:16:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Bjorn Helgaas <helgaas@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240911190516.GA644336@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240911190516.GA644336@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:408:d4::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: aa07b164-8109-42ab-9622-08dcd2964c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3VtYWh6OUloREhQeUIvcWt3MmxrQkpXVmNtM3pwQXR1RC9jN0hlbUQwc1Zy?=
 =?utf-8?B?aFlKT2lJRnhWamQzbEJqWk91Tjl3Y1l2MkwwRmpaYVhuYXFyUnhkTllodmxD?=
 =?utf-8?B?RWFzeXpROFBOZm1CYkIrY0oxSVVNY1pMUXl4cUlGRFdkWlBzUngxSWZDeUZH?=
 =?utf-8?B?WVhJb1JReVo0U2k0a3ArZ0NSSWJvbzNTeEJtanUrenU5cFNScHRic2hudis4?=
 =?utf-8?B?cVNha0I1TVJWMWhjU2MvblVpNGJGVkN4MVpJU0pMMUo0TC80aVN3YnA3aFdr?=
 =?utf-8?B?QWMyWkVQNTE2MFg4aEhCVlhtdDhIRnZiUzh1WWUrTHJJempVWnZ6WTVDYXYv?=
 =?utf-8?B?ZEI0RGdiWHYza1ZnVGRtMTJRdnFXc21EN0pYMVdDck1Ndzd0Qjd0TGpQb09W?=
 =?utf-8?B?UC9JV0pzS0NZTjhVL2VLZWZSOHg0RUpZWXJoSVBtVEFTTU1leWROelpOenJl?=
 =?utf-8?B?bER1QnJjVS94ckgrYXl3UUZZWnBIUHp4UnZPTkRlZEVCamt5WGZ3eUVoeDZP?=
 =?utf-8?B?V3V5aXEzclU5emFlR3ppK0pFUkZUM2xGdG9LWlhSTU5QWTJIQzJNYlpkVUVL?=
 =?utf-8?B?UEtOZWJnS1BIUGgzVGFmQWVYOVFWSVJxZE5ORzZoN0tZUC9wMUdkSmtmWXN1?=
 =?utf-8?B?S1FKQW16SmphZW91TW9wUjBGcURQVzVIZHJJc2tFRzZ4RER2VzNEU0k4VW5y?=
 =?utf-8?B?WTVPRnhVR1RKUVhhbVN6U1g4NVZCRkRlclB1TUZLZFVMZDVwTCtONHY1eFFs?=
 =?utf-8?B?M1VpZHFLUktVUVY1MG1jMTVBSGVvMmFhdVJpZ3VwZUFhVHZPSnorR2RrLzZG?=
 =?utf-8?B?M1dJeStkRngwSDZDdGFnRTcxclBNenA3SElDTDVZdFpNVWZ1MWVJS3hiNjFU?=
 =?utf-8?B?MXRtOGRzVURDSHFlVW1ndFQ3cVNBdCtPQkNGSWF1K1RDWXUyYmk1SHNRZWdV?=
 =?utf-8?B?bCs5VktxQ01CcEpYNmMzL0NhYmdQTTQ4K3lmSmFzeS9pY01jT3B6M2h4TzZt?=
 =?utf-8?B?ZkpKRkIyZUs5bFpsQ2RsMUkra09zN2NwOHl1aXJmdytVQzc0Z1BsZEM5VHpO?=
 =?utf-8?B?dW1OZlZPUjVpMGx0TVVLMGlVM3QvRlhwcmJobmRTODY1OTR2cmViSXVkMW9l?=
 =?utf-8?B?STRLczVobFVySXA5YUxkbDRtbVJPbGNxZzRyNW1mc0puZHl1a2FaWXhDejZX?=
 =?utf-8?B?V1ZnTmNnMzY4TUlLbmxSVis4WWhIMCtiUklnNGUvY0NLQVVBeU1vOGxhZ2Rj?=
 =?utf-8?B?RmJDK2ZRaWpSOC9MQUhHdHRkY0lFRGk0cHpZM2F1SkliQTNueHZlL0tLQVBs?=
 =?utf-8?B?a01iREdnbi9KSEd0ZzRRTnBrUDlvRnAwNzJYSTczODNZNDlvOTY4SWJjbnFR?=
 =?utf-8?B?V2c2OTlXWmt3QVhiSWxycDB5S3RUZlhyRi9BR3hVOHFBZ3o3OUlUeFIrWHFI?=
 =?utf-8?B?RTA5TEdId21US0Y3QmxYUEk4TUlvMzkxOXhmRTcrSWhWNCt0RHExaFRheTFG?=
 =?utf-8?B?ZEcwcEtqUXV3TnkyQllMWHFGWlZRQW5NSUx6cEIzU0g4cElCNWpLSzlTdDls?=
 =?utf-8?B?cWkyeWNYLzNPOEtOTk1sY2t6NW43UzdxUlZKQnJ2NHZmU3BGVDFjU2FnWmFp?=
 =?utf-8?B?d01lVjdsZ1FqNjZIc1dRNFVlaFY4VzMxOEhxZURyblAveXE5R2xUa2tKRWQ5?=
 =?utf-8?B?MlBtN2kzeEYwZDNWL1pTdk51Y0tVZEo1dEVlZW1yQThlenZNdXVmL3pSNzlV?=
 =?utf-8?B?eUFXTXJ4bGpHdnBsU095Sjc2c3dIMWRGdEcrUFVKMU1KY0pTNFEwdDZNTE9i?=
 =?utf-8?B?MHl0SkVzck1rZ0tSRHBtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVhKZVlGQ2hWNzBsQi9QZFBuYXpmNFJJYWV5WjFReWdGaVhob3QvRXlDbGwz?=
 =?utf-8?B?dVlPSEUxQlNWTkphTC9OMlY2ZkMzZHpsVXpJMHR0VFRUYmRTY25vSkVlZG5H?=
 =?utf-8?B?UTlpaXVPRU00WmpsK3FEVGFQeGJWckJLR05WY3ZjMzlQNEdwN3lzSFRSaTFn?=
 =?utf-8?B?cVU4cE5mUFp2OWpaQzJ4TDYzWjQvbkpDNXJyNVMrNTJreTFTbnJkcDRIRG81?=
 =?utf-8?B?aTVySEpXd0RXMHdhZCtHTmZIMlowcXVDbnJCUWJQd2haOWpKb2M2a0R0VlBC?=
 =?utf-8?B?MExVbUtuV21KaStobFlSeElwV1hQN0FjQ1R0R2VWck5KQjNtY1RLLzFxWXk5?=
 =?utf-8?B?a2xlVkRrMmx5dllmd1YxRjZtUm1JU01laXoxOC82TUJXbmV0WnF4UFNSbVB4?=
 =?utf-8?B?RXhObTZ6bGdISkxIaGZFSUxhZk0ySU5kTy9YWk5QWFpJRURxK3VFNXRjZC8z?=
 =?utf-8?B?anpkRVhBdDlRMitwT2JWNUl0cHBudEt6T2JvYmVUUDkzTkUwTitFUnQ3bmI0?=
 =?utf-8?B?eFg1ZXpod2lkNHd6K3FtVjJIMWJlQkJQb05veXJEV0x5SndqUWZubzU2czA4?=
 =?utf-8?B?bW1NdmtnazdpTWxNUzd5ZjJaYUsrQWlpYXUrdzlFTytwWklsckdJZUYwbXF6?=
 =?utf-8?B?RjZDNktBZVF2VWJFQUplN01EVjVWTWJQeU15dmJDT3FYSjFQY3o4dWZGL0c0?=
 =?utf-8?B?VGhmU2lkR1IyNFJFL1FuM3d2QVBudEc5TjJmenZ5Mjd1MVp6TWxhMkdmK2Ni?=
 =?utf-8?B?Vnl4bW0vMXlTRVNMQVRtMUh1SjAzREE4bTgwZ2gvL2pmRFRpMExibjlxWmh5?=
 =?utf-8?B?UWF6OFpMcDFFSWtmaGpQWVd2WFJJOW55VG5OeXBOdmx0NjZwZmZuZFpGYUw4?=
 =?utf-8?B?M2U2UUZLZG5yUFRQSC9uUWhBYkN2ZzdZcHhWaUVETEUzWStzbnVzSHlsaXJZ?=
 =?utf-8?B?WVRJUVA3N2RUVHNjZkRQaitvT2x5MEdYcjUwVjhLMmROR0F2ajNZL0EyR1ly?=
 =?utf-8?B?SE1UWkZZQ1BSQTVlTVk1eE5VTmhRaUJEbTFaVWZKTG41aGVRTHRxQ1hMcCtY?=
 =?utf-8?B?a1FQSzhsai91dDRtcHEwb2ZMMWpxZ1F3VkZvbUpUK2o5YVBtY0lYMDl2OWht?=
 =?utf-8?B?eE94VWtJT2lwdUdEd3pKTXBSaTZtWU5hamNPenZDZkY3MTlpNGRHK3RuMUpl?=
 =?utf-8?B?a2VqODlUbUdPdjdhcVYxa1llZjNvVWJjM1NpQSt0WG9Gcnppd3p4ZlducDRy?=
 =?utf-8?B?MTNycDdPSkVGRldKekIrTWlMaG5KVHAxOGVPbVdxeDQwYkhsTnJpNDFZaHp5?=
 =?utf-8?B?MElnRmZhOUhtUnFxK2JjT0RyUlRtcnlPUE9wMEdCWU1OaFh2SFA1R1c0K2d1?=
 =?utf-8?B?U0YzVFpiRlFSYUJsZldvb0JhMDNlaXA1djRMK2U4TUl0dktuditIbGRoMEpF?=
 =?utf-8?B?MEFZYkd3RGtyd0czcHlkTEVUa1JtQ0dGOHl1ZnZvKzRwcGFNYmRMei9qUk9K?=
 =?utf-8?B?YktJVzZvYWx5YWo4Q0NTV2MxWUtVTk0yREFFOFlCdjYzVVM5Z093dGMyVDRM?=
 =?utf-8?B?SHdtaXUzT25IanNvZmJPSVRJd2NuV3JHWGFXZzNiWGdvMmJlelNvZFh6MzAz?=
 =?utf-8?B?cy9LRTVQWit4Sm9NUzdBV0JEeWM0Mms3V05kampNNlFHSmR5UnFybVdYSHJ3?=
 =?utf-8?B?T3I1NU5iN0NENmhFYktEaFZOVWowOU1kL0V3VTVQdXlNaXJKSmRhSnRJVWNF?=
 =?utf-8?B?NVRqa1RoUEZVeTB6eU9oSE9xOEdieVJteThpLytSRmNtV3kzK0FzK1ZLdEZ0?=
 =?utf-8?B?MnkxcVhQRXpObmN2L3lvK2NPR3ArUFhtSFdyZjhRNGM1RHhNYWlwZ2VyYjk0?=
 =?utf-8?B?WUgwQlhTRW41V3R3SWxQMWFPLyt2R1JWRzRGc0NyYThJV3FRaG10aWg2VDdm?=
 =?utf-8?B?SVprTEc5M05Ld2FucVcvYS9kZzdVVVBmdFBzTVVsLy96bFZTSlp6Z0RBMnFE?=
 =?utf-8?B?MEdJRXY2UXdEQmxOZ0w3cEhsZVNjMUFaZDhhdHNMRkhVdEx1b1VQM0FkTjdQ?=
 =?utf-8?B?VFgyTGxkM0Q5REtrdmFjUE02bWF0RCt2ZHlOVldVcnZmWTNSc0JmUDVKYUhS?=
 =?utf-8?Q?lMZJTksf28h5bsiXyj4LyulJz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa07b164-8109-42ab-9622-08dcd2964c15
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 19:16:54.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pl3uDD/lY01fui2HwTwcdnh/fnE/iE1wW15MxcMixXSgltIK23WUpLoXPBIdG6UqBY1RfVCpc2ZYWhXZCFC7wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238

On 9/11/2024 14:05, Bjorn Helgaas wrote:
> On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
>> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
>> connected.
>>
>> The following error message can be found during shutdown:
>> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
>> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
>> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
>> pcieport 0000:09:04.0:    [ 7] BadDLLP
>>
>> Calling aer_remove() during shutdown can quiesce the error message,
>> however the spurious wakeup still happens.
>>
>> The issue won't happen if the device is in D3 before system shutdown, so
>> putting device to low power state before shutdown to solve the issue.
>>
>> I don't have a sniffer so this is purely guesswork, however I believe
>> putting device to low power state it's the right thing to do.
> 
> My objection here is that we don't have an explanation of why this
> should matter or a pointer to any spec language about this situation,
> so it feels a little bit random.
> 
> I suppose the problem wouldn't happen if AER interrupts were disabled?
> We already do disable them in aer_suspend(), but maybe that's not used
> in the shutdown path?
> 
> My understanding is that .shutdown() should turn off device interrupts
> and stop DMA.  So maybe we need an aer_shutdown() that disables
> interrupts?
> 

IMO I see this commit as two problems with the same solution.

I don't doubt that cleaning up AER interrupts in the shutdown path would 
help AER messages, but you really don't "want" devices to be in D0 when 
the system is "off" because even if the system is off some rails are 
still active and the device might still be powered.

A powered device could cause interrupts (IE a spurious wakeup).

>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>   drivers/pci/pci-driver.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index af2996d0d17f..4c6f66f3eb54 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>>   	if (drv && drv->shutdown)
>>   		drv->shutdown(pci_dev);
>>   
>> +	/*
>> +	 * If driver already changed device's power state, it can mean the
>> +	 * wakeup setting is in place, or a workaround is used. Hence keep it
>> +	 * as is.
>> +	 */
>> +	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
>> +		pci_prepare_to_sleep(pci_dev);
>> +
>>   	/*
>>   	 * If this is a kexec reboot, turn off Bus Master bit on the
>>   	 * device to tell it to not continue to do DMA. Don't touch
>> -- 
>> 2.43.0
>>


