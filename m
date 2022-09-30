Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876A5F0CB1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiI3NrF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 09:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiI3NrE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 09:47:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E111A8E9A9;
        Fri, 30 Sep 2022 06:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C196233F;
        Fri, 30 Sep 2022 13:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95328C433D6;
        Fri, 30 Sep 2022 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664545622;
        bh=m0fOS3nX34bn+zHDJ8p29wfX8vHDfZ362AEULihkAt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeWscGueLbTg9AH4Z+J781W2zFEuheRhF0bhCKB2ytnvPkWlnixbIDvogdL5rPrwL
         n5vc1lvSpZpS0D4wFgC6fJ7zsBubef7lnBl/R91lpBYkASCudW40u3sfAVJWBg5A1I
         qtm/wL/+cUo54/aoQw8KaGL4X545CLCG0Afyila/D2kF/FxmIGIkHeWcr33q5QR4xc
         iZewwiPiML2RlW6uu+zEDrdppacQJwcnklV8rSZZ8XmtEUUw4bZ7Li5kU8dEisT3kg
         DXYlf0if9+s1JniIRgw2rj6sYkb2Dx+mbf4QMD6gwMDI/k4yuLQx1aFxr2e/cKtN7V
         /DgIkczJ3sjXA==
Date:   Fri, 30 Sep 2022 15:46:56 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Message-ID: <YzbzUCikdpesdbLU@lpieralisi>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
 <20220928120510.rkdlnczytxuioxcn@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928120510.rkdlnczytxuioxcn@mobilestation>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 03:05:10PM +0300, Serge Semin wrote:
> On Thu, Aug 25, 2022 at 06:50:25PM +0000, Will McVicker wrote:

[...]

> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 39f3b37d4033..8928a9a29d58 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -330,6 +330,9 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	u64 *msi_vaddr;
> >  	int ret;
> >  	u32 ctrl, num_ctrls;
> > +	bool msi_64bit = false;
> > +	bool retry_64bit = false;
> > +	u16 msi_capabilities;
> >  
> >  	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> >  		pp->irq_mask[ctrl] = ~0;
> > @@ -367,16 +370,33 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  						    dw_chained_msi_isr, pp);
> >  	}
> >  
> > -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > -	if (ret)
> > -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> 
> > +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> > +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> > +		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
> 
> Note this capability flag has nothing to do with the DW PCIe iMSI-RX
> engine, which is used here to detect and report MSI TLPs. By design
> iMSI-RX always support 64-bit addresses. If you imply having that flag
> set by the DW PCIe platform drivers on the platform-specific probe
> stage as an indication of MSI address range, then ok.

The MSI cap shows that - AFAICS - the RP can be programmed with
a 64-bit MSI(DMA) address. It is fair to say that this is not
enough to guarantee that the DMA mask for the host bridge can be
inferred to be 64-bit though.

I am inclined to drop this patch (only) from the PCI queue because
it is unclear to me whether it really does the right thing.

Lorenzo

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
> > +		ret = dma_set_mask_and_coherent(dev, retry_64bit ?
> > +						DMA_BIT_MASK(64) :
> > +						DMA_BIT_MASK(32));
> 
> I'd suggest to just drop this. No DMA actually performed on getting the
> MSI TLPs. So modifying the device DMA-mask due to something which
> doesn't cause DMA and based on the flag which doesn't indicates the
> device DMA-capability is at least inappropriate.
> 
> > +		if (ret)
> > +			dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
> > +				 retry_64bit ? "64" : "32");
> > +
> 
> > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > +						GFP_KERNEL);
> 
> As I noted earlier the DMA-coherent memory can be too expensive. So
> it's a waste of one allocating with no intent of usage. Instead of this
> just get back the alloc_page() method here and pass the flag GFP_DMA32
> to that function if MSI-capability reported the PCI_MSI_FLAGS_64BIT
> unset.
> 
> -Sergey
> 
> > +		if (!msi_vaddr) {
> > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > +			if (msi_64bit && !retry_64bit) {
> > +				retry_64bit = true;
> > +				continue;
> > +			}
> > +
> > +			dw_pcie_free_msi(pp);
> > +			return -ENOMEM;
> > +		}
> > +		break;
> >  	}
> >  
> >  	return 0;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index c6725c519a47..650a7f22f9d0 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -82,6 +82,14 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
> >  
> > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
> > +{
> > +	u8 offset;
> > +
> > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > +	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > +}
> > +
> >  static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> >  					    u8 cap)
> >  {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index a871ae7eb59e..45fcdfc8c035 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -332,6 +332,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
> >  
> >  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
> >  
> >  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
> >  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> > -- 
> > 2.37.2.672.g94769d06f0-goog
> > 
> > 
