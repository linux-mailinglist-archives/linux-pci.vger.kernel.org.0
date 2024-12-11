Return-Path: <linux-pci+bounces-18190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227F9ED87D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24815280E77
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960431E9B00;
	Wed, 11 Dec 2024 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pMSgP/uh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0361C3038;
	Wed, 11 Dec 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952275; cv=fail; b=iLnTMgHyARNb23s/dIESAqdiAsMy1IS3j1iqeNXdjZ0yJaaxnN9QfnUgCyYtNSwsZ4lCwZlKGCidG8z72dp5HxXCkQ6py8AVi0Fswm9yd0ha1cug395bPjbxEklyx0d3X5tWt2Wov3XouufQtXhYWfAMesUInERdEjiRYU3hzI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952275; c=relaxed/simple;
	bh=y2qYYs95euDESYHw9v1vbWfcMBMRYoV2s6IEAe1UrPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fgrZAdm1+tJb4pqKutvkXrBk8EIgO8+VaikKSHrtUsIN2q7DoKMzKAVqt41qNbGKRfv4BQO1bhe7Ykc3vCxsAXMKL2h+ToZhg4hLPSHmx0kznA5yhLR3wX+vyZaIxdxMQ5VqeG/tu9Slyzt3Hp3ex1s96D6ms9omlesHZ/1VfnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pMSgP/uh; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqERmYLElKTizYK2Dcc/WTdlJ+xDZlGSS6cPSDAAHPjJfeClPcpTnx8eeDkjKGrL7WAkTfnG8YXA7+79AFXPvAXcenDgYWzMVYaRu4WwQhbTXSEpN516SIs12zI8ObxGLyKFIe6Ezit7BCMpKgfDVULs8pOrLdx9sjgv5BC/+O9FweQGc08rrC34rUWMn9l5AxJa/44jK4kX+aCxr//8vbLYDLEzfTy7Mw9k/40GKbGHzUZEwzPQPCtedsz5yXzJiQVbCl3uDHCn8IGGNPxiCWtcvR95LVbyvT+LgeP5SEVW8LzZ5MgceM3dTQgD+mAvWxp8WsEt/ntXQEqXEb4z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w8wVmUFnnhHwKMZzLgkzv/KB7xOpofrsa9OTqWGl2Y=;
 b=SYGj7cbS1QgVg15kNlKUzvkJQEva7GUj+NJce/6Kf5IsZg94WZFS538tW8FN/G5iRFxUpcnvdm7m+9wPtAvfu2my3RzWQirBEYIGjZFO36yu1SNi0ouyLd5h2+msCm0XmPKDAb7QG5bPD5boeeuyfdG1ImajMai6Z0AVyMhiHM9242sig1/FjdYTlIQ0Z9I45zC17EiBtgMaCG2iIQFCw2eBouMcM5jYn89cbbtC0EPzUMDvEMm38BAFr/4FXikQCrSZx+lGCpf6dknkPz9owWFHjnBLbyYW2a7d/JWVAG6VYhiQ591CoEoAylEsUaNUchVtSLYZrPv+N1xock2VOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w8wVmUFnnhHwKMZzLgkzv/KB7xOpofrsa9OTqWGl2Y=;
 b=pMSgP/uh+ee9YZLwoDOkl+VQ0Gqeq5dt5dPf4Ex0AOMPnaHo664j4ZG+DjoviLM0Nk0mHDW/TSo7R8SOBlflGyrGAXGc6RqkC61eDNjQK+OK95bAxmfyuIPkPmU1Q2nlVBcrPWL2JYlTvQgTMiQ2e7pJfuM2c97sQIwPL5AKw84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 21:24:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 21:24:30 +0000
Message-ID: <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
Date: Wed, 11 Dec 2024 15:24:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0177.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca9dba4-3003-4974-289d-08dd1a2a331b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0NkZExDUjUvMHVyN29NbWdWNnc2Uzd2OFYwOGdYVFp6ZzZ1NC9lK01ZMFZX?=
 =?utf-8?B?a2tlLzhvR2tjMDExUFVqYkpqT0Q0a2J1WlhvMW9lRUx3ZFpKRm5wWmZpNnBj?=
 =?utf-8?B?NndTZW8wUE04LzFXSmlYUEVFNWxUTmZnWEcrcG1Qek83dkt1eUErbUdNYzgr?=
 =?utf-8?B?djE3Si9mWDRxRVg1NnF6K2NXK001b0xVclhxV0JGM1pGUE9TanJzSkZHdlRV?=
 =?utf-8?B?UmRjS1NKODh6WFJMREs4SDAzRlRoQlRvSjZxUmVCU2xLT1cxM3RveTZJaVBh?=
 =?utf-8?B?a3ZjTUVLOVE3aDBKVUdyS2xIbkNUeVYxcDNQbmdUelhGR1dzcS9hV0VkMDB4?=
 =?utf-8?B?VEttdmtBR1FmRlM4T1JDMnI2THNnWTdjUW9tanFkRllvOC9zMElaR2p6NDkw?=
 =?utf-8?B?VU9jYVNCa3k5SUdpb1pOUUd1bklkcTEvaVJHSEF6anNQT1JjZFRqa0NBOElv?=
 =?utf-8?B?dThFTTBJYmpYK0Z4R1MyS2R4ZEFKMnlvcW1NTzhnd1pWdFR0Tk1DR0hZdDIr?=
 =?utf-8?B?dUJPTmVnREQ3UW5ycUpYN2xBZWVaNVlGSjFESnZrRVNTa1k4NlhZaVZiUW5h?=
 =?utf-8?B?WEkyZlUyTlV0K0srdUZIUVZXUUc1bndLR1JEdVdpd2xENEhaVklncEdoTU1W?=
 =?utf-8?B?T2hidlhKa2JXWmpUUWNXSTQvbGdCakhXMEV1REN1QUpFY3M1aFg3bk8rc3BW?=
 =?utf-8?B?QkJMcUdXQk1sbnpKRSt4UWpsOGd4bEgvUXluQS9KZUQyQzJQMEVqYTQrUW1Y?=
 =?utf-8?B?TU9RcFRWUEE1RnQ2V0RVV0VHay96dVZvRk0ydC9yWjJJK3YyUzhkMDJYZitM?=
 =?utf-8?B?em93dWxJS3h4Umg0TWZ0aEtOWFVPOUZmc1ozWWRCVjc5YkIySzc0SVVIRURR?=
 =?utf-8?B?WWNQS0dKTXNBUGFERE5ZTGtsdXVXaGFRN3ROVjArVnpwemtyc0dzektxbFdk?=
 =?utf-8?B?dytONDhIcThXQUxIY3prb3Z4bndQQ3lnLzBrWjNKc1FML3M4azZJdWpWZXB5?=
 =?utf-8?B?ZEdHdnhEVTZybzNRQzFvZGpwSEpZREwxd1pIUkZCdkFmV3ljbmVvREY5QjhJ?=
 =?utf-8?B?djVmeDJtbTFyaDFaREU5WXV4SURYejlyUjU2ZGZBNy9qeE1vclczcFNaYnNy?=
 =?utf-8?B?ZjVERHRrWmVJSW1HTDhXWDU5TmJaUUxxWWhGNlBRWkhoUyt6Z2xmOEs0N3E5?=
 =?utf-8?B?MkFvQzY2MjNhUVN0MWJQVFJ2L2dINHM1ZTdodEU0SHc4UTdaRU83eUdMMUJk?=
 =?utf-8?B?T1dLaDF3bXNXNlpiV3RUc2xEU0JPeGhha0J4U0lGeFBQQitkN3hnTXU3YU9m?=
 =?utf-8?B?L1E1MkJiM0VBTDJUM2hiWWVROEhzV3NpeWYxa2k4QUZ2aGZneUFqL2xlNlZH?=
 =?utf-8?B?R1ZISWZINDFBWUVTNXZvOXVoWTNRdzAzSlJpUjFBd2FTYUR3L1RHRUs0aTY0?=
 =?utf-8?B?cDlDdzhkWWJtZGlGYjFyMTZ2dlM3Q0x6WWwrWnBzdXhONjhlT0NKK1BSRkJE?=
 =?utf-8?B?czluOXFodGl5aGJJbVM3MkVDWTlwR00yZlc4NEJsTlI3eDhKNEV2OHAwWDY5?=
 =?utf-8?B?R3hDeVlnSWhySHVHRC9lOWdmSmNlZkREbjdRclBUakNCQUxrOWNJaTV6ck82?=
 =?utf-8?B?NS9WM0tqc1FrZTJRVHhpUFhZY2xEZzRJUDdnUnNMQ1pZUjczaFJJMHYwVklX?=
 =?utf-8?B?VG8xWWswM0hTdHA4eExZcHl1eklXdnlnY0RtaCtEZ3ZIOUE0bHJHckxOT0VX?=
 =?utf-8?Q?OKKBP3BdJ5OJU4moLsriEM8wsugNgVVzbRWbvEN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnA5elRtcUVmWXdndEdFazNTeHRhTzUxdEIwMW9rZTNRZVpnTWRkbmg1d243?=
 =?utf-8?B?djFnR25KYXQ1ay8rcFh0T1pSZ29VWlg5WElwU0dNVnRaRmpDOW1jWXhEUUR2?=
 =?utf-8?B?aGJqdFB6eWluUEJOZXNScVlKVGJvTWo3MThCdVEzVFBZZktLSjR3NjRJL1F3?=
 =?utf-8?B?U3lnRFpFSFBCNW5QZFgwSVRFajBMbmxwaWVtMThGdk55ZDVETDd4cXZQYzYy?=
 =?utf-8?B?aUpScHdPVGtIc0NLUWZUNkZNTy9DVEhuMlBUM1prUUllUEp3OW8vRHg2NU44?=
 =?utf-8?B?OWl2aUdKb1NwVENQMTBwWEhXYkovVXR0djhjYlVBWi9VZEx1MVhkNGlUSllN?=
 =?utf-8?B?bTFndU1rNk5kSzNsTUNvRW13eVkwMTVoam14SnJITWNpc09YdU5VNS9Weity?=
 =?utf-8?B?bWpmbXlrNXVZSTM2OUJLYVpmSVl6Uk5tUFh2VmJEaTRyVVQxTTFHSWtyTmpV?=
 =?utf-8?B?alNBaHhveXdDQkZZcHRwYWVwdGRXV1c2TzZZT28wVFNEQkNkYWdURGJDdGlt?=
 =?utf-8?B?QXdaVEF6ckJpM2xnOWRqdk4rZEVHTVpweEk3OVhRQUJJaFFqakFDZUtML1lo?=
 =?utf-8?B?T1B4M20zTEV0MDVFU01jWjFEc2FLMnMzdVRPU204UDYvYVRENWUxRnhvVjc2?=
 =?utf-8?B?OTBLUTNUdWoranc3YmxNQ296Y1JIRVptQWFQL3lNNFplQnV3aFNtekpQNXgv?=
 =?utf-8?B?SFZNblp0YktucU9FN25JdUlLbVFNbENjTG5pd1JQMWpUUkZlTThpMm5lZTZD?=
 =?utf-8?B?djZDRzVqSG1CMFIxemR2VWRENWVZNjVCRWtZc2llS284Y1liWWVLMDNYT0xO?=
 =?utf-8?B?T01tZHVER2t6eGk0Lys4RU9kb1c3eFdkZVJ1ZitSQlUyNkFzcGRuRXpnc0hj?=
 =?utf-8?B?MnJxL2MzLzZpNE5oVlhMNjljaTdSQXVBYS80YkpOUjJRQmZRSWg5Uzl6aGxT?=
 =?utf-8?B?dDFLM0VVSHdTY0haclJkK0FsNFlJSkNmSnlQT01aQnJyOHduMFh4Rks0U1FR?=
 =?utf-8?B?Wml2Sjl6NS9tTk9jc0VxaElTMUl3enpoNzJGQ1dzeEVpL3lIVUJGamhKSndB?=
 =?utf-8?B?MEk2T0dCRDF4NlVCekg0ckFWd01WcHRaZnd1ckpRK2VhTnUrZmtXQkRsNHhn?=
 =?utf-8?B?elU2d1dJYzIzcExaQlhMR3BsZ1IzOHB3WWtsVjFjRTNGaDV6OWVjREdVVVhR?=
 =?utf-8?B?L2EvbDBEditOdU1mVi9RT2ExMkhvM3RCRk4yTDVtN1p3Yll2bEdRcklVcktX?=
 =?utf-8?B?UXBlUFhiUFZJWkpYUEVYOG92RzZJMk44Z0hSZURQS29sNnFUZHVNOGlac0RF?=
 =?utf-8?B?SmswOXZ2dEswdS9Nd0kzbHZMTE10eTFzSEh4REhuZEZuaWlxVy82ZExTeHJQ?=
 =?utf-8?B?Ym5HWVU3M3l3Zm81WkQwY3VpM0tOaGZzai80Q3dpV3lWSGdkRUZzdWQ4QW1O?=
 =?utf-8?B?QW5GUjBtVVU5ZFVTOVFEYXNETmxaZnV4MW41eHQ1U2V2TVF0MGNMMUtzbTZB?=
 =?utf-8?B?UjA5UnpDSXNrTlBDVk80anRsZ3BzWUQ2OHlnQ0J5SnYxOENIM0xHQ3lud2FZ?=
 =?utf-8?B?U1NaOXovWjlhbTRMaWtuRFlRSWVTSFpDcHYrUm4vbEl4RzNsL2c5Y0ZkTEVJ?=
 =?utf-8?B?UEt4cHdOOUY3VDgxd1hjVlZZVmp0V0p4bm9DRUtBVnppR0xFR3EzTWhNdWJi?=
 =?utf-8?B?cVB0US95bmo1bnF3L2R3aEJ3c0V3cFpqNVErd2MzQkl1RFY4K3ZkWDcvNjFH?=
 =?utf-8?B?aEgxTGVYdm1kbGN0cEp1ekQrM3RTcEdXSjBOR2xFUmZCSis5RC8vVVV1Rmdw?=
 =?utf-8?B?c2xxVmRtbEV1Q1Y3QzhxbFBkYTZCaTFKU0R5c2pNWkFwU08xRWR4VlhITVFI?=
 =?utf-8?B?WWYyVGYvQzRDR1hubEN2ZzJicG5xc1AvV01JSmdtbytQR2RVOXlwTGRLbXVl?=
 =?utf-8?B?QXVneFAvSTFMT0hicWRFSS9nYk04OERHUm4wOGdDN3VWSDZHem9XOHpBdDM5?=
 =?utf-8?B?K0VMZzJETmY1enF3TWxqMXE0NUJSNU5tQnluN3JXZDd1MkpIaE41U1ZLUkxD?=
 =?utf-8?B?bUo1UnBaNzJEMFQzb0FaSU53OFBHS0tqNFcvVk93RXlhOUQ1aFVjYm5JQ2tH?=
 =?utf-8?Q?Hmfvj+BYcleaK2IYvBRxGWbX4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca9dba4-3003-4974-289d-08dd1a2a331b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 21:24:30.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bpIEysxI9ykn8dc07a+s/K1aqX3ee4kdQHkLpv5jCaxdRxchhbuVFoyFTt1Y/ZbrjvA52yAFReA3EPdrL2Qiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

On 12/11/2024 06:47, Werner Sembach wrote:
> Hi,
> 
> Am 10.12.24 um 17:00 schrieb Mario Limonciello:
>> On 12/10/2024 09:24, Werner Sembach wrote:
>>> Hi,
>>>
>>> Am 09.12.24 um 20:45 schrieb Mario Limonciello:
>>>> On 12/9/2024 13:36, Werner Sembach wrote:
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>>> sets the policy that all PCIe ports are allowed to use D3. When
>>>>> the system is suspended if the port is not power manageable by the
>>>>> platform and won't be used for wakeup via a PME this sets up the
>>>>> policy for these ports to go into D3hot.
>>>>>
>>>>> This policy generally makes sense from an OSPM perspective but it 
>>>>> leads
>>>>> to problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 
>>>>> with
>>>>> an unupdated BIOS.
>>>>>
>>>>> - On family 19h model 44h (PCI 0x14b9) this manifests as a missing 
>>>>> wakeup
>>>>>    interrupt.
>>>>> - On family 19h model 74h (PCI 0x14eb) this manifests as a system 
>>>>> hang.
>>>>>
>>>>> On the affected Device + BIOS combination, add a quirk for the PCI 
>>>>> device
>>>>> ID used by the problematic root port on both chips to ensure that 
>>>>> these
>>>>> root ports are not put into D3hot at suspend.
>>>>>
>>>>> This patch is based on
>>>>> https://lore.kernel.org/linux-pci/20230708214457.1229-2- 
>>>>> mario.limonciello@amd.com/
>>>>> but with the added condition both in the documentation and in the 
>>>>> code to
>>>>> apply only to the TUXEDO Sirius 16 Gen 1 with the original 
>>>>> unpatched BIOS.
>>>>>
>>>>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>>> Cc: stable@vger.kernel.org # 6.1+
>>>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from- 
>>>>> suspend-with-external-USB-keyboard/m-p/5217121
>>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>   drivers/pci/quirks.c | 31 +++++++++++++++++++++++++++++++
>>>>>   1 file changed, 31 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>> index 76f4df75b08a1..2226dca56197d 100644
>>>>> --- a/drivers/pci/quirks.c
>>>>> +++ b/drivers/pci/quirks.c
>>>>> @@ -3908,6 +3908,37 @@ static void 
>>>>> quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>>>>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>>>>                      PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>>>>                      quirk_apple_poweroff_thunderbolt);
>>>>> +
>>>>> +/*
>>>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers 
>>>>> into D3hot
>>>>> + * may cause problems when the system attempts wake up from s2idle.
>>>>> + *
>>>>> + * On family 19h model 44h (PCI 0x14b9) this manifests as a 
>>>>> missing wakeup
>>>>> + * interrupt.
>>>>> + * On family 19h model 74h (PCI 0x14eb) this manifests as a system 
>>>>> hang.
>>>>> + *
>>>>> + * This fix is still required on the TUXEDO Sirius 16 Gen1 with 
>>>>> the original
>>>>> + * unupdated BIOS.
>>>>> + */
>>>>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>>>>> +    {
>>>>> +        .matches = {
>>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>>>> +            DMI_MATCH(DMI_BOARD_NAME, "APX958"),
>>>>> +            DMI_MATCH(DMI_BIOS_VERSION, "V1.00A00"),
>>>>> +        },
>>>>> +    },
>>>>> +    {}
>>>>> +};
>>>>> +
>>>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>>>> +{
>>>>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
>>>>> +        !acpi_pci_power_manageable(pdev))
>>>>> +        pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>>>> +}
>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, 
>>>>> quirk_ryzen_rp_d3);
>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, 
>>>>> quirk_ryzen_rp_d3);
>>>>>   #endif
>>>>>     /*
>>>>
>>>> Wait, what is wrong with:
>>>>
>>>> commit 7d08f21f8c630 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD 
>>>> Rembrandt and Phoenix USB4")
>>>>
>>>> Is that not activating on your system for some reason?
>>>
>>> Doesn't seem so, tested with the old BIOS and 6.13-rc2 and had 
>>> blackscreen on wakeup.
>>
>> OK, I think we need to dig a layer deeper to see which root port is 
>> causing problems to understand this.
>>
>>>
>>> With a newer BIOS for that device suspend and resume however works.
>>>
>>
>> Is there any reason that people would realistically be staying on the 
>> old BIOS and instead we need to carry this quirk in the kernel for 
>> eternity?
> Fear of device bricking or not knowing an update is available.

The not knowing is solved by publishing firmware to LVFS.

Most "popular" distributions include fwupd, regularly check for updates 
and will notify users through the MOTD or a graphical application that 
there is something available.

>>
>> With the Linux ecosystem for BIOS updates through fwupd + LVFS it's 
>> not a very big barrier to entry to do an update like it was 20 years ago.
> Sadly fwupd/LVFS does not support executing arbitrary efi binaries/nsh 
> scripts which still is the main form ODMs provide bios updates.

It's tangential to this thread; but generally ODMs will provide you a 
capsule if you ask for one.

Anyhow if you are providing scripts and random EFI binaries in order to 
get things updated, that explains why this is a large enough chunk of 
people to justify a patch like this.

>>
>>> Looking in the patch the device id's are different (0x162e, 0x162f, 
>>> 0x1668, and 0x1669).
>>>
>>
>> TUXEDO Sirius 16 Gen1 is Phoenix based, right?  So at a minimum you 
>> shouldn't be including PCI IDs from Rembrandt (0x14b9)
> Thanks for the hint, I can delete that then.
>>
>> Here is the topology from a Phoenix system on my side:
>>
>> https://gist.github.com/superm1/85bf0c053008435458bdb39418e109d8
> 
> Sorry for the noob question: How do I get that format? it's not lspci - 
> tvnn on my system

No worry.

Having looked at a lot of s2idle bugs I've found it's generally helpful 
to know what ACPI companion is assigned to devices and what are parents.

So it's actually created by this function in the s2idle issue triage 
script, amd_s2idle.py.

https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2idle.py#L1945

And while on the topic, does your "broken" BIOS report this from that 
script?

'''
Platform may hang resuming.  Upgrade your firmware or add 
pcie_port_pm=off to kernel command line if you have problems
'''

> 
> But i think this contains the same information:
> 
> $ lspci -Pnn
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Root Complex [1022:14e8]
> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Phoenix IOMMU 
> [1022:14e9]
> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Dummy Host Bridge [1022:14ea]
> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> GPP Bridge [1022:14ed]
> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Dummy Host Bridge [1022:14ea]
> 00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> GPP Bridge [1022:14ee]
> 00:02.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> GPP Bridge [1022:14ee]
> 00:02.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> GPP Bridge [1022:14ee]
> 00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> GPP Bridge [1022:14ee]
> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Dummy Host Bridge [1022:14ea]
> 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 19h 
> USB4/Thunderbolt PCIe tunnel [1022:14ef]
> 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Dummy Host Bridge [1022:14ea]
> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Dummy Host Bridge [1022:14ea]
> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Internal GPP Bridge to Bus [C:A] [1022:14eb]
> 00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Internal GPP Bridge to Bus [C:A] [1022:14eb]
> 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Internal GPP Bridge to Bus [C:A] [1022:14eb]
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus 
> Controller [1022:790b] (rev 71)
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC 
> Bridge [1022:790e] (rev 51)
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Data Fabric; Function 0 [1022:14f0]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Data Fabric; Function 1 [1022:14f1]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Data Fabric; Function 2 [1022:14f2]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Data Fabric; Function 3 [1022:14f3]
> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Data Fabric; Function 4 [1022:14f4]
> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Data Fabric; Function 5 [1022:14f5]
> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Data Fabric; Function 6 [1022:14f6]
> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Phoenix 
> Data Fabric; Function 7 [1022:14f7]
> 00:01.1/00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] 
> Navi 10 XL Upstream Port of PCI Express Switch [1002:1478] (rev 12)
> 00:01.1/00.0/00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ 
> ATI] Navi 10 XL Downstream Port of PCI Express Switch [1002:1479] (rev 12)
> 00:01.1/00.0/00.0/00.0 VGA compatible controller [0300]: Advanced Micro 
> Devices, Inc. [AMD/ATI] Navi 33 [Radeon RX 7600/7600 XT/7600M 
> XT/7600S/7700S / PRO W7600] [1002:7480] (rev c7)
> 00:01.1/00.0/00.0/00.1 Audio device [0403]: Advanced Micro Devices, Inc. 
> [AMD/ATI] Navi 31 HDMI/DP Audio [1002:ab30]
> 00:02.1/00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. 
> RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller 
> [10ec:8168] (rev 15)
> 00:02.2/00.0 Network controller [0280]: Intel Corporation Wi-Fi 
> 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] [8086:2725] (rev 1a)
> 00:02.4/00.0 Non-Volatile memory controller [0108]: Samsung Electronics 
> Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
> 00:08.1/00.0 VGA compatible controller [0300]: Advanced Micro Devices, 
> Inc. [AMD/ATI] Phoenix1 [1002:15bf] (rev c1)
> 00:08.1/00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] 
> Rembrandt Radeon High Definition Audio Controller [1002:1640]
> 00:08.1/00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. 
> [AMD] Phoenix CCP/PSP 3.0 Device [1022:15c7]
> 00:08.1/00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 
> Device [1022:15b9]
> 00:08.1/00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 
> Device [1022:15ba]
> 00:08.1/00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. 
> [AMD] ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 63)
> 00:08.1/00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] 
> Family 17h/19h/1ah HD Audio Controller [1022:15e3]
> 00:08.2/00.0 Non-Essential Instrumentation [1300]: Advanced Micro 
> Devices, Inc. [AMD] Phoenix Dummy Function [1022:14ec]
> 00:08.2/00.1 Signal processing controller [1180]: Advanced Micro 
> Devices, Inc. [AMD] AMD IPU Device [1022:1502]
> 00:08.3/00.0 Non-Essential Instrumentation [1300]: Advanced Micro 
> Devices, Inc. [AMD] Phoenix Dummy Function [1022:14ec]
> 00:08.3/00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 
> Device [1022:15c0]
> 00:08.3/00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 
> Device [1022:15c1]
> 00:08.3/00.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 
> Pink Sardine USB4/Thunderbolt NHI controller #1 [1022:1668]
> 
>>
>> That's why 7d08f21f8c630 intentionally matches the NHI and then 
>> changes the root port right above that instead of all the root ports - 
>> because that is where the problem was.
> For some reason it doesn't seem to trigger on my system (added debug 
> output) I will look further into it why that happens.

You never see this message in your logs at suspend time (even on a 
"fixed" BIOS)?

"quirk: disabling D3cold for suspend"

I'm /suspecting/ you do see it, but you're having problems with another 
root port.

I mentioned this in my previous iterations of patches that eventually 
landed on that quirk, but Windows and Linux handle root ports 
differently at suspend time and that could be why it's exposing your 
BIOS bug.

If you can please narrow down which root ports actually need the quirk 
for your side (feel free to do a similar style to 7d08f21f8c630) I think 
we could land on something more narrow and upstreamable.

At a minimum what you're doing today is covering both Rembrandt and 
Phoenix and it should only apply to Phoenix.


