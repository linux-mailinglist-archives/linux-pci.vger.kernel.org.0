Return-Path: <linux-pci+bounces-2005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A2982A007
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C26B20B2C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F224CB3F;
	Wed, 10 Jan 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhqwQxCW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6E4CDEA;
	Wed, 10 Jan 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdiTOo7V1G0yXkjMGcZoXKbW53Nmji5QETg5w984jA/ZdIIDFHmKJvKYOesHoA/TDwivRrLwrsX8d/QeBU55GQIVWfkJ44r6GbU+0PYZb2Jg5U0wDnwe32SOxhH1teA6Y3iaCn0onsN5bfWE1Lf32UFIyS4SKhBZjNyEpJUAbehw+vW/Wbn72ZFIexn7IBL/ESDmu/rTQJ4UBgFXoztzks4P07xQuSugEszKY6KS+1D2HWnh1TmGPAeWRcNmimEoCL3nkBjEkzhHSFw+TXwUST662UU5T3ZBB8Fe3F2bdj5NPoaq63bHb7IYVv70ypG+mSNYRdzLeISwOAyx0yvncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMWkfihxxTu3W2TX9ECBGfwju2JpNceN/YlAxjjyZEI=;
 b=mv6Cl6Tizx5S+R4m9qrSC6h6OGBfAnN7hTS9MZxeSWJLeRqDY7OK22TGr7qYMEtOFyOZaFlPzuQJAq5045jKZDrT7uMUWIrBsvKHerZGwkv/hlSVgW7+xda+INzZw0a3YuWClMF8WVQ6lpEy5UQURGlnwC3DsKVb4GNHl6am9BKbbc0VdnJuVkUnd7le3yYqHKucTOkoGrOLj4PwAZeJdNeSk17QUVqq9QrF5Y65EXmmQDtCMSBZGxhZ0QFDR9/TIXQBRNTXumZcplIx2rLbZ9yWUtQrO7nBmFH/iimArfgyBssPlNp0nvG8LljLCJ0iuNqlXIFEmTdt8kleepDiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMWkfihxxTu3W2TX9ECBGfwju2JpNceN/YlAxjjyZEI=;
 b=qhqwQxCWSKL39SEkYcYqHMG/jQdi2qPpAx4l0EVpy4RyiBp6f5PLwjiyYLMnPN2qtaYVwmUQ5oxioES6GWR9GTQdfNEL9WmO8hKkjkic3/upiGpegWaakZ+UUKx/BsdjvtDEu1nFfHZkr2IfFDOJA3yziSfZtNq+d6xqm6rGEjSm/mEO23zwAJaZ8tsNl0flgi/qZPEjBkfA9sUavm/Mlc6Vcc2M0GVWttVZSqlcZDelJ6CcOBQNcIhG/1r69Lwkw+VulxCXMbcuOWdOtCA1G5YSnHFOcvf5dLLn3jE7cNoB2ttu2PsEoX+2TPwE+2HZHxjIbq7Gge7/lfOc+uospg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 18:04:54 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 18:04:54 +0000
Message-ID: <9db8310c-e74f-4f66-bc4e-7af795ec5879@nvidia.com>
Date: Wed, 10 Jan 2024 23:34:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI/MSI: Fix MSI hwirq truncation
To: Thomas Gleixner <tglx@linutronix.de>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
 Marc Zyngier <maz@kernel.org>
References: <20240105134339.3091497-1-vidyas@nvidia.com>
 <20240108120522.1368240-1-vidyas@nvidia.com> <87il41jy48.ffs@tglx>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <87il41jy48.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::13) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 81160bc9-927c-4973-35a6-08dc1206a587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	It3WSr8TSdXzfDrwiU6W4DaD3i8Fp+Glsw3uezBmtlwUycnYaUFLR3qLwBoWg0Wym76hEm3D6iTk2trdEyQXhweRkvKHndaTD6dlYK5gDG4bIuqo2TQt52zy4PpFPHG9T1OjllNmavEp23PA4/v0R7+Cw7emonmA4Dc7/I7Zb0nwoL5Xd6OH5Ih7PpspAOOkMo8p9dawpi15d2w/Np1lBLe1jcN4qwBeNCrw34s+gV9p1/iHGbNeithQrhdoPLlGmakAROV8YdHckhbOIT4C9xGdlIw4fk+LSJRw5+qVtZ7+bYCCvv0jS7PT0h/9i6K8v/vVvIyjJ/d1EGtuZ2h9GhGTHZOgczfEYpqUeQ/Jw2sE00aC+PCk2vNjdpyZ7BaRZRhahCV2Wl4lddNLIzfVt7NLNlfi+4lFGbUDJIXPU2qbhIFZY5OTk8em2lMclu+T5Igd49wWWsn4DEOE/K1GZprPpA4tCZ++MgS5jw4itzPhW6wAkzzH0mTIyu4hElDIMoWoBgtqO2kL8ml7xUtW7gL+Wdz3F8TUoNtWw5m5psuL/kh4nLHRX0zrLZxliorNKERhjXKa1DXhd/dd5DbrreAfxRN7HCWtB1sPwHRT2mJU+Kk3ewMHAZCFlILMxmkMb0TXd91Y0EMP11+jeFrrroW8Qvdf0sqQY0IyNA5qljd/MDcKVGJydfXpbrbwhp3B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(2906002)(5660300002)(41300700001)(83380400001)(478600001)(6486002)(2616005)(26005)(38100700002)(6512007)(53546011)(31686004)(6506007)(6666004)(31696002)(86362001)(8676002)(8936002)(4326008)(36756003)(66476007)(66556008)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEM1Q2lOWUg4SmRidExId3kwUlI5S1NUVTRQZ04yUFNlUk9Oc2NzbEp6bzFW?=
 =?utf-8?B?MWN5MEFzbCtJR0xkbHJ5bEp5RktIRlNsTnNMYmlrT0FxZjRCT3h3cFgwbmU2?=
 =?utf-8?B?bE4vNEFMSFBTV0cvU3ZLT0l4QTREU0pnZnpYZE5UNzlJbDlObjA5MHIvTW44?=
 =?utf-8?B?dXlYUFRuYTk4MFA1cXNVSFNoLzBiTnQvZXAzS0xlWXp0cXpsMlhwMWp4Sjh3?=
 =?utf-8?B?WjRYMGlIWTIzb2hIVUZXS0ZqaFN6ZzF0MUxzR3NpcGFtTmw3am1qaDIrTGRn?=
 =?utf-8?B?OGRyTWhkRTloYldJZm1yODJJazk5SjVwbTViT2psZzlKcWIrVGdpOXZKV1c2?=
 =?utf-8?B?UklVcHFyNHhpWFRDTmh1anFORm9VNGdYUGtkOFRFVm9XcUxYZUlFd0VMY1ZU?=
 =?utf-8?B?U2NCNEJmc0hEMmZjQmE2bUZ4WERabmdOK0E4YVF6NnQwdnpTRVM0dXl0NllZ?=
 =?utf-8?B?UElCc0h3MnBRdEYwZStFRW1rdXdsWlE2R0xLcERmUUlpZkd0WUlWeVJ0a0tw?=
 =?utf-8?B?ZCtiUTRtZ3M2QkJ3YkxRUmFtUnE0L05aUUpYa1c0UmNRQ2cwOHp3RjRDSE1D?=
 =?utf-8?B?S1FTRVYrR25qdkthVTJ0ckdpR04yWXJFZUhIUDRuaWVrYVZHN0NZc2VMRmpj?=
 =?utf-8?B?L2NMRWpTYzJQMTJJQnN2SDk5aWtiQ0h5ZzZ1cm5GSVpObVpDbXYwM3VuOEcv?=
 =?utf-8?B?amdQdVdmY2NGVWlZZmk2aFBqOGZXYkdwblNXZTAzeWNTamIvSGVOZEtiTnU0?=
 =?utf-8?B?Y2UvcHF6MmlNYjJ3dHBOaU9ycGpYNXVVZlJXWlM5cHR5aFZETGJtdEUrRDZK?=
 =?utf-8?B?NmhOSHlOb0FNRk5aall2ZVl4VjRrV0I5RGVtQ2pPWEkzb0xKSWR0bUswTTJQ?=
 =?utf-8?B?QUhSY0RXWUZKbkxPZUk4UFJIR3pDSFpIanQ5VmVTWHVZdG9NVmtkUVBZUGFT?=
 =?utf-8?B?bFVVWXNYZGVOUE5iNGtVMzZKdVpxSVk4M0dWWWdQQXV2bGcwaGc1OGsrdjZQ?=
 =?utf-8?B?UVZWRU0rdGdoelBQRWhuWEpBQXlRUndxS2VnQ0hsd1MyOUdBdXdJRVVGMG1q?=
 =?utf-8?B?b01VOThERU5IQTltRWs0NEZ6Vmg0L0JwOXU4UERYOHdRMGZBSjl5VVFsajU0?=
 =?utf-8?B?R0lSUGNBbE51NzRib01HQTdTaHBtZGNxaTBGN2haYVNPRmV2ZWtGbjhnSmlz?=
 =?utf-8?B?OXYwSVVPMEJWK1gvNUIxNXpWWkhMV0llMElheVFyZUFwdGdZN2VBd0pjdUlR?=
 =?utf-8?B?cXpBam9JODlzdlJIQVBqNFoyOHdvcmVFWHJnRklrcnMwUnc4QWxrRWwxSExX?=
 =?utf-8?B?c0VXOVJGRW1kV2FIUDYyQjF5NlJrK2ZXTXN4RmlPcjRDcFpGRUF4bnZuNXZt?=
 =?utf-8?B?ZDEvenZiT1cxK1d1emdRcnNMOC84RS9nSUo2RGYxZTdkL2E1L2RvN2hkUHpo?=
 =?utf-8?B?Wkt2UWhTeGNpMy9BeUJEU0J6THJ5Zkd5OEJSQXhZT04rTklwekROM25UNlRp?=
 =?utf-8?B?OEVYRXR5NTVqZlQ5b1BpdFBpcUFrUFZ2MU9lZm5CQlVlSkpBaGMvb1NjTXlR?=
 =?utf-8?B?MWF1cHoyWnhuUG1EWWNXN2k1bitzQWVaWCtTR1pLdnY3eWExbENLTGhnK3hw?=
 =?utf-8?B?ZmtXNVhPYmdieTBSdVIrVHNVai8ycGtEN2I4TmNZdU50ZDdpM1I3MWl4MHZD?=
 =?utf-8?B?dW1VN2JXS0Z0WjlKNGpQalg2VEFaVGx4dVJjNE5lUGlZdGJ6bmIrdXJveDFn?=
 =?utf-8?B?MzdXSzB4MUNxYkVhZU5YbHp6SVBXdHhyMUp4SkdqbW5MNFhZZFljbCtHemZH?=
 =?utf-8?B?ZnEzZmJ3SmswTDRzOXIwUXY1bGxFRW96Rk5rQ2hUbDUyb2kzWmNqTWpUQXg4?=
 =?utf-8?B?d0ZyWVhlTnZJbFJ1VXYzOUdnMVlsR3Z4c2dxamVYRGwxenFHVHA2aEhLTlBC?=
 =?utf-8?B?YWp6aWFpU2JlZXBTUU45ek1ZeWRVUzk5UEZML2FlSWtIZElqYUNFMVV6TUZ3?=
 =?utf-8?B?MHJrN29rbFM3M296OTFmMmxUeFFsTDQ1Y1ZvNC9GZDBWL0RLdDc3bk1lU0dl?=
 =?utf-8?B?VDJYaTc5QUVkVGMwUndvbzJOcjQ5aVBaUzZBSFRUMzVqbDNIOUFHYittKzl2?=
 =?utf-8?Q?VLiCKatYXTYY7NOONshmzonuo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81160bc9-927c-4973-35a6-08dc1206a587
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 18:04:54.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZPlH5cZDir2p77tGT0CSBPEv6XR+cIWRleWqey8wyV27SKrz/R9cETiv2E9dvbZtBgz2GwhCHzotrQLK1NmmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121



On 1/10/2024 3:42 PM, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Jan 08 2024 at 17:35, Vidya Sagar wrote:
> 
>> While calculating the hwirq number for an MSI interrupt, the higher
>> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
>> number gets truncated because of the shifted value casting to u32. This
>> for example is resulting in same hwirq number for devices 0019:00:00.0
>> and 0039:00:00.0.
>>
>> So, cast the PCI domain number to u64 before left shifting it to
>> calculate hwirq number.
>>
>> Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Added Fixes tag
>>
>>   drivers/pci/msi/irqdomain.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>> index c8be056c248d..cfd84a899c82 100644
>> --- a/drivers/pci/msi/irqdomain.c
>> +++ b/drivers/pci/msi/irqdomain.c
>> @@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>>
>>        return (irq_hw_number_t)desc->msi_index |
>>                pci_dev_id(dev) << 11 |
>> -             (pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
>> +             ((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
> 
> This is not casting to u64. It's casting to unsigned long:
> 
>    typedef unsigned long irq_hw_number_t;
> 
> So this works only correctly on 64bit. On 32bit kernels unsigned long is
> still 32bit. It's probably arguable that the 32bit case is not a
> problem, but the changelog and the change do not match. This needs a
> proper explanation why we don't care about this on 32bit.
Agree that the change and the commit message do not match.
I'll update the commit message to use 'irq_hw_number_t' instead of u64.

Thanks,
Vidya Sagar

> 
> Thanks,
> 
>          tglx

