Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB801465105
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbhLAPOs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 10:14:48 -0500
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:7712
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239499AbhLAPOq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 10:14:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM5hSMqKzDt8dQA+tWGTho6wQbJIH008QkI5/GMy6rE5Eb9hqAvgDUsW3Yunrfxx1Z6IYuwVnoyOCmx/fy01P85todQAsL7+XqyKRdQTSycnVftBI5QJBdtM0bjkaCIBhE1Rzx2dny0TnCPW7ArbGIYOaoEcFKwcCC3FOa4PqYk4qRvghR10el3oGAoXgnBuB61ueGivp0uOFAdw0XzvrEQV2JpBqDXkaHadLG5EhrVi03fE7v7jIWS2N8DLu6BgRWbprZTY717XcOSnVyuCyTun4du02rMc4NekaLhknaY0XNEYzV/UGSnSxgShQWl4KmcUnmwz+dgDrfpMhrT0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+QoK+XQDme9IGlXzjemsT/bYRCpuI5SuMMBYbhJWN8=;
 b=as5J50JSCsd40NCqYdTwxh0juuNCDDRO0XuO1+7fYTUgrwqkprN2Gs7iJvLNHSm1zfjn7/60RPv7psewQwU3Ysz641dcnnIdeVOZpaDf4Ws0LLbDgl2aTpVPe/rqG5KlNZMlpvN/vitN/pzXsHUoPP6p6XnTi9HGbVBr73IFGlVzL6syJFVafcK2ssqIoktZA2nfeCImIXf/CBJ0CD0OYfkUaJUWXzRiEGlbhCR1PnZlvuoO66cnLGIriZMRUpHMwTmin+MkNoytnd8WoYSDQq2TC0CV3UOaPlwZH95jR3+8qSvQ5+/aYI5+jVv5ATFtKfJMnU8uUKrzCbi/eFbLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+QoK+XQDme9IGlXzjemsT/bYRCpuI5SuMMBYbhJWN8=;
 b=YLmZ2djiOSVZIjUC4VKK5TRLxR5WRfM28SUdhYBV751zYrOUp3iVyx/JFa/mjXJgCAxfe0kl6fEjwJ3Ebr723rfuCibNtm+aPj/b8gjvnFDH4Du6eOOWQ0VhSsJAKj55gRocjV2pIYf9ESA5sVMjM0c2fwcnIisjXzmsoM+oBIj4ArmQx9dUl947fpIu8+K/woIjavamo6EwVRmoTFI9I8X2tPw3KTX1EFASIjIRAP25/+D0LxBJlNFrjY6alHKj9SUNG+3k5Piww7qmyG9iISmaVbQwNEXP1vgvnoYUrk1DXeRaYN9OOOYl6DOIdE+H0ma+CwmZFzjuwDAJacP0JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5280.namprd12.prod.outlook.com (2603:10b6:5:39d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Wed, 1 Dec 2021 15:11:23 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 15:11:22 +0000
Date:   Wed, 1 Dec 2021 11:11:21 -0400
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
Message-ID: <20211201151121.GL4670@nvidia.com>
References: <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx>
 <871r2w9y3x.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r2w9y3x.ffs@tglx>
X-ClientProxiedBy: BL1PR13CA0307.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::12) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0307.namprd13.prod.outlook.com (2603:10b6:208:2c1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.10 via Frontend Transport; Wed, 1 Dec 2021 15:11:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1msRGT-006HKW-Cy; Wed, 01 Dec 2021 11:11:21 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b67d7299-5fec-410d-0478-08d9b4dcd606
X-MS-TrafficTypeDiagnostic: DM4PR12MB5280:
X-Microsoft-Antispam-PRVS: <DM4PR12MB528016D9F8AD547ADF613821C2689@DM4PR12MB5280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ev5RE+5gPUrgP+zlInDGDWjLsQXXOZmstsegV0ISd6MarOV/Z1bUtrr0/yvL1hTmQPI8O4646MZy+ZQHF5wek1Inlr/86wmTOAsLGqmOR6DIRbqDjyK0R/UlUIpmdZnpe95+LqSJO/G3tPGKFBuEYohiMsTlkL32TOpxG6IaKpIY32wXi5pC8Ww9pv1axmx8Y6O1r0Z7VAmmcS5uW99q10toXn0ixkQtm0ek4ZmCbXxdU2nDmkRVeQRQ5NxgAjqTyN3mPituP7ohYYad3qDHt1wEB/YdO6QZefkn4DL7IP5YJnXBfONKVMfPNo9neMBUOJF/LZ4NHN9Qz+AwA+QzXvJSv6wSfE1IM2epotEuTavAhjOELXLzPYXDMZYEKanY2jk/qy+gGJnBombNjwA3MlpFMl7EhPfDeVoRoNM6KbwoEhuKfD2QsDMjxU6AWMXUt2RZpAiNZQ/zCpuikxGrNFmSoaTbGRZ5cPbrehn+X+bwEM/RLMZd7PTOnu1fEIjRUadWCuBLmYbaqVGtzmX19kFgIKJbt0Beeba5R8rUwseV+ovJlV6Yw36dz0UrSIBtbb+T5dvR7LfZZA4792vrHmsMr56sLxV8VJiUnhT6FheRtLI5bIhIwcszXS7O2P0VPGV7BMYRfRhKhp3vXo05fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(9746002)(33656002)(1076003)(5660300002)(6916009)(4744005)(7416002)(9786002)(36756003)(426003)(8936002)(316002)(8676002)(2616005)(2906002)(38100700002)(66556008)(54906003)(66946007)(66476007)(508600001)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGvBQIsKaOrHJUYPTpU6jM37VH/jkkBIlOgASu8XZwZxgMe/zgUJ59HBEFCl?=
 =?us-ascii?Q?oLDqc9G7s1MqrIWGHKu2U58iQIr+Mrh9+Pmipz7KrqCBFWIuUXIjsAtCBuwp?=
 =?us-ascii?Q?9LDosbWndlcB13kzqglSv7LJ08FKm1aa86lyuXkKHCRIeoBCwswqnzLoC5nM?=
 =?us-ascii?Q?g/rdLDC9KL15D3z73yN4E6zsJQbyrod3zPnsZxn+zodBIklAZ2ZU/JtxdB50?=
 =?us-ascii?Q?T74qgJRDMd4c0tjiVbK7jwtRoWnZn+qcItzkizwXZ148QYCBLYlZ+TxwywF3?=
 =?us-ascii?Q?iqdTWN/RO8vOIsyMWVPLShFX4fwbaEjDQWJdwZgSHNaIPitUBXAXZCZ/xJrx?=
 =?us-ascii?Q?H/iGxg+yOxh2xIAQmS7lAPeh/Y5nN2VR2tbi0G+NMlhvRsSKRNa9XgiYjT+Y?=
 =?us-ascii?Q?M//BZR4t3eXxTCA+EQOZq7WS768zCam5n7v/wG5ZN/WhMy+232LPSkEtxe9A?=
 =?us-ascii?Q?Z8hjAdSDTfZhhGGt69LNPmIzCGufV4lsAmhzuSXk8Khq2X5ZCqu60yxxhuOZ?=
 =?us-ascii?Q?u1rkK1Ol6vVjNIbSJkS7AqhWimFdVEwurPqMJ197KLLtTRO5ELsBQBYLTuUi?=
 =?us-ascii?Q?yg+6xPUl7+I1U3fGg5OtuNvyj6Jdjb8ZnvaGlife7JxUy/K/mtrV8mCNnqJv?=
 =?us-ascii?Q?hb9OKWRnRPar5qPPaH2ZZw8BWRjJQCPYvOnZjQcpZXYwTgj4tzNQuTQ/GsOS?=
 =?us-ascii?Q?SYlpy/6mzh7+CautHsBGFanye3grzlvJAr0uNGjcwxFmrYsk0fK3lSXihcky?=
 =?us-ascii?Q?GH58LQ0QrrAlB5Toq72JQBfHBGbuSL9UkjLF2904RlxYX5zzh2bMhe0z4m35?=
 =?us-ascii?Q?FH4++WKFAFw+mWYnccDQYvj0eDwNIwIP0NdhlTJYwdS1pRCCpgB8Utn+km9I?=
 =?us-ascii?Q?o3n5Msm8iHjboemGa1lLM7y+Kmwm3ayTNdSX54zNYZ/8c+/Rr6fbQq3UvnYz?=
 =?us-ascii?Q?nox9ujgzIIn4x1037NX2YFUD1KaL9lNZweh2tDaMSDzo8SDrOJhMxeSe91Qg?=
 =?us-ascii?Q?sK+6PDFhvE2b+wuUK2tyReH5xHPrAcouzK55V0MXxc7wPhe7ODNg2jfQvU1/?=
 =?us-ascii?Q?LM4ahv9gOaGGAO70yQUCPHd8OmKbAvxPZOK38kaAs9JscckkCySan7xfW/UU?=
 =?us-ascii?Q?4MicPldzzWrQYryhJh9naenZB5oPhcmYZgbvHWO5y4/0o6h1//dVOWLK5o+J?=
 =?us-ascii?Q?z69GvKmDUXeMsI9GgobtBluh9gYc2+3E4SOTy5jCAId/7zNuQohuJ0h3mYTR?=
 =?us-ascii?Q?ob0OvQ/Yk9s5D10+ZUPpOhBonC1Ik0TGZwcVR+XCXZ0iP0rFHuWpd80Z93nv?=
 =?us-ascii?Q?xJCBcPx7BS821xqBHfmgno5I1WcCIgVMyvIuBPTkShfmRONAcgYQmHLrogvB?=
 =?us-ascii?Q?ZYXb9f2UATbVZ03Ya1Gn8FLwm9tkLgiPF76UB3rKR7Qk64sA66CIpk6ocoem?=
 =?us-ascii?Q?cOyTo4w8KL/QMttM67DpclN4fasu2QXOuUvjZcgLPkABcDWLdOt+6evMq12u?=
 =?us-ascii?Q?OxEZcDotIs2rBz0KVKuh8SAZb/DTYCqwPzp9YwyKQLGugZOMcAFS5P6nwIoG?=
 =?us-ascii?Q?CrSc5BXOKjSVQMY03MA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67d7299-5fec-410d-0478-08d9b4dcd606
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 15:11:22.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7HF3Sla2SFXdMrITnR7n4zZDiTM2UYBcqUzTnGnaCG+haZFh6nDXRTTEtHWqy7C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5280
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01, 2021 at 03:52:02PM +0100, Thomas Gleixner wrote:
> So we really can go and create a MSI irqdomain and stick the pointer
> into stdev->dev.irqdomain. The parent domain of this irqdomain is
> 
>      stdev->pdev.dev.irqdomain->parent

It can work (pending some solution to the iommu stuff), but IMHO it is
strange/hacky to put HW objects like irqdomain on what is a character
struct device with a set major/minor in dev->devt and associated
struct cdev.

Conceptually it makes no sense to me, cdevs are software constructs,
they should never go into HW areas..

Jason
