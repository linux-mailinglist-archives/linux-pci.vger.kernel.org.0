Return-Path: <linux-pci+bounces-13375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE7197EC66
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024EFB21B05
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21394199239;
	Mon, 23 Sep 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1f5JSQOj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A2535D4;
	Mon, 23 Sep 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098642; cv=fail; b=iP9JTB0ZfR/48sJ5rUv6Gdr38zRjCwfLYw1DvJxOXofQFcjv3+FF9Q/sDrFVABhDjoGhNQEIcc0tWBWYv+oAy2oJ2jXviv3l1zfYEgOAP0/ncrwXrIfCNumhL4ecOohZBJiL5/l4ozVRFILc79uA94dN0zoZ6XMPY6Y0G+yHoaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098642; c=relaxed/simple;
	bh=+5Wl97hR00xqOVkVCSLcVw03Tdoo/1nerVRYfLmiiMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hpxF4P1fNPpqzv54q2HXQW3L86giPuym/FgUnxiLz6XR05DoolbZZHwSHqyzN+/bYU95Nx78zpWu3kl3rm8jZ3WkTkfXY9RlyeR+bZRuyJoJ+u5VBQM06KTK2YZ9UgeEVfYUhEbXruO3OQ/Z+DXs1vpI9sOayDOs0QinfslraaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1f5JSQOj; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJu4Tfcd/zKB/kPKZazjGwHUiqB9sJIBoZ/1vggmDL2EG6JG8JM/C3+g6jf0buDaBo+IRQE7aGe0zUjdC7Ce3bcGJ/qCePUYRvcLM8BYoxZYR1MEbP/9ePdM2DImZu43guOAPsNMN8SPj0SeofTUmMxVDNqE1C/E57YDcjxi62/FlZsatRvzivpVcOm80r1h5OHEYtS1FN0EHIzKRbaQwIfxBHPCun6y91LHESZH+syBO6oN73Efbhqth9CzfolyoXI/iAVblzTgM0EyUyunHpdkRRwJiwyXM3HRzdHm3EodscDif4wAtobLPosSmRPPup4my4S2FeIY9l/HNFjdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCrUwaeGHyLqXQ5TnrHMg9tZhh7xqXePvZ63weLzp34=;
 b=rhRgy1SD8FIAtN3gWNO0SJyL+SaTCiPHI68/R85HwFUFQzpD3rnzIVJijfjbi9NlCOjaDSex5tcwD8ZvFtNtWq2SXhOlrTigwVrn0Yq9pCTriPGwuwqzfjSWY6bN14sSgvooiePBaSvjSIjui3zAdBjJaOXwdt1GXsqjgMpP50EmfN2+I1d/yH6GuVIEPbD6iXZjqOPrZvbs1v+Et1oqOOgK44WBXrDd0VdMpsxGsf5AylBNC4cTl4Zj5fnEGt95cD8shBEUt7TcTTvpVPduVlkMM1XT+Q6oMkNFjtfo6NR/uYi5ycxDgKuwgqc0YlZUd/Fg+749KUh1emkshsASfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCrUwaeGHyLqXQ5TnrHMg9tZhh7xqXePvZ63weLzp34=;
 b=1f5JSQOjjWee1iYPkxi8/3WjsqpFPsYBlKutCM0EI/DZf4oTggCqqPHKwGb606sLthF/vrH8dTpqcDCjlyDcthnOt+fivITTWbZ2ubRGo76YdgwDFZWM0eOuTKqnJgw4545tue9bu+u45Cao761ytXz6wAkKFD3QlXNH/5raqEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 13:37:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 13:37:16 +0000
Message-ID: <79d288c6-6042-4f73-b465-0ddcde14509a@amd.com>
Date: Mon, 23 Sep 2024 08:37:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: unexptect ACPI GPE wakeup on Lenovo platforms
To: Baochen Qiang <quic_bqiang@quicinc.com>, rafael@kernel.org,
 mika.westerberg@linux.intel.com, ulf.hansson@linaro.org,
 bhelgaas@google.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 mpearson@lenovo.com, markpearson@lenovo.com, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <370d023e-ec53-4bf2-a005-48524c9cb4b2@quicinc.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <370d023e-ec53-4bf2-a005-48524c9cb4b2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3cc2c8-347b-43f4-885a-08dcdbd4d715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3lUVVhuSG45amxwTkREaUU3SjdVeWlYU3doU0FlN2loeHNuSzZMcmxjSHA2?=
 =?utf-8?B?OGx4QzdCa1h4WEphRzJINWF0WDBieXRyUk1MRnVyU2NpTndtYXVNU3BkNlpo?=
 =?utf-8?B?QUxFZjEzQkUyTUw5S3lucnFmNndFNmFVbVkrZnR4OHJkVEhGVzMvRDNMRzhj?=
 =?utf-8?B?Yng2cVRuVVpGbXlNeGlMaGJSUDZKVFhmaS81RERaR3BPeHllaUhmdzZHb0tr?=
 =?utf-8?B?WWJCU2RsVjZrN1c4RGthRGpwWEduZ2g4aW40L3ZDZDMveGQ2NW1DZXRJcHJT?=
 =?utf-8?B?VjMxM2g2dWtBQUlCc3M4NGoySjE0M1ZmTHhReDd0WVhlLy85QTRKSlFMQm9J?=
 =?utf-8?B?d1F0bVd2Q1JQSTBsM1VlUXlZL2xYOGxscGNuRlgza21FQUY4c0JYUmJ3YTFy?=
 =?utf-8?B?RGNCWEpNUklpMHlVZW5lak85ek5nQ2hGWGdTdEs1OWUybXRmemZNTklWSFZR?=
 =?utf-8?B?V3VrdTdJWDU4SlhScW80RVJwQUkzU1owb2ZQVU5aZUJ2VmlsRU5lbHlIQk05?=
 =?utf-8?B?K3pwZ2J0Wm9aSkRaY0RwRnRiSzZkd1hhb3VnOWVDVjJLZHdEOHhxYXpKY2ZX?=
 =?utf-8?B?RU1heUFtZG5Td0xzZU92YmpzVGlZOXZ5VFBXUE5rSUVrd2IzejM4bnJHNTEx?=
 =?utf-8?B?WFBMR1pkeis1U2RoNWlFZlY1RVJWVGYvYmtoOFgycWF5UlhnWS8xano3cEE5?=
 =?utf-8?B?T2VWSjg3d1NXYURuVjZQaXcvdnZhU3hlZmhJMjd0bTNmU0ljdFJ5SlFCRzNh?=
 =?utf-8?B?MU04Ri9CQmZ4TTZVVUhzcnFCS1RsaVJ4bDRpNXliS3NvbFpLNXhxME4xWWdS?=
 =?utf-8?B?QzN3Z0pDSDc3MnRyRHF5MDFCSGEvbkxtbDdjL1R4TXdveHUydUFsYnF0WWlW?=
 =?utf-8?B?b0V6S2lGaVUvV2VnaC9rRmplaEdpUjNsQTI4N1l5bExnS2M2QThZd24zRWU1?=
 =?utf-8?B?WnFUMjVzeE9JcnFac24rNUYraTdQOXhybEFhTHhrQzFrS2JQWjdwQkFHY3hB?=
 =?utf-8?B?bW4vb2huS1pZY3d1d1JVQUs0cDkwYzB5TnFBS0VJMTJSb2pRanR0ZXlkNnBD?=
 =?utf-8?B?R3Y0N0VaN1VERnFhck1kYTRtanhONGVMUktabDBPZ1JGRzF0UktVMkFjNFJM?=
 =?utf-8?B?YlNCVWhnUkJrMTZXMWtta1V1d3NxcTNNMWpNYTdZcXhQa2RPQk95dmJVOHdu?=
 =?utf-8?B?d3F0c1Rqck1WWkwxQ2tFRmp0NVROK21NMTVmdXcwWDlLVVR5T1R0VXppMGQ5?=
 =?utf-8?B?YVF6Z0dVOS9jeHZ6MTdubTNTdXo5VWxtUncrTy9sQ1VlREVhakh0S1k5Rlp1?=
 =?utf-8?B?dkUrbzErV25XUmJkKzZsVmRLSUtEeUNJK3BMWHZnUVB3UjZHT21zK1NDKzhG?=
 =?utf-8?B?WEVqNzNvcEJPS1MvY01DaEtnY0tUUjRjTE5DY0hLeS9DTGU0UTdGMUFmYkRx?=
 =?utf-8?B?RzZ4VElWZTBGNjJoWmVyVXRvWXZvWnZwcVBLVDhqQVovb3pqNjh5OTlXdHVs?=
 =?utf-8?B?ZTdyTzlEOXFWL2I0bnpHV0thREVXRVBVeGxvQ29uV0I5V3g4SFh6aWs4MnU5?=
 =?utf-8?B?d3dhZEJLZG9POGFJVkgvRWZ6VEk2Rm9iQkxQVXEvdTBYQklXRjVWT0trWUFi?=
 =?utf-8?B?eUx3amlHWnB4MitPSSt0Qjc2bW5yeURGdkN2aHcwY0Q5aWNaY1BHTUEyMVRR?=
 =?utf-8?B?YXBvaEltWmhoeG44cHFHNlJsSk5LQjVxNzZqZFFacVF5QTVnTHk2THRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGliMzVjRm41N1hpZW5uaGJYeXMwN3lKK0d1eEpRc1ljQ05tc3NFY3AxUWFQ?=
 =?utf-8?B?dWcrSjRrMytEUHpnMEtDeno3ZVVmMjlFOEpPNVk3NHF0SHBlaThxQSsrMVBr?=
 =?utf-8?B?cmVYdHpTZmZRVis1NFRoTW1wd3VseW5YcEtBdUozUG96SEZmK3k4V3lhMjh0?=
 =?utf-8?B?Njk1dkl2TzQ1WlVJSnA3eC96RERwa0EyOXVnS2lCSzVRRHJMbVJCdUV3UzdW?=
 =?utf-8?B?UWIxTTBMS2gxc1ZKeTk4L1UwRVk1dG42NGhzYUdzanZ5TkgyLytMaHd4VTBT?=
 =?utf-8?B?SkhZYzNYZ0dxQUYwcEh6Mms2VnVwOWREQjRsNmRwZ2NtVUxRU25yT2pWRXlz?=
 =?utf-8?B?bkwwUFkwWVRKTExSQUJQdVZZRVFBRFcxRWZ0OWZKL3JJRkk4NlQybHQvTFND?=
 =?utf-8?B?UlRjVSs2bE02aXRFWllId0xJa1VTaDFwckM5ZGJ2dnJtc2pzWGdxMG5LMkNa?=
 =?utf-8?B?KzlGVlRoMXBsRHBJLy9SdkZaQmhwdWhjWEpUdTZzKzBUUFNIR0R3dis4WTJ0?=
 =?utf-8?B?U2sweFFNQzhiQ0ZYTytxM3pOVktVUWtlVlVUVU8vc2ZwY3FlMjAzeEhBSk1X?=
 =?utf-8?B?NmhaMEhSQklpMFR4STJvZlhXNjk3OTVUbDIwWmdqZTBWWDFQamQwWTJYSWxr?=
 =?utf-8?B?YU1Vc1Q3WFJ4ZCtNSHpxaFFIcDljOXJMcjBMOTZHejh5eGVTSGUwWGJwK3pP?=
 =?utf-8?B?RTFWYVpENFRkZFlpanlHanRQRFdFM0UyNE9PZm54N2NmZTRaQTh5aFJDaS92?=
 =?utf-8?B?SHJHbmlIaklEd2M0Q1ROK25HakdudS9SbmwxSmF5bEFmOVBtdEJobFBUUHEw?=
 =?utf-8?B?d0ZyVEZoTWNDbE5XZjlmNGxNaE9GYU13Tk96VlViaXdtdkd3SlpXYWtmc1dK?=
 =?utf-8?B?cThVSnl2YXZSZFM1OFd4aUxmbFo2NVRzcm1WZFRKUlFKUmNHTmJUcGZTZHZ4?=
 =?utf-8?B?NU11UWI4SUtnNjFVNEtEL09Rajk5dHpISGFxVjFmNUFwbFBOMDlXYlZ1dm5q?=
 =?utf-8?B?NTNZU0ZuZ1B3RnBVOHB1S1FkUGd1QUZCaXR4OVNJRWNKYUxlZWs1dXFJOUdP?=
 =?utf-8?B?TUtubWJQbUxFREttb1A5TDBndm0wSmFJQkNOdU5nak5INjR4eVZ4b0pYYnJn?=
 =?utf-8?B?dldPY3V0S1YrSmtPS1pheHU2Ymh5V0JjSjZGWkRjaFlFSzdFdlR3cXRhZ1hR?=
 =?utf-8?B?WkVCNWVxdkk4eEFlSjdkUWkreEF1N2RDNXl2YStnTXg5WEY3US9CbGFEK1ZM?=
 =?utf-8?B?NE5HTlgrajRWSnNCTEJRWEJjdWV6WVhDazhodCtEdW94SThjZXB5Z1hmcEpy?=
 =?utf-8?B?UGw3UXF1RjZiM3gwYlpBbzB0V0l6ZEowVFVLeWFvVlFVdW5EWVZxZ1hsZUUw?=
 =?utf-8?B?U3pIQVZydERBYTMrNFIwTi90Rldlc3NGVE1YeDVFc1NGb2ZjZDRhT0VmOUFL?=
 =?utf-8?B?RGFxRThrVVJPWlNGaWNPeE1QWkgxWXJKVzl4aUZnUXByZGNUVWxCdjFyRXh6?=
 =?utf-8?B?dHVpQlVuK29CNmx4ZDRRL3VTaGM3K0ZWMVhjdzN0cTFGVjRkclBoY2RrS01C?=
 =?utf-8?B?aXFKVk9BeWtFR3dRQ0R1di9KWk1rdlpmcFpyVkoyNGZ0djdwTmhacEl3c1Vz?=
 =?utf-8?B?Ujg2ZzhOMCtiRDZWOVpTNWZ5KzRxUlJQOXlGUnlaZ1FYeTlNSEFJb0o1MDBN?=
 =?utf-8?B?dEkzcmhoM1poeXYyUG5Pc2UrU3EzdnVvOUlLVzRLRmNXdkhmTWRhQTRtelRB?=
 =?utf-8?B?OXcwQWY3S05EYVZWTlJiVytBRVNHay80bU04ZU1Uc3dZaXB0M0l4OGRoRjBE?=
 =?utf-8?B?Ulk4b0FweDJPU2dPa1Iwa3JnQVE5L1RDQnVYV2Y2Y0hQV3o4dmdBYlNLTUZB?=
 =?utf-8?B?Z1RWYlU4Yy9qakM5eTZVWUs4MExHZ3dTdFRmcU1OMFpaTkdTYXZxRktKcGVx?=
 =?utf-8?B?aFNSQzljZmt3ZksxK2M1M25MdFVHQWgveU13MTcrdW0zemZ4MTBjckV4bjFx?=
 =?utf-8?B?MjM1U2t4ZUZiWEtGbmhHVytQR3doNjB2ci90L1pIV0lkc2YzVy9iT09LZVJ1?=
 =?utf-8?B?YTlXWnBvaVZIWWd1eG13ZXVMRXVmbllVZmtteG1xZ09lL1RGSXJiak5WOUJa?=
 =?utf-8?Q?2UgFvD4SdYxY/qP8oFvYxTAu8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3cc2c8-347b-43f4-885a-08dcdbd4d715
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 13:37:16.9023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es2mAuWUtjQjGtYk61x0aygn1ivJUIwksilBqqXOzEMXbLPp2MknSSpfLhu0zDXwO7KV6erbWpvC2g/FoPHrlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845

On 9/23/2024 05:07, Baochen Qiang wrote:
> Hi,
> 
> recently it is reported that on some Lenovo machines (P16v, Z13 etc.) unexpected ACPI event wakeup is seen with kernel 6.10 [1][2]. To summary, the unexpected wakeup is triggered by simply unplug AC power or close lid of the laptop. Regression test shows this is caused by below commit, and with that reverted the issue is gone:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k?id=166a490f59ac10340ee5330e51c15188ce2a7f8f
> 
> Well what confuses me is that this commit basically resets WLAN hardware before going to suspend. that said, WLAN target maintains limited functionality (PCIe link handling etc...) during system suspend and is thus not expected to wakeup system.
> 
> kernel log shows this is an ACPI GPE event wakeup:
> 
> Sep 22 22:34:32 fedora kernel: PM: Triggering wakeup from IRQ 9
> Sep 22 22:34:32 fedora kernel: ACPI: PM: ACPI non-EC GPE wakeup
> ...
> Sep 22 22:34:32 fedora kernel: PM: noirq resume of devices complete after 693.757 msecs
> Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x07
> Sep 22 22:34:32 fedora kernel: ACPI: GPE event 0x0e
> 
> Consulting ACPI tables show GPE 0x07 is used by the EC and GPE 0x0e is used by GPP6 device:
> 
> Scope (\_SB.PCI0.GPP6)
> {
>      ...
>      Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
>      {
>          M460 ("PLA-ASL-\\_SB.PCI0.GPP6._PRW Return GPRW (0xE, 0x4)\n", 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
>          Return (Package (0x02)
>          {
>              0x0E,
>              0x04
>          })
>      }
>      ...
> }
> 
> while GPP6 is the PCI bridge (the PCIe root port in this case) to which WLAN target is attached to:
> 
> Device (GPP6)
> {
>      Name (_ADR, 0x00020002)  // _ADR: Address
>      ...
> }
> 
> Scope (_SB.PCI0.GPP6)
> {
>      Device (WLAN)
>      {
>          ...
>      }
>      ...
> }
> 
> and lspci also shows such relationship:
> 
> $ lspci -vt
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 14e8
>             ...
>             +-02.2-[03]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter
>             ....
> 
> Based on above info:
> #1 is that valid to get the conclusion that this unexpected wakeup is triggered directly by PCIe bridge?
> #2 if this is related to WLAN (seems so based on the regression test), is it the WLAN wake pin (a GPIO pin?) that originally triggers this? and how does it affect the bridge?
> #3 quick tests show that with GPP6 wakeup disabled this issue is gone. so a workaround is to disable GPP6 wakeup before going to suspend and enable it back after resume. But is it safe to do so?
> 
> 
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=2301921
> 

With pinctrl-amd there is an extra debugging message present [1] that is 
activated when you enable '/sys/power/pm_debug_messages' which will tell 
you if a GPIO is active during the suspend cycle.  That can help you to 
rule out whether this is the WoWLAN GPIO pin causing the behavior.

[1] 
https://github.com/torvalds/linux/blob/v6.11/drivers/pinctrl/pinctrl-amd.c#L626

