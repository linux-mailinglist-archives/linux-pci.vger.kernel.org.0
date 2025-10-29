Return-Path: <linux-pci+bounces-39594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E3C18480
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 06:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92B8A4E3EB3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 05:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CB2F6193;
	Wed, 29 Oct 2025 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jmvUtqEK"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A81DC9B5
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715261; cv=fail; b=rHP1vMm9E0heytIhTUkTb5N4Jz3x9OqldSrsO5izZMW264ZlwK6Xa9+uVmFXLgoQ9F96sGBO4ZLJbZ70GCoGDRLcF45Tuxunjjk3r3a4zsBCjhmArWBB7fZmAtpdpq0qzKFtGuN4fvrHpKRLCkbL137PF5YUd8pAh3QbezKEk9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715261; c=relaxed/simple;
	bh=WRhh8ipiz1zOyGkfkCkLLbY0ybx5O79dirJ29UdKKEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OREoUoDNUuzeoy1K5tRYX+femiCcNH+wGQtxXxMkyhw523kp5I3bsyWvFq0Z10cj+Q9GlGWKjMj6DSdYL7P8gsxVKmwDL4D2nlClvCufRnpqM79uSfJZnLCySeQwI4IdPFKfUMTl/kxI62n0Gzrk2h5IIg0Gt8/3gesZcz73XqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jmvUtqEK; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLVObQyr/t2pzxcYlHm1dNIf1AgjG520sohVoZYB3YMiAMHXeZD9gbHW02Gmek4UZVb4wRDJN06jXDEoErO/QKiDZ0qLBdH5QUlAVdrzBQNMbZ7Nc3je9UIS5Y2y7lsgMmPqPrrxkUvJdkswQOkWgEK0nKxl/lYcaHcDtmH3UsMH0CLCz0ddJlvzMXysmn71ffUxn0hMBPjGZ+W46vwtqmBuOeHgHWLzIdcqb6luIKA0nYdAjd7sH5JDxUTeDewdwmbx4brps+MI5EEnBHagJGER+8dJY+qImjrjJe5yvPPzv2VteO97L6fz994UJt8GdcvsYNFruqzs55l87QqQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSB3p5Zk4ki+JDq5BUwht8Hl4EhNzqHjKZJv4FLxs6c=;
 b=Ye8pTKLiB/R09i2nOB/vDJj6ZQb7v/olxQGH5ruPiXdHoq0jren6Iqu/3J7P+Ivil8RiLvMSw3UfnlgNYFpGoGmzmAqhRebYVf73AOsPprx1qOEhc/SLPf83+KSrWrBuC6wBJJsQt35051/Io85OLe4DDS6z4pTKGU/7JfhI3LVsDKTfIau77UMinT7deAwOOXlO8xckWrd428MNxuoX7E43Et8bnAIwcaKuYQk+adb1zx/xbFZfY4E+OU32r1LhFnIHX2o5dWfpYGpLdOcraXlCa4vZYBdwW/LPZ9tHQPBtYdZQe2vCeZlgBvzxACmbrTaRJeGSJIBA1FnaZ14s9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSB3p5Zk4ki+JDq5BUwht8Hl4EhNzqHjKZJv4FLxs6c=;
 b=jmvUtqEKfhnu+tEovWsY+s5SHW6LvSKwkhKymB0TCf5/+qwAMXw9Rfl8gauTDUG/1rr2RQZon497LmXwCn8PEW9Di/+0y/C+dzV42O1tv6ORX1LApWQ5m5RJ2Bm4/ApTC4ktbWsEgNnDmLycuw42OJSox8wSxoQrELQhONM64i8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 05:20:56 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9253.013; Wed, 29 Oct 2025
 05:20:56 +0000
Message-ID: <998ebd1f-c6b1-4858-99cf-a59e0c2d1096@amd.com>
Date: Wed, 29 Oct 2025 16:20:41 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 0/9] PCI/TSM: Core infrastructure for PCI device
 security (TDISP)
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, bhelgaas@google.com,
 gregkh@linuxfoundation.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <yq5azf9coe8t.fsf@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <yq5azf9coe8t.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0126.ausprd01.prod.outlook.com
 (2603:10c6:10:246::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: cef06a53-61f7-4c75-5aa6-08de16aaeffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2xIYlNKNkdSQ2ovUmxudVQxbnVUeHN2Zm5GZWVybmxVVlhwRDc5RjgxU0RE?=
 =?utf-8?B?UXUrUnRaVitodEVTMGVGWWkyU0Zibk5ic3dpcmtUS2dYTFdpbDk3dm1KMEds?=
 =?utf-8?B?enFrNiswdllzTXdJZW5YdEZIdFZVRVhMUDNQTldUU1UzZW82VHVxSGVodmt0?=
 =?utf-8?B?NlNtUFZVelA2YUNRT2J0YThiUFJKSno3UjdXRy84cWd5aUdmL1FMM2J3aGJB?=
 =?utf-8?B?MjhTcStZRXZ5Q0lMWVBadXV5NHlRSndYd05naG5USTRESnEvM1dZTGdXL3hX?=
 =?utf-8?B?a1RUd1RBVmx4Q290Rys4MEpuWWJabXMyYjRRSG8wZjArSzZhUndtNEwwdHE1?=
 =?utf-8?B?YlBTMXMveTZ5amF4VUxScGJDL0laNEtwaUlkZzdTTHMvN2dXaU1OeTBvK3pB?=
 =?utf-8?B?akZxZFVBNGNianNpb2I5amN3N1BKTlVKdmNBVnB6S3Y1b1pmcHNSYUwxUXo3?=
 =?utf-8?B?OUcxMjZKdmhZRVg1WHowZXlPYkd1N3VXZ3JOMVhWanJRQXBkSnpFQU5Vd1lk?=
 =?utf-8?B?WVNqRkNMYTRaRHAwd2dxMHhxUUdTUWpPTG1YcWQyQjlST0xLNkNXRE5WanpY?=
 =?utf-8?B?T1pBaWgwREJSRDJ0N20rMGFrLzNldkxXVThRS09laW9WYmFVc3FiYmR3RFV3?=
 =?utf-8?B?VnlrWVVUTlBsY3BxRU54dnRqdDcvN1FkY0trK0o0THJkV2poYnp3dXNhT1BV?=
 =?utf-8?B?WUV4M2dadGc5cVV3UC9UdTBrdnVzVkZCd0NSWWZ2SWhYSDR2cExjYzlROHpm?=
 =?utf-8?B?a0w5UmJnc3JWd1k4MXVjR3J4eFZ5UWVuajlrL2RBQ0x6NVhheDVtUzB1SFdh?=
 =?utf-8?B?MytkcXY5YVBkeXRNWXF0YzZoa0ZLTVFFUlZPVUg0Y2h5U2RrNnBPRGdVZDFh?=
 =?utf-8?B?TWUyNFZhWXV1VnVCQjJSODEreXpwcGx4TGFFNGQzMGk2c3UvL1d3VGd1UDdZ?=
 =?utf-8?B?Mnc3WmVsUmhIVTVRVFIyd0V2R0dlbUV6VlhQWmFETURtVnFKcFZITncvTWZj?=
 =?utf-8?B?L2R4RlBEaUdjVkxQdWg0VHhraTFkUnQ1S3dkZUlLb0RIZlE2Nkg5MTlqS2xR?=
 =?utf-8?B?RUR3b0g5M0czb2VUVC81aFc0SHdjKy9WNnBaaktuN2J0SnM3ejBQN2tLSmE3?=
 =?utf-8?B?VnlOL0pSUDUrMy9FVWQ2WExBU3hrcTdWZTUxRjkrQmVDbXNReWJ4eGZBc2R5?=
 =?utf-8?B?c2NHZ0ZkOThkc0kweEtJWW9wdFovYTc1YVV0d2QvdDRiZmxVSGZyOGNlVk53?=
 =?utf-8?B?aHVULzJqVWtmMVdmTUZ3RXJJUndweHUwOUZ1Unp4U09HUGx2UDZvNjRsdHZz?=
 =?utf-8?B?MkFQT0wvUmxpQ3ArUmNhMytoQ1Q4b1VBNjhWcndBTVJUUjAxRTc2d0VLanhR?=
 =?utf-8?B?aWtvQ0RwZXFwMzVtRU5URndzU3NxVVlLQkF5bC9VNmlpSlNxbGdRYVVrVms0?=
 =?utf-8?B?aXFGc24zV1o4S2pmN2JZaHFrcmtQNTR4U1U5SlRhZTV2UTVaVnRhTlB6S1Ro?=
 =?utf-8?B?VTBhcDFQbnVvRmNZUFFiSHhSQ3VOMmFPOC81d2lVN0ZKRldLWkZvejM0TFpB?=
 =?utf-8?B?RU1kUmtVMzJTQ3ZjOHE0YnVOb09KYTBpTVVBOHQ5c2o1c2F1MlFjMldWemdm?=
 =?utf-8?B?aXRSUXBCT01RMXNvVlIrWlF5R3F1QVV4bTFKYzBucVliTkxhMEVFTmZzSVZU?=
 =?utf-8?B?c3V6UUk5UWpZc2xxclF4L3ErZmZkbDZoVWJsd3dKRStEa0h2anE0NW42eStC?=
 =?utf-8?B?Q0UxVTBZcGo2ZkIydTFXZkVYRkVwRVI5a2l2cjJwaTJ2L3hYQjBESk1uanl6?=
 =?utf-8?B?cWtqdUpaWFR3NU1ncWlGaVBaSGlndkp1L00rYTRUaXVYYmxZS2R4cGRabHFo?=
 =?utf-8?B?alorelNaNDYvOXRFSWZrWDFtemdsMitibFhkdVN0TnhsNzg0Qi9BSm9KWmdW?=
 =?utf-8?B?ZC9tVmZBak5hcWo4OFVlVFJRVDZWRytHckRNcXc1azVvYkUyNk5vQUxMZ1JJ?=
 =?utf-8?B?RVVKa04wNVZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGFWOWRXNSszV2JIbVpXdGtIaFd2ZUFoclY1QVNUNnNHODc5SWhpaGV4Szc5?=
 =?utf-8?B?SjU0Ly9pOWszanZXcjVkYWZMS0ViWUVTYjVxZERYSXFwNmRPRC9xT293dmZ3?=
 =?utf-8?B?bGdGZzRQWW0vU1huSlBuQ2pvMzhPWUdRN2gvd01QY3ZKTmhmaUcyVlA2NHU3?=
 =?utf-8?B?RUdLMkE2ZEhQbWhUQzQ4Zjg2c3Z6ZlJMc21qMkREVXBNalpmdW54M3NRVEVH?=
 =?utf-8?B?eXNLYkRyRHc1WG40SjV1Y095Z3dDbG1DUFlsNHNFQ1ZIRWEyb3NVbTFFeHRl?=
 =?utf-8?B?OVAvV1BuR010VjlkWGJYbE1GbnY5RkJjUVRUSkFFcDlIRURiaFpIL2dWRWR2?=
 =?utf-8?B?emVSKzVHdnkzTUg3aFcwdGRWYkdyMUlTTDZFTGE1VkpqeWFaLzNSNHBTdWtM?=
 =?utf-8?B?alNDQUtRUkxmZGZKdjRNUitwakNORWxPRjZDR3JmVmhjSDZKN05TckRXaEhQ?=
 =?utf-8?B?UmtEa2NvZEtsSFB0ZFhkZU5UK2lRUnRPSEVydTlUaHJoNjdMd1hhellkaUtR?=
 =?utf-8?B?REQ5a09mbG9yQS9jTDZUVFFvMUt6dU1HTTVOOUx6cEVsVnZCVWhZcGZacW05?=
 =?utf-8?B?aHpiK29URWJjcWM5VzVtZWFIcjJNSy94eDBlRzI1YllGTzNWM0JvNThFcWp6?=
 =?utf-8?B?aVp2MW5CNTNDZWlyS29ZbkFac2gyMUlrcXEvUlFWeEVhRWZqT080WmdkSkpU?=
 =?utf-8?B?elJXOU9WL0YwV1c3eDkwMFptcWYxeWkyRkZmM0JxeUI2S3FsT1JBeFZUTUFl?=
 =?utf-8?B?OXFIY3ZCVG5raldNZmIvaDFBQTh4dHFzMzdrWXJDVXJJVCtmcU5RRk1EMHRw?=
 =?utf-8?B?UkRWWGVmcWpMSVRrMEk2VUhyOFJyZTdhZEJQMzZKNU1uZE10UW56Qko2di9I?=
 =?utf-8?B?ZzJSbEhtVThJSGJudFQ4bElRYk9VLzBSamdSSFpWVGRsMHRlTDJqWEpTaGpq?=
 =?utf-8?B?RmtrSWVyLzVMK0NqK3VGRTY4a0Z0UDN0SHF2Z3VYZGI2eUhZcXVNanNrdFFu?=
 =?utf-8?B?YzRUWnpaeWNXWVc0SXp1ZEhwdUt5YjY4Yk5kUkMxWEYyT2ZVeTJNMUo0Z005?=
 =?utf-8?B?NG5jMXhEWlA3TWJHdDBwZVk5am54WTd6ZXhyQXVlb1QrR0htQ2dTa0xDeXZX?=
 =?utf-8?B?ZW5BaE4rNi9iNSt3SzVFcnNoY29KU3RERSs1NGtVN2xxMy9hZGw5bFM2ZzNt?=
 =?utf-8?B?dHdtOUNmaVlvVCtCZHJXS1Q5Mjhaa3RVcm1UT1E3cVVycmR0QjVSTHlOMUlL?=
 =?utf-8?B?YTJSeG5FRnFHTUhHTTVVa2VkdTdaTWFma1prQ1RUd2FIMFlwMndycE8vaExM?=
 =?utf-8?B?OHQwNy9QZ05LUGk5WWE2NVpZSWNtcnZvSG9uZlpOa3pKTHpXZjdVZDg4aDJs?=
 =?utf-8?B?TWhxSWtXcDA4NlpWNzYyU2VKZk96RnpVb0tiQzI2VXIwTTRNakJZVFh1OHp4?=
 =?utf-8?B?RTFrcTI0cW1JUlZZMFUwYnlDdTAzZi9MQ0QyVHJlNWZmYnBmc0Y0MnNwSG1u?=
 =?utf-8?B?QVRlblg4ZnIzNFhFUkMvSjRzTkc5TDZXZlZzeHdGOG9xdFZqQmFDUnd0U0cy?=
 =?utf-8?B?MllHUHExN28ybWZwY2FNaWdkNFhnVFRtMkd2aEJWY0ZqbW1sL0M5eTRINVpN?=
 =?utf-8?B?U0J1UjZMK2F4Z1FHMnJQZ0RUYjRMWkd4NVAwak5TMEM2QVdSTTV1YmJVWDB5?=
 =?utf-8?B?d2JzZTBseG8ybEZCOVNxME1LYm5iUmZpNlUrVnhpZlVIVWJYN1pXU054NXZJ?=
 =?utf-8?B?ZHNTSFNTUnh1V0Z6QlVsK3RmOUwwZlpobTJzeWx5SzBBWDh4bWFoQkdzR2Rl?=
 =?utf-8?B?bXdBbDhFbXNZaVU3SU5pSDRTOG8rMGZyRHBTZ1dSUGR3bE5EdUcxbGdJWm1Q?=
 =?utf-8?B?WTZBalVOS2swQmZVdHE1S0VVTDB0VDNoOWh0Wm04T3JSNGsvemJreTJCbCtH?=
 =?utf-8?B?NEFFcTRjUUFIV0V1TnpiZ0g5WGVuQXY1aThJaGFaM3k5WkwvWkxlY00xU3Mw?=
 =?utf-8?B?T2tlVW1HanprYkI4UGVKZWVIQXRXRFBEQ3kyNTY5KytvakJJSEE4TlQwUGdE?=
 =?utf-8?B?a0lPQmNrTFd1VDdueDFva2w3Y0lveDBORE1ON3lxTmNpSWkzRW1HUXhtdFJ5?=
 =?utf-8?Q?7cYlbaPtI/Kq4dYIlEH379Rci?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef06a53-61f7-4c75-5aa6-08de16aaeffb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 05:20:56.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEu2CC6YPSlfMYwg9a+SrsUpjK0EGkEaWuWQKQagmi8Ep/BtVc/fl1x1voJfuu95A80NkYelF/74uG1/hSbkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315

On 27/10/25 21:01, Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
>> Changes since v6 [1]:
>> - Rebase on v6.18-rc2
>> - Drop @owner from 'struct pci_tsm' and lookup @ops through @tsm_dev
>>    (Alexey)
>> - Drop CONFIG_PCI_IDE_STREAM_MAX, only require pci_ide_set_nr_streams()
>>    for host bridge implementations that limit streams to something less
>>    than topology max (Aneesh)
>> - Convert Stream index allocators from bitmaps to ida (preparation for
>>    solving Stream ID uniqueness problem reported by Alexey)
>> - Misc whitespace cleanups (Jonathan)
>> - Misc kdoc fixups
>> - Fix nr_ide_streams data type, a u8 is too small
>> - Rename PCI_DOE_PROTO_ => PCI_DOE_FEATURE_ (Alexey)
>> - Rename @base to @base_tsm in 'struct pci_tsm_pf0' (Aneesh)
>> - Fix up PCIe r6.1 reference for PCIe r7.0 (Bjorn)
>> - Fix to_pci_tsm_pf0() failing to walk to the DSM device (Yilun)
>> - Add pci_tsm_fn_exit() for sub-function cleanups post DSM disconnect
>>    (Aneesh)
>> - Move the samples/devsec/ implementation to a follow-on patch set
>>
>> [1]: http://lore.kernel.org/20250911235647.3248419-1-dan.j.williams@intel.com
>>
>> This set is available at
>> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging
>> (rebasing branch) or devsec-20251023 (immutable tag). That branch
>> additionally contains address association support, Stream ID uniqueness
>> compability quirk, updated samples/devsec/ (now with multifunction
>> device and simple bind support), and an updated preview of v2 of "[PATCH
>> 0/7] PCI/TSM: TEE I/O infrastructure" (fixes x86 encrypted ioremap and
>> other changes) [2].
>>
>> [2]: http://lore.kernel.org/20250827035259.1356758-1-dan.j.williams@intel.com
>>
>> It passes an updated regression testing using samples/devsec/. See this
>> commit on the staging branch for that test:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?id=44932bffdcc1
>>
>> Status: ->connect() flow is settled
>> -----------------------------------
>> At the risk of tempting fate, the goal is this v7 goes to linux-next via
>> a stable tsm.git#next branch. Enable one or more TSM driver
>> implementations to queue on top for v6.19-rc1 via arch-specific trees
>> for TDX, TIO, CCA, or COVE-IO. I.e. target v6.19 to support baseline
>> link encryption (IDE) / secure-session establishment without
>> confidential device-assignment.
>>
>> That tsm.git#next goal still needs follow-on patches like the following
>> to settle:
>>
>> Alexey Kardashevskiy (1):
>>        PCI/IDE: Initialize an ID for all IDE streams
>>
>> Xu Yilun (1):
>>        PCI/IDE: Add Address Association Register setup for downstream MMIO
>>
>> ...but otherwise the core infrastructure is ready to support IDE
>> establishment via a platform TSM.
>>
>> Next steps:
>> -----------
>> - Stage at least one vendor ->connect() implementation on top of a
>>    tsm.git#staging snapshot, for integration testing.
>>
>> - Additionally get at least one vendor ->connect() implementation queued
>>    in an arch tree for linux-next in time for v6.19, otherwise
>>    tsm.git#next may need to wait for v6.20.
>>
> 
> Arm CCA changes can be found https://lore.kernel.org/all/20251027095602.1154418-2-aneesh.kumar@kernel.org

AMD SEV TIO is here:

https://github.com/AMDESE/linux-kvm/commits/tsm-staging/

7 patches, PHASE1 (from Documentation/driver-api/pci/tsm.rst) only. I'll clean that up a bit more and post. Thanks,


> 
> -aneesh

-- 
Alexey


