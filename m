Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662543AA32D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhFPScc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhFPScb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 14:32:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A7C06175F
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 11:30:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso4551699pjb.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oMmBa/UenZSiz8FWRlUYJ1ApLColqphv5fT0ZtHZkco=;
        b=WKm6uhmxacLHEonEcSMaA5j3VxH+IMGkGzvLS3a/XOVz+YuDdJpchp0+D4dErQF2N4
         wonuPp+nUW/aooKV8wk4KPh0EYl+GrrdNV1YOFCiej81yxuvF4yh143YqjOuBaKn6Y+t
         sON6O3h5g4Hi9HtZBtcb1pOPR4F1/Ti3mSp2D+GhLV9l1nJ+e7W25FX356fw1PYVT+/l
         4UonLYns+/6oImensYAibJDoZiyOmYTRTiFO2QQQWJjHQNLfHmZeBBIZ+qNzgczk/3xz
         CLxdlkFimaa70/7+COb05076EcfTGenXgd5zn+C27dIvFgZNIQhiyaNzch7jmwhAlQ7k
         sGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMmBa/UenZSiz8FWRlUYJ1ApLColqphv5fT0ZtHZkco=;
        b=JOfY9lT6uR+DZXUhcrRlOicUy6MuFd1UkFs1K6HAqeHikWBtiBjg90rvbb+h8bpKAJ
         GFTWAXtj4OdPPo989iCuakHge0Qd8LHLQ7UvF8ILoVC2iRmupiGE42Qv5visns4D8wTe
         3RdQEe3JkoSclqBFgKDntOFZZW61aSRWC9H74wgdc4zrjadkFHOWqrwK7psyLdp7/cVD
         o2UGF/vVsUdBiyzRCCuhXcC+F5KtFJIDyjQnWPhIrIw1YGWCK2118mQ1pfUVTifZRi0n
         yJKIqSnFaIl3tHfVBAerIr6FniOHA1Ci1zjwlzSRUYAnU6Z6lZS6pt+1troDv7PUhMnD
         sDWA==
X-Gm-Message-State: AOAM533rhDvy3F3arJ5t+AWhqMelvbWSHIwvxA0Ymsxk36DjBIi1e5ry
        GAa80xz1wwtNsRhfu+o/yJ9A
X-Google-Smtp-Source: ABdhPJyqynxiYazXV5IbplMzPc2VHuctu11Dn+8ZNjUwy+usenSZ+jMti/oBrereusj21n+iGcgFEQ==
X-Received: by 2002:a17:90a:bd18:: with SMTP id y24mr12297762pjr.83.1623868223982;
        Wed, 16 Jun 2021 11:30:23 -0700 (PDT)
Received: from thinkpad ([2409:4072:17:2c05:a14f:78ce:1082:5556])
        by smtp.gmail.com with ESMTPSA id h4sm2881664pjv.55.2021.06.16.11.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:30:23 -0700 (PDT)
Date:   Thu, 17 Jun 2021 00:00:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org
Subject: Re: [PATCH 1/5] PCI: endpoint: Add linkdown notifier support
Message-ID: <20210616183017.GB152639@thinkpad>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
 <20210616115913.138778-2-manivannan.sadhasivam@linaro.org>
 <443ec752-08e2-83dd-2b6f-b5e74c7bd8e5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443ec752-08e2-83dd-2b6f-b5e74c7bd8e5@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 11:52:28PM +0530, Om Prakash Singh wrote:
> 
> 
> On 6/16/2021 5:29 PM, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Add support to notify the EPF device about the linkdown event from the
> > EPC device.
> > 
> > Usage:
> > ======
> > 
> > EPC
> > ---
> > 
> > ```
> > static irqreturn_t pcie_ep_irq(int irq, void *data)
> > {
> > ...
> >          case PCIE_EP_INT_LINK_DOWN:
> >                  pci_epc_linkdown(epc);
> >                  break;
> Can you provide use case/scenario when epc will get LINK_DOWN interrupt?
> 

During host shutdown/reboot epc will get LINK_DOWN interrupt. And in our MHI
function we need to catch that for handling the SYSERR state as per the spec.

Thanks,
Mani

> > ...
> > }
> > ```
> > 
> > EPF
> > ---
> > 
> > ```
> > static int pci_epf_notifier(struct notifier_block *nb, unsigned long val,
> >                              void *data)
> > {
> > ...
> >          case LINK_DOWN:
> >                  /* Handle link down event */
> >                  break;
> > ...
> > }
> > ```
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/endpoint/pci-epc-core.c | 17 +++++++++++++++++
> >   include/linux/pci-epc.h             |  1 +
> >   include/linux/pci-epf.h             |  1 +
> >   3 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index adec9bee72cf..f29d78c18438 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -641,6 +641,23 @@ void pci_epc_linkup(struct pci_epc *epc)
> >   }
> >   EXPORT_SYMBOL_GPL(pci_epc_linkup);
> > 
> > +/**
> > + * pci_epc_linkdown() - Notify the EPF device that EPC device has dropped the
> > + *                     connection with the Root Complex.
> > + * @epc: the EPC device which has dropped the link with the host
> > + *
> > + * Invoke to Notify the EPF device that the EPC device has dropped the
> > + * connection with the Root Complex.
> > + */
> > +void pci_epc_linkdown(struct pci_epc *epc)
> > +{
> > +       if (!epc || IS_ERR(epc))
> > +               return;
> > +
> > +       atomic_notifier_call_chain(&epc->notifier, LINK_DOWN, NULL);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_linkdown);
> > +
> >   /**
> >    * pci_epc_init_notify() - Notify the EPF device that EPC device's core
> >    *                        initialization is completed.
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index b82c9b100e97..23590efc13e7 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -202,6 +202,7 @@ void pci_epc_destroy(struct pci_epc *epc);
> >   int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
> >                      enum pci_epc_interface_type type);
> >   void pci_epc_linkup(struct pci_epc *epc);
> > +void pci_epc_linkdown(struct pci_epc *epc);
> >   void pci_epc_init_notify(struct pci_epc *epc);
> >   void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
> >                          enum pci_epc_interface_type type);
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 6833e2160ef1..e9ad634b1575 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -20,6 +20,7 @@ enum pci_epc_interface_type;
> >   enum pci_notify_event {
> >          CORE_INIT,
> >          LINK_UP,
> > +       LINK_DOWN,
> >   };
> > 
> >   enum pci_barno {
> > --
> > 2.25.1
> > 
