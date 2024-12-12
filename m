Return-Path: <linux-pci+bounces-18243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13939EE35A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0807164F7D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B87020FAB5;
	Thu, 12 Dec 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RoQVCjIm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD725210186;
	Thu, 12 Dec 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996705; cv=fail; b=H3uVOUC24FPT2Hn+MhNkGWGDLRk1ZWKeYeG5i/ElOtYC0KiHFpI07h8oJs+/y7YxQrLaMNWK/xZWj5DJ2nOH7/jb7aEl7Y8PxqHVMWgFrbI1qB4iumao0ErMvHDlIgJQOg3VlNwV/oC2rSVwlLBCmRteTFXHG0o9au0e3Y/rHIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996705; c=relaxed/simple;
	bh=OoK/ca7N0bRQsihObGuhdOBRI/Echtubaq7b6s/vQ48=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIFlrU9lIZgHNZAWXtlATUmPfTCtWxA2FpuEXBqlBGcfSKZKh8gzmzsM+RLkC7+WmmbrYY6WVwAkooTnUPD+DOT8CVrcNUe8bK16vw/+Ab485T21h4OCrTyAqjAOuw8o/TQIRu1WotAt6RC0aqYwF2DawCFP3ZLScH/JA9aQpEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RoQVCjIm; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mt9L5iW4wVDZs1oipF+M/91VDJFcb3RtnzFiN9JDzvEYWpbyprZAEuVKAZy6sZdsGDwHsCPCuSkN4X9XZ/0aPaACbtZnZm0krmkCow24oo0Gxwq3OMK0e9eoWbaseX8pVXRuyl+wDsif8VyfDa6GzSWbtr0wNlJ+SOn/U9rfIxE9sNuM738Yz24vd/twj7Dbf0rGiTAPGKprJhM7cdyjizUwdfUJ7DqgW9xow3YRPRrnf/v7Vz/ng14BxsWepuJMEH0TMZ8/Nqvasz6WM9aI06Y19yZcVeWR5YNGpIS5N4AFpyy30UnfFw8//2Cys9DMG9/P9kcEplazQ+JkTtl/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEtlJnlG4mTFMrEVDstPIyO/lObAD/PCjROudGWkmQQ=;
 b=ORKXOPs/gI+0IB1WWDK2u9lReqiUF8Vh8nqDyAGDhYnQU0ARiCIwJSKukKKFjOluiwtWL5/Sa8L69+cVoyrBid66BuwSuuocnrL8CaDdiFNyKnXLlpZKbu9Sn/rWMnIv/Wzrd26/EgwJCK9N3NZ+sWZXlhNa6gJW67EpaTJ+x5lbzRhmG3uMtmwlHOMG/OkDcpK3DKbp8TiDapB5vohe1ieihQZmiNUoCoQZAQqdPoxMER+VZlQmDKbzcgbuaCEnQj40ExFOcMeupHix8sltwGgLDVjkoUC+84X7reR8fnpdj1glZbh7VB5Kc0awlkYEDoTdUiEWQigp5hD3beCPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEtlJnlG4mTFMrEVDstPIyO/lObAD/PCjROudGWkmQQ=;
 b=RoQVCjImXwRrmm7DsxtXajZmhWqoCSEYwAWW/YrJXOuynLBRNFtVqFrKvuUqpeCuYtIZvt2ouglDwp4nX9tDE54uuMFeB8qBhrEj+9QNEK32gm+1DDD+OB5JgT9uMxEAVWs96X5L4KmhCGzfwNia6JbdLY4YnckghH/axZ73RNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Thu, 12 Dec
 2024 09:45:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 09:45:00 +0000
Message-ID: <8a87754c-bb27-37d9-2423-cce6170de496@amd.com>
Date: Thu, 12 Dec 2024 09:44:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 15/15] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
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
 <20241211234002.3728674-16-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241211234002.3728674-16-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee90de2-9ff5-4a96-a038-08dd1a91a4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWJEaGRFTjErRTd5eVJGV0FwaXlpRGhtNStWZDZYY09YOWhYS3pvQU8zcjRv?=
 =?utf-8?B?dXdrMCtsVjlqQ1dHT0ZMSW9mckZUSkpTbXB6TXBtY3ppK25Sd3FEWWF0VXFN?=
 =?utf-8?B?eS9vQy9TQ1B2SFd4SzNrNWRYMkw4VUNnRXVlcTJRWW9mMnkvVy9YQ1E5Ymkw?=
 =?utf-8?B?cVFmZ2NDV1VvWngwb0lqSjVPMWlBV0h1a0FBOGtYem9TMEtBTlkxbnNCUE92?=
 =?utf-8?B?Y2ZFRjJKbGJaV3VJVXhwN2ZGN00weFU4K1lPWXliREZKOGhZd3FOQ2dQOGh1?=
 =?utf-8?B?WFAydWcydi9VUm9odVFwN1FaWHZYVGhMNkJWd05ycGFyNnVhN2dKQ3R6WXE2?=
 =?utf-8?B?bTlsc1huOE9IQ3JCR3ZNbXlWS1dWQnJwOHhDSjBtL1BPSnp6eEZDcXB2MFAz?=
 =?utf-8?B?Wno0M3kzZ3lPd0JwN2RLZDFuQzE4SFdWWk1vcjAvVGFIL0xHTzJEUUZVK0ZR?=
 =?utf-8?B?b0ZWSUcyTUorYmFnMUVCbUI3cjdkSTE1MXFWbHFGUVBrZUt4anVCN29lVm9Q?=
 =?utf-8?B?Q25aNHhqSktBK05LV2o4b24wcUMvdXBONFBKZnlkakZuVVUvQ3lkaTFKeUJh?=
 =?utf-8?B?YTg5S2N6TkxRcFNUQUVoeFc4d2lHYTVldW5OR0lXbEU5Y3l4ZEprRng3WlFD?=
 =?utf-8?B?cld4VWw1TkJPZVdaWlNUKzhSSlN1VHhVVzN1ekZERjcxYUhGZEI5L2tnM3RH?=
 =?utf-8?B?WjRuTnk3U3dVVW8rQW41UTEzSy8zOFhiZ1VDMWtGUjl4VC9HU2dnWkg1bTlP?=
 =?utf-8?B?M0g0d0lIRUR4UkJJRkVpYUhWdHJBSEFtUFpWajhqVDhVaTNXYXdaVnV3b2lx?=
 =?utf-8?B?QmMwbTJnZnBSeC9JQWZRb3pXZlFNU1ZWTVJnNUVmSTFEYkpHRndoRlhGaGRJ?=
 =?utf-8?B?V2x1ODJGOTh2bG9SNnk0b0d0d0wrYTVCa00yWUxic1pBOE1TN0JBK2RuV2tk?=
 =?utf-8?B?RTA2bTVsZHgwRmtqSzVWN0gvbGE5SlJ4aEdhcTNkWXB3TkRxMFJFQzdjUzVp?=
 =?utf-8?B?bGtQUU10aWV0TEZvNWVtRUFJeTR5aC9ZdHNmNFhURlRYNUtLaEV3QVp2eitT?=
 =?utf-8?B?amVIYUhiTVhuRlkzQnl2NWJSYlZIZE9KNDREWDVtdHRKOExnYnRBZnArdTZj?=
 =?utf-8?B?VjJmOG94eEV3Sllmd1RnRkdaR1JoTE9pVlF4cG5VKzAycmdpYzBVVUZpWTA3?=
 =?utf-8?B?WllrdkFYSGkvSFNaS0JjQkNFa05CK0RnQkloU2Nyd3lnS2sxNUZmOHlsV1BZ?=
 =?utf-8?B?cHlBYm5lWm1RbEF5ZjBLaEdncVBMWmZYNndNSGVLZnJiRTllV1pnMUN5dHRl?=
 =?utf-8?B?cHBYcW9ZQ00wNEN4UmZTMkdQUTNhR09oS0o5cVozR09FZXNCS0tWS0JGM3ZM?=
 =?utf-8?B?Q0pUL05wc0NaajBqMmpaSGw2SWZOUTVDOGxhNHprSHpneEVveEtkdytRTDUr?=
 =?utf-8?B?bUxCRkRyRFVaMjMrcTVZcThpdzR6ajdzeTRUdFpEK0EyVDNDcUp2eVJIM056?=
 =?utf-8?B?dW9LazZKMDF2YUhyU2QyVnVYaitDRmxpaU1OajRwN3F4aHpKekgzZDZHYXFh?=
 =?utf-8?B?eWlnb2NCVC95U0ErWkFXOWdTb0F2UVVneDFnTEU4THV0L1lrZ3c3OERzMVVU?=
 =?utf-8?B?bUpyUUJmdVBHdE9zR2pKci9qRGd3NDBqSzE1M3o1OWFESlhvcW1QVmx2QnUx?=
 =?utf-8?B?YmpKR00vcU1HMVk3UlFWU0xZQlM5QVNoeDRCSENSQVlnN095SW1QVGNvWlBs?=
 =?utf-8?B?NjY4SytlLzJJd3dSdWtTNmljSmd0L3lzUFpvbVJpTTJrbUsxWTdxRFZDVEZn?=
 =?utf-8?B?TEFOT3pFUVF0S2hjanlKbHlxUnYxbDVrQnF2Wk9CL1pPN0xyeGVkL0J4L29n?=
 =?utf-8?Q?UeYeFO1Jkei8w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3cvUGpJVWZ5a0dOYUYxTkR6Wm12dXJpMEh4RmZ6WFBJU3hMWG5DTkZlUS9l?=
 =?utf-8?B?VmFUdXp6dWZpem1VVlh0ZWlpSld2NXVaUTREb1o0VTY5RnB5YnZwZ3VPZWc2?=
 =?utf-8?B?Vm5GNmErQkU4NVZjREdsS01Dc2wzLzVDUW5UdFlJeFR5ZngrQU9pYWtzd1JU?=
 =?utf-8?B?TlZHS2ZJQ21JTHpDeGozY3lCRkF1S1VBTVpiclNTU29rRnRhNmM3bS9MMlVp?=
 =?utf-8?B?MzVjbXJtTXNPU1k1cFQ5YWNRbDFib1UrVW54dUZLQWxyU1ZncWZMZWFLbUtI?=
 =?utf-8?B?RmxmU2ozRlQ2UzBDZVMwc2xmMzFyTUZ5OGxlMGZkZGRxSStHeFYzc0E5Slhi?=
 =?utf-8?B?S0UwRWV5SWlYckg2OUZJdlNjd1h5S0lNL1BPNVRDOG5RUkpGN3NPUlN6RzVx?=
 =?utf-8?B?aUgxRExNTmVmZ3Q1S1FhWlk5OW1qY0FXUWhzQXV5OFVkSTZjUk4xTnk4SzMv?=
 =?utf-8?B?Y1lyOHRTMStYcGkxeVZwTTRJS3dLQUpKTE45UEZoeGlIMWFiR3c3bm1RV3U4?=
 =?utf-8?B?bzJJVWR6aUUzdTd5Q3h3V1BqeVBKVUVETGJKQVRVRUoyK0NLWTYzYjhiZlhz?=
 =?utf-8?B?WUxDcUFUN1FtWWN2OXVDR1o5Y1FaQWVZdllwa0s5M0QyeDZpYzZicE1mbU5B?=
 =?utf-8?B?aTh3V29Za1BSWkpERTNvcURTbVZ5SFdqVTBmVnJWaGs5aFlmNFMweEt0dVVT?=
 =?utf-8?B?Unc5d01hSnRNWmNNNm1hSDh6SzRTSS9jYzF2RDA1c2ticldic1VCaVlnVC93?=
 =?utf-8?B?NDk0WlBZSDZUY3VtUDdkd3l3L0FzdHBKckpGM1N2SVlybFJGSERlL0R6N1RK?=
 =?utf-8?B?MEZhcGIydjh6Vno4UW4rRm1DcUNTNSt6NGhUYnAzSE5mcEsyLzVYMGRLcm81?=
 =?utf-8?B?VGd4bStrNXlOU2Yydlp1UUZXaUwrOEdKYk81QVlBQXBlOGszelI0bzMvWWdu?=
 =?utf-8?B?eFl1SnJwOFhibzBnWlFVVGU5Q0xoNUd1L2pYLzU4NzgvYzIvR2w5dTAxMG5m?=
 =?utf-8?B?NGVaS0FNVkY4a01tRjlBNitrL09jVnZPcjA1QVkwZXQvN2hMcm80S0NuRWsx?=
 =?utf-8?B?RkREVHA1Lzl2REs5ckFrL0RmV2l4K0cybUxnbWUxbUFtLzZ4aXBCTmUvOEd1?=
 =?utf-8?B?TFMzeE9tc3RjdGl0clh0VEFCUkQwU2RGa2cwa0UzQlZEWU1xQXVzRXRhMXRC?=
 =?utf-8?B?N0RCTlIydkJNNElKT0pvOE5wR292N3FlZ3Nsa1JFZDJDajJUb0d2TWxMUUgv?=
 =?utf-8?B?a0JabnF4Nmc5Z1RrN1IyaTlSM1NrOW5LVFdQY0haTjFOY291RWY1S0F4ZERN?=
 =?utf-8?B?bEtjaVZZQTFkTXJoL1lWc1ZIR3NsMzE4UlZkMTg3ZU16SWxRTWg4NjRaajVN?=
 =?utf-8?B?UGgwNGY0d0NuZHVKQ0NvTXd4eFRscklGUVNyWFJCOStUT2xiNmtRQTkvdlVC?=
 =?utf-8?B?WVh6WnlwSGc5b2hselJjV0ZRYTVRQVFmaHRjeUZWRjZaWDBjTkxNTEVuemE3?=
 =?utf-8?B?Vm1zZ2RsbkVrTk5CMGVWenNlbWdxL0Q1ZVp5dHQ4Sk9iUE9TMUI5YkxWV200?=
 =?utf-8?B?RS9xZHR6MXEwaTJ6ckdZUnhybmhjNzBYWmd1dGlKMVNLZ3ZMYTdFaUVLZ0xt?=
 =?utf-8?B?TE10UWNlbWNCMVlDblhIK090ZllKaVhEU2JCanN3REtzQ3NjQ2FjNHJJL1NW?=
 =?utf-8?B?UWMvK2tPc1lwZDRxZUtDWnM0V0loOVJYaFp5aHU0QlBVNUF4a1A2Q0Jwend6?=
 =?utf-8?B?d1N5V1BIcFdZdzhZWENna0UwMTNrZ2pWa0ZWMjdnRVYyNDlxdEp2dWlyQkQ1?=
 =?utf-8?B?OUJUQWJ4MzE5cXZNWnByTDFySEh1dzVycmxucHFXWmo3ckMxREpKNXkrKzNO?=
 =?utf-8?B?bWdOeGhyWjVtVUJzd0tvZU5RdDVRaFJjOGJIRVZJaHhpK1Q1eUlabjJoY1R2?=
 =?utf-8?B?b3Nhc0lVOVlYOFVuUEVocWF4QjVqemwzZmwzTGo3aDVpVlVVa1EySzJrTVU1?=
 =?utf-8?B?YXVDcXB3cmxsOC8wcWV4aTdwNGdjSFF6cSt0bmZISzRhQkkrS1lFckR3MkRv?=
 =?utf-8?B?YUNDY3lJRjNRbE5LemNkMXVrVU9IaER2cDZ2ZFl2YVk2cUVaLzllVTNwZytv?=
 =?utf-8?Q?6+OfQiT0TFvI5jXWcuX0irquC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee90de2-9ff5-4a96-a038-08dd1a91a4ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:45:00.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5F9MR15bt0eNZrHtqOsSYkyK4X3JGPyCyHSPUpl1VqrAp6Dd0xA1Qd2uLmcsaiIY7LHQVsXhMya9FikgMf+RwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713


On 12/11/24 23:40, Terry Bowman wrote:
> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
> Correctable Internal errors (CIE) for CXL Root Ports and CXL RCEC's. The
> UIE and CIE are used in reporting CXL Protocol Errors. The same UIE/CIE
> enablement is needed for CXL PCIe Upstream and Downstream Ports inorder to
> notify the associated Root Port and OS.[1]
>
> Export the AER service driver's pci_aer_unmask_internal_errors() function
> to CXL namespace.
>
> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
> because it is now an exported function.
>
> Call pci_aer_unmask_internal_errors() during RAS initialization in:
> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>
> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>   drivers/cxl/core/pci.c | 2 ++
>   drivers/pci/pcie/aer.c | 5 +++--
>   include/linux/aer.h    | 1 +
>   3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9734a4c55b29..740ac5d8809f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -886,6 +886,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>   
>   	cxl_assign_port_error_handlers(pdev);
>   	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
> +	pci_aer_unmask_internal_errors(pdev);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>   
> @@ -920,6 +921,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>   
>   	cxl_assign_port_error_handlers(pdev);
>   	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
> +	pci_aer_unmask_internal_errors(pdev);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>   
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 861521872318..0fa1b1ed48c9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info *info)
>   	return info->status & PCI_ERR_UNC_INTN;
>   }
>   
> -#ifdef CONFIG_PCIEAER_CXL


This ifdef move puzzles me. I would expect to use it when the next 
function is invoked instead of moving it here.

It seems weird to have such a config but code using those related 
functions not aware of it.


>   /**
>    * pci_aer_unmask_internal_errors - unmask internal errors
>    * @dev: pointer to the pcie_dev data structure
> @@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info *info)
>    * Note: AER must be enabled and supported by the device which must be
>    * checked in advance, e.g. with pcie_aer_is_native().
>    */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   {
>   	int aer = dev->aer_cap;
>   	u32 mask;
> @@ -973,7 +972,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   	mask &= ~PCI_ERR_COR_INTERNAL;
>   	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>   }
> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);
>   
> +#ifdef CONFIG_PCIEAER_CXL
>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>   {
>   	/*
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4b97f38f3fcf..093293f9f12b 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   int cper_severity_to_aer(int cper_severity);
>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>   		       int severity, struct aer_capability_regs *aer_regs);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>   #endif //_AER_H_
>   

