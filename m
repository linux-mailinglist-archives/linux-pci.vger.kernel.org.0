Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EB3685D59
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 03:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBAC3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 21:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjBAC25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 21:28:57 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444E3647B;
        Tue, 31 Jan 2023 18:28:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA8AK1R9rMB+lv4XsK5zohqEwcT+D00Gbe6pzMyqtACxhxUxD4bsL19z6WPqn64XA8zgxNn8P8n4cXSfLOTp1uBCVe+GKNnd5fpnHII1OSjVzxim7uTWrEWCGDd0GRlWKOZE/w+df7/xzXUOy5wZQ8ZbIuT/PSjzj0+heazXT8haoyJpFJD7vocAATWb/hkGAwvUkwbxIR5I1cztAfHa4ravL7ythGN/jZg9MPGAZmSnkS5QrjQxSQoSl2CCN37q6uH4mAiNhfmuljVGXXauLisHQmCkbsbYy/6Lbhwe790tjdJxTABcPlrdB1eE2j3nRS4EuII7LNNpZhlCowvEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzJBqprqRvjZZAwX/65yb1Bkasgf+Cl9jvKml4bn3vk=;
 b=HqpSzS6rdxJRAA93a1cyqSEBdaLlU3blecUpNnGjvAbvcSSH8Nz97eL6dN/JPPEN9pT/g7SYskpP0wUJ3oCOuhYNU4RkSRe4dStz3k4MhMakW3ffzwjnMLSep8m15vfF3BOpSCmQ1o6kmtmiTGB7jEZUhKMH/3aoJnWt1quJdAKNZsq5aKhgRfUH9JH/5uOuAs3nm9oe4vVjfgKaiTVVuEKSncqrq710Vm1j7Bck5l2b2MdM2+ZAkasSfJpJ/CtkXWko4M/PWQPBPmeVTvx3CFTjz9W9XW8JVmMv6AcT+Nn9H+aX2Wwo3K1RIv0d9zSg50wsVuT0xjKxAVZ8psIeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzJBqprqRvjZZAwX/65yb1Bkasgf+Cl9jvKml4bn3vk=;
 b=km7anNgbssHtPOQ3Ka0bmBuhDC3+Y9vMseULWvOvOs7hybZbO5A9dKZJm7lYrJwwSXuKwq8f4lmULpcHwpX7pY0F0PUuDyWpFxVNlC6gf4RvLgPsf17DlhW0DLfbwK24MAoFFwHu5e0ah38pFyb/1j3PlanTnOFex3zDGYffM1Z0gxv29bjApgQE6IEFjS10dtlH5lhI9Ln9fHB7mlXeMeAKldYCGGdQu2mBadSsF/KXU+a5s6KMmcjqoLLs/JIp90pQ69KRbN00wlNlkPCk7JKzzwJmTTriuF9WO/W3eP6PXnFlOwyQBkiMVlZEG1WqGNU1HdxVXEhv5CK7kItqNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 02:28:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 02:28:52 +0000
Date:   Tue, 31 Jan 2023 22:28:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <Y9nOY9lUZoans6sa@nvidia.com>
References: <Y9gQxCmzqq6WXZK4@nvidia.com>
 <20230131235052.GA1811430@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131235052.GA1811430@bhelgaas>
X-ClientProxiedBy: BL1PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 32443a73-38cd-4a2c-7aef-08db03fc0f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjmMJJE++Sqn7Jue5mYv9I5v/x7KpDjfZzLsqLDBpM6RWU4GGtSrCJBiylYdUTF/0YVigGLrFeUo52M/kyKbM43FVlMghCVa1zYre+VJXTxn/6heXFYrHhGhbtN0s7x4VPtt1O25I6CnPFoPnl7K8HvrPLz9c15UPGZxiY4XjxgTwwqfJr6WBOxjAOKqfdG+lTKBQ/BL9/FEQAvuJ6NZuC0G0Pf6l4fjw3Tnxsz6fTqaPnHTCYbXqu+U4lLP0NVisXKqSKavZHNmc8dwztYqZZ1++q6CQqeeZufVOs75zvDZMKqiw+jzEM6X48IkYtPFvST0SSTPL5IrklGZfLJnh1G3DdYao/Tn9SZXJ3obMkUfD1GiHh7ZIweWAoWn3h+qvXjC8naspZBHKU9fPWRxLuSBZhl6oRm4Jw16w9rv/eWZmqr3bD1BMpGrEsFsm9bpLaX6+MeXrAgp/kiwGLtelL2qQ7RQECG4DMsXJKF67Mq4GvDNc4oItBn5fM9NlMTj6gdMb5SQshe31q/Hi0sQkTNn9KLW1zzvifiNwUDe+dYxqB+dqdZ7hpTs49PQakQGY0+ywSMuq84poMapvHVxeDUyV6Tj0lCOaWhWmMlF2R2p2VKs7ImziW0N0NyHxAtfX1CYAqAdCIEhceGvIXF3Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199018)(186003)(6506007)(6512007)(26005)(86362001)(66946007)(2906002)(4326008)(66556008)(66476007)(41300700001)(54906003)(38100700002)(8936002)(6916009)(8676002)(83380400001)(36756003)(2616005)(7416002)(5660300002)(316002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dLyjW2ym+aHpAaA9+1F0nRwOeCwrcDqOmk0QdNTs04/ANZgclqaQB+NKeX+K?=
 =?us-ascii?Q?KDVlvRLIrnu9Y2velLQ4dBkMD1fQnUpZvf3n/YQXDw4/9Tp56c6RnWRnmwFp?=
 =?us-ascii?Q?KQkdN1bQpGm72mVtIC+dEBIlVBlwHLUmbWBfH9IqoCTWEWYcJecvqXJ2kumq?=
 =?us-ascii?Q?J5VThb2BWpetvFr4aF6yzr8COMpQO/3X4Wi0aHkDTxIoiCCnq2Lg2z3TOW/e?=
 =?us-ascii?Q?xxsTaaBtRG4a3M+x1++sMsy9Si+89nUqP2z9JMQhYS8DieUyol3F33c4watL?=
 =?us-ascii?Q?jY9z06Xr/oh/i04x4Bc48NPc2EOpCkQ5A7zyOVeiP5QwyT95h8iTg5ylrlhm?=
 =?us-ascii?Q?xutQV5DY/nHDuZKvuKkzGobuYO23YV/tBqQ2KY+SFmDn3Bgg36P8QvTo87Hx?=
 =?us-ascii?Q?/M2JxxHXCuDGIRe3DFk9M5M7uDh/olrTh/mgY329n2oAzGhEGwV2Bg23MB6+?=
 =?us-ascii?Q?os/qR7Daglq8sZWGSXhFSMikkH73P3Y7k2qVp5Nw9C9f1jq29cFNoouqr3ep?=
 =?us-ascii?Q?XxXgLuepD39JL9gcWhEwpcR+EzZhf2PwCxhtyxKJ3V5u4utqrnHL7bdvEiML?=
 =?us-ascii?Q?xDN9K99ZYNQS4e5L/FcQxe4neW9CPJQ4t190AOUHyDrW9ZeFOg+oUu678VdG?=
 =?us-ascii?Q?Gh2RnQoo76bJ4bNVk3ScbsCmVFAr/959G9Tt0TbXqxctb30y+4o05lWRhtLu?=
 =?us-ascii?Q?EKDVXnqIvCMpqwOAx3VGA8HVvWyWsc/rsIPsw0u5nQM7KDOS06oRK2UDkTJ1?=
 =?us-ascii?Q?RzWpiMtXfhA8ssN0VMC0DyJp129C0+CVm7TG/U91CRLApa5KZsjDs6sI3XRA?=
 =?us-ascii?Q?xJ8bxqn9Y5LljzO9JmSXj/+L9aE/vLFbxu7UT6Dpl8z9cwO87IBa4zT9trsz?=
 =?us-ascii?Q?rDnfeVTQy/xctMkGMTT4r3Zd+CTJ5lG3+u8JsV1UKo9CngA6H0AUkA+VObhn?=
 =?us-ascii?Q?Ecf4hb4kNeltDEjxa0EGy/WtIypeeZ2NAm7rEqac5C2ZhS0rt6S5GKx6Zuno?=
 =?us-ascii?Q?k26VNpNttxoYyVNhJrNmHNa4KrohGnRUxylFtbH4XccH0Im6M7yDtzU/PXe1?=
 =?us-ascii?Q?kIjLIBpslGE47MfsZknLtdafDWw4/x/ZpaUFiJkkm/SneDj1OnzRyc0E8Xxz?=
 =?us-ascii?Q?POLDE4nJHDwgc7NykYTztV70G/DO8RCuN76jDOkdSFM4RmkIRX0286edkVA8?=
 =?us-ascii?Q?XfZ7plXKPpy9iJJzAQgaJBWWGvCcMdvkrU5TpZ9lZoMh4FmWXaepmeApv1OR?=
 =?us-ascii?Q?Dv9BQdiGOXf5RFUp4PxhNRnCyzlfekoJAYJJNgSoh0Q02gVKTZyyj+/7dUdb?=
 =?us-ascii?Q?x+9VuruwmfEK4oC+TXFaGlLnQo2BV/182YzvSM9sgWQA3jWNILHVuOqSdLPQ?=
 =?us-ascii?Q?I/7HiblfinQZaSNFWGaQifJoaRWF1oW9qrVfFUfKqFQ8ffZX8HnHleKLS3cL?=
 =?us-ascii?Q?hZauLPaMnpovwW/iRiDoywRBqyqgYkdJRQR7bzcm6rdWHGDgX2KSGj5J290q?=
 =?us-ascii?Q?IdQij4sWZqMIjAGKFWCnRtHCNg169WzDGOcPaB0XWG4W9m5sFEUTQ9tYHefE?=
 =?us-ascii?Q?MaKonINC6PN/40sChJZPfHeJZ+GYGPZsHHW7/cIi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32443a73-38cd-4a2c-7aef-08db03fc0f2e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 02:28:52.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTUj4DM+IbZTTveiyhB1pxnVqEt/b0oaEGAosj2VVksE3fDL4h9yFMx6vPTWkjGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 31, 2023 at 05:50:52PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 30, 2023 at 02:47:32PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 30, 2023 at 12:38:10PM -0600, Bjorn Helgaas wrote:
> > 
> > > Sorry, I'm still confused.  PCI_PASID_XLATED_REQ_ONLY is a
> > > device-specific property, and you want to opt-in AMD graphics devices.
> > > Where's the AMD graphics-specific change?  The current patch does
> > > this:
> > > 
> > >   pdev_pri_ats_enable
> > >     pci_enable_pasid(pdev, 0, PCI_PASID_XLATED_REQ_ONLY)
> > > 
> > > which looks like it does it for *all* devices below an AMD IOMMU,
> > > without any device or driver input.
> > 
> > AMD GPU has a private interface to AMD IOMMU to support PASID support
> > that only it uses.
> 
> What is it that makes this a private interface? 

The symbol names start with "amd"

drivers/iommu/amd/init.c:EXPORT_SYMBOL(amd_iommu_snp_en);
drivers/iommu/amd/init.c:EXPORT_SYMBOL(amd_iommu_v2_supported);
drivers/iommu/amd/init.c:EXPORT_SYMBOL(amd_iommu_pc_get_max_banks);
drivers/iommu/amd/init.c:EXPORT_SYMBOL(amd_iommu_pc_supported);
drivers/iommu/amd/init.c:EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL_GPL(amd_iommu_is_attach_deferred);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_register_ppr_notifier);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_domain_direct_map);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_flush_page);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_flush_tlb);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_complete_ppr);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_device_info);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
drivers/iommu/amd/iommu.c:EXPORT_SYMBOL(amd_iommu_update_ga);
drivers/iommu/amd/iommu_v2.c:EXPORT_SYMBOL(amd_iommu_bind_pasid);
drivers/iommu/amd/iommu_v2.c:EXPORT_SYMBOL(amd_iommu_unbind_pasid);
drivers/iommu/amd/iommu_v2.c:EXPORT_SYMBOL(amd_iommu_init_device);
drivers/iommu/amd/iommu_v2.c:EXPORT_SYMBOL(amd_iommu_free_device);
drivers/iommu/amd/iommu_v2.c:EXPORT_SYMBOL(amd_iommu_set_invalid_ppr_cb);
drivers/iommu/amd/iommu_v2.c:EXPORT_SYMBOL(amd_iommu_set_invalidate_ctx_cb);

A driver should not be using EXPORT_SYMBOL at all, this is all
superseded by the core code that has now been created, but this 
has not been cleaned up.

So the troublesome PASID bit is here:

drivers/gpu/drm/amd/amdkfd/kfd_iommu.c: err = amd_iommu_bind_pasid(dev->adev->pdev, p->pasid, p->lead_thread);
drivers/gpu/drm/amd/amdkfd/kfd_iommu.c:         err = amd_iommu_bind_pasid(kfd->adev->pdev, p->pasid,

And the logic AMD iommu uses to call pci_enable_pasid() is in the
wrong place, it should be in drm/amd someplace not in the iommu
drivers.

This is all more stuff to fix

> But amd_iommu_domain_alloc() also leads to domain_enable_v2(), and
> that's pretty generic, so it looks like we set PD_IOMMUV2_MASK
> whenever the IOMMU supports it.

Yes, it is all sort of messy still.

AMD and ARM have a requirement that the RID page table format be in a
certain way to be able to enable the PASID decoded in the iommu

So the iommu drivers are trying to guess what page table format to use
based on the PCI caps, and wrongly turning on PASID mode at the same
time.

> I guess I'm trying to convince myself that no harm in enabling PASID
> for any device below an AMD v2 IOMMU.  But I don't think a device is
> *required* to use translated addresses with PASID, and if it uses
> untranslated addresses with PASID, don't we need ACS to avoid
> misrouting?

PASID enabling via config space doesn't actually do much - it is
attaching a PASID at the iommu and attempting to operate the device
with a PASID that is the key item.

So right now, the only thing in the kernel which can do that is amdkfd
because of the private interface. AMD says amdkfd HW always issues ATS
with a PASID and never a MemRd/Wr, which is why it works at all.

Jason
