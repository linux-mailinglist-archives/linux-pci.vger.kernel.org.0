Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893554628BE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 01:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhK3AFM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 19:05:12 -0500
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:55009
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhK3AFL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 19:05:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liS3WKRMNRmRhKRsIfwv+wMZCvHbaJlgQ94mVt3NAi3IHD8cG52X7OpGKUWg7W+J/EqfvKCpI2igoB4e2W9lqOgClf+3wnf9i0IUfv3iFuH8bANR459ic47zVvhmENPXHPXVvED5n5V+sF2rh+zs+nb/SyBAgzXsdjHtWsk2P7EXADBojr868PFQUJj6RuSlDmkMXFgx+AmgocSgzCgsstmRLtPA9EMTUhoW0eAskJHvKGaxaFRncFnc5oNjr8K+LwyGwjOyozg+B0rgYPkRr+RgNHle527XwDgdqR9RVI+Ppz15GfXgZ1hMX0xOeb/DdkCtLb48h6+jovj7qLW2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOjUZmUrYBtK3FtMd7Ap5pTP5mG6jcB0+752kr0gfK8=;
 b=Lds13gqJShbWluCNZBbw1pKqYLJaaG+xpQgJN5pUIu7XsVmiaj2/FWsPK9oVm5DXO5ZOZ3hTSxp0twEA388euDDbyFV0PWdBGhGCnv2DVnJJVDxPop97QTWwPmVNoQOlQ6Km0b/8hAqRHN089+9YBzpbb0KM8TafqXoQriPwinZxJVCWl4RCGIBO4TqbKUtrIXM0rbkzOoDJiJGh9dxOPE+WhnSIzfXNYhq3mWoEIwToquUKPWcLBm+VAtU3Ky+rAnVrwiga3gyERA89loszKIiWHFOVfLVe6RrKFqebgGnvQtddyR7/oqQVAlBpDyhKZd3j1rfDk1ITW7+IKTrv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOjUZmUrYBtK3FtMd7Ap5pTP5mG6jcB0+752kr0gfK8=;
 b=o3gVDtx/PlQRX3k5WO9yoLjtns8p8OKaeu+KKMFwWLxaXAJgh08+rgM42l2YxgNa7uGx1GkTGdF1BZFveVFch1tJcusFKheaQoR/hAw7AzdxuPBvs/rorjmD6qt7ffwHh0AECK7iH6iJzuLb85YQB5lYTJ0m6aMxHQcCIpzpV7EJPhnCpAlnyTcwz6Q4BgBiQf1VfzTpf8NjWjUNFXc+ne7dcU446stx3CNkLDec+Nq7wT82l0MC7DlIlnlSaO9oYzQnYHnR/B6iG2PsNuNnIDjT8/oObIcewCNLZEsYm2IVPdTA2Jfy+wItwNX8rpLrwqcsK1p/mUaVYrKU3AzTBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 00:01:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 00:01:51 +0000
Date:   Mon, 29 Nov 2021 20:01:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211130000150.GB4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <20211129233133.GA4670@nvidia.com>
 <7c5626d2-ad80-24eb-0b89-402562156135@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5626d2-ad80-24eb-0b89-402562156135@deltatee.com>
X-ClientProxiedBy: MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 00:01:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mrqak-004sTT-LH; Mon, 29 Nov 2021 20:01:50 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7937c9c-582d-4b7d-6a94-08d9b3949ccf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5189:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5189F65C227359F229FA5294C2679@BL1PR12MB5189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygXFDn3n2iIkzMn45zgnaSMVEmRTPyrCDr3/ljnfS/SymUcGaMWc8mI95FjOjQm52m1TwBsf3eTWY56KlJYA1SLPnt8LxQvXTVDPY1ZB9CzGmlWrLikNsIDJHOvBEBRS7Qmej3WJfKtwJdTGdApNUeHQd74bufbYt3hB4RBsUpWDCeBv3IuMgZwmfU8pocdOUioiXRlrwSdCKCr4vhGFdKOVK7WgC0bvDUOxhTh49FV9lytutmIUbqDEThcTgKXpdRLKGoR5saOEblCWQvQC9nNNqFTQngkCKGpsfsLaFbPfFbH+Th9O39GBbinXv9DGwOrBvzF0DOd0aVNtOWZxpk4Exph9fmifhHQzfXQNV0oEa+H3R3ylxEKnfsDxo40ze3/QrN6hEViaMLvY3ivFrRJgPlxxvO0DnpJCXyhgdcmnDgWMZXjL5QFjtQnrbIvuGFnpNku+ko8vvai79MkdRXm1o9OMVgIF/UmmbSbEKkhWbZvNdle1izfBLWCoVLO6mAheeMySlGiqF/E/CmKnb/VM1UJQ4Px/s/0qNF6yWZsMK8aXvkH9kawlDTB6g7++M8gjRp1c7zUM/0SyouqxYReULi4sEEzV8gjduzvDtmkK7Vk9vvmLEIEebDCv+QIsfp/Wl4mkTnpc+9m1hYBzJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66556008)(38100700002)(26005)(66476007)(8676002)(4326008)(4001150100001)(316002)(53546011)(186003)(508600001)(2906002)(9746002)(426003)(7416002)(66946007)(8936002)(83380400001)(33656002)(36756003)(5660300002)(6916009)(9786002)(2616005)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?woM5UmtM2Kt53NEqw5lMUKOyQzCl+Co2IRO77q34C6GCeZLK53NESs2+SMOC?=
 =?us-ascii?Q?3KlxOY5UDxRYmdDx2pOagJmrNPuFibBripNqG6LFPxlHV9jsK8GDx4L21pTn?=
 =?us-ascii?Q?E4+y0j5P028Szfv+xpOMYYLn05VDLi9W+HQS7N9EEF65zJpbwuGUWGxqSu0O?=
 =?us-ascii?Q?o6VRsVNpUdevDGPDt9Nx6f5MNuwCr54yDaq/wCmX6wwz0CKFHwoCwe1TPX59?=
 =?us-ascii?Q?BXIzQQW0Fz23pys8GkA8np5P3i7Se8RjmjezzPTElWPHcwYCAvT80GrXZ1an?=
 =?us-ascii?Q?8GJDGVlYvCEpWSR2UFOnbLgOHrPU+AFEABUCGYltdosfL0Wj/tkUDWmuZQU1?=
 =?us-ascii?Q?G528+XwFjM+i9MIGfUlMiXW9v5PCVN7ILcjKfskCKC/J9kuhjxRIQg6N4z76?=
 =?us-ascii?Q?riwqk4kXUTPXkkA9FHQbM9jjyVov3EJfw6daBtOdcbO/UUQlEMrlzfj9qqfT?=
 =?us-ascii?Q?Mxr9Elu/L0Qhu5qA2zhKdEx/8RH2toPdNzwnFUtGzvdb2dvC0JiyNsoymUhF?=
 =?us-ascii?Q?1m4ULViqlabEBK8ISmsld8FWWcDC0wjY+yvkhC6ARhsd1nwNiCbcns565hKG?=
 =?us-ascii?Q?7j3+Cpm7zxAYLxHQdvi5KrE18y7jxn/eI1yqsDQC74isju3Jb5I5X1reRFkh?=
 =?us-ascii?Q?BVqnpEd5vzfAfny+roNFZxrYhlTcFmWsJEuw60N2sE0Lw5cFJ5T2aZ02WEEQ?=
 =?us-ascii?Q?TkvAVreT3ulrL75+mB88x5SYICbITHqa0aexZZjKoCB+rsc36sUBFxFbDBWE?=
 =?us-ascii?Q?OviQNgXfYoX2300zJ3o8Vtttgzb4LeJQ5Z58whyb8guFflAqetH/ZzaNVrqu?=
 =?us-ascii?Q?u2Z1v4g7lLYfgtIbI9Pbm02xBHM1BYtkJ8CxxoK0fDSvMuhLNip44fNFx6y/?=
 =?us-ascii?Q?Hg6lNrQNPBNyNThszmAzbJRpJFCgLtiNzsWN0BXpV4G/Me69CWktiOXt0ku9?=
 =?us-ascii?Q?Up6xI9mWQtZJOf2L17yk/3AO/aPhfaPH335UzJC0zGmm+Bsx2CYnMB6q94zX?=
 =?us-ascii?Q?DDMeD+I2XJ2vIFvxCoTwSSep2iY4aSbg1452xH+R+7x56V2i56NCb7LAgiv/?=
 =?us-ascii?Q?aAcnpcUsgwRnPoYeNW3wPFVvftAQRB6g7Xhnsp+drFFXWHUvoyL8gmwED1S+?=
 =?us-ascii?Q?lXGekSXWvuR0YpsyxE2JAL+RV7S4SN4jcSAww/y8JakK/oKw8Rzp5bdu6bzX?=
 =?us-ascii?Q?QV1U8NB6yWI1qt9dxBL7gyu7B7aLsu5D1SLp0NP3+FPOpOLFQdygX2xXv0TT?=
 =?us-ascii?Q?i3SFgCTE2WajoSjiYIrKSvPXuS4JqaIcLWvRl5hQFgZsykJrxzaLp3/90bxG?=
 =?us-ascii?Q?YoE2ZozTbl+iECRii4oTarjXbDYLesazfP4NAyOFIbgCRCUsVLBCWRA6dZDH?=
 =?us-ascii?Q?CLsSFgkO0rlGYXw8kX7UjgRySk1kc5GJB4EoPQpSfbpsVv4iKVa00aIWYOws?=
 =?us-ascii?Q?hKMuTPdXIN+cQb+8BxL+rMtD9VmXS7C9NmtovHE9I4I3Vnvj3xhyavasmtPu?=
 =?us-ascii?Q?LUt/X5u60w4qGTXtwRu+ZefQfyIV6+nMqceYTG7RalJTxfroxp3skuLnUwlS?=
 =?us-ascii?Q?Rs8kqp2F1sq2++/U2Iw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7937c9c-582d-4b7d-6a94-08d9b3949ccf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 00:01:51.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRt1ATkTeqd0ftvIqEotdidUXCMBl9vaK8aanbosrFuhhAOl4BtcDkuO8M8MaS9X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 04:52:35PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2021-11-29 4:31 p.m., Jason Gunthorpe wrote:
> > On Mon, Nov 29, 2021 at 03:27:20PM -0700, Logan Gunthorpe wrote:
> > 
> >> In most cases, the NTB code needs more interrupts than the hardware
> >> actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
> >> for: it allows the driver to request more interrupts than the hardware
> >> advertises (ie. pci_msix_vec_count()). These extra interrupts are
> >> created, but get flagged with msi_attrib.is_virtual which ensures
> >> functions that program the MSI-X table don't try to write past the end
> >> of the hardware's table.
> > 
> > AFAICT what you've described is what Intel is calling IMS in other
> > contexts.
> > 
> > IMS is fundamentally a way to control MSI interrupt descriptors that
> > are not accessed through PCI SIG compliant means. In this case the NTB
> > driver has to do its magic to relay the addr/data pairs to the real
> > MSI storage in the hidden devices.
> 
> With current applications, it isn't that there is real "MSI storage"
> anywhere; the device on the other side of the bridge is always another
> Linux host which holds the address (or rather mw offset) and data in
> memory to use when it needs to trigger the interrupt of the other
> machine. 

Sure, that is fine "MSI Storage". The triggering device only needs to
store the addr/data pair someplace to be "MSI Storage".

Jason
