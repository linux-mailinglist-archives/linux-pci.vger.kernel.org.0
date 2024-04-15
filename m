Return-Path: <linux-pci+bounces-6247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A88E8A4D91
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 13:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEBC285BCD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5975D756;
	Mon, 15 Apr 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTl381cz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2341E896;
	Mon, 15 Apr 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180157; cv=fail; b=ly0QcPepnL3pXQxhFv13EaUwxZ2E8bfY2rtCaig0s7FIt7tBdygaDWb7TTbdCQyMUXvcvKDSjd+XBn1uX2kGLMdcmBy/O9/Oqoq8sxnNAelCzLCEWyj2bMkFc2hSSYcctcZ8+ZMbtrGephXyYOsX9WKnQQAi7S+DtRA/jggKhUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180157; c=relaxed/simple;
	bh=pQNEcgMeP5VHOMEhtli0Kx4MXsigE9saJoMi0VOE1Dk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=klfsN86quWp2nSdk9PrSc2p3vbSizTpUW9SImndsJeB2Iq/8cg2S+fZIuJ6e1GDppadi3NHNlChLXbSI4Dj37tARud5p6kUL3RQnkwyW7W1TVmQ4kJV5cZFSuFrKbCdxuJSKJGMSEHxmz+jCZhjvTDwSCKBDLa+/iG7KQbdmVMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTl381cz; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8jUcx2ZkSovekq9Zt40pKHxVOlDGdJkkJ+6WG5L70hWMnvLLjWwotEAFdE4prnluUZeEcCJKZSmJd5LA+bhcZmaCsN9Pq2werjf/VFGCFOSUmNoNBtJMZT/GpjRXK99jsnXLRD3OmSzaSYxNY35vjqGSICaNf1L4B0OqVYyz9PMv4rXd0HE295qq56msXtraJR9Zzf04AuXxdj49QCrdm5rthoQZCbJwnISxVz4lvt3ensrYOSbGIEhHC8KYIP3IaZXdC4xbuKwRzhGHBsxEHBv5WWQu8hEqwwct4ad4IOz3vBQMaOFPZ+9QukDo2GM9Eea9yjOgIAb3IMXkq5wJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW0/tjjy1Ubg7/v8Q/h05Cbrn5Kh+CxkEitp9J56oE4=;
 b=Fs1ZRPV3fg74D6hA2mk8/8kvHJ6YGLtgiJpyiW0y6U0z/RB5N1OPAO233CGotVuC4jEqRFL3IRtRe57muGwkpjyIo34p4+/7+C8DVTlL15R5c/w2CIWdVgBNq3l3kKVEDCrwaOGEgahQazZNm9M8d1OcYkBVw4F9O++LhibwFsMoKChKmZXlfw47MRfRLrOPtiqDwP30OMqMvVla9JUC0/dmN+LORw40gSJyhKwudIQy/Mo+5Gx0NKk5oO9LS0MY0dLihykBGhAz40yrQ4HfGSFpvE/AQ9ioiTdJyqJ+OHV2ISV3B3KEYd1eTukeNCKhlQITSy3v2vWwAIGVp6COUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW0/tjjy1Ubg7/v8Q/h05Cbrn5Kh+CxkEitp9J56oE4=;
 b=WTl381cz5HHAX37HJfkZYCqBuG+LMhDMZLV+zXRnDLnOvv2zjMchrSbkX149bx0cC2b/1cSkDxl0oKQmpePJn7/gBdhuGWGeMi9LrhxVV9gUiLRjjRXEVqSj9hsI9lLslZvV2KO31zkz7B05LU1iwCt6Sha9zu6tuoSmH8J9I5tCaGHsuKL7fB68S6n4GjH9qcp41ZCSM13VonNjvsxIlo1tlM3nDwvZAHIUobtBltlK/qeE1hhnmp4QoE6n5yAnJlax9WEk1qd3sBi0W+uS/KHlkq1Pr1EJQvf8VgEe2oikJUFxjNpIo29Qku7HxHjtG7pThgRziqzB/ORVuPDJQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 11:22:31 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c%4]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 11:22:29 +0000
Message-ID: <86039c78-d05f-4bae-b2cb-55bbfca8f798@nvidia.com>
Date: Mon, 15 Apr 2024 16:52:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI: tegra194: Fix probe path for Endpoint mode
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, kthota@nvidia.com, mmaddireddy@nvidia.com,
 sagar.tv@gmail.com
References: <20240412191402.GA10938@bhelgaas>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240412191402.GA10938@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc8dd16-27e8-4c80-6cb0-08dc5d3e5622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NuzLvFOx7JdgQfFmuZOvhdFEBLZkkptwpkjUq2RyVeNu24NLkMVKgai/Kaudh2eOSUWIt1/U2jGMuJ0eJNGf/jETeuPn9Rtmeq3cFLr0fxMM0sCqAW5wkapWEJvQkpGm6cGkhTB5LCnAsbDD6x3VcKPwP6g1oIcrNjAGfM+QGeYzMDOw2WJVA3RD7035Y/QHJXrKatgV8eAx8ldbhE1xn2s+CGYY8XhsNvZsIkBFYgWnutO6onm6b8YNG7dG6bj2UZgoTFZpk4nutYwsffyKRplIdonDAsz7c4geFI7UnAbqgMFavynF6+S9jl0V5ZYXcP1tNy8FyaA8A/TrXJ+n9/RklvXdHOXfRba6r8TOAFsaeFyjteJR7pug1jb+BtIincw8r5DkBO2c+RsHO4YSJ5k4mKq1Dcwenf2K4eUwciD9tmVMJfQlLvV1OtBkalN98MEGO3O40U0DE2dgwuIMdhet4Semp3XVYAFpJxRQeYqV9SbXcwVEG3GjJfxHP30vV4NgbvV7olP7BDGeL9dARVveGsodaF7NoVub2OKy5zVdsvugU9MKJueNVJkCiwvhvyI/WsTGLjbb/iqg2xUn1BhOqKjaiDavK8CdvU74wjQYkvXf56zfS0JYCFodve2LDecRqKN7L8gUGa40M4GN5ujNpBJVN47dW0vX7yHuXXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ZmMlJnMjM4Z0VsTE5mR1NMNEg1TkhUcXcrQkZCbkRZVXdDb0pFQlkyLzNu?=
 =?utf-8?B?dFVlanJ1ekFUSFplMEVkRUkwVEdFeGVUVEt6Tlh3dnRRaGRtTE9iZTk4WElx?=
 =?utf-8?B?ZXJhdG1waU5qVGhieVoySTQ3SmtKaUF1N1luZ1dkeFFmT2ZMVnppUXVITFkz?=
 =?utf-8?B?YWZVdEw5RitBbngvNndCNXo5MzN4d3FXVjNXMjk4U1BYNUZQR1ErbVRhc3g0?=
 =?utf-8?B?YXQ3cmIxZ29xbEt4RFBXdnErMzliRFF3OFNUMFF4SEtjOUQ0Y2xzSFFTTHpO?=
 =?utf-8?B?aC8vTjJlTlR3SWcyZzlyZm5qeE13SDJkanFaeXVVRDVTN0haVzZWM25WK3JH?=
 =?utf-8?B?YmFWNTcwbkdNUlpBdUF5c1d4RDVraVpkY2dheEhFajFGVEgvaVZNa3hQMEND?=
 =?utf-8?B?UjhrS0ZkWGtnM0FYczFXODlmdlJ4TGg2dDc2NUFLQmw4bDlnRWdESmFleE1F?=
 =?utf-8?B?cGxOTjQyRnVneXdDeGI5ZnA0cm9CT3U1aU1LTEYxWTNZQkkwRmM0OEM3bURI?=
 =?utf-8?B?RjRJMkREdXppaUdjVmFpaU9BVW1CS2NQMExqd1dmMFhDOWpkOVY5MUhvWlRD?=
 =?utf-8?B?V1ltWjg5NWE4Z3FyWSthSGczSXViZUtwVUE4Y3JxaGhhMk9idmVXNzlaa0E4?=
 =?utf-8?B?dTExSnErNTNsVUlnOFJlTis2eTNVNHhZM0RBWlZnV0ovaEhDck9jV3dqWWZr?=
 =?utf-8?B?RHpGQTEvMWtrNVVVa1NEOHMzYUxEUm0vZWtUZ0IvVmFjSmd4cHV4VjhqdWFV?=
 =?utf-8?B?ZUZQRFdXZEdsRzRST25GTnczaC9qYzZzbWlWbHQ4eUI4VUd4dDMwSWljVTJ1?=
 =?utf-8?B?V1IzMXk1eWxZUXZlZkl1WDJSemk3VzZrc0JZUFpWNkZoZHYxUDE4RVpqUUpG?=
 =?utf-8?B?bDJkUEt4NEZ6aHRscTNXSks3MllwTWlNQlR4REJiTXpvUC8xcCtsQzN5OWZW?=
 =?utf-8?B?OVRtbE0yenhOajF6V0dtSWhDSjNxdDhkbFNIRm9LWU5DcEN2VjhnOS9QRlM1?=
 =?utf-8?B?K3gzMmNQUFFxdGRGTEs3REhBWFBXMFpKZ2FlVHVhd1V0eEhoRDdvVEhYMnlS?=
 =?utf-8?B?ckdGZVd1NEM0L0dLcHRaTk1zSXJMR2pCWVN2TEdkUGZRS09GNzF3K0I3UUI2?=
 =?utf-8?B?RUtuSmFYVEtMT0JJYk1WN3ZidzJSbjhDQWNjSjE1ZlRFVGJkRmxwS0RFMGc0?=
 =?utf-8?B?aXpHR3RtTjUvRmNTTVdrSVlvSVgyRW4wdnpMalZpNHlhc3RxaUs5NXpGQ0NV?=
 =?utf-8?B?azI0WkJVUXRTNmZvdE5PUFVuUzlzVmlWaTE3M2U0Ui9TZm1xVFNENU1tNldv?=
 =?utf-8?B?Y2ZaVndDenJ5K1ZKNVluV3c0ZFpnUkNRWnNVMEs1L2tBQ1JUdUpvVVQvd0Rt?=
 =?utf-8?B?dW0zTlF5Nlg4eTdRc0I4MWdWL1Y1QkhwUEl1RDdQcjFUTWlzRFhjSFlTbjQ5?=
 =?utf-8?B?cFdzTVRScmU3Q2R5MmZyaXh6bzAyeE9mSmV5UVo0Z2xUbU12MGJMTGp5cS9W?=
 =?utf-8?B?d3pLMDF6YVFRSUhaUURQU0ZOUGRoTEl0TzJtT2pUWkE5ajZvd0dBN0xUMy9P?=
 =?utf-8?B?RDZDS2tzV3VuQmRVeG9zRzFaTGdidno5Y0FBL2x0dFdKM2xOZnI5U0dhVVdi?=
 =?utf-8?B?QVRqY2ZlcVdJaTZwZDJqczNUZlNMUTNrWWtINnZZb3U0Z3ozek4yV2hWd3Va?=
 =?utf-8?B?eHFpa3luUi9XRThybnhlZzZ1UFpPUlU5UTNqRkRvay9IVW9rZFQ2SXM3eFVo?=
 =?utf-8?B?VmZ6YkFnTFMyN3pzanFYV0VUV0dWbUxEeG1TRFlUSmorb1dQNmpBWGJYMk5B?=
 =?utf-8?B?L2lLYjl1SmdxaDlkSWF4U2IwRGkzeFRJMTRpTlNxTnc3TUM4L0IrQUZXNHQ2?=
 =?utf-8?B?di9ROVM5U1RjRkQ0WHdVaGN6aUFXcUxPNjMvUnFMbHVnYnA4M1V3cjdkTjZ1?=
 =?utf-8?B?RVhwRzFJc0pkU0dEUWhXdG13UG9ycWlIVCtpSFBpTnBuSGNzQUc5N3I2M25S?=
 =?utf-8?B?UU01OEtyZHpiZGN1QTcyN1FMYXp0NkZSSFBVb25tbWZNL1pPV3ljcHkxSXl4?=
 =?utf-8?B?N2tURVcwWUl1V1F6dGhPaVVHMmp6QmRqMENrOExKODV1SWFXemMvbC9IRmN5?=
 =?utf-8?Q?Jjq0rzBZvcOCcNxpG6oRa+FXy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc8dd16-27e8-4c80-6cb0-08dc5d3e5622
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 11:22:29.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iz7EOLLIKL37kO5owjT8H7NJMz/gNZRwNvixgFLiijEVurg0me6ZKIB1UOgvt20WnnV0s35H/F2GHk+IVBjlug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805

It was Jon Hunter (jonathanh@nvidia.com), who identified the issue.
Credits to him.
I'm merely upstreaming the fix.

Thanks,
Vidya Sagar

On 13-04-2024 00:44, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Apr 08, 2024 at 03:00:53PM +0530, Vidya Sagar wrote:
>> Tegra194 PCIe probe path is taking failure path in success case for
>> Endpoint mode. Return success from the switch case instead of going
>> into the failure path.
>>
>> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> v2:
>> * Added 'Fixes' and 'Reviewed-by' from Jon Hunter
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 4bba31502ce1..1a8178dc899a 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -2273,11 +2273,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>                ret = tegra_pcie_config_ep(pcie, pdev);
>>                if (ret < 0)
>>                        goto fail;
>> +             else
>> +                     return 0;
> Wow, how did you ever notice this?  It looks like this path would
> previously have returned "ret" (which was most likely 0 for success)
> but with an extra tegra_bpmp_put() that we shouldn't have done.
>
> Eagle eyes!
>
>>                break;
>>
>>        default:
>>                dev_err(dev, "Invalid PCIe device type %d\n",
>>                        pcie->of_data->mode);
>> +             ret = -EINVAL;
>>        }
>>
>>   fail:
>> --
>> 2.25.1
>>


