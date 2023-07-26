Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4FB7642A6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 01:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGZXiv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 19:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGZXiu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 19:38:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC20E4C;
        Wed, 26 Jul 2023 16:38:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so591258e87.2;
        Wed, 26 Jul 2023 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690414727; x=1691019527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gsbI3SH+Kq96dup/SZd+lNDDg+o58o0YW0EFAmDfboc=;
        b=HxC/f1alkcNBemeDK4zIFM+fmaMJyGkgDiWXVJW4C6gtyY/yr2kHxlgnLD8GA17jMT
         8v7x2u6AhaZvGAZ2/KZ0JoVtnMrb0TIKRoeK8Iuyh4A1zVEfT82FRaxwjH9UkMGwNkGC
         xQGzn+tGXfskRav8+TXNsYPa/IRoFa4WvLU4NNs0ptKUOzRwcvbmbc315BIfOnMAZWfn
         EiBMPECN6HiQaHbKnWz+05uEU5F/Tb5GcWAYM2jXfiUiYqkcC4QXuIM44XEy4ezsWbu3
         8L+QWs1PdjqqqN8lPQvDLZ46AQQDAG02NM9geWNJRLKrWriT0vPGcDHBQnA5L92LRI64
         p5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414727; x=1691019527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsbI3SH+Kq96dup/SZd+lNDDg+o58o0YW0EFAmDfboc=;
        b=jkmwaYDBWiwsxnTZK+BM49eiN6RZ0uI0KR6DrKH2mf4SZ1zJtJorNnUraHRmoQWu7X
         bGxgsQk8W9JUaXR+pqVH0xVVdK8XbNxgFsd/+mNJfyZKNaLPyN96q+mJPIacK5hMuyN/
         ypzYp1yz/nhgk4l4jdNnix6K5PS6aPGfJBeoHrNE1Oh5LuIMI3EKf4s8Buq/OLTiz/K+
         d58G3bqLiQQpGxb1lg6HmfvQuaKwuFKDMRPbd7g6mfr6e9oTAl5KS0Gwjd2PJLfsHCG+
         ToR6YRpXUbeSB6Ct2BAvBtvPYOqjmdXdA2sT49pznU2Hm452cJi1/im8PNai+X0DwQqR
         ftMw==
X-Gm-Message-State: ABy/qLbWrqNUleVGaxngpYUBYuIUklPVd1X+R33qi3SRN8Wf/LkWHKC/
        38/qf9UqXsVtSqJjPV+s/+w=
X-Google-Smtp-Source: APBJJlGZbZTlWXcPVMKxCYwZi4R7qxv4IuHAPSuZ69a6v0RZFzwCtO63kcvVdKcYkyj4Bg6tsyqfSg==
X-Received: by 2002:a05:6512:3e29:b0:4fb:896d:bd70 with SMTP id i41-20020a0565123e2900b004fb896dbd70mr469539lfv.46.1690414727032;
        Wed, 26 Jul 2023 16:38:47 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id b11-20020ac25e8b000000b004fba1170087sm38489lfq.224.2023.07.26.16.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:38:46 -0700 (PDT)
Date:   Thu, 27 Jul 2023 02:38:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <aldqqozyrjdd74jdm2xmgp53rpke4otm6iy4tjfemdwxd4ir5y@p3dlr3p5c7t4>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <20230724074556.GC6291@thinkpad>
 <ezuyypjmhkb4nsruy5kdoopg537yqg2paf4acgfyib6p7kj7g5@kumpnp2cr4zh>
 <20230726130015.GA5633@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726130015.GA5633@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 06:30:15PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 26, 2023 at 08:02:24AM +0300, Serge Semin wrote:
> > On Mon, Jul 24, 2023 at 01:15:56PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote:
> > > > The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> > > > To support INTx IRQs in the future, it requires an additional 2
> > > > arguments. For improved code readability, introduce the struct
> > > > dw_pcie_ob_atu_cfg and update the arguments of
> > > > dw_pcie_prog_outbound_atu().
> > > > 
> > > > Consequently, remove __dw_pcie_prog_outbound_atu() and
> > > > dw_pcie_prog_ep_outbound_atu() because there is no longer
> > > > a need.
> > > > 
> > > > No behavior changes.
> > > > 
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > 
> > > One nit below. With that,
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > ---
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> > > >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
> > > >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
> > > >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> > > >  4 files changed, 77 insertions(+), 60 deletions(-)
> > > > 
> > > 
> > > [...]
> > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 3c06e025c905..85de0d8346fa 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
> > > >  	DW_PCIE_NUM_CORE_RSTS
> > > >  };
> > > >  
> > > > +struct dw_pcie_ob_atu_cfg {
> > > > +	int index;
> > > > +	int type;
> > > > +	u8 func_no;
> > > > +	u64 cpu_addr;
> > > > +	u64 pci_addr;
> > > > +	u64 size;
> > > 
> > 
> > > Reorder the members in below order to avoid holes:
> > > 
> > > u64
> > > int
> > > u8
> > 
> > One more time. Your suggestion won't prevent the compiler from adding
> > the pads. (If by "holes" you meant the padding. Otherwise please
> > elaborate what you meant?).
> 
> Struct padding is often referred as struct holes. So yes, I'm referring the
> same.
> 
> > The structure will have the same size of
> > 40 bytes in both cases. So your suggestion will just worsen the
> > structure readability from having a more natural parameters order (MW
> > index, type, function, and then the mapping parameters) to a redundant
> > type-based order.
> > 
> 

> This is a common comment I provide for all structures. Even though the current
> result (reordering) doesn't save any space, when the structure grows big (who
> knows), we often see more holes/padding being inserted by the compiler if the
> members are not ordered in the descending order w.r.t their size.
> 
> I agree that it makes more clear if the members are grouped based on their
> function etc... but for large structures this would often add more padding/hole.

This structure will never be big enough to be considered for such
strange optimization. Moreover practicality almost always beats some
theoretical considerations. In this case there is no any reason to
reorder the fields as you say.

Speaking in general I very much doubt that saving a few bytes of
memory can be considered as a better option than having a more
readable structure especially these days. Moreover for all these years
I never met anybody asking to set the descending order of
the members or maintaining such limitation in the commonly used kernel
structures. What is normally done:
1. Move an embedded object to the head of the structure for the
container_of-macro optimization.
2. Group up the commonly used fields to optimize the system cache
utilization.
3. Logical grouping the members, which naturally may lead to the more
optimal cache utilization.
4. Move a field to a certain place of the structure to fill in the
pads.

Even if the "descending alignment" requirement minimizes the number of
the pads it isn't the only possible way to do so in the particular
cases and it looks too harsh to be blindly applied all the time. If a
few bytes is so important why not do the same for instance for the
local variables too? They are also normally size-aligned in the stack
memory, which is much more precious in kernel.

Anyway in this case changing the fields order is absolutely redundant.
Even a provided afterwards update doesn't cause the structure size
change. So for the sake of readability it's better to leave its fields
ordered as is.

-Serge(y)

> 
> - Mani
> 
> > -Serge(y)
> > 
> > > 
> > > - Mani
> > > 
> > > > +};
> > > > +
> > > >  struct dw_pcie_host_ops {
> > > >  	int (*host_init)(struct dw_pcie_rp *pp);
> > > >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > > > @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
> > > >  int dw_pcie_link_up(struct dw_pcie *pci);
> > > >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> > > >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > > > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > > +			      const struct dw_pcie_ob_atu_cfg *atu);
> > > >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > > >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> > > >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > -- 
> > > > 2.25.1
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
