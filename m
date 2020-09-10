Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E2826545A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgIJVmq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 17:42:46 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19852 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgIJMiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 08:38:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5a1e1e0001>; Thu, 10 Sep 2020 05:37:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 05:38:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Sep 2020 05:38:03 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 12:38:01 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Sep 2020 12:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0aw5IE4fvFQOFVDTL+IaOk3Erute1GafD/yGQpdmtI1Z5TRDFXanDh8LHW+Vd/9TRr6d8YO9g3dmGoAleEpBmLG6AGRTD77VTvERA32elJfyC916q2L+WC8kfY7cYRN1P1uEtTVjWtN7AFiJuwTBHT6IQB2q87FzjtXgB1L5iIXkvxF6TWAyBmwg9ZPQSlTiY/keXWcfBLg70Q4sFPODr6NIc16AHTsIKNzOQFBtXFsXOA7YFB9d5ENHjO2qS/2jnUXl1c15zENFpQI6ZsNMsLhwiEpK2QciYfled6J2lJI0MsuvzDlvGOB4z4tajg5YgOnN89CYAH86Vi3sB9Q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L77Mt/sfieXghb+zfjc5nDyQkSqzqHqUWIODvssr4ls=;
 b=efB1nzo/Lf2Gm/IUQ4F+7JynFTH8SCxjRX417Q1v6n9PtkRWvV+k50tVg/QWHStnel3EqH4we1087jZdHOEbKt4PDRsb7XkvxFzHoB294T+ljCoF4xufCZDWELiJHaoCCBCbm8B2hL8dQ/vAqC6TBtoE1BS6eum0Zd3MQyBVJ627yKE+eu7x253lAgy3DJoT3h8lteuVdlXcewWNobKmdDWHpBot1qcC64X9irBCtGUz/DOpnYyLgUgvB5Vr0zFQQOTCNkL04dJyg1wrOKPTL3lqLRsRZfwe7Vv574kPrUaT0+cCAo2aFjaFLl3bE4IkFecs9NmyAnKfayTxdUVgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 12:38:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 12:37:59 +0000
Date:   Thu, 10 Sep 2020 09:37:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200910123758.GC904879@nvidia.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
X-ClientProxiedBy: MN2PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:208:15e::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0034.namprd17.prod.outlook.com (2603:10b6:208:15e::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 12:37:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGLpu-004Kbj-6J; Thu, 10 Sep 2020 09:37:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60453a73-3cca-4d7d-6145-08d8558659ee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1755:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1755EF9E571B12E7DC37CBE4C2270@DM5PR12MB1755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POPmMK2X0d4+j0v3wyZBbTIMudBSCzW+6qfRcCa/WXbJdlfIjZaPJ4IWfz/0yjMW6dh8cHhOC0J0C1ArmGtTXzQDuImzEJuL5pxOjN2bYjHBOrBelsZ8fkzBmoTcmOyLQWJS8oT8CtRckYtPDigA6XbB1TizVvib3w3TiMjOzkg2kYSgcJ5nQXjQoRjaiAsizMkyrWQJ2geGfqE7bIDAust/z2x9icURzv9hWU5WO8vRiETN8KMl5c1EHuNg5pBAHuAQ9FHdFfQPmkIC2M7YjMXN7HcRplf3AVVKJ28I/Zfe7fu4ol4czdp7DH4QQlLq4bokiJCPbiUoV8CJ8az0wMO98zdy4gW/C1IboZTqebwsVQZFbgcbEog7U5pk4DaV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(83380400001)(33656002)(4326008)(86362001)(2906002)(66476007)(426003)(478600001)(8936002)(66556008)(2616005)(26005)(186003)(66946007)(9746002)(8676002)(316002)(54906003)(5660300002)(36756003)(9786002)(6916009)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0Buxpy1B5XP7jqjHsgmMXdY+q8ECQyNCqD+J88XO1jwEwPUZzK0q0dPCJDjklpOgT1HfsT6lbL3aiF4HKN/WttgoEda8rfN4qOB769POqp2IFQvwe1HStsxubAAMwSP9/RDGiURo0PVbcf4o8TvY5eZqU8h1nSZcBx4arKsKJ/ER0gjH4Vd5KRQIw6QQaKGrcISaVXxgCbhkt1RbiH5owOTQOAVZvQ2nPf8nvTbTeStLqHCteQu/IY8S61aHPX624rzL1szJAsdlQzRAS0k3tVTC76pJaZSe3LYn/sVxjoTu5mkogFfh3eJU//norsMRzL26wM7QmMm4n4t8/JMUY0i+Xfy27PFD67GUILNlAID77U18C+lASmc9NGootFLdpFvhmimMEanfjCkW++9mIQLDacn1sdL+uUSBo/PLtaEfxyvAgzmrG+FzJUISX9d6ubNiLsxj1pnGGcaSd6fycCP7TEmHMI52nn3/p/GLT4qcYUMhdtNEPOV8yBGJvek508FSLybPqHTQA9UDkzFB+Oq0G49It/u8xiuxyi56gw5Udk4kiDaXI9XdlXhYro8xCU17pcnt8IJ4d/IakQB2X7flV1W5JeWk/wP798Pun2lIEhU3h4n52gmaHz8XDOEx7NZhj/JdnUw+EMUQYgO1sA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60453a73-3cca-4d7d-6145-08d8558659ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 12:37:59.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UMv7rimykylrIYrzwrs+q4AWCE3oUp3pBd0lJbO2TIRnxc3/OOsXVS9pCtfFJtb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599741470; bh=L77Mt/sfieXghb+zfjc5nDyQkSqzqHqUWIODvssr4ls=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=g3kE/kLQ5acHFNYIOtDlG7Z6P4wH8QzI1rBx5Z/yu6PWpUzMkKP3IymcGApc8J/38
         us0BQQVR8ui+kfDNW2MBbb5MT9O0MlYN3jrejgymb8n6jtzxrTErDFQrxsZ836n7GJ
         8QMzY5xZoH3YdMQe8U4pBCnw4gZ8Ws23KyWnx4L/+0Q5os08JaE67lmorffR13H6j/
         Grp2QtXNTUA+GIAiwqEjADOqcD00qx+YT6UI+Z92sO8ieEamT/lpKddqdUacCHrJwL
         AM8PjLIO820bd+Ab8oV8pwfTECslktyIrh7R5flJUNgsHT6yI5WpW4R0kkuFAfI8T7
         YdSGzAuBYlc0Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 10:46:00AM +0100, Lorenzo Pieralisi wrote:
> [+Jason]
> 
> On Tue, Sep 08, 2020 at 09:33:42AM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2020-09-03 at 12:08 +0100, Lorenzo Pieralisi wrote:
> > > > It's been what other architectures have been doing for mroe than a
> > > > decade without significant issues... I don't think you should worry
> > > > too
> > > > much about this.
> > > 
> > > Minus what I wrote above, I agree with you. I'd still be able to
> > > understand what this patch changes in the mellanox driver HW
> > > handling though - not sure what they expect from
> > > arch_can_pci_mmap_wc()
> > > returning 1.
> > 
> > I don't know enough to get into the finer details but looking a bit it
> > seems when this is set, they allow extra ioctls to create buffers
> > mapped with pgprot_writecombine().
> > 
> > I suppose this means faster MMIO backet buffers for small packets (ie,
> > non-DMA use case).
> > 
> > Also note that mlx5_ib_test_wc() only uses arch_can_pci_mmap_wc() for a
> > non-ROCE ethernet port on a PF... For anyting else, it just seems to
> > actually try to do it and see what happens :-)
> > 
> > Leon: Can you clarify the use of arch_can_pci_mmap_wc() in mlx5 and
> > whether you see an issue with enabling this on arm64 ?
> 
> Hi Jason,
> 
> I was wondering if you could help us with this question, we are trying
> to understand what enabling arch_can_pci_mmap_wc() on arm64 would cause
> in mellanox drivers wrt mappings and whether there is an expected
> behaviour behind them, in particular whether there is an implicit
> reliance on x86 write-combine arch/interconnect details.

Looking back at this big thread, let me add some perspective

Mellanox drivers have a performance optimization where a 64 byte MemWr
TLP from the root complex to the MMIO BAR will perform better, often
quite a bit better. We run WC in full QA'd production on PPC, ARM and
x86.

The userspace generates a burst of sequential, aligned 8 byte CPU
writes to the MMIO address and triggers an arch specific CPU barrier
to flush/fence the CPU WC buffer. At this point the CPU should emit
the 64 byte TLP toward the device ASAP.

In other words, the only usage here is only about Write. The CPU
should never, ever, generate a MemRD TLP. The code never does a read
explicitly.

If the CPU fails to generate a 64 byte TLP then the device will still
operate correctly but does a different, slower, flow.

If the CPU consistently fails WC then the overhead of trying the WC
flow is a notable net performance loss, and on these CPUs we want to
use only 8 byte write to the MMIO BAR, with NC memory.

There are many important details about how this works and how this
must interact with the CPU barriers and locking.

On x86, arch_can_pci_mmap_wc() is basically meaningless. It indicates
there is a chance that pgprot_writecombine() could work. It can also
be 0 and write combining will work just fine :\.

Thus, mlx5 switched to doing a runtime WC test to determine if the CPU
actually supports WC or not. If the arch can reliably tell the driver
then this test could be avoided. Based on this test the WC mode is
allowed for userspace.

The one call to arch_can_pci_mmap_wc() is in a case where the HW is
configured in a way that can't run the test, here we use
arch_can_pci_mmap_wc() to guess if the CPU has working WC or not.
Ideally an arch would return 1 only when the CPU has working WC.

Depending on workload WC may not be a win. In those cases userspace
will select NC. Thus the same PCI MMIO BAR region can have a mixture
of pages with WC and NC mappings to userspace.

For DEVICE_GRE.. For years now, many deployments of ARM & mlx5 devices
are using an out of tree patch to use DEVICE_GRE for WC on mlx5. This
seems to be the preferred working configuration on at least some ARM
SOCs. So far nobody from the ARM world has shown interest in making a
mainline solution. :(

I can't recall if this is because the relevant ARM SOC's don't support
pgprot_writecombine(), or it doesn't work properly.

I was told the reason ARM never enabled WC was because unaligned
access to WC memory was not supported, and there were existing drivers
that did unaligned writes that would malfunction. I thought this meant
that pgprot_writecombine() was non-working in ARM Linux? So, bit
surprised to see a patch messing with arch_can_pci_mmap_wc() and not
changing the defintion of pgprot_writecombine() ?

mlx5 is more or less a representative user WC for this kind of
'message push' methodology. Several other RDMA devices do this as
well. The methodology is important enough that recent Intel CPUs have
a dedicated instruction to push a 128 byte message in a single TLP
avoiding this whole WC mess.

Frankly, I think the kernel should introduce a well defined pgprot for
this working mode that all archs can agree upon. It should include the
alignment requirement, message push function, CPU barrier macros, and
locking macros that are needed to use this facility correctly.

Defined in a way that is compatible with DEVICE_GRE and can be used by
these 'message push' drivers. That would switch alway most of the
users in the kernel today.

Jason
