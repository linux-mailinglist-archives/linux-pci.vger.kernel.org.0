Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB276A68B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 03:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHABo6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 21:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHABo5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 21:44:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584671988;
        Mon, 31 Jul 2023 18:44:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so8337362e87.0;
        Mon, 31 Jul 2023 18:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690854293; x=1691459093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKcQ4b3iGQnIm8d34yo7op8jEmASD55O4ViNOmeufyE=;
        b=Z2nYoiay30fCW4xl8ZECaD7ydM/DO8P5yDwQhRH5jH//dyuYkLhW3BJj5vr3ATbjcB
         0h4iHYYwxbHq/+oaGKJZTpO/nP70UIC5wM7GnlUrKzap7eljTs7uqa+o0mtoRR0Qhuyu
         eSpxogBE4IIyaqEXRl5chMBeT5vmFEWs8jDjw9QPtoM0mZ90EMFOszHC//h2smbi15IX
         8NfewsXq5MttIQCfyllgz7fxe3KAl11zXz+ZKphYKmvX7sOyJGkf0Et+ExiKKYtRcz8c
         vHue8DStSZXK9NpG3s/UlnXKLFhU8DZipJ9tDmm7MTHfk7Brv0sOzRB3ZSi7QHeWbJ3J
         QwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690854293; x=1691459093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKcQ4b3iGQnIm8d34yo7op8jEmASD55O4ViNOmeufyE=;
        b=hNMvK1DX/otniJ4dxavZWpgdPrf9z3TLsp3LJ3NWh08m6oZ885wIXNwFgqHTGmcUi7
         nkX+PiXIldRaO/Pl8wn6Pfx9Wi5fgJo/PLRtaVBBAQp2++JjoNbjKlA3HFJPXz36Xszt
         n5bRLO+2iHQh6qj9BvBw8/dXobajDd1JNUqtSpWyJRwA4kcRSSSefZBi4e/IUe0ZcZRI
         kvAOdytbhpvnKM6BEdcNt7m0SCeD7uQwfXopkiEn8EYcoy7Uks0w9cO7DIQAWI32QpSU
         FTZ15uv8GFRESkxroKMgovJz25RINEv23svh1yV4nuTt3OxxdXfitQNuYGpSSmk8fxS5
         9j1A==
X-Gm-Message-State: ABy/qLZSTLrk8IzzkX/pJM3tUvh2/Hr7cpzYJGVgS474qtMgB1szI5xV
        J5XmVgXu6OaEEoRzQCq9sSE=
X-Google-Smtp-Source: APBJJlH6jhXe9KV6zpyP/ikyRbolhzeGYoolSSemdAyulRQgLkrpQptDimz9hTZiS8IaQoM+pQZ2oQ==
X-Received: by 2002:ac2:4822:0:b0:4fe:788:66fe with SMTP id 2-20020ac24822000000b004fe078866femr953127lft.68.1690854293196;
        Mon, 31 Jul 2023 18:44:53 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id h12-20020a19700c000000b004fdc7a53310sm952403lfc.148.2023.07.31.18.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 18:44:52 -0700 (PDT)
Date:   Tue, 1 Aug 2023 04:44:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <jgizq7ibill2bd735fh7elzb74guwjjwxqkfgn3uwh65lyuoe2@pqo4qdrpvkpw>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <u2lzrypnaevcp5r5xueeceoq6b5v6ngzdmwyadel2liloxb3rz@6ribp2lqv2db>
 <OSYPR01MB5334EBCD11ED8D3104A0BEFBD805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
 <4idgmodxlnzv2kkscniuw3336ynmukh3duu4rt2db354ln5sbg@e4jnmhfugmj4>
 <TYBPR01MB5341F15483816E81A073B12DD80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341F15483816E81A073B12DD80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 01:29:10AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Tuesday, August 1, 2023 6:33 AM
> > 
> > On Mon, Jul 31, 2023 at 01:24:27AM +0000, Yoshihiro Shimoda wrote:
> > > Hi Serge,
> > >
> > > > From: Serge Semin, Sent: Saturday, July 29, 2023 11:07 AM
> > > >
> > > > On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote:
> > > > > The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> > > > > To support INTx IRQs in the future, it requires an additional 2
> > > > > arguments. For improved code readability, introduce the struct
> > > > > dw_pcie_ob_atu_cfg and update the arguments of
> > > > > dw_pcie_prog_outbound_atu().
> > > > >
> > > > > Consequently, remove __dw_pcie_prog_outbound_atu() and
> > > > > dw_pcie_prog_ep_outbound_atu() because there is no longer
> > > > > a need.
> > > > >
> > > > > No behavior changes.
> > > >
> > > > So you decided not to use a suggested by me in v17 more detailed patch
> > > > log?
> > >
> > > You're correct. I thought your suggested comments was too detailed.
> > 
> > I strongly recommend for you to use mine instead. It gives more
> > details about the change and the patch context. Moreover it much more
> > clearer justifies the change implemented in the patch.
> 

> I didn't realize that you have a strong recommendation about the comments
> you suggested. I'll replace the commit description and add your Suggested-by
> tag on v19.

Just to note if there is a misunderstanding on your side. Suggested-by tag is
relevant to the patch idea in general.
See Documentation/process/submitting-patches.rst:559 for details.
So you don't need to add the tag if somebody just suggested an
alternative patch description.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > >
> > > Best regards,
> > > Yoshihiro Shimoda
> > >
> > > > C&P it here just in case if you change your mind:
> > > >
> > > > This is a preparation before adding the Msg-type outbound iATU
> > > > mapping. The respective update will require two more arguments added
> > > > to __dw_pcie_prog_outbound_atu(). That will make the already
> > > > complicated function prototype even more hard to comprehend accepting
> > > > _eight_ arguments. In order to prevent that and keep the code
> > > > more-or-less readable all the outbound iATU-related arguments are
> > > > moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
> > > > to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
> > > > is supposed to be locally defined and populated with the outbound iATU
> > > > settings implied by the caller context.
> > > >
> > > > As a result of the denoted change there is no longer need in having
> > > > the two distinctive methods for the Host and End-point outbound iATU
> > > > setups since the corresponding code can directly call the
> > > > dw_pcie_prog_outbound_atu() method with the config-structure
> > > > populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.
> > > >
> > > > -Serge(y)
> > > >
> > > > >
> > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > ---
> > > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> > > > >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
> > > > >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
> > > > >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> > > > >  4 files changed, 77 insertions(+), 60 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > index 27278010ecec..fe2e0d765be9 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > @@ -182,9 +182,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> > > > > -				   phys_addr_t phys_addr,
> > > > > -				   u64 pci_addr, size_t size)
> > > > > +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> > > > > +				   struct dw_pcie_ob_atu_cfg *atu)
> > > > >  {
> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > >  	u32 free_win;
> > > > > @@ -196,13 +195,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > >
> > > > > -	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
> > > > > -					   phys_addr, pci_addr, size);
> > > > > +	atu->index = free_win;
> > > > > +	ret = dw_pcie_prog_outbound_atu(pci, atu);
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > >
> > > > >  	set_bit(free_win, ep->ob_window_map);
> > > > > -	ep->outbound_addr[free_win] = phys_addr;
> > > > > +	ep->outbound_addr[free_win] = atu->cpu_addr;
> > > > >
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -305,8 +304,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > >  	int ret;
> > > > >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > > -
> > > > > -	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> > > > > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > > > > +
> > > > > +	atu.func_no = func_no;
> > > > > +	atu.type = PCIE_ATU_TYPE_MEM;
> > > > > +	atu.cpu_addr = addr;
> > > > > +	atu.pci_addr = pci_addr;
> > > > > +	atu.size = size;
> > > > > +	ret = dw_pcie_ep_outbound_atu(ep, &atu);
> > > > >  	if (ret) {
> > > > >  		dev_err(pci->dev, "Failed to enable address\n");
> > > > >  		return ret;
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index cf61733bf78d..7419185721f2 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -549,6 +549,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
> > > > >  {
> > > > >  	struct dw_pcie_rp *pp = bus->sysdata;
> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > > > >  	int type, ret;
> > > > >  	u32 busdev;
> > > > >
> > > > > @@ -571,8 +572,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
> > > > >  	else
> > > > >  		type = PCIE_ATU_TYPE_CFG1;
> > > > >
> > > > > -	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
> > > > > -					pp->cfg0_size);
> > > > > +	atu.type = type;
> > > > > +	atu.cpu_addr = pp->cfg0_base;
> > > > > +	atu.pci_addr = busdev;
> > > > > +	atu.size = pp->cfg0_size;
> > > > > +
> > > > > +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > > > >  	if (ret)
> > > > >  		return NULL;
> > > > >
> > > > > @@ -584,6 +589,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
> > > > >  {
> > > > >  	struct dw_pcie_rp *pp = bus->sysdata;
> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > > > >  	int ret;
> > > > >
> > > > >  	ret = pci_generic_config_read(bus, devfn, where, size, val);
> > > > > @@ -591,9 +597,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
> > > > >  		return ret;
> > > > >
> > > > >  	if (pp->cfg0_io_shared) {
> > > > > -		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > > > > -						pp->io_base, pp->io_bus_addr,
> > > > > -						pp->io_size);
> > > > > +		atu.type = PCIE_ATU_TYPE_IO;
> > > > > +		atu.cpu_addr = pp->io_base;
> > > > > +		atu.pci_addr = pp->io_bus_addr;
> > > > > +		atu.size = pp->io_size;
> > > > > +
> > > > > +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > > > >  		if (ret)
> > > > >  			return PCIBIOS_SET_FAILED;
> > > > >  	}
> > > > > @@ -606,6 +615,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
> > > > >  {
> > > > >  	struct dw_pcie_rp *pp = bus->sysdata;
> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > > > >  	int ret;
> > > > >
> > > > >  	ret = pci_generic_config_write(bus, devfn, where, size, val);
> > > > > @@ -613,9 +623,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
> > > > >  		return ret;
> > > > >
> > > > >  	if (pp->cfg0_io_shared) {
> > > > > -		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> > > > > -						pp->io_base, pp->io_bus_addr,
> > > > > -						pp->io_size);
> > > > > +		atu.type = PCIE_ATU_TYPE_IO;
> > > > > +		atu.cpu_addr = pp->io_base;
> > > > > +		atu.pci_addr = pp->io_bus_addr;
> > > > > +		atu.size = pp->io_size;
> > > > > +
> > > > > +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > > > >  		if (ret)
> > > > >  			return PCIBIOS_SET_FAILED;
> > > > >  	}
> > > > > @@ -650,6 +663,7 @@ static struct pci_ops dw_pcie_ops = {
> > > > >  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > > >  {
> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > > > >  	struct resource_entry *entry;
> > > > >  	int i, ret;
> > > > >
> > > > > @@ -677,10 +691,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > > >  		if (pci->num_ob_windows <= ++i)
> > > > >  			break;
> > > > >
> > > > > -		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> > > > > -						entry->res->start,
> > > > > -						entry->res->start - entry->offset,
> > > > > -						resource_size(entry->res));
> > > > > +		atu.index = i;
> > > > > +		atu.type = PCIE_ATU_TYPE_MEM;
> > > > > +		atu.cpu_addr = entry->res->start;
> > > > > +		atu.pci_addr = entry->res->start - entry->offset;
> > > > > +		atu.size = resource_size(entry->res);
> > > > > +
> > > > > +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > > > >  		if (ret) {
> > > > >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > > > >  				entry->res);
> > > > > @@ -690,10 +707,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > > >
> > > > >  	if (pp->io_size) {
> > > > >  		if (pci->num_ob_windows > ++i) {
> > > > > -			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
> > > > > -							pp->io_base,
> > > > > -							pp->io_bus_addr,
> > > > > -							pp->io_size);
> > > > > +			atu.index = i;
> > > > > +			atu.type = PCIE_ATU_TYPE_IO;
> > > > > +			atu.cpu_addr = pp->io_base;
> > > > > +			atu.pci_addr = pp->io_bus_addr;
> > > > > +			atu.size = pp->io_size;
> > > > > +
> > > > > +			ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > > > >  			if (ret) {
> > > > >  				dev_err(pci->dev, "Failed to set IO range %pr\n",
> > > > >  					entry->res);
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index 2459f2a61b9b..49b785509576 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -464,56 +464,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
> > > > >  	return val | PCIE_ATU_TD;
> > > > >  }
> > > > >
> > > > > -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > > > > -				       int index, int type, u64 cpu_addr,
> > > > > -				       u64 pci_addr, u64 size)
> > > > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > > > +			      const struct dw_pcie_ob_atu_cfg *atu)
> > > > >  {
> > > > > +	u64 cpu_addr = atu->cpu_addr;
> > > > >  	u32 retries, val;
> > > > >  	u64 limit_addr;
> > > > >
> > > > >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> > > > >  		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
> > > > >
> > > > > -	limit_addr = cpu_addr + size - 1;
> > > > > +	limit_addr = cpu_addr + atu->size - 1;
> > > > >
> > > > >  	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
> > > > >  	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > > > > -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > > > > +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > >
> > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> > > > >  			      lower_32_bits(cpu_addr));
> > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> > > > >  			      upper_32_bits(cpu_addr));
> > > > >
> > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
> > > > >  			      lower_32_bits(limit_addr));
> > > > >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > > > > -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > > > > +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
> > > > >  				      upper_32_bits(limit_addr));
> > > > >
> > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > > > > -			      lower_32_bits(pci_addr));
> > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > > > > -			      upper_32_bits(pci_addr));
> > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> > > > > +			      lower_32_bits(atu->pci_addr));
> > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > > > > +			      upper_32_bits(atu->pci_addr));
> > > > >
> > > > > -	val = type | PCIE_ATU_FUNC_NUM(func_no);
> > > > > +	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > > > >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > > > >  	    dw_pcie_ver_is_ge(pci, 460A))
> > > > >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > > > >  	if (dw_pcie_ver_is(pci, 490A))
> > > > >  		val = dw_pcie_enable_ecrc(val);
> > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> > > > >
> > > > > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> > > > > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> > > > >
> > > > >  	/*
> > > > >  	 * Make sure ATU enable takes effect before any subsequent config
> > > > >  	 * and I/O accesses.
> > > > >  	 */
> > > > >  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> > > > > -		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> > > > > +		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
> > > > >  		if (val & PCIE_ATU_ENABLE)
> > > > >  			return 0;
> > > > >
> > > > > @@ -525,21 +525,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > > > >  	return -ETIMEDOUT;
> > > > >  }
> > > > >
> > > > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > > > > -			      u64 cpu_addr, u64 pci_addr, u64 size)
> > > > > -{
> > > > > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > > > > -					   cpu_addr, pci_addr, size);
> > > > > -}
> > > > > -
> > > > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > > -				 int type, u64 cpu_addr, u64 pci_addr,
> > > > > -				 u64 size)
> > > > > -{
> > > > > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > > > > -					   cpu_addr, pci_addr, size);
> > > > > -}
> > > > > -
> > > > >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
> > > > >  {
> > > > >  	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > index 3c06e025c905..85de0d8346fa 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
> > > > >  	DW_PCIE_NUM_CORE_RSTS
> > > > >  };
> > > > >
> > > > > +struct dw_pcie_ob_atu_cfg {
> > > > > +	int index;
> > > > > +	int type;
> > > > > +	u8 func_no;
> > > > > +	u64 cpu_addr;
> > > > > +	u64 pci_addr;
> > > > > +	u64 size;
> > > > > +};
> > > > > +
> > > > >  struct dw_pcie_host_ops {
> > > > >  	int (*host_init)(struct dw_pcie_rp *pp);
> > > > >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > > > > @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
> > > > >  int dw_pcie_link_up(struct dw_pcie *pci);
> > > > >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> > > > >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > > > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > > > > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > > > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > > > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > > > +			      const struct dw_pcie_ob_atu_cfg *atu);
> > > > >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > > > >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> > > > >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > > --
> > > > > 2.25.1
> > > > >
