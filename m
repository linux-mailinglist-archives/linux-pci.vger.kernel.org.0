Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A730B3A83B6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhFOPOM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFOPOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 11:14:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DBFC061767
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 08:12:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v7so2969176pgl.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eu/8Z6gF7JMgCtFuTXnnRycRhPLQbvQUaq3zZY+wYG0=;
        b=SJZxKifR/KdssaCl7Xuxy5Wc63x9pUUuC12pTPG9yZtMaOC5+YB3WDTtjSWcC5GLxF
         Ba6TXcDveT+Kl+TCdNFiIHc6tYsS+8RO9U9Txk08A/lHzBHZkihoLcjvYIToJglwpyP+
         S19Lwq0NuSlgcYC87JkPJ1a0xyGKJotYJ7YGooXrs74kaewDmb8t36+oSAkrg/03+iKD
         9mE5PTA7Le/RQQsm9SbgPcKy+3eYyIPBAufm4H1yfX5YJgbrPVod+04ktbg+cgObHDgy
         EAvbDf/BgDgjBwMiglN0b/v7EzzGJl7Fv72qc9Lu/Uuk8+q5SvNT//+Vbd2zXNNhNoJ0
         CH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eu/8Z6gF7JMgCtFuTXnnRycRhPLQbvQUaq3zZY+wYG0=;
        b=XDL++DYaJY0cvrwvfL7sRssszIUr5aINLa4564tYwvCY8WCu9ncLFkiBztWiKTpTDf
         WgeuobwfOl861ZVEhrdKUZ6w0uGqjVOT12uNb6t3UIGIcYtyVO4OoBC7lwj5fShfSNpO
         ZYKIaGuQsQ/3VMiUXTnNchiKKB/1wShQfwWSnqZtp61xWP2/H/AtgB/SmlwH7kToEYt0
         8FDSFwQ5KLrHYDw9KTXH2N+0UQ+m1OYSZn94Xx2XiHH/b7Z0l8ArXcf/WjcKKQjaBXZw
         YC/Bqy7WUlTYE4SO/WvgRv1I6DZnXsl78KyNJ2eAs5vJ/u/5WhkdsRqIVn2EMdR7pqeF
         /vBw==
X-Gm-Message-State: AOAM532Q/Ir1Y11D4hsuNvyWzt1guJPT46jkKY7MBPLxmVTk0/juqqBx
        d6+yZs51hMQCIFstrTwUfKf7
X-Google-Smtp-Source: ABdhPJwbVbM/owpKFGfN2MXaqBf7f5OdgZx94yrXHbdl1FI8U+Ee4yH5VVInD44kx6K5Jh90apl7dQ==
X-Received: by 2002:a62:5b41:0:b029:2cb:70a7:a8ce with SMTP id p62-20020a625b410000b02902cb70a7a8cemr4921093pfb.77.1623769926326;
        Tue, 15 Jun 2021 08:12:06 -0700 (PDT)
Received: from thinkpad ([2409:4072:85:d63b:767d:943:faf7:b89d])
        by smtp.gmail.com with ESMTPSA id h8sm2376683pgc.60.2021.06.15.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:12:05 -0700 (PDT)
Date:   Tue, 15 Jun 2021 20:41:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org
Subject: Re: [PATCH] PCI: endpoint: Add custom notifier support
Message-ID: <20210615151158.GA93671@thinkpad>
References: <20210615133704.88169-1-manivannan.sadhasivam@linaro.org>
 <9021212f-aa5d-770d-c455-c632dd79e7f8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9021212f-aa5d-770d-c455-c632dd79e7f8@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Tue, Jun 15, 2021 at 08:31:48PM +0530, Kishon Vijay Abraham I wrote:
> Hi Manivannan,
> 
> On 15/06/21 7:07 pm, Manivannan Sadhasivam wrote:
> > Add support for passing the custom notifications between the endpoint
> > controller and the function driver. This helps in passing the
> > notifications that are more specific to the controller and corresponding
> > function driver. The opaque `data` arugument in pci_epc_custom_notify()
> > function can be used to carry the event specific data that helps in
> > differentiating the events.
> > 
> > For instance, the Qcom EPC device generates specific events such as
> > MHI_A7, BME, DSTATE_CHANGE, PM_TURNOFF etc... These events needs to be
> > passed to the function driver for proper handling. Hence, this custom
> > notifier can be used to pass these events.
> 
> Bus master enable and PME events sounds generic events and not QCOM
> specific.

Yes, that's correct! I thought about adding the notifiers for them but not sure
about the convetion in EP stack. So went with an opaque notifier but I don't
have any issue in adding them.

> Also this patch should be sent along with how it's going to be
> used in function driver.
> 

The function driver which is going to use this notifier is under development but
I can share a snippet if that helps.

> In general my preference would be to add only well defined notifiers
> given that the endpoint function drivers are generic.
> 

Not all functions are generic ones. For example, on Qcom modems there is a MHI
function driver which transports the IP packets to the host and talks to the
MHI host stack[1].

So for sure we need to have a custom notifier for vendor specific events.

Thanks,
Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi

> Thanks
> Kishon
> 
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 19 +++++++++++++++++++
> >  include/linux/pci-epc.h             |  1 +
> >  include/linux/pci-epf.h             |  1 +
> >  3 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index adec9bee72cf..86b6934c6297 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -658,6 +658,25 @@ void pci_epc_init_notify(struct pci_epc *epc)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_init_notify);
> >  
> > +/**
> > + * pci_epc_custom_notify() - Notify the EPF device about the custom events
> > + *			     in the EPC device
> > + * @epc: EPC device that generates the custom notification
> > + * @data: Data for the custom notifier
> > + *
> > + * Invoke to notify the EPF device about the custom events in the EPC device.
> > + * This notifier can be used to pass the EPC specific custom events that are
> > + * shared with the EPF device.
> > + */
> > +void pci_epc_custom_notify(struct pci_epc *epc, void *data)
> > +{
> > +	if (!epc || IS_ERR(epc))
> > +		return;
> > +
> > +	atomic_notifier_call_chain(&epc->notifier, CUSTOM, data);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_custom_notify);
> > +
> >  /**
> >   * pci_epc_destroy() - destroy the EPC device
> >   * @epc: the EPC device that has to be destroyed
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index b82c9b100e97..13140fdbcdf6 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -203,6 +203,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
> >  		    enum pci_epc_interface_type type);
> >  void pci_epc_linkup(struct pci_epc *epc);
> >  void pci_epc_init_notify(struct pci_epc *epc);
> > +void pci_epc_custom_notify(struct pci_epc *epc, void *data);
> >  void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
> >  			enum pci_epc_interface_type type);
> >  int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 6833e2160ef1..8d740c5cf0e3 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -20,6 +20,7 @@ enum pci_epc_interface_type;
> >  enum pci_notify_event {
> >  	CORE_INIT,
> >  	LINK_UP,
> > +	CUSTOM,
> >  };
> >  
> >  enum pci_barno {
> > 
