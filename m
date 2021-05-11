Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9F37A8AC
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhEKONg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhEKONe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 10:13:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDCDC06174A
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 07:12:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gx5so29952757ejb.11
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OIwezPJuTfdqFYz8VGwzwetE3vIr2bBPuH042i/Tcg8=;
        b=GM+JN+TEJV7xyOwTPmcH2A6BKMHr6ucfSAdOwRNoHULozQlNH3nqMODU+3cgcI00Ba
         NZW0JprVhz7P8o01TYoRQVHdqbx3jnFOjQMR1SJ5K3RkzK2X5zus3FOVtU+91UfWPJ8A
         MmXBaKOmONRvmkKyKDf7OY0F0N6ygalXw0zyw1Y2jOExMe/uCyRy7AKvZ+WxBqwMgXpk
         HcRJJ+AEd2G7/eoWcjacDzN94fXxyrx60SGiM9ViERmyn3eneH/ta4rGY9UbMETVQ9qG
         Kt0c67Ot6/v9MJDGNlT9jAbwI2xCv6yhmtw1X/wXRL6DFwALPw/GNaGZVyLoo8AwvP/C
         vf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OIwezPJuTfdqFYz8VGwzwetE3vIr2bBPuH042i/Tcg8=;
        b=HPoDw+2CPnKqdPQf7HFxCCojAQzLA0Q+gq6CoUTcaZL4q0HMrGrkWb97FTUiY6bBm0
         N1FIlW7EfH3e2AukPX+4M6u8Ga7YmZmna9ox3vO5JbpoGlVroVnaPEfza5H/xJBmmZ27
         J14ekqwu9qEKJTgI4SuiZOoU4GDzo7cMdtfVT1goWeSe8K083EoCZWxpNZpKJmzIRNSd
         nOHUuGM8rgjKgaD2ixj8n6bn9jhGrl0w/JAh8SYk8Q3i0H2TsWK5+WspygWAi/z8XdSs
         BsAvrq3xcG6Yl2B75LDqHaTeeiXEzbc35KeiyYjpbr4Ky1fxD4KamRMwj5jL4+9ZKKQN
         4htw==
X-Gm-Message-State: AOAM530f+Qlt/aFUfeWahBHM8Q58zPhNfhk7YHdanZnNcRc54o63UB66
        qbuUplnRoezu1L7stZCae6pUTw==
X-Google-Smtp-Source: ABdhPJyUQl5TJG/HXT7H22ZmzKQQuCuRK0URhnZdX07Zg0398dem+nMwIGif0SiweBR+MwBemwsKTg==
X-Received: by 2002:a17:906:edcf:: with SMTP id sb15mr31458761ejb.202.1620742345934;
        Tue, 11 May 2021 07:12:25 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id re26sm11730624ejb.3.2021.05.11.07.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 07:12:25 -0700 (PDT)
Date:   Tue, 11 May 2021 16:12:08 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Fix MSIs for generic hosts that use
 device-tree's "msi-map"
Message-ID: <YJqQuKZOeorJ+/Py@myrica>
References: <20210510173129.750496-1-jean-philippe@linaro.org>
 <87r1ieo3cd.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1ieo3cd.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On Mon, May 10, 2021 at 07:23:14PM +0100, Marc Zyngier wrote:
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 3a62d09b8869..275204646c68 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -925,7 +925,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  	device_enable_async_suspend(bus->bridge);
> >  	pci_set_bus_of_node(bus);
> >  	pci_set_bus_msi_domain(bus);
> > -	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev))
> > +	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
> > +	    !pci_host_of_has_msi_map(parent))
> >  		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> >  
> >  	if (!parent)
> 
> Do we need something similar for IORT, which implements a similar
> functionality to "msi-map"? My ACPI boxes seem to get their MSIs just
> fine though...

I'm not seeing the issue either under ACPI on the fast model, because it
doesn't go through pci_host_common_probe(), and bridge->msi_domain is not
set:

 acpi_pci_root_add()
  pci_acpi_scan_root()
   acpi_pci_root_create()
    pci_create_root_bus()
     pci_register_host_bridge()

It doesn't look like any ACPI platform can set bridge->msi_domain at the
moment. If they do flip the switch at some point, MSIs won't work and
we'll need something for IORT. But I'd leave it out for the moment.

Thanks,
Jean

