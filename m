Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937C360FCAA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 18:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiJ0QJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 12:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiJ0QJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 12:09:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26B6356
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 09:09:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so6928777pji.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cs6Se82l4PDsSj9I2mLI3f+GZ/GJF+Opr2Jjis5B+58=;
        b=gr/x3Rmw+ft/dWHSYXxVElM0ozip0qNvQoiaAb7SE3U23IY75AgH/lPJDcqT0638Ts
         KreY/MOQbHmTECj/j0eOSRu2dYoVj8QWWkrdhhF0zwCgqMm4Vb2P+VSLd/ZOEOdLpvPw
         N3cXmnt7x8itiPJ83eQQdCPR102fH5oJvdYV8Km7l48+hRK+ZiJbHT9YL9biHiH4gRGG
         pNRa2Dwd5DMHE8olSf37Q54BHys2n/JF58TJC1E34xWi6p61LXWrt4NXDGqzBv19Vj3f
         zw0eE/aO+D6k3bNTuYNBx5y+1k1QHVXR5642U/tDnaMj5t4/CuDfFZOvDrUnIfcDLroJ
         Yl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs6Se82l4PDsSj9I2mLI3f+GZ/GJF+Opr2Jjis5B+58=;
        b=HYLsCRrS+fn9Ab2Bhyqjs9jbXdnyll72XYKoFm1ox45xaNfdsUN+cX0iRXXJD2EG4Q
         oqzLumi4EqHXAE5PJ7Net2FqTf+R+53vv8L0OiwLfFF13HLm4m+HOL9NtEX5zTZMURGh
         XbwQs1f0B6LMbRFlrzq5fh4SsppYEfjFmdQ2vQNLLuejCqTXvYLmViZoMUlKRrGnQxSl
         0mLEqgCOXX+Sb/vOzi4ljv9q+k2hO9WtxDZd9GJStrPakAiDAnMlKWa0pIXjpQDWGGV/
         Vd7WLwrG4JFLcI86PtLD2qOWDydtk7gqO1/4fh0aeIo7S7cgfCtbvSHSdHj6AI/5DG24
         dcJQ==
X-Gm-Message-State: ACrzQf19XgDUPRR30na/qaTm6587xhQdW27SpusYa957dbZfMuubKCLe
        Ku/FgT+0GkJk0n+4oGL/gAKH
X-Google-Smtp-Source: AMsMyM53JceTu9c/G4onEt7iCb9cuuRM2cwy18Blh80zUk9iUEs6nhRalt+MMq6PmBPGozyinxPUNQ==
X-Received: by 2002:a17:902:f684:b0:17f:95cc:af8 with SMTP id l4-20020a170902f68400b0017f95cc0af8mr50148643plg.91.1666886979301;
        Thu, 27 Oct 2022 09:09:39 -0700 (PDT)
Received: from thinkpad ([117.202.186.162])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902cec100b0018661d627d7sm1410039plg.59.2022.10.27.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 09:09:38 -0700 (PDT)
Date:   Thu, 27 Oct 2022 21:39:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, kishon@kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Message-ID: <20221027160932.GD76627@thinkpad>
References: <20220922092357.123732-1-mie@igel.co.jp>
 <20221025142143.GA109941@thinkpad>
 <HE1PR0401MB233126D2C7410EC5F6C3976488319@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjnbZMzFJt8kBtQz6FHc_QQYw7=fZp8kK87mZ-t75z+g@mail.gmail.com>
 <HE1PR0401MB23319EE329D62420919740C688339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221027151220.GC76627@thinkpad>
 <HE1PR0401MB233111DEC8F76341029183F188339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0401MB233111DEC8F76341029183F188339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Added Kishon's new email address and removed the old one]

On Thu, Oct 27, 2022 at 03:34:11PM +0000, Frank Li wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Thursday, October 27, 2022 10:12 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: Shunsuke Mie <mie@igel.co.jp>; Jon Mason <jdmason@kudzu.us>; Dave
> > Jiang <dave.jiang@intel.com>; Allen Hubbe <allenbh@gmail.com>; Kishon
> > Vijay Abraham I <kishon@ti.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>;
> > Krzysztof Wilczyński <kw@linux.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; ntb@lists.linux.dev; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check for
> > no epc alignment constraint
> > 
> > Caution: EXT Email
> > 
> > On Thu, Oct 27, 2022 at 02:35:56PM +0000, Frank Li wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Shunsuke Mie <mie@igel.co.jp>
> > > > Sent: Wednesday, October 26, 2022 8:43 PM
> > > > To: Frank Li <frank.li@nxp.com>
> > > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Jon
> > > > Mason <jdmason@kudzu.us>; Dave Jiang <dave.jiang@intel.com>; Allen
> > > > Hubbe <allenbh@gmail.com>; Kishon Vijay Abraham I <kishon@ti.com>;
> > > > Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczyński
> > > > <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > > > ntb@lists.linux.dev; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > > > Subject: Re: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
> > for
> > > > no epc alignment constraint
> > > >
> > > > Caution: EXT Email
> > > >
> > > > Hi Frank,
> > > >
> > > > 2022年10月26日(水) 1:07 Frank Li <frank.li@nxp.com>:
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > Sent: Tuesday, October 25, 2022 9:22 AM
> > > > > > To: Shunsuke Mie <mie@igel.co.jp>
> > > > > > Cc: Jon Mason <jdmason@kudzu.us>; Dave Jiang
> > <dave.jiang@intel.com>;
> > > > > > Allen Hubbe <allenbh@gmail.com>; Kishon Vijay Abraham I
> > > > > > <kishon@ti.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof
> > > > > > Wilczyński <kw@linux.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > > > > > ntb@lists.linux.dev; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > > > Subject: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
> > for
> > > > no
> > > > > > epc alignment constraint
> > > > > >
> > > > > > Caution: EXT Email
> > > > > >
> > > > > > On Thu, Sep 22, 2022 at 06:23:57PM +0900, Shunsuke Mie wrote:
> > > > > > > Some PCI endpoint controllers have no alignment constraints, and
> > the
> > > > > > > epc_features->align becomes 0. In this case, IS_ALIGNED() in
> > > > >
> > > > > [Frank Li] why not set epc_features->align 1
> > > > > no alignment constraints should mean align to byte.
> > > > It is one of the solutions too I think. But in that case,  we need to
> > > > write epc_features->align = 1 to all epc drivers, dwc, qcom, rcar,
> > > > tegra, and etc.
> > > >
> > > > I think that my change is better.
> > >
> > > I think it should be based on what original term defined.
> > > It should be fixed at where make mistake.
> > >
> > 
> > 1byte is the default alignment that drivers can assume, why do you want
> > drivers
> > to set them explicitly when they do not want any special alignment?
> 
> What's definition of not alignment by align variable?
> Using both 0 and 1 as no alignment is not good enough. 
> 
> I grep whole kernel driver directory, not one use 
> 	If (align && IS_ALIGNED(x, align))  statement.    

I can see multiple hits:

lib/ubsan.c
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
drivers/gpu/drm/i915/i915_vma.c
drivers/nvdimm/pfn_devs.c
drivers/misc/pci_endpoint_test.c

But in most of the places, the alignment is guaranteed to be set by the client
drivers because they might be read from the hardware register or fixed for an
IP. But in this case, I don't think we should _force_ the drivers to set
alignment to 1 (default) if they don't really care about it.

Thanks,
Mani

> 
> There are a common convention, align is 2^n
> 
> 
> > 
> > I think this patch is fine.
> > 
> > Thanks,
> > Mani
> > 
> > > Are there other place use align == 0 means no alignment in kernel?
> > >
> > > >
> > > > > > > epf_ntb_config_spad_bar_alloc() doesn't work well. Check for this
> > > > before
> > > > > > > IS_ALIGNED().
> > > > > > >
> > > > > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > > > >
> > > > > > Reviewed-by: Manivannan Sadhasivam
> > > > > > <manivannan.sadhasivam@linaro.org>
> > > > > >
> > > > > > Thanks,
> > > > > > Mani
> > > > > >
> > > > > > > ---
> > > > > > > Changes in v2:
> > > > > > > * Fix the commit message in phrasings and words.
> > > > > > > ---
> > > > > > > ---
> > > > > > >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
> > > > > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
> > > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > > > > b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > > > > > index 9a00448c7e61..f74155ee8d72 100644
> > > > > > > --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > > > > > > @@ -1021,7 +1021,7 @@ static int
> > > > epf_ntb_config_spad_bar_alloc(struct
> > > > > > epf_ntb *ntb,
> > > > > > >       peer_size = peer_epc_features->bar_fixed_size[peer_barno];
> > > > > > >
> > > > > > >       /* Check if epc_features is populated incorrectly */
> > > > > > > -     if ((!IS_ALIGNED(size, align)))
> > > > > > > +     if (align && (!IS_ALIGNED(size, align)))
> > > > > > >               return -EINVAL;
> > > > > > >
> > > > > > >       spad_count = ntb->spad_count;
> > > > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > > index 0ea85e1d292e..5e346c0a0f05 100644
> > > > > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > > > @@ -418,7 +418,7 @@ static int
> > epf_ntb_config_spad_bar_alloc(struct
> > > > > > epf_ntb *ntb)
> > > > > > >       size = epc_features->bar_fixed_size[barno];
> > > > > > >       align = epc_features->align;
> > > > > > >
> > > > > > > -     if ((!IS_ALIGNED(size, align)))
> > > > > > > +     if (align && !IS_ALIGNED(size, align))
> > > > > > >               return -EINVAL;
> > > > > > >
> > > > > > >       spad_count = ntb->spad_count;
> > > > > > > --
> > > > > > > 2.17.1
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > மணிவண்ணன் சதாசிவம்
> > > >
> > > > Best,
> > > > Shunsuke
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
