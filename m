Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE615F2BD7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 10:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiJCIcI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 04:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJCIbo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 04:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F16205EB;
        Mon,  3 Oct 2022 01:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A31160F9A;
        Mon,  3 Oct 2022 08:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F359C433D6;
        Mon,  3 Oct 2022 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664784251;
        bh=QH8MdKcgOw8BSv4jKq28Wcit6TCxETXOMp8VbJCm+r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGX/I78bPMcmU9tvCddRJJZO/ZQbX7+a4ViZk7JD8j+mYN7Bv/uMa71eqL53qWc74
         pExlM9sDRLfySUxV1ecPuvUo3iGIj5NIfNs6FN+mO7hobex0XWrowXAGYRZ6qzQcqR
         7llJ/n3kPpdI/iXmxF9DuiRuzmymAVf881OMJsmRS4Y0KcMIgaarBjgfxKNwUO9gbZ
         KtvqMpyqaEHndrQa1e3yyD48MV/uc+j1zC7pun89zt1zEIra5yvNHPUA6YraDY4A8t
         O4k6AGmV1RfCP8njxqH0XF6uz4ecsWilCgjiBKI9xzZ/xIvnK+32wuevfuCC4TkEoR
         2wF+WuHxmcpsA==
Date:   Mon, 3 Oct 2022 10:04:04 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     William McVicker <willmcvicker@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>
Subject: Re: [PATCH v5 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
Message-ID: <YzqXdBFMNvhZMMCN@lpieralisi>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-2-willmcvicker@google.com>
 <20220928114136.4yvtfnrcril3jkgg@mobilestation>
 <4dc31a63-00b1-f379-c5ac-7dc9425937f4@arm.com>
 <20220929193241.pdjj5ifm7vgpff42@mobilestation>
 <6b919ea9-2f87-65ca-8286-5b4baa6e1c3c@arm.com>
 <20220930125736.rovbmgilxv3bzvzc@mobilestation>
 <26a0d62a-feec-652a-05b0-16731d55e085@arm.com>
 <YzchHuCI9sH8dQ7Y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzchHuCI9sH8dQ7Y@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 30, 2022 at 10:02:22AM -0700, William McVicker wrote:

[...]

> > > So now we have what we have. The DMA-mask is pointlessly changed for
> > > something not really implying any DMA. That's why I insisted on
> > > dropping it at the very least. Another reason I thought was also
> > > appropriate was the default DMA-mask being set to 32bits anyway.
> > > But you said we shouldn't rely on the default DMA-mask setting. So
> > > ok, it doesn't count then. But it doesn't change the uselessness of the
> > > DMA-mask change in the current driver.
> > 
> > As I keep saying, it *is* relevant to DMA. The MSI doorbell may not be
> > accessing memory, but it is still a thing that occupies DMA address space
> > like a mapping of memory does, and DMA masks are how we control how DMA
> > address space is allocated. Unless and until we have an API for arbitrarily
> > reserving DMA address space within a given range, the approach used here and
> > in other drivers is the next best thing, however much you don't like it.
> > 
> > > > AFAIU the correct PCI device
> > > > won't actually exist until we've got far enough through pci_host_probe(), so
> > > > I'm not sure how to easily solve this :/
> > > 
> > > Walk over all PCIe devices detected on the PCIe-bus. Check their
> > > MSI-capability flags. If any of them have no 64-bit MSI flag set, then
> > > make sure the MSI-base address is allocated within 4GB memory region.
> > > It isn't that easy to implement though...
> > 
> > It has nothing to do with capabilities (but also: consider hotplug). We
> > simply need the host bridge PCI device to pass to the DMA API to ensure that
> > the mapping/allocation is relative to PCI Mem space rather than system
> > physical address space, because the two don't have to be identical. The
> > challenge is how to reliably pick up that device and set up the doorbell
> > *before* any other PCI devices also discovered by pci_host_probe() have a
> > chance to start binding drivers and trying to request MSIs.
> 
> Maybe I can provide some more insights on my patches that may help you guys
> understand the idea behind the MSI capabilities flag. Basically, on a given
> Android phone there are going to be multiple PCIe endpoints -- wifi and modem
> are good examples. Some of these PCIe endpoints may only support a 32-bit MSI
> capability structure, but others could support a 64-bit MSI capability
> structure. So my intent was to have the PCIe RC driver detect the endpoint
> device's MSI capabilites during the EP device probe and then set the
> PCI_MSI_FLAGS_64BIT accordingly before calling dw_pcie_host_init(). Since the
> PCIe RC drivers are the ones to call dw_pcie_host_init(), we can dynamically
> change the DMA mask and allocate the doorbell target address based on the
> PCI_MSI_FLAGS_64BIT.

It seems to me we are all talking past each others to solve different
problems, so I am going to reset this discussion given that we are
in the merge window and I must finalise the PCI patch queue.

Patch (2/2) should be dropped IMO - I don't think the host bridge
platform device DMA mask should depend on the root port MSI cap
64/32 bit addressing - I don't think that's the right thing to do.

We should keep this discussion going for the next cycle, I will
drop patch (2/2) for the time being, sorry.

Thanks,
Lorenzo

> This all really gets a lot more complicated with the introduction of Serge's
> eDMA device. So I full well expect dw_pcie_msi_host_init() to be re-factored
> for that.
> 
> > 
> > > > Of course *this* patch doesn't change any of that either, so it's no worse
> > > > than the existing code and I don't see that dropping it helps you at all;
> > > > the current driver is already trampling your 64-bit mask back to 32 bits
> > > 
> > > Yes, and by this pathset @William intend to fix the DMA-mask-override
> > > behaviour by using the dma_alloc_coherent() method.
> > 
> > No, that is effectively unchanged. Whether it's a streaming mapping with
> > dma_mask or a coherent allocation with coherent_dma_mask, masks are getting
> > set way, it's the fact that it's on the wrong device that's the real
> > problem.
> > 
> > If you expose the eDMA as a generic dmaengine device then there's every
> > chance some consumer would make a streaming mapping with it, so even though
> > the current code happens to not override the coherent mask it's still biting
> > you in the streaming mask.
> > 
> > > So any
> > > platform-specific DMA-mask setting will be overwritten, and the
> > > DMA-mask setting won't be able to be moved/dropped due to the
> > > dma_alloc_coherent() method usage.
> > > 
> > > I have added a DW eDMA-engine support to the DW PCIe driver (you've
> > > already seen my patches) and the engine initialization is supposed to
> > > be performed after any basic initializations like CSRs mapping, data
> > > allocations, MSI, etc. Since DMA is performed by the controller itself
> > > it's required to have a correct DMA-mask set to the DW PCIe platform
> > > device otherwise any consequent mapping will be bounce buffered to the
> > > lowest 4GB even though the corresponding platform can support more
> > > than 4GB of memory (even our MIPS32 can) with DW eDMA easily reaching
> > > that memory. What would help me in this case if the MSI-buffer
> > > allocation procedure wouldn't change the device DMA-mask.  As an
> > > alternative to completely dropping the DMA-mask setting, the DMA-mask
> > > setup process could be moved to the low-level platform device drivers.
> > > It would be even more justified since the platform-specific device
> > > capabilities (like DW PCIe AXI-interface address-bus width) are
> > > unknown in the generic code.
> > > 
> > > As another alternative I could override the DMA-mask within the DW
> > > eDMA probe procedure. But that would make things more complicated than
> > > relying on the low-level platform drivers doing that.
> > > 
> > > > and
> > > > reserving the doorbell address in the wrong DMA address space (modulo the
> > > > other dma-ranges bug which also took far too long to figure out).
> > > 
> > > Actually current driver (without William patch) reserve the doorbell
> > > address in the correct DMA address space (if we don't take the
> > > dma-ranges settings into account).
> > 
> > No it does not. With or without this patch it is still passing the *platform
> > device* to the DMA API, which means the mapping is relative to the platform
> > address space, not PCI Mem space on the other side of the iATU. The fact
> > that the iATU's dma-ranges translation is erroneously applied to the
> > platform device at the moment is, as I have said, a bug.
> 
> Thanks for pointing this out. I agree this is a bug and I guess it hasn't
> really been a problem because there isn't really any DMA'ing going on. With the
> new eDMA device being introduced, this bug will likely need to be fixed.
> 
> > 
> > > It works as expected in case if the
> > > PCIe<->CPU space has one-on-one mapping (which is true in the most of
> > > the cases). The only thing which is wrong is the pointless DMA-mask
> > > update. I could have easily dropped it in my patchset. But after the
> > > @William patchset is applied I won't be able to do that due to using
> > > the dma_alloc_coherent() here.
> > 
> > Once again, it is not pointless. There is no guarantee that __GFP_DMA32 does
> > anything, since ZONE_DMA32 may not exist (per this patch), and the zones may
> > not be as expected anyway (look at what arm64 currently does if all RAM is
> > above 32 bits, but save those complaints for another thread).
> > 
> > > > At this
> > > > point I'd rather keep it since getting rid of the __GFP_DMA32 abuse is
> > > > objectively good. If losing one page of coherent memory is a measurably
> > > > significant problem for T1 once the other issues are worked out and that
> > > > series lands, then you're welcome to propose a change on top (but I would
> > > > prefer that all the drivers using this trick are changed consistently).
> > > 
> > > Regarding DMA-coherent allocation. I am not happy with losing a whole
> > > page of the dma-coherent memory, but we can live with that. What give
> > > additional difficulty for our eDMA-patches is the DMA-mask override.
> > > If you still insist on preserving the @William patchset as it is,
> > > where do you suggest for me to update the DMA-mask if the low-level
> > > driver won't be suitable for that anymore?
> > 
> > I'm not insisting anything, it's just that this patch is already reviewed
> > and queued, is a small step towards being less wrong overall, and dropping
> > it wouldn't actually solve any of your problems anyway, so I just feel that
> > being obstructive because it falls short of perfection isn't helpful.
> 
> Thanks for the responses Robin! I agree that we don't have a complete solution
> and need to fix this DMA address space bug, but dont think that's enough of
> a reason to drop this patch series. At the very least I think patch 1/2 which
> removes the ZONE_DMA32 dependency is a worthy patch to take for 6.1.
> 
> Thanks,
> Will
> 
> > 
> > Robin.
