Return-Path: <linux-pci+bounces-4474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605AD870AC2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3DD1C20970
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1BD78B65;
	Mon,  4 Mar 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lIhye1nT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC454653A;
	Mon,  4 Mar 2024 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580834; cv=fail; b=K1+9FEP811a0VbiO9trTUd3hzB0UHEv2FJbMwdF42gq8rJLXs6XjvK4B+XK8OFcfSWkv+o1SA95T582TdxfuQuXmJEGXdnA+wivOEt4u109EZd+N6Pnezco0Xs4dACtko3wgNraV4T7TUBZI0rWtZd1gtorFFQsGTAvGI3GJ6Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580834; c=relaxed/simple;
	bh=ta915SUab97IXgiXBX8FfQqqCVHHh0Sp/hDcbdU8Nt8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=TZv7KW0ak/D0QYhZ7tqPKpIu7+2BfBKfliqoGWRCtM+iM/9oDahznkjfQmRIBWhulfretsRIkxEaV2mIY9LO6l12vo4HFlHBQXXSamPk6eA1V7S/DziWN9QT5prUw2Dxx0g6kv5+D4x5Pru8xWe8ZEoaVHrydT460xWSuWrDnXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lIhye1nT; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnLJsK+8hz8687/P15mcYRfaNKXtxE+jjIDPPY204Co8aBRubCMBYM27jKgVM6zLauIWLocXwUI1MSlJ+jjv/NvSHD4pHMlx/du5JIPJv78r4oWfnQ5TpEcSEulnkdi0RrzL+2xWpagO7wkF196se7w5HthXkmINZlRXaqAS5TlX8xdvfDGyOyGDZSeeLlK3xsVWUVcI+0YW7Z7B1HBJDrdjjgvOFTWOgbv1Fbi5yxsGY5Jig8+E/6fByY00uZP66+jE+gg0268slc+zb43uQ6TctWXqk/paoEocGIFNHXplPS5fWwx37wqCdmzhhY+5Jbpi87pUOqrX28hsdab4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHFBK/5IszV3WwDOkp6Hb+DCy3WcRtRpMBZXG4OnU9A=;
 b=InwJWsXbxKHW3CjfoGvZbqA4bE/le6V8If7Vmv/v08x1Gk5bgYtReOOMl2MbuMzuCW/t2jZvcm0dlVMnp7hNcTw8BzYGUgwnqQD6TsqfdObkb0rq9WOlKwN+6dZFWEDW0ZmVm1sn/ToKmHkPpq+2A5kF4Qvpasogf/pP2ZavYaTae5MoLcK7ZOWXctppCl1pt06TAPM4y/O6/Zsn6ZZdYC4gP/WY/3LmjErUE0NYEVpPxw34Z86ioK82B2Q5yGwfkKtmnOtPS2YILEr3UpU3cBTyGHKUeRc4gXzSxtN8D8i9bUwDBLWBPlZbZ8RtHgScV12WHWvYa2SRco63qQnu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHFBK/5IszV3WwDOkp6Hb+DCy3WcRtRpMBZXG4OnU9A=;
 b=lIhye1nTfaGP7lp3Ts1xkIWUG+KDWMJo0Wh6XIuVpJfYddXW1hPWtD/MJ91ibCeiWfalkHqdOox1NTlcewp4eCGnkzURyQd2aI+cbR6i/FD35cP1HQd7xCvBAM3/VyOlq5RfjpXGrQMIgES07fHgss2V5B1ECkjNUcqIyDvW8Cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Mon, 4 Mar
 2024 19:33:50 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::a323:881c:69d:e1ee]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::a323:881c:69d:e1ee%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 19:33:49 +0000
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
To: Lukas Wunner <lukas@wunner.de>, Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kbusch@kernel.org
References: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
 <20240304115844.GA3541@wunner.de>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <ff3918bc-ebd2-60e2-971f-5b48ba929335@amd.com>
Date: Mon, 4 Mar 2024 11:33:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240304115844.GA3541@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b369e0-f76b-4eb2-b121-08dc3c82043f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cPm5H5mifybrSbWCkJkCLI4LEGcI/F+l+rw6o+SXLN9no8ey3+nniyOBLo+t4uGyHFmNVZt/mhK71+FzFe+F5pDCyr+BcTnCeofIbNFdkO9bPplR/eQHIMEN5CUMSpSQRuerMoU+3rlnN82RMwIYS+HzbdytzDBAWfAwkoKPlTNZ+yxy+ElpS+cxro4dKXVtAzLaGwkgXUZxDZ1xOPa+FMgO8yNr5uFU2FjFpmb/VB0ftuYPqYinwEadU6BSkRrRS4FmS7X+aPbGLQSj0AF3tq7oKNkg/mbj/M7mHI37Qnxy5+uzLcyS5UFSODXfc6LFdkQ5mXjQBlm2vlVKjVxuo5svXaRuiWBKxeOyC+oYqWHECUVFCXO7rIAQw3dGxzkdk76uthU0nIFVfuHuD4peNmXnTONj6tOJw6/Mtz/fQPkbvhAFd5QR7tWUodf0u1t5IMgMT9MeBoASKE73rZlEfq6dZCuXsAJZy3EHD+lIJleS6CklMxMzab6HL6k8NoCsqXULpWTBum4TAf+o4B08YFyw+88jl8RgvnHRNrR+RfOUj27awr7gx3ekUFMCUHri7VEXh9nYBENfV5BuYCmW9DpCz8oNg3KmAF1BgYrcYYKjQA2EBm68TgT1mutzsbb756g8TnpdZ1ujl82c9dXXK5kYTnMa7wGGuOfaToTbK9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE5aUWh4c0o5cEcrMGJlQnE5UGRkNkhpS3JUZVUrUW1PeFU5OFk1N0cwSVZ0?=
 =?utf-8?B?YlVaTm1tZXNsbUxraFEwRDVoWmdQWDFxdXdJMWhIL3lYVjVHVFRVVUVvTFFM?=
 =?utf-8?B?ZWMzck5mTUgwRnlsMkN5RG56UEkxbDVzWldVM0xnT3hiWE1aWHFNSGVmN0py?=
 =?utf-8?B?TUc5dEJHcHFhZEgyYTRhSDVrSW1wclA2dXVVWXVTeFI5bzlIWGhzMjYrMjNJ?=
 =?utf-8?B?V1dDdGlKM2FMR09TNjZ0U1lhQXpHUWV1cktTTnI5RjN4LzVqbWFwbTBqS2J1?=
 =?utf-8?B?dkNLZm4wQ1pCQzg1Zm04bitGeksrTjJzV1pESXY4b0dIK2xsZWhxSDdjRWVU?=
 =?utf-8?B?NCtBT1JubHYwMW1DLzBTdUQ5VGtMYnNZN2JKSWJCRWNsVHlwOE9BRjd5NmJj?=
 =?utf-8?B?Z2dJRjRPZjJQWFo4UjVoQlZhUlV5QVV1VDlWS1VkUzg0am5yV09yZTRPMW13?=
 =?utf-8?B?ZmVlSktCdkVEZDE2UDRhWmVyTnhPU1NYM1dmZWhNRGxEdGord3ZYZ1VoUHl6?=
 =?utf-8?B?YlhWWUVZN25XRWduMTRmckFNYitDSW1QeTdLMnhXVjBIQXNlc3UvQzl5NGxr?=
 =?utf-8?B?UlBmL1ZTMU5iUVV0ODlqUkVPbExmYS9lV1c5dXQyS1VXNmdINzdnWVoxSUE5?=
 =?utf-8?B?cmNlQ1BOU1ZVdzJpTzFTTk93dUw5czlicGVXUUpHSEEyQ1FRQk1DQi9BNGZl?=
 =?utf-8?B?VzQ3R1BPVmpkcEZleGlhNTNiS1Nqbm5LWWE1Rkt2RE1ab1d6Sis4WGJudkVO?=
 =?utf-8?B?VlRwajVIUVk3amJwZ3VRcFNRQlRRV1U5dWNWMTFVWFdCV1RYeXJqVlVPR1VN?=
 =?utf-8?B?aDF4MUZFeU5qTWk4WnJtQTgvc3ltQ09YWlBySkRiRy9FWURyeTJqbVQyZUxP?=
 =?utf-8?B?citPQVRLOFBXcHFQRndrcUhyc09pNkR1VFJwSzk4SnJQWXFEc2t2d2dQSmhH?=
 =?utf-8?B?Q3pDNnZkMzNsK3g0WHVnaG5rZzZRK04xNStRZitEVWtRYkptUU1JNys2TGYx?=
 =?utf-8?B?OWFBbU1ob0lQUTJ2c3F2L2dxVTkrOUNXRDNRS1VHT3pDTXFUcVBjeGhMRlFN?=
 =?utf-8?B?YmpOQzJPd3piOG4yaFpUNmVXc1hyZUk3dmRybjJ1UGp0YWhuekVJbGJGcDlV?=
 =?utf-8?B?UDZuZnJJR1NYaEtqNnFNNk5zODZFQ0V0blpGZGFMajlDUEQ2QmR6Y3JobTd5?=
 =?utf-8?B?eHBWOHVRWVR0QXVna3hYUE9SMjVsZThxcWE5WlFiblo4dHNFMkJTaEpNZVlF?=
 =?utf-8?B?dGxlNmZsem5OZDgzNFVLRUlyUmlVV1BmVlRQUGJsS0VwVEtOMGt5VnBKWkFP?=
 =?utf-8?B?YVkyRnc1NEVlRmhyWG1wWHM3bHJqUHRXSzVPU2w3S0xNM25zZGFpYytGK2Zm?=
 =?utf-8?B?eDJvUHJ6ekhRanE4MnBYUnIxRmxuZUxnVjRXeGd3MmY3ZVFvSnl1bDh6WVZu?=
 =?utf-8?B?T1FQbE9SeXYzZUZkbTJ6b3V1ci85OG5FUzNFbU9iandPZU1RMkNiZVo5dFFJ?=
 =?utf-8?B?eGhJWU9Fcy85d1ZYcDMxQ0I2MG85aHhZQVI2VnJURERIK3VZR1pwNjJUU3pT?=
 =?utf-8?B?NXYzZXVKa09TMzlMRzdXb09CRS9lUStIeGJjVi9ocEg2R2tHUjY4NW0yNHYx?=
 =?utf-8?B?S3RnQXQweVl3RmxUMmpBWTd4Tm1JdmJ0RFQvdEE2VkJhOU8zNHptU2NLOTVL?=
 =?utf-8?B?aDA2L2RkSUpRWHNNYmg3TE9YR3BVWm0zU0pwZkYrRXpuWlYxMlVWZURwb3NI?=
 =?utf-8?B?N0JBOTdMWXZVcUNxeFpkdXVOdWs0NU1CaktlM2xuYk8yQVREMDRsak1YMnho?=
 =?utf-8?B?OERiejJjaWgvR1N1alNGR3BJaGJLSk9zbjFIQWRabjZwVWNaTVlkUnVzVDdZ?=
 =?utf-8?B?L21UUUJhWGducDE0MHdYNGJiN1RTcnBWNmdKSm9WdzhEQUFYTVdEM2pPamZl?=
 =?utf-8?B?TmI4aEhjVEFscUlsTXU3NU81bUxib1BvSll5M0gwclQxOUJaNVpnTWhESTVv?=
 =?utf-8?B?RHJONThWQ0hET0lDZVhoWkRkL1drVWF3bk96MzJKUlNwRkhITzFVNENSa25z?=
 =?utf-8?B?dk1wbTN4VS9yN3NTWUptb2UxVktweS9WbDBLOEQ5SWFtZEtRU0luOUYycm9H?=
 =?utf-8?B?TXFZS1lDV2RXbTdVUE9KcjVXSHZSZVBQRDZLV1g3WUVmVVN2SkIzUk5pNGV3?=
 =?utf-8?Q?Gel13tlbbgxgZrwk7+excc+Y2Wa33oftYeUvQ6CjWQ8h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b369e0-f76b-4eb2-b121-08dc3c82043f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 19:33:49.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mq8BaoFKBz9uhMzx1mpFCFOoIr94M+DSFXHXQPKD5sbN5HdR6lqLoZAZoq/O75ptUKTb5f+4zdq6Z39FPtT3wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

Hi Ethan,

On 3/4/2024 3:58 AM, Lukas Wunner wrote:
> On Mon, Mar 04, 2024 at 04:08:19AM -0500, Ethan Zhao wrote:
>> Per PCI firmware spec r3.3 sec 4.6.12, for firmware first mode DPC
>> handling path, FW should clear UC errors logged by port and bring link
>> out of DPC, but because of ambiguity of wording in the spec, some BIOSes
>> doesn't clear the surprise down error and the error bits in pci status,
>> still notify OS to handle it. thus following trick is needed in EDR when
>> double reporting (hot removal interrupt && dpc notification) is hit.

Please correct me if I'm wrong.

When there is double reporting (hot removal interrupt && dpc 
notification), won't the DPC handler be called always which takes care 
of clearing the surprise down errors? Do we need it again from EDR handler?

Thanks
Smita

> 
> Please provide more detailed information about the hardware and BIOS
> affected by this.
> 
> 
>> -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>> +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
>>   {
>> +	if (!dpc_is_surprise_removal(pdev))
>> +		return false;
> 
> This change of moving dpc_is_surprise_removal() into
> dpc_handle_surprise_removal() seems unrelated to the problem at hand.
> 
> Please drop it if it's unnecessary to fix the issue.
> 
> 
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -184,6 +184,9 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>   		goto send_ost;
>>   	}
>>   
>> +	if (dpc_handle_surprise_removal(edev))
>> +		goto send_ost;
>> +
>>   	dpc_process_error(edev);
>>   	pci_aer_raw_clear_status(edev);
> 
> This seems to be the only necessary change.  Please reduce the
> patch to contain only it and no other refactoring.
> 
> Please capitalize the "PCI/EDR: " prefix in the subject and add
> a Fixes tag.
> 
> Thanks,
> 
> Lukas
> 

