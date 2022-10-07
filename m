Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48C95F80DD
	for <lists+linux-pci@lfdr.de>; Sat,  8 Oct 2022 00:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJGWpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 18:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJGWpW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 18:45:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138FBC613;
        Fri,  7 Oct 2022 15:45:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r14so9201147lfm.2;
        Fri, 07 Oct 2022 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8lMVcjBY7o9HvLnsky7BCzwLG9CQsP53cQv3MPfApo=;
        b=lRzw2JQiYUxvEHnUtC3UJWL0/ChUhiLLycJNhADDMoLE+nRwGFPEpOslptrRzZSa5j
         HEQAvc69OVO7h3SVRCpdZFTnclYdmwJomcKMkcoa3VPBeLlatBkSux/NF7eBEY0SieeI
         8rkOPD+ZBxpPq+D36Z0BLyA/G8U7wDgwqoi4IxP4tVD2S7QHjPQzz+UTmHWnIBYvHjCB
         r9GBACL579yqqmMjBl9ciuFYJH1yEyojA8LGc4wB3l8zCjaqDd4QDpp3pskLNsIRQ2QY
         G6B4g/r5DQ1RFzrDuqWRKQkjBXzIZcDvvxYt+j7u6pzzNrjafc668ycVZjwPk76+A07r
         X/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8lMVcjBY7o9HvLnsky7BCzwLG9CQsP53cQv3MPfApo=;
        b=6YMBsq4klhqDLtEEbSgmRa1Lg1QJLufrP18kEvLd7raGsZhoix243ZT5Gj1CVtj2kE
         tgeWt461d/TpG1Ks0OO0XfBNUEBFWR4w8g/865ZycabPVwduxlS/Gb3ZkdXapjf6mKMF
         HE3MxWZDYDXLStf5ZfDpmXARztTiDBs30ychHAovMBJtiUrunjR2cavyGcPfjyDA+kwT
         ZS5CkDODQGV3oyV6qh1dtUHqB4XznlmqzylJV1obKVWy44/bMZ3wBehqQxGJ5TuoJuok
         nVn8xA+9jZ1Xb1E2+rRwNrPEXE1u6wVO7rjNRnC3DOgYTb4UblnXWVJzOEH3Cp1exwEe
         inAQ==
X-Gm-Message-State: ACrzQf1Cz1lpZZ59PP2kTXFptH8mU4zq4G9KGIxqh3PIdoRVipJNS6uQ
        IX5uFfRTCVVuMJLnQVhr+8M=
X-Google-Smtp-Source: AMsMyM4eE0/CdQBJTTtXxyN35zYb7lXM2dMFLOMANoy4bY+nPoqtFuzuPhSUk4fgtQf0dhI56H8H+g==
X-Received: by 2002:a05:6512:747:b0:4a2:3eaf:366c with SMTP id c7-20020a056512074700b004a23eaf366cmr2816396lfs.633.1665182718260;
        Fri, 07 Oct 2022 15:45:18 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id v18-20020a2ea452000000b0026ab2a04055sm470373ljn.130.2022.10.07.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 15:45:17 -0700 (PDT)
Date:   Sat, 8 Oct 2022 01:45:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will McVicker <willmcvicker@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>
Subject: Re: [PATCH v5 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
Message-ID: <20221007224515.sseyabdfa2phcsdz@mobilestation>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 30, 2022 at 04:39:05PM +0100, Robin Murphy wrote:
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

It's not that I don't like the approach. Now after the @William's
patch is merged in I don't really see a well suitable place for
setting the real DMA-mask of the DW PCIe controller for the eDMA
operations. I didn't want to set the mask in the DW eDMA probe
function since it was common for both eDMA embedded into a remote PCIe
function and installed into the local Root Port/End-point device. In
the first case the DMA-mask is already set in the dw-edma-pcie.c
driver. In order to cover the later case I was going to use the
low-level platform drivers. But after not being able to get rid from
the DMA-mask override performed in the MSI-setup procedure I will have
no choice to hack the eDMA driver somehow (see the last comment for
details).

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

> It has nothing to do with capabilities (but also: consider hotplug).

Actually it does. Based on the MSI 64-bit MSI flags state we would need
to chose either the pure 32-bit or 64/32-bit mask. Of course hotplug
would be a problem. But it's not the point in this case.

> We
> simply need the host bridge PCI device to pass to the DMA API to ensure that
> the mapping/allocation is relative to PCI Mem space rather than system
> physical address space, because the two don't have to be identical.

Right, that would have solved the problem with setting the DMA-mask to
a correct device. But the PCIe-space-related "dma-ranges" would be
still left applied to the DW PCIe platform device. Moreover in general
the PCIe host interface can have its own "dma-ranges". So we'll need
to have two types of the "dma-ranges": for the PCIe-bus to initialize
the inbound iATU and for the DW PCIe-controller itself. Furthermore
the later translations are applicable for the former addresses too... 

> The
> challenge is how to reliably pick up that device and set up the doorbell
> *before* any other PCI devices also discovered by pci_host_probe() have a
> chance to start binding drivers and trying to request MSIs.

There is no way at the current pci_host_probe() method implementation
because it performs the host bridge device registration and the
PCIe-bus scanning. There either have to be a hook to be called after
the bridge is registered or the pci_host_probe() would have to be
split up into two sub-methods: bridge-registration and scan child
buses. I have doubts that either case would be happily welcomed by
@Bjorn.

> 
> > > Of course *this* patch doesn't change any of that either, so it's no worse
> > > than the existing code and I don't see that dropping it helps you at all;
> > > the current driver is already trampling your 64-bit mask back to 32 bits
> > 
> > Yes, and by this pathset @William intend to fix the DMA-mask-override
> > behaviour by using the dma_alloc_coherent() method.
> 

> No, that is effectively unchanged.

I meant the same. It's unchanged, but if before the @William' patch we
could have drop the DMA-mask change at the assumption that the CPU and
PCIe spaces are identical and relying on the DMA32 zone availability,
now we can't because of the dma_alloc_coherent() method utilization.

> Whether it's a streaming mapping with
> dma_mask or a coherent allocation with coherent_dma_mask, masks are getting
> set way, it's the fact that it's on the wrong device that's the real
> problem.
> 
> If you expose the eDMA as a generic dmaengine device then there's every
> chance some consumer would make a streaming mapping with it, so even though
> the current code happens to not override the coherent mask it's still biting
> you in the streaming mask.

Right. It is. That's why I was trying to come up with an approach for
@William to drop the DMA-mask override at all, i.e. either rely on the
default DMA-mask state or just move the mask setting to the low-level
DW PCIe platform drivers.

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

That's why I noted "if we don't take the dma-ranges settings into
account". Taking out a wrong device utilization and if the CPU and PCIe
spaces are identical then passing the *platform device* to the DMA API
will do what is expected by the current code.

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

Ok. It is indeed not pointless taking the fact that the __GFP_DMA32 can
do nothing. (I would have renamed the __GFP_DMA32 flag to something like
__GFP_DMA32_NOT_GUARANTEED then)

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

I am starting to get confused because the problem has turned to be
multi-dimensional. We started discussing the DMA-mask override, while
now we are talking about a wrong device usage and the dma-ranges bug.
Let me sum up so we could come to some conclusions on each problem. 

1. This patch is already merged in by @Lorenzo.
The streaming and coherent DMA-masks are still forced to be of 32-bits
in the DW PCIe platform device. The low-level DW PCIe platform drivers
can't be used to set a correct mask now since it will be overwritten
by the MSI-setup procedure.

* Temporary solution: I'll override the DMA-mask in the eDMA driver:
try 64-bit mask, if failed - fallback to 32-bit mask. In fact I'll set
the DMA-mask to the DMAengine backing device since it will be used for
the correct DMA-mappings anyway (see problem 3.)

2. The DMA-mask is set to a wrong device in the framework of the
MSI-setup procedure.
Indeed it is supposed to be set to the PCI bridge device. But we can't
do that due to the pci_host_probe() method implementation. The device
is not ready for the DMA-mask update and the memory allocation/mapping
at the stage of the MSI-setup procedure execution. Isn't it? (Note the
empty instance is available at that stage.)

3. PCIe-bus-related DMA-ranges are applied to the PCIe host interface.
This is a bug. It can't be easily fixed due to the PCIe-specific
semantic of the "dma-ranges" OF-property. @Robin promised to think of
a proper solution for this.

* Temporary solution: I'll set the dma_chan.dev->chan_dma_dev flag to
true, just initialize the DMA-parameters of the DMA-channel backing
device instance by using the {of,acpi}_dma_configure() methods and drop the
dma_range_map assigned to it. In addition I'll set the DMA-mask of the
DMA-channel backing device too to solve the problem 1 (see above).

Sounds like a doable plan. What do you think?

-Sergey

> 
> Robin.
