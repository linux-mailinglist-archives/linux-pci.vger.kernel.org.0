Return-Path: <linux-pci+bounces-22278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25507A4330A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 03:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3EB3B85AC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 02:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553C136352;
	Tue, 25 Feb 2025 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S3EgTam6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13F4C80
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450593; cv=fail; b=bAEFxkgix34x1zPFlptXxUDe//rjtTsZfVhW/OavEmVER5q8PL2vjT4mM0FPJRSreM3zbxgKEBpoiFTQiSOoxSE8KXcmviiWW7YQbOzkkoJGpYhF2w0gNvEdeM7tvSnEZoCntwK0rbgHsgdq3mThI+4d+nqxECwGk8uQXgsl1WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450593; c=relaxed/simple;
	bh=dsFZINofACw6OFdozgfhkhFOkxcLgpSmQMvudEqfJi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hCWdGgnMHQkkwKaRVjhiPQoXeyDhJ5azkRjHNggHJ5QhMHVF4qhe85S/GVtPCVohTlcakmF5ZdubBOs9VFN4qY1RfUJIwzW2GwZzgU5T+SjSlWppM7ZS7yZLsbdXZ1pC7ETcxdCSW2fYMsl79FP7i3J71lI+5eVwUgoq3qPoHjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S3EgTam6; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxubyhFvSGf07CmIIHO2h1KIjJjDDnMiX9nMbcL8Hi3g+nJBt27HVIKCzmhfRM7Iz+YBkauy6zAnJcr32R48V1D+6Oep5DGdvmrmgTL0JeGZCAxhE9Nh15wm06p5VqZMWYuZEiMXjcvFevl5a3cORj7U1BKvBhEpUX2L1kRqzgtvTC8G6jZ4IMziy5G3OglUD/rwzYyiCFBF6jnvcjSN6+Cabelnl7uqWpWLsGxUF3nvgFW/sCYD4sJwb+fmz54VQXfcGjT6VC+8knaZ6rvN7IGhDJ2QTp8MgdmSb2OfIWHwWjpWiPI80B6Lsy21MwcboesLe5QV2xwzBJd2n8aHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdiaIv/AdMTOUEyoXJbBg/5pdQYv4eDX25ZcB/J0GNg=;
 b=RSepCg1yuFu95b083YHG1tu0NBktwXFnXJkEGCwyyEGSJzCqM3Op1xAd25SI0jyVXIk07JLIsCu/4NtH/nXdy0TD87pZcgM3lwjamrBWjXdGBwYIKDLPlKOQwQs9qNj8RMbNc5vAJ2NPdFKfv8gbiAvg+gmd1+iInxBdb6gwiKHDdHZeFGJycwZy17eaGnZh+Indko716hOIk/KeC6BJQNVvNpRxckMVrMnF6vJQZ5YDEATuVXX+cWaJYqBQfaG0u3EqDfFD0QCfPleOYqzD4/6AQ8g6fpBj8S2QCZf7B2lEcH2wbZVNtM8EwqdJkWwmtcGH0UkKa+8AlM0V53IIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdiaIv/AdMTOUEyoXJbBg/5pdQYv4eDX25ZcB/J0GNg=;
 b=S3EgTam6bKow3k5kwujRVxsbQfT98F0CFH/AZE4q8NEw7klvMr8fXXK5pC2yEd8BuDvxUAPNcinRBly/JKLK341glZopbS5zd9PNvHqkh8BdNoZkydRboa7p4oIC2YOa+0YnnLIuIiQo+Q8y2cX23b+CI0xA0anVPGvXalgga3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 02:29:31 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 02:29:31 +0000
Message-ID: <0051800b-dd91-48c7-87dc-2efd4622dcb6@amd.com>
Date: Tue, 25 Feb 2025 13:29:23 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-coco@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org> <Z32MUFBIyp0IKyzC@yilunxu-OptiPlex-7050>
 <yq5aplkuu7g6.fsf@kernel.org>
 <67bcf33d4a495_1c530f29476@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67bcf33d4a495_1c530f29476@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0218.ausprd01.prod.outlook.com
 (2603:10c6:220:1eb::16) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: b387dff2-d57f-493a-94c2-08dd55443bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0NxSWJ3TXNCY3g3U1dwRXpsNWJXRzJwWnBOSCtOSklkZ2FaS3N5ZWJxY0tU?=
 =?utf-8?B?ek1lSFJXTGxiWFF5clhLWU4zYzcyTGRVcWFBTzFQL0dtMUxqVmkxYXF2RnZT?=
 =?utf-8?B?Y0FOQnVIcHI2d1NNKytZNGVpOHZtZ0I0aFNiTFdCUFY0a2dmWU5ldWlTWFEz?=
 =?utf-8?B?cjBzKy8yU0psbUt0RE5HTFpmbVN2QVN6NUNtUElVWmtzb3k3V2hSVHlTRm1C?=
 =?utf-8?B?d3dpa3IveEgxQllETEJ4Mjg2Vi9JZHMxRHAvTDlkUy9DbEM2SnVUMlg2QURD?=
 =?utf-8?B?eHZZWWxHNU8zM1B4d2d5Rm0vSDFCazhybmNRYUxDY3FNbTlBMFNscEl6Y0Fq?=
 =?utf-8?B?ZlVROHlWWE9Tb3hsbnFHUFJJZTFhckxLSzhGdnFFNlZpNmZNZmpTTTc0N3BD?=
 =?utf-8?B?OEdwUFRjaEJ4blFnQkIvaUhXaHFxdXJndzJOdzNyNk5oM1ArNWdQd1Z4MXZ5?=
 =?utf-8?B?T2h1Z1J4dGVqQyt1cS9uelRTaXdiVXFxd1lHR2x2aythd0lIUkVEQTAyR01r?=
 =?utf-8?B?ekRDYjFrL0l1RzBLVWNPbFNqMnkxai9US25SUS9xNU5WdWNHSXRhSERpemtD?=
 =?utf-8?B?dWk3RzRZaE14V1liODNBZDA5bk5FNWZ1bDlES3g3c25lbHZUYnFQVm9zK0l3?=
 =?utf-8?B?ZTh1ODFiTFJNMVNPU0ZYTmFHT0dvUy9wUThUdTZKSDZMVDFTbXNNRFZ4dE1n?=
 =?utf-8?B?VmZlOERVOTlIVjlhMGlaU1ovbTV4VGhCd0RFQU80c1dXenFzbHlMQ2QxcXN2?=
 =?utf-8?B?MWZ4Q0NYVENOZnB6a01DUjJob21YZDE1T2F3WDFGMGU0ZnFHTWJoWGJ0UVps?=
 =?utf-8?B?Y0h1amJqYnQrdmRnNzJVNjFnVDRxeENCVnlFQ1MvbTA4NnRPTVRaZjg1M2dP?=
 =?utf-8?B?S0M3Q0dNTWQyTkpWRzBEUUVadFY0UDhuajlWRFY1Y3hqWmthL2s5OTR1azc4?=
 =?utf-8?B?VjhtQ3pFdHhHTlUwTzFiQW04b0NCUGx1dVJzWWV3TDBaWHdvaGI2QnJEdElx?=
 =?utf-8?B?NFRhcXhqVkQ3ZWVFTjRGUTltZUQ3dlVDYno0Q0Qvemx5OS8yYUs1ZThNQjFi?=
 =?utf-8?B?a2NhK2FPaHlHck0wWUlvOHZGajB3U2hPVGNxdUJ0cEFLOVdSdnZiV1hHa05U?=
 =?utf-8?B?K1lCRlluMjJjTWxTc0FUVlpvL0ttS1lBR2RScWduUFo5QjBTUm5HdnBCaWw1?=
 =?utf-8?B?VHRkOUxPU216cnE2S1VHRkcvQWNYQXQ5VUx3anZGVlJVZFArZ0hXeHlPKzR4?=
 =?utf-8?B?NzVBaEcwR0ZIV0N5S0dVOUJUMVR3UzhSbER1elR4RFB2UndlVDJ0K1duVVp1?=
 =?utf-8?B?SUFNM1FqSFlBR3l2ZTFhUHp6bFRaTEZpVHNrVFFOVmh0Tkt1ME9zSk1NdFJp?=
 =?utf-8?B?SlU5eUc3dzlObEJKdzc4UjV0cWpQTUpnM1lrb09TU3ZpaVkxRGdXb3NqTFRY?=
 =?utf-8?B?RjlZTys2eXJlV1ludndjemZ6U1p5MlhrVERvSXdkTEUzV3FnN2tYa3o5Z2hr?=
 =?utf-8?B?RUNFTWM5OGVoWmYreEJKWEcxWjl5a0dWSTQxMkt0YjJpa2Ewa3BBSGlNcFVk?=
 =?utf-8?B?TWdKcVhVN3M2b2NycU85UEZYc3YwMm5vUCsyOGdKK2lhcDBIWVpodEJlaVBo?=
 =?utf-8?B?bUpkclRBWVVUaFhoVW5lYmRGRXdIaFRQaE55QUt4d3BBem5JcmExWGtERmlw?=
 =?utf-8?B?REx5cmZpdGFVRTREbDVFVUtIQ2hWWWU5V1JyelV0dHBqcHhCYVdnZUNpQ2Rr?=
 =?utf-8?B?OHNFOS9CYXk1WG1NdENkdmtxR0Q0ZWhtaks5RTYvYkhBMi9OdGJ0U2NuNHBE?=
 =?utf-8?B?OGtNeGZyYmpmcUtXdTg2aFFKMHdCaWFqWWJPekF3Rmx0bXVia2FJd0hkUnVa?=
 =?utf-8?Q?FFWXzhG9IZJ+T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk9JOWFqZ3FPeW9hNzNUSDAvSkM1ZGtUOXl4NTJhOHgzT1hFdXZRV09vQ1RX?=
 =?utf-8?B?RnlEbHR0WnBoZXE4c2tLL2hCQmRpdUprdnZVYkxqejVnc3hHUGZtemF6cmN5?=
 =?utf-8?B?bkk1ak5yNm5hY3hIVVZOVEpKSk1jUzEwMis5NUZyYWU3Q1QrVzhYNmkrTjNI?=
 =?utf-8?B?R2R1b2pZQkN4dFJGeXNjNk5ia3kwSGZoWEdvTEpoWHhLLy85K2pPVVlSa2l0?=
 =?utf-8?B?aFFxYTUvZm9XZXNpRStjMTJVVmJWeER2K2VoNWtCOHF5aEpyeklGL0h5aWpv?=
 =?utf-8?B?WG9wNVBhRDlaamFCM01FY2FWSnlmV09LRjhiYnZ6aE9aRGVKeFp0SVA1emFx?=
 =?utf-8?B?RlZLL09CSXN5a24wdTRYYy9naFNZMHFOVjZKSXZQS2tvNk9yK3RoUi92Zm04?=
 =?utf-8?B?TWhHYlo5SDlrckt3K0EvK2YzL3lrNWkrWGgySUVzRTk3ZFdnNCt4TS91Z1VV?=
 =?utf-8?B?bWdOYXlkdEpxUW1oUVdMM3lXSHJtdVhodnF6eUgzaFF5VHlvNUIyM3E1YWc4?=
 =?utf-8?B?cDRIVlJqYnMxcnVVcURIMSs0ZWRHTm1KZnJZTG1HWkpZTVBvS0cybk9vREg2?=
 =?utf-8?B?YmUvdEpYUFBVL1ovSkdIakhQUTdDTURLSVd6QlRFa25kMERiL3VVbkp5N1Ev?=
 =?utf-8?B?NlRreFErblZzNm9valcyRmRXV0NncGMxUmFycHRXT0xkS3FiL2Z0YUF4UGJE?=
 =?utf-8?B?Z2VYQ2tuMGRsaTRiM3NENHhlMnpveXBpa2xENDNYRFJDaU54U3hvSmNaM3cz?=
 =?utf-8?B?VDF4bHlsNElZSFlJcTY1NGgxWCt2NVFsV3FDUXVBK01vTm9Wa3BVRkNLTERa?=
 =?utf-8?B?NlVJcEJKUWlaaURZZ2svWFpKRFhHeHlIV3drV0NzZjJES3RFUkZrdkhjSFRi?=
 =?utf-8?B?Qy9jd0Rrb3FpT0RjNFYzbnBOL1U1ZlJpbXlVV0NHWk83N3R6SS8ramVLcmNw?=
 =?utf-8?B?VmgzSnBjMHdWM1pFVnoycFExYlh0Z0FsUTJUSnR0WmVzdWNhaS9VajdHYWhT?=
 =?utf-8?B?WU51Z0l0T1ZxNEowSUdLNy90eExDRTRxTEZrRlQvYmxqVUtaMklFOEJCOXJC?=
 =?utf-8?B?ZlBEd3FDOERLWWE3OWFDYi93UHhGV0xmSWJZemlEOVRBQWt0SXI5dHJSaWtC?=
 =?utf-8?B?eWRINVFGRzBGNk1ka2Vmbi9lN1ZYRVhacjU2MzVnQk1EeUhtelQ0Y0EydGl4?=
 =?utf-8?B?ejhqZ0M0WDZydHBSVUNSSXZ5UmFTa1NUaVVmVjZLc3JzSmxvM3pMdnNqS2tH?=
 =?utf-8?B?REpnQzVOL0t1VDVCWGhwdnJKeVl1d3dES1FoZkZacjAyYVVZWUFmT3RSUm1j?=
 =?utf-8?B?eU9KVmRRZ2VZZVlJR1JyeXFlblFVWTZhRFN3NjBiR0tWbktEaXBsMThVTzZr?=
 =?utf-8?B?dlVVODRvK0JPR00rRkJCcHZPUm9XQW9xU1cwdTJrTVBwcnlWZ3ZrTU1Ia3Vp?=
 =?utf-8?B?cyttMnowaVd4Y3hSV3I3RUh3djVYM1ZEcUpSbkxCR1JxaGVaTlAwUFJpSmND?=
 =?utf-8?B?c1dOVURucUJJTDlic3pHRlcwRFZZRXV3RzNyNzRHd2wxRG9ObUlOMU9ZckJq?=
 =?utf-8?B?bWVnZEIyM21rYzRNVGkxRDBwbUJ6SHNVZUJDaU04S2FSMVR4V0l6REpIQWFE?=
 =?utf-8?B?c1hmN2Q0MWVYQUxXVm45a3FoZFhlOG0zcXNnY2FsUml3N2UvMmpuYWFDS0xK?=
 =?utf-8?B?U3ZsVnNSWDd3ZTdxaUorYXRmTGZDWUIxKzUxR3pzbFRkREZJenBrNEttSkZY?=
 =?utf-8?B?MFlJNWtrWFVsckZ4ekliSzFEWE91K3NvMjh0MUZQbnZQMllLYXNUUkdJY0FZ?=
 =?utf-8?B?eHNnaExxNVF3aGhxRzQxV1dkN3VlTU4zYzhpZVQ4Z3pmSkdFWjJSajhwZFlF?=
 =?utf-8?B?VlRwMERLaG91NWJ3M0o5bXVJTUQ1S2tMb01YZWFKR1lKMm5MS1lpZEtVT2Fw?=
 =?utf-8?B?ampobVhWSExMMFRrUjN0eTRnYSsyZW81V3hpQ3hDdkFaVm1URGlJeTZSWEJm?=
 =?utf-8?B?dlRidDdqYWpXNTdhWnR5b1BPR1VwVk0vRFo1RzEveUlScDlRVlBXMUdSQWJK?=
 =?utf-8?B?eVJvZU1yNTd4bTVFR1BjbmlqZG1MMHN6UW9NKzQzbldZTHBNSmxlMnVWbUNJ?=
 =?utf-8?Q?aM8foNjokptHWCvcLZdhuzoB5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b387dff2-d57f-493a-94c2-08dd55443bea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 02:29:31.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCE3rmLpsVvZBtjyQ9j7SsnQ9rphbV93fM/4TMyGQtwu99TazbcoM9PUHWKMZv1CdeBA3UeNfXAz4WJ3awVvTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964



On 25/2/25 09:31, Dan Williams wrote:
> Aneesh Kumar K.V wrote:
>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>
>>> On Tue, Dec 10, 2024 at 08:49:40AM +0530, Aneesh Kumar K.V wrote:
>>>>
>>>> Hi Dan,
>>>>
>>>> Dan Williams <dan.j.williams@intel.com> writes:
>>>>> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
>>>>> +			 enum pci_ide_flags flags)
>>>>> +{
>>>>> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>>>>> +	struct pci_dev *rp = pcie_find_root_port(pdev);
>>>>> +	int mem = 0, rc;
>>>>> +
>>>>> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
>>>>> +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
>>>>> +		return -ENXIO;
>>>>> +	}
>>>>> +
>>>>> +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
>>>>> +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
>>>>> +			ide->stream_id);
>>>>> +		return -EBUSY;
>>>>> +	}
>>>>> +
>>>>
>>>> Considering we are using the hostbridge ide_stream_ids bitmap, why is
>>>> the stream_id allocation not generic? ie, any reason why a stream id alloc
>>>> like below will not work?
>>>
>>> Should be illustrating in commit log.
>>>
>>> "The other design detail for TSM-coordinated IDE establishment is that
>>> the TSM manages allocation of stream-ids, this is why the stream_id is
>>> passed in to pci_ide_stream_setup()."
>>>
>>> This is true for Intel TDX.
>>>
>>
>> IIUC ide->stream_id is going to be set by SVE or TDX backend. But then
>> we also expect the below.
>>
>> 	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
>> 		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
> 
> This is an after-the-fact "trust but verify" sanity check. It is making
> sure that the Linux-view and TSM-view of the Stream ID space stays in
> sync.
> 
>> Hence the confusion why the stream-id cannot be allocated by the generic
>> TSM module as below
> 
> ...again, because Linux has no way to convey which Stream ID to use to
> the TSM.

The AMD PSP fw allows the OS to choose streamids (have not tested 
anything but "0" but all the API is there) and the OS programs these to 
both ends of PCIe link via the IDE cap. Is it different elsewhere? Thanks,


-- 
Alexey


