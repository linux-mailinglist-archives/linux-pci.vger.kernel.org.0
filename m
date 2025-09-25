Return-Path: <linux-pci+bounces-36940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E3B9EE8B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B851338555B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930252F83D5;
	Thu, 25 Sep 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dxI3kP4O"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32592F7ABD;
	Thu, 25 Sep 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799816; cv=fail; b=VGI1A/95Mry45ndGQ2YjIITziI+k9eARN4QqvFXfbs3elSV7Ita16IG5vZ5FVkZFSEQrrmm37NxBf2XOYcW9VAOGFrTOgFlzlAfE7ZLnBwRbcS9L4fSg/iOTNpiqCUEdMwdoYj/C0MyVPV2bU5GvEclEf+9c4eVFMLRqCwKU1UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799816; c=relaxed/simple;
	bh=zzg73sla7nJF9qhNpoWyJ1PYPGInoZklkxD/4UnYS0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dUHX+mOGZVaTFhdCpjLmkwuvcTIYcnb3GvQiUUEoSCkKp+e4bsXAOTLi3MK9iSHsgYGJoNDR6fO2DTwQdwD3sfkwVW22H7mN0Lt4tPju8K7qd0IpRrc99cCr8mFCXKuYBnC8npja0CuhN/iuZB7L2JjRdFIoHZGgAACCt+cQ9g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dxI3kP4O; arc=fail smtp.client-ip=40.93.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6T9q6YUk8A29JOPUNr/1N7PllDRkk/p4r/INNzfCKjI2uHxXps2720YZmGrxRmtd19XS6igD6hPDnfshGGveIKsK95wZdGTWiVieEyaTnbp0LHgOncTWgCA0k8IXun0SG67urxc1/gUrCJ/SIx3/nCLI8sqRbqscSDBfN8JgHHiBY/CYzGRMzqMK7O3u0L++V7IBg8wchG7gT1Z2rZz2UV2clrhfTyvKvLR0MN/ZYtB8AFIx3H2xlI6CVqNZeNzPsme6lPBusn2ASyVvHcXX9SMuFLChOKaM+G7vgR/AXq8v1BoS8p24JixJESLzq4dhk778FPfV34/SK/AkGwbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jesQgwa3NW67NjmBF2dOVd+v4IT+e/gMMProydVidts=;
 b=L3PIcpdj1xTkfp9hGdqPpCeDfbaAVLxNUy8EtR6wyJjNHBGfwn/H0iUlSoxp+JR9nF0aZloBZUMjUEodyNYBdQLRELWzJIh9G5bhMmiRKPJQD/TAQYDBcrfSJeilfW6S8lAOdmEB65YMtOpsM+4oQruFIvdHGlwz86PiizoHTiEBHPsHRngr0xw3RJWo5MQk9A6nreaV7QYI7H5ivLuXpEYDO/OseA+/fKQjIkBBfyZ54pkRAP+QNp/7asCRBq+Zx8Neg0jZ3zxzRdLFTgUfp2KEAqLFRlvhz1fOrizuMWEuDT5q/FdtF5h2xTGhO+5lkfpuo4bgrSU1EpZErbrRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jesQgwa3NW67NjmBF2dOVd+v4IT+e/gMMProydVidts=;
 b=dxI3kP4OvNRpK7zk8xl1JyKQgMslFdTeaTaHQNJz6Adx4v6SkBgZgH0xyB5zmcSZjfuXtWwWOELeE8Wx8th039U0Tt+wEiJ/MmeIrWldr6rYLW4hIzqRU916CrRWFTnSI/zaTlZRXAIpgnHtUf+pJCsPB9Lwv1T6vQxfwmNVcF+JwMv/Y3movvHW8ynfPXfbjjHf/JxPIoFvDKNgFAfDcFg/D5z7Mvdykee0940T81aYa5vdsAq55p7E/T8c+qquUELvxri7LInHZLH+xzj/ihXsz1eS4v3Bkn0s8n7QG+rVD11LBYcJicVNwb7Twq24aMiSdlZaaPkex0e+E1nqzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Thu, 25 Sep
 2025 11:30:13 +0000
Received: from BN9PR12MB5382.namprd12.prod.outlook.com
 ([fe80::53e:7aea:b62e:46ec]) by BN9PR12MB5382.namprd12.prod.outlook.com
 ([fe80::53e:7aea:b62e:46ec%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 11:30:12 +0000
Message-ID: <a12f45f2-62eb-44fd-b7d1-675be1f49ca5@nvidia.com>
Date: Thu, 25 Sep 2025 14:30:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
To: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, aik@amd.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
 <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
 <6896333756c9f_184e1f100ef@dwillia2-xfh.jf.intel.com.notmuch>
 <21903f51-1ed0-41a4-a8c8-cfa78ce6093d@nvidia.com>
 <yq5azfbjq2nf.fsf@kernel.org> <yq5a1pod4obp.fsf@kernel.org>
 <aNUW6s9++Ely4v2R@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Arto Merilainen <amerilainen@nvidia.com>
In-Reply-To: <aNUW6s9++Ely4v2R@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To BN9PR12MB5382.namprd12.prod.outlook.com
 (2603:10b6:408:103::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5382:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 41159cfc-6e7f-4de5-f813-08ddfc26e440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTFwYkNDMUNtYy9KTE1YTW1meXBpbkp5N3oyU3NUK2t3dmo4SW9VSGZqT0or?=
 =?utf-8?B?T21mSmVLVk9iYkU4anc3SG9xR2FQdHlabk9nYnQ1RG1uNTNvbzJqSVBqbnpM?=
 =?utf-8?B?QVJXdnM0Y1RrSEJESVhjaC92Z01xNVZtQ2tzRnl1WllLZ3BjTVBmWmpuUXdE?=
 =?utf-8?B?V09kNXlxa2QyWUxxWndkcnlGVkdGWFhBUUNpRWg5YjFJRVRDNmwwSVR1YlZs?=
 =?utf-8?B?SzVuWG9tcEU2bU95RjdxTGZ6Q2RMazQrUTQrUWc2RWl4VERBRlpHWWRWSkZx?=
 =?utf-8?B?bzRNM29kZkczWUtUZ1p5bUgxS3RvVHlsMkxYbWJHNURFR0ZqNGRSMUJRNzk5?=
 =?utf-8?B?WHVheVZDVVVxMUdxTm9yOGJKMU5oMHB1c1d6QktFVC9MMmNjYU00Y0VDcWZI?=
 =?utf-8?B?a0ZLdXlMS0N4N2dWRXZJSUdCbUFLazJYK1VoZUgyVk9adEJOODVFV0NWUnFL?=
 =?utf-8?B?cDgxbXNRZDhGSVc5MXlONmZRN0l6ODdyaW1mblk4bFNvQ3FuZVplQmNrVlNx?=
 =?utf-8?B?MjdzMXVsKy9ES0t3UGR2OHlCbjdIeFVaRUxISmJjODJSbHh3czFoMHp0TUxT?=
 =?utf-8?B?MDJOUlJUT3Q1WWlOaEJydlFKSXNaSnlMZ09hQ3FYS2MwcU5hYzg3SHBGM09m?=
 =?utf-8?B?bHdkSjAwU3VWWTc0enR6RmJTc0IwTCtVYXlabnVFTHZ3eEhlem1hMnZFNXdZ?=
 =?utf-8?B?OFBsdkU5M2poNEpYcUxSWVhPTTlQYXNJcEtRd0M0T2k3RmhIOGsxZis4NWIw?=
 =?utf-8?B?emFYa1ZhcGlCb25QaGhpeFkvRFFqenhaZjUydEo3eEoxVFVxelBTRWlqSmtI?=
 =?utf-8?B?aWxpbnRYLzd5R0xpVWZoUUpqcy9rWStvb2gra3FNUHQxcG16RDFXNjlsbVlM?=
 =?utf-8?B?SE8vakxiZlpoSzBuVEpKT2lUcENDR2JiakxGbFlWRXhnNzdIVG9qYkZLdXZt?=
 =?utf-8?B?dVFZZ0hkRTdqQmFLZnBad0drQkVha3RwZWphM2dESHZpQ2dqaTcwSnkvaFpY?=
 =?utf-8?B?VkJoV2hSSUxqaXBtN0sxWUUrSHVhYjYwa2o1WGpFa1NDMEswa3F6bm5oM01n?=
 =?utf-8?B?eS95SVlQK3JVV1hKZVlEZXBwem9qQWttT3dNcGUwYkx3Z3c3R0R2QTBua2ha?=
 =?utf-8?B?S2U2V3JWTzJhSTdWcy8wUi9ERTZMZ0lSWUxid1FsNlVnaVRqdW5XZE9Day9C?=
 =?utf-8?B?aUdRa203SFd5OHM3RjhVZVBUa2MrTVR3Vm9ERXJnQzBFT1JxTWVLdHlhNUh1?=
 =?utf-8?B?WmtyRDVxK0cwbkt5WFNHcDdJdTNCZkdUdVdlOXlFRWFpR1dDWlBEaGptMU9K?=
 =?utf-8?B?REZPWTIrUmd0bEhMNUs0WG5FUWMvcFJSN1NqMFJtc0QzWWZxa0VvZ25tb3h2?=
 =?utf-8?B?Z0ZQNkViajVVdjR3OUhZc0tEZHUxVTFOc2tnYnBiMDlQSmNWVHZGQnJZdFl0?=
 =?utf-8?B?a2FUTGRMZlN1aDloSXhoUFdDZitnZ2d5b0RMYWVqRXJyc1Q4VzRNNjBaM2do?=
 =?utf-8?B?Q3Zoc25CU3BKMDhCSlNIMmsvOXEzY1JydzF4MWdsVmFYOHorV2JqUnhlUlk2?=
 =?utf-8?B?TXdwNFAzVDFSZ0JLUExCd3pwbnNkQnB5M1QzMk04VENzTFlDZGJTUm53TzZm?=
 =?utf-8?B?NnUrTWV1V0NqemdSWmNtZVIxOVNLODFVZFZWN3NPTmJVOXNpN2lDcmxlREFm?=
 =?utf-8?B?VEJTUWd0Z1dGMEpWT0ZJL3QrdWVpQ2MyaXhUdEtwYVE2b1JWQ2JFbTRLQmlC?=
 =?utf-8?B?bDR5RHIyK2pBbEk2VmY0bWNvbmdYVC8vdURqZC80b0tISUZrbjU4VjVncjNK?=
 =?utf-8?B?TTBpUW0vK3ViZFZBMTU2K0NyL1FrOGtSSE5rZzJlWVNiTE14NkJPc2NwSTFO?=
 =?utf-8?B?UmtIR0xMaGY4RThHZllWcHNjNTdYdURsSnIrUlBMQ1ZxNnB1T0FObkhESUo0?=
 =?utf-8?Q?yCIA+4pP3PY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5382.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Kyt3RThRclZkR1hKdysyYmZETjhjcFFOWTN1c2lMQmU4T0E4RHZCRURpdkw1?=
 =?utf-8?B?UFV4SVYyYjl1YXNDK1Zoc08wbDVzbDlhbkFhUXV6eDdobnRuWUtlckt4dUJu?=
 =?utf-8?B?OXh6bnVtYVdKSk1XM0ZseWp5cHpLOFEzTUFPWTZHMFRGOUdxdTE3dFdvUWF0?=
 =?utf-8?B?aE9EYlZSYklVbGs0WFlhVXNKdGlicFhiTzF6NHRVN0dBdG0vN1R3VUtMZWxG?=
 =?utf-8?B?dzJrQjB5U1Jsbk9OSTNhSC9oc3FNd1Z6YkRtdVJwdncvSThsTmlhN2U0TzVo?=
 =?utf-8?B?NzhxMFY2NW5DYzRDV1JJeFdMcUVYK3lRaHBZOHd1SDdOU2REbWRjVytFVm42?=
 =?utf-8?B?cUcxb0dsMU1KUG12VGNoZEFDNmV4ZWFBRGxYKzJIdnVudDVqYVBwbCszaWpz?=
 =?utf-8?B?UHVKSlNjOEFZbTNPRWt6cHhsejMwcjJZRHg1WmJ5L2dJaCt5cW9kdGdSRXk2?=
 =?utf-8?B?T0dGMUNsUmNtN0ttVzVPaUJqSjhvekoxSWxQVUkyYU1SRkZBd0RkSEMyNTFm?=
 =?utf-8?B?NVlJQ1V3cFd6K2tnM1l2WmJ4ME5mcldxNEtEVVdGU21naUVzWFltVG9NbXNC?=
 =?utf-8?B?TFlPdlZkL052WWRLYi9PTzl5SW9wYmNCNEZUMWVMRWxyWVQ1bXh0VnJpQzA5?=
 =?utf-8?B?REQ1OEl3bU1mdEhBcENqczg2MGdneXpFSjFHeTNpKzkrNENrdFFSU0JJRTBr?=
 =?utf-8?B?TlNrdWVOZ0hKNlppUXpkbXZiSWdsK0hFbzF3Tlo0SUgzamV5RFQrSmxTS3F2?=
 =?utf-8?B?bGY2L1pmQ1lDOHJkdGI5RUJkczNFakFSRzVETnBvZUhGVWFVUmlnMDZEU29I?=
 =?utf-8?B?ZUN3NkFVSVhrRG5zeUE1UTFTVFdhdGRBMFQxOWp1WWRuTWF4UkE1YkxpbzdQ?=
 =?utf-8?B?bCt2d1BVQm5Ed3NiYkUyRjZva2x0NVJhVVN0bklrYVNSZUNjU000QjgvRE9R?=
 =?utf-8?B?M1B0U09RL1lBbk9WTXoxbGJIdGhDSFFxTmpESCtLcHZDemRjZXpUMk1rTWl6?=
 =?utf-8?B?RUpqeDY1TmZOVjhiU3AzRzRMc0xpY0Z3NEkvOWJkVCtLS2g3UGx1cWNxY2Jx?=
 =?utf-8?B?OW93dGlrMDZhT0tneE5ONWJnWnJORGpIM2pZNm05ZGU5dW5IY3BHOEY2Tjg2?=
 =?utf-8?B?RXQ2Mi9zMGw5cWlQelI4bjc3M1ZVUG5lc2pWNVFrZDhrOFA1THNPa1pIbGE2?=
 =?utf-8?B?emRWbG15Y1NLR3VnajVwbFNxYlV5V0x5ZkNENG5aTmZNYzVFWUVwelZmVnk1?=
 =?utf-8?B?YSsvaUdkZjR4dWYzUGJLU0RaOVR3QjlwWW56RjZUeTVDeUpPSmYyVVF2OUNo?=
 =?utf-8?B?QzF4TlBFQTQ5dlNxVUovWURvVmFLbUI5TWlvWEt1d1hSZEY4QXkzeTRibnl4?=
 =?utf-8?B?bklaS0JMWmU4Wlh1bnVBMXZaUzc5eFVMbURHa3FyVldONnlxdUxxWG1nb3VD?=
 =?utf-8?B?ek1KUE4yWnErVnJyQ1JRWWpZRTFGN0RXNzZ2M3dxd0dGeEcrTWhKZnBpVnFL?=
 =?utf-8?B?Y0VnZEMxZC9nYWtIbU9UMFg4YzlaSHdrYTJCOGxpSTFQYndlQjhLZnp3YTRQ?=
 =?utf-8?B?SjRaTzZQRThUdlMxQ1N4MExNMEtQOExqSnVNNmRqQlJRWHQ0N0NNR0xTTjJH?=
 =?utf-8?B?d2hVWEN1c2padCthRkZTS2pEajJwL21RWjhzNEsySzQvWnQ1Q3lvcjZlZnUv?=
 =?utf-8?B?QzR5SjR5TGtIVWJKR0ovQ3lPZDdvNkN6M2RsWnFEOHFsZjYrdkU4Y2VjRldB?=
 =?utf-8?B?RnhtUFdMYVhSMzN3WE5XdjZKQVRscFFNMytuQjNLWVJtQUYxOVRSaVlOcVVp?=
 =?utf-8?B?RTBSMW1GazlYNHlXdGYrdWsxSG9sNHlJRFI4OFd4b2w0VDcvQmQwM01QdGxW?=
 =?utf-8?B?bEtycjdadDhnb0NKRTRNSXNvVWxta2J6UFh4TUNjVnhyN212NTlmS2R2TlZs?=
 =?utf-8?B?bm9KVVJHQkl0V05qMVNOb3ZWUW9uY09sR0NjS0ZIV3EvSE9QcTBqVFBVemlr?=
 =?utf-8?B?TzBmYXVidDRHRFFKaWdJWW12OTRPWnpIa3dDK3diRy9qc2tjRFF3R2xVc0t0?=
 =?utf-8?B?U1pLTVcwdnAvbktRdmJpOWFCaHI1ZU5tdWU1M2FOVG5xK2hjV1p6OGZDSDNZ?=
 =?utf-8?Q?QvwsqWxyLogABEKZsxm9ezrXN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41159cfc-6e7f-4de5-f813-08ddfc26e440
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:30:12.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+3PznoK7X0vfM+kBUsrcjZKyjbFGNcZOpqjdFvZbNZuX7cWXVtmfRWeuHycklarYjDHSxwQaF553tIajwpVXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723

On 25.9.2025 13.18, Xu Yilun wrote:
>> This is the change I am adding
>>
>> [...]
>>
>> +static int add_range_merge_overlap(struct range *range, int az, int nr_range,
>> +                                u64 start, u64 end)
>> +{
>> +     int i;
>> +
>> +     if (start >= end)
>> +             return nr_range;
>> +
>> +     /* get new start/end: */
>> +     for (i = 0; i < nr_range; i++) {
>> +
>> +             if (!range[i].end)
>> +                     continue;
>> +
>> +             /* Try to add to the end */
>> +             if (range[i].end + 1 == start) {
>> +                     range[i].end = end;
>> +                     return nr_range;
>> +             }
>> +
>> +             /* Try to add to the start */
>> +             if (range[i].start == end + 1) {
>> +                     range[i].start = start;
>> +                     return nr_range;
>> +             }
>> +     }
>> +
>> +     /* Need to add it: */
>> +     return add_range(range, az, nr_range, start, end);
>> +}

Should we use bus addresses while programming the ranges? The 32-bit 
ranges may be remapped (i.e. the range address doesn't match with the 
bus address).

> 
> I noticed Arto has a good idea that there needs at most 2 blocks no
> matter how the mmio layout is for PF/VF/MFD..., one for 32 bit, one for
> 64 bit. And the direct connected upstream bridge to the DSM device has
> already aggregated the 2 ranges on enumeration. [1] That greatly reduces
> the complexity. No need for callers to iterate the devices/resources to
> collect the ranges again.
> 

I agree that the implementation feels unnecessarily complex given that 
the aggregated ranges are already available.

For reference, I am using a routine like this for collecting the ranges 
before programming the address association registers:

static int pci_res_to_ide_addr(struct pci_dev *pdev,
                                struct ide_addr_range *ide_addr)
{
         struct pci_dev *bridge = pci_upstream_bridge(pdev);
         struct pci_bus_region region;
         struct resource *res;
         int naddr = 0;

         res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
         if (res->flags & IORESOURCE_MEM) {
                 pcibios_resource_to_bus(bridge->bus, &region, res);
                 ide_addr[naddr].start = region.start;
                 ide_addr[naddr].end = region.end;
                 naddr++;
         }

         res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
         if (res->flags & IORESOURCE_PREFETCH) {
                 pcibios_resource_to_bus(bridge->bus, &region, res);
                 ide_addr[naddr].start = region.start;
                 ide_addr[naddr].end = region.end;
                 naddr++;
         }

         return naddr;
}

> For TDX, the firmware enforces to setup only one addr block for RP, no
> matter how many supported blocks the RP actually has. That means TDX
> could only support 64 bit IDE ranges. I'd like to require an input
> parameter like "max_nr_mem_rp" for this purpose.

I do not think having only a limited number of addr blocks is unique to 
TDX. Given that the SW needs only a couple of addr blocks when 
programmed using the information in the type-1 header of the upstream 
bridge, I would expect hardware implementations to not have more blocks 
than necessary.

- R2

