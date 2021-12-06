Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3C469882
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbhLFOWy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 09:22:54 -0500
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:40161
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244558AbhLFOWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 09:22:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnmuz2Uc6a0R4rEzUReyBjN4V3CaA8lb47vKd1CV20CVLVyXaOcSTAp0y8a3Au+g1s0qNGud7u8CcgM4vgObsGJbKv5u8i1WYtiquNe4R05jz+hGLDRrUksSG3UBDcu/OOJeAq+Y28b4DgDes/uJ9SR14sRBdyPnBJj/K7Bb3NnyMoTG5nXcAC6N3gvpnt2BUu8mon5aMm/dg5FkCAzvNuEt8LZGjKG/CMGuG5kBAR+NU2kRkWtRq4cNLC/nEIklgoerZgr9laCxzXh2a+mB/xoDsEbJRv8jO2mME56O+mnYkw1GUgi76ceWF7avKJbyw0e8ZeXL3eqA51AqLw2MBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s33L9I9tWRsuPN1BuFQQ4V50sW1tbQOR8xkMP9Iv0d8=;
 b=Sji+6fYENl2qeuxKa+cfyFHOlj2fG727PsM7XLXy1vLcs4fwYf2QoEABu6SmOck29isOog0vtmx1vcKo+v5y5qwoISdGbFg9Gf+L3Dx4aJd83lB2HibQEHrJQTvEjCSE0tx7ULcxpylCRcyulJ8nt+JBcSbn/mRHoYHUvVmyebYgntZ/rVERBclK7diDK87eE8rtAOwQkUiAG4ieafV3mN5zxuFcbIqOde+3tuFc9FV63ZDfr9D3NAI5njXhIEX9FPl0cpCobRoVhwkwHH/Stuu1L/V2DnrvcPOrNSeX5hMC7p+FPAMZHJw8VjSQrHlR4P8QrQjBXizrNZqudRJv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s33L9I9tWRsuPN1BuFQQ4V50sW1tbQOR8xkMP9Iv0d8=;
 b=ksINXdoGhMqILuFBhkEvflVNzR4GWItuf8SxTbr+JVw5JZdrd9uFdit1HTreiEvrVsv56mJbhF8jhwLN5046zrf1J8GG/G2tjGGnrNY35VZyhSCdcI3JZW4JtkQQQyc6d5eeLKBjwQB150o7oiqCf4jD5yGQBPW2hN17rohbfS47vGlvlAxGtQholiMBS3UMOzqDkC/swlSYU/wrxLTH/oKVhaDWoG0ZWOsRYfXiOPN5FBAr00eUFt48hTGfD0HG214eVcJ7zIponlSbHM+OjDOZrqhh1iBXiSIbdcRzCPRfDJKzAHTTEtGiyCAaNVVZJDL/Sx21PBcr4C+wpoQ+zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 6 Dec
 2021 14:19:23 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 14:19:23 +0000
Date:   Mon, 6 Dec 2021 10:19:22 -0400
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
Message-ID: <20211206141922.GZ4670@nvidia.com>
References: <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9044fkb.ffs@tglx>
X-ClientProxiedBy: BL1PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0099.namprd13.prod.outlook.com (2603:10b6:208:2b9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 14:19:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muEpu-008wJd-Cr; Mon, 06 Dec 2021 10:19:22 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7bf6166-9883-44df-e64c-08d9b8c366de
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50773C662AA0E526C1D576ABC26D9@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziXlJLH5sUn3pszwfZcvSt8eyCqqH/MKuu8PuHpZLiJ7BCB2SClIZe3b6D7IxrYXeZn7HNL5g25HLtfCJRXdr+F2sZvegUL7pq5MZPZ3GZ/W26nFJg3oiDG9MRsHWxXtUkF20x6oIfRvkKKOUKe5Hu+DpSpztpqVCPTNqBi+QVV9bYqBODVMopUuUib0oHWzsPEykGZoTC0X0BrORsBBl5C3q5mAz9iXNCa9GRXeJWbcfZwcY0O/JuLXxdLQ3yLB+ZS+tWfi5eB+unvfUjvvd97J/SARbSFFpCM50aU90Ee9pzGDgNI6IlG4pmqZOiN5IzFD7ZnmbGL/9ryojsiK3YWGyDIncX9ugDeThgEV0XIv9lLXKut6ODPlXvg5KYactdT+tDV1K8ccnVXPdXmxmNsdKcZihNOXnOBHKrGHkXrk+cw9LOTj4nQ2tkkpyIn+ZFd8LwUT7koYVqXvlHJq5st+hhcxfsROHHMiuqvd9hovoNSuLm0LRCGt/apB1N/Uw8MTb2EhtXIqmg2xkWDdickC015YCWwuJovQnxcVZfDOr3XdzTd+yuTgR4lx0ffh42FCKnvUWhHavHxNBn2XGWCoyD6j7rfU7/GFc+fHTAAPT+jotTktUZ5TDAljKlQPmjEEprAZczOdNJZFfQiQbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(33656002)(83380400001)(66476007)(66556008)(36756003)(66946007)(508600001)(7416002)(4326008)(5660300002)(6916009)(54906003)(86362001)(2616005)(426003)(38100700002)(9786002)(8936002)(316002)(8676002)(26005)(186003)(1076003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsPPD0sQ47SWb5kJqKM4cjW7v+CMfuZ0RV1qzYUFEABibKzrI/nA1J08R4p2?=
 =?us-ascii?Q?1g5tK5i9OCldw2ApSbjF62qYwsYEaA2r1DLHRTMLMLEJRlwGWVy+aXhe8nTA?=
 =?us-ascii?Q?RYwNusbVDUzRNigfbSnamucQRCsIdP4K7Vbq5k2meIWXlH9B973gwvmBR9HQ?=
 =?us-ascii?Q?24VtfTPHEay1wvd7rvKwhEFFEz0KfAGKVUFIzc/8WvHY/bSeJjbtIcXENs0o?=
 =?us-ascii?Q?XUQiPWmqRVigFs15G95PVkvonTnjmSFevaZasVAr73gZ04Gwb935IJm8Ixtf?=
 =?us-ascii?Q?OC/JZ9Xz30JlzvMHmJMdsQyg+81xXqjW3G90z9vF0h0h7AMbFNEpNd26uBXn?=
 =?us-ascii?Q?J+uIloVivbn++BUZk2WfftwA+KzPPIkoR/ZEnTjkaWgTm1IQwf/m3oXeyy+K?=
 =?us-ascii?Q?qx9+KPR+7S6VNLb7r3HDYIqw4hBoiMdaAwXF+29SnBAnT/yxVRHz5ABCOMJl?=
 =?us-ascii?Q?EG63rD+Wm+XK6cB+HwVxyWFULvUX0VmgAFrI9iSk6stTn5Tk/qMzrs/8f6LZ?=
 =?us-ascii?Q?x6tR7gwMNYHm/hzuFgLqdMxE/S5vaEhUbkn1As3lsKopRjTKMI4XlSuM01XK?=
 =?us-ascii?Q?I1ENuE1PS2f90eoYTyZZ5tE+6e4Ts8ssgRzgj7eR7vpNcz05IxnYX34c3hi/?=
 =?us-ascii?Q?KCmev0uyiPJ2pMrAMNDoFFlqyPtpEKjQl5Wt4vUpRpHubE7Hdihn+YFLFJK0?=
 =?us-ascii?Q?jgcv0GuQJXcWX+XelPVJqd0z9JBwcNsKEieEIYCOKEPWy2twSGLjkVkYp3SI?=
 =?us-ascii?Q?0zA+7SDpakDNBof7FttLjHuufynA8JBILhHguw4/ES36Qu0cdVaXpXt2FAvX?=
 =?us-ascii?Q?uRMF1Aq+X/M9Xq4S/APr0lO2HfYCRmV04PNDhkXjI3JA50hAvVQuAtb3zVMm?=
 =?us-ascii?Q?SpGlu7dWRPGZFSfZlePZXxfFFI8XsnewQUqge0Su9eopl7EC09ixTLPljoYp?=
 =?us-ascii?Q?71426u/aEIpS8ZpQk68NDOaz9dJNTxhVvaifQPNqy+llgQ64TxffARN6cGIL?=
 =?us-ascii?Q?3ZrG/vQuOWP8LHf4db41h6kn6ww9K5pQIewahGLyOIn5cAmMp9QWFnJzC6Mk?=
 =?us-ascii?Q?/S6ZSIE1IywH30TjFb3QxF0j/6TkwPcLhA3RSsfM/OTgmNQShJuSJSIAhDN5?=
 =?us-ascii?Q?MLd9yPeTUcq8r1DPUchroi24m1l0bWVIIbKIaWGiH7M62jmkp4iGA7vClkv7?=
 =?us-ascii?Q?WlAA+GM+0W9UWocPGujOAMeYytckKDyB1sWqcT1bJ3qna2A9szOSMYlpAXCt?=
 =?us-ascii?Q?QuYI4xxyOK+3pYmZmzSBQZ//xalZoIZQi9sB/Fgxmk8X0hq9QZgZaOwR7zk2?=
 =?us-ascii?Q?sWJmJ5zISvIt1iOW6Dg9L+LwwHW1kDJ4EkApvPJJBksQWbiEsraknNtKbZ3Z?=
 =?us-ascii?Q?li9c2YVxw2Sh1K7DmKhAdDcECEoGMBi0uh0LG31fLMymfJ1pPxJyft0F6K6c?=
 =?us-ascii?Q?ErHhTm+ct5xklVrRJhpP3yFqeOy6BzYLoOXMD05dbaakKCsWMIF/w3ad10td?=
 =?us-ascii?Q?SmMhybGYKEn8jIhoWQEV4tFO2PVGz/kVirauoVwQT96QQnmH4uqIH/quPN8P?=
 =?us-ascii?Q?7GlPI27xFKVFvUpZ8aI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bf6166-9883-44df-e64c-08d9b8c366de
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 14:19:23.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS+lLoTetQsZ/T4eURkiJe1eM+TQQMSm8ySYHl86m4vRqgtZTVj3XzFFHMskOR5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 04, 2021 at 03:20:36PM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Fri, Dec 03 2021 at 12:41, Jason Gunthorpe wrote:
> > On Fri, Dec 03, 2021 at 04:07:58PM +0100, Thomas Gleixner wrote:
> > Lets do a thought experiment, lets say we forget about the current PCI
> > MSI API.

I've read both your emails, and I'll make a few small remarks on this
one, mainly to try to clearly communicate what I was thinking

Just want to call out the above paragraph, not suggesting we do it,
but the thought exercise of what should we do if not weighed down by
endless engineering cruft is usually informative.

> > What if it worked more like this:
> >
> > probe()
> >  // Access the real PCI SIG MSI/MSI-X table
> >  mystruct->msi_table = pci_allocate_msi_table(pci_dev);
> >
> >  // Special interrupt 0
> >  mstruct->desc0 = msi_table_alloc_vector(mystruct->msi_table, hw_label=0);
> >  request_irq(mystruct->desc0, ..)
> 
> A device driver should not even know about msi_desc. Period.

Here, this wasn't really about the msi_desc, it was just about some
pointer-based handle. Call it what you will, and force it to be opaque
to the drivers.

eg this 'msi table' layer can just have a 

struct msi_handle;

In headers

and in a C it can be:

struct msi_handle {
   struct msi_desc desc;
};

And achieve what you've asked for

> >  - msi_table is a general API for accessing MSIs. Each bus type
> >    would provide some kind of logical creation function for their
> >    bus standardized MSI table type. eg MSI/MSI-X/etc
> 
> You can't give up on that table thing, right? We just established that
> for devices like yours IMS is not necessary a table and does not even
> need the index. The fact that MSI-X uses a table does not make
> everything a nail^Wtable. :)

It is just a name for the idea of a handle to a device's MSI
mechanism.

Call it 'msi_hw' or something.

My concept is that each device, integral to the device, has some ways
to operate the device's MSI storage (MSI/MSI-X/IMS/Platform), so lets
give that a name and give it a struct and an API. It is all still core
code.

Think of it as a clean separation between 'determining the addr/data
pair' and 'writing the addr/data pair to HW'.

Today you are thinking about this object as an irqdomain, irqchip, and
msi xarray - I think?

> >    It is a logical handle for the physical resource the holds the MSI
> >    addr/data paris.
> >
> >  - Use a pointer instead of idx as the API for referring to a MSI
> >    irq. Most drivers probably only use msi_desc->irq?
> 
> No. pci_irq_vector() translates the hw index to linux irq number.  The
> hardware index is known by the driver when it is doing a batched
> allocation, right?

Yes

> I'm fine with using the info struct I described above as the reference
> cookie.

IMHO an opaque pointer to refer to the MSI is cleaner
 
> >  - We do not have device->msi, it is held in the driver instead.
> 
> No. First of all drivers have no business with that, really.

I'm reading your second email and still not entirely clear what your
thinking is for devices->msi?

> >    dev->irqdomain is always the bus/platform originated irqdomain of
> >    the physical device.
> 
> This is a guarantee for subtle bugs and I'm not even remotely interested
> going there. See also below.

Not sure I follow this? My suggestion is that it is either as-is today
or NULL and we don't try to use eg mdev->irqdomain for anything.

> >    Thus we break the 1:1 of the device and irqdomain. A device can
> >    spawn many msi_tables, but only one would be on the dev->irqdomain
> 
> Why are you trying brute force to push things into device drivers?
> That's really the wrong direction. We want common infrastructure to be
> managed by generic code. And all of this is about common infrastructure.

The driver needs some kind of handle to tell the core code what MSI
'namespace' it is talking about in every API - eg MSI or IMS.

Pointers are the usual way to make such a handle.

Going along the IMS == MSI principle that says there should be a
driver facing API with a pointer handle for the MSI and a pointer
handle for the IMS.

Yes, this means the existing API is some compat wrapper around a
pointer API and would have to store the pointer handle in the device,
but the idea would be to make that pci->dev ONLY for the compat API,
not used in the IRQ infrastructure.

> > Is it sane? What really needs device->msi anyhow?
> 
> device->msi is a container for interrupt management and that's done by
> the interrupt code and not by random device drivers. Again, struct
> msi_desc is a software construct which the interrupt core code and the
> irqdomains and irq chip implementation use for various purposes. Nothing
> outside of this realm has to even know about the fact that this data
> structure exists in the first place. See below.

I imagined that msi_desc remains as part of the interrupt core code
and the 'msi_table' object is another interrupt core code object for
dealing with device's MSI

> > IMS is a logical progression of this concept:
> >
> > probe()
> >    mystruct->msi_table = pci_allocate_msi_table(pci_dev);
> >    mystruct->ims_irqdomain = <....>
> >    mystruct->ims_table = msi_allocate_table(pci_dev->dev,  mystruct->ims_irqdomain ..)
> >
> >    // Use MSI
> >    mystruct->desc0 = msi_table_alloc_vector(mystruct->msi_table, hw_label=0);
> >    // Use IMS
> >    mystruct->desc1 = msi_table_alloc_vector(mystruct->ims_table, hw_label=0);
> >
> > Not saying we can/should go out and just do something so radical, but
> > as a thought experiment, can it guide toward a direction like this?
> 
> What I agree on is that the interface should be in a way that the driver
> can:
> 
>  1) Allocate vectors at a given hardware index
> 
>  2) Allocate vectors within a given hardware index range
> 
>  3) The core returns the hardware index and the Linux irq number in
>     a separate info structure which is independent of the interrupt
>     stack internal data representations.

Still slightly like an opaque pointer better than a two entry struct -
but compat is compat..

> Sure the driver can get a cookie of some sort to do allocation/free from
> different resource pools, e.g. PCI-MSI[X] and IMS. But the internal data
> representation management has to be done at the core level.

And here I still see it in the core level - this 'msi table' is a core
level data-structure and the opaque 'msi handle' is a core level
data-structure
 
We are just exposing a handle that the drive can use to. You are
calling it a cooking, but IMHO using a cookie instead of a pointer
seems obfuscating a bit?

> even try to make the irqchip/domain code mangled into the other device
> code. It should create the irqdomain with the associated chip and that
> creation process returns a cookie which is passed to the actual device
> specific code. Allocation then can use that cookie and not the irqdomain
> pointer itself.

Sounds like your cookie == my msi_table? Maybe we are all agreeing at
this point then?

> So thanks for being patient in educating me here.

I'm happy you got something out of all these words!
 
> The fact that we will be able to support this at all is based on years
> of cleanups, consolidation and restructuring of the infrastructure. The
> result of doing this is that my trust in driver developers in that
> regard is very close to zero. The cleanup patches I had to do for this
> series just to solve the single irqdomain case did not help to elevate
> the trust level either.

Yes, it is amazing how many patches this is at already.

Jason
