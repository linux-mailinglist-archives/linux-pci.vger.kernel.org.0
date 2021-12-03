Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10FA466E90
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 01:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349738AbhLCAlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 19:41:17 -0500
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:1536
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343847AbhLCAlQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 19:41:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yar6dS9QeKjXpcDB/QyNbXFYe0jvo9TZzZ019v1cgi5xAHEHm9ZgioJZWe4UZTQV642QPEf2H49SAipJ3t9nYY/8h7j7qhOWSH01NbbvwJfNYYCG4Qi0eXXgfh3N40wX6zn8YfbQdgs45FLxbwcUNuxr3MIcwpZcq5jrHZ+LNoarHlxpxtRT76ahGNcNb2U+yGMf/q2NGTahlMQcC1POUViGoMGrkaAHImTFpDfsjVItf7A8QK55UbviF6YFo4mzpO+RFIcoLVqBC+nkuxrEMHfGw3PevntxzabSGS8CYgnGygr4M68eSIED2M0xRcQ7p5EBYidjp+DKnCEcnnGGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFcaoM8SKcf//gJdJSNG2ir7aOqwiNxZAFMsHMdVgRs=;
 b=lCf0Wp0+fVL4NO2tCr3buVIkgrMklbhfM0Z452GOvB3z1DAlHFJHy++od/dCULR53/KxfaeFYfvB019h+URlqLLbO1RzqPx9hTKg+sY+fV/OVMHOhc3u9V/RQw51U1YKcH5b/9vf0EU7R/3sk5qUC/OGKsKypeMbiOi4twvz1ODtCsejq438n5qZkn9SNR5kIINEm+1jMUWe82u/qGxceJEXRilthDYm2TdtB1K7GyYT8G3y/2XFiduoM6LPXyCa0VkxCcrmC49MW8mNDgp8Q4kz5GuGm9zVG6lmQHVtP715ZrF5YXF5u6ko3JS1oOsh9qvDK206Belnp8ehx8SJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFcaoM8SKcf//gJdJSNG2ir7aOqwiNxZAFMsHMdVgRs=;
 b=rgwsgU23mE4CemJpnhiG/GjohKxaV0v4y6ObKs6OUXEi0twy6606/Udb51jVaciQUNOcCM2Qtpc5YHGq5ZN4J5MpnwNDH0noCWjdhVcz3AZPkyEgMUv9GWqPFUO/O4rNsrXqtXK1KXYSLz7XFbEdRdlj2J1gFuredQzGJSppj/L7C1/dgql4W9m4mBOZvZAuf/mksM2KGIjlrJ/DOw11Yame/cV/L7biv8rVDMC8VPsrzbJcEOWRvu3NZZbKsxYWPYxL2oP240TNEreDmEOcH6O+2jUQylXH4DwHW3X8Lq06S26bVyvrEOUH90olWsBGpTRyCwELvja+4l39XLSv1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 00:37:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 00:37:51 +0000
Date:   Thu, 2 Dec 2021 20:37:49 -0400
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
Message-ID: <20211203003749.GT4670@nvidia.com>
References: <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o85y63m8.ffs@tglx>
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Fri, 3 Dec 2021 00:37:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mswaE-007HHZ-0X; Thu, 02 Dec 2021 20:37:50 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39a4a6e2-4828-41a5-1e8d-08d9b5f5236a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51426642741FA9DC8271E4D2C26A9@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iisJVgIf/NXK7Sfs4RvUkJi/cVQqnbqRVBH7ew5W0q6xW0jNUu7ITVqO4aH8iB2B/ktbow4x57uWDQAkL1tLzB5nCKLeBF37EE6g0pxpoHdrQXR5iMPGEeWuxSEv5Fst0C/eOsS7VFqhPwBxcnvgpRiyHJ0FnyISAmvKdRd7rcYemmBvHleN6vyf6k3qHcMPz+n+cmG75LQnlIulTkHSoRuA9WLtYCjtcvDgmXlgLuu9sHTJgfY3W/qhLF4VPmkZX+b5BIfYZBGzbKUB8RTFBZWZK1l5zxzbx+Oe6Jbx2BtBQPjrn0ignbDw5V1tqWqPQwF8xeZfCyABHq5Mq/ujWQR8kkzqDJVlglTng9wKznTrD+plF+W0WgDzz7GFkp5Gcid/V8epVm6/18WiFIHdaWzMj0uaz/CuMjdzASPXmu2ou2jkri3LkiqwqkWsERu/Q7YatTIyKAWiYeAUYcvS0IdHgkzXWXV0ovzJDjt9K/YCAtJibFV/VSpmMNJK04SJmwxYp/iyA3yPv3uEDCmMGQRoTK71pFeG9a1FBx8isVVao9OyDXoF+q27moM5o80A21QSSsjJGsoZfOrJYOeEdYEAKE1mVlZAHiNZg5x6DlkJliToB3gpelu4Nfn9tMSXnbDkzIzilr6BqWJ2fngeQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(8676002)(9786002)(186003)(26005)(6916009)(426003)(9746002)(7416002)(2616005)(4326008)(2906002)(5660300002)(86362001)(8936002)(38100700002)(316002)(36756003)(83380400001)(66946007)(66556008)(1076003)(508600001)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NUBObkUK0uX2MzFgtIFe1LGQKOVLu/idQu7zf9F2RkzPGuJJVVBg13WbMPXT?=
 =?us-ascii?Q?T0WGp0aMFTLWg926xp/pciK5q3bcvvdCAsDgYU/dk0nfHCs3IOTWuUiJWtZX?=
 =?us-ascii?Q?geTvYqQP4jToG+C7D/MT12PtSzuzthvIyVShLWUrmRy1GI1/si18z3Vc3N+C?=
 =?us-ascii?Q?lTG4fK7n9aTntQuiClwksJQLN4X7JRAcxSEeb0x96RIfA1CGr7tUrNJMALBb?=
 =?us-ascii?Q?IHqLicvgWCAX/L6TkjlHgseIapj3UG8MofSkRstiv9zj5J+CnEJj6cRgKenm?=
 =?us-ascii?Q?2npy4SKeTB+GNmLSBnDgO9q+mjyF25IIfl6tNfMRo+d3VAApAG4QnRb29Ipy?=
 =?us-ascii?Q?9N50xxgliVwhtcxghQ2zPPrqiElk+i/t59ew/hbJUQ+J5vkNSTGsQwqHHFta?=
 =?us-ascii?Q?jzxGsbktg8H7AX2KU4jvgir8lrM7g960Kle7F4WZAeRuCkcncGZKZ4RnQkKO?=
 =?us-ascii?Q?VmIexieqyW5XYyhT1y44E/mFbjUbhcyExFk7aiSKgY5BK5LkmML5g7oD7ejf?=
 =?us-ascii?Q?FJeWubMIlQ1x4dmWK+7ERCPx4WYBOWTzs1lWp4vFX2g0jxHmrOkuS7R+ikTA?=
 =?us-ascii?Q?y5QlY9H2vubnIScl+Q3XuC7IzeG/l9Ll/+DMBihnNnJvlk5320aLR+N6j1mR?=
 =?us-ascii?Q?E9hBIiEZAP0UsgWr8V37zkZFb+GE9mI639NCZpmc1cjM9rYGGjW7NIjopezX?=
 =?us-ascii?Q?toFdPF86mqAHyADIS4i3CAUME0kQ7pnfxH7jgOsH6BzDWNIesbtlj5w3XYaZ?=
 =?us-ascii?Q?TTydnzCTftBlvrYBQGRe4ph9foptW8YZALsncFucduRTkcjV8VjDGxu6xOCj?=
 =?us-ascii?Q?3++T3sftFbHHl0JKcanLFO4xIfH+Tt5SCoIxfG/O1pYBEEpimNj2eUBBx6hG?=
 =?us-ascii?Q?20geZcGR1yHb/zKKcp2AAf/uPAzqVy3GHHhVpxc44VckTNrLKdl6GF5OgyWz?=
 =?us-ascii?Q?AUPISNIpmYNfRmvQqOwfUCaQpnwfru6ve0Im0bxVnSRtWJFF75zfUUWSEufI?=
 =?us-ascii?Q?huvyXNr8/SquRt+sdhoFMeHoAYyzGn/7k7OH7R+ohMM+VFe6iIyyx852Pxk6?=
 =?us-ascii?Q?Fdm6VohoTIsPSIEa1FIrN8/uCOMJXeNuTHKXxe3JauCBMrAYV0KNRdAbKC7Q?=
 =?us-ascii?Q?xliLAIZvNaPt1iMpaqgA3FUmP0WxMXIi4Y2OwQmEN5JXdjCSUrSrVG1r33qg?=
 =?us-ascii?Q?z1FNrDkMMq3YfKp1R+Kv9J9xeVTXG01lRjv0aXrINvQMZZGmTq0br0i/MU2+?=
 =?us-ascii?Q?+SBIzw89xfiYv75jRDHVn7e1UCD560zgYD1lerhexzg3ggF3JgcPhO2Bqgnp?=
 =?us-ascii?Q?phzLzXLEt9apSjbQ4YftDIrsRI1jlnplZWJr9NiZFb2GGUSLYuWdtix2GOhe?=
 =?us-ascii?Q?HOMK2py6WUxhZN4Qa48xJf+r9tyieoE4TJMqSqRAJeeX1Gvr+cdXbJCN1XFC?=
 =?us-ascii?Q?gxMT25FTmIMm2S4lB4rARWz/UOD7vBdgwGAvMd6uyONSPJjo3B6IG0OIclqI?=
 =?us-ascii?Q?+QuIqUJZqZ9WC5rSi7djwB+Q03rfqzF0kmXIomtap24refGc6fihJFN9mf2a?=
 =?us-ascii?Q?HN7sqM5JvdU5ti0+4u4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a4a6e2-4828-41a5-1e8d-08d9b5f5236a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 00:37:51.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/SedTGCTZbEE3KKIt+U1XhiAdsEwskrh8oV+3e3SDlnY6UFcvR9WOmgCWPInDoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 11:31:11PM +0100, Thomas Gleixner wrote:

> The software representation aka struct msi_desc is a different
> story. That's what we are debating.

Okay, I did mean msi_desc storage, so we are talking about the same thigns

> >> Of course we can store them in pci_dev.dev.msi.data.store. Either with a
> >> dedicated xarray or by partitioning the xarray space. Both have their
> >> pro and cons.
> >
> > This decision seems to drive the question of how many 'struct devices'
> > do we need, and where do we get them..
> 
> Not really. There is nothing what enforces to make the MSI irqdomain
> storage strictly hang off struct device. There has to be a connection to
> a struct device in some way obviously to make IOMMU happy.

Yes, I thought this too, OK we agree

> Just badly named because the table itself is where the resulting message
> is stored, which is composed with the help of the relevant MSI
> descriptor. See above.

I picked the name because it looks like it will primarily contain an
xarray and the API you suggested to query it is idx based. To me that
is a table. A table of msi_desc storage to be specific.

It seems we have some agreement here as your lfunc also included the
same xarray and uses an idx as part of the API, right?

> We really should not try to make up an artifical table representation
> for something which does not necessarily have a table at all, i.e. the
> devices you talk about which store the message in queue specific system
> memory. Pretending that this is a table is just silly.

Now I'm a bit confused, what is the idx in the lfunc? 

I think this is language again, I would call idx an artificial table
representation?

> Also I disagree that this has to be tied to a PCI specific interface,
> except for creating a PCI specific wrapper for it to not make a driver
> developer have to write '&pdev->dev', which is the very least of our
> problems.

Agreed, just trying to be illustrative at a higher level
 
> Aside of that 'my_irq_chip' does not cut it at all because of the way
> how the resulting messages are stored. IDXD has IOMEM storage and a
> storage space limitation while your device uses system memory storage
> and has other limitations, i.e. system memory and the number of queues
> the device can provide.

Okay, so the device must setup the domain because it must provide
information during setup. Makes sense

> Not really. I was really reasoning about an abstract representation for
> a functional queue, which is more than just a queue allocated from the
> PF or VF device.
> 
> I really meant a container like this:
> 
> struct logical_function {
>         /* Pointer to the physical device */
>         struct device		*phys_device;
>         /* MSI descriptor storage */
> 	struct msi_data		msi;

Up to here is basically what I thought the "message table" would
contain. Possibly a pointer to the iommu_domain too?

>         /* The queue number */
>         unsigned int		queue_nr;
>         /* Add more information which is common to these things */

Not sure why do we need this?

Lets imagine a simple probe function for a simple timer device. It has
no cdev, vfio, queues, etc. However, the device only supports IMS. No
MSI, MSI-X, nothing else.

What does the probe function look like to get to request_irq()?

Why does this simple driver create something called a 'logical
function' to access its only interrupt?

I think you have the right idea here, just forget about VFIO, the IDXD
use case, all of it. Provide a way to use IMS cleanly and concurrently
with MSI.

Do that and everything else should have sane solutions too.

> The idea is to have a common representation for these type of things
> which allows:
> 
>  1) Have common code for exposing queues to VFIO, cdev, sysfs...
> 
>     You still need myqueue specific code, but the common stuff which is
>     in struct logical_function can be generic and device independent.

I will quote you: "Seriously, you cannot make something uniform which
is by definition non-uniform." :)

We will find there is no common stuff here, we did this exercise
already when we designed struct auxiliary_device, and came up
empty. 

>  2) Having the MSI storage per logical function (queue) allows to have
>     a queue relative 0 based MSI index space.

Can you explain a bit what you see 0 meaning in this idx numbering?

I also don't understand what 'queue relative' means?

>     The actual index in the physical table (think IMS) would be held in
>     the msi descriptor itself.

This means that a device like IDXD would store the phsical IMS table
entry # in the msi descriptor? What is idx then?

For a device like IDXD with a simple linear table, how does the driver
request a specific entry in the IMS table? eg maybe IMS table entry #0
is special like we often see in MSI?

>         msi_get_virq(&myqueue->lfunc.msi, idx = 0)
>
>     v.s.
>
>         idx = myqueue->msidx[0];
>         msi_get_virq(pcidev->dev, idx);
 
>         where the queue management code has to set up myqueue->msidx[]
>         and stick the index of the underlying device storage into it.

For the devices I know about there are two approaches for allocating
interrupts. 

Many devices have a few special interrupts at fixed table
indexes. These can only be used for their single purpose. Eg MSI 0 and
1. An example is IRQ 1 signals the device had an error, read the error
reporting MMIO registers.

Then the device has a broad pool of fungible vectors. These are all
interchangeable, any vector can be used with any queue. eg MSI 2->128

A common mode operation is to setup the special vectors first, and
then assign on demand the pool vectors as CPUs are allocated for
use. Basically each CPU gets a vector and then many device objects are
attached to that vector. This scheme gives CPU locality and doesn't
exhaust CPU vectors. As example nvme uses 1 queue per CPU and 1 vector
per queue and userspace tells it how many queues (and thus CPUs) to
consume.

A device like mlx5 may have 1000's of queues and hundreds of sub
devices sharing a single CPU interrupt. This is desirable because we
can quickly run out of interrupts when we are talking about 100's of
concurrent subdevices.

When a "VFIO mdev" gets involved (mlx5 has this already, it is just
called VDPA, don't ask) the same allocator is used by the VFIO part
except VFIO has to request a dedicated MSI. Dedicated is because the
Intel VTx is used to deliver that MSI addr/data directly to the
guest's vAPIC.

When I imagine mlx5 using IMS, I see IMS as a simple extension of the
existing MSI-X vector pool. Every IMS vector is interchangable and the
main PCI driver will apply exactly the same allocation algorithm we
already have today for MSI, just with even more vectors. When VFIO
wants a vector it may get a MSI or it may get an IMS, I don't want to
care.

All of this about logical functions just confuses
responsibilities. The IRQ layer should be worrying about configuring
IRQs and not dictating how the device will design its IRQ assignment
policy or subdevice scheme.

>  3) Setup and teardown would be simply per logical function for
>     all of the related resources which are required.
> 
>     Interrrupt teardown would look like this:
> 
>       msi_domain_free_all_irqs(irqdomain, &lfunc->msi);

Looks nice

> Now change struct logical_function to:
> 
> struct logical_function {
> -       /* Pointer to the physical device */
> -       struct device		*phys_device;
> 
> +       /* Pseudo device to allow using devres */
> +       struct pseudo_device	pseudo_device;
> 
> 	/* MSI descriptor storage */
> 	struct msi_data		msi;
>         /* The queue number */
>         unsigned int		queue_nr;
>         /* Add more information which is common to these things */
> };
> 
> where struct pseudo_device holds the phys_device pointer and then you
> can utilize the devres infrastructure like you do for any other device
> and do:
> 
>       pseudo_device_add(&myqueue->lfunc.pseudo_device);
> 
> at setup time and
> 
>       pseudo_device_remove(&myqueue->lfunc.pseudo_device);
> 
> on teardown and let all the resources including MSI interrupts be
> released automatically.

We are already doing this with struct auxiliary_device and other
similar things. I don't see the value to couple the msi_data into the
lifetime model?

> I might be completely off track. Feel free to tell me so :)

I think you have the right core idea, just shrink your thinking of
logical_function to only cover msi stuff and leave the device model to
the other places that already have good mechansims. eg auxiliary device

IMHO this has become hyper focused on the special IDXD VFIO use case -
step back and think about my timer example above - a simple pci_driver
that just wants to use IMS for itself. No queues, no VFIO, no
mess. Just how does it configure and use the interrupt source.

Is it helpful feedback?

Regards,
Jason
