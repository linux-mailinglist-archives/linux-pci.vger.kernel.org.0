Return-Path: <linux-pci+bounces-2917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDD845505
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 11:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943681F2B65F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61115AABD;
	Thu,  1 Feb 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u6uGVWes"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7E1586E0;
	Thu,  1 Feb 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782608; cv=fail; b=DoNsw9fBHTxZJyYNvGAY4F4tczxzwncuh+aG1Ib0eRf9MNfOTKgAJAlJFyKnj85l+lftYT50xlx0I1tptHY2cYaE+agPtsodaaOyvocXSbiXi2HKVzvQwSQxdR+BzEnppOniOCH8qRmLNTsgBBY1Nm4qAwTZ3tfEMuX3Dx+38eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782608; c=relaxed/simple;
	bh=vsbr52wRtzp5r2T0DCjIBPtGP3rRjRhSs6CeJRjRR7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FSj5g91wGasthjrBa94ckaM0rJbACjWJAttZX2fBUbB+paFuUubjHeZT1pVmL2KKRPONsE+JdHsmwfz46AwQRv8T8EBnP4QXEvnsQdLw/wnO8w9ey6N02DmX7JK8WRoljPUs4zaIZNwjdXFCL6CdOkf8U9ufAc6aBQHJlonGGUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u6uGVWes; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcNU3a+3oFsx+56MiwNqa6ah/QmlUOlY1oXrlRcd5IU/8VnHoulAf34XAYBdnBErAVxSgP1VwySIexZwsmHYAE/abZUiLPtCwxAYiGX6wiZvRStT0HKT7DnDCYG04SL/8YJKj2wjDI4x8vI9mv150aDVZRYUzwSZkD2cJ0sh7CSMscp3r4V7NV6sEHBzWHCQycf1OCQrME/nPLhMn0DOxeD2QPi0yLlZqbshVHmbR/BTLAwTHpqrKhLvJF6oJlJLl07W3c7vNUHe38awqjvrPEh30cvsKYepTw0lfsCHyn1WZechNoUWf8Rq0Uvy0zomy6GsnCWMsqPEYIQj+l1YiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOrJe5HKDFq8O0snB6lbAnsxAqXqeQInEtQU2TvmvgQ=;
 b=aFYey7s1rMlWxDo/zvaB+/dOdj3oNS4D/KrIGoaWmlxLMERP+b5njoQnYzoUb3nQ5A/Y+mQ3j4Ft6ooWDo+a/p38jxsCPGg8Au1AtoqWb+mLeboB4XOF6Tbr05JbaFgZgOfoa5EOTbJK2c2OPrqKhzQCENaEJTnFsY1P0lKnU8p8CUIgflH6mvLH2U39r8bCYBpR5dbWkSfs6f32N9aTxrfJiVlau8wAbErhOLK64Z11XpTNUn2/evCdF1YdZy7rLAhb7vSsU5BCaMJT12jmfPHfC2eLNo6zj6estDavoK1bfk9egDgEBDcJgfUKaK1VoNNJIKqxQx5qbdUjD3yckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOrJe5HKDFq8O0snB6lbAnsxAqXqeQInEtQU2TvmvgQ=;
 b=u6uGVWesytomhgmWpTc8gyL5a0yTdIksdRGPrz83fybb1dTbVN0p5QS6EJPuLnm+alrMcsiXwzBsPYBZZbUQLjMSRVXjsw63bZf48Y8pnjSIaaxj3mxGqT96fL/LN7zjpWKIxwbiMBh3FQDRfBqEz3HYiOorLoYKyyyGXnqw6W4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 1 Feb
 2024 10:16:44 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::c167:ed6d:bcf1:4638]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::c167:ed6d:bcf1:4638%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 10:16:44 +0000
Message-ID: <895b31de-f7f8-425c-870b-1524be21c688@amd.com>
Date: Thu, 1 Feb 2024 21:16:37 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel 1/4] pci/doe: Define protocol types and make those
 public
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20240201060228.3070928-1-aik@amd.com>
 <20240201060228.3070928-2-aik@amd.com> <20240201065040.GA31925@wunner.de>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20240201065040.GA31925@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0084.ausprd01.prod.outlook.com
 (2603:10c6:10:3::24) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 00430813-4906-4648-897a-08dc230ee3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UD8cxXbwipBrxSZ5h0+P7tI/cjnA9Qefo1TrXhdPLgTPCCHbRKx8mtUsViWAKsFkQ8TNbkFMrviWvvbQ+yWTjj9Akx7drZ7nzw5SBNP94Gx4jL0MjTu2zKZbTNGK+82RlQ5fIrGA011O1d0THbrofyTiG8heF5JwVeUP9dszzL0GawHPc2VaDxjp1quedys+lVOkdvayldO3ySmLjShqc/hix6u+h7u5CP7wp6e4NjqdbF5VWnhqODtioyUeOVLkF66aILBl7nd7TJqs0gAZMFT0fxpM7HRfByN5qUM946z4ljc2AAxZ1ml1bdqpegcYPiU5UzhrbKwp6sE54AgPsYP/jYYZIGuBUIcEk8mrXznvxz4C3dBLbKEca8dhpoQc30I/sP/ybah1FbZRQ5NgKmuy9qyCcKScPxrxj7ay/YgxrePiXW48cB/0gNAQX868WVSrkDErujfc1ZlnE6sKybzoujq/BrsfPdkFSIk0FgXfmzZIYkNHB/f5fwfKhPX29w8lIu5cE1S5gvqH/u7nvdXRVItTQheZ5/6xVOvUlRB6ZQxNxDnnxHJGtPM+TrhFBya60PcgUrCqiejCDltyyaxLqPI+JRXQnF3WSkJAR4k0caRVbncrgJpc0L4uyCRo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(36756003)(31696002)(41300700001)(2616005)(26005)(38100700002)(6512007)(6486002)(966005)(6506007)(2906002)(478600001)(6916009)(66946007)(66556008)(316002)(66476007)(53546011)(54906003)(6666004)(4326008)(5660300002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1Bjc0NOWjRBQnhNOEwvWG5qYWRqdGliWUZhcWRrZG1Cd0tsSW50OUY4aHl6?=
 =?utf-8?B?OUlmY1ZrdEhleTRuYVhWa2F4S1pCSll0MjZQUkgwSnJLOHd4KytCWjJBVXFn?=
 =?utf-8?B?emh3SStORHAvSlhxZS9BUjR6Nll6dDZxUlNlblpvWXB0bVNZOWtQZmgydnhl?=
 =?utf-8?B?QytCVytwR0pYWG9KMUg3Y2tYU09KT3QzTmZZbWZaNzNLWk9JZ2dXSURsbG1D?=
 =?utf-8?B?c2tmQ1ltSnB4L3NTbnAzVHhnSUFNZ1cyRzM5d1VaSFdybW85UEtLNldTUzdx?=
 =?utf-8?B?WkUrK1AxVFlRUGJyOG41OXRpWUJVSGVnOENhOTgxVVJnSUhBcXF3T1dkOTZ0?=
 =?utf-8?B?Q3JXOFgxakJxZU9MN3hpampWUUl6eFRsMk9zVnQ4bkhxUnRTVlUvTlE3c0o3?=
 =?utf-8?B?TjMrUFphdWtpTFVMV01vVlpmVHV0ZS9tYVNkeWJ2QW1NMmdmcHBtNmg4Ylp3?=
 =?utf-8?B?NGQ1aC9Yb200YjNFNkVvNkZ5NDVjTkxDUnRoMjF1ZWZTakdXOEw3V1pWcjZX?=
 =?utf-8?B?L2xuYS9SV255Q1lTMjJ2bW5WQkl5aXV4dTNQNFVEaGVTUm9vT1dScTllTVhw?=
 =?utf-8?B?aXQ0RnNUSGwzc0orRnlxMksvd0l0WjltNHdKQ25KWDMzeUN3eWlLMDlqTDZm?=
 =?utf-8?B?UTJLWGpXODRtVExiMFVsYkJqa0RKTlhyY0dab0hiVTJSNEl5ZWR6SE1heWZp?=
 =?utf-8?B?YWZHdVBMR29WWXpLUlE1cEhpTkl6ZUxCaXduQzBRQkJ4cUwySXVtdVpuZ01F?=
 =?utf-8?B?ekZvbjg2V3RzUUwzdTNSdE1yVVVEdTc2d0ova3RjWkp2eEJOYnNWdGpxVlg5?=
 =?utf-8?B?Sjc3SWoraTVocmpibTNqUnZIaW1kSUQyMnArd2g5MjBhODhQKzIzNjhHYUky?=
 =?utf-8?B?dSsyY1hoQlNzb2xORGZzYkZBcjY3eGJlMnJoZUl4SGhjc2tueENUdk92NUlZ?=
 =?utf-8?B?YnprUXdnZ053KzRWUzlKSTNxYjc1cTBoUEg1OEIwZ1FpSkRqWmJzQnJVcUtP?=
 =?utf-8?B?alNCVkhtUDlxVUVPU2Zob2o5SVJGclBJQ3JSSlF0bEpZN3JwVFcrVWw1Qm9B?=
 =?utf-8?B?L1pXTVVGOTZkWTE2S3JxbW1tRmVKUlpaZE8xUDZMd0Y2ajUzSWR6WGpIOWEv?=
 =?utf-8?B?VkwvU0NVVUJpbHVrUVVzTkhKVjYwbWYwNEVEVWdTU0FLUHNnaXlacVdNYmFP?=
 =?utf-8?B?MFl5ZlozSGxyYThETXlnZG1IL2pEaGZ2aFY2S3U5eFUvNFZFY1FCUHB2c1M4?=
 =?utf-8?B?eUJISng3bjZFRU9LbEgvS014MTVQT3V0eVNNYzJKSkloVWFWbjl4cEVhSy9p?=
 =?utf-8?B?WFpWc2ZmUG0rMW1MNVpkbmEyODdZV203WUtIdEhiVGt4bVFYQmpTS2E3dCtW?=
 =?utf-8?B?NE1mWjkzQmh4QWVKUEZTYkNlTXpsRDlTR3dnbXRTRFZ5L0RWUEhmQ05hY3FH?=
 =?utf-8?B?NCtJSWQ5WTQ0N0dpVVlxMS9JUGNhd3l6Ymg5QnNhVGZNOXVRbDJia2w3M3A3?=
 =?utf-8?B?ZmIwS3BwekMrcGtzeVgvazNGRFhBYUVxWkxhS1E0bGNWOE03aEJiVkE2dklQ?=
 =?utf-8?B?M3pkK3FFVjFXdkZaOXdMbWNtU0VMaHB5dGwzZEtvWWR5am43VnhzNksxYWsr?=
 =?utf-8?B?Ty9YZmpXM2c1Y2NvTVdmUHU5YVRBbTlYWk9GZlpKbEJEd2tQb1ZEM0J3c3Ix?=
 =?utf-8?B?QnhuOFZRK2RLRHpkcHhwS2NKVEYwclFPZXJiTXpvaHl5VytjVlIwYjlvL2tS?=
 =?utf-8?B?amFYVmU0OUJmampHaU5CelpUOXpDRzRFbDF1cEJFMW16YlFaYWdRRGdwa3Nz?=
 =?utf-8?B?dTBRRjUvemd1RTBqR3NUazdhRHpqQitzc0tqRnB3VC9zdHN2UnZGcFFnWG11?=
 =?utf-8?B?azlmYXVYbXluRVpuc1RGcmVnSG5NMyt2VTB2anpIQjJyOXNWellUdXVlQ3A1?=
 =?utf-8?B?OERsZDlzR25GYkZuNnQ5b0ZNcHNTSzBScjZrYzRlaFU3SDcyeHd2YWhWV1M3?=
 =?utf-8?B?d0QveUxqa1p2M2RpWHdUYlZ3ZWppSlI1L2tzNjRJNWNGZ2szSnduenNNK1Ft?=
 =?utf-8?B?SGMxTkhRWEcrUDdNZW5BK01sTjdNbHVvUU1YN25KVDFicUZLZlBkbUpOd01X?=
 =?utf-8?Q?X6t2a0tLjLr9lr6gaeA39//hv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00430813-4906-4648-897a-08dc230ee3ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 10:16:44.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HNryE/chGGDDnYWdRvPxaVIyg1B9Id0PgyeqQpNl/4XaDkXX0mtIQ7o+3QrZR+sJtJkxiszh6eSjjGMdV0TRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

On 1/2/24 17:50, Lukas Wunner wrote:
> On Thu, Feb 01, 2024 at 05:02:25PM +1100, Alexey Kardashevskiy wrote:
>> Already public pci_doe() takes a protocol type argument.
>> PCIe 6.0 defines three, define them in a header for use with pci_doe().
> [...]
>> --- a/include/linux/pci-doe.h
>> +++ b/include/linux/pci-doe.h
>> @@ -13,6 +13,10 @@
>>   #ifndef LINUX_PCI_DOE_H
>>   #define LINUX_PCI_DOE_H
>>   
>> +#define PCI_DOE_PROTOCOL_DISCOVERY		0
>> +#define PCI_DOE_PROTOCOL_CMA_SPDM		1
>> +#define PCI_DOE_PROTOCOL_SECURED_CMA_SPDM	2
> 
> These are deliberately defined in the .c files which actually need them,
> i.e. DISCOVERY is defined in drivers/pci/doe.c and CMA_SPDM is defined in
> drivers/pci/cma.c:
> 
> https://lore.kernel.org/all/7721bfa3b4f8a99a111f7808ad8890c3c13df56d.1695921657.git.lukas@wunner.de/
> 
> I don't see why they would have to be public if they're each only needed
> in a single .c file.

SEV TIO needs both CMA and SECURED_CMA for DOE device<->firmware 
bouncing and it is going to use pci_doe() for this. I should have put 
this into the commit log, sorry about that.

Or the plan is to add pci_doe_secure_transport() to cma.c and force 
everyone use that?

The PCI SIG DOE protocol numbers (discovery, CMA, secure CMA) are all 
defined in one place in the PCIe spec and defining them in different 
places (doe.c, cma.c) is weird imho.


> 
> Thanks,
> 
> Lukas

-- 
Alexey


