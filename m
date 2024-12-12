Return-Path: <linux-pci+bounces-18253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1B9EE451
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1AB2834D4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499C204C28;
	Thu, 12 Dec 2024 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mEW2G4oz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56221E89C;
	Thu, 12 Dec 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999948; cv=fail; b=ZwEFdICIyvw+X4A+OG7evjfKfDuMOcWtgnD5VY229AD6MPp6SbiQdP/J4h8SYX2tsEgqvBY9fspuAH6MVW2svwyzzxqk+UCsXwkJyCWT88G3cTQSDaQmRn1/nPcnjLtIK1M6sJw+tcLwZDo9h9NaiCvbaJje2gHuNB7guSm7M74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999948; c=relaxed/simple;
	bh=xQ3/k0CFxwF9NHSoj8S/2eymd27qnzSkpQSOb4/G4kc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQ8QWwSiJ0ENqqzb+zr9ovAfoxfazOCrvjOrWG8aDCvWFT4fF1MHiyMj0j5ejawp1DORKCnK/tuZ1BCytWV1sXyO1FCMo8b/BiZBcKIEFNopiWB/H8vh8P284kBsMIwGONQhGz5yCqdF47jnTIMXo24BRR2JKykHkNv1oVl6hVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mEW2G4oz; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwUeRtsybIPPsFoeKCt5qWSlRmPU+TQjpbMPxKr8MHzK/Ky9VkZUlVJgDBs5wR0hqP8uR736dggJDugZ6ptMiLtyxnnxMlyBBTNiTBQGsxJANvUXaKqQGq/Y8WoONfDJktWQ15s0M9ZxG6XZJDelst5bx+7z+opxbfLqPgXisab5NLFkjLV58wJbMUAOeM3GyMavFO8EqHK3yPYuNoU6dEIP702kF4gMgWNWcelQRIA9rbuSYDv9ip9gwovgFQc9Im6oB2YyHm6tf+ZLnfQr8HCv8LuT0BuOi0qtXV2+oELGDAy7e9mdC/tUb+E1sbwZUXao/Ssp5XBXg3xMMw3bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfM2XU0vMM3aYlxI1Trc15yNBo/KCZ9/jJ7of3HaBGo=;
 b=l5cUM/TfQACMT9MfeMNHljr7aMb25DwXzGW11OCeSyaiW+pw/Jz5byfU2pij6d8Ajf16hO1GfQIGeT/9RAAlYxAzBgp7cVEFCCYx4j0ZCebBSnAV6AN0RZqveRvrWtuDGL5cAXNcxtyvD7C7BjRxDd2bzgZhoJbbfUAQeQ6Vti6wao87VuODZgqaS6j1ZqBFsCYdQ2ARSYa6HtVAfpOtWZrwXoDjK5CLJOnokvso7iOdSKe3fTbxDChd6BuczEeS4ZDiR/epIz8W7Dd6Mt/z/qM6M97z2zjoq6qL44u69S3pmvlzLk/PCkQazlRc93DKU7uQADrvUXhWWqIq1NIImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfM2XU0vMM3aYlxI1Trc15yNBo/KCZ9/jJ7of3HaBGo=;
 b=mEW2G4ozMFZMSo9lOWLy7uVHzs0hxihIp6Z2yxNp0i1YMUI6GNhGFRjb+PtFpYNob6YtVj2RgwHMPpmynQf1cZnuh6q4+Vq+XGfrYcQ402YUHd6xNdy1MchXSJckvwKIJKLxa8EGOwmR2tq5Upl0npXibHar52K3evUhaPGzFds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 10:39:04 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 10:39:04 +0000
Message-ID: <a10edd19-c8a3-f95e-f7c1-54da06f923b8@amd.com>
Date: Thu, 12 Dec 2024 10:38:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 10/15] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
Content-Language: en-US
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-11-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241211234002.3728674-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d717e83-8fad-4739-721b-08dd1a9932c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K24xY2VLekN0TG9jbFE1NFlsQ3lQUE12WnlObm1IdzBSd0Mya1N5cjNjRWZ5?=
 =?utf-8?B?YkYwQzJwb3J6blp6SmJGYzNUcnZDd2dpMVlxRDh5ejBYbXZQSXdCWnVKZWZr?=
 =?utf-8?B?YkFKeDByU09FSlV5MGFxSW9YOXBhK0xFVWZUMnJubkQxbEQ4NFB2enkrblNV?=
 =?utf-8?B?YlVRTDFkVlVDNWdkNjV0aXBIVzdmRHJBT3piMlpoZWR5QlJrNERvaWlqSyt4?=
 =?utf-8?B?V2c0MnNWeThxRkZYVFRqeTNIbFZvNXV6Rnkxa3Y3ZW8xN3JYaFBZZWN4TGJh?=
 =?utf-8?B?alpTNXhTWksvNzQ4dUhxc01OblJWVllnNks3V2hlTFQ0alpoMm02OFRFdjI3?=
 =?utf-8?B?R2t5QkhTRHhDSHp1VXZKemR5eTlYTlUyYzdBKzBCWTlrUkt6a2FNQUx3TXM5?=
 =?utf-8?B?TU4zeStIN3NpWDlHZEEwS3hHaENHS2RDYnM3R2hSNi9idHJvVTFpQ01vM2dP?=
 =?utf-8?B?cHNJcEJPbmZRa2VDRlNxRVR6Q0g1UDZycnNMTkJIZnhHcjhjTWNrVlhnUTA5?=
 =?utf-8?B?Y1pYKzlZbGtIR09oZGxtMS9TLzI2b1MzdzVoRjdoTjZmS3o0V3NKRGc5eTZ5?=
 =?utf-8?B?UFVXTjVnaXlhMncxaDRsaFFXSjBQTnl5d2pCM2NTY3hlVVlCVTF0N1Q1YUFP?=
 =?utf-8?B?QXRzaFhuOXBPdy90VjgrcjV2aEdGOEdDcVRXNjNqMVp3d2RVZEF4eFo0WmpG?=
 =?utf-8?B?S3NWTzBueXd4Tm91ZWVLQU1HdlAzV1k2V3FPN2wxYlN1MlFGNmRmbzFGRGUv?=
 =?utf-8?B?d2szRytsaTFjancyalVTZHhuby9GWlFUdnRia29jNmx5RVl3OHVydkU2NWNH?=
 =?utf-8?B?WHlaUEYraUlxckFTNUlScDVwNEhmcGpyb3lmemRLZ0FlOHYyQXZMZFpsNW4y?=
 =?utf-8?B?a3pzK3BaNkdQa3lkdVM5UVZhQlFGNTFnL2JzL29DSStEc3Foamh2K0ZFM1NH?=
 =?utf-8?B?MnNuYWZLNnUwbXEvTHZ4eXJjQW5hajJDaG1Sc2hhYlh4MGlRMTZUbEVxV2N5?=
 =?utf-8?B?NjhSaUtsTWZTZ2orNU5qVmpRbGgzZHIyajY3d3ZPSGVUL09hV0hPU1FOd2I4?=
 =?utf-8?B?eVpXS0dReE5nYTVEOEIzaXF0WVFqbW5KRERKNlBacEZGSkk2NHVrZDNZNkFn?=
 =?utf-8?B?UWNVZDZVSFk1ZnQ0MDRWVEw4Z2hBUDdVbFhpd0w3U0xSNGd0VjdUdGs4cWRu?=
 =?utf-8?B?THBLZVk3dzA0c3FSYW5yYThBd1IwL21RZUU3TTJrZlYyOEtrNmtDVEZ5d1NH?=
 =?utf-8?B?ajJFZ3lkU0JOblJURnFGaWtnVU4zcmNJUFQ3Mm14MW5hMCsvUkthcExwNzJN?=
 =?utf-8?B?SnQ4Q25NbVBsaldvMHltWmFkbVRzUWZ0bHFsZTdDSkI4a0hhRXhtUWtDMlBB?=
 =?utf-8?B?RVZMZmZHZ1FsemxiNy9PaFpIWDlETkYxUEVCZThLSFkwTkhvOXZ3U25CT1VZ?=
 =?utf-8?B?cjF2Ulg1bGplVEZCd3BMcGc3NnpEVW9vZGxDWkYreVZMWmZJMk00VkFSVkhP?=
 =?utf-8?B?QXZNUUswSkd3dEl3TUNLS1F0SWJNSUNTaDE5OThCKzZCM0J3azUybFhBT0Jl?=
 =?utf-8?B?MUJuaW5FMTY5aEU4NGtIN2svalB4TGpsNHBLTTFsRHJmZkpHNHlJSmUwQ1g1?=
 =?utf-8?B?TDUvZTlvbGRPVDFkSTlCTkN2Z2xzN0ZxNG5JTEZnNmd0NUkwZmpPcmdrd01a?=
 =?utf-8?B?WmlZb0FqMXd1bU5RaWRqbXBhTy9selRqUFpRT1BOSDl5SG0rLzlRUCsyS3JB?=
 =?utf-8?B?KzhzZWI0M050ZGZkOEFObGpYdzRNS2FlYXhGMWgzaDI2YWJHUC9OYXdCUnlM?=
 =?utf-8?B?cW5CVy9DZ2Y3ZlBnQU1TdjcvYUd6RUVJS25JWXFmYVNTamMvMUNQRXkrcEhX?=
 =?utf-8?B?ek9rTVllcWZoc0dZbkl0ZlVwZFFUS1h5Mkx1eU9lU1dQSVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE5oTzIyWllpbndWV05NS29ENjZDdWd6QzZJRmtOaWtsU1lzZG9oVFY5dys0?=
 =?utf-8?B?ZVRJZ00zR0VHck5ieTVBTnNaOTJSanp6VmRDeS82S1lGcjI5UDV4amx2UzRK?=
 =?utf-8?B?UWc5ajgzb0VIUG5meWxIWVMvQTIwR2t0SGZESnN6cjlyQjRST3JyQnBFUDNx?=
 =?utf-8?B?aDEwTTZkYlVxbVQ1b3lzRnB3K3VWTHdudmxJYSt6eGd5ZUVLcFRKeVFuekIw?=
 =?utf-8?B?Yjhrai9mWHZ6WXlLbjE1MGZyWnZuanhRVVBWOXhaRTlBeUxRbDUwZ2JiSFQ1?=
 =?utf-8?B?UW4rQWF5QU8vRWJjeW9BdnRMZDhDODhSdEZ1M2lzT0xZYU8yd21HVEd6bjFD?=
 =?utf-8?B?eUw5K1JkRk9FSEVlWWdDLzBtbjRwNkNlejFTMFIvV0dMck9OOHUrK2JzNThz?=
 =?utf-8?B?WnV1RG9zMjZ3RE9IQ3RSejdSYzJwWHJKWm1aN2M4bWN1MGlETFE4a0lORkF1?=
 =?utf-8?B?YVJmQTU0Zk9tcVBUa3IxZ3ZwQXE3TEtWVFpjWXJnNERIMkFJVC9XME1QSzFy?=
 =?utf-8?B?ajJTTFFYbWRENzhZVVVkUU1zVUtmNGNKa1NLYThLZ1JxQk0xTmZYeEdGZXJQ?=
 =?utf-8?B?RGJJdCtWUDFlZTBvcmNiOVozZHBpZFB1dGUreFNucVMrL1ZZN0o1eGhRblIx?=
 =?utf-8?B?YUNpKzk3YmUvZ1d6QzNhMEcrMFpKTE10dHV1MkdvK0gxRkF2dzIzMHZtb2dH?=
 =?utf-8?B?RTRGVzZvR2dKOWFCdkY0L2UxejV6T3NOM1FydkpvSklZK0dnVVNZUUtZYWJh?=
 =?utf-8?B?OUViVldoWmFmU05tY0lsSEI3akxTQWg4eEFqK2FOa2dHRWtxdkJ0aVlTMVcx?=
 =?utf-8?B?UUNUbVM2VnRETE9yZm5RRndkc0VJUmNPM1FlSjBVbGF2TkpkRUMxK3lidzBK?=
 =?utf-8?B?Szd4YjNHZWN5MVlZbmZ1Z2s0NGUyRDR0MXN0UmRhOFlGalBXRFJDaGZFbmUv?=
 =?utf-8?B?SG9KRXFuSzAzYXVJaEg5VkN3NFJEcE00akM2VTZWRGZ6QVR1Y0pqNzlFZzFX?=
 =?utf-8?B?SnQ5K0hMTkRWVmQvMHliMVJoaXBBd1ZzR3RIRi9rNkpYOGZnOGh1RzlVTnhh?=
 =?utf-8?B?MXFzSVlGdTlieHNZN1p6eHFmTXd4UW1rRm5jTVdCSVIwbEViMEVTUytMeHNU?=
 =?utf-8?B?QWlENW9taU5oWlpVWFUyZUVGcjQ3Z1NqaUh1UDd3U0VaL2lFUk92RDFQYSto?=
 =?utf-8?B?TU5ZWjBvUUtBVjE3R2xyMlorWm45WmJJcWNrbW5ZK2pUaXd2QU53bldUbE10?=
 =?utf-8?B?SFdCZjZ2MUc5VVZTVWR3djUrdmVhZ0VidzE5WDBDNUxyemU3aTFGc1ZiNGoy?=
 =?utf-8?B?bER3Tzg0cktaQUFKRm1UOHlLZ29mSHdXb2tIRWdHNmJ6M1hYa0NwNlVDRnpK?=
 =?utf-8?B?YXByc21nWWZOVXZYWWdhbmcwbTdLOWx1WUp1dHZob3JCcVlHRTVxZ1RsR1RU?=
 =?utf-8?B?NDIveFhzWVZ2eW9VckVvai9MVzRvRWNUMlRiR0JpT0NET1FFQXR3RFZGRENq?=
 =?utf-8?B?WEtnYWxlTVM1UnM0UEgwNkxlZjRTVFNhbmVkbjlma0cwcGR6czl1VG9Na0pF?=
 =?utf-8?B?YkF1MFZhVzR6NGZGZy94YXVrVjdLZmNuMS83K3NqK2JOZndMNnJQOFdNaVZt?=
 =?utf-8?B?K1h4aHhDckZTVHZxODVBSlQ0bU5UWUUrTmJkaDE2YUREZ2ZGUTJzQ2YrYXNL?=
 =?utf-8?B?NTFzaWk5UXcyZ0QxUWZNSDVBaWFndUdoSFhhVk9KczhiVVh6eXRZekVKZi9U?=
 =?utf-8?B?VzBudzJ6ZjRjMHZxMEh3cXBHR2VWZElSd3AzRTJ5VGZhNWdUaEpLVHF2UzFN?=
 =?utf-8?B?eXA1N1VlSlAzYWlBZmsxQkhrd25IN1dTaXBycG43TjhjVHpyWExjcERYd2NK?=
 =?utf-8?B?d2g0VFF6b1NXMlJSTjNhWkRnL1VxTWJsWTduL3pxbk1QUHBtUWRxT3FZKzhD?=
 =?utf-8?B?eERZdzJtbUwrU0JkTkJZMmxoU21zUk1CTmF6UjAwUFd5VkIxOU5vOGxKOXpu?=
 =?utf-8?B?bWgwNklSY0VrWUVPRVdOaU5PQ01lTTI3RjBVWHh3TnVKZTdWRTl4Vi9Jak16?=
 =?utf-8?B?Nk80SGlZVmNGR25ZZDc2NnJvL1k0eVpIWGNIdENEbzcyWVNCMy9BeTcyYmEr?=
 =?utf-8?Q?LLi7zbBDs/qWTnU/9cGN5Czwc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d717e83-8fad-4739-721b-08dd1a9932c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 10:39:04.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNhSkB2OnIaWXtHQVAbggCo186BYPe5q4StjeWvtLqhH7Wujy5xbiBpZ6LUbK4N2w/nTy3veGiZaqZqi+g5f7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390


On 12/11/24 23:39, Terry Bowman wrote:
> CXL PCIe Port protocol error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port protocol errors.
>
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
>
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
>
> No functional changes are introduced.
>
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


> ---
>   drivers/cxl/core/pci.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 08073bbe2697..89f8d65d71ce 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,7 +650,7 @@ void read_cdat_data(struct cxl_port *port)
>   }
>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>   
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +static void __cxl_handle_cor_ras(struct device *dev,
>   				 void __iomem *ras_base)
>   {
>   	void __iomem *addr;
> @@ -663,13 +663,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>   	status = readl(addr);
>   	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>   		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>   	}
>   }
>   
>   static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>   {
> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>   }
>   
>   /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -693,8 +693,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>    * Log the state of the RAS status registers and prepare them to log the
>    * next error status. Return 1 if reset needed.
>    */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> -				  void __iomem *ras_base)
> +static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>   {
>   	u32 hl[CXL_HEADERLOG_SIZE_U32];
>   	void __iomem *addr;
> @@ -721,7 +720,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>   	}
>   
>   	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>   
>   	return true;
> @@ -729,7 +728,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>   
>   static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>   {
> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>   }
>   
>   #ifdef CONFIG_PCIEAER_CXL
> @@ -818,13 +817,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>   static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>   					  struct cxl_dport *dport)
>   {
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>   }
>   
>   static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>   				       struct cxl_dport *dport)
>   {
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>   }
>   
>   /*

