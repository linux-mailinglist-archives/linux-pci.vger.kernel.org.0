Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4941F838
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 01:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhJAX3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 19:29:37 -0400
Received: from mail-bn1nam07on2083.outbound.protection.outlook.com ([40.107.212.83]:40576
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231219AbhJAX3g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 19:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9H/ofbx5PxJtVGO4xXipnLEcAqt4u5fVj9bFjuOJHMvrYr3JBuYMI/ORNB9mJvk1Ebj1J6iDQiyBgM2dQCcCMnO+0kuKzxhkKurF//Pz0U+xEih34zXFvtRv3J12AodLvts5NuO18QbEeE/6mRfE6Oejdk1sjPYadAfTLHyCnBa7Uwfn1GtUjCjUTkhXulsqa2eBJ5rMSjAgwAukyRXgMCE/24P77X6JLlOrE5s26GeXZhayyba2vj1D3E09yeQwnfCRUbpsHixxgjcn//fcezBJGISl22q2/rJaH5PI7vANZpFULNJUbZ4FbMW558doVVp+5xoY+AXhaOaMRVkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbChE8IkyQXE8VEIZARmFZ5lTiVDTpDxafQlstVYmJI=;
 b=Q0c+yHUM089k5iOuWJbKvXYf0dihqJuVjM5N7WAKMR8y7CYbIaCydPZPWJIuYVvIJ6vxfDVNxJXAnWuxr7w8BzEiFNZ7UbfugEskuqP8p4KCrjuWuLZhfQ81/AU01Khto1DOL+jc8gAgb5WEZeY0iL5tpF8W3KTg2uFxJBB3r8lmjWZPaoCebFPJYX/HpOSTR/zQj3cDl/zS8DcqPhPhaDN/ujdQ7sVYX0WYGWega8uhlcK7OMiVmyjXvJablS6+DVxLNZ2A742XXaBtc/7+IFJw80xuvojhEe3/2vy/D7EiynUJ98cewzrDzIzcLdQ0ukFcsd8JFrP+NmJN7eRkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbChE8IkyQXE8VEIZARmFZ5lTiVDTpDxafQlstVYmJI=;
 b=GocUvT3Qi6VXIv1jeGV6+yt/Xgb/YjT84Rft0wCihFSvSHjvbCsr4KjQQB4s4DiHylJXqELeddyTBrrWlMDtClAXMoiJSBJQSdXdbZY1eZQqmaWoq1I9wxTd8YVY91NxKottpg07Um3n1hsl+F7ziXhO47y4SsqXqWnDP+CLlIaBUEoCWKTL/cvVk78ERw71a3Bwwu1Jk+psWNZ6u5CgM/4pLxiLiBWJxNYcaKeNbxtvRs5o2d8mcbqaN7YC8HmOxgcZYtJgdpHh+iX3Xzv6/6wRUvhumvguJ26JvJ9FbtBGx4s4M56/3Bn2HtkRfULRAZxJUYBGDzbyLaSthQFv5g==
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 23:27:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%3]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 23:27:45 +0000
Message-ID: <a1cd336e-60c0-b72c-022f-4b53c0b3fc51@nvidia.com>
Date:   Fri, 1 Oct 2021 16:27:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
 <20211001221405.GR3544071@ziepe.ca>
 <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
 <20211001224605.GS3544071@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20211001224605.GS3544071@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.93.211] (216.228.112.22) by BYAPR07CA0018.namprd07.prod.outlook.com (2603:10b6:a02:bc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Fri, 1 Oct 2021 23:27:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f04de5-bdf2-4f45-e510-08d985331268
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB47897596A697D9F4306F74BFA8AB9@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLt4hJW1GhWC2dwLKqRVcWka4xWa5Uw62lL44QMouGDL7//O2saezrRxAmoHUE+2OxhAwsZKGM97F2uo9baOD0p6Yoxtf5bIsf7IpDdGjytu0lNxIUflQ6zBctUhND3hqOn5GeNydYDlUzzjstMviPBFKOuqrSgd9Viip6+fMl007wu5n2epDfblE30X8OxE6vIta3CdA1j9F5OjFo0ovgVH71MoTOtzeONTOkib1H/1DC0pQ5zS1HfHu6BeS8XPvM4bbkryxSXY8aBM5UyXzVMZX/ZNMOi1WVkNqy6CIrR3Arsvnh1YKhB+QRozjCV8MOdt8eHfgDmd0rZ2mSSGYjSEhBVEmEXkpLsuuFdz2z/GBR9/FgyF5hTNoPKxswg+z4UDwYO8Nii3urJ1a0QwlchYGZtTAIQUPUoVZhJWaFuR184ybS4GX5xi+OSYLZyV3z9H/+l0Tix2/DIYH9t1AIt6sqa0BR4mU+Var5LX3lAEXCgSrxyDwBRlakK2Ir3NTtQqOfa5pN1qsCKKcZhi1T4I/gPHmFjQYsvpNSnoo0Y4tN/N3Efg3FwvDB00EGG/6mECUZwqy8qssm31Bl9dEfFz3Rxo3UheDu0OyXN/prUgFpjTSbQT7GJTw4Cou5YtkKZXZdnhUTL3bkf9VtrlxEgHmsmrFsZb4NOdFZTtkwvdvqfEdaB8e+O3MtPSraFyKMIDFzvnUn/mHf48/dCpxjlYGrClST7l/2UwTzloeJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(16576012)(66476007)(83380400001)(508600001)(66946007)(66556008)(2906002)(53546011)(26005)(8936002)(86362001)(6486002)(31686004)(186003)(4744005)(5660300002)(7416002)(8676002)(110136005)(4326008)(31696002)(316002)(36756003)(2616005)(956004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJEbTBnQWUwb1UySGhrRE4wTWJQSTJxU2wwY2h3V2Uzai9xUzFyamxQaFY5?=
 =?utf-8?B?NjBPRCs5ZkZVM0wxQUNIMmgvWldKS0FOaDlqb2Z6RDc0YTVUV0U2MmxZSS9T?=
 =?utf-8?B?WjZmY1I2S1RWM3dIWW44VEE2akh4aUdzV3ltMXg2S2RtbUc3U0pabWJObmNm?=
 =?utf-8?B?a21SQWIwQnlHd3NkYkNiTTRXcVBVUkFiZk93RW1XWWRBdHloR2w4MmlPWTI0?=
 =?utf-8?B?ZjRSMWgxajJpOWgzOUl6OU1mYW5DMHV1Qi9pVktWVGxVSTF2TlZ2aUxYT2hK?=
 =?utf-8?B?UkxNR2tsK3hBUllKZmY1RzVJazJXSE5wVG1IbHdESHhSRXN2TXU0TUNtSTVR?=
 =?utf-8?B?aFFxWGE5dG5vMW1keDhaVDZHeTZiZFhLSER2T3hsU1cwWkpxdk5ybkY4S1Ru?=
 =?utf-8?B?aHF0WlRuaW9Sd0ZCc0RLRGRjc3dCQmpaekJiV29vV1VaMnJOdVBDTVU2eVNE?=
 =?utf-8?B?alNHR3dZaHZrMnBrT2xQbllTMTJLRmt4MUlMNXQzRFJNYVVCZkNtNDh1aGg2?=
 =?utf-8?B?QXQ0bDVuRjZ1RFB4S1VDMG9Kc2Jac2wvQnBRSnZGeE9IOU1zWVFLVnhwNTRp?=
 =?utf-8?B?KzR6UzE3UHBrOXVQMjVTSlpUOHE1Y0I4SVQra2pwamo3dDJVYXlOZVl0N1Y0?=
 =?utf-8?B?d0hyM2RHaXRnN2JmbTVoVmE1M2lFTmJHcndONytrQlRxM05wMHNSNXhZYm9k?=
 =?utf-8?B?WjlnVGE5SXp3Z0kxcVJBK2RUWmZTd0V6TWQyaEUyazRJMm10aFdWOUlSN256?=
 =?utf-8?B?amhabG9XUkQ2YUI3djc1OFVkTldINzhTOUw5T2JrUi9KbHpMZ0dEVllYVVRM?=
 =?utf-8?B?bnQwYnc5UCtiVFk3UUpBN1lLeEZQMEliQVJicmNTeFpkQVVHcEpDQ2RDSDdy?=
 =?utf-8?B?TnVMYzU3VENBaGZuVHh3OFlLY0lkMHNQVkFkVzhGMzc3UFdwajYrdEhJV3Vi?=
 =?utf-8?B?d3ZOV29EMm93VXlyUXUrd1BUUzFtelg1VkVGWjNob1FQNFg1NDMrZ2hYdnhx?=
 =?utf-8?B?emZwZmtyWFJVbGFWajEzS01EL2pKUUVXZWdGTzZyQmlhU0hmalRPZHVZUTRm?=
 =?utf-8?B?N1hVMEFET1V2RnhJdWovUDUwOHpUTFVVQjdBZUJJQ0RFQzRUcmthUVhjYm1x?=
 =?utf-8?B?Tk8zQlZSU1pWUXVrUmxXcDRoT1QxWDVNZzU4UlhPNlk5bEdSOHRRelB4cmYw?=
 =?utf-8?B?L2hFb21wM2NSWHorNXowUEtoM0FlY205YkJHSUEyZXhIN2ZpWHBCMFhFSnd6?=
 =?utf-8?B?ZU9BSkdpc2ZZSlJSZm1LRTdYWDRWN1gzRHRWS0xqWisxblVkcmZxam1pTjQy?=
 =?utf-8?B?cWQ1ZU1iWFR4T2k2cU1VTHpMbHR4SzZINWRtenFRV29YRGdveGd1b0tRaGpI?=
 =?utf-8?B?bnk2WlBpWk5aUnhFUWNHTjg0RFk3YU8zVDVkM09zR3hKeUYvekN2dWNkbkp4?=
 =?utf-8?B?cTk1MURPemU1c1NsWDB3S0JMWkg4NXplbXdoK0NSbWhLKytyVU5OdnRqUCtP?=
 =?utf-8?B?WUk5d1ZYa0dnVC9CZDBtckJhVGw3MTNvMllsb2lLRjhCa09xK1U4WDhvWUc1?=
 =?utf-8?B?cFNMelNQNU9WWG1BVitNUTUrMWJsd1VwZ2s1UUwzQVo1bXIvbS9PTWU2RmZO?=
 =?utf-8?B?cHBnczVuenE1QzlRWFVualhjRndQNDhoOVF4OUxrR094VGhjTmdod0syRHIx?=
 =?utf-8?B?Ui80NjVMbGZzTmpSWnN5SzdWSm9yQ1ZPaG5LVFY3WXpmd29hZHJlMFFNbkpR?=
 =?utf-8?Q?NpZH3490Oh/k7yG704+tiRVll3GSORGEzqfPLBU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f04de5-bdf2-4f45-e510-08d985331268
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 23:27:44.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEJzYs6/A3tYihDqmP7YI7oSA9DXCFwZvXqao7qflcx3inwmHXmFnY0WjpKjEBTu+S4+7kewnko27NazOUzFlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/1/21 15:46, Jason Gunthorpe wrote:
> On Fri, Oct 01, 2021 at 04:22:28PM -0600, Logan Gunthorpe wrote:
> 
>>> It would close this issue, however synchronize_rcu() is very slow
>>> (think > 1second) in some cases and thus cannot be inserted here.
>>
>> It shouldn't be *that* slow, at least not the vast majority of the
>> time... it seems a bit unreasonable that a CPU wouldn't schedule for
>> more than a second.
> 
> I've seen bug reports on exactly this, it is well known. Loaded
> big multi-cpu systems have high delays here, for whatever reason.
> 

So have I. One reason is that synchronize_rcu() doesn't merely wait
for a context switch on each CPU--it also waits for callbacks (such as
those set up by call_rcu(), if I understand correctly) to run.

These can really add up to something quite substantial. In fact, I don't
think there is an upper limit on the running times, anywhere.

thanks,
-- 
John Hubbard
NVIDIA
