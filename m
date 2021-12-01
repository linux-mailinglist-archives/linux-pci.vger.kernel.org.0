Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD324643E4
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 01:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345604AbhLAAVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 19:21:12 -0500
Received: from mail-bn1nam07on2076.outbound.protection.outlook.com ([40.107.212.76]:61248
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237423AbhLAAVL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Nov 2021 19:21:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kfm3zGKJ4No+z46N4tqHIh2OBMf9tQ/eKl0bnX17iR5trE7i5g5fZo6zb2bUStE+QWQdDwnIFzszejpEIiCMRiO85+EWAD/VU7Ii06PBLJ339nvc+C3/bHnVLzQU48ZhJHtt3wsVeTFdNOvkumF9JSFiLpZJW5u3G3P4Os0DsLnO4jR1/hSlvrpKpleu4BVK1+81wQ1IZtqeDCrgJyE7HEklhGjDoAWQNkhYDs/0PEfk9V6+dqcJ4tN9J6hiTR3uGXtetBaM8zZ6tYUdElbP1SJJTie4Grgcldu4YYDKg7XD43zF/l7XQi2+RvXJKi8MeY1spxTBMkNDX6s0IdFHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg+1vGZ/7yLn0B7Lsikb9H61ykghmMMQSb5jtXEoHek=;
 b=VBLhzV2pY2RAPvRc1mhKbjYI1Nq9WgD2mR5SdzDUGnTrTbpD5yZToH3oqraTKtxe5GnR+t39h/l/eK923g5fYYQ0cvJRn9LrxDUGNaXM0U7/0z0uj9ILAPtM1SjYgQQ5xBqYkIRiYyO+9TtyjtqPrf3074P13w/q+OWK5ihOd9s7d162iDEAJsvRp3my5zESHAfILSMbBoN4imAaoMvoBmFfEHr1sxgrhsfkwXPWn0f824gZGrTfPbcBAJXsFh/RHT6/995D9ujmR/LtNJxw5U6N3r9nluEvk/2vYu+BnVGp9ZyuIpNka0448iC6dwcnX2RDWlIC6h1/MsvTz/ZwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg+1vGZ/7yLn0B7Lsikb9H61ykghmMMQSb5jtXEoHek=;
 b=gST3emFT7/rKJJK8RAyGKOcVp5033BGlh22MCuJzBLbiULBeP1w3/bIRrNAVp8Dgz3+/mGetVCFlB3+BP6yA6mMnKjPa1C4Q+kSfkiUPqklRbT3Ha1NIL1dtcvhqTl8tn1FZ3zKGF6T9feNAhyJ1iU1xaz5I0Rvpw2TI1ZQwqT2wh88t7/Dm0XpyQdD95wknq4VFXDyQ2xU2+wZoO2KQ2T0k/dC7jVChGtl3tic3iuGhbyvXaGn3F67J5Hlewtvh6pUhNeerodl3dIG7JgMn+1JPIzIWYfZgK295wuOMQq5iiTu8GVyfX3ZNibylkFQCME241foUEA3I+n3aNwERIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 00:17:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 00:17:50 +0000
Date:   Tue, 30 Nov 2021 20:17:48 -0400
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
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211201001748.GF4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o861banv.ffs@tglx>
X-ClientProxiedBy: MN2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:208:239::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:208:239::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 00:17:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1msDJk-00625h-SX; Tue, 30 Nov 2021 20:17:48 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3f6dc0b-fa4e-44e2-d3de-08d9b4600247
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5045929B376DFA5DB6A5BC3EC2689@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fi5g7FgUwVpEQDZ21c0AaLEDtYkK+iR805hrsa7XcZvZBOtNplbAkwU7AiFV95WB0E1s2htRlNfYwabedbXmipQ8zS8DTFf5he9DSWyLtc6inohp3Sq/Viyr5Azq7qSzC9E52Esb8I9FFeUT8p4jFYmPjttQF780rv1dCtjwdnioddWeHsqOKxU8X22oIL2GLaF84PEEpvCo5G9FdntDhZcAX1T1MZIRcFQ6zPaWyIF9Iz4KP3HHQwyDSzQXFMzSCiY0rH5GA88Wncu/C7VFmKlmXdvCD55Bc757RGDrNMlzVDVnDjBtPdH+G1OZXL6BV/KQrknZ4lAd21xneKGcA5NxgTiyXc7ZMpwJ79HfMO32Yyyxtkmex6erwMrJ8dNct9fjGOQ65zvN+TtjIuOC1UcpEKC36YyyTJaYnZ/yHF7yWymCELJ01gPvUI8pCZwGq69+WlF4bObWJsSZSxClQoqPM348dQ5LsF0pXGgl9C8NY7fyHI48wzZqKcwhgoDSDAebm0ObyWR7OiCexBBXuqoCy186nzu0DFEAbNBjySoQYx9zjgS/j+fV7gg1mZeuKCowaKbsaYTXPx/yszUAQRp5nzgzpvGRQsXczBdD/EJk8I2Ltg+F5EkkUw7HUEDcCJYAnfGj5m5THLAELSP/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6916009)(8676002)(7416002)(8936002)(2616005)(508600001)(426003)(38100700002)(86362001)(4326008)(66476007)(66946007)(83380400001)(66556008)(1076003)(33656002)(5660300002)(9786002)(186003)(316002)(9746002)(2906002)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aBMJYoXLNHr7c4GBS4Xay0ZJw56EJmXwIcQoWytXdhe5AlwHvpwML/iWG0en?=
 =?us-ascii?Q?p1IdcZYZdO1n30VChxnnG06WnakmquFY+QZEmd3TS37Op5YztaphWRIN3z1f?=
 =?us-ascii?Q?L2GDWNIgqYGwZ/DdMxU2RKVJbpydi3ItORG73e2Q/j/FikifcCcapIsU9tC6?=
 =?us-ascii?Q?Dq6w4DSudHzl06oOeM7bCwFjsSNikW57bEFMg8hnrNT0erQWa0JN0uvAoVXv?=
 =?us-ascii?Q?GkYPlBPE0RHKlUiiq+QPooJQAB1mOiHvUC1X6aA8/5bQJkWnvCi/LeY6awaO?=
 =?us-ascii?Q?a+omHzu/qipJyWclg6RL6D6QfhrQhhEDU5KbYkPQNRtERzHiNoMDlKBEdYtZ?=
 =?us-ascii?Q?SEHUv8KEIYseltU5a3q49XX/5rFTsXXcyDYtyAkXyKTIlUUjkllbX184f9NR?=
 =?us-ascii?Q?U5seszIJP9tZj2RWHHWXEwQoLDiKe0ddNt2KXxdionrtJVvvmuAR+R0Ux6H+?=
 =?us-ascii?Q?qhSqMrImiF1CokPw3coZcKsHxxicuYQ2v18ntjrygBQ3L5UCr4QDleOY6Y01?=
 =?us-ascii?Q?1L5qIpsaX3jyRGpHqswK/cx1dUXy5T4xk1wb6JMae3x85wA9cQcmuhPlpvxI?=
 =?us-ascii?Q?BbOMImT1FKRVmoxIhN8SE0I8BFDqWj89z47XOCkXKKJkU+PGwv7h6GjucsC3?=
 =?us-ascii?Q?eQ9Za6OL4Eey7HEN68zxqDJ4Up3OC/tjfzSxAhOrmfYrDy++m0fDBUJV8PQI?=
 =?us-ascii?Q?pS76Z7FWELi08PLGygKKpanx5EsMi8OHdaJvUdkMnjpV8CQtHNT+DQJ7D7PK?=
 =?us-ascii?Q?rlWYidPJMMKaL2mDGSybE21d1CTNzpjilDAF8G1FN9odfUXKicReGVyA44ow?=
 =?us-ascii?Q?ynWKeOYAJjUOCM5KDH5Dp4f1RPhNFSqReNqavc0l5WPmOcrCg/xPFWSSTpTW?=
 =?us-ascii?Q?ngZ+MD6LG3DulUwIh7gOtpTtpeVtNUY9lpZ7WBPrkbYoFzBnuwMHxw3dN2bK?=
 =?us-ascii?Q?DgWC4yDrwtjI4VYUn+/XsmiRlPKfHbOebk016SLh1ulo7LVhwXzvcCVf1AN7?=
 =?us-ascii?Q?td2jAUnFJL+8duAvDgie33lV2bFk7uL+gp5Q3Mafhlvl5r1CDf7WCm3YB0Lu?=
 =?us-ascii?Q?zhGdHotKSylfjkFpyKBQhV0aDTBkK0ZU6b6B3elLeHzInNzTclfVOo/SfkBT?=
 =?us-ascii?Q?j/T25WgSUu8bfhN1HFJGreqH8/S8Xf5opDDH1mFfZ0YButus0h9fg8TywLOn?=
 =?us-ascii?Q?lSWAlsOchOMGa3+p3+sgK67yUGKb++ouIrdqdENtl7j6V3qR0OGJCl7TjrsN?=
 =?us-ascii?Q?R5J4elnOZsej4CFqfQyOyO8Qx+5K8WyPVKu8nxU6NA3qn/wyvTlvrdZFFHaM?=
 =?us-ascii?Q?c3m/a/8m4u6j8IPlET1W8ni5xK2XNsSLH4tqz/oahww3eCCGl1j0JfsqVwmn?=
 =?us-ascii?Q?bn+ZErwBjkJUgRqqSCs3qEvSLxGureHR62pNIyptKpDwafnq001bcvXor47A?=
 =?us-ascii?Q?g2wjIgsFusXY4/u3SkuBx0I2NeN8qUnp9CTAS3qLSyX15cSVxXi8gTqLSmzR?=
 =?us-ascii?Q?Iou9nYyjX1Y07HS2suYqFdPQjO/C62LaCb22kZGMBqyA4pQBMGvzl9q8K/FR?=
 =?us-ascii?Q?Nz62llL/crGx1clqx1Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f6dc0b-fa4e-44e2-d3de-08d9b4600247
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 00:17:49.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDE/jBfkytVQm37L9L0hQG0mfQABBDPo/EbT0ND/QFLXRN1BcY5Xu5Sz4RyDFQZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 10:23:16PM +0100, Thomas Gleixner wrote:

> > If this doesn't become an irq_chip what other way is there to properly
> > program the addr/data pair as drivers/ntb/msi.c is doing?
> 
> That's not the question. This surely will be a separate irq chip and a
> separate irqdomain.

OK
 
> The real problem is where to store the MSI descriptors because the PCI
> device has its own real PCI/MSI-X interrupts which means it still shares
> the storage space.

Er.. I never realized that just looking at the patches :|

That is relevant to all real "IMS" users. IDXD escaped this because
it, IMHO, wrongly used the mdev with the IRQ layer. The mdev is purely
a messy artifact of VFIO, it should not be required to make the IRQ
layers work.

I don't think it makes sense that the msi_desc would point to a mdev,
the iommu layer consumes the msi_desc_to_dev(), it really should point
to the physical device that originates the message with a proper
iommu ops/data/etc.

> I'm currently tending to partition the index space in the xarray:
> 
>  0x00000000 - 0x0000ffff          PCI/MSI-X
>  0x00010000 - 0x0001ffff          NTB

It is OK, with some xarray work it can be range allocating & reserving
so that the msi_domain_alloc_irqs() flows can carve out chunks of the
number space..

Another view is the msi_domain_alloc_irqs() flows should have their
own xarrays..

> which is feasible now with the range modifications and way simpler to do
> with xarray than with the linked list.

Indeed!

Regards,
Jason
