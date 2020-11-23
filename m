Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F942C18DA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 23:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgKWWvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 17:51:24 -0500
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:24065
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733147AbgKWWvS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fslUJj10EcnEqJJmk9cuqZbVdvaakovN2GoH+qTaOfWa0U6GQ+PyRw+GCVZf28vgIzVZTgWdkVOzPr370fOLjU4FyG4WC+3BviSDsDYOiy7LpoERGHCAhzOAMpMMjdWWuCuODjbXcYmB4Il4EW+TqZRpSFr9RH7pe1zh2E3dG1B2m8Cg0cbb6kSXBSpeSAqMjCCwx4dixg5K//kcRNx4EWFSpU3sf31E83pM5kkL4Droo01s+t9JwL49Hj3zevW5OEgu0mXdheAErxCmIl3VbUVnONUvzmmouwp/EB9vIb7jOIlP4cdtstIO0EGuiYgJEBuZv/xSj+YHap8hWy1hIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ5oX/gM57euXN94QblKpTjwqNAfLreegM7OqiUpZpo=;
 b=WdcepFp9ovvf4+N90xe5s2sbsTp142SOQy7+f7/cO6KtmGS00J7eYPSOwq6AgsucQvwKPSJZom3+LQxZFYlamcHbHF48lZXMorY+DGgOs+jBA3lgIlKIdklc9IynfMOHIRDQy401qa5nKa2DTwlo1BZ14RtVa+X4JWgbJmLpnZBy5DIkxsx7HyvEiM5feeFz/Kc9/y7zOFJvtoqls2Q5/jbbMP12Nzfb6dcEoIFBg4GY+80kZLOOTm7agbXr59mnyFwq4om0aQBXIfkeAfvnGvjYTO+5azrdGY9NN8jcZRdt01lspHPVvZKT0eIsuK82vzlrr16PiJL555vKVzH7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ5oX/gM57euXN94QblKpTjwqNAfLreegM7OqiUpZpo=;
 b=TeYWzVWPAegEVVvcc49PhKKvFFBGqxwjbJMCH47yHwZoKUKnl32wlLdFl3w0ZQOTthAgt3iKCXm8Gca8hJmhL3trbKb0gHTdo6fSOEy9wmDQ+sR0reJrS7bw+1ucCN3R+Ml25HO3tJQdclJrqqLiEe3bAb3tkJR/Au6SXiO0rmk=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 22:51:13 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%8]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 22:51:13 +0000
Subject: Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
To:     Will Deacon <will@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Edgar Merger <Edgar.Merger@emerson.com>,
        Joerg Roedel <jroedel@suse.de>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20201123223356.GC12069@willie-the-truck>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <218017ab-defd-c77d-9055-286bf49bee86@amd.com>
Date:   Mon, 23 Nov 2020 17:51:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201123223356.GC12069@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:610:51::25) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by CH2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:610:51::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 22:51:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18853704-df28-4727-678f-08d890024743
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4111DED35B8A9959913C4B9F92FC0@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 011lQo37cTgq4n+fptQGhB4QroJLQXSTXLGED55hSnjm0PyqvgwTyhIAHeTIzSGyuo/Wv6ee4wcMDrK1RHkdH8V+twx7bL2rXZTbXlDNK8tggFyjbJS2l4agJ5HAZcZ3OFFqkwMlzaHIh+BIvPc30Y0MELyqJd6yN7yv88rULxofhG0p8XhB5VasgvVivhbD2BVh5RFtd72I/odNJJZZ0Yt11rENc7f3RJ2Tcg2ijyQGFMDorQkXH106Es5RtArJzc7ZeN5w3fFsokuiRxylH+lWQ16u/kKND6hiiizIhjCt0RO0vnmp+mT9XPEcES/T4NXnXRf0jCHgU/NbmSaDHmpODTNXd7YJSO7TFhrvGPpnD28G+syziYO9mA5H4HhQgsiHo7+wsNgEWtxWDQrVyczWc7NQ+bw+fBuiq57OVA3atmsLZoi15dbcxl+NyONXJchbmpxkLev51drjaCd8AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(2906002)(86362001)(6636002)(66476007)(4001150100001)(316002)(66556008)(54906003)(44832011)(110136005)(83380400001)(45080400002)(5660300002)(53546011)(16576012)(16526019)(52116002)(36916002)(8676002)(186003)(4326008)(6486002)(36756003)(966005)(8936002)(31696002)(31686004)(2616005)(26005)(66946007)(956004)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4CAaQY+B8HWYs9FCPsm9JmoSzsimFE/oPC7/xC52NBwTxTE5OqX4iTpIB2hA63ZXn0zMrd4+qv2UtVa10venzr2DtFXChsdI4CK+AkWe+5fFVhRc86VgXGwkZOWLQea1rC9TQaYUfMHTj/iGrAudX29uzBrRtv22zeegBMw5QACxh73EVYZeEImx/3fawSjoxSVWb8CHiE4vfxHXeRDE4Vp5O1Rhp5QNS+X+bDD8uzEm2lrTpe93fg7Gu6jIN1ekgcMbVh42KGUaHy9qf3SVqpg1yXEWk9MJctrAOCwJJONpF9WSd3FHhDuSR/rHGoStCkjtraB/7PVGVU1eFgUGc2BUMCexHSqJLuSTK63l1zXx3HpCsAKwjI3nwgBUa8h2AE/uYiPmpO4+azlJ1tvw5mBvauACyecRx/cxKF0OrGDgyJuDTub8qG3mvIWnabponGK4dxGnG85rwQQTRYzK2iliFuM+BO5D7dVEBDZ6lE/zjwLai/Chjx+C7gPweKXTtOdAC89NgH8P1Fr/P9UcaFp0QjHhh/qAEO4RsCdXCjynu7Q5g71Zm0viCgZR6YG9kk6OnPqlZcMzWqNZC1+OTorqWW1sAsliWiW2sHAqDiIW7snxECJlq/TuVLirA0oaxoy75QYwMZk/z8NgcYB2s0VFbGPabDO4gSy25eor2dmbv7hCAd+1w/oSmy2DNiO13g/EB+Z87SCXGt55OTu7SJfW2wqhwF+jW54aUW3pU+Awz4Gul9C9m9BASznsB6k/Ig6chzaXMC0mb8GxVJfRytM05fiteCZx9z5CgFqBhnZz2mknzA+v45ygSkljSIiIOOvKFxVPFKrdXPuIEo4SB/mCGxiV0wX9gfImj/E4cjk2owRcQz60knkkyUWPQmd03uJpQCzvHOylHIX/Uz7ENQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18853704-df28-4727-678f-08d890024743
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 22:51:13.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yFvMrrF5PN9Oa3HxhpUHuhomZf15d1JF/8dvN63Q+WNAsjflvn+E1kpGBiOQXReSkUhF3AkVGrG8K9ZO8rwtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-23 5:33 p.m., Will Deacon wrote:
> On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander wrote:
>> [AMD Public Use]
>>
>>> -----Original Message-----
>>> From: Will Deacon <will@kernel.org>
>>> Sent: Monday, November 23, 2020 8:44 AM
>>> To: linux-kernel@vger.kernel.org
>>> Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org; Will
>>> Deacon <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
>>> Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar Merger
>>> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
>>> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
>>>
>>> Edgar Merger reports that the AMD Raven GPU does not work reliably on his
>>> system when the IOMMU is enabled:
>>>
>>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,
>>> signaled seq=1, emitted seq=3
>>>    | [...]
>>>    | amdgpu 0000:0b:00.0: GPU reset begin!
>>>    | AMD-Vi: Completion-Wait loop timed out
>>>    | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
>>> device=0b:00.0 address=0x38edc0970]
>>>
>>> This is indicative of a hardware/platform configuration issue so, since
>>> disabling ATS has been shown to resolve the problem, add a quirk to match
>>> this particular device while Edgar follows-up with AMD for more information.
>>>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
>>> Suggested-by: Joerg Roedel <jroedel@suse.de>
>>> Link:
>>> https://lore.
>>> kernel.org/linux-
>>> iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10M
>>> B1310.namprd10.prod.outlook.com
>>> her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
>>> 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
>>> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
>>> LCJXVCI6Mn0%3D%7C1000&amp;sdata=TMgKldWzsX8XZ0l7q3%2BszDWXQJJ
>>> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=0
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> ---
>>>
>>> Hi all,
>>>
>>> Since Joerg is away at the moment, I'm posting this to try to make some
>>> progress with the thread in the Link: tag.
>> + Felix
>>
>> What system is this?  Can you provide more details?  Does a sbios update
>> fix this?  Disabling ATS for all Ravens will break GPU compute for a lot
>> of people.  I'd prefer to just black list this particular system (e.g.,
>> just SSIDs or revision) if possible.

+Ray

There are already many systems where the IOMMU is disabled in the BIOS, 
or the CRAT table reporting the APU compute capabilities is broken. Ray 
has been working on a fallback to make APUs behave like dGPUs on such 
systems. That should also cover this case where ATS is blacklisted. That 
said, it affects the programming model, because we don't support the 
unified and coherent memory model on dGPUs like we do on APUs with 
IOMMUv2. So it would be good to make the conditions for this workaround 
as narrow as possible.

These are the relevant changes in KFD and Thunk for reference:

### KFD ###

commit 914913ab04dfbcd0226ecb6bc99d276832ea2908
Author: Huang Rui <ray.huang@amd.com>
Date:   Tue Aug 18 14:54:23 2020 +0800

     drm/amdkfd: implement the dGPU fallback path for apu (v6)

     We still have a few iommu issues which need to address, so force raven
     as "dgpu" path for the moment.

     This is to add the fallback path to bypass IOMMU if IOMMU v2 is 
disabled
     or ACPI CRAT table not correct.

     v2: Use ignore_crat parameter to decide whether it will go with 
IOMMUv2.
     v3: Align with existed thunk, don't change the way of raven, only 
renoir
         will use "dgpu" path by default.
     v4: don't update global ignore_crat in the driver, and revise fallback
         function if CRAT is broken.
     v5: refine acpi crat good but no iommu support case, and rename the
         title.
     v6: fix the issue of dGPU initialized firstly, just modify the report
         value in the node_show().

     Signed-off-by: Huang Rui <ray.huang@amd.com>
     Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

### Thunk ###

commit e32482fa4b9ca398c8bdc303920abfd672592764
Author: Huang Rui <ray.huang@amd.com>
Date:   Tue Aug 18 18:54:05 2020 +0800

     libhsakmt: remove is_dgpu flag in the hsa_gfxip_table

     Whether use dgpu path will check the props which exposed from kernel.
     We won't need hard code in the ASIC table.

     Signed-off-by: Huang Rui <ray.huang@amd.com>
     Change-Id: I0c018a26b219914a41197ff36dbec7a75945d452

commit 7c60f6d912034aa67ed27b47a29221422423f5cc
Author: Huang Rui <ray.huang@amd.com>
Date:   Thu Jul 30 10:22:23 2020 +0800

     libhsakmt: implement the method that using flag which exposed by 
kfd to configure is_dgpu

     KFD already implemented the fallback path for APU. Thunk will use flag
     which exposed by kfd to configure is_dgpu instead of hardcode before.

     Signed-off-by: Huang Rui <ray.huang@amd.com>
     Change-Id: I445f6cf668f9484dd06cd9ae1bb3cfe7428ec7eb

Regards,
   Felix


> Cheers, Alex. I'll have to defer to Edgar for the details, as my
> understanding from the original thread over at:
>
> https://lore.kernel.org/linux-iommu/MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com/
>
> is that this is a board developed by his company.
>
> Edgar -- please can you answer Alex's questions?
>
> Will
