Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25B54664C8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358373AbhLBN6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 08:58:30 -0500
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:40737
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358355AbhLBN62 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 08:58:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUhDshf1ZF1Urz6u2ISWk/LBeVWZ8UFKjWlsk4Rs77hO2jwfJE8j6x+tgyYC4j3+lTdyP57TKKRLQpvP5P1wZGxHjTJwFIOyPK/K1ojtb+J9qFIX4dC80/kMeOUC5zDOZBmxSct6B39izS+n4yiS7IfHzLk5COQTWKUquimR0oDCpjMCtcJmh+oZ9yrP93KhaiiNQ21KuDyipRPuJCmOFg4JPNIUBcLRD+pR7Ma0qtdci9dJufMxrnWWHX9vza40FVKOkXLWh042ZWkb2PBV9GSBrxTU4oEJdDsg2K3r2xNi0mYAVfOlgPd57+Y/y4EZ74QXNmrZUwzKxt+tbEMXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJG/8wULDaO7GKgoOBZHMVL7ikcFpagddB3jmecP7QU=;
 b=Wh7dhHqqmHyfQOiD0EpytLTVb9CVa92zrp3pUWSurIk2BN7Ex1gT/MFImD+mNQR47KbcnjsN4RrN9MFXPrsoDYkTK27X/EGY9/irA5OeiemuBxGeL11WaKEwobiMlIl9D8oRmoyhCpJGEuM3XIyi5umK8zXo849FxsqATdUa20gu5+3+7YHC0FyC6Cd4ljQHPa5GXPUHt2gbnsI4FMxMDmx45anHkMACtu6ksBZ6uBdVtB1sQoeb5FOFKrNxV32PfduFdrdxz92sCYDzME9cn4/PBeMMgzUnko9k8lNUkCOY4nw7J3z4STLFqHpx6NtB5J2Uerf/GXHUovgfA0a00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJG/8wULDaO7GKgoOBZHMVL7ikcFpagddB3jmecP7QU=;
 b=is00GuVARRk+RbC2L7QJffw2u5uk85USeeT/8emnEml+2cq+5SdV3a9nx/6pPR/YbKNkTOL5YB1Y0ei/e8CFqohsecAsux2AdUNl6M36TWzEuQ0WLCdthS+zUWJdXqE6zKPXuSwzQlt6XV3jyaHLUepys8Tv/PfO2y5FX3XVmEfuoyCYsgenDPuveBJ3GrwM28DPPSWAx64yWlfKSAKnHELauqbN2AhY6vT9sQS9ImVveyyW3D2pXS6RKIb4UEu01AVXsn+xNhmUX08DJ6H+pPOPGUb9scuEISuEDpEtC3n3d4l1AZYkTXgsAtFSmRgF9rbKvKZUVnk0Wwiea/pGRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Thu, 2 Dec
 2021 13:55:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 13:55:03 +0000
Date:   Thu, 2 Dec 2021 09:55:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211202135502.GP4670@nvidia.com>
References: <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1av7u3d.ffs@tglx>
X-ClientProxiedBy: MN2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:208:1b4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 2 Dec 2021 13:55:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1msmYA-006rEm-Hc; Thu, 02 Dec 2021 09:55:02 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dc43f66-a4d2-44cb-58d5-08d9b59b570b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5335:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53350C926591FE56F22F130FC2699@BL1PR12MB5335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbiSfJXKQjXEqDq23f1P0x8j8DmykDYVUEYLNeuy5eA0lwVYK5vu2dPiU9ygnhsOu8KvommqwJWMF330ea34YHnHfQeL0OX3ZkQMo8FKCgcXK19gRrCaI2cyIqmJFS4SmuqX0e88tUR90JRh2p8rP4GseC1/ZuAUheDOvxvM9/v5bjMyC5fHV8akpgHvaAkVwjwUbrqXekQKuOkRGZVC4Vx7cGFOTDHcaaBBh0pei8CE531g1g9lz67Aw+GeNL1I9LZvnxCCfOuh+uJlJf209sY1ftd4pJ+MwZp+ySZxsWhUWJfguy/09pYfKUmpvu61lLmqS/BcqQH9uSRdh8W6L2TWfrXwQx1TfnlezWMdPq0I72LgUn7Y8PQIDCFJWwT8bgXAAa7SjnoyVGchTBaqkLvqMFKTgHRZqirtwN9Oo07G6d9pMf1OGs5j2hpXU/t1miS/sOeIPFj64EsZF7MNETI0/vxr1AHLdtaxZbi4VEaLjBhnTrtDTRCJXecLdvlYp9ZVqvasIH0h3nzy46dtIqVKQ+mol+WwzXNuXRGUwgwNmGAzbBlv/GS/2F3SCQ7bkrIooDR8CH6OnlQY6oxMB8AK0GTtnWrByqo1YsEmX278uU7hqrsqD3E3C4PMpX74o0ue6rrASX0hFGSiXuqOlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9746002)(9786002)(6916009)(8676002)(26005)(186003)(4326008)(8936002)(54906003)(86362001)(5660300002)(7416002)(66556008)(38100700002)(316002)(66946007)(426003)(2616005)(83380400001)(36756003)(1076003)(508600001)(2906002)(33656002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fX78J73ccCHHCFIjaucx8HssmlMi8Zfl8x3UBWXZUgp/IWdE5BAvDd0hWNS4?=
 =?us-ascii?Q?o7MCXnOOI6yAIR5UFSijWH3cwuVO6tielLDFtQMKGbLfT1yNWFOBss+ON5aL?=
 =?us-ascii?Q?0Pv8jE9qTj8gZrszi0kAui2IbuWP9IjRlH04ebrWS7qBWmj8eQWb/sJY9WuY?=
 =?us-ascii?Q?EKtNnos2Rdjx4gq9vR6RHb2L6YhQCFdyJogfxoyQirMbPJOehjUVSgUvQYyw?=
 =?us-ascii?Q?ScGkDhy4cQYRAa3lenHh752EMGDwWWp+Xwv229p00wIwLJtcGaSO/2GZVSyT?=
 =?us-ascii?Q?RMk3ZZA4TeR6Pj8vO6n6GuSYw90ZY/ISYM01amBh1T81c0jXEjbgoLXbV1OB?=
 =?us-ascii?Q?rhhgb0uuSVl4BZGZOBkIQx89NCw8rWc4HwUAKG29qVtz67BcUI9xFsfySONb?=
 =?us-ascii?Q?utIr29mnGHX7oM/fS0kO4+cpCyAlrU8G/SQcXRw+G7I0w64Pyu+5AxQxOWRb?=
 =?us-ascii?Q?89LoYvEgSYDCPf27qqTdaMEYk9RmUK5OGkbN/E4pOkDnqRYW+ax5bK8B9fW0?=
 =?us-ascii?Q?TXPc+ksjiCehx/gaWQep1SHb9J2Y1fWiCv1T9jiE4GUEH3vtWe7jvr8gAfcG?=
 =?us-ascii?Q?74H4DOQewVLI54dEXqDeC8SFxLrnFKmTLQNixOv2v0s/5s4oxHeA+xdSn3Hq?=
 =?us-ascii?Q?6cAtcLeeAgXfnh4eumoFtZQB6oZ6YkCxM37q26cigymBYO7APV8jrZzj66Ms?=
 =?us-ascii?Q?Iseu3R7vtrUTtSjsMHBIUC32/yud942goVpxhjpPe5T2K4O6CVB38wExkhuo?=
 =?us-ascii?Q?ziO4J557S0QCXKhNFYAYCsCNXij/utBNs6HfDVLxPoMEp/52FXgUCLzWi/le?=
 =?us-ascii?Q?QNgGyL+ynuHCNQKLwGZMdPW5NNTT5B1yjeCPVxNeL8GwfBd57lh67zzpnOni?=
 =?us-ascii?Q?gswBTtXFMQhypDSh0Tt3Meg29e7UgIqAqlEF3gLGAvLkteRLQ+puhAm7U8c7?=
 =?us-ascii?Q?HiiQf2i1pDtjDat+PpZuV/VPVxnSlMIFBfF5V+Ffn8zkxCKK4kyp2O5UvZs5?=
 =?us-ascii?Q?eabWeK0yHeHk6zCqdfCtGg6tAMEL5hyNVR/IuFXQSTR2W5NyBEzR5YF1RwPD?=
 =?us-ascii?Q?nBCnU/KkYNRxkI8riO9tIP4hDXZwH1Y66eM3gsi7XRwWkpc2JO1CcQGhAbhX?=
 =?us-ascii?Q?jp9PrAyrDYEEL+grGquHV4MUTU5WvYK/TCY+6O5xRGhCVG3Zu6sMyYXlkd93?=
 =?us-ascii?Q?QfGwbWpr0rfUlPi2MmwPm8LM0kZbSnZqhKdMrOo1o6iOWn0G2/z/l+xv9NpA?=
 =?us-ascii?Q?8qS+No4tN+odR/Dh5ALNgdwNLGsFOg9AADSEtI2+DUx0hibyfpowc5bwxXpo?=
 =?us-ascii?Q?4NwpjOqPtgfaKxQEGJJvxy/6qKCYUfJ9u2Makkk9V5D133+1XOmrL9ECsMhW?=
 =?us-ascii?Q?n5GftYxxoFq6Edm9/Ry/hoMTU82b7w/txMsHPQz2M+J2ut6IFeSoZMu0c9Ql?=
 =?us-ascii?Q?15mtfoYo2Uzxdc6h1FUwT/oowS5qvrPkFFuosBO06XJHpF8OBCV/xDz3q8yI?=
 =?us-ascii?Q?AbBLxU7LYu1zHTkAbQsZ7Elio7ta3G9rw3P7tiYDjIqvOlA63GGvQizkpkbp?=
 =?us-ascii?Q?Cb8afhRxbjEC3hAkTtw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc43f66-a4d2-44cb-58d5-08d9b59b570b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 13:55:03.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMGEhjGZTe3XmX7e7UpmGrW1NEVlPCiahNWAUuIf/FbVaD0FAFHsnYWKHvwUVAcT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 01:01:42AM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Wed, Dec 01 2021 at 21:21, Thomas Gleixner wrote:
> > On Wed, Dec 01 2021 at 14:14, Jason Gunthorpe wrote:
> > Which in turn is consistent all over the place and does not require any
> > special case for anything. Neither for interrupts nor for anything else.
> 
> that said, feel free to tell me that I'm getting it all wrong.
> 
> The reason I'm harping on this is that we are creating ABIs on several
> ends and we all know that getting that wrong is a major pain.

I don't really like coupling the method to fetch IRQs with needing
special struct devices. Struct devices have a sysfs presence and it is
not always appropriate to create sysfs stuff just to allocate some
IRQs.

A queue is simply not a device, it doesn't make any sense. A queue is
more like a socket().

That said, we often have enough struct devices floating about to make
this work. Between netdev/ib_device/aux device/mdev we can use them to
do this.

I think it is conceptual nonsense to attach an IMS IRQ domain to a
netdev or a cdev, but it will solve this problem.

However, I would really prefer that there be no uAPI here. 

I looked at the msi_irqs/ stuff and could not find a user. Debian code
search found nothing, Greg redid the entire uAPI in 2013
(1c51b50c2995), so I think it is just dead. (maybe delete it?)

So lets not create any sysfs for IMS with the msi_irqs/ dir.  We can
revise the in-kenel mechanism someday if it turns out to be a problem.

As to your question:

> So again, why would we want to make software managed subdevices look
> exactly the opposite way like hardware/firmware managed subdevices?

That isn't my thinking at all.

Something like mlx5 has a hw/fw managed VF and there is an RPC call
from driver to device to 'create a queue'. The device has no hard
division inside along a VF, the device simply checks resource limits
and security properties and returns one of the >>10k queues. Again
think more like socket() than a hard partitioning.

It is the same as I suggest for IDXD & VFIO where the PCIe IDXD layer
takes the place of hw/fw and has a 'create a queue' API call for the
VFIO layer to use. Instead of using a VF as the security identity, it
uses a PASID.

This is a logical partitioning and it matches the partioning we'd have
if it was a real device.

> So if a queue is represented as a subdevice, then VFIO can just build
> a wrapper around that subdevice.

I think that oversimplifies the picture.

IDXD is a multi queue device that uses PASID as a security context. It
has a cdev /dev/idxd interface where userspace can use an IOCTL and
get a queue to use. The queue is bound to a PASID that is linked to an
IO Page table that mirrors the process page table. Userspace operates
the queue and does whatever with it.

VFIO is just another interface that should logically be considered a
peer of the cdev. Using VFIO userspace can get a queue, bind it to a
PASID and operate it. The primary difference between the cdev and the
VFIO mdev is user programming API - VFIO uses IOCTLs that carry
emulated MMIO read/write operations.

I consider *neither* to be a subdevice. They are just a user API,
however convoluted, to create a queue, associate it with a PASID
security context and allow userspace to operate the queue. It is much
closer to socket() than a PCI VF subdevice.

Internally the driver should be built so that the PCI driver is doing
all the device operation and the two uAPI layers are only concerend
with translating their repsective uAPIs to the internal device API.

Further, there is no reason why IMS should be reserved exclusively for
VFIO! Why shouldn't the cdev be able to use IMS vectors too? It is
just a feature of the PCI device like MSI. If the queue has a PASID it
can use IDXD's IMS.

If we really need a 2nd struct device to turn on IMS then, I'd suggest
picking the cdev, as it keeps IMS and its allocator inside the IDXD
PCIe driver and not in the VFIO world.

Regards,
Jason
