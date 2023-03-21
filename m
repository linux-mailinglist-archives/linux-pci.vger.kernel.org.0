Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC5F6C2D74
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCUJEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 05:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCUJD4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 05:03:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB62947828;
        Tue, 21 Mar 2023 02:02:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g17so18207292lfv.4;
        Tue, 21 Mar 2023 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679389378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zii/L8bydF2J5bZJFsBnJTDRUEK+gjfel/OiYtpVK6E=;
        b=GrWhwbrqEvFoRYyXkUO5+jrN+zVkEK95a7DsrW1ZLC1hFa0fRLIiVSe/5dgQ7kQ3gl
         ab0WtbTeb3JsZybEHDcUFugMdg5r2yWULyrHaEJlJRMSGJJyTUcLA0AQ+t6/JZBXvC8Y
         R5moVIhDfgRyPZZ2/IZSPsVY+aE68X48SyOZihYtGISeiPPTdDTwetUBNIK2NNqRTMx2
         ISBqtXu8Hh/0Bpqac6OKx3mZwisg46lweGlU5YSLJeWaUtorCeQotDV/QWGcmwRiCjjJ
         KPCkPWNpsqMgEQAhiGcEOXKlMTptyCWNBB6DgX1bpu7ayyjxsjG8cHe89NMld0Gxf/R9
         X6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679389378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zii/L8bydF2J5bZJFsBnJTDRUEK+gjfel/OiYtpVK6E=;
        b=CmEpImSzaSGhfjlrZNhF0wlcT1qSfqHuoiidtxv0+JMEpThQY2Z5Jq30oTGp/4XHSq
         qD2eXzgF9ZaPwcvaMM2TyAKt6q/a+3Yg1bw6kNoDJkhinXeo2/JcD94mPA4k2jfo4mPY
         9l2aEuen1xjAc7eyA/545Nlcsgjk3RPKtcxxJ26OEbwOTO0zf6JN6VVLv5oDguGW5bH6
         rHdQO+vmjAoawETefKrzXzSoHgkfadVQxPCUQorXhO370yLmusYEO203Lj2C/Sgd6pwZ
         YLBzmgjXD6hmCugvYzgmCt3g2OF6ga8OGYNQpIc/O/JPGLoZN91B9pi7ltTgvOdnC8xV
         bNJQ==
X-Gm-Message-State: AO0yUKVC4Om57hz0jYF/el05/Rm7ul0IstSbraFN7fEMa6I743K0C4TO
        p/RPhpyktQGNkeMdTF3ktm4=
X-Google-Smtp-Source: AK7set/gQlTgRvutONqyBXlc5/sCs1gMiZSDxAeYXnLe40E7tACAbeI9H51AyXkVG3JZWDZsFIO8xA==
X-Received: by 2002:ac2:5dfc:0:b0:4d6:d0a0:8313 with SMTP id z28-20020ac25dfc000000b004d6d0a08313mr682869lfq.10.1679389377633;
        Tue, 21 Mar 2023 02:02:57 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p5-20020a19f005000000b004e856a4159bsm2092375lfc.20.2023.03.21.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 02:02:57 -0700 (PDT)
Date:   Tue, 21 Mar 2023 12:02:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 01/13] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Message-ID: <20230321090255.cca6xowea6k6fud4@mobilestation>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-2-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310123510.675685-2-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 09:34:58PM +0900, Yoshihiro Shimoda wrote:
> The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
> "Set the number of lanes". But, if snps,enable-cdm-check" exists,
> the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
> Therefore, unexpected register value is possible to be used
> to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
> So, change reading timing of PCIE_PORT_LINK_CONTROL register to fix
> the issue.

My version of the commit log:
< If CDM_CHECK capability is set then the local variable 'val' will be
< overwritten in the dw_pcie_setup() method in the PL_CHK register
< initialization procedure. Thus further variable usage in the framework of
< the PCIE_PORT_LINK_CONTROL register initialization at the very least must
< imply the variable re-initialization. Alas it hasn't been taken into
< account in the commit ec7b952f453c ("PCI: dwc: Always enable CDM check if
< "snps,enable-cdm-check" exists"). Due to that the PCIE_PORT_LINK_CONTROL
< register will be written with an improper value in case if the CDM-check
< is enabled. Let's fix this by moving the PCIE_PORT_LINK_CONTROL CSR
< updated to be fully performed after the PL_CHK register
< initialization.

> 
> Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Looks good. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

@Bjorn, if it's possible could you please take this patch to a
fixes(-ish) branch of your tree and merge it in the next rc-cycle?
It definitely fixes a bug in the DW PCIe core driver.

-Serge(y)

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 53a16b8b6ac2..8e33e6e59e68 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1001,11 +1001,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>  	}
>  
> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> -	val &= ~PORT_LINK_FAST_LINK_MODE;
> -	val |= PORT_LINK_DLL_LINK_EN;
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> -
>  	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
>  		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
>  		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> @@ -1013,6 +1008,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
>  
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> +	val &= ~PORT_LINK_FAST_LINK_MODE;
> +	val |= PORT_LINK_DLL_LINK_EN;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> +
>  	if (!pci->num_lanes) {
>  		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
>  		return;
> -- 
> 2.25.1
> 
> 
