Return-Path: <linux-pci+bounces-6003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2145089EC90
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2351F2161D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACA13C911;
	Wed, 10 Apr 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GGBPIYn+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2095.outbound.protection.outlook.com [40.107.95.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45713A405;
	Wed, 10 Apr 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735090; cv=fail; b=INwS6m0Uw4551M/54RhHoCVluoIlPqCh8fL9OI/gUbWzw9XuGuzaddmNj6d3valruSJh19m+CzT2KLVBUbRto0NZA8y9S9VzYCnzsthz5L5auJ/qsVyeh+zJZjEdF5nRUyQGitc8Z0hWRMCvHM99aZJtLW9miI8PMa7uV23yoUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735090; c=relaxed/simple;
	bh=6zaTh1wD5o8a2jEl6up/Dp9ipsZUmQ/6O1ks5amRvSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnes/LLxxBCPIwVelKD53w2NLML97Xq7/xvjErrlwciD27C6C1ZVpm/3iVEJ2Zx02iYQ/R/g5agIDH6bHHHxmLPa4MK1Fwmpxd18nqYX6tVo0SdUhdsjSkKzF9+2oIYtrw7uoHtp8rmrNFTZyXEG92Wad9+gBdE/BsvE61yU2BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GGBPIYn+; arc=fail smtp.client-ip=40.107.95.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je6ppT5+uRV0R9ZHyZV5YS7IDBm1SxECsrXIjo29njZ/7d6zKAaNC9OP/kBFBqyyAtyGYj5q3CnNhjcle2uHYDSOC18xHv0wyjsgNWxq7fyFuge6+el0BxGDk6iTJ6vLh+FttYxotZr6ZhfcHxmI6rc59ZCNKp8Vzu+XMh/WzGIkt+lWYW6iUCLLGp3LpCaUiU9tyALsZurX55B1/eMiO0C0bq1EtfVn+akLg9opOAundmUNdQF8HhYk2aP5TYvLnaSmN5xrbUNKJfxo1iSDomBztX5+oYb6r5G3N4L5qE4HC3rbF5flp6ZalYkRGf5HA+4vX4BIOoq0V0VyTjOwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQhF/eDEoabbhhr5lSpe+c0HOYbbtZvITRRwTpQMITc=;
 b=gNQ+256nphtkfbTTMQisP/wCoG5KFLedBp5OIjihuK/xw7DkcIvWeJNanWP4Ibaihu8Mz44rRTZ75cx1nYg1T0A4+VeReCOA+EsGgyO46UbQhkGRjBFN5cSe4uyEGeb7iMQ76pEYBoJA1dWtxUXd1fJKzNIjUD2kfxblrxgIwlNquJMxXc9xBrlxVdJyB4Ak1sK1IsrJv89vwiGQ0NkYBo/iu2WJ2tfqsmads9NBq/a7ReDs0j8f7glWaw+R9Kv9CfHCcmvQnxYH04A7tk1CWGrnIstQtMm94d67vQrb+llEy0vzhDrgsyAOX6UEGkLzGmo2ZXO794No2sixvFyAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQhF/eDEoabbhhr5lSpe+c0HOYbbtZvITRRwTpQMITc=;
 b=GGBPIYn+E/Wuutj+qwvtJ895DsOMprHm9Yu4tu8PrRuVlg6/64xElD6r1XR9zLSOhqLl9Pve5n/6G0nC+Nf78ys5q4IOUSM9osp26uGkE+i3qoraoyqZ7hK6UC4kRPtKoEJE6kXYRV0j/2kbrj8+MjNvdEi3bS12Peo7oNltgap3txvrVbDZBmNoYE4zWNs0QsHivDjqs9Lv61qF9Wtpm2qO+76a/i2jOrFfFBY/IiryfpuQt1KunKlPBtp1JSd4oeVb5R4A17HxmCBxTVViCTKjVwztRhBq6fg5xqMf3YCeR6Z85e+3WScR/iA+BDoi5n3bD0fjLHp0WE9X6gQRfA==
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:44:46 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::c19e:4e13:c3bd:191d]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::c19e:4e13:c3bd:191d%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 07:44:46 +0000
Message-ID: <aea3ae44-409b-4916-8e1d-5a902713a619@nvidia.com>
Date: Wed, 10 Apr 2024 13:14:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] PCI: Add support for preserving boot configuration
To: bhelgaas@google.com
Cc: lpieralisi@kernel.org, mmaddireddy@nvidia.com,
 linux-kernel@vger.kernel.org, will@kernel.org, jonathanh@nvidia.com,
 kthota@nvidia.com, frowand.list@gmail.com, kw@linux.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org,
 devicetree@vger.kernel.org, sagar.tv@gmail.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, treding@nvidia.com, linux-acpi@vger.kernel.org,
 Rob Herring <robh@kernel.org>
References: <20240223080021.1692996-1-vidyas@nvidia.com>
 <20240401075031.3337211-1-vidyas@nvidia.com>
 <171207369295.222743.17702844066682854972.robh@kernel.org>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <171207369295.222743.17702844066682854972.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|PH0PR12MB8173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VGiJEAI53874Gr8fowSXtmFE/g35lvbyefEcsrXKUdgj4WD78v+GTcD++0eZxfMKq1tX3OYfMR2huiboSIJu+60/t6v9poal9Ce/5yBV7JVf554Snyf3pRUnAloNxHb1D7jhsvjshKSWFdtoaoae0wHTT8475gbR+hzzzPepJ79HaIQ/RNLkH2KAyyr3V4MFZu6FFnwElEBjEym1/CkmooXWKZ5eBI1xX4g+S88wskOnwsfkbx19astGmIKGd/XDpkBIDKCtEmpjJFB1gNe+fy+n1itUbYRxeFXOzwuTs0AuKQzNCazpezIBv0m4+oO821ThcZWpHYWBc43q4uM2gsKKSW+MCd5MbblFNhZSUm/B4STRyj95aR69zD9Fnhv1qmYZXeXTlgqrB9U2poqzLhIElbVNw2momLGe3pcWtFxLZQOui3DwHZw572Fi/wcMIh9MLPHyvDzVnGqTqeVG4qKwBwC7NGfswzUuth1Yn1OrtWpaD2Whf2zieYlJ2NWXr4JeULcsjl/+AR5eGMaN+WBB3hdxYZEOv1InBvAnXODd0q2FxjdMJk/wHR1KiJuoFC2wXWo8ZbZcsUb71oOT8LGeuPrA2RXYdLYD6DeTlI049GH9emLtKt3xqWo5vshoQZL5zEGoBK5qxMcKs4sJeytrASqJG0wQFjo57BXwKOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0E1YlVzNFlyYVZuUDV4Z1VUdFJFUmpWWlhiN2dHaVNXM0FIOWd1bWo5bHhM?=
 =?utf-8?B?SUVoaHRRUjlZRFBKRmdvdzhNZVIwNnR6cHFmNzZSRkU0MmVXU1Zldm92Vms0?=
 =?utf-8?B?bWNWbG1CSWFZSnVVbTJaZXIvYStHd1BkS3haenRhajhOZlhabGFETWJ5eHFp?=
 =?utf-8?B?TXV0YlZWTnBXOTkzS2o3SWFBSDBmbDMvV1ZpWmVUdXZXd0R4cWtWVnlxVDZl?=
 =?utf-8?B?TUtwSWRnaDVvSStaRk1aZ21oM1IyYUtXcW9jYUhrOUZiUUZHZUlSZFFOdXZ2?=
 =?utf-8?B?RGtWZkZKZWVYMkR6MXJ4NVZhbFBoMnRWTDNzbDhYTCtTdXVhRFVNWUg5RXhq?=
 =?utf-8?B?Z1FuRkFhSnpPMFFQSlBBMFJIOVlnQjl0RVY0ekpmMVdXL3FQMjMyQUFpUFJP?=
 =?utf-8?B?eFVzRCtYT3pGc0FFcUtKNkdJdmFpMUEzYjVDUTNGZ2lLVFAvNTl3K0NyTTVh?=
 =?utf-8?B?Y1VSSHVKdVNwSldaRjE1anEyZHpieVVGYk81WXdNclNYOWVyNjNHeVFiZEdi?=
 =?utf-8?B?VExTa3Q2Ni8zdWJkbnFNVDl4TEE4c0JodC9QenN3NVg2ZEFOYUt4R0ZYYkVK?=
 =?utf-8?B?QWRLZHE3V3NOL3YzSnFxeWlxS3J2M0FvWEpUZ1o4cy9kRldlNisrNXQ3NVdJ?=
 =?utf-8?B?SmE4UENuUjk1YWNXV2RWK0hnMnducEM2R1lQa1ZNK29YVzA1TGlxOENabjJX?=
 =?utf-8?B?Si9zVFZRcFh5N0xmU0FJTnJ0Q2hTWEV6dzlZT3FtVmM0eWlzTTA4akN5eUgv?=
 =?utf-8?B?Q0NRTDlSWUhwWVRSb2VuZkVnUURuUVpHYkt4aGdLN1dkS0hVaE5FWitRV3lz?=
 =?utf-8?B?a3lBSXRFd2lDc2NpUVRFODFMQ25DZXdabTdQNEE0QXhKOWZPYzdmM0FJRmxX?=
 =?utf-8?B?TU5FTEZLaC8vdHhudEJjM1VhRlgxQmllZ25DVFk2K0FjRjc5RFMvL1N0STJs?=
 =?utf-8?B?bkoyc1F3TDhFOTZ4VmhEWjBEMzlIcVhXTGx1MGFFQ0d0QXgyOXV4TVgwNmpL?=
 =?utf-8?B?dWViZlNzMTZ4dVpPT2pSRGtGNGlBUEMvNzBiMy83cWZnTjdKb3pvZ2hiQVUr?=
 =?utf-8?B?VzJBU2ZSSVIxRjhGZjJIREFDcnVCYmFCUEF5d0ZSN21ia0dhSEhFaUdDRXBh?=
 =?utf-8?B?d2pSbWQ3Y2lqSjJCcFh2b2VFRXI1RW1XWk9ycEJmQ3gxSXVBR3g4bWhVaE1R?=
 =?utf-8?B?KytRS25NNWE4ekRncHZQcVEvUmRnQnAzUldZdTEwSkpNV0FaSFFraEUvTDAw?=
 =?utf-8?B?clNXSS9ubHdWV2tobUtBdTR2QWg3eEUzbUo0TVNPM1AvR1FDM24rZ1I5Q29s?=
 =?utf-8?B?eE5CTmpXTWU1WFhDeVhBd2JUNzhVb1kxY3p3Sk9wZWlrZTVGZUZHSExrbXNo?=
 =?utf-8?B?TFhrZFZNNEFaMGh2SUFiYXZsQm9PQWtyQ2Z1a0FZdG9Sc0lqK1FJM0RIY0ts?=
 =?utf-8?B?MGxRcXh6b0pGZjhkZ09DcDJncllGYmpaVWJEd2hBeUxkR055MDk5ek1TakM0?=
 =?utf-8?B?OFFUNDM4aEY2bGtOTVNYVWZTU0R0dUV3LzVjK096S3h1VWZDVktmd2kvMVpy?=
 =?utf-8?B?ZmpaV1RPS2Zpcjk3ZVk2VVFTNW1nOXZGYUdoaGJwcGNqT3pLWWFRbHYyMTJm?=
 =?utf-8?B?WDU0cTg4M1hFbVdUamZDUEl4K3BUMFdtQ0RmS2xGVkdVRTFRdnpOZ2l5SnFH?=
 =?utf-8?B?TEwyUFgveUczY0Nra1dpL1RiVWMvdmxQUVp0alp4cExzaXRDMjZiUVZ6Z2k1?=
 =?utf-8?B?Q1R1YVBlT3pNVkVzR0FnWVA0VHgyb0MvTks3N0YxZDRUak5QRXpoTTRzS2lH?=
 =?utf-8?B?bzBTaGM5bUx6VmdsKzNweTNvYysxckZtRXQrNUVWZTRTKzlRTVoweURmbUgr?=
 =?utf-8?B?b1k1NEVCUlFBY2ZjYjJXNzVQMkoyV3ZsR3VjY2VLOWRpM1RLTVNkMG1WTm1V?=
 =?utf-8?B?aWRDMUszdC9aRFFrR29KZzJwdmNXcmZ2VDgyMXl6QVg4WHhPWnFES1o2LzVO?=
 =?utf-8?B?T2FZRXpvdDJpNm9YM1c3SmdxMHprSnNsOFAwdUhRTW1yVjZwRXVQK3BOdjVS?=
 =?utf-8?B?NVZuUEhoTnB3cy8wMEpKbTMwemdrTHFUeng5azJrVldlNUlGb0g0MTRXMDI3?=
 =?utf-8?Q?fPczDhuO5i1rhfC/2jUHbyV3k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd680bd-f09a-49ce-139f-08dc593217ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 07:44:46.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdYYXLFX3Jx8V/cC1hcb6rw+xUi/IJiD5i6vjIZipogCv5rkv/bOaWA6vTaDv2ZJS586/0M/MPjYnIcXkpeeDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

Thanks Rob for the review.
Bjorn, do you have any further comments for this patch?

On 02-04-2024 21:31, Rob Herring wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 01 Apr 2024 13:20:31 +0530, Vidya Sagar wrote:
>> Add support for preserving the boot configuration done by the
>> platform firmware per host bridge basis, based on the presence of
>> 'linux,pci-probe-only' property in the respective PCI host bridge
>> device-tree node. It also unifies the ACPI and DT based boot flows
>> in this regard.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V5:
>> * Addressed Rob's review comments
>>
>> V4:
>> * Addressed Bjorn's review comments
>>
>> V3:
>> * Unified ACPI and DT flows as part of addressing Bjorn's review comments
>>
>> V2:
>> * Addressed issues reported by kernel test robot <lkp@intel.com>
>>
>>   drivers/acpi/pci_root.c                  | 12 -----
>>   drivers/pci/controller/pci-host-common.c |  4 --
>>   drivers/pci/of.c                         | 57 +++++++++++++++++++-----
>>   drivers/pci/probe.c                      | 46 ++++++++++++++-----
>>   include/linux/of_pci.h                   |  6 +++
>>   5 files changed, 88 insertions(+), 37 deletions(-)
>>
> Reviewed-by: Rob Herring <robh@kernel.org>
>


