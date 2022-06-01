Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C264053B0B2
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 02:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiFAXrs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 19:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiFAXrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 19:47:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E3258733;
        Wed,  1 Jun 2022 16:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA9NLYFHfzCubyDbP89iwLr17+R0WndG3oGeYp+HXKn4Mgrjv+Kwi0Pplt0KeYfTYoakNO7aquuw+/wJ7MQmTz+DU89uonF0E8/+Bky/VhCE6HgHiolb9MkZTauUAvEHRR0CU9Qetzqwc+FYnZT27fFhvEUmknFBV7iJ7l1Rh5Ldu/DjTzvl4/cwB9YmOlaoYBIPs1mdnSFxO27ghPA9Tw3AlBryG7NWe4cMjAP3sKeTlvbSeBZb9UVPtcoNlIubUYCqzbnVPpGgiFSZ7PtMQqIhGxICtTjSIli7SnuzWr6uR3zvTtluNjVyE0sngT+WToHmfdru/vFU7f58OjrzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD5veInMlUhA85KNRlYeUco2NbcQpukjB5BsHp+fL4A=;
 b=bjrKypzxAZe3F2e7/HkwrJMyHbrRogRbPUDu4gKhAp9N3+G1N6FkFJs2EyUSi00AA6W5YYZONEsAxKPJWsKKRMniWq1KQrAKxSsS+1fgK3YjybukkIBbKtiHu0TM0VgRYW2fgCGO9IZqM//vyplllpLWkPejBsNazGGmW+Obs6maEmr+S57+isRjVCZlEuZf7V1Fz2dKZIfrkgxsgrPrgfhapiwr4MRbwCFaATJrHmP6xwg0Ky38ZKiboP8jfiL7vu06ST4Gh6gYV1TbmmmDE6iPkndshqupyongq25Q2801P2vqBwe24SjZ8DZSeOIT2UPscPTt7jVcEAOHMxLkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD5veInMlUhA85KNRlYeUco2NbcQpukjB5BsHp+fL4A=;
 b=Wnp1ouaMiECVJsNK8czdaBfqTxlldK91XgRGm/txUZRmkJ1z5Xwk43rnfQFdrCD4rSKtHA+Z/yWF2SMuSmyzvtigX824/bLofXvRO17oF8hwDg2Tb6Zi1CsGYCtjwJdesVckoQNHluTKdVAafXNNF7iFoSfjW/VIc/mjnJASrjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY4PR12MB1880.namprd12.prod.outlook.com (2603:10b6:903:126::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Wed, 1 Jun
 2022 23:47:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3d0f:71a7:3a0f:ac2e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3d0f:71a7:3a0f:ac2e%6]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 23:47:42 +0000
Message-ID: <f09d7f6d-d15b-8343-ed38-3e474c11f2bc@amd.com>
Date:   Wed, 1 Jun 2022 18:47:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] x86/amd_nb: Add AMD Family 19h A0-AF IDs
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        babu.moger@amd.com
References: <20220601223056.GA10215@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220601223056.GA10215@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82216a56-635c-4bb9-9bef-08da44291e79
X-MS-TrafficTypeDiagnostic: CY4PR12MB1880:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1880ADF2FD8A59E38E65835EE2DF9@CY4PR12MB1880.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXALiFSyw2KWeUF0iHp9XLLv3zraJNDaEeioN+zMSZFx1aqSFWSpSrx1N9P2gJShVXec1QtP6TGeg5FHa7izNrSmkLPhlI6vOWV81nXX7aM0e541PjNJeUpwgYtbUDhySRuyjx15f2LjykjBoKYXgzM1IJRw4EbAjWEowqhDQUINcPuxAE9czDELK4t6g8i9AVS6eVgzJ3vzuTM6UIwQ143M9+zBTGmQzi8z4fgC5YLzTjGq4nFeUeu+hClcXURCXEywQNGZvj4eLkA+Oti/52C8VaOZ2uuFputTk5/tQoHZZEOaOw53mCbPavJQyUDy3zD6yHkbyP9bCR72X8hbC5o502PgmANgNWqL8ZAoq37hAF9bsNUPPvnMfyOYtEpNrsZc8BuOZ0y56u1gOPh7F9ioP4NUKE/2xwml3y0YTwEvBIIVbBCFAg5vJJ2iht4W18M0Qk8eRVyaqeRWcZEusX61TOEi4FfBBJz40dcIlkOXFhNH6zOXKBnbRcTVJaZBjTsMmB4i6H/nbMVLDzfh/WBtGN+GqrBz+oBqxhiA2TluBiHfFvviCdhqbZev/AdAevMcp2/3Xruo4v765YBEXt075yDQKct/xiR7PdNLKXG2Fza79ktgSAqUKWNrCP/Xj1Ii08H/93BKQDa7tpbMryTHRXFFdXnugiFqy9eI+bDS93wsV8GfnanaXlbsd0Zz+wFPmHYiJJrDaosTx5h/J6Iyj10LDCosXUQtLccBDKEOI7sQ2Llbt6C4gIYDT6wxnp3KWWBb8twI9NX5lf/CdTeXjp9vOmgp3BPQ0R7Y07rOTGvPE37jq7hmjUXFoH5lKpz9H8ZR64PZOgggSJFBXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(86362001)(4326008)(316002)(6916009)(5660300002)(2906002)(31696002)(44832011)(31686004)(66556008)(2616005)(66476007)(66946007)(38100700002)(8676002)(54906003)(186003)(8936002)(508600001)(966005)(36756003)(6486002)(53546011)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUhJS0Ixb0ZKOElGSXJ0WmZybTFOMEdvR0ZyTGZLdDhoaXVJMUpuRjFQUkFI?=
 =?utf-8?B?ZENaenoxSzIzV2xaMSt2T3Uvcm9zUTlxS0hjT285YjBrZHI4aGd5SktBRWQy?=
 =?utf-8?B?K01lMVZJUWRQWHJDYlNzdkFnZ2xhYVVUNmtSYTg5Ry9sR1djbjJ3YXhEbzRN?=
 =?utf-8?B?dnpmNVBRbVZZVEl6cW1yQWdlZFJKNVU4QlRtZzUxWmFuNyt5RG4wZmpTQ29B?=
 =?utf-8?B?K1hvQnB3TEptVW0zMnBXV2RMS2F6MW9KaHlTakNES25xTHdsQVFmb0hkMlUz?=
 =?utf-8?B?V3lCWmtLZTErY3pNSWlyOE5rSlpudkpaK1kwMW9aU2gyYks3bFpZUUIwTzZK?=
 =?utf-8?B?cE9qUzR5TTg1aDB5V3ArTlBGT1ZEdG44ak5XQmoxelpqUnhNQVlsV0NkeHB5?=
 =?utf-8?B?VHZzZVpOOFNlWXJWeUhFdDdNTUl0Z1RSY1JtOE5TWE1EMUdlbEEvbTF5N29h?=
 =?utf-8?B?RDdSbTlRMXVOU3RxSC94ZnJsMkhXWGoyWUhnRjRmajVFa3AvR0RMa0lFeDVN?=
 =?utf-8?B?WFpkbWRyMTRNUDcyLzEzWW9FQkVoUU5RSVE1WTJhUUx2a1I2bi85R3hrZFpG?=
 =?utf-8?B?RkNxWS9QSWd0MmtnaXptSExERVZTNUdHZWJXMit1QS9JNi9tV25HUXdVMkt0?=
 =?utf-8?B?bEhmZ3VDdEp2WEdZLzNaVU1TbE0yS3RxSjBNQzFkZ0Z3YWJLMUx3b0FYZDNJ?=
 =?utf-8?B?V0tCOERyZjJZNUpXb040NzNPRkI5a1RJVzNkbzVIaEdzV01sN2lQRWNLMDhv?=
 =?utf-8?B?d2kxSjdNNDgzSFNvVWJlWkQ1N2t2MEIxbktIeGg0b2hHckxSVWg5SDBzRnFm?=
 =?utf-8?B?RUlqRjA4R1BBMjU5Ty9YWEtUS25qR1RLaHY0aVBHYjhnMy9sN0pZQjNtczdv?=
 =?utf-8?B?L1cwd1ZsaWx0MFRBbVBUb2ljVkZnMFRTVE9HZFNKeXM0bFhuVExPeVNLcXBR?=
 =?utf-8?B?THMydUN6R1FMUVpscXdMUS9nQjdJeFVqajZhY20zdmsxNWp4MW1XYXB0aVlj?=
 =?utf-8?B?VDA0Q1JwT1ZoYW9Za0pHUm13Qmp5TUJJVmpGVzRVYzNNRDl6Ris5WTRhL0Fa?=
 =?utf-8?B?OURMK05Hay9jbDcvT2Mwd2E3K1VUWnhRQnpWczJJdkNMN3ZsOXRDeWpDeWZ1?=
 =?utf-8?B?VmRlN3hzZVpoN1ZDYStWRkllUmg0YzV4MUErVk9Ba0J0Z21QdzEreHlpWklZ?=
 =?utf-8?B?R2xtdGtCYTNoNEh2UldHa0FBbEtuTnRPaTIrZ1hpRk1yVlF0N3FlZ0JuNzQ0?=
 =?utf-8?B?NEtPOW1sNExVUUhFS244T1VaVllmb1BuY3dXS1VRaE1TRkRQNUViTVJDT1FR?=
 =?utf-8?B?Y053VUE5cVM2N2xyNjVnZVByVXNvbGJwVG95NmRKcUlwK3ZvNVpYU1FmSEZE?=
 =?utf-8?B?cUF5VXgyeFlPSFoxWXkyeXNhTVgwdXM1dTdvMkFFQ3FheXpEem5zU2o1VE1F?=
 =?utf-8?B?UGwvNE1pREp3S0Q5OStvVlVOc0I5WUFrTXBZaHV4WG5CaTZxNlpacHNWQUhn?=
 =?utf-8?B?dExSclR1NnRYa2pHNmJXLzB4c2pQS1FGQktVMVFQTVFpenZKbzAxRk44MVJK?=
 =?utf-8?B?amNvaXF2S2pSTWRoSUN0VE1KVkR2K05vM09xeE9JME5sT1ZOM2M2bWlyRnRz?=
 =?utf-8?B?N3oxWUpKRjZkUEhHUjJLSkpheEU5RnQ0UnA1bHNNL0diWlZkMjNSdHNSSHgw?=
 =?utf-8?B?L2EvMzJNM2pDQldqOVh4Yk9IRWVCQmpuakxqbDNRaHJ3bWlUUkZVMk1wODNs?=
 =?utf-8?B?RFdHK2V3NkpuRGxqV2ZnTzJiNFNmZ2xSREdoZFBvVmJCNjFXUEl1aTJITUFh?=
 =?utf-8?B?S1ZPQndmVEZwcjNLQmFBanVEYWFnb29wQW5EV0YvbTdEdmFRcmlBVjd6T1ZG?=
 =?utf-8?B?d2VFVkdsZlNuYW04ZENxdUhoT0EzWWJaaU5YSnEveTV5cjRoR3E3cWdCVVBE?=
 =?utf-8?B?RzJBVGJaWkkyTTZqYm90eW5OSEZrcVdDUzhCVThZZnA1ajhZRnY3OXpLVmF1?=
 =?utf-8?B?SzBEWE1lM01lZDZNaEdLK3htRGprdzBMZk1NRU9Bamo1VXlROVdsWGFDeS9L?=
 =?utf-8?B?WVUzd2RnVGxLc0hXUG9zY0tvVmlBUXRtN1k4Q2hTRzNYWGt5RXJyd3dpZWJr?=
 =?utf-8?B?SVBPcUFQTE1ieXRvS0JQdGVERWJMbUZ4OWlGQ25vZUxWMTRIT3JtL1RHVGhS?=
 =?utf-8?B?d0tKcUxuQUptWnhScGFpbzZXKytRNWx5U2h5NnliTlhxV1UvZUVlaHhzQ0lY?=
 =?utf-8?B?OHlDbVBWODE5d2EzSjlIQ0V0ZTFZL1dPL0wyajc4blFuMUZHVEFrKzFWQzJL?=
 =?utf-8?B?Q3IxMVY3THV1UnZKQ2FJdzBSKzNEVjUxRzZCSHJBdlRkclk1eXlvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82216a56-635c-4bb9-9bef-08da44291e79
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 23:47:42.5105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71V9g3Xo6z5nvox65c5W4kbEJ33Nt3uC/8w6bQu1PzTSmai5wtQTrAdI2dZfgxh3XyQQkcxQMQ6Q84HbEIocxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1880
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/1/22 17:30, Bjorn Helgaas wrote:
> On Wed, Jun 01, 2022 at 12:21:18PM -0500, Mario Limonciello wrote:
>> commit 4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh)
>> and (A0h-AFh) PCI IDs") had claimed to add the IDs for models A0h-AFh,
>> but it appears to only have added the models 10h-1Fh.
>>
>> Add the actual IDs for A0-AF which are needed for SMN communication to
>> work properly in amd_nb.
>>
>> Fixes: 4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/amd_nb.c | 5 +++++
>>   include/linux/pci_ids.h  | 1 +
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index 190e0f763375..cc8c7cfa9068 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -25,11 +25,13 @@
>>   #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
>>   #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>>   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>> +#define PCI_DEVICE_ID_AMD_19H_MA0H_ROOT	0x14b5
>>   #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>>   #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
>>   #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>>   #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>>   #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>> +#define PCI_DEVICE_ID_AMD_19H_MA0H_DF_F4 0x1728
>>   
>>   /* Protect the PCI config register pairs used for SMN. */
>>   static DEFINE_MUTEX(smn_mutex);
>> @@ -43,6 +45,7 @@ static const struct pci_device_id amd_root_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_ROOT) },
>>   	{}
>>   };
>>   
>> @@ -67,6 +70,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3) },
>>   	{}
>>   };
>>   
>> @@ -85,6 +89,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>>   	{}
>>   };
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 0178823ce8c2..05b4c67a8a2a 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -560,6 +560,7 @@
>>   #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>>   #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>>   #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>> +#define PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3 0x1727
> 
> This file is nominally sorted by numeric device ID inside the vendor
> section, but that has really deteriorated over time.

It seemed like it was more oriented to be sorted by the macro definition 
than the ID.

> 
> I can't quite figure out the rationale for deciding whether to put
> things in amd_nb.c vs pci_ids.h.  The IDs in amd_nb.c look basically
> the same as this one.
> 
> Normally we put things in pci_ids.h if they are used more than one
> place.  PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3 looks like it's only used in
> one place.

I suppose you weren't on CC for patch 2/2 in this series (thanks 
scripts/get_maintainer.pl), so it's not obvious to you that this ID is 
used in a second place in patch 2.  I didn't want to ping pong in/out 
from amd_nb.c in the series.

Here is a lore link to it:
https://lore.kernel.org/linux-kernel/20220601172121.18612-2-mario.limonciello@amd.com/

> 
>>   #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>>   #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>>   #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
>> -- 
>> 2.34.1
>>

