Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48E76538E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjG0MW3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjG0MW2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 08:22:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DEC30C0;
        Thu, 27 Jul 2023 05:21:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso1580053e87.1;
        Thu, 27 Jul 2023 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690460498; x=1691065298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lv8NLN1fG/Lk2oimzBPYTF7qXzdm4FqQVkw6hJCTj0=;
        b=CPepNmNZ6Jty33pDVwH9xvXmD+1cPXg/Vmwt7+FqF8RfxBa0ulxIh/DPy1OZJhc1Om
         QnP/1XlTi30iKhTvDoe0/XoUYySZ9IlSxGvjiZ+WWog/Xt/T8fswOqE8avOtrFb8OGIY
         aKJpFdPDl1Jqlf4OlJxoeMo5JyLV84ay8W7LDRfQj5VDEqkxd9b6UYlZHkuJt+dO8fXn
         8qsGaaLhtUKcd9U2WJsU+gmWpLzB39HzmfqOdqXrV619nEdJdVcHvfHfwh8/u2OnnWHR
         JNrX4cc78eAzNzwrKGSiImEOS3taoFnp+G2Ut2/ps7BXGrkouf+FrlHMNoZ/2PJcxsKG
         2Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460498; x=1691065298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lv8NLN1fG/Lk2oimzBPYTF7qXzdm4FqQVkw6hJCTj0=;
        b=TcdTP3DiYAlhyBEs06nyaYaUIT2YwIbQ4vjj6/4LvGoseaLxGIo/TLwbsVWLJBeNyz
         pRplUYv8OTBZaCnlPXeTF0Cgp5nXItPwAmYgJyZ30/FMJ+U1I34rnDixIVMhr34a9ZQh
         YEh+xG4qQwK3It4Xw+wEsI2hPe9zhXItQlgWnEUMjg7w+D1LXGtRleU1Dawy6UbVs8Uf
         ad3VTd0a0JNWg+enRqSg+uXTmj50T6n3tTIM1Q+m4Zul9bP2VIfeNFtLRkO/uEiJKLRP
         KBR5pitzRcc0e8rD306y6yhHbdXfywG9tWd2SdkbB4MAKnPUUjkpczr5d0OHASrq7pwo
         2V5g==
X-Gm-Message-State: ABy/qLYbWs0qM0w6IeAilO5B/dYgJCQho83X4YyAh2ymqaSZaFV7kTkp
        ZkS0i0XPqG2lLabZVBd8qxM=
X-Google-Smtp-Source: APBJJlFw+VPnN4KLx7SkniKX8XuJHD/frq+qjPTTxFkmXHGb/TARyZOOpm1buWxCLY/+xqQYPEvYMw==
X-Received: by 2002:a19:a40d:0:b0:4f8:6d99:f4f3 with SMTP id q13-20020a19a40d000000b004f86d99f4f3mr1524855lfc.52.1690460497859;
        Thu, 27 Jul 2023 05:21:37 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id eq17-20020a056512489100b004fe1268bf7asm288662lfb.126.2023.07.27.05.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:21:37 -0700 (PDT)
Date:   Thu, 27 Jul 2023 15:21:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <qcqki7cxr75vjov67kkxsox4buokfgu64s5irisu6hz2yvmt26@o6dyibtpz5vc>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <20230724074556.GC6291@thinkpad>
 <ezuyypjmhkb4nsruy5kdoopg537yqg2paf4acgfyib6p7kj7g5@kumpnp2cr4zh>
 <20230726130015.GA5633@thinkpad>
 <aldqqozyrjdd74jdm2xmgp53rpke4otm6iy4tjfemdwxd4ir5y@p3dlr3p5c7t4>
 <20230727110343.GA4702@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230727110343.GA4702@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 27, 2023 at 04:33:43PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jul 27, 2023 at 02:38:44AM +0300, Serge Semin wrote:
> > On Wed, Jul 26, 2023 at 06:30:15PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jul 26, 2023 at 08:02:24AM +0300, Serge Semin wrote:
> > > > On Mon, Jul 24, 2023 at 01:15:56PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Fri, Jul 21, 2023 at 04:44:36PM +0900, Yoshihiro Shimoda wrote:
> > > > > > The __dw_pcie_prog_outbound_atu() currently has 6 arguments.
> > > > > > To support INTx IRQs in the future, it requires an additional 2
> > > > > > arguments. For improved code readability, introduce the struct
> > > > > > dw_pcie_ob_atu_cfg and update the arguments of
> > > > > > dw_pcie_prog_outbound_atu().
> > > > > > 
> > > > > > Consequently, remove __dw_pcie_prog_outbound_atu() and
> > > > > > dw_pcie_prog_ep_outbound_atu() because there is no longer
> > > > > > a need.
> > > > > > 
> > > > > > No behavior changes.
> > > > > > 
> > > > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > 
> > > > > One nit below. With that,
> > > > > 
> > > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > 
> > > > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > ---
> > > > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
> > > > > >  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
> > > > > >  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
> > > > > >  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
> > > > > >  4 files changed, 77 insertions(+), 60 deletions(-)
> > > > > > 
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > index 3c06e025c905..85de0d8346fa 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > @@ -288,6 +288,15 @@ enum dw_pcie_core_rst {
> > > > > >  	DW_PCIE_NUM_CORE_RSTS
> > > > > >  };
> > > > > >  
> > > > > > +struct dw_pcie_ob_atu_cfg {
> > > > > > +	int index;
> > > > > > +	int type;
> > > > > > +	u8 func_no;
> > > > > > +	u64 cpu_addr;
> > > > > > +	u64 pci_addr;
> > > > > > +	u64 size;
> > > > > 
> > > > 
> > > > > Reorder the members in below order to avoid holes:
> > > > > 
> > > > > u64
> > > > > int
> > > > > u8
> > > > 
> > > > One more time. Your suggestion won't prevent the compiler from adding
> > > > the pads. (If by "holes" you meant the padding. Otherwise please
> > > > elaborate what you meant?).
> > > 
> > > Struct padding is often referred as struct holes. So yes, I'm referring the
> > > same.
> > > 
> > > > The structure will have the same size of
> > > > 40 bytes in both cases. So your suggestion will just worsen the
> > > > structure readability from having a more natural parameters order (MW
> > > > index, type, function, and then the mapping parameters) to a redundant
> > > > type-based order.
> > > > 
> > > 
> > 
> > > This is a common comment I provide for all structures. Even though the current
> > > result (reordering) doesn't save any space, when the structure grows big (who
> > > knows), we often see more holes/padding being inserted by the compiler if the
> > > members are not ordered in the descending order w.r.t their size.
> > > 
> > > I agree that it makes more clear if the members are grouped based on their
> > > function etc... but for large structures this would often add more padding/hole.
> > 
> > This structure will never be big enough to be considered for such
> > strange optimization. Moreover practicality almost always beats some
> > theoretical considerations. In this case there is no any reason to
> > reorder the fields as you say.
> > 
> > Speaking in general I very much doubt that saving a few bytes of
> > memory can be considered as a better option than having a more
> > readable structure especially these days. Moreover for all these years
> > I never met anybody asking to set the descending order of
> > the members or maintaining such limitation in the commonly used kernel
> > structures. What is normally done:
> > 1. Move an embedded object to the head of the structure for the
> > container_of-macro optimization.
> > 2. Group up the commonly used fields to optimize the system cache
> > utilization.
> > 3. Logical grouping the members, which naturally may lead to the more
> > optimal cache utilization.
> 
> Indeed.
> 
> > 4. Move a field to a certain place of the structure to fill in the
> > pads.
> > 
> 
> This is what I try to avoid by grouping the members. If you move a field to
> a certain place, wouldn't it affect readability?
> 
> But I do not want to argue more on this. Please see below.
> 
> > Even if the "descending alignment" requirement minimizes the number of
> > the pads it isn't the only possible way to do so in the particular
> > cases and it looks too harsh to be blindly applied all the time. If a
> > few bytes is so important why not do the same for instance for the
> > local variables too? They are also normally size-aligned in the stack
> > memory, which is much more precious in kernel.
> > 
> 
> Well, for local variables I prefer reverse Xmas tree order which is what widely
> used throughout the kernel. But we do not care about their ordering because, it
> won't grow too much like a structure (not talking about recursive case).
> 
> > Anyway in this case changing the fields order is absolutely redundant.
> > Even a provided afterwards update doesn't cause the structure size
> > change. So for the sake of readability it's better to leave its fields
> > ordered as is.
> > 
> 
> I certainly agree that reordering wouldn't save any space for this structure.
> As a maintainer, I prefer to keep this pattern so that I don't have to worry
> about the padding issues in the future and hence the suggestion.
> 
> But feel free to drop it as I don't have a strong objection to this specific
> case.

Agreed then.

Yoshihiro, could you please ignore the Mani' comment regarding the
"descending alignment" order and retain the fields order is in your
current patch?

I'll get back to the series review tomorrow. Please no rush with
resubmitting.

-Serge(y)

> 
> - Mani
> 
> > -Serge(y)
> > 
> > > 
> > > - Mani
> > > 
> > > > -Serge(y)
> > > > 
> > > > > 
> > > > > - Mani
> > > > > 
> > > > > > +};
> > > > > > +
> > > > > >  struct dw_pcie_host_ops {
> > > > > >  	int (*host_init)(struct dw_pcie_rp *pp);
> > > > > >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > > > > > @@ -416,10 +425,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
> > > > > >  int dw_pcie_link_up(struct dw_pcie *pci);
> > > > > >  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> > > > > >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> > > > > > -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > > > > > -			      u64 cpu_addr, u64 pci_addr, u64 size);
> > > > > > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > > > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > > > > > +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > > > > > +			      const struct dw_pcie_ob_atu_cfg *atu);
> > > > > >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > > > > >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> > > > > >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > > > -- 
> > > > > > 2.25.1
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > மணிவண்ணன் சதாசிவம்
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
