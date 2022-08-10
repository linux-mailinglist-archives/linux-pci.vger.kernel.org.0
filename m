Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9004A58F4A5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 01:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiHJXJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 19:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiHJXJ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 19:09:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA1474CD6
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 16:09:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so4183577pjz.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 16:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IYUblAxSUIQ6YomS6SAe7QOiq/9tC9/LzRRTchU+IxE=;
        b=qns1rAkQK4/otY2irw1U49E0MjSMaYOnuN2cHpSDDAsxpMr5u17jjwVx4NNtrzv+xg
         OWMBGgJzYQB0Hx1dcA5B0UmbJLjUz3WsHnMhVE34YBV1OmOax2W/IllnQYCXiCp4tJ+c
         PHGI4k4jNCgim+Dq8Gf8KGrhxi666WBzad/d6WV7XjVvIIhbHu17sYLa6DFSYK3/V2rC
         3NBLay8W0CEyJDEcPwKl/c/vVhVqdACgwG2wtW003/T1zSkBO5KoZJavO8sWBarQQVbO
         jOzh54JGwiNErNmr+Zg8EzOvHDiEhEvBGDvZYFfh4QVD6U1dIEGtLHROGWM/9Dq520V4
         LHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IYUblAxSUIQ6YomS6SAe7QOiq/9tC9/LzRRTchU+IxE=;
        b=IRVJOwe4PdiNxOZHK8N6qOb2o3vry7n0aJQEFbLdYVIy8oN28yd2eLCUgJh4X0XlMc
         Apcb5xL5fcQPCekXKP/p5JDKL7zQiOOrCfhwlTW12OXNnYfqC+KITkmRExPwPM4yWoz1
         fOxGLj2CM+AToMrkbMIcc+DOYwhXooz2rMHDeKznGsqSHv9S0aXzR5ucANgZgGGRX0H7
         0F5By5RZHFvUwXyY7j5gwkOk2FxNaTAB7ULaRZ5ekYFSvcxPykPkZwgFG0jRIYoVj22z
         h04JB+CtPQIKByZqIPQbEkNoq6VFlK1ai8GIyZAvqozP7TEQdXO8b/PRs98/1U43rOP/
         P3Dg==
X-Gm-Message-State: ACgBeo2NBoJij08zc6mpBPxVdECbccqeIew4jBP0AcyGZrKIbMFh/Bdp
        IzN8TBeSNrHm+cWOrQaYWL+DQQ==
X-Google-Smtp-Source: AA6agR6JUfKOK+mhbI8Ko7mE/jyEfI9bwxECCepOgB5bm4ykAknGjBW2rMQOY5FxSZiIH3VjLhL0Xw==
X-Received: by 2002:a17:902:d546:b0:16e:c70c:fdf5 with SMTP id z6-20020a170902d54600b0016ec70cfdf5mr30428690plf.100.1660172967179;
        Wed, 10 Aug 2022 16:09:27 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id s4-20020aa78bc4000000b0052d82ce65a9sm2631701pfd.143.2022.08.10.16.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:09:26 -0700 (PDT)
Date:   Wed, 10 Aug 2022 23:09:22 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: drop dependency on ZONE_DMA32
Message-ID: <YvQ6ohi0SumTAt/s@google.com>
References: <20220810183536.1630940-1-willmcvicker@google.com>
 <20220810183536.1630940-2-willmcvicker@google.com>
 <20220810212716.GA557589-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810212716.GA557589-robh@kernel.org>
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

On 08/10/2022, Rob Herring wrote:
> On Wed, Aug 10, 2022 at 06:35:34PM +0000, Will McVicker wrote:
> > Re-work the msi_msg DMA allocation logic to use dma_alloc_coherent()
> > which uses the coherent DMA mask to try and return an allocation within
> > the DMA mask limits. This allows kernel configurations that disable
> > ZONE_DMA32 to continue supporting a 32-bit DMA mask. Without this patch,
> > the PCIe host device will fail to probe when ZONE_DMA32 is disabled.
> > 
> > Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
> > Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 23 ++++++++-----------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 7746f94a715f..8f2222f51671 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -272,9 +272,9 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> >  		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >  		struct device *dev = pci->dev;
> >  
> > -		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
> > -		if (pp->msi_page)
> > -			__free_page(pp->msi_page);
> > +		dma_free_coherent(dev, PAGE_SIZE, pp->msi_page, pp->msi_data);
> > +		pp->msi_data = 0;
> > +		pp->msi_page = NULL;
> >  	}
> >  }
> >  
> > @@ -375,22 +375,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  						    dw_chained_msi_isr, pp);
> >  	}
> >  
> > -	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >  	if (ret)
> >  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> >  
> > -	pp->msi_page = alloc_page(GFP_DMA32);
> > -	pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
> > -				    PAGE_SIZE, DMA_FROM_DEVICE);
> > -	ret = dma_mapping_error(dev, pp->msi_data);
> > -	if (ret) {
> > -		dev_err(pci->dev, "Failed to map MSI data\n");
> > -		__free_page(pp->msi_page);
> > -		pp->msi_page = NULL;
> > +	pp->msi_page = dma_alloc_coherent(dev, PAGE_SIZE, &pp->msi_data,
> > +					  GFP_KERNEL);
> 
> You can use the managed version, dmam_alloc_coherent(), and avoid the 
> freeing yourself. Also with that, I think you don't need 'msi_page'?
> 
> Also, no need to alloc a whole page. A u32 or u64? should be fine. The 
> write never makes it to memory, so doesn't really matter.
> 
> > +	if (!pp->msi_page) {
> > +		dev_err(dev, "Failed to alloc and map MSI data\n");
> >  		pp->msi_data = 0;
> >  		dw_pcie_free_msi(pp);
> > -
> > -		return ret;
> > +		return -ENOMEM;
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.37.1.559.g78731f0fdb-goog
> > 

Thanks for the review Rob! I've updated the series to address your concerns.

Regards,
Will
