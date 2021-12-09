Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47C46F55F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLIVCQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:02:16 -0500
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:18528
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhLIVCQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 16:02:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0F1wGeeeSm0jWQ7PJvkm0VraZFI6DEryoaV3mbMzPWdbKyRlV9rsBxezRl15wXmhAHyq6oGCxvXGi92yVCFg6yY+LRYDs18x9R1e1APCfPYUSKSu1O2AeB4FEheAYhnsRQ5ak8DU8vTc+/kz3CKOoLFpSF4rFU0YSz6CLpeEGaUIEIb0hD0GxOwMBSQ4G5mDO4xzvzMomm6Us3FhLPIdOg5h+fAuwfxPg6mxC4EmI8ic/aL0D+wW+tuBmoTpDRb5j6K2xn8J65Smfo1nSyfW4kEWwa6877YzL0cFAnrg21Kj6JYM4ev8tIv4Y1TulfV0QG0ZYnXj3Aido1UXSKxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+etbLonmzIXmgDqLGAV7I5NYJ3/Xqeek3tduaG0wTc=;
 b=C/zgCQ5g1vFm1o5FnlvrwjbiRJH5cNgbtVdsWt4sjfLTCDB5zg6WSOVthidr1K6PD80c9GCP7IpppBmC+C6k1DtxKjStFY8BrXIO7x6eZ8c1GIZrMP9I7LrpMiutry85qpOrUXSqG7BWeJUXtlUzjispo9QEXSIPI11OxGrWjm8Be2kY422lDRyDHlQfY+a/KMBLFb57O6O0W8v/NYarK6vmb7AP4H7mPfb/lBuAedI7FXNXc3UcQYI3kGyk92kx/p+omhbuZWnf4FCNKl2W9bRoPx+KH7k4R60Tp3T6NhEnvuw4tyNOPnx80K/aUgFiRbul3snxpfMXVlyjnTCZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+etbLonmzIXmgDqLGAV7I5NYJ3/Xqeek3tduaG0wTc=;
 b=fF6YyYA16hMPZjjcpfQ8SqHj3LXQV80hOfz5p+L6IDPFgLWJQn80jIg1xxlZ8ON2xlyHLuaqMd+Xl5T3lGQkOPXwRldSfQcxkSEJROUflzJ6HdGiuWlZznUgl0qyZtHTbiTJdbKWUIvKxbSXjh0HeRTVMnsEW5bOT2aCoQT94H/Ui7pi3PRqz6MmAkUX97DuWI4vo1mCOuf41vwe7hHXp+DgNAHCNitcRO5/wk37pHbTLcz4D0qYeMsjm3oi9D3TAFFJNxdA4K9P1yKK6XX1FXZTOCF0Mrsr+Kav+1RYaYbh6Xx3JL8qrg+3CfGTTTBTfIANqkoZvH1rL6btzNy/fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 20:58:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 20:58:36 +0000
Date:   Thu, 9 Dec 2021 16:58:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <20211209205835.GZ6385@nvidia.com>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
 <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rwtzfh1.ffs@tglx>
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc8ccbdb-d4c7-4eac-a345-08d9bb56aae2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5143EED6110D434088B09783C2709@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xopPjCyTjnO4ZcSOE4+KpTz0QlOLNH4cLXixgkTHNoiKR8zwrvNR696wEjZSJau8dAGZSOqe1SOaC+7OjQeCDBTy+afEkF5+RJJkY0yv7tCa05jR6xMC/qd3HKaK6e0WF49/2ff4Ii9I+yqb/XOj4HNejHHGB9yi7Q6gcpm6iHcy+k0KoogPxAOyYyT8Yo5fTEU996bWSD6IuoDD7T4EI74L6RJKFxk+BNebO+GVNSQB8WwwwLDz4EOacAErKbdEaZCnGijkGPAdtChAH1h55lT9bpCBdf81a5pI8BMOUBQlN1D1Z3pN9mbanUoeJHmaiQfN6AKKA//sos/W/GnWowQgEszI2wsa3l9XZ+MhnE/jHaTdB0E6I4OF/wDYFryrou9hIUQFRcG2S6pFCsmxF6WDahemd5NnsopJr17N22DD8yd2VbAMIkkXEzdGld1lFL1JwUlUQxt6DiVVCIadqz8mzqdA+NvOIuZlojhtS+TbxeXx/MQgOKquTjpbq0Y+8Z2epAHI70sDlbH695zTeswvQrbR5pNBc7F9l34ZUzrpjkbmLwBpj4jgLUTAvZIv6tMGpjp9lL252bDdXHonE5AZEcWtKUkUHZ8YEXTfyGTeyojDBNtZTWMZXqIn9xixdFHwrMz+FWGoVk7VDTU6Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(83380400001)(66476007)(6512007)(6916009)(26005)(66556008)(6486002)(2616005)(8936002)(5660300002)(54906003)(66946007)(2906002)(38100700002)(8676002)(36756003)(186003)(4326008)(33656002)(508600001)(6506007)(86362001)(7416002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGnNdxm3ODL9Lj9rmlJhmr6W/sE9lIRuiqSpM31NWtci3finTvgujJVEKysP?=
 =?us-ascii?Q?1SmrtVbhI5yyfP1uRWXFfpiUzHYTALqiV8USQIcx8yKizHZgoKSCN9FuGacF?=
 =?us-ascii?Q?Uu7q6VotlLTQLnno6DwtvMMY0PvqkgtTymdIqQFZ20fLMxMbOSLEFGfAogvq?=
 =?us-ascii?Q?Xf4QYtWZ2DzgsdnfdaPVD50fVJvblWTIXdroVNDaUrgfGNMQdq/i2+FX6lDs?=
 =?us-ascii?Q?sYyTXrSHryu03USidqoa/UBXETj4LRAipEvbi2ttLMlT/uNLS3/2Uxnon38K?=
 =?us-ascii?Q?RW27Eowr3uNwGtrNAztymB7OSu4Ec+ABMp+Vhy+L0zpMWvCymhcG2+NyOkyd?=
 =?us-ascii?Q?YmXFi+zaivJMnYkEDuU8ukPLKO6miyFaUSRx33IgPLvS9Cc5LCe9YRImhstB?=
 =?us-ascii?Q?vv8EhFhOMM4k+gKibvmZcBlgT7vWCtmDzq715GMZ5MPwqjO1URgtE3R58nBk?=
 =?us-ascii?Q?HZI7GhDuwM/K/yiNm9T/+bNloTICaqWO6Kb8heHnhVKIHm+KmFjcxiY7V7x/?=
 =?us-ascii?Q?oA55mDx7n6yqaEM3TfHKNCrEI/RdZ7bQsebU1KWhfUcib07F0mIQp4Zb7qBi?=
 =?us-ascii?Q?hGNBexoIXkOrbijxJwEtZBC9sgzT/Qww74PuVgOgKEESSVW5ZUflHEU0LXwe?=
 =?us-ascii?Q?d7e+npw7P2HOKySYIMNQ/ar1+fHOsHNbBtzg4/NXEB69C38yBToiBvp2zjbP?=
 =?us-ascii?Q?kiY81gRhn2MnIg6Ins27of7NDUgJIybLZCfOs/sjT1f9MAseSLBY9Oit2wvw?=
 =?us-ascii?Q?GjkcTGgbIClOQFcpsc34HDKWodUKp9Prh7IYCt2mniJy37pGbjsZSIj95iyW?=
 =?us-ascii?Q?hdXdWsBDPEAU5F4QOiaWM6M4FMMOAKB7UkBuQRw6wy/rVli6c0AjP2Co9Klb?=
 =?us-ascii?Q?RPeYo8+AC8ICqV+u/ZW+p9y+2FqAJ0JFap/i0i7aGAFurXUXjvsR3DAlCl92?=
 =?us-ascii?Q?T/UZGoSpTuKs7IhYOby0z0sAhWX/dgl/JITPG1mlTv2/mYxLh8McQgt63FeP?=
 =?us-ascii?Q?AIXhh3VLR5RLhZFjh4uJeJBt1ow1zqkrS7MvB/7T38ry1Msj33l1zvSKtU/h?=
 =?us-ascii?Q?7xBfR1HxCxn+1E8X3tzKCZ7cdgUv4L/ZOujyagizPrRYKeadNhlnDs64EiBQ?=
 =?us-ascii?Q?XvC/+P3HtnCvXt2+TUpNsS6V85zyykBm3nduv3l6juWkUxqj4EeQOgOo1bSm?=
 =?us-ascii?Q?/J+RQGOU4w1WHbMPf35mHoR0qyhpBO9GX3hp8HiBOgqemoRaPvt/rVzMbTbD?=
 =?us-ascii?Q?YORO6tvJrf4cYCangWgIWiBWke8U3f9DwHbP4X9oaIqocrKNhmDZ3ehZZXac?=
 =?us-ascii?Q?zKyy4hXgd5aapGAE+WkvqgkVDh3JGmhNUswn1ja8sOT3CUAhSWJgqaaerMg+?=
 =?us-ascii?Q?Nghq/voG+MVCyU/bYbrYrHIB3dBJBx/8Zqe84eQXos7lGlC9H1E5VEYD+q0L?=
 =?us-ascii?Q?2VaVcIei953J1F5VqcnM4WzB/TlzF+zAnKaelXQY9q+URuvwhW20k2OeUH7z?=
 =?us-ascii?Q?p+Mwin3+4/pTJ7bvPiYhJXQqzvz/ZCVpwZW0URDBtPa1vCnFV9p9R1nKrN8y?=
 =?us-ascii?Q?jTP/S3YXHJU4P7qA1PE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8ccbdb-d4c7-4eac-a345-08d9bb56aae2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:58:35.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4Qw5mKrSRJfZ7zj0ngG3x5ixYTjty9weeD7GOeS3Fv97ES6XIVOAzwzgZ8k8Thn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 09:32:42PM +0100, Thomas Gleixner wrote:
> On Thu, Dec 09 2021 at 12:21, Jason Gunthorpe wrote:
> > On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
> > If we keep the MSI emulation in the hypervisor then MSI != IMS.  The
> > MSI code needs to write a addr/data pair compatible with the emulation
> > and the IMS code needs to write an addr/data pair from the
> > hypercall. Seems like this scenario is best avoided!
> >
> > From this perspective I haven't connected how virtual interrupt
> > remapping helps in the guest? Is this a way to provide the hypercall
> > I'm imagining above?
> 
> That was my thought to avoid having different mechanisms.
> 
> The address/data pair is computed in two places:
> 
>   1) Activation of an interrupt
>   2) Affinity setting on an interrupt
> 
> Both configure the IRTE when interrupt remapping is in place.
> 
> In both cases a vector is allocated in the vector domain and based on
> the resulting target APIC / vector number pair the IRTE is
> (re)configured.
> 
> So putting the hypercall into the vIRTE update is the obvious
> place. Both activation and affinity setting can fail and propagate an
> error code down to the originating caller.
> 
> Hmm?

Okay, I think I get it. Would be nice to have someone from intel
familiar with the vIOMMU protocols and qemu code remark what the
hypervisor side can look like.

There is a bit more work here, we'd have to change VFIO to somehow
entirely disconnect the kernel IRQ logic from the MSI table and
directly pass control of it to the guest after the hypervisor IOMMU IR
secures it. ie directly mmap the msi-x table into the guest

Jason
