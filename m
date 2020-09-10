Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92091264AC3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIJRLn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 13:11:43 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:54764 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgIJRKt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 13:10:49 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5a5e100000>; Fri, 11 Sep 2020 01:10:40 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 10:10:40 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 10 Sep 2020 10:10:40 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 17:10:36 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Sep 2020 17:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SowFqvUxNFFvCR61ZdIcT6Evs3kUj4tMN9U2gKi+CVOlzvxrhmi1rZu+ASnRjReKVp2GReD6sZaN8n6SBC+hEMf8s/KOoiSW9Vv/mtu/eCXf2Ei/A2zV0h30Pikhh+Be3BjXDyk2nZHceyGuQY1BkpQHLT7Z8zkgHMESx6Ff4Ps0PUlnnjWofj0JpaK44FsS8sPkM9pS1yn2uTmrZlT/en0/1+Pt/KseslxopBNRywr/OLitl3K6My0SKtOfbTf5kDmAm+VPZLEpfzYRrqdBtHbRlxcJCEFgdWFaiMzwiy5gSAtWB4zK7rnsigp6HJJ3hr/xaHbggnROVJdJgPGJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ceBXleZkH/OjQPdmtFfNaxRwgV+UQ1n5Ym2H0siSk4=;
 b=Ino+mKQM2E95b7XaEjlWQHy2HbRpu15/2eY96s0/d2WEd2Ihz/fhpMLVyGOpTF3gjUdLdwwz8yfVLPOAiymjZLDTi6QEDro4Fwmbx42iAyY/RiItTnSR4y3TV2i6qqs+sFEjvjji0t8PCrupTPAcsEh+ET2rGsirNE1CCsSy1mYYfFZHKSdnlDz39jtj3VO3fLl2gs0y+GBi4B2MIlrH26iJg1S/qeco/+M7QQep475jb7tXbpJC9PgJNJepOZg6nmRlwnpgSO2CZGDz2mfZIb8ZLmkY+y0BxJBU8RQU+HcxQFPWsAZBzA4JW1km3sWVUfL27BRFXpS+X1Mq2kr0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 17:10:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 17:10:34 +0000
Date:   Thu, 10 Sep 2020 14:10:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200910171033.GG904879@nvidia.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
 <20200910123758.GC904879@nvidia.com>
 <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
X-ClientProxiedBy: BL0PR0102CA0060.prod.exchangelabs.com
 (2603:10b6:208:25::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0060.prod.exchangelabs.com (2603:10b6:208:25::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 17:10:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGQ5h-004Ngz-5f; Thu, 10 Sep 2020 14:10:33 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f070e080-c219-4171-b221-08d855ac6e1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-Microsoft-Antispam-PRVS: <DM6PR12MB448373299B3AA2EB8F5200D0C2270@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PaBRI9mWXr763xz8rNT0WmOtddHRve5PGggENpf/fsbq5xNCOiY3OvX4Kh87NOlXeoNJJ8zwYiaoPriD5V+HVCOFF9j9cNjyS67l1pi8+VWTQY7w5gfdlZJVJCnlXFjWo7sFIH4xO2gaXBbN01RS62cEE8OWo4/IVim+sKgbfmCvBvoimz6bTLjxGRmwXMs+RCek1oyPwWmt+ES89fNn13r/Q3yBYgzpDAJqrFLGduQ5z6R7nvQvk6pO0lZbU+61XAX6Lqr8jvqTbLNmX2HKaMMvGqxLC7PYDpTL88rJDlIxPEfNzW1tEr7nKCaLFWlajV8erkPfuzNsEJJyRSTk7M5avJ+N2u9b7NOjAxNDr5s0ZdviEL8U2SRrGKgIWPDh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(8936002)(2906002)(66476007)(66946007)(66556008)(9746002)(9786002)(5660300002)(36756003)(86362001)(1076003)(26005)(8676002)(2616005)(186003)(426003)(316002)(4326008)(54906003)(478600001)(83380400001)(33656002)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W8xKygmYJ+xb+LD87lhlpZW/KOogDq0oqLdDRWhVZdoaGx/OYJ/WX7uST711a4WOwPW9xVSH6Y+5QsVXTeqs6dfnmg0ngmBNSVCBB4Vr15/edRhFSZzRxBmq01ZDnDG+uZD42zMkejlaDseZpEHw3FglpZ3BInW7N6vXNP9O4ghuJE0yUV+eMmG33vp69wLmvnd/XtcwVdX6F8pYaBEC5k87CodkBlonj/Wf2TLloXC2ndjuQIoP4bhLxIzlaShPMU65HivP56KSmhs7DsbzqQwu6yen86pV6EDMbSu2darGueuvaLLrPlQfRyBHhGuaHk3BUZCaCcq2rM+6DqsrZbh0eFQ6L8FM7golxT6qgjyaYbR9/ZxRk8yO3Q8swCUgXB+qOzTmZY1BCVQiBHXiXBeAVpxElqNHZ8qAPt11FjvcHsr6zf0cj9hZXlykOmDNa5/PytLJ62lzkXrhRJS2L9ddn4udC2ziR1yOosBXlL4bDdLBVKOJqtyDbn5MHWpyg/DdqA9z3uq9uva3BYVjuGeQdX2EOHg76rRU6ukgCOhb9xsjDoMFy2UMoAECYtyIzvceUzHJPRPYzQLRk92FPktmJty2CtP/Ibsb6KWNh2BsOaMuLaVVDsqvJIKsf/Dk1oY9jtm/JBICYKOSJCFzpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f070e080-c219-4171-b221-08d855ac6e1c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 17:10:34.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8edn71o5IfRGFtbTrBFP0ggXHNqGXCV3nEryBhRd7c40zOgtJbwV8SSxA0jZ0Qd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599757840; bh=1ceBXleZkH/OjQPdmtFfNaxRwgV+UQ1n5Ym2H0siSk4=;
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
        b=bwDzSHb7RwTVehEqwKEfMyl9dmMtrKDOYVQoSX6lTvvJHe94sBEfDgA5VF0QGloEl
         mFCPqlMcsyFQo+CX2EGOFfPmSlN2zNGSFMnWZT0RnWCoji+aJH34ETifjVnjWzhK00
         dkBl/kU5+ywbyuvGA48C/ZqVgvOpq8+i0Ac/weXQNE7Hgg6zUgGza7kjCgs8beDKn7
         d9ptMtyV+44tH+TDLTewKohelj0chbCb0gFe/pEnSoJvOn/rIcwKc63o8XhernLAmR
         sSAwsel1sHbZceMskznAtjKb13fVYq/ra9jI9q9ks7IDDFJ7EHlHMkTb2nYu/e8e3u
         JOSlOXAIGfg9w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 04:17:21PM +0100, Lorenzo Pieralisi wrote:

> > In other words, the only usage here is only about Write. The CPU
> > should never, ever, generate a MemRD TLP. The code never does a read
> > explicitly.
> 
> On arm64 pgprot_writecombine() is speculative memory (normal
> non-cacheable), which may not do what you expect from it.

Can you explain what this actually does on ARM? 

Can it ever speculate loads across page boundaries, or speculate loads
that never exist in the program? ie will we get random unpredicable
MemRds?

Does it/could it "combine writes"?

> > If the CPU fails to generate a 64 byte TLP then the device will still
> > operate correctly but does a different, slower, flow.
> 
> Side note: on ARM that TLP is not a native interconnect transaction,
> reworded, it depends on what the system-bus->PCI logic does in
> this respect.

I think the issue is that ARM never defined what the bits set by
pgprot_writecombine() do at a system level so we see implementations
that do not cause write combining at the PCI-E interface for those
bits. (I assume from what I've heard)

> That's why I looped you in - that's what worries me about "enabling"
> arch_can_pci_mmap_wc() on arm64. If we enable it and we have perf
> regressions that's not OK.
> 
> Or we *can* enable arch_can_pci_mmap_wc() but force the mellanox
> driver (or more broadly all drivers following this message push
> semantics) to use "something else" for WC detection.

arch_can_pci_mmap_wc() really only controls the sysfs resource file
and it seems very unclear who in userspace uses that these days.

vfio is now the right way to do that stuff. I don't see an obvious way
to get WC memory in VFIO though...

So, I don't think this patch will break anything, however I also don't
see a point to it as nobody should be using the sys/resource files
these days.. Curios why Clint proposed it?

> > Thus, mlx5 switched to doing a runtime WC test to determine if the CPU
> > actually supports WC or not. If the arch can reliably tell the driver
> > then this test could be avoided. Based on this test the WC mode is
> > allowed for userspace.
> 
> Can you elaborate on this runtime test please ?

mlx5 is a network device, so the purpose of the 64 byte TLP is to
push, say, a network send command to the device fully formed (eg with
the DMA list, etc). Otherwise we can only push an indication to read
the 64 byte command via DMA from the command ring. 

Avoiding the extra DMA is a performance win.

The runtime test pushes a 64 byte command to the device. If it arrives
as a single TLP then the device executes that command, otherwise it
triggers DMA and reads the 64 bytes from host memory. The test
arranges that the command pushed via the TLP and the command fetched
via DMA are different. The test can then determine which path the
device took and thus know directly if the implementation can deliver
the required TLP or not.

> > configured in a way that can't run the test, here we use
> > arch_can_pci_mmap_wc() to guess if the CPU has working WC or not.
> > Ideally an arch would return 1 only when the CPU has working WC.
> 
> Which means we can guarantee the TLP packet you mentioned above I
> guess ?

Yes. For a PCI driver I think this is the only thing that matters for
"write combining". mlx5 is pretty strict, other drivers might gain
advantage from smaller or more fragmented transfers, eg 32 byte chunks
or something.

> > Depending on workload WC may not be a win. In those cases userspace
> > will select NC. Thus the same PCI MMIO BAR region can have a mixture
> > of pages with WC and NC mappings to userspace.
> > 
> > For DEVICE_GRE.. For years now, many deployments of ARM & mlx5 devices
> > are using an out of tree patch to use DEVICE_GRE for WC on mlx5. This
> > seems to be the preferred working configuration on at least some ARM
> > SOCs. So far nobody from the ARM world has shown interest in making a
> > mainline solution. :(
> > 
> > I can't recall if this is because the relevant ARM SOC's don't support
> > pgprot_writecombine(), or it doesn't work properly.
> > 
> > I was told the reason ARM never enabled WC was because unaligned
> 
> When you say "enabled WC" I assume you mean making:
> 
> pgprot_writecombine() == DEVICE_GRE

Well, when I say "enabled WC" I mean it seems existing
pgprot_writecombine() does not give write combining at PCI-E and the
option that does give write combining is DEVICE_GRE, that has the
alignment problem and can't be used.

At least on some SOCs.

> > access to WC memory was not supported, and there were existing drivers
> > that did unaligned writes that would malfunction. I thought this meant
> > that pgprot_writecombine() was non-working in ARM Linux?
> 
> On arm64 pgprot_writecombine() is normal non-cacheable memory at the
> moment - it works but that does not precisely do what you *expect* from
> arch_can_pci_mmap_wc(), that's the whole point I am making.

Most places use pgprot_writecombine() blindly and just ignore
arch_can_pci_mmap_wc() - I suppose with the idea that
pgprot_writecombine() will be a harmless NOP if it isn't supported?

mlx5 is possibly the only place where someone actually tested and
cared about the performance difference between using a WC specific
algorithm or not.

> > mlx5 is more or less a representative user WC for this kind of
> > 'message push' methodology. Several other RDMA devices do this as
> > well. The methodology is important enough that recent Intel CPUs have
> > a dedicated instruction to push a 128 byte message in a single TLP
> > avoiding this whole WC mess.
> > 
> > Frankly, I think the kernel should introduce a well defined pgprot for
> > this working mode that all archs can agree upon. It should include the
> > alignment requirement, message push function, CPU barrier macros, and
> > locking macros that are needed to use this facility correctly.
> > 
> > Defined in a way that is compatible with DEVICE_GRE and can be used by
> > these 'message push' drivers. That would switch alway most of the
> > users in the kernel today.
> 
> That's probably the way forward - I still have concerns about this
> patch as it stands given your clarifications above.

I would very much like to see some support for DEVICE_GRE (at least on
the SOCs that require it) in ARM going forward. For whatever reason
this seems to be necessary to get write PCI combining behavior on
enough ARM hardware that it should be supported in the upstream
kernel.

Jason
