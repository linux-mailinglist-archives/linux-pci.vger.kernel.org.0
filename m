Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF165A18E3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbiHYSjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 14:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbiHYSjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 14:39:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896359DFBD
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 11:39:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v23so13974824plo.9
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BS8mf7vr1cRbY/T9F78iHhpM5J/Ne5HpcQ0z+u0SBPE=;
        b=IOotYEkZJnUHQQFBqXqRknuO2poclGrF0tnKTPKFSU/u+3AVSgkjO2U++U8ulxrWEa
         3J6imEozR4oCV4XOa+P11VEcM/CV8rKJ+ajK1+0UZ+pJEAuspky4R9vbNpMZv4Hc7NfU
         Nrf52g2Tjs/kf93DpXZcjTbTXfJ8pZdlbozBxRkbh0VcAheQj+rYWgKJGO26eC4Yn5lt
         +KXdOE1S+JnRcluG3YDLN4M6nKTDzjmRCt8uuEtHcoaNg9STFN5HoJwhKljBwm7hcDJH
         Z8vLNpT/ogYxV6HE+y4WrR31qBpY8+Hhf9fP+Wy0wRbz3GapgC5Ni8INjGhDGnURigRh
         s9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BS8mf7vr1cRbY/T9F78iHhpM5J/Ne5HpcQ0z+u0SBPE=;
        b=FCCN/fQLN7PMBoeURg058oq8KZ5iUu+AE1O5hAbFP9n83TtYEDlHYHFny22pTnBn3g
         VTStfq85fGuOcxl1NM5J/QRYStV96EhZobGdrsVunG9R5tB1PrJYqW1sX40N4zr9D3Nd
         Ly1M9X/BUc/hqfz1tz+XHzvpE9n95jZCQin6KAmoaoEfUYrcxPznPX+t6H8EW58DSBzS
         FXhhfTVipoLYsc3PfqI0IHUmWkko8PWUHwddH3cpVt/oZbKZSF5Buq8fVCqmXOgp3eJ5
         EstoumGMp6KDZznaXXnjlgNup86/rLvJq5/mb3rVqUyJ2+ZmwduBfm/WZSIZUw5l+Nm7
         Abiw==
X-Gm-Message-State: ACgBeo2YrE435ToSmYxN+gZSFnWm2r57jvoDMcEkwdNMKOC831o1szP7
        fhXW+dybwk0m1UovpC7jWnv6kQ==
X-Google-Smtp-Source: AA6agR6It6OBHlgY6R6McDPq8cavZOGWnTCMsJysi7o10F8mX0y1+pMyrco0crpU45idH/QgUWFq7A==
X-Received: by 2002:a17:90b:3c82:b0:1fb:8ef:5ddb with SMTP id pv2-20020a17090b3c8200b001fb08ef5ddbmr437191pjb.11.1661452747391;
        Thu, 25 Aug 2022 11:39:07 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7951a000000b00537b3b1422dsm261132pfp.102.2022.08.25.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:39:06 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:39:03 +0000
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
Subject: Re: [PATCH v4 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Message-ID: <YwfBx0q1UZVsyULD@google.com>
References: <20220812000327.3154251-1-willmcvicker@google.com>
 <20220812000327.3154251-3-willmcvicker@google.com>
 <1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com>
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

On 08/23/2022, Robin Murphy wrote:
> On 2022-08-12 01:03, Will McVicker wrote:
> > Since not all devices require a 32-bit MSI address, add support to the
> > PCIe host driver to allow setting the DMA mask to 64-bits. This allows
> > kernels to disable ZONE_DMA32 and bounce buffering (swiotlb) without
> > risking not being able to get a 32-bit address during DMA allocation.
> > Basically, in the slim chance that there are no 32-bit allocations
> > available, the current PCIe host driver will fail to allocate the
> > msi_msg page due to a DMA address overflow (seen in [1]). With this
> > patch, the PCIe device can advertise 64-bit support via its MSI
> > capabilities to hint to the PCIe host driver to set the DMA mask to
> > 64-bits.
> 
> It doesn't matter so much what the host's own capabilities are, though, what
> matters is that if you configure the MSI doorbell to decode some 64-bit
> address because you can, and later an endpoint shows up whose DMA mask
> doesn't reach that address, you've broken MSIs for that endpoint. While the
> host is probing, it cannot possibly know what future endpoint drivers may or
> may not do.
> 
> Now, in the case where no ZONE_DMA{32} is configured, there's a fair
> likelihood that addressing-constrained endpoints are probably going to be
> broken in general, so that should not be fatal for the host. So *if* we fail
> to allocate a 32-bit MSI address, *then* we should fall back to a 64-bit one
> (when the host supports it), but to preserve compatibility we still must
> always attempt the 32-bit allocation first (oh, if there isn't a theme
> emerging here...)
> 
> TBH this has come up enough times, and has enough subtle complexity, that I
> think it's high time to factor this all out into a helper between the PCI
> core code and the DMA API for "please give me a bus address that's
> guaranteed not to conflict with any valid DMA address".
> 
> Thanks,
> Robin.

Hi Robin,

Thanks for the reviews! I'm happy with your suggestion of trying a 32-bit mask
first for the reasons you mentioned. I have tested this out on my Pixel 6 and
db845c and will push the updated patchset as v5.

Regards,
Will

> 
> > [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++++++--
> >   drivers/pci/controller/dwc/pcie-designware.c      |  8 ++++++++
> >   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
> >   3 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 39f3b37d4033..d7831040791b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -330,6 +330,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >   	u64 *msi_vaddr;
> >   	int ret;
> >   	u32 ctrl, num_ctrls;
> > +	bool msi_64bit = false;
> > +	u16 msi_capabilities;
> >   	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> >   		pp->irq_mask[ctrl] = ~0;
> > @@ -367,9 +369,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >   						    dw_chained_msi_isr, pp);
> >   	}
> > -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> > +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> > +		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
> > +
> > +	dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
> > +		msi_64bit ? "64" : "32");
> > +	ret = dma_set_mask_and_coherent(dev, msi_64bit ?
> > +					DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> >   	if (ret)
> > -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > +		dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
> > +			 msi_64bit ? "64" : "32");
> >   	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> >   					GFP_KERNEL);
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
