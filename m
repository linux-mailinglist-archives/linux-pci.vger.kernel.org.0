Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C0F5B0B85
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIGRdY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 13:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIGRdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 13:33:22 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BECBA7AAA;
        Wed,  7 Sep 2022 10:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfsieicNtMPuZ69XJYP8qQdEIRJ3PTC2v17l+fT3/EnHnmmNVJjnNax4dMmt1TbI2v+gxYWWATWo4Tzn5QmlD0TXXN1iqN5++DuWPhpukmlS/pEkx0JCUXQ6ZunkhZPbLYevsrkYCtWQ0yGJFbOVwZHJmDW6/0fQs3/i+8SBKzMTZV+kL/6Jrct9WS7B9kB5gwpgSzMyNDR0esq/gcYHri2OU8yLPGweRePY1Sgx8gK8bdZMFzXxTCfsHRaGftxVwq3lHfHALjaXHaGAAWbJS7QjIVNkrL1vEmaqQft4VKn3l609syzKva/+VrROrwxyag+EOGpKe4PP5uijyDT7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4slZVVCfsAflzgyI1We8Xf7pZOY2L01TNVtEGIPDLU=;
 b=TY/xKyGCmfS/axgCgeZZTWm1/YyNY3utZCGX7NSLfiU4zpLR/FJIctQgSGxqEK3cSvAyayjvJchr4p2zQNfXPYH3k5nW9FzVl+uBL8lR4f0pJdxvLq9Ay4vXuYZrBIUmuYVsL/64X1QNGk2JmAVETwd9QOJMDe4KJU3I6NSyvtEJ9iA63lEkmuzanlCrbus0LpJRLGLJqp28Onvf4eiwIlkJNhBtTbW4CTFIx6UPYDgKRTGEFFxO7caeihUaz4hNYPE1H3gP/Tmi85fzij0xp3cllNHWM5ySCrNoe5r5QLKNSqd6Ir/+SV5U2jFpk9PJPPtQhBEqXac4QGocVKjXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4slZVVCfsAflzgyI1We8Xf7pZOY2L01TNVtEGIPDLU=;
 b=Y4HjxIZN3FVaNSqT0T0usynV4twi+lH0OZD7uja1h4mx34l8aD9I+sJ5Tnq7rQcrSRTOAZKCnRZnzkhLEbH4LFatymKH5hdQEpRSZthTpVHGYsXAu1XEpI+hVdGh0q0nKb2YCZ0tAqGUk80CX/CZdJ+hgXsalupZJfeFh7jZCp1cubSniw9F3sHytd1MrmJxlj/lJQkVyn15dWxTUSOUtV1HVk5/VHq2Befm+TdfHzd3GUBawPlEsm2q2xNuemUlIHHSIyxy+i/W4s3S7q/rQCPrqCwxR3pkbsnms0pcNLHT4MDqsmj2Jxxz0Np/BlhL7mRNxVPq1j2GWvOEtm2Z/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Wed, 7 Sep
 2022 17:33:16 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 17:33:16 +0000
Date:   Wed, 7 Sep 2022 14:33:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <YxjV1y/FF0nCI/WO@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
 <Yxd2+d/VOjdOgrR2@myrica>
 <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>
 <YxhqbhMmWLeFS512@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhqbhMmWLeFS512@myrica>
X-ClientProxiedBy: MN2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b79552-cda1-4eee-0fe2-08da90f70c2f
X-MS-TrafficTypeDiagnostic: PH7PR12MB5687:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hAD9pIxZc02VHuk9lK3SQ4DYA9LPxyrPmQyV0OBnXFlI6rYeVSN3tZv6/d3FQJE/SjDSRHmUGekxcN9fTPqWPvAcS/kX+fdLr98EwYEL2RYo16WL+Ik3k9Dj7M6C12+Kxp6aXuF/xAjh4WzEdwcydG9GR0tkMAAP6v+FZKT+YyjqPf7DjpSCv8qQ7Cb+LIEaoeTS0aIr3RL0x/VyFpPYn3F2RhvFBgnssYNdiOY2VVBe3nhKnvtjUGkuF2IF3s87WuvBlxHKxQszhiFn0iv83M6nLAwklNNHQi8cQiJhQ/jw0xB51FdyXtAxJgBWruMN8Fa7oEVmeSaRPT0uyXwK/6sGR4Bc7q0uxdHfJHmjZtywtHKtTxsFqLr/RcR+AlrUjfy+r6+vhT244Ua8qeO+hMwG/CfoANGaNUdg6eE1PKI0aG/y07tVV7w/RtA2xqWmUU8phVPSPOxgO1kOcmimdU7xSlAGvymwlBz0PHNKAK9Eh+jFIyECrMLS9HL6bi2y1YAoqOOvopMqlCKwntHybrB4gMJyG3L1djiPV2qG93wNpgtBMf/UWUZCsH+fqznLkznkerWFcickkaIxuRIHiFV1t8YIj1gvJBHvsIfrTIbdlqNQu9IuHEUWk786fXkQpIyu8icRPtaNffRSYZzdzw2ELWM/KjXjaIxD/JGCm5Xn4fLJfmoMsUQp5C0KQwrfFrUnM+3lb/83FzMS0R/RZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(2616005)(41300700001)(6666004)(478600001)(7416002)(2906002)(38100700002)(8936002)(36756003)(186003)(6512007)(26005)(6506007)(5660300002)(4326008)(66946007)(66476007)(8676002)(316002)(66556008)(6486002)(6916009)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqlZptRaD2vk/hRTXkzXA3xQ4iVAg6gcBHAlFypxicoqZ9rpYb6nPMe5Kam8?=
 =?us-ascii?Q?NjHUryyUhDxRBGicS9aGrFjfq+SNpi8ud0XARgYugNxGnHntDOB5bnWm1HY+?=
 =?us-ascii?Q?Ywk4SeOCqXpCsV45NniCsu0z24GufVXdgj4fIEgVD3yRBxM1whP4zdZFYzPc?=
 =?us-ascii?Q?p85+ViTxtuJdpPOG8ZIpwIIXUbIWNQy+edxHosp7ANIktS/BFGbY70QQc4TP?=
 =?us-ascii?Q?MDaNh6ECGgFC506GVqSxYldvvAZKVGZYRUQLAiKT9d2zKmu/0Lit6TMxYarn?=
 =?us-ascii?Q?S/+CnHj/OkiohkB6ZIoX4vbuPLsy2fvxgAUkS2rDtDhpQ8VECVSq64XXJIif?=
 =?us-ascii?Q?EnapsUxRlxDQ6t48XPJjeYAoZNvYricpyGlYx3BYhneuBxnnM95L7xaEBUDG?=
 =?us-ascii?Q?uh2aaP+UctvaQ/jcUxdZ0NtGszUXQKixoe9MtztO0xGrnZaXYZucxmAAnbxH?=
 =?us-ascii?Q?r43cicEtRmIg1CjtxwtmKWAKFrMrhlYUG/emmTfpPKXq+Fm32ErfEvoMP9Vz?=
 =?us-ascii?Q?ITb7qAjV/5gmpRgVuxjDQ+NL4hf6dgarfrJzbyDPNWDQmnUshis4REoCW5I6?=
 =?us-ascii?Q?AVU8wfKB0itjzTCOBCYuHZ8dVSJ+iVvMC37ew6yVaHR7EiGHtX6vDqnuPhwP?=
 =?us-ascii?Q?8Eb8UQqMnlWskqBDDbtl+hUQRJqsfJ2Xgic1S0dhiAxAtirmMozJgNVeKMzi?=
 =?us-ascii?Q?x5B4gOBpUZCqeYiSTBQed92QBboCRmybpH98KlQgTrh0NWJMo+zPg/gpBR+g?=
 =?us-ascii?Q?OLWA713Du4pNkm9QE9Gf2tcInHlgYat274pkhFvWYxNHsOwyqggfc37cwJcx?=
 =?us-ascii?Q?yzs5o5+J3suV/KZwMpKJPM6FHyLSAz3NmN8WSkL0ELokaBsQbLxayo+43OQn?=
 =?us-ascii?Q?MI4ysUBkZLpK1Ig5ptJfFFQE4eVsYkKNpTl6+l9rycOlKF/55rucPLFh8D3b?=
 =?us-ascii?Q?sPGtrpW6A3vGYYrZp0dTNhIf5Q8qBfmfywekosWuLpfMq9/0AxFws7zg5K5A?=
 =?us-ascii?Q?/AT8VPggUcQVQxVSYPc8LJVCOo9nCiYWwTg36Ex+FpkqsO4WD18UEXfpPSMc?=
 =?us-ascii?Q?37H8YMgjAJesaFqKcnbx5SN1P8thjU1yJpTW4ih7iPi4f5DJnDq2vAT+OE7x?=
 =?us-ascii?Q?P+212BbwPMS2mM4s62Cfk3dHeAC0ivQ9KcmqoQyVujBy2gvPhUesMmpH5GrX?=
 =?us-ascii?Q?kVE/Vl4vab3NtuY7GIS5+AcsaPZGO3JMl6H47Jq7gxc/c+dN4Uu8xpXIdWXe?=
 =?us-ascii?Q?sdGpq+NLfdN0N5DzvLXvptR9RawqCQSNojamDVjaHyMUZJNVhNMP6Jj6F3CB?=
 =?us-ascii?Q?oO1N2P8jRXKbQZyYQHqrdewZdWNlt3c/kNZ/nJKxA+tBP/EFejEiRQNkPVkW?=
 =?us-ascii?Q?+Q8JofedvjG9/swfhBc70e7sAClnDzl3eGzsNjKfs0MYR1pCiR1Tjpr25fh8?=
 =?us-ascii?Q?pPPHhgccU8uyS+w2iIk4zVnmCqWj5pUx6+Y2z2tmnGIkFJYjmWn93a1ExjXi?=
 =?us-ascii?Q?Qb2qlz+rbzhAkjuE5JNRQGOJTl/OC1/x9pGt4aTFij2jqPlHYlaBxgSQekR5?=
 =?us-ascii?Q?2o+Y4K6W1/pUMV9l+DW6E6VtdjJa/PZtiySns09K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b79552-cda1-4eee-0fe2-08da90f70c2f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:33:16.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mE42ZkUmFcJi35sj9tWOVfqATs4/Pwz1bTOEs5KUp34vr23nSiY4RsLABof05NF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 07, 2022 at 10:54:54AM +0100, Jean-Philippe Brucker wrote:

> Is iommu_domain still going to represent both a device context (whole
> PASID table) and individual address spaces, or are you planning to move
> away from that?  What happens when a driver does:
> 
>   d1 = iommu_domain_alloc()
>   iommu_attach_device(d1)
>   d2 = iommu_sva_bind_device()
>   iommu_detach_device(d1)
> 
> Does detach
> (a) only disable the non-PASID address space?
> (b) disable everything?
> (c) fail because the driver didn't unbind first?

I think it must be (a), considering how everything is defined and the
needs for vIOMMU emulation.

If it is any other option then we have a problem of what to do if the
guest VM asks to change the page table associated with the RID while a
PASID is attached.
 
> I'm asking because the SMMU driver is still using smmu_domain to represent
> all address spaces + the non-PASID one, and using the same type
> "iommu_domain" for the new object makes things unreadable. I think
> internally we'll want to use distinct variable names, something like
> "domain" and "address_space". If (a) is not the direction you're going,
> then it may be worth renaming the API as well.
> 
> I'm also not sure why set_dev_pasid() is a domain_ops of the SVA domain,
> but acts on the parent domain which contains the PASID table. Shouldn't it
> be an IOMMU op like remove_dev_pasid(), or on the parent domain?

There is no "parent domain"

PASID or RID+PASID are completely equal concepts for binding.

If you are thinking "parent domain" because SMMU is storing the PASID
table in the RID's iommu_domain, then I think that is a misplacement
in the SMMU driver...

The PASID table belongs in the iommu driver's per-group data
structure. The iommu domain should only have the actual IOPTEs.

Otherwise everything blows up if you attach an iommu_domain to two
RIDs - the API demands that every RID gets its own PASID mapping, even
if the RID shares iommu_domains. We do not have an API to share PASID
tables.

Thus the PASID table is NOT part of the iommu_domain.

The exception will be for nested translation where we will have a
special ARM iommu_domain that contains the PASID table in userspace
memory. When this domain is attached it will logically claim the RID
and every PASID and thus disable the PASID API for that RID.

Remember also that an UNMANAGED iommu_domain should be attachable to
many PASID's and RID's concurrently.

Jason
