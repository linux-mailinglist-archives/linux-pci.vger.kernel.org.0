Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273456A8B8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiGGQ4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGGQ4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 12:56:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0275E248CE
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 09:56:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x184so7196031pfx.2
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1BT1AT3k3iZmUZypE3uU5mjcufGCXhMCCf//Wo7EMV0=;
        b=C6bwjOBD52gxx6jkELTtK27C7o3ITQe946fB8fjzS8ygN3RVGrh0hDzKQd/5woWYsE
         qTvSUaTh9ZDRbZ8bNYVIoU4dSWpJ/04NsVHJL5wpZ0rxdLRmhPJPgNjwhxl9txmyAGYn
         hlLvBlzMhojacIdcbt4Ta5XayLq48MWFeC2/5yJRj7iI2h0PVujwu3jSqJ6kSD4dC9dR
         PrO/ST/nzyMl4a8jz5CLtFH2nhCk8yfdKFY/r3deEVhmp2ZoiSObgF9jQk4FYx/i5yoh
         +KWj4h2jQ1BYsYJ1j8jVx7Lp5/r+BfI3pSPvbPp4OSntUuYFCHqoHoEIDsL8JJYOyaKM
         Qyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1BT1AT3k3iZmUZypE3uU5mjcufGCXhMCCf//Wo7EMV0=;
        b=wRYuR1N/V05KrKzLOmheWq0ayKXRuS6D8+gN6ZCufrzGmsjbPiK5cUMLHC/eF5YnM3
         hEWMLgWA9fbqO7pB0YtGIpyIl3CSkhvP2c6rkq0Umssp3Wtkmgi57fL2MDmuwBmqhP3G
         eiUu3oe3nJUt9JOB/lF+Pbujg5EgSml3fYRMqhWhgYGdku/77hAAsNmaTrp3DqYSTU9a
         8ADQ/aPCGGObo5y1rQ5+09/JL/HSoJLjDtFzSrW72mECxsy4Besi3G9WfePCsh8mkNLT
         C+HOaMBHpvvVK4Db3IcDR1yKxSuDqLZVBrCG4+nGZL21xNWTodydJcN+VhWEBVI9Wykn
         p5OA==
X-Gm-Message-State: AJIora9E2TDoQaMy75Rwm/fh98ylgkt3Y4wYcKmK04lGaMxbzW+BGS5W
        SYtVgafezeVrjprrGCvk7o2V
X-Google-Smtp-Source: AGRyM1tWAmuv/zDzk386/V8vG5C1HmB4rlyeJWlBag0dj/uxPpxeuWGA2XXBKCFE4zTbAzH6I61Swg==
X-Received: by 2002:a63:d54c:0:b0:412:562e:6964 with SMTP id v12-20020a63d54c000000b00412562e6964mr16815009pgi.528.1657212963414;
        Thu, 07 Jul 2022 09:56:03 -0700 (PDT)
Received: from thinkpad ([117.207.26.37])
        by smtp.gmail.com with ESMTPSA id b123-20020a621b81000000b00528c22fbb45sm2927241pfb.141.2022.07.07.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:56:03 -0700 (PDT)
Date:   Thu, 7 Jul 2022 22:25:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220707165556.GA5458@thinkpad>
References: <20220622040133.31058-1-vidyas@nvidia.com>
 <5c36260c-6bb6-7eb5-be82-c60cd927c02d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c36260c-6bb6-7eb5-be82-c60cd927c02d@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jul 07, 2022 at 02:39:08PM +0530, Vidya Sagar wrote:
> Hi,
> Anyone has review comments for this change?
> Without this change, Tegra194's endpoint mode is effectively broken.
> 

I submitted a patch that fixes this issue in March and I did CC you on that.
https://lore.kernel.org/lkml/20220330060515.22328-1-manivannan.sadhasivam@linaro.org/

That patch incorporated comments from Kishon on the previous patch from
Kunihiko Hayashi. But there was no response afterwards.

Thanks,
Mani

> Thanks & Regards,
> Vidya Sagar
> 
> On 6/22/2022 9:31 AM, Vidya Sagar wrote:
> > Platforms that cannot support their core initialization without the
> > reference clock from the host, implement the feature 'core_init_notifier'
> > to indicate the DesignWare sub-system about when their core is getting
> > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > core to dw_pcie_ep_init_complete() API which is effectively called only
> > after the core initialization.
> > 
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >   .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
> >   1 file changed, 49 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 0eda8236c125..9feec720175f 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> >   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >   {
> >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct dw_pcie_ep_func *ep_func;
> > +	struct device *dev = pci->dev;
> > +	struct pci_epc *epc = ep->epc;
> >   	unsigned int offset;
> >   	unsigned int nbars;
> >   	u8 hdr_type;
> > +	u8 func_no;
> > +	void *addr;
> >   	u32 reg;
> >   	int i;
> > @@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >   		return -EIO;
> >   	}
> > +	dw_pcie_iatu_detect(pci);
> > +
> > +	ep->ib_window_map = devm_kcalloc(dev,
> > +					 BITS_TO_LONGS(pci->num_ib_windows),
> > +					 sizeof(long),
> > +					 GFP_KERNEL);
> > +	if (!ep->ib_window_map)
> > +		return -ENOMEM;
> > +
> > +	ep->ob_window_map = devm_kcalloc(dev,
> > +					 BITS_TO_LONGS(pci->num_ob_windows),
> > +					 sizeof(long),
> > +					 GFP_KERNEL);
> > +	if (!ep->ob_window_map)
> > +		return -ENOMEM;
> > +
> > +	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > +			    GFP_KERNEL);
> > +	if (!addr)
> > +		return -ENOMEM;
> > +	ep->outbound_addr = addr;
> > +
> > +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > +		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > +		if (!ep_func)
> > +			return -ENOMEM;
> > +
> > +		ep_func->func_no = func_no;
> > +		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > +							      PCI_CAP_ID_MSI);
> > +		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > +							       PCI_CAP_ID_MSIX);
> > +
> > +		list_add_tail(&ep_func->list, &ep->func_list);
> > +	}
> > +
> >   	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> >   	dw_pcie_dbi_ro_wr_en(pci);
> > @@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> >   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   {
> >   	int ret;
> > -	void *addr;
> > -	u8 func_no;
> >   	struct resource *res;
> >   	struct pci_epc *epc;
> >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > @@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   	struct platform_device *pdev = to_platform_device(dev);
> >   	struct device_node *np = dev->of_node;
> >   	const struct pci_epc_features *epc_features;
> > -	struct dw_pcie_ep_func *ep_func;
> >   	INIT_LIST_HEAD(&ep->func_list);
> > @@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   		}
> >   	}
> > -	dw_pcie_iatu_detect(pci);
> > -
> >   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> >   	if (!res)
> >   		return -EINVAL;
> > @@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   	ep->phys_base = res->start;
> >   	ep->addr_size = resource_size(res);
> > -	ep->ib_window_map = devm_kcalloc(dev,
> > -					 BITS_TO_LONGS(pci->num_ib_windows),
> > -					 sizeof(long),
> > -					 GFP_KERNEL);
> > -	if (!ep->ib_window_map)
> > -		return -ENOMEM;
> > -
> > -	ep->ob_window_map = devm_kcalloc(dev,
> > -					 BITS_TO_LONGS(pci->num_ob_windows),
> > -					 sizeof(long),
> > -					 GFP_KERNEL);
> > -	if (!ep->ob_window_map)
> > -		return -ENOMEM;
> > -
> > -	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > -			    GFP_KERNEL);
> > -	if (!addr)
> > -		return -ENOMEM;
> > -	ep->outbound_addr = addr;
> > -
> >   	if (pci->link_gen < 1)
> >   		pci->link_gen = of_pci_get_max_link_speed(np);
> > @@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   	if (ret < 0)
> >   		epc->max_functions = 1;
> > -	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > -		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > -		if (!ep_func)
> > -			return -ENOMEM;
> > -
> > -		ep_func->func_no = func_no;
> > -		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > -							      PCI_CAP_ID_MSI);
> > -		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > -							       PCI_CAP_ID_MSIX);
> > -
> > -		list_add_tail(&ep_func->list, &ep->func_list);
> > -	}
> > -
> >   	if (ep->ops->ep_init)
> >   		ep->ops->ep_init(ep);
> > @@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   			return 0;
> >   	}
> > +	/*
> > +	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> > +	 * step as platforms that implement 'core_init_notifier' feature may
> > +	 * not have the hardware ready (i.e. core initialized) for access
> > +	 * (Ex: tegra194). Any hardware access on such platforms result
> > +	 * in system hard hang.
> > +	 */
> > +
> >   	return dw_pcie_ep_init_complete(ep);
> >   }
> >   EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > 

-- 
மணிவண்ணன் சதாசிவம்
