Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E64700D0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 13:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhLJMnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 07:43:18 -0500
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:16641
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232216AbhLJMnR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Dec 2021 07:43:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL1bdkTy9wg0ugHWYciT0/8Xi7mX7GFJAZmaagvEsu2BbvJwBqmuwRgRDhvQ4QmATUC9rV3FbQEcJ8czJoE9v0mBsyaO5C2VFCVnpMF/blwQBRb2MReJcQ8Ip/NQf9gA5xD9Y38SVK4tFrXu6U7FUFvCNUgEbDo19O8OJXz37OQonObOhUYhIFABEg7IOXI0b9r3L5fRZV3xRdQUks+TzuFoo98zxLTBjiNipUqgsBY9wgwB7ilKIuDY1Uk3tG6BJqOh7jMaVTrJq3NrZEPMUw216AQgxgEX6u5R/rTb+k9yYOiTdX6eGpJ+J4UVhhvsodjI7TWtxEDHl/svu7wy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0fMPmab2uvG9MU19FoSeQxZlEvv5TWqraNaKqSb4L0=;
 b=PPKCDvd4v/avBQJZAtGlueusswebvDL4psopcOstfACTKg14KBVB2hEorbIoA1WdKYT04GIZNmWk/0RlTy2v3eLOHwAw4rQsrGA/IWViaLEMOJa2BFCQ9qJ5rkWMFFW8HlhRZy+HwRw6Kt2rZY+whnvheb28L4s0+Q2xHplacpjI+u8wR/VvtoIv55wUmv9L3M+GvX0uxPvAedazcK0hyadnbPBy/3Lng0E5Wmt7zzBNE/fUdUVKrsZ6bpyvDb2x12epIGvu0g99jWqmAsIeYsekluXT00BaHRUD2mM1dH5L7dZr8uicGqQiev2cFgIpMXRaQlBWo7pfZECTdrCiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0fMPmab2uvG9MU19FoSeQxZlEvv5TWqraNaKqSb4L0=;
 b=BBW/0dakS2jqkXVp5y7UdCnXsY5ZcAmxCxBfWNIQatlyOcJXbSyYQ7JevDWSZ7fsylEivY7tyhl+hrBpfJlQBNW8h3T1RPpcnn/fhPVNScuv9iiqYcIz8t+MFrn1Z4lU6qvvk4JNCq5FCMxvFmR3+NAYfgpxIpk+7o7IY54ngtskKtEBGsGEtCPKD7HuSLQ0aZ4xg9cSRZldjM9lxiiZQx/RLxmN9/BGc9F9EBETEg4ySrNEg/l1MtW03H5JeE0c7R0sy4EMb0/j0K6pKS+UJVdOTtFHH4PtUzwzC8G7piFKEJ4yCQsY8IIrVZXjz0H3rMAyTzr04x0HC4NBIdLJug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 12:39:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 12:39:40 +0000
Date:   Fri, 10 Dec 2021 08:39:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211210123938.GF6385@nvidia.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
 <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx>
 <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx>
 <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4806e7e9-7a76-4bb1-b693-08d9bbda226e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5175B993160D961E298DFF7BC2719@BL1PR12MB5175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OUv25Hec6nhNmWfa4k67A61Ykz6P8Cuzfmzf/zZ+KSaPflfAP4Z/g/8NGa5RYbbX6uZ1znpFGRwqxtGyE2FPsROnNN7WkNBSNJlS4NhNqvNmtXiDVWdcbnf+luelRKtmyE2c9F8CYQhZ84zIahzDHMCZ3LqTIJcrMCQisyHtVXyzldMyqj+vYG5L+HAt5DFbiBKb3sOrDPcZfc69+6X3OWlK9Gg8XOTmVXzh9r/49f7Cp1rnEdNVEO7WAvE9WBpyv2ruV7QKapfJB2dA5dsx6wo4suCZzCOO+9LtEyFKxXR6OAKPT9sYSy5wwlw0dSoWR1Ix5ZkMsBdS1z/ZclR7royJJXo386s99LPO+smkG6u2KKVK6hwQhEMMCOavL2aiuNliM+A3GHj9/pkRES+k4F3HTaGE+6QI4srqoGDxdcpcEl0vpbTbtjUlo2832ylg1hubn9negzUYuzXNA4DXz0gMThXryTPFFUmsVoNOlop8T3TDmWWAw1tu9TDfVbulzDiXtJnTs2b3PhhloXI9BOdiaXnBGO9T2v4CC3/l2idUR29zuoob2e7g4hpYS+uI8ZnzQqhe7TJcd4ZKJu8DvB6jUhPgeSTgQe94fAQksWWqofSU6f02RWCeJkQT3sInTVsfpFjnbSM/873otwB1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(6512007)(26005)(8676002)(83380400001)(508600001)(54906003)(186003)(66476007)(66556008)(66946007)(2906002)(6506007)(36756003)(5660300002)(1076003)(38100700002)(6916009)(33656002)(6486002)(4326008)(316002)(7416002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i/ysojPts8ffnSarDicHAUTx9pHOgqOQAo1YAtjI2NxKqqnKB3lST9DEpZVN?=
 =?us-ascii?Q?g39pVdKXoHr8d4UkJ1OIlNBDNg7lAnT3Bjxhibfy63ecz0b3RonUHswQNH6E?=
 =?us-ascii?Q?ztpRcYmyDw4DcHVgij0qRQOTODDycNl3UuwBhR1mwDSEtAIMvIxd04MxwuG4?=
 =?us-ascii?Q?GxcWMEvAgqjgl0uNe1jzJwThPtoHlj6KXy/ejFQlhjhl7QBsZa258CZuKf2+?=
 =?us-ascii?Q?fkl4OAeBabS0347aDh+vrPe0mabIwjo9sSJ+dcuQe1b5Tx0rgD6TT9FemX62?=
 =?us-ascii?Q?ITOti4DUiL1AIZvzRPRKFylU2ZggZT746RSM3eRd8xBc1fYv/oZDGBsZEBLs?=
 =?us-ascii?Q?j7n4GxbdE7iDVG0Dhd3RNYUxPqzuGh2vSf35/iQsUXxzO3vIluu6BYgPSCTk?=
 =?us-ascii?Q?+8lktQr5+9by0ZMuA2vWkn0cYHYHfJOpEC+w0hH78Xqhrw37gnsexKocX8Oi?=
 =?us-ascii?Q?Bd7Vtske7Vij72qkp1a6beErFfbG+pQal5e0Cbl8lUcA90Otbr/8OCGtoLOu?=
 =?us-ascii?Q?z1iewx/QqA0UIx8HO06hfHRyAwG+5fmq7QYBYFHgmwLX6ZvfbEZLEhqPqHXT?=
 =?us-ascii?Q?CLi00pkuAkC8e/1nEHP5vcyPtw+gpInINM488oZn7hGVPkc8A80sKtxyJ5av?=
 =?us-ascii?Q?2xpUzwOM2GX5p9sdOgpKZXFt8xYLahu27rBmTExlFTL8L6a2pZ6la5qcV1Hb?=
 =?us-ascii?Q?zIUWoZ7T2u7CcwWgmi3BJprvQKtSWOaoZoDjfiz/rKDIa5MTRbOPMzLF3yAA?=
 =?us-ascii?Q?8otKkl7NTup7NFYNZYYHwsBoqyeEC4CfElXuuX8IKarOLnq+++I4IP7u12Sk?=
 =?us-ascii?Q?deMC6fsu0WORdmw4xLvM2+hzuTPj/773WMty5XGjgsRWXwaojZN1xIMePmjQ?=
 =?us-ascii?Q?7/8Pt2RlO6z1aL+5IsEkq7MGjd7GLBzpKnpwTfnLSrWzk3aImbSWmhqK+ifI?=
 =?us-ascii?Q?E1eyxxV1E/7PvK3npvPeHstxp+ovOY1AJX2VIgYMjEtkBodRcZzZIsZmf7ae?=
 =?us-ascii?Q?oRDM2AkLDP4FeFyvTUiLUyfChk5RG/Lcl8TGZLcU9rEvaJUgGdpYljKbwNiw?=
 =?us-ascii?Q?C5l6856bQJE1iwmN+83HNeRMAeiL3ppo2tGY/CRHvp3dLggg0Up4mAwouurW?=
 =?us-ascii?Q?0wY4opdaTIhbzsrT8zbWxYhUJAYpZha6scPdflvNt74OsKLP++6U67aAMgLN?=
 =?us-ascii?Q?60g4cicxSQMgPRO9RJdy49eiv0JaZxUxZgrtbnRW1oL0oZRWb793TbWHfR9l?=
 =?us-ascii?Q?QaievWhpl8VNyqTpPK8qInUcXgAIS6RikjrNK9EDPI/wbSu8Jz+f75V9iJ6W?=
 =?us-ascii?Q?ifEVebUYe8LA5AZ5+6+K5233DWCVxAuV/HZpMX7LPeBzN6H3b6dDDKgjn2qn?=
 =?us-ascii?Q?vHKr4ucV9inBGCICglARhHYBmSM+al+b9kResfviCsLfZGxoQpR7+fC4BetR?=
 =?us-ascii?Q?UvjRnJJV28bKT+s6Xlst1+MiGB/g2iHRG1D9zo7Fq1sePnjZBrnkblBecgAR?=
 =?us-ascii?Q?OR3OuDd1uwS3sBJ7iP9L0SVTVZo/9fDCgSv67A6dVjWUkfTeYSvCeSxIf1oL?=
 =?us-ascii?Q?CR1NAOKNiyUOM0sJoOk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4806e7e9-7a76-4bb1-b693-08d9bbda226e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:39:40.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wyGge3EVTdLxsFgI+Q34aekTqjybgqd85HfSzjZfZhDGUei1uShjWrJWysgFRwt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 10, 2021 at 07:29:01AM +0000, Tian, Kevin wrote:
> >   5) It's not possible for the kernel to reliably detect whether it is
> >      running on bare metal or not. Yes we talked about heuristics, but
> >      that's something I really want to avoid.
> 
> How would the hypercall mechanism avoid such heuristics?

It is clever, we don't have an vIOMMU that supplies vIR today, so by
definition all guests are excluded and only bare metal works.

> > The charm is that his works for everything from INTx to IMS because all
> > of them go through the same procedure, except that INTx (IO/APIC) does
> > not support the reservation mode dance.

Do we even have vIOAPIC?

> > Thoughts?

It seems reasonable - do you have any idea how this all would work on
ARM too? IMS on baremetal ARM is surely interesting. I assume they
have a similar issue with trapping the MSI

> Then Qemu needs to find out the GSI number for the vIRTE handle. 
> Again Qemu doesn't have such information since it doesn't know 
> which MSI[-X] entry points to this handle due to no trap.

No this is already going wrong. qemu *cannot* know the MSI information
because there is no MSI information for IMS.

All qemu should get is the origin device information and data about
how the guest wants the interrupt setup.

Forget about guests and all of this complexity, design how to make
VFIO work with IMS in pure userspace like DPDK.

We must have a VFIO ioctl to acquire a addr/data pair and link it to
an event fd.

I'm not sure exactly how this should be done, it is 90% of what IMS
is, except the VFIO irq_chip cannot touch any real HW and certainly
cannot do mask/unmask..

Maybe that is OK now that it requires IR?

Jason
