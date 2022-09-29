Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814D45EFDF4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiI2Tct (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 15:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiI2Tcs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 15:32:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8346412644D;
        Thu, 29 Sep 2022 12:32:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a2so3737963lfb.6;
        Thu, 29 Sep 2022 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cXkX2H9k3D7HLHbVxc2rCNU+15RLZHb5rgdEV0Qk9eA=;
        b=dThX9s1Gd4gBefmvzUkQA2VisMXXBMw2u5LJFqbgG8o2GxKxCEr8sZjP+2CZS2llRW
         nyeEYzMeMI/KR/m1tR6xc+Bh62vcorocQiYHD1JZaxMb3/i5VgfMEwgCm+PyEoK4MEbk
         /quwDt3Kj82H8pqO2nYf+T8SQruRjWweCNjbiaxdlP5JD7HlLcwG/thlzqJ8hkOzs5AB
         qCbUxVOB6PyJnDB/9ZK910wOc458FQNH/QjQ3LqYCMtV0SCdlzIzXJ+D90/AGbOIVzhL
         k9xGYamAdmVwtOoqrS1H30zAXZwInYGtsyjj/EoBetCceNwL9bhy9uQVpzfFOYlenZ44
         U51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cXkX2H9k3D7HLHbVxc2rCNU+15RLZHb5rgdEV0Qk9eA=;
        b=nAHAeRJUwK4wxtuSMOpdGijNVMo5mWNR95DyKZzyo+h+iM5AvgZ1bq/otjJFYb95Kr
         SCdrU9ij07neRNb3hIc+Oka7AVb7maGiwn5QPTCFT/jYfTxwDASqm23+xK1zkW6FfXJD
         txRk4iEmz3EY0k2Bxp++/8PbgovcF/ryczM8zY4THvdqABJgM1626305dpEnJJZeUXRM
         +50AZhV7+Bhvdcf0b63QtAb/WI//MQ+K7qJ8VqNyWxK/7OLI6cyYDFoZXQZRRoxozb8Z
         pisNgBekSfb7I+NxmU7RWQVGdpG0Xv6cAKpTUx8h4t9EobemQAR03+/tum3z7tqCBrsZ
         uRkg==
X-Gm-Message-State: ACrzQf2y+gWuu2RVehStzVqqls+9/d/rUv1vEZSreBr6ArOPHTunn6f0
        qhQ5AcGsOPFSO2+/ZGnfsMA=
X-Google-Smtp-Source: AMsMyM4lSK5B+Hgq1SCBKPOrcbVfnB35EVyc7TA4ULFN6OEfoY7sOFM3XzVzQumLtgsYIrMNPZjqAQ==
X-Received: by 2002:a05:6512:c2a:b0:497:a1ee:7a21 with SMTP id z42-20020a0565120c2a00b00497a1ee7a21mr2047880lfu.221.1664479965624;
        Thu, 29 Sep 2022 12:32:45 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id a8-20020a2eb548000000b00268bfa6ffacsm25536ljn.108.2022.09.29.12.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:32:44 -0700 (PDT)
Date:   Thu, 29 Sep 2022 22:32:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will McVicker <willmcvicker@google.com>,
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
Message-ID: <20220929193241.pdjj5ifm7vgpff42@mobilestation>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-2-willmcvicker@google.com>
 <20220928114136.4yvtfnrcril3jkgg@mobilestation>
 <4dc31a63-00b1-f379-c5ac-7dc9425937f4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc31a63-00b1-f379-c5ac-7dc9425937f4@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 29, 2022 at 07:25:03PM +0100, Robin Murphy wrote:
> On 2022-09-28 12:41, Serge Semin wrote:
> > On Thu, Aug 25, 2022 at 06:50:24PM +0000, Will McVicker wrote:
> > > Re-work the msi_msg DMA allocation logic to use dmam_alloc_coherent() which
> > > uses the coherent DMA mask to try to return an allocation within the DMA
> > > mask limits. With that, we now can drop the msi_page parameter in struct
> > > dw_pcie_rp. This allows kernel configurations that disable ZONE_DMA32 to
> > > continue supporting a 32-bit DMA mask. Without this patch, the PCIe host
> > > device will fail to probe when ZONE_DMA32 is disabled.
> > 
> > As Rob already said here
> > https://lore.kernel.org/all/CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com/
> > and I mentioned in this thread
> > https://lore.kernel.org/linux-pci/20220912000211.ct6asuhhmnatje5e@mobilestation/
> > DW PCIe MSI doesn't cause any DMA due to the way the iMSI-RX engine is
> > designed. So reserving any real system memory is a waste of one in
> > this case. Reserving DMA-coherent even more inappropriate since it
> > can be expensive on some platforms (see note in Part Ia of
> > Documentation/core-api/dma-api.rst). For instance on MIPS32 with
> > non-corehent common DMA.
> 

> This has been discussed before - in general it is difficult to pick an
> arbitrary MSI address that is *guaranteed* not to overlap any valid DMA
> address that somebody may try to use later. However there is a very easy way
> to guarantee that the DMA API won't give anyone a particular DMA address,
> which is to get an address directly from the DMA API and keep it. Yes, that
> can technically be done with a streaming mapping *if* you already have some
> memory allocated in a suitable physical location, but coherent allocations
> are even more foolproof, simpler to clean up (particularly with devres), and
> unlikely to be an issue on relevant platforms (do any MIPS32 systems use
> this driver?)

My patchset adds the DW PCIe RP controller support on MIPS32 arch:
https://lore.kernel.org/linux-pci/20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru/

> 
> > > Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
> > > Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >   .../pci/controller/dwc/pcie-designware-host.c | 28 +++++--------------
> > >   drivers/pci/controller/dwc/pcie-designware.h  |  1 -
> > >   2 files changed, 7 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 7746f94a715f..39f3b37d4033 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -267,15 +267,6 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> > >   	irq_domain_remove(pp->msi_domain);
> > >   	irq_domain_remove(pp->irq_domain);
> > > -
> > > -	if (pp->msi_data) {
> > > -		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > -		struct device *dev = pci->dev;
> > > -
> > > -		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
> > > -		if (pp->msi_page)
> > > -			__free_page(pp->msi_page);
> > > -	}
> > >   }
> > >   static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
> > > @@ -336,6 +327,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > >   	struct device *dev = pci->dev;
> > >   	struct platform_device *pdev = to_platform_device(dev);
> > > +	u64 *msi_vaddr;
> > >   	int ret;
> > >   	u32 ctrl, num_ctrls;
> > > @@ -375,22 +367,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >   						    dw_chained_msi_isr, pp);
> > >   	}
> > 
> > > -	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > 
> > This has been redundant in the first place since none of the DW PCIe
> > low-level drivers update the mask, and it's of 32-bits wide by default
> > anyway:
> > https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L167
> 

> No, in general drivers should always explicitly set their mask(s) and check
> the return value to make sure DMA is possible at all before trying any other
> DMA API calls. There's no guarantee that the default mask is usable (e.g.
> some systems don't have any 32-bit addressable RAM), or that it's even
> always 32 bits (due to crufty reasons of something of_dma_configure() tried
> to do a long time ago).

Suppose you are right and DMA-mask should be always set before any
mapping. What do you suggest to do in this case? (1) The code above
overrides the real DMA-mask which could be set by the platform
drivers, which in its turn are normally aware of the device DMA
capabilities. But in this case due to override afterwards any buffers
above 4GB mapping will cause using the bounce buffers. (2) It's set
here for something which isn't actual DMA. So to speak on one side is
this patchset which overrides the mask for something which isn't DMA,
and there are another patchsets:
https://lore.kernel.org/linux-pci/20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru/
and
https://lore.kernel.org/linux-pci/20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru/
which add the real DMA support to DW PCIe driver and for which setting
the real DMA-mask is crucial. What do you suggest? Setting the mask
twice: before allocating MSI-buffer and afterwards for the sake of
eDMA buffers mapping? Moving DMA-mask setting from the generic DW PCIe
code to the platform drivers?

-Sergey

> 
> Thanks,
> Robin.
> 
> > >   	if (ret)
> > >   		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > > -	pp->msi_page = alloc_page(GFP_DMA32);
> > > -	pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
> > > -				    PAGE_SIZE, DMA_FROM_DEVICE);
> > > -	ret = dma_mapping_error(dev, pp->msi_data);
> > > -	if (ret) {
> > > -		dev_err(pci->dev, "Failed to map MSI data\n");
> > > -		__free_page(pp->msi_page);
> > > -		pp->msi_page = NULL;
> > > -		pp->msi_data = 0;
> > > +	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > +					GFP_KERNEL);
> > 
> > Changing the whole device DMA-mask due to something that doesn't
> > perform seems inappropriate. I'd suggest to preserve the ZONE_DMA32
> > here until there is something like suggested by @Robin
> > https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com/
> > in the last paragraph is implemented. Especially seeing there still
> > common drivers in kernel which still rely on that zone.
> > 
> > -Sergey
> > 
> > > +	if (!msi_vaddr) {
> > > +		dev_err(dev, "Failed to alloc and map MSI data\n");
> > >   		dw_pcie_free_msi(pp);
> > > -
> > > -		return ret;
> > > +		return -ENOMEM;
> > >   	}
> > >   	return 0;
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 09b887093a84..a871ae7eb59e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -243,7 +243,6 @@ struct dw_pcie_rp {
> > >   	struct irq_domain	*irq_domain;
> > >   	struct irq_domain	*msi_domain;
> > >   	dma_addr_t		msi_data;
> > > -	struct page		*msi_page;
> > >   	struct irq_chip		*msi_irq_chip;
> > >   	u32			num_vectors;
> > >   	u32			irq_mask[MAX_MSI_CTRLS];
> > > -- 
> > > 2.37.2.672.g94769d06f0-goog
> > > 
> > > 
