Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889AE7BF96E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjJJLOb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 07:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjJJLOa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 07:14:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47FC9;
        Tue, 10 Oct 2023 04:14:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBB9C433C8;
        Tue, 10 Oct 2023 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696936468;
        bh=cqJDIFRAmhUKp1Y/7ZPqP9qn5Uw4cafg32jMOCIdKVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Al1DQQFum23qa1CFi9YJPQfJyUYxPKj5WmenRAs9uOYGU2vK/BNUH16tPKmOAcYfU
         dKVG7im4959ES4XYIjH4mQLCeBxGuc9QuAQoiKk8x4Fc4lZ3mKe8+X+3fXA7DEgsog
         I/VhM8APcpJqjTOqYtYgKHfxT7xkHkHLv6RUG9SBhtW4zj8cALfcQNgd0pvvUPeh5Y
         2OdL3qJ/wHmghuYQHNQ/91KvED94Hs5mgwIQZNtumEERaBYU+wFWV8oS4AAWx/seZn
         fqLDiXISvyIrUzsiF74fo46oJLVVBH3cnEDf7sr7V8RuFuTE/YOqBwm1BDHN/yWpwP
         euZ27L1/VcEFA==
Date:   Tue, 10 Oct 2023 16:44:14 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v21 03/16] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW
 handling
Message-ID: <20231010111414.GB4884@thinkpad>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-4-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922065331.3806925-4-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 03:53:18PM +0900, Yoshihiro Shimoda wrote:
> Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
> 
> In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> field there is another one which needs to be updated.
> 
> It's LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> the very least the maximum link-width capability CSR won't expose the
> actual maximum capability.
> 
> [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.60a, March 2015, p.1032
> [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.70a, March 2016, p.1065
> [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.90a, March 2016, p.1057
> ...
> [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
>       Version 5.40a, March 2019, p.1396
> [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>       Version 5.40a, March 2019, p.1266
> 
> [kwilczynski: commit log]
> Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-8-yoshihiro.shimoda.uh@renesas.com
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Same comment about s-o-b.

- Mani

> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index da4aba4aee62..2b60d20dfdf5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -734,7 +734,8 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  {
> -	u32 lwsc, plc;
> +	u32 lnkcap, lwsc, plc;
> +	u8 cap;
>  
>  	if (!num_lanes)
>  		return;
> @@ -770,6 +771,12 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  	}
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> +
> +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> +	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
> +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
>  }
>  
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
