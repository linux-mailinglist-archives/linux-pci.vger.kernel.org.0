Return-Path: <linux-pci+bounces-6451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DF8AA123
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5288BB2154D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00478176FC5;
	Thu, 18 Apr 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fUVIOiFA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ABE15B98A;
	Thu, 18 Apr 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461536; cv=fail; b=f/3FrLRZWWj6uqc02ui9XOW5AwDz1Q4LqiAdCtIVeCB4i63J31QMz18w11DTDCxO16u1CZe8RugKSX8WUBcck++fAiYQB9HKkyM9eYbgHl3DhdOaMGsH1bRI/u9OuTx/T9ASeohMBYmAnuvIUrDmzbeqisOCzhrxL/3Cx7aPX2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461536; c=relaxed/simple;
	bh=WF409Hwtj0Zh2cS3Nh2EDxZ669qRGgKpkBTzl5InTe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DpiJq4DxJGSn8jW0FbrfI/Y7CUo3RNEBVLjpcQZ+JaKbBngqOzv1Z/zlg7JRcUBB2hb9OqLdteWKeWW6uY2+aAkGYYxDRwonjVKPFC2Wn1CKd65VYPkeB5ygm3Z14eFWUnfGJgK355Pf4hNVMcGTmYHq3EqCakC7fU11wcWFVeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fUVIOiFA; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g14S3e0luaGii00REkHwOVSjpzym/2DudJEFVUXlbBfYTBJ3HGLHYp0buqxK2H39Dr0i5tMFiVAcsUbW66/0YYtm4tM3XAt82cfUWFRtj7/61vAYI1btrSCu1fSof6RC2A4lNn70DFCNU+vtguCwGqBF3LrSPfmfy5K4VzGNCaJbjAzJl9HLTqE4N7SjlAWL0CymcShs/QguBvJ9zH3mbMp/YFPIjwVkB+dtOARNrW+LrenaxbZ53aPcYId4S16DSJx7kT6Cdaskv74mxxaY/B6XelRHc2A89+fJS6dTOfz5+QNUESrh2DIfYbcAj9lHAR0h06W+HvB7HuwKbbUDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyv9QiSqgvF2Da8Dg0dw3Y5STG5Bu1B6vj3x95DvfvM=;
 b=HC3aY5kOVtc2XYM8KgFiQwwqQoJ/LmaBGWUHmFlnuS8OXM2gAv+LHJDETPQ5fFaCX+io5559caQCMm21FfnBxTLWoLhb81gUsB6QyWv2oEW3eg1F/0C2+hoo6UsDw9abm5Nvsqvrlf5MGTJpLcTVmNlveTHxVk4jzhRmTN5qJVrevk4/C8qFEUFCds7EUr8x+DZSX39usZXzD3PZUkKhqzcgeuJpS5iS4pz/8gVLTOC4WegG2XLBPeSUqCyrWMNMrCtnlByy6o39sXdaDPnewqWoU1A7qrx3c1yyzU1Q4qTOMGm7pONdj49cixSvz8gWGmNepM+ISqCGsG4r2dShBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyv9QiSqgvF2Da8Dg0dw3Y5STG5Bu1B6vj3x95DvfvM=;
 b=fUVIOiFAbZnMmQ8S+X2pvuuUNXHtdFaUapZWZT8A/SURQSx2vx5g8mhyEXPhooqFz0SNtnA4Dod+JcIIF3Pt07q1U6MTwFd2DzqS4Gn4kRf3VuafBubd4JFaAI1CpBfyHqhxAaF+HPvNUWBWlxFsbKP+SoBmiIVYK4Mbdkvgsh7mflupGtJIErIxZIN4Z7J+2Omzsk67zYT1yuUvSR9r3oLsz7fokZV437T6gym/zgGp9tmaOVnOIm2ZnVhnPTL+41olsMkNP7JsyqnF94ZzuaykjZXeT5pLj//Bu58t9g8O5d8xjgPLHHs3PmgTbuOsh06ab4mbxL3jkQL3Pgjhyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 17:32:07 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 17:32:03 +0000
Message-ID: <9e31d94e-5b5b-4711-a208-d344c340b597@nvidia.com>
Date: Thu, 18 Apr 2024 23:01:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] PCI: Add support for preserving boot configuration
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, will@kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 frowand.list@gmail.com, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240410205044.GA2152821@bhelgaas>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240410205044.GA2152821@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::8) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f26196-c102-4b2a-a1db-08dc5fcd762f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wWFuuk1pdHvOskp12dYpEMRH9+hziK709gXZUbKyY/sBV3Tz9XNPcZ5QYbkCL8FrtWB00OJ/RfwcJnQiBah/DfFTu5/3UI+cnYIyKYvHoZERZuLee6cLhsJ66tHLCFdzFhyI+/Rw2Bij5ILVZHB2C8MzSo1KIkKOUbeuTKwjfJN3qc84SCkn//2BQWOGGeEmzrIuPsypcUTBe4s9nzY7JDXlW1aUGn0ufbcNUCTr5E/sTKYe7zQvUwsb1XpjQk5qEuGVo116o/sU/+fcavG2hXKTpSfu4tjS8MfceLB/fWiBoVtwQeXNK92jIn5D/4KoYdsNNLAGAcjKiuQhffhWjknaGOXBIZz7Kh3z+usiOYN6qv9G5e7V9lP+xXmWY66p+300WDMv7yGPgU5Avdkhds5gw3CXPg2difJzIiEAJpVll5JnJo4Y2g2esJye8kMYjz/Ks8DC++TN2Iu27zdSFSvNo6GoZrfCNeJhL/xUEJ4KmwTHlwTkuxJIb2Z493SvLD1yV66SYSV9KJw4EFNCJYrQ/8bbk+s+WxVNJOCc9mLqI5JbNXjxyVvTEKOCcj1da4ztC1Rilim4IsV1WcFR/lKuXeRPOpnMexJ4KXl5ixIGfNfyv9qc/M60gXK7YrLU1prURZo4O08cqr37Mt9G+Qnc3sBQlUcjeGw6RVRIHPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1FrVzFKNXlIVVRFemhxSzMrVGtUUWVDTTAxbW1OcUpyRGxqdVV0clpXZ1hu?=
 =?utf-8?B?VlBtUmpFcnpoZVBMOW1PZEVmWUZRRWJGSEI3alpZZU41UU5XWVFCRlMrMXRr?=
 =?utf-8?B?dVFzd2d5RTAreVRaWTEzaC9uaXhUSnpDM3o2SlNqY1hETE15S01GUzJuWU9j?=
 =?utf-8?B?QjAweExCME9IbzhoUGRrSUIzbXBWVXI3dy9xNkdpamQya0tsUks2c3NLVU1P?=
 =?utf-8?B?a0lBUDBUcW9sdWJybDBteUFxUXhWS3o0cnZKeDkyQU1SYkpOakxYVkxacWhj?=
 =?utf-8?B?WmpUbDZDcGQ2Mi9qcGZrZDRKdVZCVzdMRzJraG9SQ1g0ME4yaDJUblpqTnBa?=
 =?utf-8?B?K1AzaEhvVFZTVjF4Tnh6cWZFdEVoaUU4cGNtT1hIekxIYWdkTXVRT1JCa1FO?=
 =?utf-8?B?a3N4RWJiY2tVK3o1QjRHRjZxZy9hKzQ2WUc0UFNZd3lCOGhBbzg0d2dtTXlV?=
 =?utf-8?B?L2EzVVdHVUdiQTJKUFE4MlI2VlZuQ0RteVY1U1MxMWMraE1BQktKd0tXSmlB?=
 =?utf-8?B?VGRGM0IrMUhpRG52ejVCQjVINEo2Uk52NGVJd0RnL09zTUVQdUlTRXE3MU1L?=
 =?utf-8?B?a0M3eVl1SUFRYjFqU1VNeEhWVFJZcXdvNGdUSmI2VFJRUUFlUC93eHk4UDZD?=
 =?utf-8?B?WnBmeU1CMnR6dUtMbm0vR3JodzdqeWxPaTRrTGgwSE5QUDMzRmc4eXRPeTUr?=
 =?utf-8?B?OGlwUGp5TjZLYzZIT0VLRVhPbVQrVE83YVkyZFBTUEVIaEFyY0ZKYXV1NEtE?=
 =?utf-8?B?QURQZ1gyTWFSM1Y5V1RRZGtVZzZ6NzMvYTJHckNwM0ErSks4OEFGcVhyL0k2?=
 =?utf-8?B?eE1uMFViMks2TjNrN1pqMGUxQ3pnekR5c2cxbmFCamh3eXRrdTg2UFhCeTdR?=
 =?utf-8?B?dDBvbEdFY0FaR2xwSExoWWtzRW1CYjBieUtmQnFyb1dtSER3aTlrOTU4NkJ1?=
 =?utf-8?B?eGJaM0FZUHBZZVZyQW5BbkFZbVZuK1hLOGU2K3FpZHd6b1U0bWxXOEVPRzUx?=
 =?utf-8?B?MU5aaXQwekJidXRucXdraHM4ZjhhSUNPczgxeHRTTkFkY21TU3VwOTUwNEFO?=
 =?utf-8?B?angzS2JUaVV2TjlMb0lSNlloQmRhNzVSMEk2T3hHbVNvUEpxVzZrSDlnM1pT?=
 =?utf-8?B?RFk1Nk1WazFMeWRyd3ByMVErSENiUmZCWThEenRUMUxIRS80V0FxVkJkSElR?=
 =?utf-8?B?UzVEWElFUDhhcDR5ZE5rT0lBRjJjcXlFck5KSXVRR1plVWtXSmdEVExyRzQ0?=
 =?utf-8?B?UE5lTjFPZytWZ0c3SjFidWpiWlRaTmpPRFBIekhqNzlEWUtlNFpGcGRmTkNr?=
 =?utf-8?B?Ukd6ZHVaQlhXMi83a1FZT0ZXY0RiMUZYeE5yR3BMMHhBODlZSTdhN1UrR1Zz?=
 =?utf-8?B?S0I5RGpVZlpEZXRJc3ZDdEY2eXVuRVBraEhnZmNQMzhmMGx6aklpL0lWS00y?=
 =?utf-8?B?WnZNQzE5SktZU2tPUEZhRVJXYVQvSVQzUzFFK0o5N1FMNUcvZmpkOVpQRWtY?=
 =?utf-8?B?d3JZTTArNEF0MGVFM283d0NNUWNIOXVVL3JJVjF5ODRTMGFldmFyS0tqeDdT?=
 =?utf-8?B?NHB5WThjUEs2UC83S1hJUGROeTJOaUZucS9nbW9YbG1kMzRneGJuWHVadUNO?=
 =?utf-8?B?OU9UTG11S0I5eXllVFd4bncwN05DQ1JsMkhQbDNLcWVGWko5RHpYWGxvcGxa?=
 =?utf-8?B?ZVFsWkdOM3NzYVVaUlBzYUFCekNOVXRYN2tQaEFhMUx5VzZ5MXZCRmgyTm1k?=
 =?utf-8?B?U21sYWlMT0RZRkhYL0lWcWdjajFZUWlGeWZvZlNUVEVzTktqbTlBSGUyOEJW?=
 =?utf-8?B?ZUlGL2twQW9JMTZaUDM5eEY2ZXNSVEVIeHlxVGFybHU2eExzaDRiUWVVcG0z?=
 =?utf-8?B?NEdEZVdOMXo3MnJTeFRmTE1CSWNQejloNGd2a3RsbCsxcFFlK1lkN3dtMHVR?=
 =?utf-8?B?TTV0RWxaeWNlNEl2Rys2dGFxWDFTZVIrdkZ0NGR0K2NVVElYRnlSVEZxRkZJ?=
 =?utf-8?B?NWxtNjVvNU1veTZYVHVFeGVRdkxOMmoyN3BaMU1RNU42WjFFWCtzNHlnN3dT?=
 =?utf-8?B?cDAyN3ZndHBxdnNoekgrL1QrLzRLdWJDazArWGl4UitQUFBVc2NKUGl3ZEYx?=
 =?utf-8?Q?tSxRn6TEEQUEZ9VwJNpyzuAbh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f26196-c102-4b2a-a1db-08dc5fcd762f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:32:03.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiFvOot2qUeNNh8joWajaNtrWEQoVJynd6syAVEdk8/36o9BI5UnmGPmAh45vEMvvy6nb+aPvsOvmHndnPZ6bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

Replied inline...

On 11-04-2024 02:20, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Apr 01, 2024 at 01:20:31PM +0530, Vidya Sagar wrote:
>> Add support for preserving the boot configuration done by the
>> platform firmware per host bridge basis, based on the presence of
>> 'linux,pci-probe-only' property in the respective PCI host bridge
>> device-tree node. It also unifies the ACPI and DT based boot flows
>> in this regard.
>>   drivers/acpi/pci_root.c                  | 12 -----
>>   drivers/pci/controller/pci-host-common.c |  4 --
>>   drivers/pci/of.c                         | 57 +++++++++++++++++++-----
>>   drivers/pci/probe.c                      | 46 ++++++++++++++-----
>>   include/linux/of_pci.h                   |  6 +++
>>   5 files changed, 88 insertions(+), 37 deletions(-)
> What does this apply to?  I tried v6.9-rc1:
>
>    $ git checkout -b wip/2404-vidya-preserve-boot-v5 v6.9-rc1
>    Switched to a new branch 'wip/2404-vidya-preserve-boot-v5'
>
>    $ git am m/v5_20240401_vidyas_pci_add_support_for_preserving_boot_configuration.mbx
>    Applying: PCI: Add support for preserving boot configuration
>    error: patch failed: drivers/acpi/pci_root.c:1050
>    error: drivers/acpi/pci_root.c: patch does not apply
>    Patch failed at 0001 PCI: Add support for preserving boot configuration
I'm going to rebase this patch on top of linux-next and send.
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 84030804a763..ddc2b3e89111 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -1008,7 +1008,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>        int node = acpi_get_node(device->handle);
>>        struct pci_bus *bus;
>>        struct pci_host_bridge *host_bridge;
>> -     union acpi_object *obj;
>>
>>        info->root = root;
>>        info->bridge = device;
>> @@ -1050,17 +1049,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>        if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
>>                host_bridge->native_cxl_error = 0;
>>
>> -     /*
>> -      * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>> -      * exists and returns 0, we must preserve any PCI resource
>> -      * assignments made by firmware for this host bridge.
>> -      */
>> -     obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
>> -                             DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
>> -     if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
>> -             host_bridge->preserve_config = 1;
>> -     ACPI_FREE(obj);
>> -
>>        acpi_dev_power_up_children_with_adr(device);
>>
>>        pci_scan_child_bus(bus);
>> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
>> index 6be3266cd7b5..e2602e38ae45 100644
>> --- a/drivers/pci/controller/pci-host-common.c
>> +++ b/drivers/pci/controller/pci-host-common.c
>> @@ -73,10 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
>>        if (IS_ERR(cfg))
>>                return PTR_ERR(cfg);
>>
>> -     /* Do not reassign resources if probe only */
>> -     if (!pci_has_flag(PCI_PROBE_ONLY))
>> -             pci_add_flags(PCI_REASSIGN_ALL_BUS);
>> -
>>        bridge->sysdata = cfg;
>>        bridge->ops = (struct pci_ops *)&ops->pci_ops;
>>        bridge->msi_domain = true;
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 51e3dd0ea5ab..e6da3654f9ac 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -239,24 +239,61 @@ EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>>    */
>>   void of_pci_check_probe_only(void)
>>   {
>> -     u32 val;
>> +     bool is_preserve_config = of_pci_bridge_preserve_resources(of_chosen);
> No need for a bool here:
>
>    if (of_pci_bridge_preserve_resources(of_chosen))
>      pci_add_flags(PCI_PROBE_ONLY);
>
> I think it would make more sense to add
> of_pci_bridge_preserve_resources() *above* of_pci_check_probe_only()
> since the usual order is to define functions earlier in the file than
> the calls.
I'll take care of it in the next patch.
>> +
>> +     if (is_preserve_config)
>> +             pci_add_flags(PCI_PROBE_ONLY);
>> +     else
>> +             pci_clear_flags(PCI_PROBE_ONLY);
> Not related to *this* patch, but I see that of_pci_check_probe_only()
> already clears PCI_PROBE_ONLY (added by f81c11af617c ("of/pci: Add
> of_pci_check_probe_only to parse "linux,pci-probe-only"").
>
> I'm concerned about clearing PCI_PROBE_ONLY because some platforms set
> this unconditionally, and I don't think they necessarily have
> "linux,pci-probe-only" in DT.
>
> Apparently none of them currently calls of_pci_check_probe_only() so
> PCI_PROBE_ONLY remains set, but clearing it here feels like a landmine
> waiting for somebody to move this into a unified call path.
>
> I guess if we were to drop pci_clear_flags(), that should be a
> separate patch in case it breaks something.
As far as the current patch is concerned, since it is not going to do anything
different compared to what already exists, I'll leave it at it for now and
ponder over moving pci_clear_flags() to a different patch later.
>
>> +     pr_info("PROBE_ONLY %s\n", is_preserve_config ? "enabled" : "disabled");
>> +}
>> +EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>> +
>> +/**
>> + * of_pci_bridge_preserve_resources - Return true if the boot configuration
>> + *                                    needs to be preserved
>> + * @node: Device tree node.
>> + *
>> + * This function looks for "linux,pci-probe-only" property for a given
>> + * PCI controller's node and returns true if found. It will also look in the
>> + * chosen node if the property is not found in the given controller's node.
>> + * Having this property ensures that the kernel doesn't reconfigure the
>> + * BARs and bridge windows that are already done by the platform firmware.
>> + *
>> + * Return: true if the property exists false otherwise.
>> + */
>> +bool of_pci_bridge_preserve_resources(struct device_node *node)
>> +{
>> +     u32 val = 0;
>>        int ret;
>>
>> -     ret = of_property_read_u32(of_chosen, "linux,pci-probe-only", &val);
>> +     if (!node) {
>> +             pr_warn("device node is NULL, trying with of_chosen\n");
>> +             node = of_chosen;
>> +     }
>> +
>> +retry:
>> +     ret = of_property_read_u32(node, "linux,pci-probe-only", &val);
>>        if (ret) {
>> -             if (ret == -ENODATA || ret == -EOVERFLOW)
>> -                     pr_warn("linux,pci-probe-only without valid value, ignoring\n");
>> -             return;
>> +             if (ret == -ENODATA || ret == -EOVERFLOW) {
>> +                     pr_warn("Incorrect value for linux,pci-probe-only in %pOF, ignoring\n", node);
>> +                     return false;
>> +             }
>> +             if (ret == -EINVAL) {
>> +                     if (node == of_chosen)
>> +                             return false;
>> +
>> +                     node = of_chosen;
>> +                     goto retry;
>> +             }
>>        }
>>
>>        if (val)
>> -             pci_add_flags(PCI_PROBE_ONLY);
>> +             return true;
>>        else
>> -             pci_clear_flags(PCI_PROBE_ONLY);
>> -
>> -     pr_info("PROBE_ONLY %s\n", val ? "enabled" : "disabled");
>> +             return false;
>>   }
>> -EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>>
>>   /**
>>    * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 795534589b98..b0e0226a8da8 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/cpumask.h>
>>   #include <linux/aer.h>
>>   #include <linux/acpi.h>
>> +#include <linux/pci-acpi.h>
>>   #include <linux/hypervisor.h>
>>   #include <linux/irqdomain.h>
>>   #include <linux/pm_runtime.h>
>> @@ -877,6 +878,28 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>>        dev_set_msi_domain(&bus->dev, d);
>>   }
>>
>> +static void pci_check_config_preserve(struct pci_host_bridge *host_bridge)
>> +{
>> +     if (ACPI_HANDLE(&host_bridge->dev)) {
>> +             union acpi_object *obj;
>> +
>> +             /*
>> +              * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>> +              * exists and returns 0, we must preserve any PCI resource
>> +              * assignments made by firmware for this host bridge.
>> +              */
>> +             obj = acpi_evaluate_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 1,
>> +                                     DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
>> +             if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
>> +                     host_bridge->preserve_config = 1;
>> +             ACPI_FREE(obj);
>> +     }
>> +
>> +     if (host_bridge->dev.parent && host_bridge->dev.parent->of_node)
>> +             host_bridge->preserve_config =
>> +                     of_pci_bridge_preserve_resources(host_bridge->dev.parent->of_node);
>> +}
>> +
>>   static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>   {
>>        struct device *parent = bridge->dev.parent;
>> @@ -971,6 +994,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>        if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
>>                dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
>>
>> +     /* Check if the boot configuration by FW needs to be preserved */
>> +     pci_check_config_preserve(bridge);
> I really have an allergic reaction to functions named "..._check_..."
> We can tell that the function has something to do with preserving
> configuration, and it's void so obviously the side effects are the
> important thing, but there's no clue in the caller about what the side
> effects are.
>
> I'd prefer something like:
>
>    bridge->preserve_config = pci_must_preserve_config(bridge);
>
> where pci_must_preserve_config() has no side effects, returns bool,
> and the action is at the caller.
I'll take care of it in the next patch.
>>        /* Coalesce contiguous windows */
>>        resource_list_for_each_entry_safe(window, n, &resources) {
>>                if (list_is_last(&window->node, &resources))
>> @@ -3080,20 +3106,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>>
>>        bus = bridge->bus;
>>
>> +     /* If we must preserve the resource configuration, claim now */
>> +     if (bridge->preserve_config)
>> +             pci_bus_claim_resources(bus);
>> +
>>        /*
>> -      * We insert PCI resources into the iomem_resource and
>> -      * ioport_resource trees in either pci_bus_claim_resources()
>> -      * or pci_bus_assign_resources().
>> +      * Assign whatever was left unassigned. If we didn't claim above,
>> +      * this will reassign everything.
>>         */
>> -     if (pci_has_flag(PCI_PROBE_ONLY)) {
>> -             pci_bus_claim_resources(bus);
>> -     } else {
>> -             pci_bus_size_bridges(bus);
>> -             pci_bus_assign_resources(bus);
>> +     pci_assign_unassigned_root_bus_resources(bus);
>>
>> -             list_for_each_entry(child, &bus->children, node)
>> -                     pcie_bus_configure_settings(child);
>> -     }
>> +     list_for_each_entry(child, &bus->children, node)
>> +             pcie_bus_configure_settings(child);
>>
>>        pci_bus_add_devices(bus);
>>        return 0;
>> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
>> index 29658c0ee71f..3f3909a5d55d 100644
>> --- a/include/linux/of_pci.h
>> +++ b/include/linux/of_pci.h
>> @@ -13,6 +13,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
>>                                             unsigned int devfn);
>>   int of_pci_get_devfn(struct device_node *np);
>>   void of_pci_check_probe_only(void);
>> +bool of_pci_bridge_preserve_resources(struct device_node *node);
> This looks like it should be in drivers/pci/pci.h since it's not used
> outside drivers/pci/.
Agree. I'll take care of it in the next patch.
>>   #else
>>   static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
>>                                             unsigned int devfn)
>> @@ -26,6 +27,11 @@ static inline int of_pci_get_devfn(struct device_node *np)
>>   }
>>
>>   static inline void of_pci_check_probe_only(void) { }
>> +
>> +static inline bool of_pci_bridge_preserve_resources(struct device_node *node)
>> +{
>> +     return false;
>> +}
>>   #endif
>>
>>   #if IS_ENABLED(CONFIG_OF_IRQ)
>> --
>> 2.25.1
>>


