Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE344654E8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 19:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhLASRj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 13:17:39 -0500
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:20320
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238924AbhLASRa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 13:17:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE/rHRAiPYEPxQR1Uv8/RDYYm/arXqEW6y3MmCkYCKESGRtvuZmnXHk5mOFYoMctUL0JFulPKPu7wHAjYkJU2rfGngmwx1odvQiuPJ4AAdbo+RXIWi2t2Rp4/IHEz4En+dtSlO0amumaQTzQ/pYDQaU9O22xWfVRFBW5WvJr+yRHbrLGV5PhvIMuJb22TnBBceBkMmKtbyXnhXOoem582FO0LAegPgH1OlcbZuab6QuXJG4EXbPiJXLcDTwbfKupJra5dZEoyKUnolPycICt1haQ7PMsdcMhBxHik0EEeUVVf9uhV318QHgrTPMDK9HI/UzKAEbPbvI4pjBS22rAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/drkoEhu7nZh/phzadEOE8Lq+erAnjghyP5VZJ9WY8=;
 b=KeyKQg7sztx0aiVwgD98mkhy5iIrrWO0jWzIFiO+nr5UrjXusjcT9cgZ08TcaLIPg/Mbr9tqdbURjlKyRncXHVjiWv4m2XuKfUYMjpbpDkkAJ8IlK6u4INaY7c1uzsC0DI0m76c+FHli63CQmUPdgV3agjX2HX0AZGXm2jUmtp+AXqhUgdzPqiZeyqsv0GCU47UvqKqOiPhLp9O8Y/m9+LZF3wzvcKZqhHK8PanLIOTaFUwbi/fR2+jxw1Y9pqX5goRPYfo1TGH+4X29DaI3Jaxl9+JQzkDVJBY9XztHWAUEaS9/meVvFv7VvH5S8XFmStNFyqjajiLC9UePBOddlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/drkoEhu7nZh/phzadEOE8Lq+erAnjghyP5VZJ9WY8=;
 b=g0RP6hNwU4NAB9/w9WmTzpsWFo0UdY0prGtMgzJCzK1EY9thA29MLKLeJSVccCDIXNhogAjPps0pRfTIPifVIpecDqCtl+wUQYx1qgOfFH8MbiEp6q6TeHLema1VThvOkLbnOrRliAMv9zmd394Rfy2N0m5/2alfkh0YCBQg9cf+82fu8doxWo8ZUXLyNhW73z/DnyT60U2Nl30cCdl2HsNZMnYude4RedQSrQpJcEflxLOgzH+g+63AckrmW8iiH9PpeZ3GsoTxRnT6ndv0E0c8PRpf7nNan4eSG7iSa7aN/R05gyxh2cOTHHEecwDl7ICokQclHSTuT+D7SIPEdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24; Wed, 1 Dec 2021 18:14:07 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 18:14:07 +0000
Date:   Wed, 1 Dec 2021 14:14:06 -0400
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
Message-ID: <20211201181406.GM4670@nvidia.com>
References: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2548byw.ffs@tglx>
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 18:14:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1msU7K-006VDS-61; Wed, 01 Dec 2021 14:14:06 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca816ada-6367-46b2-3b78-08d9b4f65d99
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5493056BBAF18733A1A6D39DC2689@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tooc435HsfvuiFOTgyLmU4UgqNRqIoUN+hYf4bdl50UA/dxldRTzVHZZqBq9zQA5PguVHJDQgVPtbluUUOwnz61zneNqzuFoYTLMzuFBBBe9g21yrwI/8idH1sxFNmOza54aLLCFpGibH/rXS3hETh4rB4DiuOHQi0v1h0xlmnDrXccpWVuHC2Qx//dZ9TEOQwroE0hlug3aoM3BH//I1Al+Eq+AX+XjPJcQjlZDtHZOtBgqL+k3VYNEgE8JnHsYV1SYa4r/MHfF1OhOTXZahbD1n3myKfVlQe25KjI0jp1cGDzs/sDD+Lqr92hn9RSokng0Nco9hr668AIVU6ETt6vV32D3sZHF9AmQuy8moVdWXATPUrRohde1xrbmuLXWvuOQmlm7oHbmkChU9EjNYjAazteU/PHmsHkFweyRMDKU3JqVDdPMHuVkp+vquhFg2VRq4Ux4KFn/wnRjafhQoUAYLUdqyihad15hfvjCE6KVnlMzu3+vfCfttCb9hiJNeLwMJIzC9fIq63u6PFtxyxN7Uom5H7VgM+uOqyoq22PqBZtbEyp2I2x1Eupo3rgCxWUr0/tmofipWVnGUzZ73jVjtTOl38siyVd5t057qPz/NiEkYcyU5Vfyu5CJlh3TiEaNZPX978OhWBCl0Z/0BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(1076003)(426003)(508600001)(316002)(33656002)(9746002)(2906002)(36756003)(66476007)(83380400001)(66556008)(8936002)(6916009)(5660300002)(66946007)(54906003)(4326008)(38100700002)(186003)(2616005)(26005)(9786002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llI5b/lyMhd8gG1ZPmuCIdNISi77mu8IHX+gstCZ0HblnrtRYvgS609dIChy?=
 =?us-ascii?Q?g3IdcVpTnooTpY0+v6L3BRmDkYFCH2+SWdEEOV9BiiUaefz2FWdIiVdhzyy8?=
 =?us-ascii?Q?ZKHUWL6n2T/9du2cbyYEzm7Aft9Hpa10ia3wzP+NrlsJmdWH72ejSI2l8u8W?=
 =?us-ascii?Q?xzPK8TzaNxtjn/r4ShoLi3FXSTrKssFOngQHcttcheBDKWe1I10OEzIuSEBY?=
 =?us-ascii?Q?n+hJb1f7QmZaMpJnCFcwxh81DLXqGxxqptdpvKTWT2E9w/IR4jTiQ2DVE9vw?=
 =?us-ascii?Q?jGXrTrgqw4+OOarrJaI77k5zT114heoEdDIF3XRqSgfE2Kvu1fNbpOXZkGC+?=
 =?us-ascii?Q?sjQmynwzM0POehlw0H3evhEv42vFSvVLwtluqmCiFzBuCmnhudlST3k1sVXF?=
 =?us-ascii?Q?NMph/wrpnHlDasjAIU5r20NcvspaCQHh8Hh+Bp7LA3cm5rtPgR3JKB5BsVu1?=
 =?us-ascii?Q?5tIX81sKFsSIGyhYzm+1kffIi2We3xZOCgfYWKDlKnYzc8CXAGnmYNM1gAqW?=
 =?us-ascii?Q?urNY2IvDCuY52REtZ6J7MkOw3arxaTCjzp2Bx4B2frkuCj0aSPEjMD0oDyqY?=
 =?us-ascii?Q?8VhisZGIS1B8T4TppOcXk1BfxmQFfo9UzTYsA8HHwBUBsA1qF1l1H/WQXJU2?=
 =?us-ascii?Q?uXB9IF/YCIuXKftHB+fa9QJQgnjGxDMixKyYfSFE/9+lFXCUtcA6m1DWOsIV?=
 =?us-ascii?Q?2OnsnBxhlXgYeHG7n9EvaFyHktnc9o5/I+sNXA36OIbGKrQYY10/VJkB0F2N?=
 =?us-ascii?Q?gOLAim4E7dBKCO2IuZtZlJIuZgNztolos3SGM2hhtAFqe5/A9KjMAoI8ygnd?=
 =?us-ascii?Q?a/TQgFAeHEJIHCXsp3fP2YRBjZmN5VDhtM9AQ43H5tsN8d5gv2SkaFtC3QdI?=
 =?us-ascii?Q?3bc017HJ2oTHx2WiVxr6bFHSTUUxlRxUDVTqH2K45bIfwN/oLJ5OotY1O6JA?=
 =?us-ascii?Q?qw2SxhlkU+4wbe5KfOwhMDSC82Xfz56M0xP8k64PZI6M5Xg7ilIGYBZ7ds1L?=
 =?us-ascii?Q?0FNUYJSgqO1+DssnJt/4VH0+mulEftWl/umSaHFx9mnWj4yyiNp0A48ctmb7?=
 =?us-ascii?Q?y0ySGCi7td2yNkinNNy6r8Uv+8LUwr4mUpKJZQPpCk/jU6CxzgNdVD3PbZLH?=
 =?us-ascii?Q?4rgcDExva0ItFCuJ5T3vBfj2qZOQqkLTDY+wwLxVxnGxbQYXgBXVhuzxwPu/?=
 =?us-ascii?Q?6XlslvzKYXzR+toDRG+e6m5yCRLeGRaPO2JY/eIYelprUtT+/KPZ5wRqmDYH?=
 =?us-ascii?Q?hiA/KnbUVzcJw3yy3fTvGZeLrYbd6NZGM80C+CR99tQXO+9d+GiWSaoOlBMJ?=
 =?us-ascii?Q?eR5Tteo2lvD+M2JtoU6e8t4uvdg4oUe/6ggsWJE04RbgjQrwuPwYlN0r2J5x?=
 =?us-ascii?Q?K1oJnKqprF4+jQMxeDGE4KfvIkJIq3DJ47qMjx8hBrvqDydA2mtmsYJuHSbg?=
 =?us-ascii?Q?D41JC98A34UkxL889oTUaZ9qEdRWzqfNCxZnFYJJ/B4a1T/9g+HSifTF3APm?=
 =?us-ascii?Q?wZDdp7JP2dFfS9lvWo1NuVLo9BQxUdvYe2xd9G4kZDUCKKgTKRJNtGvgKIgz?=
 =?us-ascii?Q?t3009p88R2MkoCD2or0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca816ada-6367-46b2-3b78-08d9b4f65d99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 18:14:07.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7b+iAxIE8zKW/3yDHgcto0NrQg8iPaBQx0a0KUbBfcC7PCZdkhXCaG9L9mb+JoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01, 2021 at 06:35:35PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 09:00, Jason Gunthorpe wrote:
> > On Wed, Dec 01, 2021 at 11:16:47AM +0100, Thomas Gleixner wrote:
> >> Looking at the device slices as subdevices with their own struct device
> >> makes a lot of sense from the conceptual level.
> >
> > Except IMS is not just for subdevices, it should be usable for any
> > driver in any case as a general interrupt mechiansm, as you alluded to
> > below about ethernet queues. ntb seems to be the current example of
> > this need..
> 
> But NTB is operating through an abstraction layer and is not a direct
> PCIe device driver.

I'm not sure exactly how NTB seems to be split between switchtec and
the ntb code, but since the ntbd code seems to be doing MMIO touches,
it feels like part of a PCIe driver?

> > IDXD is not so much making device "slices", but virtualizing and
> > sharing a PCI device. The IDXD hardware is multi-queue like the NIC I
> > described and the VFIO driver is simply allocating queues from a PCI
> > device for specific usages and assigning them interrupts.
> 
> Right.
> 
> But what is the representation for that resulting device? Some VFIO
> specific homebrewn muck or something which is based on struct device?

Why is there a device? A queue is a queue, not a device.

If the task is to make some struct device (eg mdev, or cdev, or
whatever) then queues may be allocated to do this, but the queue is
logically a resource handed out by the PCIe driver and there should
not be a requirement to have an external struct device just to create
a queue.

> Right now with VF passthrough, I can see the interrupts which are
> associated to the device.
> 
> How is that going to be with something which is just made up? Does that
> expose it's own msi properties then somewhere hidden in the VFIO layer?

For sysfs, I think all interrupts should be on the PCI directory.

> > There is already a char dev interface that equally allocates queues
> > from the same IDXD device, why shouldn't it be able to access IMS
> > interrupt pools too?
> 
> Why wouldn't it be able to do so?

The only 'struct device' there is a cdev and I really don't think
cdevs should have interrupts. It is a bit hacky as a in-kernel thing
and downright wrong as a sysfs ABI.

> The VFIO driver does not own the irq chip ever. The irq chip is of
> course part of the underlying infrastructure. I never asked for that.

That isn't quite what I ment.. I ment the PCIe driver cannot create
the domain or make use of the irq_chip until the VFIO layer comes
along and provides the struct device. To me this is backwards
layering, the interrupts come from the PCIe layer and should exist
independently from VFIO.

>      When it allocates a slice for whatever usage then it also
>      allocates the IMS interrupts (though the VFIO people want to
>      have only one and do the allocations later on demand).
> 
>      That allocation cannot be part of the PCI/MSIx interrupt
>      domain as we already agreed on.

Yes, it is just an open question of where the new irq_domain need to
reside

>     1) Storage
> 
>        A) Having "subdevices" solves the storage problem nicely and
>           makes everything just fall in place. Even for a purely
>           physical multiqueue device one can argue that each queue is a
>           "subdevice" of the physical device. The fact that we lump them
>           all together today is not an argument against that.

I don't like the idea that queue is a device, that is trying to force
a struct device centric world onto a queue which doesn't really want
it..
 
>        B) Requires extra storage in the PCIe device and extra storage
>           per subdevice, queue to keep track of the interrupts which
>           are associated to it.

Yes

>     2) Exposure of VFIO interrupts via sysfs
> 
>        A) Just works

I would say this is flawed, in sysfs I expect all the interrupts for
the PCIe device to be in the PCIe sysfs, not strewn over subsystem
owned sub-directories.

For instance, today in mlx5, when a subdevice allocates a queue for a
slice (which is modeled as an aux device) the queue's assigned MSI-X
interrupt shows up on the PCIe sysfs, not the aux.

It should be uniform, if I assign a queue a legacy INT, MSI or an IMS
it should show in sysfs in the same way. Leaking this kernel
implementation detail as sysfs ABI does not seem good.

>     3) On demand expansion of the vectors for VFIO
> 
>        A) Just works because the device has an irqdomain assigned.
> 
>        B) Requires extra indirections to do that

Yes.
 
>     4) PASID
> 
>        While an Intel IDXD specific issue, it want's to be solved
>        without any nasty hacks.
> 
>        A) Having a "subdevice" allows to associate the PASID with the
>           underlying struct device which makes IOMMU integration trivial
> 
>        B) Needs some other custom hackery to get that solved

Yes

> > Any possibility that the 'IMS' xarray could be outside the struct
> > device?
> 
> We could, but we really want to keep things tied to devices which is the
> right thing to do.

I see the sysfs issue makes this a poor idea as well, as where would
the sysfs live if there was no struct device?

I'm inclined to think either of your ideas with the xarray are good
directions, primarily because it keeps HW data out of non-HW struct
devices and maintains a consistent sysfs representation for all the
different interrupt allocation methods.

Regards,
Jason
