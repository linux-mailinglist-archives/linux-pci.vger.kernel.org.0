Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584F8264F9A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIJTrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 15:47:08 -0400
Received: from foss.arm.com ([217.140.110.172]:38516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbgIJPZZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 11:25:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2780113E;
        Thu, 10 Sep 2020 08:17:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD01D3F68F;
        Thu, 10 Sep 2020 08:17:26 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:17:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Clint Sbisa <csbisa@amazon.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200910151721.GA25809@e121166-lin.cambridge.arm.com>
References: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
 <20200902113207.GA27676@e121166-lin.cambridge.arm.com>
 <20200902142922.xc4x6m33unkzewuh@amazon.com>
 <20200902164702.GA30611@e121166-lin.cambridge.arm.com>
 <edae1eeb0da578d941cfa5ad550eb0a0eda5f98e.camel@kernel.crashing.org>
 <20200903110844.GB11284@e121166-lin.cambridge.arm.com>
 <28d333afc73bd854390f8c39691a735040ba5b39.camel@kernel.crashing.org>
 <20200910094600.GA22840@e121166-lin.cambridge.arm.com>
 <20200910123758.GC904879@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910123758.GC904879@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 09:37:58AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 10:46:00AM +0100, Lorenzo Pieralisi wrote:
> > [+Jason]
> > 
> > On Tue, Sep 08, 2020 at 09:33:42AM +1000, Benjamin Herrenschmidt wrote:
> > > On Thu, 2020-09-03 at 12:08 +0100, Lorenzo Pieralisi wrote:
> > > > > It's been what other architectures have been doing for mroe than a
> > > > > decade without significant issues... I don't think you should worry
> > > > > too
> > > > > much about this.
> > > > 
> > > > Minus what I wrote above, I agree with you. I'd still be able to
> > > > understand what this patch changes in the mellanox driver HW
> > > > handling though - not sure what they expect from
> > > > arch_can_pci_mmap_wc()
> > > > returning 1.
> > > 
> > > I don't know enough to get into the finer details but looking a bit it
> > > seems when this is set, they allow extra ioctls to create buffers
> > > mapped with pgprot_writecombine().
> > > 
> > > I suppose this means faster MMIO backet buffers for small packets (ie,
> > > non-DMA use case).
> > > 
> > > Also note that mlx5_ib_test_wc() only uses arch_can_pci_mmap_wc() for a
> > > non-ROCE ethernet port on a PF... For anyting else, it just seems to
> > > actually try to do it and see what happens :-)
> > > 
> > > Leon: Can you clarify the use of arch_can_pci_mmap_wc() in mlx5 and
> > > whether you see an issue with enabling this on arm64 ?
> > 
> > Hi Jason,
> > 
> > I was wondering if you could help us with this question, we are trying
> > to understand what enabling arch_can_pci_mmap_wc() on arm64 would cause
> > in mellanox drivers wrt mappings and whether there is an expected
> > behaviour behind them, in particular whether there is an implicit
> > reliance on x86 write-combine arch/interconnect details.
> 
> Looking back at this big thread, let me add some perspective

Thank you - it was needed.

> Mellanox drivers have a performance optimization where a 64 byte MemWr
> TLP from the root complex to the MMIO BAR will perform better, often
> quite a bit better. We run WC in full QA'd production on PPC, ARM and
> x86.
> 
> The userspace generates a burst of sequential, aligned 8 byte CPU
> writes to the MMIO address and triggers an arch specific CPU barrier
> to flush/fence the CPU WC buffer. At this point the CPU should emit
> the 64 byte TLP toward the device ASAP.

While at it - mind explaining please what those 64 bytes actully contain ?

> In other words, the only usage here is only about Write. The CPU
> should never, ever, generate a MemRD TLP. The code never does a read
> explicitly.

On arm64 pgprot_writecombine() is speculative memory (normal
non-cacheable), which may not do what you expect from it.

> If the CPU fails to generate a 64 byte TLP then the device will still
> operate correctly but does a different, slower, flow.

Side note: on ARM that TLP is not a native interconnect transaction,
reworded, it depends on what the system-bus->PCI logic does in
this respect.

> If the CPU consistently fails WC then the overhead of trying the WC
> flow is a notable net performance loss, and on these CPUs we want to
> use only 8 byte write to the MMIO BAR, with NC memory.

That's why I looped you in - that's what worries me about "enabling"
arch_can_pci_mmap_wc() on arm64. If we enable it and we have perf
regressions that's not OK.

Or we *can* enable arch_can_pci_mmap_wc() but force the mellanox
driver (or more broadly all drivers following this message push
semantics) to use "something else" for WC detection.

> There are many important details about how this works and how this
> must interact with the CPU barriers and locking.
> 
> On x86, arch_can_pci_mmap_wc() is basically meaningless.

On arm64 too, for the records - or better, write-combine is not
well defined, ergo I don't know what arch_can_pci_mmap_wc() means.

> It indicates there is a chance that pgprot_writecombine() could work.
> It can also be 0 and write combining will work just fine :\.
> 
> Thus, mlx5 switched to doing a runtime WC test to determine if the CPU
> actually supports WC or not. If the arch can reliably tell the driver
> then this test could be avoided. Based on this test the WC mode is
> allowed for userspace.

Can you elaborate on this runtime test please ?

> The one call to arch_can_pci_mmap_wc() is in a case where the HW is
> configured in a way that can't run the test, here we use
> arch_can_pci_mmap_wc() to guess if the CPU has working WC or not.
> Ideally an arch would return 1 only when the CPU has working WC.

Which means we can guarantee the TLP packet you mentioned above I
guess ?

We have to define "working WC" :)

> Depending on workload WC may not be a win. In those cases userspace
> will select NC. Thus the same PCI MMIO BAR region can have a mixture
> of pages with WC and NC mappings to userspace.
> 
> For DEVICE_GRE.. For years now, many deployments of ARM & mlx5 devices
> are using an out of tree patch to use DEVICE_GRE for WC on mlx5. This
> seems to be the preferred working configuration on at least some ARM
> SOCs. So far nobody from the ARM world has shown interest in making a
> mainline solution. :(
> 
> I can't recall if this is because the relevant ARM SOC's don't support
> pgprot_writecombine(), or it doesn't work properly.
> 
> I was told the reason ARM never enabled WC was because unaligned

When you say "enabled WC" I assume you mean making:

pgprot_writecombine() == DEVICE_GRE

> access to WC memory was not supported, and there were existing drivers
> that did unaligned writes that would malfunction. I thought this meant
> that pgprot_writecombine() was non-working in ARM Linux?

On arm64 pgprot_writecombine() is normal non-cacheable memory at the
moment - it works but that does not precisely do what you *expect* from
arch_can_pci_mmap_wc(), that's the whole point I am making.

> So, bit surprised to see a patch messing with arch_can_pci_mmap_wc()
> and not changing the defintion of pgprot_writecombine() ?

We can't change pgprot_writecombine() to DEVICE_GRE, it can trigger
issues on some drivers, see unaligned memory access.

> mlx5 is more or less a representative user WC for this kind of
> 'message push' methodology. Several other RDMA devices do this as
> well. The methodology is important enough that recent Intel CPUs have
> a dedicated instruction to push a 128 byte message in a single TLP
> avoiding this whole WC mess.
> 
> Frankly, I think the kernel should introduce a well defined pgprot for
> this working mode that all archs can agree upon. It should include the
> alignment requirement, message push function, CPU barrier macros, and
> locking macros that are needed to use this facility correctly.
> 
> Defined in a way that is compatible with DEVICE_GRE and can be used by
> these 'message push' drivers. That would switch alway most of the
> users in the kernel today.

That's probably the way forward - I still have concerns about this
patch as it stands given your clarifications above.

Lorenzo
