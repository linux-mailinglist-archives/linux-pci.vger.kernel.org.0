Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD6722406
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjFEK6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFEK6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 06:58:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5ACEA;
        Mon,  5 Jun 2023 03:58:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso36784221fa.1;
        Mon, 05 Jun 2023 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962719; x=1688554719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GwBjzdlFiqH9/htrq3/gTiCUQ+rn2YtMAR4ZlxAmMk=;
        b=cd1sGThJWyGiYTP0LEQ4AcWRcxlBQTg/p47lL9Dv+5rwOUqdlNJTim1hrEefNtPm6u
         Z24ju/MFuFKzAn7dluHBkaFxO2J5DhvlJ2X4lsSXcipyZZkMvHxjEMCj9GrsjFUV9Vw0
         fz9zgApWZ1gNAT8LE4A5EK2JeBjnHn/f9Tje4KjUZ3lpdMdfYzXB3XwPEypJrcIpjDCN
         G41DeZLQIb4k88HA9QwQU/uuf3Pp/JIMXZgKZSCdcMjcKUmjLWvz0ST2gEC2vzXWqbzB
         kdTMu01+m/28Y+jknJRg6gbw7hQrIYb0NHv0Wowc9KVWExiMiGyjzTkoB7ctVxhT+rZt
         nzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962719; x=1688554719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GwBjzdlFiqH9/htrq3/gTiCUQ+rn2YtMAR4ZlxAmMk=;
        b=KBaoNJP+uf/pT9SZFFsQaa1Ciy/1lLehaYqY/TVH6n0tmFonfskMv8TMdNo/E6itNI
         R0dYhF7F2Oi2rR3BZB64cadaZigLMw1VH7pQ3A0Mgd8WdRTn8TSUYnczarEFAesx/hu0
         PlYvJtWtx1OehqzQcKIaUuPEjfW6xTbbRqKIH7KrJtQ2hPLbFRfFQCFEhUmFVd8ACNh/
         vxGDetM50IMjiwk6UT6IDkt05mmCDLTpGw7+6KN5Nvw1j7RGQjrMjfT6V3DXq00zuuJE
         r2MVfDf4iDjkwNTXg8nKha4bft99nNTnY6euG3uayZY/VnRGoZgNJsODc0Ms5SjNBh8I
         jGdg==
X-Gm-Message-State: AC+VfDxWrSvtOFgGHhQ3OYK5LgqhOnR+cDmkjRcTONWWeEJmuJd51RuP
        YOgHxxOlp3BuQCXXGWvnbP4=
X-Google-Smtp-Source: ACHHUZ57P9cW4s65TelliT9WOwKpN9ocbjXvamYeGPg+nAgaOAdNv0XmkX3vc1127aIjExtaaV6/Tw==
X-Received: by 2002:a2e:3203:0:b0:2b0:2976:172d with SMTP id y3-20020a2e3203000000b002b02976172dmr4052358ljy.9.1685962719245;
        Mon, 05 Jun 2023 03:58:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id p15-20020a2ea40f000000b002adb6dd5a97sm1406292ljn.27.2023.06.05.03.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:58:38 -0700 (PDT)
Date:   Mon, 5 Jun 2023 13:58:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 11/22] PCI: dwc: Add dw_pcie_link_set_max_cap_width()
Message-ID: <20230605105836.ddvbrhlf6xfnkd2y@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-12-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-12-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:23PM +0900, Yoshihiro Shimoda wrote:
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
>       Version 5.40a, March 2019, p.1396
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
> index 5dc423dd2f21..8b2978c6eb23 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -758,6 +758,21 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
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

Once again. Please move this code to the
dw_pcie_link_set_max_link_width() method as I already asked here:
https://lore.kernel.org/linux-pci/20230501195753.o3qfcs7qyergccnr@mobilestation/
There is no point in creating a separate method for the action which
is implied by the already defined and incomplete
dw_pcie_link_set_max_link_width() function.

Also as we already agreed please replace the hard-coded bitwise shift
operation with the FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes)
statement.

-Serge(y)

> +}
> +
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
> @@ -1040,4 +1055,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>  
>  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> +	dw_pcie_link_set_max_cap_width(pci, pci->num_lanes);
>  }
> -- 
> 2.25.1
> 
