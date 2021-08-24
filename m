Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070F53F6A4A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhHXUPU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbhHXUPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 16:15:18 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A571EC0613C1
        for <linux-pci@vger.kernel.org>; Tue, 24 Aug 2021 13:14:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso49348942ott.13
        for <linux-pci@vger.kernel.org>; Tue, 24 Aug 2021 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QZeCJMWa2DyYIKT8pa19hLZA7G5Ooy4YsTZZ7q3AAk0=;
        b=o+MAEkXjUlnugHRMChx4LwieuBiIAi4mQZvjGR7fvreydNMyquGGa7fWcTDHUcBgrQ
         gWlcqGrFAKtu2bJuKxRDqAnZ4qFfy8bUCzt6kJ8boduahrwtF+mrhVnq4XhZRAaDbjR7
         kZYRGjhp+SnfywAk+RIOi8BN7wfJQFVgs7dfHDKoJe2/bo4TVWrVjAcSbVwcSUbFCHTf
         6ZfhxY4W6tQFuE7roPCKS71L87X+cvFgIsxwQS3GqLIJwzK+QT5dPL3+axVYg4YyfBpz
         n9DdbKuJHP5rogwWs3tRSuPicO1+0IwX4sXAFQGaU6XCp85W8KBI+GSBTshdie8lxPyP
         yWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZeCJMWa2DyYIKT8pa19hLZA7G5Ooy4YsTZZ7q3AAk0=;
        b=d6kXE38bcext9LASRaJqDPTqRLzi5KurYMcWLRMbGT9fSRFIqc/GtPlcK62VOsNewG
         eyqNvuIaBPj9bOHNlPHtJ8FKdUe7p1lCzDLtcK+cjra9+IjkP0A+L1DDaIJfix6UNlTw
         51ISlBCTuvXTemOmhlcQhO1UutWnAEre0d2EvZURE5yg4vftZdL57htdfUbJuovTwa6I
         ENE3KlB4RrKEwsJvtMWqUE4o4fa3knTRbtusuBojjt+/iKKg+bMYcBxl2mXxmawKn8vm
         wQczBAjBOeC0KFvw9G0NSYFrTmwpjc+ub7uUmrH+z2Vg4DmlH7hQZYT/KLwIEzo7GL6l
         fudQ==
X-Gm-Message-State: AOAM533+eV8YPC8dkBsi8ye6Rsl4Tbo/eyKVINB7reDrwWIBcjx9vc3i
        9Yl5eUog1ge/QAgC4iEvpnPd9g==
X-Google-Smtp-Source: ABdhPJxxW96qHYBwTeBhQSeNQcMWYpoBctpNwA/ov26qmHt06vQxhPHx8QeZsks//ic1sCFa8V2zow==
X-Received: by 2002:aca:a8c8:: with SMTP id r191mr4201299oie.144.1629836072932;
        Tue, 24 Aug 2021 13:14:32 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r13sm4790133oti.80.2021.08.24.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 13:14:32 -0700 (PDT)
Date:   Tue, 24 Aug 2021 13:15:49 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Perform host_init() before registering
 msi
Message-ID: <YSVTdedrDSgSYgwm@ripper>
References: <20210823154958.305677-1-bjorn.andersson@linaro.org>
 <20210824190527.GA3486548@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824190527.GA3486548@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue 24 Aug 12:05 PDT 2021, Bjorn Helgaas wrote:

> On Mon, Aug 23, 2021 at 08:49:57AM -0700, Bjorn Andersson wrote:
> > On the Qualcomm sc8180x platform the bootloader does something related
> > to PCI that leaves a pending "msi" interrupt, which with the current
> > ordering often fires before init has a chance to enable the clocks that
> > are necessary for the interrupt handler to access the hardware.
> > 
> > Move the host_init() call before the registration of the "msi" interrupt
> > handler to ensure the host driver has a chance to enable the clocks.
> 
> Did you audit other drivers for similar issues?  If they do, we should
> fix them all at once.
> 

I only looked at the DesignWware drivers, in an attempt to find any
issues the proposed reordering.

The set of bugs causes by drivers registering interrupts before critical
resources tends to be rather visible and I don't know if there's much
value in speculatively "fixing" drivers.

E.g. a quick look through the drivers I see a similar pattern in
pci-tegra.c, but it's unlikely that they have the similar problem in
practice and I have no way to validate that a change to the order would
have a positive effect - or any side effects.


Or am I misunderstanding your request?

Regards,
Bjorn

> > The assignment of the bridge's ops and child_ops is moved along, because
> > at least the TI Keystone driver overwrites these in its host_init
> > callback.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - New patch, instead of enabling resources in the qcom driver before jumping to
> >   dw_pcie_host_init(), per Rob Herring's suggestion.
> > 
> >  .../pci/controller/dwc/pcie-designware-host.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index d1d9b8344ec9..f4755f3a03be 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -335,6 +335,16 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  	if (pci->link_gen < 1)
> >  		pci->link_gen = of_pci_get_max_link_speed(np);
> >  
> > +	/* Set default bus ops */
> > +	bridge->ops = &dw_pcie_ops;
> > +	bridge->child_ops = &dw_child_pcie_ops;
> > +
> > +	if (pp->ops->host_init) {
> > +		ret = pp->ops->host_init(pp);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	if (pci_msi_enabled()) {
> >  		pp->has_msi_ctrl = !(pp->ops->msi_host_init ||
> >  				     of_property_read_bool(np, "msi-parent") ||
> > @@ -388,15 +398,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  		}
> >  	}
> >  
> > -	/* Set default bus ops */
> > -	bridge->ops = &dw_pcie_ops;
> > -	bridge->child_ops = &dw_child_pcie_ops;
> > -
> > -	if (pp->ops->host_init) {
> > -		ret = pp->ops->host_init(pp);
> > -		if (ret)
> > -			goto err_free_msi;
> > -	}
> >  	dw_pcie_iatu_detect(pci);
> >  
> >  	dw_pcie_setup_rc(pp);
> > -- 
> > 2.29.2
> > 
