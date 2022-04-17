Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F1450477A
	for <lists+linux-pci@lfdr.de>; Sun, 17 Apr 2022 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiDQKMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 06:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiDQKMu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 06:12:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757BF10DB;
        Sun, 17 Apr 2022 03:10:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq30so20372134lfb.3;
        Sun, 17 Apr 2022 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JyEKlxjsw9MBn/UISVAKEEPgrY8QawzFShu9JRMeGwQ=;
        b=Dd2WTYrEmdWrI/Ch/B3lPyU+k48p0oSCMIlQso7glgKua2/Ir2MsHcduEuKu8rmlzt
         f+dQ8lbBnjSibaXpngaDnchUOCpMuvTW6udZaTfTxBZJtlurVLUQPWq+4gJ+ok+d6dqd
         HTarm1ab0ho45JQlumQIGSuDcP3tBJpq6J493/7Y9LtkzbAT9wJhYdBid/BPVoaxC/RY
         Vg+daN/RR2od0cq29T2vAAJBIY7B6ZYXebjcw9Y0zQ0aUvOzQq0nhv/qjQ1Qu+fwU0vd
         G/hr6M3YXh10+Lc2XHgn6pAcox8PewbHDXZbgPF3+3eGxy09uHV9cN+acLjwRvbXKBzk
         ZGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JyEKlxjsw9MBn/UISVAKEEPgrY8QawzFShu9JRMeGwQ=;
        b=5vGgiIBRBcIH910cIoXuE0sxo0F4bE/1RW4K1beQaz0TPu5ljvqEJfNVymsC+M0Zpr
         u+QcFwnFy1L7HGeo3T8ePlPvypHsEMYsHNMboLwhz4ph/bxHSrMCaZEZ0regLxy145+8
         OJ0j7w7jDDwV4VlfX9Y/Nsihm0sDYuqD4yGDINVoTFn9nJSq0x3rAZn1chUUBDT2uodO
         YHyIpxuJj5PYlWfJJKKWh51ddvMOdzsBFXVd1mN4/gshPvGuot80JajVja2B51rUydWi
         J/bvtULYkEMtl3yhWm49rYZq5O71AvxrG1R09s2pXYtBD5mT3QGF1rMlTSntJ1GwqVSu
         iFMA==
X-Gm-Message-State: AOAM531WVLkAwKVZL1/dD7FxLV/itSVWwj2XIMTrgQtsp8Fn0NDyCbOt
        VQz6lZcazxW9qgnW9K2m2Nw=
X-Google-Smtp-Source: ABdhPJwN+uBGqH6/qa/dRyBf5xHl8nIMP9BRM5gQWPcm+mRmO7ZZnMTQIuBbBp5aY6mKrSMUWubAZw==
X-Received: by 2002:a05:6512:3095:b0:44a:6dcc:42df with SMTP id z21-20020a056512309500b0044a6dcc42dfmr4836926lfd.535.1650190212995;
        Sun, 17 Apr 2022 03:10:12 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id o26-20020a198c1a000000b0046bc20821f6sm913758lfd.115.2022.04.17.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 03:10:12 -0700 (PDT)
Date:   Sun, 17 Apr 2022 13:10:09 +0300
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
Subject: Re: [PATCH 03/16] PCI: dwc: Add more verbose link-up message
Message-ID: <20220417101009.ib7o4geybtvkviuh@mobilestation>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-4-Sergey.Semin@baikalelectronics.ru>
 <YkMb5lT91ZveLTgg@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkMb5lT91ZveLTgg@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 09:47:02AM -0500, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 04:37:21AM +0300, Serge Semin wrote:
> > Printing just "link up" isn't that much informative especially when it
> > comes to working with the PCI Express bus. Even if the link is up, due to
> > multiple reasons the bus performance can degrade to slower speeds or to
> > narrower width than both Root Port and its partner is capable of. In that
> > case it would be handy to know the link specifications as early as
> > possible. So let's add a more verbose message to the busy-wait link-state
> > method, which will contain the link speed generation and the PCIe bus
> > width in case if the link up state is discovered. Otherwise an error will
> > be printed to the system log.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 22 +++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 6e81264fdfb4..f1693e25afcb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -528,14 +528,26 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  
> >  	/* Check if the link is up or not */
> >  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> > -		if (dw_pcie_link_up(pci)) {
> > -			dev_info(pci->dev, "Link up\n");
> > -			return 0;
> > -		}
> > +		if (dw_pcie_link_up(pci))
> > +			break;
> > +
> >  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> >  	}
> >  
> > -	dev_info(pci->dev, "Phy link never came up\n");
> > +	if (retries < LINK_WAIT_MAX_RETRIES) {
> > +		u32 offset, val;
> > +
> > +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +		val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > +
> > +		dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > +			 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > +			 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> 

> Given these are standard registers can we do this in the core code? The 
> main issue I think is that the config space accessors don't work until 
> you create the bus struct. That still should be early enough.

AFAICS there are generic methods in the core code to get and print the
link status. See the __pcie_print_link_status() method implementation.
But as you said they rely on having the bus struct instance created and
properly initialized. It's created in the framework of the PCI Host bridge
registration procedure:
pci_host_probe()
+-> pci_scan_root_bus_bridge()
    +-> pci_register_host_bridge()
        +-> pci_alloc_bus(NULL); 
        +-> ...
As for me it would be more logical to have the PCIe link established
(at least activated) and it' status logged before any of the denoted
actions are made since further initialization rely on the PCIe bus
transfers. Moreover the PCIe host probe procedure doesn't really
perform any link up/down related activity, so there is no logical
place to implement the link state checking except someplace at the
traceback top position, but again the bus struct instance isn't
available at that stage. Of course we could implement an alternative
__pcie_print_HOST_link_status() method, which wouldn't need the bus
struct passed. But that would have required some more modifications
(and may cause some functionality duplication) than fixing a few lines
of code and wasn't a subject of this patchset. As such I decided to
stick with having the local link status logging procedure especially
seeing it's done in the framework of the link-wait method, which is
called right after the DW PCIe LTSSM is activated (at least for the DW
PCIe Host controller).

> 
> I think it is possible some implementations don't report the link state 
> in these registers. Maybe we don't really need to care.

I don't see a way to disable the PCIe capability in the DW PCIe
controllers. So if some implementations lack of these registers
reporting the link state, then either those implementations must have
been broken or they violate the PCIe Base Specification [1]. IMO that
must be considered as abnormal situation and needs to be specifically
handled.

[1] PCI Express® Base Specification Revision 5.0, p. 742.

-Sergey

> 
> Rob
