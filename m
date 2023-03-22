Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0416C43B4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 07:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCVG5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 02:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVG5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 02:57:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7772515FE;
        Tue, 21 Mar 2023 23:57:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by8so16672097ljb.12;
        Tue, 21 Mar 2023 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679468224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VctT1j+Lpa3hVedsW/Ad619Xdxc77II5IVNWJsRbhsE=;
        b=CnJ+tP6Cx91ge+Wp3GCb7DTQgxhnIND7WMWiMJ/7o50PpNbaW76swff5BhJ1dWDR0C
         V6y7lPldyqFFYQ1+VrBiXIWrtNx2DIq/EfuO4wIWocA7pl2Zcnl5IVhNCc1JT2FW9cVX
         jhwaqWKDKYRkhMf0f1rUj7hG7h7LVsQ+PlEiq+n0Q/bu22JlWvCrE4nF6Z4mcAH/ziEG
         Fxs02of++KK78xd+yafy22SQZOKDhLieBuK07GgIHsuJNvpI4NmW5VWo9TRPLv0YU097
         e43H2PTSzNBz4kA33/fDSQ9bbC2YGaR4Glvyi0KFsFX01Ctpl0UWlDKckadZxJfPVaS7
         FhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679468224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VctT1j+Lpa3hVedsW/Ad619Xdxc77II5IVNWJsRbhsE=;
        b=sAxP1G2Clj89RaWaTjp4GmFzkoCAlS6Mv7MB5Frgb1i8fGb22XxLuIqpO8Vqn0p+uw
         yMbUvk9ts6xr1H3ImAC9HeJqPUFIemxzu9mLgnVeTOaozL32HUySeWNLuSAuKPwfIut+
         eNeE4T71NyB4pWW5efvugfxR6xtEevax/YntJv1Nq+jGj2jJPPo+tdzTT5V4EFEGrpWl
         PgVD6y6y/lQwy/YLIaqMRK/bcbSfyUh/EJUnN0sokn47/4OOuiGy2KbFVu/Y2jE4OWu8
         NMMmwL5slqW4ux8JriK02ai0J+sUpTVTfm0li81oN+vlPP5Z+zIV613HMiIY9f7Pmrl+
         c7xg==
X-Gm-Message-State: AO0yUKVoww3KBznABHk8Q6IAQ/6T1oQCHv+XOF7B2JQ32x8k7/Btq8/y
        I8gE3IYsd4IsaAIbxu2UrMo=
X-Google-Smtp-Source: AK7set+HXLRoEjVux+KBqTYyfeeEPpWDaTZy89gDp9Z3fbarR/XWyoTVAgFKibigewNEP/2sNcYtfQ==
X-Received: by 2002:a2e:9d15:0:b0:29e:4fa5:1708 with SMTP id t21-20020a2e9d15000000b0029e4fa51708mr1980232lji.3.1679468224015;
        Tue, 21 Mar 2023 23:57:04 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u14-20020a2e854e000000b00299ab2475ebsm2498810ljj.1.2023.03.21.23.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:57:03 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:57:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 08/13] PCI: dwc: Add dw_pcie_num_lanes_setup()
Message-ID: <20230322065701.po7owyzwisntalyz@mobilestation>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-9-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310123510.675685-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 09:35:05PM +0900, Yoshihiro Shimoda wrote:
> Add dw_pcie_num_lanes_setup() to setup PCI_EXP_LNKCAP_MLW.

More details of why it's needed would be nice. For instance, in
accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with the
PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
field there is another one which needs to be update. It's
LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at the
very least the maximum link-width capability CSR won't expose the
actual maximum capability.

[1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.60a, March 2015, p.1032
[2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.70a, March 2016, p.1065
[3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.90a, March 2016, p.1057
...
[X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
    Version 5.40a, March 2019, p.1396
[X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 5.40a, March 2019, p.1266

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  drivers/pci/controller/dwc/pcie-tegra194.c   |  5 +----
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 89b8ec29da7f..47860da5738e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -696,6 +696,18 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>  

> +void dw_pcie_num_lanes_setup(struct dw_pcie *pci, int num_lanes)
> +{
> +	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_MLW;
> +	val |= num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;
> +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_num_lanes_setup);

That's not what I meant. I meant to implement that functionality in
the framework of dw_pcie_setup() function by moving all the
link-width-related initializations into a dedicated static function
dw_pcie_link_set_max_{link}_width() (thus the prototype would look
like the dw_pcie_link_set_max_speed()) and _calling_ it from
dw_pcie_setup() in place where the num-lanes initializations is
performed if pci->num_lanes isn't zero. As I already mentioned in my
comment above in accordance with the DW PCIe HW-manuals this should
have been done for all DW PCIe IP-cores in the first place. I also
checked the PCIE_CAP_MAX_LINK_WIDTH field access attribute. It turns
out to be the same
■ Wire: No access.
■ Dbi: if (DBI_RO_WR_EN == 1) then R/W else R
for all IP-cores which HW ref manuals I have at hands (v4.60a, v4.70a,
v4.90a, v5.20a, v5.30a, v5.40a).

* Note even though the dw_pcie_setup() method currently permits the
* 1, 2, 4 and 8 lanes only, in fact the x16 setup is also possible
* judging by the CX_NL DW PCIe IP-core synthesize parameter.

It would also be more readable to place the dw_pcie_link_set_max_{link}_width()
function below dw_pcie_link_set_max_speed() as per the calling order
in the framework of dw_pcie_setup().

By doing as I suggested above you not only would be able to implement
a correct link-width setup procedure for all IP-cores but also could
get rid of the PATCH #5 since you'll be moving the respective code
anyway and get rid of the dw_pcie_num_lanes_setup() method invocation
from your and Tegra glue-drivers.

-Serge(y)

> +
>  static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  {
>  	u32 cap, ctrl2, link_speed;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 79713ce075cc..36f3e2c818fe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -415,6 +415,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> +void dw_pcie_num_lanes_setup(struct dw_pcie *pci, int num_lanes);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			      u64 cpu_addr, u64 pci_addr, u64 size);
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09825b4a075e..befe17d57e2a 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -902,10 +902,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
>  
>  	/* Configure Max lane width from DT */
> -	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
> -	val &= ~PCI_EXP_LNKCAP_MLW;
> -	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
> -	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
> +	dw_pcie_num_lanes_setup(pci, pcie->num_lanes);
>  
>  	/* Clear Slot Clock Configuration bit if SRNS configuration */
>  	if (pcie->enable_srns) {
> -- 
> 2.25.1
> 
> 
