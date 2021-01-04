Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331912E9E77
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 21:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhADUBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 15:01:36 -0500
Received: from mail-eopbgr750057.outbound.protection.outlook.com ([40.107.75.57]:4002
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbhADUBf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 15:01:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqMdtX3UdqQr4VQHjKiSO6IIHnYtOyCDuHCzzYxHBLUEe5wWOjOAc6xCcYe7vfmp7eTIVCMWj1yKl96hsr9SjnQc7Ud+6tsYJb6OmH57TwilOiHcOegFKTRaAZkqInxpkNDqFXpfnyFqsh5WIyvN1LxXxxfJflCgYI6uXc1DhBH4y3lSjdyetKz5G41aPNWqFGq4axWaCQON3cgYl0Y3GkbZEuBluNE0LfP83z1495BKSbkj0rXXduGm7QYhE1iwB4SSS/9TklMev6fy6DdfveNOuYf6ft6RWnM9XvHbjxyl6JFyMkR6iQ89ZG1k5TJ6SHjk5QSrKHYUbImLRlNu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HV6BXZTqrgPjnLG9+76jdGMhmFlNXzwvPqrZMlEYFc=;
 b=f7T6dcMhYDpwXNK5SP5ck+ZkSUZZCiwru272/nmweoE5mMTo9SyzU6/eyF7ObBdVGYphQxC7ibOHpFX0Z9zkBPcnLzuAw9jqrGn7oWsYKGGoQaADUzIdnbY9KuvZseBMiLzaZtpxXYbxTR6w7QjZTNFA0HMN8SaoY4IY3h+8QNfc5AaA4foqgumE645lIonJQXtog+asOlYHpciLTMUQHk4sIG1lmC7XOSqaFBmDMejwoW1MeeJ0O68xQoRbHkBgtdfNfrAS7ACShRmqy+qOdcUmbHzrySd0UW8srU4qrtlzxb/jo5b2Gkvd6T4uXqQLFRjEjP6lVAY36S/yZfyIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HV6BXZTqrgPjnLG9+76jdGMhmFlNXzwvPqrZMlEYFc=;
 b=YclvT7qCj/+Xs1b0xWlzWB5MIyruPOz0y67Ka/mp2cVlq0A1njDl9qjc/NAcJp5MS5Kx7D+J4Xr+iD+Vgq/8xCSuD5yXWMdDqy6UVAEIo3cllu5TG7eI/MtQf1V16ImuntsSmaxd5KN0dXb64mEFmz8ccC4kltk9JOQMKMCuHVI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2752.namprd12.prod.outlook.com (2603:10b6:805:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 20:00:46 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::6d32:940b:f630:b37d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::6d32:940b:f630:b37d%4]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 20:00:46 +0000
Subject: Re: Question regarding page fault handlers in kernel mappings
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-pci@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <d511840d-50af-44bd-92db-876180c503a5@amd.com>
 <20210104165628.GB22407@casper.infradead.org>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <654b6d02-9ea6-0e36-d736-b529982f09f7@amd.com>
Date:   Mon, 4 Jan 2021 15:00:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20210104165628.GB22407@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:4465:d1cb:357e:d8b0]
X-ClientProxiedBy: YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::34) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:4465:d1cb:357e:d8b0] (2607:fea8:3edf:49b0:4465:d1cb:357e:d8b0) by YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 20:00:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d266d9b5-aaa3-4a98-a68c-08d8b0eb6cb1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2752:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2752855A970AE466A80EA071EAD20@SN6PR12MB2752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIAmCbhVLl5xQtk4f8k1nSTfhk1lZhUBMgbLg+gWn3/3fo6hmATRocew0ovlCAbdLdVs4ez1aoKt5wbWo6Ws+Rd52YyuowU3YCMQ0Uu0gkQC45UozZuO+rfkKiI6CVkO4fGoR7hPwoPJOI+zDZ3HnINzW37F+HhEiupUT3hrewS3K30GscABbA9tyaG7NF5WySnRubi6b+/QFnHXF32WvJKViSu8Dy/YV8TLMgSO0KyK3ytQWnrMcuQ6/ftgQHHxqrjPypxE5UybM89p2Jimi71///WMqFstTD44/xVnisSo+A2pM8zSYFXg1aQFB15CsHOl6P97cZE9MFyIuA8h9I6knE6ugcyOlHbpQYM31wU0N7f7bI5SybfFSHiBbAtaM6IHUjXnBOM09b1o66NuTq71HGali+9SwiDBV0IpAetJBgKO1W0KyuqZXsvLy50JTTOAb9ywiDpp9NECGW6j0qr9hzsSl6fOc0pmPTC/kh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(478600001)(316002)(86362001)(6916009)(66556008)(66476007)(66946007)(31696002)(6666004)(8676002)(5660300002)(31686004)(186003)(16526019)(2616005)(4326008)(83380400001)(36756003)(53546011)(52116002)(6486002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SnZOS0RXM2RSZ0lDZTdvd3RBbjd4SEg2UUY2aGlZdWR1Szk0eWpkR0pKVkFm?=
 =?utf-8?B?TTJBUktDUmVPUjZ3RXhRUjdEYUpwb1U4TG9kSHFCQVlybFMvVGsyMDJwVDJh?=
 =?utf-8?B?N1J3dTBHWmt2L0VBZVpjS1lFWDc5b0NIa1ZiZXQ4aUZFcXFtM2x3UDd2dE51?=
 =?utf-8?B?VkxwTnM4eTNuR081TWVCZ0E5UHFDOGwvUG9FbStSdkdveFBHcUp3RG5Bbktz?=
 =?utf-8?B?RXZnMWlzRHdYbUxxR3R4TnQrOWliMWEvT0tFdVFmTmpCSUluVkF0ZmFyUHN4?=
 =?utf-8?B?R1IyaHF4UG5TZDZ5REd5emJXVVBuZWRIdm9vU3U0L0ZvMHM4K1ZYRlZDa2xD?=
 =?utf-8?B?M1ltYktSelQ3RklQcUV5SXF6SVozK0R4VTNCTVcvdDRBdjI0QlpnT3gzcGV5?=
 =?utf-8?B?TVpoajN2TGx2am1ZNGNYWXh1emRwRmpsaytxcGNqdzNCUEtIZjFPaVN5bUVS?=
 =?utf-8?B?L1h5T015MWZjckpLcENHR0Z2dDYvYVlkRnlscFVUZ0RIRUtsSTc5OUxveTVP?=
 =?utf-8?B?T2dSR1hZU01DZktER0JzdDdHU3AzNW44Z09oYlVDOE1uN1lMSTRLa3NtbXkz?=
 =?utf-8?B?ZGJQVjZ3WE00aG02ZThpVll0MUZLeDZhNEVYMzAyRmxNcE9lTk9SblZhS2Fu?=
 =?utf-8?B?KzdHejk4S25GUkozUmo4b1NpVFcxUnFBVXo3RVlIcDBtb0ordFNoN0NieUtF?=
 =?utf-8?B?eVVhNFF1WkJMZlpMajdacE1qSFkwbkdEUlIya3hTVW9xbVhhUlRVQXR0WG0x?=
 =?utf-8?B?bVdDejlYdFhOZXF2VU8rUC9lOWxUN2kySS9UY1hPV0N3bXlWcXVNdjJIK1Fu?=
 =?utf-8?B?UUpLR0t5ZjJDeWpLTXA2eTE0Q29xempaSzVxWU1BY0FyS215WGp3TWxKMzE0?=
 =?utf-8?B?cDNqdyt5M1c2d3lIZlkwdUN0ZHEvTWVab1lIQ0wvclMwdERRUXNRUzZPcUd4?=
 =?utf-8?B?aEZOcWRVNU4yWG9nYnl0ejBYa2R3WnVNZCtFUVYwTnVSTERzK3JIOFNFaG9n?=
 =?utf-8?B?U1Btb2QvVzdrNlNCRnc2SmZqUU1rUVpZSHMrZFZrSEVRZGxuaTczeS85d0ho?=
 =?utf-8?B?R2hmTTIvQXFGdUJYTDFWblI1RVNjUVpEdmhhSzZoNHpzbnBiWDJvdmN2b3dr?=
 =?utf-8?B?MFUrMTk2YVhFNHFoWkowbGxLS252RGNUZHEyeGlCUnZXQWdvV2l5UlhJbEdC?=
 =?utf-8?B?cGZaN3R0R3FmMmFZUmt0bVorMkwrcFZPd2pvMitKTUhSQ01NVHNCWjFYZkJR?=
 =?utf-8?B?c0tlMStpSTk5bHlnbjZOb05MQlZ3Z01QRnFYRk9QWVhQOURoeFJZSzdUM3Bp?=
 =?utf-8?B?SWd6QU9DUVJxVHZma0VtWC82QXFUc21WMGZvVm1SZEQ2bEVndVZXYUpRbDVa?=
 =?utf-8?B?Wlk2NjU5Y1B5bkxGc3hPdHNTZ1g4ZE1XOUY0UEx1NlNTQnlIUnFYczVqbG5p?=
 =?utf-8?Q?wLv42jG8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 20:00:45.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d266d9b5-aaa3-4a98-a68c-08d8b0eb6cb1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ9uqaX/tm8kD93a/aEwcmKCyx0ibo0I+5dqE6i+no9BVyCYc3+ZQmyDECvX/ri1ih2jthIp43yFn0wVwuHJlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/4/21 11:56 AM, Matthew Wilcox wrote:
> On Mon, Jan 04, 2021 at 11:38:38AM -0500, Andrey Grodzovsky wrote:
>> Hello, I am AMD developer and I am trying to implement support for on the
>> fly graceful graphic card extraction.
> Are you talking about surprise removal (eg card on the other end of
> a Thunderbolt connector where there is no possibility for software
> locking), or are you talking about an orderly removal (where the user
> requests removal and there is time to tear everything down gracefully)?


Surprise removal


>
>> One issue I am facing is how to avoid
>> accesses to physical addresses both in RAM and MMIO from user mode and
>> kernel after device is gone. For user accesses (mmap) I use the page fault
>> handler to route all RW accesses to dummy zero page. I would like to do the
>> same for kernel side mappings both form RAM (kmap) and device IO
>> (ioremap) but it looks like there is no same mechanism of page fault
>> handlers for kernel side mappings.
> ioremap() is done through the vmalloc space.  It would, in theory, be
> possible to reprogram the page tables used for vmalloc to point to your
> magic page.  I don't think we have such a mechanism today, and there are
> lots of problems with things like TLB flushes.  It's probably going to
> be harder than you think.
>
> I'm adding the linux-pci mailing list so you can be helped with the
> logistics of device hot-remove.


Thanks, that makes sense as I couldn't find any clear documentation on how to handle
page faults for kernel page table while there is a clear mechanism and 
documenting on how
it's done for user processes  page tables (implementing the 
vm_operations_struct.fault callback)

It indeed the would be useful if some one (maybe on PCI side) could give me an 
advise on how
best to avoid accessing MMIO mappings made through ioremap  once I identify the 
device is gone.
The best we came up with until now is to explicitly test for device being preset 
before
doing any MMIO r/w access.

Andrey

