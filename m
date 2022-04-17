Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2876A50482E
	for <lists+linux-pci@lfdr.de>; Sun, 17 Apr 2022 17:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiDQPQC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQPQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 11:16:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA72E697;
        Sun, 17 Apr 2022 08:13:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g19so7079683lfv.2;
        Sun, 17 Apr 2022 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0m3IBb/ZpbHo13WgPLZEjLJAyGb5H3OuJfo3hnEC+J4=;
        b=LvyidDxIah4372iUBdrAhmiv9f/DM76ODPvxJabuch+5plB97qiBNhLz3mLEx/ckz9
         ldmg5nzu3BsfAMzK0sI5+YNo2v9lLUhN0aJRqJSk5R7/Nevz7tR8QVUYiQHfL94h1qIv
         c7QwuEXTG++LfvHPvXqUogZ/iKKpKuwmIBPb14Yefz/EGMgwTUzeLDbdKTsogrp0ZlG/
         P8D9nCYoQU8cD+m3XXV7kHOsGhAvHK4F8uga2QMZiduSvGumgS75+EhQHhQg6tlncxD6
         IRnS/BqSnRvXdwtFu/X+XlE/3gstzFWbT+si6C52keiU0f89d7+6WYNXpA8z6/JGMWse
         iFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0m3IBb/ZpbHo13WgPLZEjLJAyGb5H3OuJfo3hnEC+J4=;
        b=aAirTUcRQ/lDbq4JmCn80vS2PnsuGGrvfwqdiEFFoKaa8nPHV0pwDqtmqHJDWOzU0x
         TagEBU4sjxg6J0ihVdlRgED3WbIoTlZS11TuQn9S9E9S2OOeUP2NYHjy1IOAD/etdi8y
         cO1KwoRjWNF/EVofwp1mpDrM0iIfqrCyUfj/1QYc5sk87VB1jLi3BsTAhbUMbiR0OFb9
         pOg17y5vYGpdT3M7nbLuMd5HZmyocNXiUZF88JH5h1UzpXBA6DxB82Sr/EMCPL7Q3oTY
         f415M0ad5jIuSGQzi9XVpO8ns4a+UN+3XzqBnQ6Cod5etuVKluQ7F9eftzTpi2Ll5FtY
         4g+Q==
X-Gm-Message-State: AOAM530VXiWOXqzYS68R4KdNh93jtnqSm93mNB+kzIGHpqqp7wx1Pqpe
        GrZeoyiJn3fPSqAbqkgSurM=
X-Google-Smtp-Source: ABdhPJzXW5xA++O+GCHhuL3EV2eRdnnHBDbCBc916pFBuqgpcnF99kqyAhm0OulRhWdk5oP7UwV6JQ==
X-Received: by 2002:a05:6512:304a:b0:44a:c4a4:8e9d with SMTP id b10-20020a056512304a00b0044ac4a48e9dmr5262564lfb.624.1650208403639;
        Sun, 17 Apr 2022 08:13:23 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24357000000b0044adb34b68csm968552lfl.32.2022.04.17.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 08:13:23 -0700 (PDT)
Date:   Sun, 17 Apr 2022 18:13:20 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] PCI: dwc: Add IP-core version detection procedure
Message-ID: <20220417151320.wahjqjbe3efb4kty@mobilestation>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-6-Sergey.Semin@baikalelectronics.ru>
 <YkMhBdrd9Bq4hzjq@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkMhBdrd9Bq4hzjq@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 10:08:53AM -0500, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 04:37:23AM +0300, Serge Semin wrote:
> > Since DWC PCIe v4.70a the controller version and version type can be read
> > from the PORT_LOGIC.PCIE_VERSION_OFF and PORT_LOGIC.PCIE_VERSION_TYPE_OFF
> > registers respectively. Seeing the generic code has got version-dependent
> > parts let's use these registers to find out the controller version.  The
> > detection procedure is executed for both RC and EP modes right after the
> > platform-specific initialization. We can't do that earlier since the
> > glue-drivers can perform the DBI-related setups there including the bus
> > reference clocks activation, without which the CSRs just can't be read.
> > 
> > Note the CSRs content is zero on the older DWC PCIe controller. In that
> > case we have no choice but to rely on the platform setup.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
> >  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
> >  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  |  6 +++++
> >  4 files changed, 34 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 7c9315fffe24..3b981d13cca9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -645,6 +645,8 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >  	u32 reg;
> >  	int i;
> >  
> > +	dw_pcie_version_detect(pci);
> > +
> >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> >  		   PCI_HEADER_TYPE_MASK;
> >  	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 8364ea234e88..8f0d473ff770 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -398,6 +398,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  		}
> >  	}
> >  
> > +	dw_pcie_version_detect(pci);
> > +
> >  	dw_pcie_iatu_detect(pci);
> >  
> >  	dw_pcie_setup_rc(pp);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index c21373c6cb51..49c494d82042 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -16,6 +16,30 @@
> >  #include "../../pci.h"
> >  #include "pcie-designware.h"
> >  
> > +void dw_pcie_version_detect(struct dw_pcie *pci)
> > +{
> > +	u32 ver;
> > +
> > +	/* The content of the CSR is zero on DWC PCIe older than v4.70a */
> > +	ver = dw_pcie_readl_dbi(pci, PCIE_VERSION_NUMBER);
> > +	if (!ver)
> > +		return;
> > +
> > +	if (pci->version && pci->version != ver)
> > +		dev_warn(pci->dev, "Versions don't match (%08x != %08x)\n",
> > +			 pci->version, ver);
> 

> Trust the h/w is correct until we have a known case where it isn't. Just 
> read the h/w reg if pci->version is zero.
> 
> I would suspect as-is this will give some warnings. No doubt there is 
> some platform with multiple revs of Si that didn't change their version 
> in the driver. Or the author just guessed on the version that picked the 
> right paths in the driver.

I'm not sure I fully get it. Could you elaborate what you suggest
here?  Do you suggest for me to drop the warnings and rewrite the
pci->{version, type} fields with the values read from the registers if
these fields were set with zeros?

-Sergey

> 
> Rob
