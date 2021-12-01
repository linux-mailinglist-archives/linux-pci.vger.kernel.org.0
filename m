Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F54464E61
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 14:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349377AbhLANDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 08:03:49 -0500
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69]:34656
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349457AbhLANDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 08:03:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjGRLPUoqy1wMYUIfkUT4vzgHcw/tjg19hnaap6ztzhjD7Qr5cgRZlnjvTFtk5odo6gmkkKyxZNw3u/7okGrsxSODGktIe2Sx9cas58v2cUc3zM3lWfHeuAemn4Lnfe4gbBVv/grVg/hsYzF0NCCJRdsbTb2Aj8fRmp7PN3DEDio0WHS6Jfq1kJxrYCu4tP8oCwH3NCiwuX3vo1QIXQ+mRRUNr7DHxJPHJ1mpt+xgHlW+7IZ2gHcblSaCoujBVCUhF0eH6my5oA2XSOMzMfFN2EuTSjE2DVkUZqEr6tAItt3PB+xEZTpOAcXSJlBoOzdd/w/sQTtDSa4sD9kSVXUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEkpm0Sgw4M7XdzD3IWiISuFzyKcEefF7Lhqwt6N4zs=;
 b=JLfTnY2y1+LZbmFeNynIhDRurg1SoJWGJOaz5KSkvPPteyaLdKB4LItEa3p21YR6KcYtpMEYdEkZh6TQnFHBZER3iddKRK4hzvziPabh3WMA1Uk1r+3NpAnWSYXUQXg7LDR8zn+pgOU99gW8EDh1aMaIIR35QwaIpOw8Ae1knYmmsd3ajiCwTjnJiqlXbqAX5nmUJiiFB7GW9nFkWk4bY3Aj3pqwa8xhdeEv74I00z0V1nFDHQfPTDzUCfXqj32f28z+GKUpKL8eYbky4VRgfK8WJRfAajeUZHion/N2/cEFRY30AriFyjDQpg2sqlHrLBPsR/jrKxfOOfGF6SuxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEkpm0Sgw4M7XdzD3IWiISuFzyKcEefF7Lhqwt6N4zs=;
 b=gggpSLqhMdQpMQ6ovl1i6w+T1iN+JaUWSqgfUE0wcamED49gwpXuIzqBfrHcGzh6LZ9Jf8GYqjztUXRtwGd5ozXB96b+iyXFDErZMI0NLNVeJk9A8ZIYHqCYtsPQbnd5datZDo6WEefbAIznBgtXgtH7fTAuqe9vHscAyrRbAKhdowjyt0fEoIXRtxbzZS8m//0RMA7ngfTZh/J/UttNL+9l/YJg1S2FeRSUoKRlsRJGmdanAZEt3rGSRzODWg1Ju24fmd8JIRwLLLG6pOwTRI7AuAE6grlWt4gM+47NagCdJK0FLVI+1k8qjkmtP8CpKLfzOudcSNSmeIbb11K4lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5280.namprd12.prod.outlook.com (2603:10b6:5:39d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Wed, 1 Dec 2021 13:00:25 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 13:00:25 +0000
Date:   Wed, 1 Dec 2021 09:00:23 -0400
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
Message-ID: <20211201130023.GH4670@nvidia.com>
References: <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtlkaauo.ffs@tglx>
X-ClientProxiedBy: MN2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:208:15e::29) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR17CA0016.namprd17.prod.outlook.com (2603:10b6:208:15e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 13:00:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1msPDj-006DJF-JO; Wed, 01 Dec 2021 09:00:23 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487759db-e66a-46f0-14fc-08d9b4ca8aa2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5280:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52808A10798B9A9D3AD93B33C2689@DM4PR12MB5280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoLQ9hyIgQpeV/aqDJwSwbzcr5vR5KkELFdE+ZpHxiQlY6EgWIHalh68tUIip/IjPpS9fOEkMO6nygJ8PmbhzaYwFQv2jkII5Xsyz8XdsQQ4O3BWiBZnGmnK6kjC6EtYpSQOgpWzUo4yKxNd79u3BOXPVO5trh29qM49cPuiDpmKWm9MUmsuU90dvJf07/J/KEafa1Ua5mzXCGihlRUyAR/MYrMCtYMwrpG1IqexMtD9P1mCmb53E7Trfo6aAD2WdlljCVMtK2GYJTdT8Oi6aKRTPm3oFxtCbqmgUGdc4JrO3P2lHBDgnKoZINaybZ29K2mUgYCnfyP9XB+1JkRpSvJ1ktAvLiHRJWjPBIB5hwxak0Gog22fqiFtOHQcWVw/625GmkwwrdZNEHrJjdm48miCfvfJJxNvYji9sYUhL7B+MrshFLZCy9JOuWV92LoQFMvy8AqdnmV4wnZO/BFD0INYMWv+XZtvgO2ShRNoJSy6OafZOYx0eLcq4ToxV07mSJ7Obo0QZ7NTYNHVLbbNElzjuO9vgmKJxUHcB9JuR25TxJL69IcEviHQ4vk0bATqvXvTHZiuj8znOcfTBEV0nbZPL0sI+ySDO99v1Xw9kxNlVdlBdmEvGj9LgfRMTC5IfwD8LYmkvziEvzt2+GQHrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(66476007)(66946007)(66556008)(54906003)(26005)(508600001)(186003)(9786002)(1076003)(5660300002)(6916009)(4326008)(33656002)(9746002)(36756003)(426003)(8936002)(8676002)(2616005)(2906002)(316002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pgvKhu+a/eYwf7+IhB7N6CIc0pTi+2UhvedfbJJFHPYM3AtHrCyRubrOTYmg?=
 =?us-ascii?Q?IJPqPdB8OiLKZh9xqafxIO7dgwNQS+conE00g2gkTMczPZD60H0KDGyTshC5?=
 =?us-ascii?Q?0isKolia9Auu6ksorfxSRDLTDFgOQ72TC5tFumwTIDRUQ63K6XJ0OFaxP1DM?=
 =?us-ascii?Q?K9aNNTMJSDS3pNfoHPE/VBYqWPyew96v6hiGlMqqEY4qcVhiuCfbJqUBwiTH?=
 =?us-ascii?Q?DsYXvf32cOOY9d0ElfLAkED7z8D9FWG8Czjy0zmPYK7WKXUd8OGdKSGJQ51u?=
 =?us-ascii?Q?S5Mvn85Jb2H01CNqL/pV260oX6nlYFtDrZCYY3o6IfIVY3hX/88eqKGXhGI8?=
 =?us-ascii?Q?Gyo4nF3HT/f2q7WK5YFMtIGxJx/g7rKrBc8MFQQ8lltg4G1OK7Lw+NmxI8To?=
 =?us-ascii?Q?IArsgMcYs+R0kigDKAO5YdD0aS4COgzxshhYweFyUjvidz5vhxrk/NnQjdPF?=
 =?us-ascii?Q?pUEJuleVYCp0mnv8T7n4g6QgmL8tNpgOQ21bNuV/LpSS6X4kah59Wqp+LqSF?=
 =?us-ascii?Q?ThZFQUSJd+Z4vFxN2MH6VDioS0//tyr9AaWVuTm6lCCvzHwWMgzgCvie0jW8?=
 =?us-ascii?Q?35JMmNSw4WYzp4sjateNaEd1nJar7Xq7TiLgT2JAFgquIlQC7gwFdIj2L7G/?=
 =?us-ascii?Q?/RTFQpQTbHnKXeQx55GaYe2uIsFPKtnqCpDksFgXAWMY30GDho8lx2TcvTES?=
 =?us-ascii?Q?INUD/lqNNHwpHKwLrMugfKiPysGmaqyLioRsd4wIcak6g445YUi9T+zwvq6H?=
 =?us-ascii?Q?t5pMWaz24XqEBTV7FhH7U/gB6BkS3r7aI5Ye0DZCr0H05DK65RYk0+z6mD34?=
 =?us-ascii?Q?dMXU9tobufKcYaefcBi6ZjQuKEu/dv+P7P7rgn4QiAq5VIczbC73/rBFR5/L?=
 =?us-ascii?Q?QeIloAp65Q7UImyVOeNm3jjNv0KGtvlpDOj5Hk+9djCIs7I3CbA1P3VvNoJc?=
 =?us-ascii?Q?kMJiLw6m2OuR3jYcf82wsu1OQBZ4FVXyVhU62cwdbi96/YJktAC6G2dGJKCn?=
 =?us-ascii?Q?Z5T0UgX9w13r3S5Du+IWBhdhTySrxwkvr0e0HyLaojdtUV53ovOOgDCkTAA2?=
 =?us-ascii?Q?Dr2oOZi0mNhztx83Mg6D8VpWhnAmwOCRmp83QdXVvfnMDJrecQZmcm1qw9E5?=
 =?us-ascii?Q?jaArmlZ+UK9Xd8cy2wDaM0IqMKRhHJMnWEftqoKG1QejKclkO+U8Tc8aR3AV?=
 =?us-ascii?Q?4NAeN2EsJTrhLw5ehyNLdUsec13cDMGSy6s9Q3X/ZpzskqWOfTl8dRZaWFet?=
 =?us-ascii?Q?UKXjsG5bCrJA8x+Gou5/BqBe5IDIyOC15oKHyeqf6BhJh5fCgO9wORflAzZo?=
 =?us-ascii?Q?G5L5FpGDdBG8kzrF8FMP2znqz0Qq+plRoL6hRDWHE2E8Odwyb97uhU/n2Nbi?=
 =?us-ascii?Q?YFd5qZgrmcM9bQ4nFxd/SYqRM4317nP3T1kif3eAO+MPWfABqzhzj5HB1RbH?=
 =?us-ascii?Q?7Ws/M9VT0wNrn1DRSAYHJj0JkN93wqF6KfSgIKZJ4WQeHEseWGm35QdmZQMJ?=
 =?us-ascii?Q?PiyCr7jiDc8648FdS8RmwdpTCMQonm1n4fQRK7IlcvlChd7+ud9+ffGSd3d+?=
 =?us-ascii?Q?a0g3nNnWQHekoKB/hjg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487759db-e66a-46f0-14fc-08d9b4ca8aa2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 13:00:25.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /66EnYJ0w0BVvhceh4ycx0bFFS9zwWYTKaqNgvDw1OArUQqCmYupqi+Y5UZLihVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5280
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01, 2021 at 11:16:47AM +0100, Thomas Gleixner wrote:

> Looking at the device slices as subdevices with their own struct device
> makes a lot of sense from the conceptual level.

Except IMS is not just for subdevices, it should be usable for any
driver in any case as a general interrupt mechiansm, as you alluded to
below about ethernet queues. ntb seems to be the current example of
this need..

If it works properly on the physical PCI dev there is no reason to try
to also make it work on the mdev and add complixity in iommu land.

> Though I fear there is also a use case for MSI-X and IMS tied to the
> same device. That network card you are talking about might end up using
> MSI-X for a control block and then IMS for the actual network queues
> when it is used as physical function device as a whole, but that's
> conceptually a different case.

Is it? Why?

IDXD is not so much making device "slices", but virtualizing and
sharing a PCI device. The IDXD hardware is multi-queue like the NIC I
described and the VFIO driver is simply allocating queues from a PCI
device for specific usages and assigning them interrupts.

There is already a char dev interface that equally allocates queues
from the same IDXD device, why shouldn't it be able to access IMS
interrupt pools too?

IMHO a well designed IDXD driver should put all the PCI MMIO, queue
mangement, interrupts, etc in the PCI driver layer, and the VFIO
driver layer should only deal with the MMIO trapping and VFIO
interfacing.

From this view it is conceptually wrong to have the VFIO driver
directly talking to MMIO registers in the PCI device or owning the
irq_chip. It would be very odd for the PCI driver to allocate
interrupts from some random external struct device when it is creating
queues on the PCI device.

> > Another view is the msi_domain_alloc_irqs() flows should have their
> > own xarrays..
> 
> Yes, I was thinking about that as well. The trivial way would be:
> 
>     struct xarray     store[MSI_MAX_STORES];
> 
> and then have a store index for each allocation domain. With the
> proposed encapsulation of the xarray handling that's definitely
> feasible. Whether that buys much is a different question. Let me think
> about it some more.

Any possibility that the 'IMS' xarray could be outside the struct
device?

Thanks,
Jason
