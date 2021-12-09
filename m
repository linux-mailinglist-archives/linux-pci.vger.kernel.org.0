Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3246ECF6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 17:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhLIQZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 11:25:06 -0500
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:33568
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235727AbhLIQZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 11:25:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOENTDkFiSsj/FQG5HFN2CZdSVBAsWCQx+QAKk8ADq8DAXDtkSYDUyJ2PcGsb+peVwGc+CB31nJ41v6kDbx7/L64OenoOf1HqMLzrPGBlQ/sDl36VEN6RwuftKaJ0EdSrFF2LVYeqzU5JFZVReqBByjF3SxN3fMg4lXJtgyTyGqc8mJxuSm2lU0GPEABrSTGAFA0p17qEsM/0zYC40Zm/S8m78zQvAIXeQ7T7owZjT4jiOWw4QDBzV9gTOCIrxiusAVi5ZyoWNQpLe8lRSXf0e1w4sQKb2RwK/bxGDXtxGPj4XFVAwichmYLdUptztWgb5QjRWcf7k7FgOO5XlqbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgPDlhNAzB28ieRUrppSXQEi1R8DHDSAtSWhVn+tnQo=;
 b=ZAScLG6rBs+oV4RU+C+BFWmf1wjZ6fSgvTt6Kn+nCG5JSgGuJsXkTHy9w01zrvpVE0DjM9EKlBl3nwmh/OToiLP4iR582uixmphIaWv/w6fSnS1UZT5ZPNw6cxbTNPOMgivGA0Eq/k4XLiFn1fA8DAwihLPJmDh0Vzi+SJY9ZOLsIpk5o733ugmrnS8dm7heieinx3XB1P38PqnetgIV3L4PpShqmUpXy69oaOaQ8JisW1zq8HBTfNHavGm826N8u1SZIJ01iODGyC0HfE6sm1qcgaVSApweQJ9VCOqjFXlrdIdddkMaY+oU/RF8VlLw07ELOmu71320P6wStRgzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgPDlhNAzB28ieRUrppSXQEi1R8DHDSAtSWhVn+tnQo=;
 b=BJNxtQt1HYqexSvYR2oi+Fl/KygZcaNq6J06FDoCwBulr4GXXgpA2nDPzsTT0N0Xhj3zkbRczxxBEXO8r5XAv0HKQJSUPahr+OKkQWu4JtkwPHZR6lgO6r7FkKs5b3EiXphUKztcOlRbeQLkSzeQyufcijiY11E8YUkZU+lMTHUeNtAmnUrIb/4A4pNAu4mSbNWxlYF8jNsPSNEkyHAoqi4pq/N9yqyY1ZjxSwPF+i3t+pTDh5KNJyuya3mPIYi8wW7JQ9cnXJIU/sDkUy9XVHr86owEUYQJ1e9uKyPVjX/Ly1I+lgGsWin++6DPIFhTsDzhfG0EpmTvBOv+QugIXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 16:21:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 16:21:30 +0000
Date:   Thu, 9 Dec 2021 12:21:29 -0400
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
Message-ID: <20211209162129.GS6385@nvidia.com>
References: <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfv2yy19.ffs@tglx>
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceaad3d0-bea1-47fb-96ef-08d9bb2ff53e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB517473759B1E3E3F521D8B15C2709@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWRaIkG4ZxaNseKtDNRrE2IibmaxxZS3fMfCEaPRjTPrUaUI9acH1OAtyuWalHvAa3ZrwVEkztxVajhECLrf5sOmudVu4KqtsTmd/xfPEI2e5LF/7UchpW5XzLgU53hQRgWlWdglCiY4tlko+iFn6jlEUkfG9nWolYmU7ZyYmKyKHSUUuSKAu6D4WXxEhB2TcX41jn4k2+unumorYX2Pcvw2SRXVNzSxU8MO8Ch0MNTALpFhc7E4907s9wgTFA5ZqiKcuInpQqllWnHwWazFxo+mJ/togRY87XUPA05ARCKdljSjPIQiFHZjuNBgTcSO8wcF9HXAegNwZ/StDbzYVCfdiCBCdEvx4lhVDsUGFK8oaarujBexhOxP2Ph0Hf0iQ3pQRzasyy9nDzE6b5K/4JJdZDghv7md0rV+GBF2bpsTCWuX0nRHQkb2NtdghTvNUn7uPbLZdvse1zMZf89tN3A0+qA5ors4WsdyvNpdRIZ9GP96pqko2+JfVdSIxErzSUuIUAdF5f77NQNFeEOoKvAXoWezqs4/GQdtCe8/gPVxq6YtxvMFC4l76A3JNsJnrZTpPxFup2Uz/JSke9LXX6kLdFF5gPTpbhVULfhFJTGd9hUmdADp99G5TX0r6WK8SufvJa8fDQmz/pZJ88fEWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(2906002)(36756003)(2616005)(5660300002)(33656002)(6916009)(6512007)(66476007)(86362001)(6486002)(66556008)(38100700002)(7416002)(54906003)(4326008)(8936002)(26005)(316002)(508600001)(1076003)(6506007)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5C02uw14WhAWiIggLNL9HhXA7jGTL3xtRUP1/vD000rzgJilACvrgVcygthD?=
 =?us-ascii?Q?MJ18960T+EzhdTKiA2ZO4z7YSWvYTmmfHWcgKo5egSoSU9kgJeB+Fbw/ZxQY?=
 =?us-ascii?Q?p8nuie7rc7+DlNCnJoEv9wrte8TtiTDFzJhki706/b8WoF/95N+ig9yCRJKm?=
 =?us-ascii?Q?tLYF271oiRp8dw8BLb5ECjitmLjsaU1YMiQiUdJtx4tPWq1LQRN3uEAb9hhe?=
 =?us-ascii?Q?OvX6FYT5nNNVHXrKEocyBLd3mKXjRGpEUva+16OOFgSp3TqTL0ztzYGRf5Vp?=
 =?us-ascii?Q?2VwzJhsJiYOsu86tRSkJko+a8kLrXVAsOQeyNNETgNUpvTDSlWvbBaeYG3bw?=
 =?us-ascii?Q?0DJawaSZlTcEfBCKpxy2tJnr1RcK7UuR9Yae/jU3PXwaFs1CIogXJSOIjrqd?=
 =?us-ascii?Q?aFa/BEYSduqklM7dzCS6ask69zdvetJa6iTFk0SeiwhvjrwPgCq+Sd7BO19W?=
 =?us-ascii?Q?B/ZN3OBUoRZnFDi0eSPc9azGIl/izO4Ps9yXTeQUrBYt/LhkwUKUZhJaLFmK?=
 =?us-ascii?Q?UqAvL+ErcWEk4taKzCOJUP108RwYQmphUt7seabVhFM3YpXZGNQSiFYJia8u?=
 =?us-ascii?Q?PuDNrPuQfTDQodmGWHm/015NVsbLqfL5W39Kt8pz9p/Kv6QpFui5t8Ed3b5I?=
 =?us-ascii?Q?ztvyx3pRn+OTQdfTKQrU5CNj32YqCP3aKRrfjW+X/teIrIIlvXa8KMOdASv4?=
 =?us-ascii?Q?fd8nfFS0tk2//YdrpvD9pXEvk2KenIHq4yfikXkpcsPlDPXmPV7ccCExjnSu?=
 =?us-ascii?Q?SNT5gS3taWjNXfTchFMi94vNE7vkbrEv39v3brmt3aqsitA0ESl35rz/hE9/?=
 =?us-ascii?Q?KFQDYuEi1AAE4OjWbth8NC5anE2naeTHIzIUY7q1PTTs7Ei8oFGgpGdt8m48?=
 =?us-ascii?Q?r6nkaXYYkdnl2PEnLSLxwR4rbAcOtoVcyOyB+QA4MczkIn0lD7QtObYaF+z8?=
 =?us-ascii?Q?WLKIQqtGMVVVpdXaokQFkjrg/jeDQHAIhkpbQd4gNncsNzFb5NOA5dEdZ+Sr?=
 =?us-ascii?Q?y4fMle87tx2k3NMo7GvNrd18adYzzGsqLGgUwckglI2SKPGflKSPSOM8XAbO?=
 =?us-ascii?Q?LkKvBOshKBvuabulu56oqAsdwtTfPc3BMIXLCescTZtOU5aM0/3Uy311UjAT?=
 =?us-ascii?Q?EBkCtZ1dty0uE8yA+iP+KQQPkGL63AF3c4jsBl1osCnyh+Ffk/e0Wi0sCJi4?=
 =?us-ascii?Q?X23120QYe2EZvB/fWlPoD93bLBW+XdLB3qQVl42NEpcE6DxryKlMvg519xRO?=
 =?us-ascii?Q?4VLWD6MykqD/TVj8A/brJmaqxQwPV6OfamkAVlWM+dO5floaIJ3V9jLvjewN?=
 =?us-ascii?Q?suDVpV3I7IkzIuBxTetICLAuIQeSer2QN3x62m7YPwBkMVKD72XneM9dlUy3?=
 =?us-ascii?Q?FneDLRQl+Eu2DXMQGNsJXOPYPxactM/KjMxNc5+uPskrjAfkX4wXDVgndkdp?=
 =?us-ascii?Q?OG+qP3dtGsuSiFBSqGAITwsVhCuIQg0TNCDUliqaSHt8jlnfUh7I5O1MDpbN?=
 =?us-ascii?Q?117/fWFtJhcVAjML8RIy3uNlKujcRaLM3Lkzp8tiUSlHIBXBRUxpXaksu9S6?=
 =?us-ascii?Q?ABwOMzjWKJpytIuJBy8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaad3d0-bea1-47fb-96ef-08d9bb2ff53e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 16:21:30.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuinvCzm9qNHsV8oCXejq8KNnDdAGfRwakutYCXudTpLNAa4VvWYoIVuHCwsrbjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
> On Thu, Dec 09 2021 at 05:23, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> I don't see anything wrong with that. A subdevice is it's own entity and
> >> VFIO can chose the most conveniant representation of it to the guest
> >> obviously.
> >> 
> >> How that is backed on the host does not really matter. You can expose
> >> MSI-X to the guest with a INTx backing as well.
> >> 
> >
> > Agree with this point. How the interrupts are represented to the guest
> > is orthogonal to how the backend resource is allocated. Physically MSI-X 
> > and IMS can be enabled simultaneously on an IDXD device. Once 
> > dynamic allocation is allowed for both, either one can be allocated for
> > a subdevice (with only difference on supported #subdevices). 
> >
> > When an interrupt resource is exposed to the guest with the same type 
> > (e.g. MSI-on-MSI or IMS-on-IMS), it can be also passed through to the 
> > guest as long as a hypercall machinery is in place to get addr/data pair 
> > from the host (as you suggested earlier).
> 
> As I pointed out in the conclusion of this thread, IMS is only going to
> be supported with interrupt remapping in place on both host and guest.
> 
> As these devices are requiring a vIOMMU on the guest anyway (PASID, User
> IO page tables), the required hypercalls are part of the vIOMMU/IR
> implementation. If you look at it from the irqdomain hierarchy view:

It is true for IDXD, but mlx5 will work without a PASID or vIOMMU in a
guest today, and there is no reason to imagine some future IMS would
have any different device requirements from MSI-X.

Though, vIOMMU operating in bypass mode seems like it is fine if it
helps the solution.

> If you look at the above hierarchy view then MSI/MSI-X/IMS are all
> treated in exactly the same way. It all becomes the common case.

Unfortunately in a guest they are not all the same - it is like the
PPC code I saw messing with MSI today - MSI setup is a hypercall,
either explicitly or implicitly by trapping device registers.

So MSI is special compared to everything else because MSI has that
hypervisor intrusion.

My ideal outcome would be to have the guest negotiate some new
capability with the hypervisor where the guest promises to use new
hypecalls to get addr/data pairs and the hypervisor removes all the
emulation around the PCI MSI. Then MSI == IMS again and we can have
everything treated in exactly the same way. Hypervisor doesn't care
how the guest tells the origin device what the addr/data pair is.

This moves the hypervisor trap to setup the interrupt remapping from
the MSI emulation to the new hypercall.

If we keep the MSI emulation in the hypervisor then MSI != IMS.  The
MSI code needs to write a addr/data pair compatible with the emulation
and the IMS code needs to write an addr/data pair from the
hypercall. Seems like this scenario is best avoided!

From this perspective I haven't connected how virtual interrupt
remapping helps in the guest? Is this a way to provide the hypercall
I'm imagining above?

Jason
