Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EB35F0D2B
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiI3OOP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiI3OOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 10:14:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EDE17DC0B;
        Fri, 30 Sep 2022 07:14:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b6so4926666ljr.10;
        Fri, 30 Sep 2022 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/YxpMmXaMRgmPTQHUD7Yd7YlKdlqlO/QkbBIqrm2TKQ=;
        b=YSHptMlMDn7s0rnKmXh9RiPBNJ9fWlXT5cK1uUpEL0vEbsLXcoMHmno7HGDrywjDlc
         g8TzGG0EpOQ3RDebA+OnS8bONKe1N9VpECpYUJvLl3v3PQ5BeLT/t/JSuI5vlnz3m6+5
         wY0ghobz9xqyyqV5xHUR8haH6h1LtTFPId/BVHPyEvmX8Z7YeFZKj3F6ItyeIfceUCyk
         Lc2h1vEGN82oPVfUCGzzj6Lk91LpVL6yRCb91zHlI+kI8MsIjawVcFrwI9RIf3TmDL6N
         iXB2ctt4vSt1iQVRN0Gv7hLun2O97/qP4kWu8HLKdjzHXCcqvhulDOT7RnjVUH0qnxK7
         i6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/YxpMmXaMRgmPTQHUD7Yd7YlKdlqlO/QkbBIqrm2TKQ=;
        b=q0qclGZrwK9qxsZlpQoP8fN3bMbGS1qp7LUT48PudalSqnvvl7PO9vRxdtU0iXc2qo
         1UrAtoBRG3tzs5fwixKmgB6yhZ7MkNA1UMMSqCDfyYEzSjKoKZvJjBxz1op8HxicJV79
         PRvHykHdkQEl36zSMqeUp0bOAsJ5049kv3LSzMkbGYs079cID831S65bPJFZpHId4BmY
         3942cIOsI4mg+DyimiCy+yAWDUFaEtW+2X+avy7SlG5WFw66STqxuCyd+uO1JzET5dfu
         fHGrkWSVk2xqDBf97izpUFG9Z1/K+qTTLs+uZpdk+J3j/qeO8DwqnfONI2kN468e+XuX
         gJqA==
X-Gm-Message-State: ACrzQf3OB6vQJ6U6OjNdPaXkVfm2IbVG/FTlZNpxSOaC2skeGamdN+bd
        5p9xNeV/I7/WFaAt95McUo+P+3QBrn+OUA==
X-Google-Smtp-Source: AMsMyM7YlOphqoXiFfpges8kyFfmN6P3TfmN0xqohtmh+sxHq/RhsE7+8X7ctKOKzNdliT4Bi3n6TQ==
X-Received: by 2002:a2e:b8d2:0:b0:26c:34d8:a849 with SMTP id s18-20020a2eb8d2000000b0026c34d8a849mr3146798ljp.274.1664547249752;
        Fri, 30 Sep 2022 07:14:09 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b004998d9ccb62sm308159lfq.99.2022.09.30.07.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:14:09 -0700 (PDT)
Date:   Fri, 30 Sep 2022 17:14:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
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
Message-ID: <20220930141407.mbpb33b4a6jitfyl@mobilestation>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
 <20220928120510.rkdlnczytxuioxcn@mobilestation>
 <YzbzUCikdpesdbLU@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzbzUCikdpesdbLU@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 30, 2022 at 03:46:56PM +0200, Lorenzo Pieralisi wrote:
> On Wed, Sep 28, 2022 at 03:05:10PM +0300, Serge Semin wrote:
> > On Thu, Aug 25, 2022 at 06:50:25PM +0000, Will McVicker wrote:
> 
> [...]
> 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 39f3b37d4033..8928a9a29d58 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -330,6 +330,9 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >  	u64 *msi_vaddr;
> > >  	int ret;
> > >  	u32 ctrl, num_ctrls;
> > > +	bool msi_64bit = false;
> > > +	bool retry_64bit = false;
> > > +	u16 msi_capabilities;
> > >  
> > >  	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> > >  		pp->irq_mask[ctrl] = ~0;
> > > @@ -367,16 +370,33 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >  						    dw_chained_msi_isr, pp);
> > >  	}
> > >  
> > > -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > > -	if (ret)
> > > -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > 
> > > +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> > > +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> > > +		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
> > 
> > Note this capability flag has nothing to do with the DW PCIe iMSI-RX
> > engine, which is used here to detect and report MSI TLPs. By design
> > iMSI-RX always support 64-bit addresses. If you imply having that flag
> > set by the DW PCIe platform drivers on the platform-specific probe
> > stage as an indication of MSI address range, then ok.
> 

> The MSI cap shows that - AFAICS - the RP can be programmed with
> a 64-bit MSI(DMA) address. It is fair to say that this is not
> enough to guarantee that the DMA mask for the host bridge can be
> inferred to be 64-bit though.

iMSI-RX always supports 64-bit bus addresses by design. The
MSI-control CSRs are unconditionally permit having 64-bit address
setup. So you can't even synthesize the DW PCIe RP IP-core with only
32-bits MSI support. AFAICS what @William is introducing here is
MSI_FLAGS_64BIT usage as a flag, which could be manually set by the
platform drivers and would indicate that the platform driver permits
having 64-bit MSI TLPs. I guess the platforms are supposed to know
better which PCIe device are going to live on the bus and set that
flag accordingly. It isn't true of course without the bus
pre-scanning.

> 
> I am inclined to drop this patch (only) from the PCI queue because
> it is unclear to me whether it really does the right thing.

Let's wait for the Robin response for my last comment regarding the
patch 1 fate too.

-Sergey

> 
> Lorenzo
> 
> > > -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > -					GFP_KERNEL);
> > > -	if (!msi_vaddr) {
> > > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > > -		dw_pcie_free_msi(pp);
> > > -		return -ENOMEM;
> > > +	while (true) {
> > > +		dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
> > > +			retry_64bit ? "64" : "32");
> > 
> > > +		ret = dma_set_mask_and_coherent(dev, retry_64bit ?
> > > +						DMA_BIT_MASK(64) :
> > > +						DMA_BIT_MASK(32));
> > 
> > I'd suggest to just drop this. No DMA actually performed on getting the
> > MSI TLPs. So modifying the device DMA-mask due to something which
> > doesn't cause DMA and based on the flag which doesn't indicates the
> > device DMA-capability is at least inappropriate.
> > 
> > > +		if (ret)
> > > +			dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
> > > +				 retry_64bit ? "64" : "32");
> > > +
> > 
> > > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > +						GFP_KERNEL);
> > 
> > As I noted earlier the DMA-coherent memory can be too expensive. So
> > it's a waste of one allocating with no intent of usage. Instead of this
> > just get back the alloc_page() method here and pass the flag GFP_DMA32
> > to that function if MSI-capability reported the PCI_MSI_FLAGS_64BIT
> > unset.
> > 
> > -Sergey
> > 
> > > +		if (!msi_vaddr) {
> > > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > > +			if (msi_64bit && !retry_64bit) {
> > > +				retry_64bit = true;
> > > +				continue;
> > > +			}
> > > +
> > > +			dw_pcie_free_msi(pp);
> > > +			return -ENOMEM;
> > > +		}
> > > +		break;
> > >  	}
> > >  
> > >  	return 0;
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index c6725c519a47..650a7f22f9d0 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -82,6 +82,14 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
> > >  
> > > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
> > > +{
> > > +	u8 offset;
> > > +
> > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > > +	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > > +}
> > > +
> > >  static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> > >  					    u8 cap)
> > >  {
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index a871ae7eb59e..45fcdfc8c035 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -332,6 +332,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
> > >  
> > >  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> > >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
> > >  
> > >  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
> > >  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> > > -- 
> > > 2.37.2.672.g94769d06f0-goog
> > > 
> > > 
