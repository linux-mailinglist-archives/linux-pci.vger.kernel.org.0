Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A84E5828
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiCWSLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiCWSLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 14:11:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166788B17
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 11:09:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q5so2303833plg.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VAZZx4yARy2bKiWJUAHdWlVunec6BHxeT5QzHW1tg88=;
        b=PHbNOcWJhOiuq9FYpf2BLGL+KcJUD8yv398yfLyzaYJqcUZYygYK8VtrNRR/IoSEqU
         F3zb98OaADAGpiDgWbcBrG0JM7PoMDuATFYf3AG4eKzcqdL6jZ7uwm+YT2/uLWoWKvfT
         gazsEehP6guPSbnFmGMmgzDb3MM+rwqvRrskLhE2wNRNAXt5Vrc+tarwlbfJiZqHyfT4
         p5vD8QumOnCptAMJXSYnVlPaPoFfVAKLbR4HNdpeeSKToiArAkPt4x8MkG9EeINZSdiB
         oJlQRF0aJALatIOa/H4oS1vioSAqRq8Blf0iQUyIRHLqTEkc1OzWDHHvUPWbTadfCPqx
         QIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VAZZx4yARy2bKiWJUAHdWlVunec6BHxeT5QzHW1tg88=;
        b=tV5wjD9Imun8oIvcQAdzCwPway7N5rgeGORZH1dTXQyqJf4nShNXsxTxAV3iD7N8dY
         6fuYHgYBr5OfYSWTck50cIqfB5I1Jl2ZWSm7AyXCmHrl2vyY0aIoKjv17W2vFXjTuZdE
         KyAKyy3zv7xr6zkD2VjJC8dUvTEKLwIo9Uh+ip63ZU0Bno8fwHAJwZNjwdxxEv9Kjeu9
         idlw38+M+pbAFD+Kn/UCT2LULl5qKtfcj+enNR/+/ZB4iVD+M9zzWOxT1atL9HW/G9wr
         zAvTYZTRbauH8x3DgTWOBmN6cGKlb3r00snVQSYZAdG3ACnp2rmhGiMUcuy5aSgBC7Wr
         kz4w==
X-Gm-Message-State: AOAM532o+CcQ3psJ1kAgZrdHG55TQaLKYo4q7i+m2X+rdg2F+1VqY+7/
        nG7uPLFRo4go4whdicPbGaKT
X-Google-Smtp-Source: ABdhPJxRawOxfVPQ8IfHp83njNoGoQyDNWo8LB3IeXind2f3A8QUP7qFqLe6UFd7l3C0hlPvGyweAQ==
X-Received: by 2002:a17:90b:4d8e:b0:1c7:1e1f:484b with SMTP id oj14-20020a17090b4d8e00b001c71e1f484bmr13107731pjb.216.1648058984275;
        Wed, 23 Mar 2022 11:09:44 -0700 (PDT)
Received: from thinkpad ([220.158.158.25])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f66d50f054sm538127pfi.158.2022.03.23.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:09:43 -0700 (PDT)
Date:   Wed, 23 Mar 2022 23:39:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lorenzo.pieralisi@arm.com, Vidya Sagar <vidyas@nvidia.com>,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2] PCI: endpoint: Use blocking notifier instead of atomic
Message-ID: <20220323180939.GA81772@thinkpad>
References: <20220228055240.24774-1-manivannan.sadhasivam@linaro.org>
 <e151083b-c15a-7baa-3423-84bd1881105a@ti.com>
 <20220228062830.GA37219@thinkpad>
 <a66ccea3-b854-75d7-dc3d-6c9bb2057a0d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a66ccea3-b854-75d7-dc3d-6c9bb2057a0d@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Wed, Mar 09, 2022 at 10:07:47AM +0530, Kishon Vijay Abraham I wrote:
> Hi Mani,
> 
> On 28/02/22 11:58 am, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > On Mon, Feb 28, 2022 at 11:46:52AM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Manivannan,
> >>
> >> On 28/02/22 11:22 am, Manivannan Sadhasivam wrote:
> >>> The use of atomic notifier causes sleeping in atomic context bug when
> >>> the EPC core functions are used in the notifier chain. This is due to the
> >>> use of epc->lock (mutex) in core functions protecting the concurrent use of
> >>> EPC.
> >>
> >> The notification from the controller to the function driver is used for
> >> propagating interrupts to function driver and should be in interrupt context.
> >> How it should be handled maybe left to the function driver. I don't prefer
> >> moving everything to blocking notifier.
> >>
> > 
> > I agree that we need to handle it quick enough but I don't see any other valid
> > options to get rid of the issue. EPF driver may use a non-atomic notifier but
> > that seems to be an overkill workaround for something that could be fixed in the
> > EPC core.
> > 
> > And propagating interrupts is not going to work or needed all the time. Do you
> > forsee any issue with blocking notifier?
> 
> I think any interrupt to the EP should be delivered to the function driver in
> interrupt context, it could be function level reset interrupt, hot reset
> interrupt, link state interrupt etc., These are right now not supported but it
> will use the same notification mechanism to propagate interrupt from controller
> driver to function driver.
> 

In mainline, I can see only 2 users of this notifier:

1. pcie-tegra194
2. pcie-qcom-ep

In both drivers, CORE_INIT is called from a threaded irq handler so it is not
running in interrupt context. And the CORE_INIT of pci-epf-test driver is
calling EPC functions that could potentially sleep.

For LINK_UP, tegra driver is calling it from hard irq handler but the LINK_UP
of pci-epf-test driver is queueing up the delayed work. In the qcom driver,
LINK_UP is called from a threaded irq handler.

In both cases I don't see any necessity to use the atomic notifier chain.
I agree with you that the notification need to be passed from EPC to EPF asap,
but I'm not sure if it really has to be atomic.

Thanks,
Mani

> Thanks,
> Kishon
> 
> > 
> >> I'm wondering how other users for CORE_INIT didn't see this issue.
> > 
> > This can be triggered with EPF test or NTB if CONFIG_DEBUG_ATOMIC_SLEEP is
> > enabled.
> > 
> > Thanks,
> > Mani
> > 
> >>
> >> Thanks,
> >> Kishon
> >>
> >>>
> >>> So switch to blocking notifier for getting rid of the bug as it runs in
> >>> non-atomic context and allows sleeping in notifier chain.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>>
> >>> * Removed the changes related to non-upstreamed patches
> >>>
> >>>  drivers/pci/endpoint/pci-epc-core.c | 6 +++---
> >>>  include/linux/pci-epc.h             | 4 ++--
> >>>  2 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> >>> index 3bc9273d0a08..c4347f472618 100644
> >>> --- a/drivers/pci/endpoint/pci-epc-core.c
> >>> +++ b/drivers/pci/endpoint/pci-epc-core.c
> >>> @@ -693,7 +693,7 @@ void pci_epc_linkup(struct pci_epc *epc)
> >>>  	if (!epc || IS_ERR(epc))
> >>>  		return;
> >>>  
> >>> -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> >>> +	blocking_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(pci_epc_linkup);
> >>>  
> >>> @@ -710,7 +710,7 @@ void pci_epc_init_notify(struct pci_epc *epc)
> >>>  	if (!epc || IS_ERR(epc))
> >>>  		return;
> >>>  
> >>> -	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> >>> +	blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
> >>>  
> >>> @@ -774,7 +774,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
> >>>  
> >>>  	mutex_init(&epc->lock);
> >>>  	INIT_LIST_HEAD(&epc->pci_epf);
> >>> -	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
> >>> +	BLOCKING_INIT_NOTIFIER_HEAD(&epc->notifier);
> >>>  
> >>>  	device_initialize(&epc->dev);
> >>>  	epc->dev.class = pci_epc_class;
> >>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> >>> index a48778e1a4ee..04a2e74aed63 100644
> >>> --- a/include/linux/pci-epc.h
> >>> +++ b/include/linux/pci-epc.h
> >>> @@ -149,7 +149,7 @@ struct pci_epc {
> >>>  	/* mutex to protect against concurrent access of EP controller */
> >>>  	struct mutex			lock;
> >>>  	unsigned long			function_num_map;
> >>> -	struct atomic_notifier_head	notifier;
> >>> +	struct blocking_notifier_head	notifier;
> >>>  };
> >>>  
> >>>  /**
> >>> @@ -195,7 +195,7 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
> >>>  static inline int
> >>>  pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
> >>>  {
> >>> -	return atomic_notifier_chain_register(&epc->notifier, nb);
> >>> +	return blocking_notifier_chain_register(&epc->notifier, nb);
> >>>  }
> >>>  
> >>>  struct pci_epc *
> >>>
