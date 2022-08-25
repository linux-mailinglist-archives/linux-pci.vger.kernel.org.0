Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE45A1AF5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 23:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbiHYVWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiHYVWQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 17:22:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818BABB002
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 14:22:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g189so4907918pgc.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/e+LqK/q+u9symjBcWa/3jFlckMwfnMM7fu3ESMwHEY=;
        b=oOR6OycOhqZc7h24pYx0QoNxrNViQHcvBeMfOOq5GMRHei0hTOAOK4FXVr35hK1KKA
         m0hPNe3ivdhmKSwAd1iT09nYZVqtmaVTuQoTerM3vS971Y/hcVVAJDEA4ZxpBSTHs66g
         JIgZPR64cDjEqcO4WjHHsvT3IyGb1oRDYxTmQtAcHaJi0k5MUzhyhCPpzLc68BQuZnFM
         UhZKA8mroP/lQN0mggZv9j1UgyfMG9Zs8SjtuvRflNRAFema+mUXmQCJ0iEHzjk+L9Hc
         cC482YIUg8UJX2GLZaZGlKRDM37XTe8IOTs36V0DF/1bdSTbE3Tg4oKmsamQHYvoxI+S
         LNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/e+LqK/q+u9symjBcWa/3jFlckMwfnMM7fu3ESMwHEY=;
        b=rL6zqVE29NknmnZ4tXCzeZQunU8m9qc9zP2MvCSZDfI7axQMdq031/0GACi47PHlL3
         piUMnPZ2Pvx1ETvQX8dP7Eb6j1xZzB8LXFldjuwjmzbaouvMT5QL1/1EsxX4g9dorF3r
         AvYKWK1pKC/vpRal/XA0LsDAWb89pN16loibtZ9be2PZ8SMU105mVYvUfH+5q4itcCUq
         iyBU3Yyu7MCGWHb9dIx1XB5BwIHFdywgcxzA/jonpoQ8AcmzX3dDgsxezpFAVod2c2hk
         nU7tsRxOrxFvrmKWQ9x6Gx/0PTofBwnG/xXgVKTDVqJdPwbsQ4HQLTv6e550itmnEjUg
         Lb1g==
X-Gm-Message-State: ACgBeo2+14JmnaY5QkXeChMg9s59aZkOuusXIMojIkJj6vQ2zKWhjQW2
        NK57It61/wnD6VMxn6NCas1fUg==
X-Google-Smtp-Source: AA6agR5owlY1ZLhzmSl+4AQ1Z9gsg76DHkAwCzaaIgigVu1g0uZf+YoR5I7tfyRkCUz6e0hV95pOjw==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c67 with SMTP id d22-20020a056a00199600b0052eb0f78c67mr882853pfl.20.1661462532725;
        Thu, 25 Aug 2022 14:22:12 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id q11-20020a170903204b00b001708b189c4asm22331pla.137.2022.08.25.14.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:22:12 -0700 (PDT)
Date:   Thu, 25 Aug 2022 21:22:08 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Message-ID: <YwfoAKorwSVooUY2@google.com>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
 <335d730d-529e-7ce0-8bac-008a4daa6e3c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335d730d-529e-7ce0-8bac-008a4daa6e3c@arm.com>
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/25/2022, Robin Murphy wrote:
> On 2022-08-25 19:50, Will McVicker wrote:
> > Since not all devices require a 32-bit MSI address, add support to the
> > PCIe host driver to allow setting the DMA mask to 64-bits if the 32-bit
> > allocation fails. This allows kernels to disable ZONE_DMA32 and bounce
> > buffering (swiotlb) without risking not being able to get a 32-bit address
> > during DMA allocation.
> > 
> > Basically, in the slim chance that there are no 32-bit allocations
> > available, the current PCIe host driver will fail to allocate the msi_msg
> > page due to a DMA address overflow (seen in [1]). With this patch, the
> > PCIe host can retry the allocation with a 64-bit DMA mask if the current
> > PCIe device advertises 64-bit support via its MSI capabilities.
> > 
> > [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > ---
> >   .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++++++-----
> >   drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
> >   drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> >   3 files changed, 38 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 39f3b37d4033..8928a9a29d58 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -330,6 +330,9 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >   	u64 *msi_vaddr;
> >   	int ret;
> >   	u32 ctrl, num_ctrls;
> > +	bool msi_64bit = false;
> > +	bool retry_64bit = false;
> > +	u16 msi_capabilities;
> >   	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> >   		pp->irq_mask[ctrl] = ~0;
> > @@ -367,16 +370,33 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >   						    dw_chained_msi_isr, pp);
> >   	}
> > -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > -	if (ret)
> > -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> > +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> > +		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
> > -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > -					GFP_KERNEL);
> > -	if (!msi_vaddr) {
> > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > -		dw_pcie_free_msi(pp);
> > -		return -ENOMEM;
> > +	while (true) {
> > +		dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
> > +			retry_64bit ? "64" : "32");
> 
> If only we has some sort of "variable" that could could store a numerical
> value, think of the possibilities... :)

Sure, now that we're trying both 32- and 64-bit, I can do that. Thanks for the
suggestion :)

> 
> > +		ret = dma_set_mask_and_coherent(dev, retry_64bit ?
> > +						DMA_BIT_MASK(64) :
> > +						DMA_BIT_MASK(32));
> > +		if (ret)
> > +			dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
> > +				 retry_64bit ? "64" : "32");
> 
> Setting a 64-bit mask should never fail, since it represents having no
> possible limitation whatsoever (I'm not sure if there are any platforms left
> where setting a 32-bit mask can actually fail in practice either, but I have
> no strong opinion on the fate of the existing warning).

Yeah, I'm not sure how this could fail. So I just left the warning and edited
the message. It's probably cleaner to just leave the warning unconditionally
based on ret.

> 
> > +
> > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > +						GFP_KERNEL);
> > +		if (!msi_vaddr) {
> > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> 
> Possibly a mattrer of personal taste, but I'd say try to avoid dev_err() for
> things that aren't actually fatal; if you're still able to continue on, at
> best it's a warning, not an error. Especially if your use-case *expects* the
> 32-bit allocation fail. There's nothing more offputting than booting a
> typical vendor kernel and watching it scream tons of errors that look
> EXTREMELY IMPORTANT yet are also apparently inconsequential.

Failing a 32-bit allocation should be a rare case, but still possible. If it
fails for both 32-bit and 64-bit, then it's very likely the PCIe device calling
dw_pcie_host_init() will fail to probe. So I'll move this down to only report
that error.

> 
> > +			if (msi_64bit && !retry_64bit) {
> > +				retry_64bit = true;
> > +				continue;
> > +			}
> > +
> > +			dw_pcie_free_msi(pp);
> > +			return -ENOMEM;
> > +		}
> > +		break;
> 
> TBH the whole loop design is a bit baroque for me, I'd have gone for a more
> straightforward tweak to the existing flow, something like:
> 
> 	msi_vaddr = NULL;
> 	ret = dma_set_mask(32);
> 	if (!ret)
> 		msi_vaddr = dma_alloc();
> 	if (!msi_vaddr && msi_64bit) {
> 		dev_warn();
> 		dma_set_mask(64);
> 		msi_vaddr = dma_alloc();
> 	}
> 	if (!msi_vaddr) {
> 		dev_err();
> 		return;
> 	}
> 		
> However I'm happy that you've captured the important functional point, so
> I'll leave the style matters up to Lorenzo.

I was trying to avoid duplicating the allocation code, but if that's preferred,
then I'm fine with it.

> 
> Thanks,
> Robin.
> 
> >   	}
> >   	return 0;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index c6725c519a47..650a7f22f9d0 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -82,6 +82,14 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> >   }
> >   EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
> > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
> > +{
> > +	u8 offset;
> > +
> > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > +	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > +}
> > +
> >   static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> >   					    u8 cap)
> >   {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index a871ae7eb59e..45fcdfc8c035 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -332,6 +332,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
> >   u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> >   u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
> >   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
> >   int dw_pcie_write(void __iomem *addr, int size, u32 val);

Thanks,
Will
