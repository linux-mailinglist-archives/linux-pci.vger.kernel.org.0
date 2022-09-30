Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AE05F1064
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiI3RCa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 13:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiI3RC3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 13:02:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2A1D8F0B
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 10:02:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d82so4748749pfd.10
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2022 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sqqVlwZPAs+TFeTfyNyzYm+lQPyEeaCR69C2Vijqv10=;
        b=fCVYWtDmrhvlxhAI5v17N9vsh8WP5y+V8WOvE/tPNWk8N9yPD1iUV6TvfUaPyBgqz2
         t8di9rXi4ZgpELUU4OW7MZEXFYy4QGvZUmuGr9HjP0zuGpOlKQXAn8zjrtj8zm00gMA4
         r9oU8GuPzu7QqETVB4k2RUMYx74oqbjFyzaVdZSJj+mIIFUWL059LI/kMUFzEEjGAQcv
         wXeY6Ir/eyWPZc3+oDYqBpAYBzPzrM1s9oXCxbsC5SuiSU7jBhadcqfpA8bgv5omQ0CK
         drmDd96xjEeXmbRwuHaSyQU/yV7DtMNKRFFcG5pQWavOuhL/9Arac4hBr/CdKaDIE2E+
         qPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sqqVlwZPAs+TFeTfyNyzYm+lQPyEeaCR69C2Vijqv10=;
        b=zn7Q7AtcQNVT4sXAVLmUx3ePqtmHoqHsTa+ykncB+RpEwJ58Zoona+K5NEwe7YfT4t
         6adU11dTrIux1/VhU5xy/9+rD4mPCiRAwcQ0X/jzQwJnJOKsIGUiohhEnHZF9+sL3gL+
         nzyQpRgSLSEfDni07wzBGMUQfw+tqkK9pgO65QYIRt2nV3BYoIcEcjY1Sfkna4y9OXp6
         wQ7E8AUJmtH4BL7m/RcCyvHOaMtznETSnXvM2HiceVVm42Y1uSV7i1/qjNsB8/of9EFK
         8x3NCRn6rL+ZrlAQUuKgDyxtgPWhrSvwvR7E7O47IQJgjsgXWmavZT8zx6rU9OBWYyOg
         Dqow==
X-Gm-Message-State: ACrzQf1vWIv0IBvv2sO3iHvpl6Z8zeDdpniZbwEh5f3LgHkGi3mmMDvs
        xhBoscB6hPQK8xISBT5nbrLcZQ==
X-Google-Smtp-Source: AMsMyM5IL2UxetmVfpMMd7rQ/uz+5yJM86ANVsSV+9t4cuV+iuDiZchUoPgwLY4hd8QQJ2bCrd9v+w==
X-Received: by 2002:a63:5164:0:b0:43b:e57c:a15f with SMTP id r36-20020a635164000000b0043be57ca15fmr8265478pgl.586.1664557346934;
        Fri, 30 Sep 2022 10:02:26 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902714b00b00176a47e5840sm2112162plm.298.2022.09.30.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:02:26 -0700 (PDT)
Date:   Fri, 30 Sep 2022 10:02:22 -0700
From:   William McVicker <willmcvicker@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>
Subject: Re: [PATCH v5 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
Message-ID: <YzchHuCI9sH8dQ7Y@google.com>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-2-willmcvicker@google.com>
 <20220928114136.4yvtfnrcril3jkgg@mobilestation>
 <4dc31a63-00b1-f379-c5ac-7dc9425937f4@arm.com>
 <20220929193241.pdjj5ifm7vgpff42@mobilestation>
 <6b919ea9-2f87-65ca-8286-5b4baa6e1c3c@arm.com>
 <20220930125736.rovbmgilxv3bzvzc@mobilestation>
 <26a0d62a-feec-652a-05b0-16731d55e085@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a0d62a-feec-652a-05b0-16731d55e085@arm.com>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/30/2022, Robin Murphy wrote:
> On 2022-09-30 13:57, Serge Semin wrote:
> > On Fri, Sep 30, 2022 at 12:01:58PM +0100, Robin Murphy wrote:
> > > On 2022-09-29 20:32, Serge Semin wrote:
> > > > On Thu, Sep 29, 2022 at 07:25:03PM +0100, Robin Murphy wrote:
> > > > > On 2022-09-28 12:41, Serge Semin wrote:
> > > > > > On Thu, Aug 25, 2022 at 06:50:24PM +0000, Will McVicker wrote:
> > > > > > > Re-work the msi_msg DMA allocation logic to use dmam_alloc_coherent() which
> > > > > > > uses the coherent DMA mask to try to return an allocation within the DMA
> > > > > > > mask limits. With that, we now can drop the msi_page parameter in struct
> > > > > > > dw_pcie_rp. This allows kernel configurations that disable ZONE_DMA32 to
> > > > > > > continue supporting a 32-bit DMA mask. Without this patch, the PCIe host
> > > > > > > device will fail to probe when ZONE_DMA32 is disabled.
> > > > > > 
> > > > > > As Rob already said here
> > > > > > https://lore.kernel.org/all/CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com/
> > > > > > and I mentioned in this thread
> > > > > > https://lore.kernel.org/linux-pci/20220912000211.ct6asuhhmnatje5e@mobilestation/
> > > > > > DW PCIe MSI doesn't cause any DMA due to the way the iMSI-RX engine is
> > > > > > designed. So reserving any real system memory is a waste of one in
> > > > > > this case. Reserving DMA-coherent even more inappropriate since it
> > > > > > can be expensive on some platforms (see note in Part Ia of
> > > > > > Documentation/core-api/dma-api.rst). For instance on MIPS32 with
> > > > > > non-corehent common DMA.
> > > > > 
> > > > 
> > > > > This has been discussed before - in general it is difficult to pick an
> > > > > arbitrary MSI address that is *guaranteed* not to overlap any valid DMA
> > > > > address that somebody may try to use later. However there is a very easy way
> > > > > to guarantee that the DMA API won't give anyone a particular DMA address,
> > > > > which is to get an address directly from the DMA API and keep it. Yes, that
> > > > > can technically be done with a streaming mapping *if* you already have some
> > > > > memory allocated in a suitable physical location, but coherent allocations
> > > > > are even more foolproof, simpler to clean up (particularly with devres), and
> > > > > unlikely to be an issue on relevant platforms (do any MIPS32 systems use
> > > > > this driver?)
> > > > 
> > > > My patchset adds the DW PCIe RP controller support on MIPS32 arch:
> > > > https://lore.kernel.org/linux-pci/20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru/
> > > > 
> > > > > 
> > > > > > > Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
> > > > > > > Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > > > > > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > > > > > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > > ---
> > > > > > >     .../pci/controller/dwc/pcie-designware-host.c | 28 +++++--------------
> > > > > > >     drivers/pci/controller/dwc/pcie-designware.h  |  1 -
> > > > > > >     2 files changed, 7 insertions(+), 22 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > index 7746f94a715f..39f3b37d4033 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > @@ -267,15 +267,6 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> > > > > > >     	irq_domain_remove(pp->msi_domain);
> > > > > > >     	irq_domain_remove(pp->irq_domain);
> > > > > > > -
> > > > > > > -	if (pp->msi_data) {
> > > > > > > -		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > > > -		struct device *dev = pci->dev;
> > > > > > > -
> > > > > > > -		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
> > > > > > > -		if (pp->msi_page)
> > > > > > > -			__free_page(pp->msi_page);
> > > > > > > -	}
> > > > > > >     }
> > > > > > >     static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
> > > > > > > @@ -336,6 +327,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > > > >     	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > > >     	struct device *dev = pci->dev;
> > > > > > >     	struct platform_device *pdev = to_platform_device(dev);
> > > > > > > +	u64 *msi_vaddr;
> > > > > > >     	int ret;
> > > > > > >     	u32 ctrl, num_ctrls;
> > > > > > > @@ -375,22 +367,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > > > >     						    dw_chained_msi_isr, pp);
> > > > > > >     	}
> > > > > > 
> > > > > > > -	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> > > > > > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > > > > > 
> > > > > > This has been redundant in the first place since none of the DW PCIe
> > > > > > low-level drivers update the mask, and it's of 32-bits wide by default
> > > > > > anyway:
> > > > > > https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L167
> > > > > 
> > > > 
> > > > > No, in general drivers should always explicitly set their mask(s) and check
> > > > > the return value to make sure DMA is possible at all before trying any other
> > > > > DMA API calls. There's no guarantee that the default mask is usable (e.g.
> > > > > some systems don't have any 32-bit addressable RAM), or that it's even
> > > > > always 32 bits (due to crufty reasons of something of_dma_configure() tried
> > > > > to do a long time ago).
> > > > 
> > > > Suppose you are right and DMA-mask should be always set before any
> > > > mapping. What do you suggest to do in this case? (1) The code above
> > > > overrides the real DMA-mask which could be set by the platform
> > > > drivers, which in its turn are normally aware of the device DMA
> > > > capabilities.
> > > 
> > > I am right. Appropriate DMA API usage as defined by the DMA API maintainers
> > > is not a matter of supposition. I literally just explained right there why
> > > drivers can't blindly assume the default mask is usable on modern systems
> > > (yes, it was different 20 years ago when system topologies were simpler).
> > > 
> > 
> > > However, having now gone and looked at the whole driver rather than unclear
> > > fragments of patch context, the code here *is* technically wrong. I've been
> > > mistakenly thinking all along that this was operating on the PCI device
> > > because I know that's what it *should* be doing, and seeing misleading
> > > things like "dev = pci->dev" falsely affirmed that assumption that it would
> > > be correct because it's been around for ages.
> > > AFAIU the correct PCI device
> > > won't actually exist until we've got far enough through pci_host_probe(), so
> > > I'm not sure how to easily solve this :/
> > 
> > Right. The code affected by the subject patch has nothing to do with
> > the real PCI devices. The DMA-mask is set to the DW PCIe Host controller
> > platform device in order to force a page being allocated within 32-bit
> > address space. That's it.
> > 
> > Here is a log of the related changes:
> > 
> > 0. Initially a GFP_KERNEL-based page was allocated for the MSI buffer.
> > It may cause having the DMA/PCIe-address above 4GB, which wouldn't work
> > for the PCIe peripherals with only 32-bit MSI capability. Though
> > nobody bothered back then.
> > 
> > 1. 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
> > After this commit nothing really has changed, but instead of
> > allocating the MSI-message pseudo-buffer turned to be embedded into
> > the private data. It could be allocated at any base address with no
> > actual limitation (because private data is kmalloc'ed).
> > 
> > 2. 660c486590aa ("PCI: dwc: Set 32-bit DMA mask for MSI target address allocation")
> > Someone found out that some devices failed to deliver MSI to the
> > address above 4GB of PCIe address space and fixed the problem by
> > force-setting the DMA-mask to being 32-bit before mapping the MSI
> > buffer. It indeed fixed the problem, but the actual buffer still left
> > being allocated from any address space. Instead, the mapping procedure
> > just bounced the buffer to 4GB space. So basically the solution was
> > very clumsy since turns a bounce buffer being reserved forever.
> > 
> > 3. 35797e672ff0 PCI: dwc: Fix MSI msi_msg DMA mapping
> > @William basically got things back to (0) but instead of GFP_KERNEL
> > the page was allocated from GFP_DMA32. At this stage he should have
> > dropped the DMA-mask setting too since the buffer was already
> > guaranteed to be within 4GB space, but he didn't.
> 
> I never saw that change, but frankly the justification in the commit message
> is wrong. I know that there are Android systems with memory above 32 bits
> that run with SWIOTLB disabled because they think they know what they're
> doing, which are almost certainly the same ones that also want to disable
> ZONE_DMA32 for similar reasons. That patch is really just another hack
> around an unexpected configuration, but without saying so.

Whether or not the Android OEM knows what they're doing is up to them :). We
shouldn't force enabling/disabling configs based on our own opinions about who
is an expert. Phones at least have the advantage of a controlled environment
which allows them to tune their drivers based on the hardware they ship and
don't need to worry about hotplugging unexpected hardware.

> 
> > So now we have what we have. The DMA-mask is pointlessly changed for
> > something not really implying any DMA. That's why I insisted on
> > dropping it at the very least. Another reason I thought was also
> > appropriate was the default DMA-mask being set to 32bits anyway.
> > But you said we shouldn't rely on the default DMA-mask setting. So
> > ok, it doesn't count then. But it doesn't change the uselessness of the
> > DMA-mask change in the current driver.
> 
> As I keep saying, it *is* relevant to DMA. The MSI doorbell may not be
> accessing memory, but it is still a thing that occupies DMA address space
> like a mapping of memory does, and DMA masks are how we control how DMA
> address space is allocated. Unless and until we have an API for arbitrarily
> reserving DMA address space within a given range, the approach used here and
> in other drivers is the next best thing, however much you don't like it.
> 
> > > AFAIU the correct PCI device
> > > won't actually exist until we've got far enough through pci_host_probe(), so
> > > I'm not sure how to easily solve this :/
> > 
> > Walk over all PCIe devices detected on the PCIe-bus. Check their
> > MSI-capability flags. If any of them have no 64-bit MSI flag set, then
> > make sure the MSI-base address is allocated within 4GB memory region.
> > It isn't that easy to implement though...
> 
> It has nothing to do with capabilities (but also: consider hotplug). We
> simply need the host bridge PCI device to pass to the DMA API to ensure that
> the mapping/allocation is relative to PCI Mem space rather than system
> physical address space, because the two don't have to be identical. The
> challenge is how to reliably pick up that device and set up the doorbell
> *before* any other PCI devices also discovered by pci_host_probe() have a
> chance to start binding drivers and trying to request MSIs.

Maybe I can provide some more insights on my patches that may help you guys
understand the idea behind the MSI capabilities flag. Basically, on a given
Android phone there are going to be multiple PCIe endpoints -- wifi and modem
are good examples. Some of these PCIe endpoints may only support a 32-bit MSI
capability structure, but others could support a 64-bit MSI capability
structure. So my intent was to have the PCIe RC driver detect the endpoint
device's MSI capabilites during the EP device probe and then set the
PCI_MSI_FLAGS_64BIT accordingly before calling dw_pcie_host_init(). Since the
PCIe RC drivers are the ones to call dw_pcie_host_init(), we can dynamically
change the DMA mask and allocate the doorbell target address based on the
PCI_MSI_FLAGS_64BIT.

This all really gets a lot more complicated with the introduction of Serge's
eDMA device. So I full well expect dw_pcie_msi_host_init() to be re-factored
for that.

> 
> > > Of course *this* patch doesn't change any of that either, so it's no worse
> > > than the existing code and I don't see that dropping it helps you at all;
> > > the current driver is already trampling your 64-bit mask back to 32 bits
> > 
> > Yes, and by this pathset @William intend to fix the DMA-mask-override
> > behaviour by using the dma_alloc_coherent() method.
> 
> No, that is effectively unchanged. Whether it's a streaming mapping with
> dma_mask or a coherent allocation with coherent_dma_mask, masks are getting
> set way, it's the fact that it's on the wrong device that's the real
> problem.
> 
> If you expose the eDMA as a generic dmaengine device then there's every
> chance some consumer would make a streaming mapping with it, so even though
> the current code happens to not override the coherent mask it's still biting
> you in the streaming mask.
> 
> > So any
> > platform-specific DMA-mask setting will be overwritten, and the
> > DMA-mask setting won't be able to be moved/dropped due to the
> > dma_alloc_coherent() method usage.
> > 
> > I have added a DW eDMA-engine support to the DW PCIe driver (you've
> > already seen my patches) and the engine initialization is supposed to
> > be performed after any basic initializations like CSRs mapping, data
> > allocations, MSI, etc. Since DMA is performed by the controller itself
> > it's required to have a correct DMA-mask set to the DW PCIe platform
> > device otherwise any consequent mapping will be bounce buffered to the
> > lowest 4GB even though the corresponding platform can support more
> > than 4GB of memory (even our MIPS32 can) with DW eDMA easily reaching
> > that memory. What would help me in this case if the MSI-buffer
> > allocation procedure wouldn't change the device DMA-mask.  As an
> > alternative to completely dropping the DMA-mask setting, the DMA-mask
> > setup process could be moved to the low-level platform device drivers.
> > It would be even more justified since the platform-specific device
> > capabilities (like DW PCIe AXI-interface address-bus width) are
> > unknown in the generic code.
> > 
> > As another alternative I could override the DMA-mask within the DW
> > eDMA probe procedure. But that would make things more complicated than
> > relying on the low-level platform drivers doing that.
> > 
> > > and
> > > reserving the doorbell address in the wrong DMA address space (modulo the
> > > other dma-ranges bug which also took far too long to figure out).
> > 
> > Actually current driver (without William patch) reserve the doorbell
> > address in the correct DMA address space (if we don't take the
> > dma-ranges settings into account).
> 
> No it does not. With or without this patch it is still passing the *platform
> device* to the DMA API, which means the mapping is relative to the platform
> address space, not PCI Mem space on the other side of the iATU. The fact
> that the iATU's dma-ranges translation is erroneously applied to the
> platform device at the moment is, as I have said, a bug.

Thanks for pointing this out. I agree this is a bug and I guess it hasn't
really been a problem because there isn't really any DMA'ing going on. With the
new eDMA device being introduced, this bug will likely need to be fixed.

> 
> > It works as expected in case if the
> > PCIe<->CPU space has one-on-one mapping (which is true in the most of
> > the cases). The only thing which is wrong is the pointless DMA-mask
> > update. I could have easily dropped it in my patchset. But after the
> > @William patchset is applied I won't be able to do that due to using
> > the dma_alloc_coherent() here.
> 
> Once again, it is not pointless. There is no guarantee that __GFP_DMA32 does
> anything, since ZONE_DMA32 may not exist (per this patch), and the zones may
> not be as expected anyway (look at what arm64 currently does if all RAM is
> above 32 bits, but save those complaints for another thread).
> 
> > > At this
> > > point I'd rather keep it since getting rid of the __GFP_DMA32 abuse is
> > > objectively good. If losing one page of coherent memory is a measurably
> > > significant problem for T1 once the other issues are worked out and that
> > > series lands, then you're welcome to propose a change on top (but I would
> > > prefer that all the drivers using this trick are changed consistently).
> > 
> > Regarding DMA-coherent allocation. I am not happy with losing a whole
> > page of the dma-coherent memory, but we can live with that. What give
> > additional difficulty for our eDMA-patches is the DMA-mask override.
> > If you still insist on preserving the @William patchset as it is,
> > where do you suggest for me to update the DMA-mask if the low-level
> > driver won't be suitable for that anymore?
> 
> I'm not insisting anything, it's just that this patch is already reviewed
> and queued, is a small step towards being less wrong overall, and dropping
> it wouldn't actually solve any of your problems anyway, so I just feel that
> being obstructive because it falls short of perfection isn't helpful.

Thanks for the responses Robin! I agree that we don't have a complete solution
and need to fix this DMA address space bug, but dont think that's enough of
a reason to drop this patch series. At the very least I think patch 1/2 which
removes the ZONE_DMA32 dependency is a worthy patch to take for 6.1.

Thanks,
Will

> 
> Robin.
