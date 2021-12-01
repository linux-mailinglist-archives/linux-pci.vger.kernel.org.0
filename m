Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2384655C5
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 19:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhLASuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 13:50:50 -0500
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:23648
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229673AbhLASuu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 13:50:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRKnpRyqqiqwtYT75rT0bvGJhQmnXu3sqEAvtUzoDqchoRSrQeySqz+57tk2zD4svWpqvULpY3mD6vgZVHdc86o4/jtkjVsBvXJbz5iMPguBuDSpdPcJjiQ+dU/M2ytUfgiIyzah4I/px47TgsG/nyLeY1wyW6sDdOa7xqGg1zFQVdhU7CvrIuVCR3pRbMvbJO4c9UHCxUzJk0FFPGdPgD5zk+NWAZe7154HHcfNCPMNyO1sG5hrzkMwZYGvNTqtUx8LF+V5qlqAYrZoiaaZyiDi2I2qL+MTdRD6z0fnYivvStXnST++TyvQBKjlUinu2XzKxI3vr1c1K7gGtK9q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXItD7ldxAtzBmsqOWiJr1ETJJVIgdNHSztEjVM0mcA=;
 b=CWoJ5PJDKs4Gj9dzMVv/6EIKaadjTEfbAKlU2U3hXayEBpI3I7lWIXJ8nZz937n8NSL7PUBCxMrW8wC7ySNOmozIGR/2JGg0ADK56SJAn6akBSLa/vAP5879rG11UMMUc6K0Jx8evWDZEWWcSUnzyhnQ5+JN6cK3x8H9pp+H9jpH2+9ovegNtHV+hfkjQ4ZtmOpi2Envcs1STikivGxz+0tNCxgGZL/yvT0EWzQ4sj3sdwuhCS+K13IuuBZ8wNqu3QFfT+qQPlw3AFjSsjXzOS8XMbjB2Fp6ElaL2tXwXy5+H5toCknt0X45b3fPxnlACY42RE3QtCMmLYRS0RDmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXItD7ldxAtzBmsqOWiJr1ETJJVIgdNHSztEjVM0mcA=;
 b=KLDxS1f98G13Kqylgj4zyYoi6ODJXJS2oFMWkQzx2Bp1nLtNxidi1+zIgBnpdgksB4P3gzPl4vFcclruHvZ3Y1Q3hzjFQWewscuDezrxkSaVCp3+p2z4TL3l9zTaYqunwGHbSNunsnsUuW+9nZnWj4IBX6R0uohseh3i0UJBoBFqICl+iyW/+aMQ61y3szigqJ8BfoKi/vlEEeM9JI9OxabF98F71YNAN6VIypH3O6edhQXRQVp1ZYzo/v5DW4gsJNqbfsLVksl4Jge3IqOea/zHnkCTiR31SJtSKCpElYf6TPZ6PyDDwtJst+8PwnrjefzadD4LlZqo6gamS4/lZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20; Wed, 1 Dec 2021 18:47:28 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 18:47:28 +0000
Date:   Wed, 1 Dec 2021 14:47:26 -0400
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
Message-ID: <20211201184726.GN4670@nvidia.com>
References: <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <871r2w9y3x.ffs@tglx>
 <20211201151121.GL4670@nvidia.com>
 <87sfvc893n.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfvc893n.ffs@tglx>
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0075.namprd13.prod.outlook.com (2603:10b6:208:2b8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend Transport; Wed, 1 Dec 2021 18:47:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1msUda-006WkA-QA; Wed, 01 Dec 2021 14:47:26 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3cd54a2-a17d-455a-bb1b-08d9b4fb05d7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52290D3E02BD4F3C47245370C2689@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yjyIJ6w1qiB7spINi+OjtKiney4QTIkSClJAs7B4a2g+NKMEYjWA4f+SAX4T/EDjAu6Y8sXIT4VsadcTu6GAbPtH8Dtud9zxwod7R4AWduwJvtaCJVkvwcXqKGVxZeOyrsTnVVwub5lWZ6VFHBN37rKLoHDSXaN93MD9yMYqgvMecNBOSVpzd7Dvetr4e/AxU5Nxrlf7OzGBYdCQKwS3izVo45ukgsoCb5gl5ZhlVKvSssPeJBvuxQeaV8bF/aKGpvm5F3yr9YoQIfpKIf33jWFjK/857ftyWwzZR+D/yXcQd601WQYywriF9DtPlO6LVYzjEq1VE4ifujoFfpa2/zUL80xmwQ3g26hmRiy21egK9UmqvCWtlgLGPIGAyfPxUDWRsGbz598EgoIxlnTx5NZTVZMEwWi7BKA4oxTi9C1qNRYYkTUPBO4+T5CcgZ1HHMYn/FG9dShJBuqTYFbQN2GJKzeY8xl5HsaAECaiOjkIuZMeC7S+x6XiwZUJ4kdm8lBb5+NKAFtIAvuXqP4psNhl1tuO3N9iP3/fyPjOmOF/gxh//lT3jaMKL8HILJSnP4h2+6JvCFa7QZBw2rlYxL1wpuqqA1vqZ73G745WFFBpfTy4fXivBO8DJKdcwocqTGThV/MZ4lAcJgV0AwKkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(9746002)(2906002)(38100700002)(9786002)(2616005)(66476007)(8936002)(66556008)(5660300002)(54906003)(426003)(7416002)(26005)(508600001)(6916009)(1076003)(186003)(4326008)(36756003)(316002)(33656002)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mTpAgeJtDzpVswsVvWxEIlrkVDFcTAeKV0nQ2ktPOsK39GObHRW7KylOWRsM?=
 =?us-ascii?Q?EnzrWlJt3tWUi+4oneF81YSln3l/8sjtIEDXXDW3uQ/oT348TeGxiYHIGwdo?=
 =?us-ascii?Q?ichARPQBJ4q1mg0sK4yjZFCkKHkMvxbLUxT15TJYG/jLkTSkbP4xn69PcaOR?=
 =?us-ascii?Q?oNLEqXbVkktVAXimWnEYR5LYgpoXMjj8DwKXYEr6Tkf8xV9dh346NB7eslrq?=
 =?us-ascii?Q?VaPtQn5tgbkq/cleRo9ETEphWMpByc8Q630434kAVR8Hj/kHeBQup6+04yRi?=
 =?us-ascii?Q?SLqjEaI4xt86C4QGim8L85ZW0AceE2fP5IGcScBVMdVTqkQEJEOrucGMY3Mg?=
 =?us-ascii?Q?BdH8+qTpA2mYCobJNCWksYK3liLY5I56rCADfsEXanY16qLwhD/4QZ1G/Bdd?=
 =?us-ascii?Q?c0i/zwD5wxF0BR6iwwM3wmucLMY3lRGSbEtXAzHVpMfpMUoMXcmMlS+/MykS?=
 =?us-ascii?Q?IxJUArUH+E9OoA9mNvvJf1hLyY1x7kD5r+3wp9/X554JUD3P2euG2l6f19Of?=
 =?us-ascii?Q?du/xCXFP8lWru+3j6q+9lRp+1nNyNHnsDbaV04aCYkqvOhA/BSKTm4/pWl6Z?=
 =?us-ascii?Q?Fmdurn8KpBC//U33/za/9pGFq17TFnfqpEwkGK/lIlvdYEi6a98mzCFdfVcD?=
 =?us-ascii?Q?LQ6LFbmb7aH+XX0GAYc8VTJLWxi2HetWAOZ63piEcJ/uuMtEQjiIahIfSrc9?=
 =?us-ascii?Q?4ADsH9L0REBSbuQFaAd9y7AM/pWfYUlSWWXdzQ7hss7LiRsbKJpzq8eytpHb?=
 =?us-ascii?Q?02i8iV9ITCS7WuM8ZFdJoWFE9BqG+zVBJsoVlzQBaDMUKSmMc+Lvb/M8qKYA?=
 =?us-ascii?Q?q3CFkgyCElbfQ/O+/ZNOc8pfqpYWfgmu+71LOoUKPWvtNozUlTmZ5EXWul9+?=
 =?us-ascii?Q?0ozvf/rOGEW3LFvPaf93SyV/yDnccg63RsfI5bpT0kxIyw6CLO8ZDugfXsKk?=
 =?us-ascii?Q?ThRXBEbzQb+fyo6NRnUviAacTDUER7WOtKs6zYnYH+OcvSGB3wlGYYc5FxPu?=
 =?us-ascii?Q?lN4Ku3v9ajuPY4jWfpo4xKg2l9DJyAyvU3TOOwk6YfrpavAWqxtpbGO1TmXr?=
 =?us-ascii?Q?INmtlj6uLeokifhGT6olPAPPUCkp8iGJ763XlUhhrwOUHrjjSX5d0MnopCxl?=
 =?us-ascii?Q?S2lhDY6vpanFVgoRPUjr+/o2UrMMjjJS4PdUVNMZIwMUg1hns7i5QMOT0EhE?=
 =?us-ascii?Q?wXaE+ef7CJ1jaASWVO3DwtGi+unfyqYJjmPMf+ROMjlbE521MlrfUphZ6Isz?=
 =?us-ascii?Q?xsQ9rpNG11PuLn2X3eq8lb7uojFBMAZ8XPJ7uaofpPgLIzG0WdpYPUiIYCbl?=
 =?us-ascii?Q?h6eot7itlhL7Wwuhj2b0yCgXpINcaqypF7DccqgEPkkBUVQULdEhq+OLxDGf?=
 =?us-ascii?Q?sejmHQ1nul2Dzk7VBlBszS3sxgLH0njohKryOFSDbm1pBB+a/wh3AEwX3Otg?=
 =?us-ascii?Q?Zd/FzrpNa8bJEwaMRAx7OSIHcz+o8PXJyTQ/MQHOWMAraveCtGVWOpvJrcG5?=
 =?us-ascii?Q?Srjuf8BcCJ4Xz28RPu45wwgcmmFg3z5bX4iJmAt12Qop4gL/bczAoAVFfBFb?=
 =?us-ascii?Q?xbfmhf1up2RfIT86rag=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cd54a2-a17d-455a-bb1b-08d9b4fb05d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 18:47:27.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 212YAvZ60eeYKFhqTPhxQFnREVA2/mB4J49Qg6WCQWz+7Qkzla8T2ew4MtUTo5CP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01, 2021 at 07:37:32PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 11:11, Jason Gunthorpe wrote:
> > On Wed, Dec 01, 2021 at 03:52:02PM +0100, Thomas Gleixner wrote:
> >> So we really can go and create a MSI irqdomain and stick the pointer
> >> into stdev->dev.irqdomain. The parent domain of this irqdomain is
> >> 
> >>      stdev->pdev.dev.irqdomain->parent
> >
> > It can work (pending some solution to the iommu stuff), but IMHO it is
> > strange/hacky to put HW objects like irqdomain on what is a character
> > struct device with a set major/minor in dev->devt and associated
> > struct cdev.
> >
> > Conceptually it makes no sense to me, cdevs are software constructs,
> > they should never go into HW areas..
> 
> I picked that because it _is_ already used to establish the connection
> to the switchtec_class NTB driver which is beyond the usual cdev muck.

IMHO that is also a misuse. These days two drivers should be hooked
together using an aux device, not a cdev and the obscure
class_interface stuff. Aux device supports auto probing and module
auto loading for instance.

An interrupt on an aux device is at least somewhat conceptually
parallel to an interrupt on a mdev as both are usually representing
some slice of a device.

Thanks,
Jason
