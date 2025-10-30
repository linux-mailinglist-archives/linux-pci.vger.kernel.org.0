Return-Path: <linux-pci+bounces-39875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C3AC22BF7
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 00:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6800402721
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B92E7182;
	Thu, 30 Oct 2025 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mcXcArBr"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299A2DF151
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761868607; cv=fail; b=XIXq2vuTgz5wCujRLcsSF1yiukCpHjqZJUvgLsFLvkSYnT+tyY3dATe1tDz8T8pHqktYDGiZbpKxsSRkcGr7q5H1bX5ZKDI45XWASL1ESSdblOVlfIvTLC1vOGbAS+NkC+j+1Qwz4TB1nCNhFGrN+Lh/CJgBgDFSD0kel2H/+gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761868607; c=relaxed/simple;
	bh=dyYQ8pt222JrLGcC60ILuUFKLbbDV8ItyJxoWYqTFgo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fy+LwI2sdOohOW099s4Hw6DYgL3auxijy+vyWDK9FZwWWECub8TCXfR1hfermTrNv+MDVHXs8FPsJS/68NmJKJiSR5xr1JJLwulUsNnu4WB3tWlzhZfZxzDyEn/XUHTF7dQl3Y24T4EQV15umZd3y0XEk8+RGXmjJ8G0os6UEds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mcXcArBr; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPPuT8ccORqXGcJaPvM9Wff3gcnxgBkBCQBPUe2og4w851MOWTLYBSXhuwwsJgN4zHyE2OWdNUO4kahPnhlFUfft0D0NykFj1OOP1A8CqS81o/mVOSJTWIjTvuhusFA2VtZQgq1sDkPb+WQD5FYe6fXfsMzRuyyzesniQPWmIOtuzztWeSgRTEKXNFi1iWo5WjXm8/iICGM60QTcDJGD1eE/n37Ax8Lbzy+0Kp9fzMTdhdNhJlxufpE7xSOKCS9ZsHavlwVBNdLyJUIB2tLgLWv26oX4nfrAiCnlS6iXfAxKVpG9pw0Drouvlg+YV7BEo/TCTD0K+jUQoW/Gu7XS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/SOVT8FMUtB6fu0wi/oOM0h+Ek0oB1Q9jxxSAM5LK8=;
 b=Av4ChcgRW95CKZVabYuRGehAwbXJW6FKbyfPHcN+xPsbScn3PRr9Y6Tz8H22mi080PNKPNilJeNaxnvlcwUwDWmrSNuOQa1HewzATh8axiTo1mmGVwCG2yf92JOX8hfjsEYGj4uI8vW+lbMnn56K6ecnZeOScryv4LKPcAAtvu7Ous0FVLylAEVu17n/h5UWuhnyFw3TePvmY4KdWjHQYJggiqeJUerkyJp4HLv8nPqSz0SaHRQAV6U6yjnQzkMcuwaWDSypJa92KmfVMfEjTHaHGzHkRee5g59JANok2yEftEEyVQodRljvjl60tr8wqUpP0ebXlcLVrbkAB/W+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/SOVT8FMUtB6fu0wi/oOM0h+Ek0oB1Q9jxxSAM5LK8=;
 b=mcXcArBrZD+mS0apTc9G6AZ9RO3qq36Q2Ryghxr51X3ftfeR0rZM5vBd8w5NRkhri8AMHVJw6WmoBOE6T6JzAo4ZEKp11+m1E/lyOjR7aNQ4hjVwqTPfq3IV/DOFevtEIyeRZCd6D1Pgev1EcdNSAITt2eDAepq5IxJNco2dUtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 23:56:43 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 23:56:43 +0000
Message-ID: <96cba9e4-ad1d-4823-b30b-f693c05824d4@amd.com>
Date: Fri, 31 Oct 2025 10:56:27 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, yilun.xu@linux.intel.com,
 aneesh.kumar@kernel.org, bhelgaas@google.com, gregkh@linuxfoundation.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251030213717.GA1653974@bhelgaas>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20251030213717.GA1653974@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0133.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 68631d28-fdbc-4ab3-2cb6-08de180ff9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWtPODlDcWY4ZW5qeGFlc1BWQmZxbWJmWVZhOElhSGlkSGR4YWFqR053amEr?=
 =?utf-8?B?VjBSZktRVGh2Q1laSHhrTXVMaWRPQ2FQcVc5aTVHNnRJY0phNDlkUWYxbW4x?=
 =?utf-8?B?S3NPdDBFVVJ4OTIzK1BIalMxOWdpcThNTG9CNlhISEsrT0g2Q1lMTHpTY01M?=
 =?utf-8?B?aG5OU0lHT1kvSjZvdTR6UWNDNGNzaDE1RXVRQ2pmS2NlQVBoTTlyTVdJOWt5?=
 =?utf-8?B?QW55YUIrak9CQnR3Rk1BRWJTdlAvd2hPRkZETFAzSjJxc1FFVXAxV2JnbGV0?=
 =?utf-8?B?azA3RERWc3Z2MzM3bE8xOWFicmlIbHhZYlVKOHlNZ0hUa2V1MndTSC9qbmJ5?=
 =?utf-8?B?ZkJJV1Y0QjVnM1RlcU9TaUp4QnVPTFhPc2VIS1ZlUUszZVdpcVpDV0dYaWZj?=
 =?utf-8?B?alY2Tlg5eVYraFhUd2NMajVPeE9WTCtkQmdhbExvQ1N2SHlMMFlIVHA3d1VC?=
 =?utf-8?B?Qk5vZlhWT1RiSjZxRC9nQnIxekJvUWhjOWRoaWRIU2tMd0xuZ0FtNGg3aEps?=
 =?utf-8?B?dHBtQnFzYWFmNVgwQzZQd09pRllKMjU5N0RMWjlXbmNrajBwalloUTFsRmlL?=
 =?utf-8?B?VVNnN1BBY2FpMnRRMXltN0lVKzdWYkcvL1lLbEJzUXpPbWVEZ1c2L2VPTTBs?=
 =?utf-8?B?YUhNVFpBS0swY2ZNSUFPaDh4bGwxc3lWemRMcDBOZjVMRFAyL0RFNFc1UHdC?=
 =?utf-8?B?MWFkSnM5NnEzNVAwUDljaXg4V3FmUSsvOUJlZ3hNQkZuMm8xYW1Pb24ybHQx?=
 =?utf-8?B?dGJ6dTBnOUtUSGxuNDBnbmttb2QzcG1XS2VXSGg5bXVsOHdBWG44N1h5c21X?=
 =?utf-8?B?MTJIUlRCcXBQZGg1eVVuMGw5OFhhQXJSR2ZlR2lJMkNWVTdOcmtTMkJJa1Zs?=
 =?utf-8?B?SlgwTEtUQ055SWN5OTRiVEZ2ZGtwQXA4L2dvaWNtc3BxLy81UmF5d2ZDZEQ3?=
 =?utf-8?B?RkpDbGlneXBxejNZdFBBQ0ZsSkJtbEdKYjJ1K0N6NmV4T3RHUFpvMEZxTkty?=
 =?utf-8?B?aWF5WHYxZzM4cjQvUjcrNmpZS0FFaHpYVjA2R045MnRuRGhpZkx5YzJrN2x0?=
 =?utf-8?B?ZlhJS0lCdG11RVhNaUcxb21MUHZOQWlJLzJtUDhtOUhjeUd5RnI2REc1cG5l?=
 =?utf-8?B?TUhRUWNJQjZVRDBRSWVyYXRZbWREa2lCK2pwSGZ0amRBRXBNVU01UXd5cThG?=
 =?utf-8?B?RGZjSlFKRVNCdElCQlNueVRSbVpuWkhiTjQwbTZFelVQdTZIbjlRakFTdE5W?=
 =?utf-8?B?eDg1cnRBRXVlOXN2Q0tJa0ZXVGZPR2kvUERuQmpjOVpPOG05SXZDUTBWY1NS?=
 =?utf-8?B?WjFNSUhabFU0eENnc2VWMlZrRjVFamhzR3lJWUd1R21ib09sbHM5aGhFay9W?=
 =?utf-8?B?dkVEOHZpanhrZWJxcXREeG5VUTBrVGtzMmFuOHdyUzlRWW9GT0FJYmlCRTRO?=
 =?utf-8?B?ZXNYU3BkMkYxa21BVGRTZ2U2SFFJR1FoQVpNa0Yyc0pGeEpsUFpBVkNrZnFL?=
 =?utf-8?B?WGNrUkNBL3lJY1poTEl2OE0xZC9TcmY3Q3RlSDR2bU5yRElVNERZS3JZdlVw?=
 =?utf-8?B?dWxZS2VKbThPM0xZb0xBRnJFYWRGOFRlZi91dmt1YUZpWFRuWGQ2azRoTTdm?=
 =?utf-8?B?RXlxbnRsMTl3VFl4V1lvOHVmajlWN1dsZ3NvQmthRHFSWTVOMnMzdFJ1dnEx?=
 =?utf-8?B?bHBXcHYyeGJ3bDRIQ1R3M3FHbDFkdGJjKzBoWHg0V0hnUjZ6azNTRHNzYU9j?=
 =?utf-8?B?N1hJeXh2SHhjSlhYcEhnMDU2Zm1FOWpqME9VSFlzTnJtU1RXNnJHWlh4cXVG?=
 =?utf-8?B?MXVyRmpQQTg0a2JSVmdUaWsxL3ltb3hTZkdOYm5ldzhYdmNyRVBVSjR3dmNl?=
 =?utf-8?B?QkQrM3JHS2ErRUFGRzJ4V3ZrcytjYzBNdUlwdHJTN3J1VVBqZzFzdzZLYVFU?=
 =?utf-8?Q?71IciemJc/1Wmiojo1WDOXMlCtCSupAg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVQdU9ONDI4NmJLTE5KRHRtY09PeDVRYmVmeE5iNFI1YVdrOWJzdUZiY1VE?=
 =?utf-8?B?cDJiZCsySzhpTnY1SzFBOUV3UXBqSHJqQ0paQ3F1dHgwbzFaU256R09ROTV3?=
 =?utf-8?B?TVhJcElNRmhlai9zcXNvUW85eVN2RmxQZ05RWkxyWEVBZ0RtR21iRllQa0VQ?=
 =?utf-8?B?QU9pSWZDOUx4bHdEWDhlb3diU00vOGhJQUFQeGdtTGszTmg1cXY5TjJDVVJY?=
 =?utf-8?B?bStJZk41UDkvaVBQdzRHQXVYTTVrZEh2NkVCWlZVV2N2bmlzYkZCeEFKMFEw?=
 =?utf-8?B?d0JpOWFSWVhPbFVzc3hLQ3JsQ0lYMWM2Q0d2TVAzOUdITmk2c2Y4NGJvdWdZ?=
 =?utf-8?B?aThpaFJLNWFsMlRBcnpyQ3drdVRXVUFlOG84Y2VBa3I0K2V2WVpMNGNLWUxI?=
 =?utf-8?B?NXBqOFdvTGZxbzNDK0FmYzNFQUdnVXZteU1PdEE3SVhSRktyNk9KOFgwTmZQ?=
 =?utf-8?B?MGNWS2tpZnAzQXllK3h0TGpuYUJ4dWQxajNNNVNUcXpEN2NIejZ3TDUxNnJF?=
 =?utf-8?B?bjdoQjBEVDlzMG5Dd3BWQVMzSlcydzh4K0tHc3dJVU56bW8rbzhKb0lTSW5p?=
 =?utf-8?B?emJWdnl1Z2VJRUkwcVdSUGtmS0VuVml1NDhwMUZjNHJKRUMrSXdNOVRJQisz?=
 =?utf-8?B?akNxTDVBVW9lLzByeUpVU0ZJaXY5ZVdxUk1BREg4cTIyWm4yb21mc0ZRYnBu?=
 =?utf-8?B?V0V1UmJkaVJ6YThHdnZlcTRmQzdySjlMWjRzYmJobjhrM2M0QW96VkdUeko3?=
 =?utf-8?B?djY3Y1VmZUx5elU2RlUwd3JUc3hiWk4xUklCWEVWTnlXMk5PQW9aTWpNTmVy?=
 =?utf-8?B?cjZaalFiMnJPYnJPdnRSLzdtazRZdFZZU0pXMVh0cDIyN2NKMG9pb1ZqZzFP?=
 =?utf-8?B?MnMxUllDWGp6dVdNdTQ4VkRIZEt5aTN6Qk9mNU1lNVE3UGhMQ1BqTmFMck9Q?=
 =?utf-8?B?Qm9XMFk2S0dScTVxSlBpZUFKZWQ0QmpBenFCWW9BOERFU0g3bEJ0M3djQmhO?=
 =?utf-8?B?Ky9vY1ZLcytRbUJQSG9kSTZveG9nclRMM0Y2L1ZNd0NQU1QwMGlvUVdHSTdB?=
 =?utf-8?B?bmwyWkFJY3RQdGdNNDc2U3lzaWljVmNVMFd5dTRxZVM4M25Nc2RtdEYzNThs?=
 =?utf-8?B?VHB3MllmM2Ria0lzL3lpQ0F4dnpBZU5TTkFpci9VTFBLeDIvV1NSdU9JelFT?=
 =?utf-8?B?VktvWXBhNHN3aTBiOEFOWm1NL2xmdzRxM2JSdk5uYXQ4d2J6MGcxN1laOWNO?=
 =?utf-8?B?T2k2OTlNcXVkVjlDanFVWlg2cFEzQjdza3FyZ1ozWHMwdTlQUHhSSVpmbWxG?=
 =?utf-8?B?UnRHOG0xcG1pdzdOZnRsR0JaYjBzeVFremxPdXBNYkRVT2xKQ0ZoMmU0ZVRB?=
 =?utf-8?B?eEgrRVczL0dJdFV0eDhZLzkyejJBNE9PSlRWejdEVENZcWZlcncvQ1JYMkJ3?=
 =?utf-8?B?dDB1amg1SVpYL3JkajNHS0F6UURUck5Qa1M3WjMxT3g4ZDlZWnBhdnlTY3Rk?=
 =?utf-8?B?ZGN5WTRkYTRjYzRMMHo2bnJJUTRrSE1uOStNaVRuUW9CT2taNzh0U1N2Q2lD?=
 =?utf-8?B?ZmtOODVVanRQajJWSnNZL015T25NUTVYdEVZZHQ1OHdLb1dlWFBsWXpsc0g3?=
 =?utf-8?B?VytyVnQ0T1Y4T3AvRGxkWHRaRGloVUlNckpONFpwSDNhSTlkYUFHUEFjRVg3?=
 =?utf-8?B?OFNpYm1PZzFaNHFBaVo0TWpXM0xkdHFjb2ZnL2VVZG0rSC9qbkRNbUlET0Jj?=
 =?utf-8?B?VllLeWJuaFRLMUJta0d4Z2hDUEp3VVgwdHFpWEo2UGRodTlQKzQxeTFJeENW?=
 =?utf-8?B?MXFyV3JnSGc0NmpHSnY0bDRHdld1SWZKOURkdUY5ZlRUU3VVQ3F5cDdRQkVn?=
 =?utf-8?B?SW93L3F2NjdocFlkRzFNejlFVFFteFFzVVFjOEd6Q0JzaU5ubnI1RHVFK0Q5?=
 =?utf-8?B?Y09vNld2ZUxiZUNQTVJhZUQ3WlV4VkM0V0lCcUc3ZzFjRUU1aitld2dzTjNv?=
 =?utf-8?B?R1BjL2t2OHVJK2dTdlFBWklkYlRCbWdVak90OFV2cVlHK3BKaVBGdVN5N0xD?=
 =?utf-8?B?bGtLTWM0K29TbW5lL0RPOW9pY1BjTm5JZ3BDMm01VzBzMFVFYVR5bVZkd3o5?=
 =?utf-8?Q?dS/zLX0SwUzyqsJJSnDyBFWvE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68631d28-fdbc-4ab3-2cb6-08de180ff9f9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 23:56:43.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoQG2yTACbH7csWT6nqThB8ov6Z0i8FbrMdZyF9ed0nGVV521rVnyGaQhY9/qvjzJ6CkbS9dSCEucxJz8azu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835



On 31/10/25 08:37, Bjorn Helgaas wrote:
> On Thu, Oct 30, 2025 at 11:59:30AM +1100, Alexey Kardashevskiy wrote:
>> On 24/10/25 13:04, Dan Williams wrote:
>>> Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
>>> 7.9.26 IDE Extended Capability".
>> ...
> 
>>> +#define PCI_IDE_CAP			0x04
>>> +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
>>> +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
>>> +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
>>> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
>>> +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
>>> +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
>>> +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
>>> +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
>>> +#define  PCI_IDE_CAP_ALG		__GENMASK(12, 8) /* Supported Algorithms */
>>> +#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
>>> +#define  PCI_IDE_CAP_LINK_TC_NUM	__GENMASK(15, 13) /* Link IDE TCs */
>>> +#define  PCI_IDE_CAP_SEL_NUM		__GENMASK(23, 16) /* Supported Selective IDE Streams */
>>> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
>>
>> Since you are referring to PCIe r7.0 (instead of my proposal to use
>> r6.1 ;) ), it has XT now here and in the stream control registers.
> 
> I haven't been following this, but is there an advantage to referring
> to r6.1 instead of r7.0?  I assume newer revisions of the spec only
> add useful things and don't remove anything.

We are adding here a bunch of macros for all the flags defined in the spec but we are not using many of them yet (or ever). And we are not adding the XT _support_ (which came in r7.0) right now, only the flags.

So what is the rule -
1) we add only bare minimum of the flags which we have the user for right now?
2) we add everything defined by the spec which the commit log refers to?

Right now it is neither but if the commit log said "r6.1" - then this patch is a complete set of flags.
I do not care all that much, just noticed some inconsistency when I recently touched "lspci" so feel free to ignore the above :) Thanks,


-- 
Alexey


