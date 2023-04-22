Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FB6EB96D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 15:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDVNtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDVNtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 09:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0D61BEB;
        Sat, 22 Apr 2023 06:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82CFB60C06;
        Sat, 22 Apr 2023 13:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391EBC433EF;
        Sat, 22 Apr 2023 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682171373;
        bh=UbFTVeA9GJtCePnCqu6jhZCXZDI2CycMk8Y9FF86nIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxBB1T+fXAOwZM14XKVZ4uBCogcymPwIWDnbB8fkNpNt9x4CyWPSG/mdSEG3C7B2f
         UxPA+9utLyEGfDnjBeYfGSGhu/OMuGIoqTc+Kac/hJxFFZUFJ8LUFTseX5R1qdrSFR
         XwOyaqcJm+LpL06R+AxikjX/SyjSAImtpYmCxPR46H5V/G8Ck+76QAgEAHr9TyaNsk
         qr3tKDaOdhBk3TZTBhL2+DtLW603fSDrRsKrCI8mb1gnAOwremc1Be+xrqFOGCtMfN
         LOlD5g2AjRAXD8lT619BK9hxJi9dGJ4MGnd+HPWkgodOPFqYNjdzmeU56/7lSWEtDr
         txbhFEsS1OGFw==
Date:   Sat, 22 Apr 2023 19:19:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 12/22] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Message-ID: <20230422134924.GI4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-13-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-13-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:53PM +0900, Yoshihiro Shimoda wrote:
> Add dw_pcie_link_set_max_cap_width() to set PCI_EXP_LNKCAP_MLW.
> In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> field there is another one which needs to be update. It's

s/update/updated

> LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> the very least the maximum link-width capability CSR won't expose
> the actual maximum capability.
> 
> [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.60a, March 2015, p.1032
> [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.70a, March 2016, p.1065
> [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     Version 4.90a, March 2016, p.1057
> ...
> [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
>     Version 5.40a, March 2019, p.1396
> [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>       Version 5.40a, March 2019, p.1266
> 
> The commit description is suggested by Serge Semin.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c76fa78c6468..2413cd39310c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -737,6 +737,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
>  }
>  
> +void dw_pcie_link_set_max_cap_width(struct dw_pcie *pci, int num_lanes)

static? Or if you want other drivers to make use of it, then define it as a
common PCI function (not dwc specific) and also update one potential user
(pci-mvebu.c). I think you need to do the later.

- Mani

> +{
> +	u32 val;
> +	u8 cap;
> +
> +	if (!num_lanes)
> +		return;
> +
> +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_MLW;
> +	val |= num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;
> +	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, val);
> +}
> +
>  static void dw_pcie_link_set_max_width(struct dw_pcie *pci, u32 num_lanes)
>  {
>  	u32 val;
> @@ -1073,6 +1088,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
>  
> +	dw_pcie_link_set_max_cap_width(pci, pci->num_lanes);
>  	dw_pcie_link_set_max_width(pci, pci->num_lanes);
>  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>  }
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
