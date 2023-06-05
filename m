Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A69722429
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjFELG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjFELGW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 07:06:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E055BD;
        Mon,  5 Jun 2023 04:06:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1c30a1653so16859311fa.2;
        Mon, 05 Jun 2023 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685963179; x=1688555179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7M30gPRF1S9FmsectECqP03XbemHmNsuKOYVOI7zWc=;
        b=YETGDHrlvlPXeuRrT+vezPoWYnsr7Xid2LpIK5AyVz3kNTn9HUBGpXZdHE0PoAupVc
         uPEp2hIwRV6QqQXRkdj3HAnCZ4l9o0zjcpR+OPa7yNPle1K3A5T15RWP3hTP4Xuh+kep
         ABMBanCYpppHk/rzmN+6jlJNcVwPS8gMU5aGELd+nhh3/qrxUBEWhVT++C2FHM9zpM9h
         zavp90/YNL80eTU3ndAWSCmGoaUoiD4WhuZiTQZlZpvFSHi5YjoERSBWXS1XMBEEENR4
         fTFQHItGpLes1oaXrzRNUK/OCejNTuGu7o/0Hz+fjMo+Qi40UwvTP+Gzwvb8USbSrOGE
         P/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963179; x=1688555179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7M30gPRF1S9FmsectECqP03XbemHmNsuKOYVOI7zWc=;
        b=k9y8KM1NlbRR60gOEdSA8QMpl5z8vOWcTfekpJ3b3yomFcMBk2XKDpMRgSlyMo9ts5
         tbMF5YYTNEFG/tzHfWpwuUZgWVqtzNOblLQmiiiL4+QuXLi552zrmM9BxQQ3p3QRIKhh
         z69EWKaUv1A564BgqV2J50RH1tWHYYhRA6kWHy93QpJU8lzhSXlBgPzbtfFHlRNtdbSM
         1gnVT619trVwXjS8/CrD3ZSgAqyobamc+1prCR7L1g4SwditVMoQBE1HF5D83Arf4mP/
         rlnfP6SZPhdDa4mvvLhO3FtqB9H49UrHqYeL7QgoM02Kzxl1sqYHV14b4c8T418ZnbRL
         VJsQ==
X-Gm-Message-State: AC+VfDx/WzR3r88gneJuwGwCdXOOaUJM4n/8vdwg/J4vxdsot0F9a6YX
        TwQxaGyW7/FBLjDqmDQSkv4=
X-Google-Smtp-Source: ACHHUZ4W/mP7rRFDsy2/31Pt+q8ndVpZ9XK1lT5mr7917K/HPvUfBLgNp/FOioqFsZIVqOyNWeRuiA==
X-Received: by 2002:a2e:3502:0:b0:2b1:eb62:ffc8 with SMTP id z2-20020a2e3502000000b002b1eb62ffc8mr293673ljz.6.1685963179228;
        Mon, 05 Jun 2023 04:06:19 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e82d5000000b002a8c1462ecbsm1413836ljh.137.2023.06.05.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:06:18 -0700 (PDT)
Date:   Mon, 5 Jun 2023 14:06:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v16 12/22] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting.
Message-ID: <20230605110616.k7l2o7fwwiy62jau@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-13-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-13-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:24PM +0900, Yoshihiro Shimoda wrote:
> dw_pcie_setup() will set PCI_EXP_LNKSTA_NLW to PCI_EXP_LNKCAP register
> so that drop such setting from tegra_pcie_dw_host_init().
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>

AFAICS this update isn't supposed to bring any regression since the
tegra_pcie_dw_host_init() call is always followed by the
dw_pcie_setup_rc() method invocation which thanks to your patches now
fully performs the link width setups. So from my point of view:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Though testing this on a real hw would be very welcome.

-Serge(y)

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4adba379b83d..723a22ccd58c 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -901,12 +901,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  		AMBA_ERROR_RESPONSE_CRS_SHIFT);
>  	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
>  
> -	/* Configure Max lane width from DT */
> -	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
> -	val &= ~PCI_EXP_LNKCAP_MLW;
> -	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
> -	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
> -
>  	/* Clear Slot Clock Configuration bit if SRNS configuration */
>  	if (pcie->enable_srns) {
>  		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
> -- 
> 2.25.1
> 
