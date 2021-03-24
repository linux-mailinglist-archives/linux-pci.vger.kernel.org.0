Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEAB348092
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 19:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbhCXSfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 14:35:09 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:65184
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237203AbhCXSfF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 14:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX54vxZGumbQAiFIKJbHHFaNPsvTSFuUZ+6iN5ky5radqoreBEWt/pQZBAeNgb8WN7iKlqk68fIoj0jzzMyK0SyBorGF5HK/rJ3nUOo4hJgjnG3f87LQJvspbDpgmq4bH3w3MfZ2D579FvSagNRCKeHBAw9oiMIcfbwG70tVeb8jJAa//6wm/CjP8FwRkHtHWyfQq0kZvpxr+P2dtkSpnE6VcZuW9lVxBXEjf0yiXfZas7Imrch/JDFbixbd9ZIPosOv0o40MRbrKN7LffGg7f60yltoTDQJ982/+rZtiQtjWyqzx7I1XFnQFBaMXG2/yjuTghetYKPTowwe9aUh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv24XVEZj5zgBJAjtDKWfORzBUazvN9OQAkcsUrROfM=;
 b=h2kuAKATNyaaPfLVurukPosNu4Gg1+YSSj3sDbk0/ehcfDV69VF9Ak/otydUI6lotFDu9vZ5p5n+Zb02MKFVU1E3lSRollhjlcgQJTy8y6hiN8mYzoQ42eNwgN7ZeLStPAnrdH8zwIuesY/qUUNRHb4di/XwBmXZhRyTMl1pBGRK9m4XyT4P7zfeP+vSIeHC3F483w+X4aFf+X2ovmXqwSC930p3dfLEYz4p+MGBK6Ycj0rL4SZ34Uznh0ljms5Yx5zzbkt6jnGMlSELV5QDfqmljOvCBqV1XOsSwBFfnW64lTWhd3wOvXY/X6kNZFYQCujv2FON0dWYmrB4sjB79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv24XVEZj5zgBJAjtDKWfORzBUazvN9OQAkcsUrROfM=;
 b=bNyTP8qGd0N1tXvMCQUkhm92eUYhWuEYogpTK3tPzIwxuzvfy00pl8RkldcmnV5CQYGrt6U8+yY1uSJNY7JQJjXYebyENb/caBooOH29Ba0WcBobSk9zCMIwu8xV04AF5HOV0CLtywG8ebDuhfBKlTd5cx4D4ACCctJtdkEYN00=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Wed, 24 Mar
 2021 18:35:00 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 18:35:00 +0000
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
 <20210313013856.GA3402637@iweiny-DESK2.sc.intel.com>
 <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
 <20210324172157.GH2710221@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <044e4f2b-6cb9-7740-622c-ec807bb1a79b@amd.com>
Date:   Wed, 24 Mar 2021 19:34:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210324172157.GH2710221@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:d95a:1638:1804:512a]
X-ClientProxiedBy: AM8P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:d95a:1638:1804:512a] (2a02:908:1252:fb60:d95a:1638:1804:512a) by AM8P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 18:34:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 956acbf3-f8c5-45c7-3cf9-08d8eef3881c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4359:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4359DC73AB710331CF466E1083639@MN2PR12MB4359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2K2FZNlZ1D/p5/DAB6NBA11nGEx2xQlRaiEsS1ZgVvk+Nz50se7AzUz+dJWioNZ7ARte9Epl4owXdqVWZy7obenu6vJ/NoCc4H+iCsf7dc860D80EpOkUwCl8a7aMXbzuMpnJCKEsn0hzxbak873qjXZyobk/AzPhWSQudrqUphBLeTEpHw+zSxQEhihD+kGYEPL0frUm9BBGT8ePBWLsOYGNpfNwqM0cyBXdR5AHAbI4b2O4is6XFa+vMh1ZjoR59yYnSs5v+2VyTLEmJit1anCuFhvg/hK9zEDKHUdH3FSuxTva4QSyG+3ygWuSphInhXN9WeVBk3M0DO5veM9SxanE22qpLRS/LVu1PZ8tSmpY60c8/rUTfVVGpgwWeb+wjnC1aHgHYWwf+kGxCiIwRqnObc3otaMicDgBpcbz2Ui6qrrZmTldqj7EUS0cO3b5s6IiZhtc3fO19KSCyeN8sW2XZqb0YWWk2m156R7YQhoH2whEMUuoe3IbEXu1KrmldGbm4nAx8EFw9XtilNV5HxBzQ+M1NQWjGr3nOpGr+zoXM/TdQbGH+D3AFI5LLgXMNqTa7TiUDiYOkQU1poLZ7rc4PSpVzc7wiw9YgpRQEZNL3g1Yt4SDjHYiKhQKrsCco1hy5/PDU2/tNQPCUewa39v0UZasiY8kjpuvWHFuLiQQTvJ+rOx2PCJIDsAAnYnjuIlfn3nUp8tZBVR+o6tNgO9gsHEQnOIHLgdmcEteo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(36756003)(66946007)(7416002)(83380400001)(66556008)(2906002)(4744005)(478600001)(38100700001)(16526019)(186003)(66476007)(6666004)(4326008)(31696002)(2616005)(110136005)(5660300002)(54906003)(6486002)(31686004)(8936002)(8676002)(52116002)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VmJJb1NKQXd0WjhpS2ZDV3E3NUwxdyswaDgzc0NwVjRGM24wUnB1YVAvVVhZ?=
 =?utf-8?B?anF0OGYyMi9LN1FFRVE3L0c4bDJaNHk4SXB1YUs0eEoxWVN0VzFyU3BiejZV?=
 =?utf-8?B?WWNpekQzakpjdDY1d0RrY1RBRGExZE5SY1d1V3E3aFA5S3lOZUZvbXFsa21U?=
 =?utf-8?B?YjNWSUJWWmxaTjdkckZ5OEkwc0h0Mk0rd0NlWWl1QnRQdTE2KzdQa0p1N082?=
 =?utf-8?B?Z3IzWVRlN0dKendBYjF1S2VNWjB3ZDFpVHRjWkhXenNtOExkOUU1YkNuOEtm?=
 =?utf-8?B?bytlYzNMZDV4TjcwNEdqM0RmekIwOWxKWDcvcnVIcjU3ZVZOajlXZHdwekJB?=
 =?utf-8?B?WTBTbGJldXcwZkRzWnVVQjNZNjlBQXd4bUFuRmZJYk11bEtIWHNuaDBiYXJT?=
 =?utf-8?B?UVNVNUZKcFFaK0VQdXBLbXRMU2l4S0lURVNlNjNpTG5melhodm1BS0sxcEp0?=
 =?utf-8?B?ZkxqMlpkd1JDQkQyNE9Rci9HditNK1NqV09uNzNJS1BMS3dIbjJPS2dmelRD?=
 =?utf-8?B?blhHMjFYMVU4YUsxZU9QUGp0eWhsdmpvRUZmZzhqTVVOaWZ6bWZzUS9tajZK?=
 =?utf-8?B?M1p6M1U5ZFRXMFg3dnpVSG9kZmVBNDN4bEw4YVJNSS8xVk5sWVRUd0lCK2Qw?=
 =?utf-8?B?OVk5QVlVTStOUmtDZkhaSmozb3AxZTR6eEV5RHF4N2hlNnhrelMvQTc0THVo?=
 =?utf-8?B?R0pxN3h0bCtYbGtsY2dzSjk3QzlmSVJaZUw2eW9vNlJWZXREcWxEUkdFcjB0?=
 =?utf-8?B?ZHFMV2F0b1UwNjNhTFpxR2FxeEkxVnowNkM0dFZvU0UvUnR0d0cxb0V4OFBV?=
 =?utf-8?B?d2lVdkxUKy81akNRTGtLSVEzTXJ2R2NVbmUwUzVqSkxVRUF5NHVoZ29FUU8r?=
 =?utf-8?B?S1dpL2FnWkFINlF2ckpaSytHTWMxL1BZc0MxZ2d3NUE5aGNWdzNCenR0a3Nz?=
 =?utf-8?B?QWwvdkF3MzFsZlZSVHVNTTV3VFdOYlJteGRKOUc5cjJ6STJQMGxWbzhZbUJ0?=
 =?utf-8?B?ZW9HMTlMbEJZQ1BJYkkya0krSmRINFFSWklZS1gzZkVUY0VvQjc3YUNLZ2JB?=
 =?utf-8?B?eFliM1h2N3lPaHNWT3NKa0U1dnE3ZG1sVUxEWEZjd3QrMXJXS3RZMENTQjBD?=
 =?utf-8?B?Qi9NVGZEVjM4MlVGWTRsS0dvNWVteXlsQUpuS0Y3UC83ZDFtSTVwYzEwYllx?=
 =?utf-8?B?d3BpYnJHenNhcjdZbGxLOTQxMmFOcWw1SGlqK2ltUDVsTmRZYWMrWExLTGMv?=
 =?utf-8?B?ZW8yNTFYVTlZN0wwaGpNcUhSallIMkNicm5GcDYxZ1lmVGoxenczajRUdWd3?=
 =?utf-8?B?dVB4Uk5sRytlaGpiZjlXR1EzQmk0d2hsQlEycHNpZys2clF6WTRMV3BkRGJK?=
 =?utf-8?B?ci9OZWRiVkhkLzBremxPSENwMm9SRUZ6bUZyQzFpcmo5bDdEc1lCTGlvYStT?=
 =?utf-8?B?SVhOUHBBL1NoRDJnM0RJZkw1d2VFL2JjOGdzcWN6L2owaUhJNGVoVHJ2ZkR4?=
 =?utf-8?B?T0c5T2JKTUhiVm0rRFJwdjlBM3RYSXhmQkNHTzJjb0J6VmtPQ2Q0Ri9wbzVT?=
 =?utf-8?B?UFJEeGZCenROMHk3V2RXa1JGSTJLb0krY293N01Yb0c2S3ZrVEhSb2U0Q3B6?=
 =?utf-8?B?S1ZzeE1FL0pPQVhFRnBoMjdESFV3RWg0UVJOTWNRdG40Q01wUG9CaDVLeGcx?=
 =?utf-8?B?U0pmcFZERGJVdmYzQnc1L1VPbTkwdVlCdm5lQjVibGFraEVsdHUyak5DMFZ1?=
 =?utf-8?B?U2t5Y04xVmdpS0F1ME15MEU5RVZMdXpHQnFUeEg4OWtJZWtiWlB1ckhCZnph?=
 =?utf-8?B?TnRJeXN3aGxlbHhpVUhUMkh6TjlRMmxPSm9Za1Z1Qlcxa1ArUkNJV3hUVUh4?=
 =?utf-8?Q?cG/TVAERThKyp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956acbf3-f8c5-45c7-3cf9-08d8eef3881c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 18:35:00.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI/P6No2K8NHXggpk9GeLrl3VyfgTusrSIgF2Xao7Fq5ZYEphqG46m2Co8rN+jE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 24.03.21 um 18:21 schrieb Jason Gunthorpe:
> On Mon, Mar 15, 2021 at 10:27:08AM -0600, Logan Gunthorpe wrote:
>
>> In this case the WARN_ON is just to guard against misuse of the
>> function. It should never happen unless a developer changes the code in
>> a way that is incorrect. So I think that's the correct use of WARN_ON.
>> Though I might change it to WARN and return, that seems safer.
> Right, WARN_ON and return is the right pattern for an assertion that
> must never happen:
>
>    if (WARN_ON(foo))
>        return -1
>
> Linus wants assertions like this to be able to recover. People runing
> the 'panic on warn' mode want the kernel to stop if it detects an
> internal malfunction.

The only justification I can see for a "panic on warn" is to prevent 
further data loss or warn early about a crash.

We only use a BUG_ON() when the alternative would be to corrupt something.

Christian.

>
> Jason

