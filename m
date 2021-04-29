Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2155236EE3B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhD2QeU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 12:34:20 -0400
Received: from mail-dm3nam07on2053.outbound.protection.outlook.com ([40.107.95.53]:29249
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233480AbhD2QeT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 12:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6CsbRA5/clka/7dlPv6H3L/gaLUw1k9whs1ZOV9iNGKUueuZoiuz+rYxPgBUr7/0/D6YPzRcM2NwFKFP8PZuPat4HVsUnVoVFlSTnEnnCYgNix4zsVuva6E8BlwiLXrzC8KckVJmLlZ+shMeDRcrpcswgDBNi36YYwWpV03Zn8Vkz8whn0slhDS604U5XMK7x8G9MQDJQus8ELBZQvdG8ZXHbfqXEUUrnc+rqhljzgjSLSj1KjrTOz4foiTGZ7dadVnLFQHsL3B4ClKDXiX+X6aqhx7h1hX9P7J7pJJHpKW3JjR0jFtht85uqz32bsdR6msD1MHQL/xR6pzg77T0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8La800WhmAt5/yTgCs0eFMzs558yxsQAn8FaEOsRkY=;
 b=ewGtU7Foao2SoGoDC62OuHwuGMIYohEHrVWUQbeSNbyqbMSAUCK6AeIHFsw0V4nLGHVrcVWNj1tqSPzUknUmmebw/bT1C/PGYmIWPnOeSMbey4jXXge38DeBgKY5tfKBK+am/bjWTxGC/VFUuvgdMicKDhC6ZYcEahnv6e3WoTN39MSy2OSIAnhqhRUpwz/EXew8NlX7ssYuhaWB71L3gYmlZPne7BpCdX9mxynKfGjVBC6mZGDE6IqEfW4sYQipFaxJEiNE//Z9XpiYqNplFA5ALzk51uRomoQfG6emavwT7pJ6dSgxQ2mWdZBqKTeZsWWbyOohDXq0UkN71eySIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8La800WhmAt5/yTgCs0eFMzs558yxsQAn8FaEOsRkY=;
 b=GjKtPo+Gx5ChEbzWMSAuGpRWNe1cpH0FkNhPQk/JOQiE3hmjzUJSf719MKs1DQOTXTDwFhMMuUV3h3qbVOoscx0Br5Ll8VirK81RzPwx6tr1VhIaYWGDwR8mzB28zw1VLB7mnIFUXERCRzmgTlTWfFomYaZX52ryMKQnvFKcaiE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 16:33:31 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Thu, 29 Apr 2021
 16:33:31 +0000
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs with
 drm_dev_enter/exit
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com,
        ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
 <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local> <YIqZZW9iFyGCyOmU@phenom.ffwll.local>
 <95935e46-408b-4fee-a7b4-691e9db4f455@amd.com>
 <e760ada9-b4a7-c6ab-18f7-0bcc1b5442c2@amd.com>
 <a0cfd25b-f9fd-5788-d2d8-331b69102622@amd.com>
 <9c91bdae-d78c-202b-8b58-6977929f1273@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <6d56684c-1964-f023-7d23-f0e5042941c5@amd.com>
Date:   Thu, 29 Apr 2021 12:33:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <9c91bdae-d78c-202b-8b58-6977929f1273@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:497:888:9bb9:54f1]
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:497:888:9bb9:54f1] (2607:fea8:3edf:49b0:497:888:9bb9:54f1) by YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24 via Frontend Transport; Thu, 29 Apr 2021 16:33:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26535897-138e-4bf4-906a-08d90b2c869f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44161B9095CAB7DF387D2ABEEA5F9@SA0PR12MB4416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMIXMsVwMC4W9vugMd2aXYIQZSkuF2lWAEBQOk4b+29ep8vSMCvfpJXyjr0f15UYq6GFDOrHMp6aVsEOX2nI5kV44zPqsuLsTyDDtoUKHB21RGU7aJAliIFWjgzOrn4TXcP1ROCyLdnN+Ramv0uEOJR7vEQa6nEtWqVfgKNwS3H4T/fwAC69L+/6gjgK1Y6RIPJ2kQdgtUNFZ+mh0DZ2+J+IWtTQamrFBowiyEvxx+NgFR8jq2rMPuzi6UqqCjFtWtdIpci/Nzo6isIkojQQLSV6V/4ZBwc4vwRx6BAGf5K7xg2L1QVDWQzCJwHQPSW/8VNM20Y3cQ1FnRX/9mAsze6XFc7RhjUCE4ZXuD0FujwgKNnOrVaGhxUtlAmprTbXbpmIrJ62O3a/PfEto8XYOhPdPGG+73dmuJgWfCPwf7MgSkJm64t2QXqikIdwdVoA/2i5u3WfZ36/3zO6Kynx3ljOMXHZJjLix27QPVKawoOCxSTBNhJBZATBwpkIJYgR5PlJdzCuvERho1VSX4D/mmOg22KGZbGNIPhtKV+zyb2VGFTBqIwoWIj3dtYoFfbsxGOltp6vVd5PrZ4HvDdHdpLNvLRMIyrW/K70Ms9fVrxrBnUW7gXOiWroYwpptdG74Eg5g1Cufq6edHTgoi0ltZhyi4AZ9DRL5TMM6aX3pQ1RvuTnvWYTHZBsdbP4XXuEmuNarH+AdJUNY0R7sYvEpwJmuseG2OHFgnVVWeBi/4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(2906002)(38100700002)(478600001)(36756003)(53546011)(966005)(5660300002)(2616005)(52116002)(44832011)(8936002)(66946007)(110136005)(4326008)(66556008)(86362001)(31686004)(31696002)(66476007)(316002)(8676002)(6486002)(186003)(83380400001)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cUpQc0J2NTZta0hQMzRkbHV3Skt5VGJxUXBvRkFVa1NKbHRMeDQvR3JraC85?=
 =?utf-8?B?RXc1R3VsZXJCYWhxdmt0QVIrTFhLYlRmUzBBZUc1V3FTbUdIeXMwY2dwNGJF?=
 =?utf-8?B?YmF5aGZ4aXhtd1V2T2t1aTlGVGRnMG5lNE5ZVjFIdHJwb2lJYUM0R2ZVUWFo?=
 =?utf-8?B?ZzRiNC9oWkJBdXBJQmVLNzI0Zjg3Z0dUMFQzcStZUHZmMVkrN0FPNXV0R2F4?=
 =?utf-8?B?dHVLUVdGaDFvcjdiNDF3VDlSbmFVaG9oU2xpNW9xeGhTWk5nNTNtYy9VVXh3?=
 =?utf-8?B?bmc1V242RTYvTEVVd3M2VE1RY3BKNlNTNHVSMUwwWHRmZlhkRkVMdTBGYmJR?=
 =?utf-8?B?cjFodFc4Rlg1eGc0QnNYdVRHMWN6MWdEVi8wNGVUVkFHZFFidXZXN3ViZkdn?=
 =?utf-8?B?anRVUzBia2x3cWZlMFM1cWQrL2t5L1F4elRnOHhYczREcEhaNlU2cVM4OC8w?=
 =?utf-8?B?d2UvdXZibWNMOW9sZUltVi9FNHdDa3BEYnVOQnNFbzAxSmVmbVE1QlNPdE5G?=
 =?utf-8?B?Rm5IQ2ZVSkdMWklnME9Ia0pDWEFQNWhUTW1jS0VkeUVHZnVsblhuM29wQThv?=
 =?utf-8?B?N0Fjcm5XQWZ4QUJKU05oVk0xMXNkVm9PVXZIQjd1TFQ4TFF3TGxBWkt0NTRy?=
 =?utf-8?B?bHJ4WmVnU2k5SXhkUzQ5enVuMHVIYVF4cGMyUkNNdzlCSnNRdXpKZldtdWxi?=
 =?utf-8?B?WnV4c0J0bXE4RVhqb25vOGdhcXBnRHVEZmx1aXNNSEEzS0JGSk9Ub3RxNnlm?=
 =?utf-8?B?WG9OdjlYUmtGNnBaMkNsUFcwcy9hcDhJSFdKQkJlUHV1WXo0eFBKRTRnUzNy?=
 =?utf-8?B?NkY4L1Z1NTE4eHM1aGh1RDhpT2pIYTRHaVRPNC9sMXNvRUtpZVMwb0lOTDV6?=
 =?utf-8?B?SHg2d0FtaXMxai9ObUU3V0ZaOWlWWXVoWk5adzFBV0o5Qkl5c2p2WEgyVkxr?=
 =?utf-8?B?V1dXZmdzeCt4VHUrVm5oVm9aL3paUDl1clVKdHdMOVhTdmRBT3hmcVA1Ujlw?=
 =?utf-8?B?VzdqRktlVXZrN2V3ZlZaN0NaVy82a2RYaXpKUGlrT0R6bUl4VkFzdmVhTHRx?=
 =?utf-8?B?Qm05eVZ5S1d2dXNwUjFRbmYwUmlnZExRQ09xeks1enFYVUhXVWYxbVp3ZzlP?=
 =?utf-8?B?TGlqVVV1TlVkR2JjcldQemFaTDNHYndhRlhwS2F2QzNPWVgwMU43bWdDK0p6?=
 =?utf-8?B?eTNzNElBU2tOSkVjQnkwQjdDQkswZmNFQkRwMlN6TXdwQjQ2T2k0QlVCdHVr?=
 =?utf-8?B?cHN0cFlYdzVoN1o3TFNQQ1VJaWoza2dTUm1GOUp6SEpaYkRTR3FoWERjcWtw?=
 =?utf-8?B?SUEzVDBnZ0p3SzZwK1BuOTJTWnliTEpMNmhJQUNkTHhteDhjYk95TUw2NWdG?=
 =?utf-8?B?SmFLSWFjUDhHUW5BM2phZ25GTWJPVmZEdHRsYlVuWUR1QWxtMFNmTzFleXhx?=
 =?utf-8?B?cXRLQ0lmRkVwb2NkSHZqUFRWaXUwTmRRQ0JEYkh0T2JoOWVDaXRQTVhQZUpK?=
 =?utf-8?B?OG92cFZINlI2TUdsME9YdXUxRGMxUDN2QWFGQnV6eU5XMzZkZ29aOXM3WE03?=
 =?utf-8?B?MEpaaWhhYnNnL1NjMVZvcDZHY1kwZE5hYXpIclRHSUUxWnNDaHRhU1dIM0lG?=
 =?utf-8?B?bXcva1lnS0grNDhXbWJWekpjYXN2Vy9FWGJGWjZvMmZYSldGSGpLL0pnRTZl?=
 =?utf-8?B?NDRoR29WaUJXaDJlQVlaaHZLcko1akVTeXl5NGlhWGRLSEZKUWwrVUVBNzRi?=
 =?utf-8?B?cHU3N1QxYnNZWC9qczFWOG52bTE2elRRRy9VRS9qVUFwNUF0UG9ITkJFWHZ1?=
 =?utf-8?B?aWhPSWJ3TGtlWUZUQlp5QSs1cjFrSFJMcytZZVFuVE1NU3YxZlo3MTRGSmsx?=
 =?utf-8?Q?PiAFoCHIl+lXN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26535897-138e-4bf4-906a-08d90b2c869f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 16:33:31.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAzxuMPN0Xv/dPnEBfGHo0zUwf4wCg1VAl2QerljTCgv3W9srJ/Wu1zdTz05pI5Q/xAuIstm6RRUUzJSWBKJLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-29 12:29 p.m., Felix Kuehling wrote:
> Am 2021-04-29 um 12:21 p.m. schrieb Andrey Grodzovsky:
>>
>>
>> On 2021-04-29 12:15 p.m., Felix Kuehling wrote:
>>> Am 2021-04-29 um 12:04 p.m. schrieb Andrey Grodzovsky:
>>>> So as I understand your preferred approach is that I scope any
>>>> back_end, HW specific function with drm_dev_enter/exit because that
>>>> where MMIO
>>>> access takes place. But besides explicit MMIO access thorough
>>>> register accessors in the HW back-end there is also indirect MMIO
>>>> access
>>>> taking place throughout the code in the driver because of various VRAM
>>>> BOs which provide CPU access to VRAM through the VRAM BAR. This kind of
>>>> access is spread all over in the driver and even in mid-layers such as
>>>> TTM and not limited to HW back-end functions. It means it's much harder
>>>> to spot such places to surgically scope them with drm_dev_enter/exit
>>>> and
>>>> also that any new such code introduced will immediately break hot
>>>> unplug
>>>> because the developers can't be expected to remember making their code
>>>> robust to this specific use case. That why when we discussed internally
>>>> what approach to take to protecting code with drm_dev_enter/exit we
>>>> opted for using the widest available scope.
>>>
>>> VRAM can also be mapped in user mode. Is there anything preventing user
>>> mode from accessing the memory after unplug? I guess the best you could
>>> do is unmap it from the CPU page table and let the application segfault
>>> on the next access. Or replace the mapping with a dummy page in system
>>> memory?
>>
>> We indeed unmap but instead of letting it segfault insert dummy page on
>> the next page fault. See here
>> https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=drm-misc-next&id=6dde3330ffa450e2e6da4d19e2fd0bb94b66b6ce
>> And I am aware that this doesn't take care of KFD user mapping.
>> As you know, we had some discussions with you on this topic and it's on
>> my TODO list to follow up on this to solve it for KFD too.
> 
> ROCm user mode maps VRAM BOs using render nodes. So I'd expect
> ttm_bo_vm_dummy_page to work for KFD as well.
> 
> I guess we'd need something special for KFD's doorbell and MMIO (HDP
> flush) mappings. Was that the discussion about the file address space?

Yes

Andrey

> 
> Regards,
>    Felix
> 
> 
>>
>> Andrey
>>
>>>
>>> Regards,
>>>     Felix
>>>
>>>
>>>>
>>>> Andrey
