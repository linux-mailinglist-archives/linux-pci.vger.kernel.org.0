Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8982F466AA9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 21:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbhLBUDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 15:03:46 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:41537
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241286AbhLBUDo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 15:03:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NatEtoxt4S4Utl4RRw/OeE2wM2Fx5uEVy+ME71HqsyClMPCFVMs2ULGwLUN5MeDxc+OFQXtgPPo1sBLC7LKpnwJLpUYCGAYykpQdIlN7lRFljuKZCE3hAKqCdBzTZFSF233iFR4UrybxoYA6SimljMgcwxwBEn8xtOC9Bze52W65+jMRwzrsUO8/7hNTW24/HVmRR329QlErIY383n6EJTRLRB5EPN2Hdav8IDdAa3xmxwdfX0ZMsD0/i9ObkgQ93rRUnJ0Qa5YdFtJ8dTgd1FzHq+XHsfyeyegxT+9+eOERDr942S0ExcBL3fiyKrJR90gdHININJDPP1P0GwdlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejsy+3j6nw2c2XvHC88Po+Gp04OnGepseyJ+BVMZWnQ=;
 b=TGwQDJF9OQJ+d8PRh/8gYyoZwS4Ynr+l2FzkjVmZI5sSb8O2j2+mu4rnCvwAGw8W3J8JkSl+tma6fkmEVymOp39ka/wg3Eek82fplOVa9tnU/kkjoM16cTZiusv4Ln05oZf7SuyhpzOHRmqT4wpDnA0UYZv2G3rWmm2Lkfj6hzjNwFUK03ImG/hkzwOWzxKQ2IRKKmJL5prJBhNdgwXoRjgPLUjLjtTRCK5aME+ZxUWP2En4t78EqpavcYka0fzHGLQ6TmGG27VGV4KwnBJvW0y5G9vV2OVgpg1Q5ctuGK02CIUJIWsgAw3CPc0dQBAp9op8fcp3W8w1/Oc5XdCEXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejsy+3j6nw2c2XvHC88Po+Gp04OnGepseyJ+BVMZWnQ=;
 b=PNy49Yrobi/OIPaghNKQVGxzEUsjVJj8f30bC0DqTG/Z1j94VP/gtvOHc2dTd7Z+HZYE4/rDo8H4G9XuAUZ2CespASjWX/FdoIDeIz5eZ3zPCRjCsSSOX4b/cVhZG4JNl147/1ygZ2MmP4hD2KhWg2XqXvtz6OaT3kpn9KveZ/XALZG5HTVimKt7JzqFDvWOxdInaLtck/QOW7ggSUhaceQd0SSBT7nG/CCEoHE2cDEH8L3zZZyuPI718jU6IMhSGjsJ71zppw4YR3I5OcJyRUAGNvOfA0LrJJ1imRljM7v5+9EJ6BHMDWCzJTh7EDp1pEwOJJlr4mU/CPNk2BLGuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 2 Dec
 2021 20:00:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 20:00:19 +0000
Date:   Thu, 2 Dec 2021 16:00:17 -0400
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
Message-ID: <20211202200017.GS4670@nvidia.com>
References: <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
 <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
 <87wnkm6c77.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnkm6c77.ffs@tglx>
X-ClientProxiedBy: BL1PR13CA0367.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0367.namprd13.prod.outlook.com (2603:10b6:208:2c0::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 2 Dec 2021 20:00:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mssFd-007CiX-DC; Thu, 02 Dec 2021 16:00:17 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95662b79-c8fb-48b1-4095-08d9b5ce5db4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-Microsoft-Antispam-PRVS: <BL1PR12MB525586202245271D13DC4E39C2699@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqoD843BUJjRbfDqruaYCVGWttqDoi2L+xrlXhQDLjUZE/5vuZRegIYIbFo6EAq4XIex+/CTHQLCPthdFGdBykS9zgUk9Has9sG7OBH8GQ9dU+9/vtfMEc5DUUrSt0eO1xMMu+VuFi0ugb30IYfCLji2lTewdNuDGiJ6b/XksMthuRWJ5fC7l4XLrDVVH6L+QlsfJsRCityItb/Tc82K4XBdwLa7zMjgS7gcmGF2EzLKjuYmagzuWD9IdwMTJkKt3gz55yJb7nzYJXD8W741isg1/MCgggOGfPdzW1/RU/puJ1/TwPK8JBc8UF2+3JGyKgc9poTqxvAGM6t6Jt5pyMiwdLRQfKgU33UHzkvn8u88snhQYcjfmNMNeFX4ReHbXZDEVJHDUB5wQR1b1w2hc5Os+L92cJ9pCh4ZQayN1AY1HcoOcyVxe2s0v1BdPhEgbl9/gH812Z9cEgbNVqHVfoVJJwYl72QNjRyYMAwRVb9YYyl20sRrn4dhyoPAjyR7be2sE9gV6aU6qFssOpabyYKvxB5Sw+iIt/NyLu0+B1BjwGkwNZdS32gq8H0RiS+Al5SQ36J7dRYe4lTU01fEh6yi1hQqCsp4jbVkza3TcBpaOWeZ5RxQfZY0XW+kuwxkIhTSztl3eKOD+ul55wOlAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(36756003)(66946007)(38100700002)(8676002)(508600001)(1076003)(66556008)(66476007)(5660300002)(9746002)(426003)(6916009)(186003)(9786002)(2616005)(2906002)(86362001)(83380400001)(54906003)(316002)(33656002)(8936002)(7416002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Rf4MFlTKMVAWZ+/fcJ2gA/VoGaW8+IsvEnNd9x/CVI88lBYHyeMGnZHKF5X?=
 =?us-ascii?Q?j6AhGMzaSpIJFYwrZ57B4bcTXwflYErNZQQzoeOgowZE9QZzOO9C/3xw6D5k?=
 =?us-ascii?Q?S+qp5W6acurXUOPue+08245fxwD7TfcJmO8mqlOzqERlmiQbLDMbN7Ndg8Hp?=
 =?us-ascii?Q?MoYbANRA/Q0PEqvjxn2E3fHk/aKd1PsNT3+UCyqM0KMJPCezIyRe5ndlwGDD?=
 =?us-ascii?Q?j4HRIAhwGMOMTTAWX8Tikr616dI6HVJzoLhVSx7PLjZ+z6uOAP2LPXAorto5?=
 =?us-ascii?Q?m0UPN+78XKFeZy6pd8gNpDc2Eklwu9KDz4dS2JR0gSpEIp8++7eL/3f+bkia?=
 =?us-ascii?Q?p7c+dlAqLguV4+Du3kaCj0N+LnFrar1eGlXu2OkTyLeZEjm89XJDrKNVXavd?=
 =?us-ascii?Q?/bau/prQwvKSDnNuIje6BTqLpJny1f72RSkU9pr1rMbKVUBKEg3t4pY2phVy?=
 =?us-ascii?Q?CvFBp7T8T5KkO7Lzkp0y+BpxJWpou7LvhBnwYkt0EYWEXkRQr0Y52qlTqcBC?=
 =?us-ascii?Q?Hvul5JMEwLHIMUCElSUXjsGDBHofICWft++XE1/JLcpKrOAs+yx9zVl7Pamv?=
 =?us-ascii?Q?HHHW8PJmDolwYIjJfLv7MI83Nv9Tqsl/3Lc/qXrXuAYrsq2quuQ6VC3XhBEr?=
 =?us-ascii?Q?y0TXuSE0lFnjyPpeBWfqAMyBxTsHNaSB1VbxNfgM0lQVRSoYrtRC2UyG3woY?=
 =?us-ascii?Q?6wuFuTiOEA32Akh7zKXdHYe0ozdkL26flQiNRGUnQqhO2PRAZSAHZO7MsWKV?=
 =?us-ascii?Q?MtcgIfBmibMVUSzshYq5PHrhmlTyEWE81NDbN/t8s4s8a//oWqvXqq0cc4OR?=
 =?us-ascii?Q?L63L6LOx+lMC2COLhjWoTCV8+yAqwuJK07zIEgkEtfak4IHU80hDktS2d6vP?=
 =?us-ascii?Q?041iYWCyGaiBk+tttEBn4A8mXQlvEOmg/qtW9oajkyG1pU/ZBRVHWIuy/QPc?=
 =?us-ascii?Q?qck3hczvrOKK4QLupslxmzY9lkQyUcan6QihcSJ/p2kUHCxcSY8q7iNc6+Jc?=
 =?us-ascii?Q?MXEatwhnsjSqQPO35d2ku3vBVrpOFMYRX3S/t96ywzcguHTnIH1vgfzGCbgQ?=
 =?us-ascii?Q?tI7d2eub02aD0oEGC93gxA2wqN6qUkURWjcQHGnTsin8UT18d80SYYVAAWgj?=
 =?us-ascii?Q?qEcaSrsqlARr+Bg/Pw+PGgRJNfJI+tY/EA9kUuZuIAZnMQHvNFOIhvbdr32g?=
 =?us-ascii?Q?89oPi95/zq8MqUhTviPaCT/aZQe8/GVLuvrt2T7+dYap/KGAmR1264AMKiTC?=
 =?us-ascii?Q?fEpx1p6WCwFTz5w9ACJHIikN7G32wx/qctdX7nai2QuwHGkhtXG1pyKflKKO?=
 =?us-ascii?Q?txomVmRDXIi+tg8EkpcSlvFdwAoY65uoAqFLtNjDNd7Fn5932utgIf+2/ouM?=
 =?us-ascii?Q?3eJs/VSlwE9Cvkua86I+nqYPgWP0ftDHj7h3qjRglkzQ0wf7DXWZj3cKQFOR?=
 =?us-ascii?Q?U14xqL1IX8dEaiqOI7+SYS0yIUrvVVTMnO8fIUQqf/bS0iJPRPsfnjCu55Hq?=
 =?us-ascii?Q?UMM/MKF0IDgW2Po2Z9SsOk/x5N3uMntjUNb2lcs1FkpMyscsGXC1+YU07SaY?=
 =?us-ascii?Q?UCKDJzK/IiZussSzRcs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95662b79-c8fb-48b1-4095-08d9b5ce5db4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 20:00:19.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eOHrErUSphI1mZXyRNZyH9PJ5hFuxAl3+mshdWmbdz+LnsWcVQofsGUePgYshFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 08:25:48PM +0100, Thomas Gleixner wrote:
> Jason,
> 
> On Thu, Dec 02 2021 at 09:55, Jason Gunthorpe wrote:
> > On Thu, Dec 02, 2021 at 01:01:42AM +0100, Thomas Gleixner wrote:
> >> On Wed, Dec 01 2021 at 21:21, Thomas Gleixner wrote:
> >> > On Wed, Dec 01 2021 at 14:14, Jason Gunthorpe wrote:
> >> > Which in turn is consistent all over the place and does not require any
> >> > special case for anything. Neither for interrupts nor for anything else.
> >> 
> >> that said, feel free to tell me that I'm getting it all wrong.
> >> 
> >> The reason I'm harping on this is that we are creating ABIs on several
> >> ends and we all know that getting that wrong is a major pain.
> >
> > I don't really like coupling the method to fetch IRQs with needing
> > special struct devices. Struct devices have a sysfs presence and it is
> > not always appropriate to create sysfs stuff just to allocate some
> > IRQs.
> >
> > A queue is simply not a device, it doesn't make any sense. A queue is
> > more like a socket().
> 
> Let's put the term 'device' for a bit please. 
> 
> > That said, we often have enough struct devices floating about to make
> > this work. Between netdev/ib_device/aux device/mdev we can use them to
> > do this.
> >
> > I think it is conceptual nonsense to attach an IMS IRQ domain to a
> > netdev or a cdev, but it will solve this problem.
> 
> The IMS irqdomain is _NOT_ part of the netdev or cdev or whatever. I
> explained that several times now.
> 
> We seem to have a serious problem of terminology and the understanding
> of topology which is why we continue to talk past each other forever.

I think I understand and agree with everything you said below.

The point we diverge is where to put the vector storage:
 
> Of course we can store them in pci_dev.dev.msi.data.store. Either with a
> dedicated xarray or by partitioning the xarray space. Both have their
> pro and cons.

This decision seems to drive the question of how many 'struct devices'
do we need, and where do we get them..

> But what I really struggle with is how this is further represented when
> the queues are allocated for VFIO, cdev, whatever usage.

Yes, this seems to be the primary question

> The fact that the irqdomain is instantiated by the device driver does
> not make it any different. As explained above it's just an
> implementation detail which makes it possible to handle the device
> specific message storage requirement in a sane way. The actual interrupt
> resources come still from the underlying irqdomains as for PCI/MSI.

Yes! This is not under debate

> Now I was looking for a generic representation of such a container and
> my initial reaction was to bind it to a struct device, which also makes
> it trivial to store these MSI descriptors in that struct device.

Right, I've been trying to argue around just this choice.
 
> I can understand your resistance against that to some extent, but I
> think we really have to come up with a proper abstract representation
> for these.

Ok

> Such a logical function would be the entity to hand out for VFIO or
> cdev.

What is a logical function, concretely? 

Does it have struct device?

Can I instead suggest a name like 'message interrupt table' ?

Ie a device has two linearly indexed message interrupt tables - the
PCI SIG defined MSI/MSI-X one created by the PCI core and the IMS one
created by the driver.

Both start at 0 index and they have different irq_domains.

Instead of asking the driver to create a domain we ask the driver to
create a new 'message interrupt table'. The driver provides the
irq_chip to program the messages and the pci_device. The core code
manages the irq domain setup.

Using what you say below:

> If this is not split out, then every driver and wrapper has to come up
> with it's own representation of this instead of being able to do:
> 
>      request_irq(msi_get_virq(lfunc, idx=0), handler0, ...);
>      request_irq(msi_get_virq(lfunc, idx=1), handler1, ...);

We could say:
  msi_get_virq(device.pci_msi_table, index=0)

Is the 0th PCI SIG MSI vector

Something like:

 ims_table = pci_create_msi_table(pci_dev, my_irq_chip,..)
 msi_get_virq(ims_table, index=0)

Is the 0th IMS vector

Is it close to what you are thinking with lfunc?

Regards,
Jason
