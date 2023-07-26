Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B977636F2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjGZNA3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjGZNA2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 09:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9661BC2;
        Wed, 26 Jul 2023 06:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2D56617A5;
        Wed, 26 Jul 2023 13:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C66C433CA;
        Wed, 26 Jul 2023 13:00:19 +0000 (UTC)
Date:   Wed, 26 Jul 2023 18:30:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <20230726130015.GA5633@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <20230724074556.GC6291@thinkpad>
 <ezuyypjmhkb4nsruy5kdoopg537yqg2paf4acgfyib6p7kj7g5@kumpnp2cr4zh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ezuyypjmhkb4nsruy5kdoopg537yqg2paf4acgfyib6p7kj7g5@kumpnp2cr4zh>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 08:02:24AM +0300, Serge Semin wrote:
> On Mon, Jul 24, 2023 at 01:15:56PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote:
> > > The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> > > To support INTx IRQs in the future, it requires an additional 2
> > > arguments. For improved code readability, introduce the struct
> > > dw_pcie_ob_atu_cfg and update the arguments of
> > > dw_pcie_prog_outbound_atu().
> > > 
> > > Consequently, remove __dw_pcie_prog_outbound_atu() and
> > > dw_pcie_prog_ep_outbound_atu() because there is no longer
> > > a need.
> > > 
> > > No behavior changes.
> > > 
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > One nit below. With that,
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> > >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
> > >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
> > >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> > >  4 files changed, 77 insertions(+), 60 deletions(-)
> > > 
> > 
> > [...]
> > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 3c06e025c905..85de0d8346fa 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
> > >  	DW_PCIE_NUM_CORE_RSTS
> > >  };
> > >  
> > > +struct dw_pcie_ob_atu_cfg {
> > > +	int index;
> > > +	int type;
> > > +	u8 func_no;
> > > +	u64 cpu_addr;
> > > +	u64 pci_addr;
> > > +	u64 size;
> > 
> 
> > Reorder the members in below order to avoid holes:
> > 
> > u64
> > int
> > u8
> 
> One more time. Your suggestion won't prevent the compiler from adding
> the pads. (If by "holes" you meant the padding. Otherwise please
> elaborate what you meant?).

Struct padding is often referred as struct holes. So yes, I'm referring the
same.

> The structure will have the same size of
> 40 bytes in both cases. So your suggestion will just worsen the
> structure readability from having a more natural parameters order (MW
> index, type, function, and then the mapping parameters) to a redundant
> type-based order.
> 

This is a common comment I provide for all structures. Even though the current
result (reordering) doesn't save any space, when the structure grows big (who
knows), we often see more holes/padding being inserted by the compiler if the
members are not ordered in the descending order w.r.t their size.

I agree that it makes more clear if the members are grouped based on their
function etc... but for large structures this would often add more padding/hole.

- Mani

> -Serge(y)
> 
> > 
> > - Mani
> > 
> > > +};
> > > +
> > >  struct dw_pcie_host_ops {
> > >  	int (*host_init)(struct dw_pcie_rp *pp);
> > >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > > @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
> > >  int dw_pcie_link_up(struct dw_pcie *pci);
> > >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> > >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > +			      const struct dw_pcie_ob_atu_cfg *atu);
> > >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> > >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > -- 
> > > 2.25.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
