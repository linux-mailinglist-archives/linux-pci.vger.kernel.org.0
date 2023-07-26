Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F71762A8A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 07:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGZFCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 01:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGZFCb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 01:02:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94331BD6;
        Tue, 25 Jul 2023 22:02:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b703caf344so92053431fa.1;
        Tue, 25 Jul 2023 22:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690347748; x=1690952548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gPbjK30c+esvkEhjPHS36WVKGOUlnq14R3/RY/1nVA4=;
        b=VsaiOgMmRSRuZ+7oSGVWVaV8cc69VVfDz4gH6qEwsWIpSBgvoBMWarEKNSsMNDO1TA
         hURKbSEg1r/OE6y46ExptxFIdpaniy7YgFqfFskimUE9GVpD52RSl5FegEnwx4J+uEKU
         EmguLvnShhIRRN7RJo90oGlIic0snmCQTdg92veLswi31x92jPHLYpdHZ9dJWkO9nOFy
         nVGqFSq+uo+mUJAy71HGBolXOqyCsCMwskmhrc7f2qLgXg42iNhM/JRyYsgHeb8sztpp
         BsB/0JgUfi5uzuKhNoEs2RHZqGub7Fzur/C8YySK8L+Vx8xLAZKG91ROyivt5dCmfp3b
         IhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690347748; x=1690952548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPbjK30c+esvkEhjPHS36WVKGOUlnq14R3/RY/1nVA4=;
        b=e+NWs36fRGi4/HDdJ3En8eG81IVpkCVNWek9c5wtCWzjH/XXa/TKCT6yenEI9aDzcX
         Gk9RAUT+B8cxBdXYmPCo7gVjmW8U5d5pKnKvZ46vbE8N6kmPUs7zj+8UeZfGxCDInmdp
         pd+d50pkJI5jAE/TMeqErttcXIlvKYdTNGk8ndpS9VCINi+KpWs4LYBs/dx5Thqcrp12
         hVspywqOemwJky1sGaJInNB1dLe3+f0+UJ4XNO0/BNl8/JJ7xaXgzzmZkfI38sQNDLOD
         DHRLKuS+qnG20gM1TzcE9xcZwPaP5WOipffC5OUvHmDpgFIm12OcqP/icsjhXlL0NCw9
         hRdQ==
X-Gm-Message-State: ABy/qLbKWmycEV1IE3ncrrNOJovK9guqJqbIqm4POfIHMucCMuZZmHqM
        3yTglV9ovne/bydIsiGLo4U=
X-Google-Smtp-Source: APBJJlGVb3rqa45EKMVx4vbtnZ6haFuc3ndW0gRD7t8HpP70eXwAfi5Ik7kxvo5eeiiF/iEyXErUAQ==
X-Received: by 2002:a2e:a403:0:b0:2b6:f21a:3dae with SMTP id p3-20020a2ea403000000b002b6f21a3daemr530083ljn.44.1690347747911;
        Tue, 25 Jul 2023 22:02:27 -0700 (PDT)
Received: from mobilestation (37-147-155-252.broadband.corbina.ru. [37.147.155.252])
        by smtp.gmail.com with ESMTPSA id i22-20020a2e8096000000b002b1b92910c8sm117332ljg.86.2023.07.25.22.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:02:27 -0700 (PDT)
Date:   Wed, 26 Jul 2023 08:02:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <ezuyypjmhkb4nsruy5kdoopg537yqg2paf4acgfyib6p7kj7g5@kumpnp2cr4zh>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <20230724074556.GC6291@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724074556.GC6291@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 01:15:56PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote:
> > The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> > To support INTx IRQs in the future, it requires an additional 2
> > arguments. For improved code readability, introduce the struct
> > dw_pcie_ob_atu_cfg and update the arguments of
> > dw_pcie_prog_outbound_atu().
> > 
> > Consequently, remove __dw_pcie_prog_outbound_atu() and
> > dw_pcie_prog_ep_outbound_atu() because there is no longer
> > a need.
> > 
> > No behavior changes.
> > 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> One nit below. With that,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
> >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
> >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> >  4 files changed, 77 insertions(+), 60 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 3c06e025c905..85de0d8346fa 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
> >  	DW_PCIE_NUM_CORE_RSTS
> >  };
> >  
> > +struct dw_pcie_ob_atu_cfg {
> > +	int index;
> > +	int type;
> > +	u8 func_no;
> > +	u64 cpu_addr;
> > +	u64 pci_addr;
> > +	u64 size;
> 

> Reorder the members in below order to avoid holes:
> 
> u64
> int
> u8

One more time. Your suggestion won't prevent the compiler from adding
the pads. (If by "holes" you meant the padding. Otherwise please
elaborate what you meant?). The structure will have the same size of
40 bytes in both cases. So your suggestion will just worsen the
structure readability from having a more natural parameters order (MW
index, type, function, and then the mapping parameters) to a redundant
type-based order.

-Serge(y)

> 
> - Mani
> 
> > +};
> > +
> >  struct dw_pcie_host_ops {
> >  	int (*host_init)(struct dw_pcie_rp *pp);
> >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
> >  int dw_pcie_link_up(struct dw_pcie *pci);
> >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > +			      const struct dw_pcie_ob_atu_cfg *atu);
> >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > -- 
> > 2.25.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
