Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED86339162
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCLPez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 10:34:55 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:33271
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232182AbhCLPei (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 10:34:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ4i8/i1vVYsgPQiVK2MO3S0sF9f5YNLRKFuXOCUpth5XSX0Oj4YkwfJbsAiPAtzO2KzNRzDwMYcspPIg0AlvbjfcBsUoXkx9e/OFAU6qg1ae77bORIcX5R2y0FLpw+UYpUE3aEWiUlFNprEZeGRRYe25dEheI3RRNsAKRXXBgrj23zbvns/LIyTvIBnvNahDZdaRLmIrAX1qMLzqzybfgoOAPhW32M7is+C70YeySUFkv1BWwrT+bznpgezsi3dyEHvTu1ZbLh9OUODrXc4C/Y1FUANSvQZgj9poZ860X9BqY3quGi1e1FOSj7ak4sRTxI7CfuDEwfiJorWhZE6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTTEUQ3Jq7BwoQQlSpSbKUp3M2X2n5UdKH396qIGr4w=;
 b=L+/FR5+adl0mnq5ZoAP2386BLKRejEQPCKGSzsNt+vsQ1SHmx5wkObLA5VimRJqvTF0mGQquhdGQdQ2czrFoP7a7/WGXtpAZdmXrqq2j4DnqtfGdrQs1l4eU0UpcdHjMjw9yxTN6JXECAXX1mmNPLA0Nx4mGorievPmgrFLA2Mg5rI5Lou9vm0yPklVauDJQcQIuxQjsiX/OQlcPTJtixZOkXu7n2b8/ndzNgOgpzlcI3/TSzf9WOCPl9p3UqV1U2OuTa9R4NH8XAiF7AbWW4nK81gjxXYYLd9c0sRV5AwEhncK6qmvwEksyDzqAJ36bWSXQ+8gFk6Z1KywE1xrOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTTEUQ3Jq7BwoQQlSpSbKUp3M2X2n5UdKH396qIGr4w=;
 b=VEHfaEZtsWngexwT2tfPa8i+1ihj2FxNKkwfF4nzURdno9th6utk6m9VIUTFeLxmkbqVS4BZn2XatgSvpxRIPA7EJZEMIiypAjoFi39S6BK/RuYirS4/DHQeS4ohZh6YTLvKRt9mPQYrTsWlbcYHFcaSUsSNPS460YeC4IgYB1Y=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2351.namprd12.prod.outlook.com (2603:10b6:802:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 15:34:37 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 15:34:37 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
 <7d9e947648ce47a4ba8d223cdec08197@yadro.com>
 <c82919f3-5296-cd0a-0b8f-c33614ca3ea9@amd.com>
 <340062dba82b813b311b2c78022d2d3d0e6f414d.camel@yadro.com>
 <927d7fbe-756f-a4f1-44cd-c68aecd906d7@amd.com>
 <dc2de228b92c4e27819c7681f650e1e5@yadro.com>
 <a6af29ed-179a-7619-3dde-474542c180f4@amd.com>
 <8f53f1403f0c4121885398487bbfa241@yadro.com>
 <fc2ea091-8470-9501-242d-8d82714adecb@amd.com>
 <50afd1079dbabeba36fd35fdef84e6e15470ef45.camel@yadro.com>
 <c53c23b5-dd37-44f1-dffd-ff9699018a82@amd.com>
 <8d7e2d7b7982d8d78c0ecaa74b9d40ace4db8453.camel@yadro.com>
 <f5a9bc49-3708-a4af-fff1-6822b49732c0@amd.com>
 <1647946cb73ae390b40a593bb021699308bab33e.camel@yadro.com>
 <3873f1ee-1cec-1740-4238-a154dd670d62@amd.com>
 <98ac52f982409e22fbd6e6659e2724f9b1f2fafd.camel@yadro.com>
 <146844cc-e2d9-aade-8223-db41b37853c5@amd.com>
 <e3f3de55-8011-77d8-25ac-f16f8256beff@amd.com>
 <1f5add8b-9b2d-8efd-02d8-ee8ab33c070a@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <f3f74ff6-f7cf-5567-6af4-cfb0e2769cc9@amd.com>
Date:   Fri, 12 Mar 2021 10:34:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <1f5add8b-9b2d-8efd-02d8-ee8ab33c070a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:8dc6:261f:a3f0:6b7e]
X-ClientProxiedBy: YTOPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::32) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:8dc6:261f:a3f0:6b7e] (2607:fea8:3edf:49b0:8dc6:261f:a3f0:6b7e) by YTOPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 15:34:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8eea07bd-3912-4a59-f431-08d8e56c57f8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB235106E07A2A2D690BFC9B8EEA6F9@SN1PR12MB2351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b21Sb8x+DdHzj7gINMxnJpbP3OgqCwZmSM7pOIds1RkfxCJgrPdwvjnwMliTjeBXS7W8/Z835FbgzJ0aEWSfPc60cxAfYqUMB0fcinVbBcVUX/Zj6pWuBo/MjOjWpMsHqIw73X3a4DJcDWEDEQIql2Z5XoqPIT+AUOu3uClF7TrKZGVjEx3vsxQ6WxhssBanyWR3Z6uUvTuUHOaDMzjL3jI4VYnKhYLXRDMdGHql+B4Og6DiOWL4F7tHBrxEWXDVQmr16zuqgGgYWjoyj6VCk57TW/PfVtVpWOGRL5HgDbA/jKUChF/6YfvgxkJuF+ZfQVSdAG5ozdQCPB/sZGQ9XesjA+MqgcdoS6W7+XKnYIcQAIuELEXBeUJ1V70VFu2NIhdiMrsvE79gFRGQu81u8oNaONfAE16vAOfJdoqQ+p9+AYEDTo1p4XXOBSQh6ORVkcG6CVd7Z/BPdNfYd/mhGzsU+IEDucQctZpa+tBew/q19+E2Fp4j9q48keUuv41VVLAEJkz7xBAc4gAuHLcOOFq0bnsAdrGvhxB548k8PGBCwqUGYq/QZi8SrBwu2iQQLrD6qFyZ+cV2mVN2emn2CzuBI6mTGH5Y8ck1I5QUK8YVVmI8k1Q9WHKKhlbx7h6DJIP2ZEIrBk/oIPtu/3AjfQAGnQnP/OFXbC2w4T3PO9G/6mScEpQ1RTkYW3/6No3B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(86362001)(31696002)(5660300002)(66574015)(54906003)(66476007)(66556008)(110136005)(66946007)(8936002)(2906002)(8676002)(53546011)(36756003)(52116002)(31686004)(83380400001)(6486002)(4326008)(966005)(44832011)(2616005)(186003)(16526019)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MFRXajYxenBoYVRMQ3dxekI3S2F6ZWtuSmQ2MVl2MHJWZ1Q4T3o0ZHcyWE9Y?=
 =?utf-8?B?eUxVM0poam9KVkZzbEZ4YVJTYWNDMnRvMXluNzR4bHFsUVVLL1BaaitzdUd3?=
 =?utf-8?B?cEV1RDVtNVYzLzRpWmZNLzhrTENpbUErUFhGa2YvNGd2bGdMd2ZkRTV1OEFw?=
 =?utf-8?B?TGU0NGlZT3JBYTlROFRWL01HQmhlcWJHdEJpRHAzb2JDaExLQk8yUUNxYXBF?=
 =?utf-8?B?Snl3aFBJakRDcndGRnpXYnVFSTlEUUdQTGlrQ3RCNVBLbDZHbEdDbFZyeUtk?=
 =?utf-8?B?QSt2YmVQMUJvRXlGV21aN05kdlVRUnRWeEk1Zko2VFR5ZVNlRTdYL0hTZFhS?=
 =?utf-8?B?ZURscDd5eXBFYkx1YW9vQWlOTzdGdlFUQlpKUGpQNGJISmphTEpSc2ljcDVN?=
 =?utf-8?B?SlgwWWRVNWd3cHhkNVp4WDhhbHBKZ2dlTkF0TDJCZk5pTzJRTk5qdVR0QTEy?=
 =?utf-8?B?aUdKR2RoY3dIWGorTGZZNGxNN1dpNm82bWs3Q0JaYUJOandId0pJNGhJMEd1?=
 =?utf-8?B?R2ZYYUM3RXNGTWtEbDV2NENzLzV6ZjJSTFVtZE9UYzBMelFvNlZ5MVVTb2R1?=
 =?utf-8?B?R0RSME0vV0I2S0NlUmNCbldZcDBlZFVqWWRqTC9ad0IrMSt0RHlWaHpjSGd5?=
 =?utf-8?B?V2RSNEhJeG85aWs2ZjQwVzByUFd2dDIyRWsyMXd2WXR0MklIOUpNZFluTG5U?=
 =?utf-8?B?dHN3TjBreUdaQ2pxTGxDeUxUalF2czNLU0prNlpLUVdJYm5CZmZacEFRWjNM?=
 =?utf-8?B?Vm5FczhESzRsYW1zM1VPam5Oa1JRTlg3V1czY05zQnVIeXVUb3cvN0RIUU9o?=
 =?utf-8?B?YmpNeitaRVF1WkFQaFlHUVo4ODY4VXBBTUpNQnJMUnVDbG13alVYdmU1Q3RN?=
 =?utf-8?B?RkM2N3F3elNaekVUMjAzSjZBSDBHVkVJZVJGN0Vkd1NwMVA1ckFxNElwbXZG?=
 =?utf-8?B?Nnc0MTM3a2lHaXNmWlJSZ0QyTE1wR2xmckRLZHNrbG9lK0JvT1BnSTJEak1E?=
 =?utf-8?B?KytJTElIcWpPeFJ6b1Q3eVp1WGhKcm96TStMZkVGeFBSaTRKQkhTNzVTTXR5?=
 =?utf-8?B?d1llQ0lJVFNER2lPZlp3TWU2SWI0T0lYVkU1U2VEeWJubTIrajlkaFAxOUJD?=
 =?utf-8?B?cC9yRm94VlhvRVhPSVp0cDRQZDVaOGhGTVBHN0hnYXlGbEl4SW1nVjFkNVVp?=
 =?utf-8?B?Uk53enNaYjlGQlFQNk5Zc0R3ejFHc3VGM0t0aFJvcEp5cG9Cc2I3WnNNbWtv?=
 =?utf-8?B?WFFiUlBRbHJGdGNNZ0ptNlVFNWduRE9JY3NzcDVialBqTDFCQ1dOR28zcVZC?=
 =?utf-8?B?UjRLRUhHYzJlYlB1ZUtFU043Y213RmRtTlV5ME84MHMxakc2VTZtSHFSTW9a?=
 =?utf-8?B?WnUrMks2RE1ra1RvcTYvcmJ6ODR0N1ZFQmsxN1VLZU1qUUJ0S0NpVENVQ2NZ?=
 =?utf-8?B?RHB6alB4NjFTU0RtQmpreUc0OHVYenplNUNpK3R3VE0xMFRwdG9HYW04Q1Nj?=
 =?utf-8?B?SVhBczZxZTRhRk9xTVg0SDdnb01SZkt6Sk9Gbkdua2RYbUt5WHF4bTZYOXJR?=
 =?utf-8?B?NHZBMFNoczRIekM0eTl0NENlSUFXbHNDTU12ZnlZVStiT3VmdUxaT0puYXlC?=
 =?utf-8?B?TC9VYkFOdmJVZXRrSmZkenVUMnZWUzhFQnlud2FnREhLT0VGWmdlZGdTL2g4?=
 =?utf-8?B?NlMrTE1oZG8rZkN6Zk8rbHlFN2xaellZYUlpY0xvUXJRVnZHRU1SQTNjVnVH?=
 =?utf-8?B?d0JtdVowem5KZzJqRkRPN2d5bzFrU2hhZkRIRnA0bDBENTh3RTZzQW1LaVBT?=
 =?utf-8?B?azhxYmJxclE3c1lhejVFSU5rM093UUhBZkRpSEFpU0hNV0pMTDE5Y3htRzBH?=
 =?utf-8?Q?wHx4bIz5xvKPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eea07bd-3912-4a59-f431-08d8e56c57f8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 15:34:37.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nx5q6gY6yFjgImDihWNq600pgZ0L5B4UOQPUJ2ekDkzyoupbzRVXs0vAaO3a21r+KHfvjYK/ccuc143q6W0vhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-12 4:03 a.m., Christian König wrote:
> Am 11.03.21 um 23:40 schrieb Andrey Grodzovsky:
>> [SNIP]
>>>> The expected result is they all move closer to the start of PCI address
>>>> space.
>>>>
>>>
>>> Ok, I updated as you described. Also I removed PCI conf command to stop
>>> address decoding and restart later as I noticed PCI core does it itself
>>> when needed.
>>> I tested now also with graphic desktop enabled while submitting
>>> 3d draw commands and seems like under this scenario everything still
>>> works. Again, this all needs to be tested with VRAM BAR move as then
>>> I believe I will see more issues like handling of MMIO mapped VRAM 
>>> objects (like GART table). In case you do have an AMD card you could 
>>> also maybe give it a try. In the meanwhile I will add support to 
>>> ioremapping of those VRAM objects.
>>>
>>> Andrey
>>
>> Just an update, added support for unmaping/remapping of all VRAM
>> objects, both user space mmaped and kernel ioremaped. Seems to work
>> ok but again, without forcing VRAM BAR to move I can't be sure.
>> Alex, Chsristian - take a look when you have some time to give me some
>> initial feedback on the amdgpu side.
>>
>> The code is at 
>> https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1 
>>
> 
> Mhm, that let's userspace busy retry until the BAR movement is done.
> 
> Not sure if that can't live lock somehow.
> 
> Christian.

In my testing it didn't but, I can instead route them to some
global static dummy page while BARs are moving and then when everything
done just invalidate the device address space again and let the
pagefaults fill in valid PFNs again.

Andrey

> 
>>
>> Andrey
> 
