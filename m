Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8969D6F38EC
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjEAUAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 16:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjEAUAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 16:00:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262093ABF;
        Mon,  1 May 2023 12:59:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4efef769000so3483600e87.3;
        Mon, 01 May 2023 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682971076; x=1685563076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpLvkTdFS0+IxGUsVRL03YFN7R9zsnTIj4XlFZYc2N0=;
        b=QY7m5lTyuVZ09cTsheItkUh9dIPIhqh9gZxuIIcppKkXqdjrAa3uDy5BZF8FHNMzOa
         h24I4ClFUMgYBwlXUuf0fqtwaNBCPokXX7VZZj2OHVcIj5HEo9/fVxtzj7gZQatHaD1U
         SRApLRDrJyYjnvmNL/WslrMh+dgwMNT+HNDMj4bWPv0m6EPjHUNHfUk9vRDM56fc2Ms4
         WLipFRj68+gtFfXeguzRmzLUAgaDxctFKxu9U3KvaT76ULJ7w3iiVyu22JsQTk0NYsqt
         mMZbJZ7A7uqpeXdg3JEJBFttE1H3NIS1TO+7UZdpA9VvLuUqWXC45ICrjus92a2+xaT0
         fADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682971076; x=1685563076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpLvkTdFS0+IxGUsVRL03YFN7R9zsnTIj4XlFZYc2N0=;
        b=CnatsjqXHKsE2SnL2X/KobEnhXGCKfIIHdYlaxZrQbFuLtfHLL/ns41RLsm6TZ50Uj
         w16tqTeEFjhOXtePcwN63kRdkQI6pgPJ2oV/0ikICFbTFvMdptYKSmSqEUkgz4PLaaJF
         2IW0PNVtNx+ODJi0UX4F8Ll6xbkw/oApGOYTS3aifhuFiGxQ0DLkI3hDOB/Jex0RZjUb
         bjiWDoQIlaVl7Bv88FK3lc0pNRcuOl2MVbWu63GKPGjj1KrlJC/98twsj2wo0abhrZNs
         PGfpMT/LcdaiIKDJRo7OjVumawERKTlc8z+xjJ3MKN3qlIpDjQQYKaflwXGkc74MK82x
         Cxvw==
X-Gm-Message-State: AC+VfDwYa96/iGHiYxUd4h3lrqvv+7hKb+UZiU59+lHOyZinFfV0Vtzm
        wiAcOHH/LVx8uipxx2acvRI=
X-Google-Smtp-Source: ACHHUZ7uTNOZZMsDXaIjw7E8WqD8doQG5NChMAWBFiegBcGwkWXX/cSmzKcZ3sMQRCjxSR32EdLakQ==
X-Received: by 2002:ac2:538d:0:b0:4cb:4362:381d with SMTP id g13-20020ac2538d000000b004cb4362381dmr3926690lfh.62.1682971075805;
        Mon, 01 May 2023 12:57:55 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id i8-20020a056512006800b004edc9da63bdsm4936187lfo.160.2023.05.01.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:57:55 -0700 (PDT)
Date:   Mon, 1 May 2023 22:57:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v14 11/21] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Message-ID: <20230501195753.o3qfcs7qyergccnr@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-12-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-12-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:47PM +0900, Yoshihiro Shimoda wrote:
> Add dw_pcie_link_set_max_cap_width() to set PCI_EXP_LNKCAP_MLW.
> In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> field there is another one which needs to be updated. It's
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
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index f8926d5ec422..bdc5ebd7cd5f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -737,6 +737,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
>  }
>  

> +static void dw_pcie_link_set_max_cap_width(struct dw_pcie *pci, int num_lanes)
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

Just move the function body to dw_pcie_link_set_max_link_width() thus
the later method will be as coherent as possible.

Also note the duplicated code can be dropped from the pcie-tegra194.c
driver. Please submit an additional cleanup patch so the Tegra driver
author would have it reviewed.

-Serge(y)

> +
>  static void dw_pcie_link_set_max_width(struct dw_pcie *pci, u32 num_lanes)
>  {
>  	u32 val;
> @@ -1074,6 +1089,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
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
