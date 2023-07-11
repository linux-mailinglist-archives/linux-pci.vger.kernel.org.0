Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51D574F952
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGKUsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 16:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGKUrv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 16:47:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3359B;
        Tue, 11 Jul 2023 13:47:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69923a715so98567241fa.0;
        Tue, 11 Jul 2023 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689108468; x=1691700468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJHRQ34WYwoDGj03DDbaHxKoVvqJPbF8opF7Gn8ticg=;
        b=ToUgugcPuBd55m8pWthqiCe1ojkZnICsw9WiQfoe8kp6WEVjn2mI3jkfrzV3tM7OlE
         qPBU4CjwJVCsU4ll2AJSWTcxW48jkpRsVpN1OGmIyrtutKfJUPWs/iXlAXSqGXqH2JZ5
         2pK7I7mOUhC22YbCW211nkRryHP9aGpFIxBGFnA85Ptx8cZLD9IX+pFi0fPFTUKl0zeV
         L6NKn2g+7NGvKY42w0BvQqtzqGnGae+h61kKPjnvzGC0Vg985PtDUJJnkGO7Mjo6vJa9
         kHF13Q2F8LL2+ldyI+ts3KIkstDG6l4kvgb4tGnA2Ib2W/evA2D+g8H+jwgM+/UA9C34
         RxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689108468; x=1691700468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJHRQ34WYwoDGj03DDbaHxKoVvqJPbF8opF7Gn8ticg=;
        b=JlPNyKJSzF1fHJGK7IP0ZJXGlME8jSBGSclcu45pWf3k2/laqXt+6gfY96isAhcMMw
         yapsNt0fOGGzQLaSVeWQJeJLsQVgoZkyPalO/tX6u0cITJxMhcDkSv6/y3jcB6N5LPxE
         e5Y0dOklfW1C2FP0OGiHx9PNtsGOPF/41K78TMiHD/CZ0c8RgTvIltoUHsoQePQ4GxIE
         Kj+WFJzzz0DktrAEvEv3L38aZixXqtArkHWMFv7t0+DkO+30S9x19mzL8PdBTFCsAZTQ
         JASabhngIcS/VVchc5L/KJTtFVP21LGDE4h8H6FixyCjIt+LrkDrC40VPaAwiuPOt7/A
         vALw==
X-Gm-Message-State: ABy/qLYtA18tFYSTeAc9M/0fA5NSU6V0bNuJrzXWf/mc6PlrZ34U0P2+
        kRBNG9fZqvSyhuHLyVeJuwI=
X-Google-Smtp-Source: APBJJlEsnwN8An1uHj9yamSS8udYeK1O+8NhwN94DRWpiw4tBOjfddE6RCXZVSnEqpTLHhSk6ccunw==
X-Received: by 2002:a2e:b045:0:b0:2b6:e618:b597 with SMTP id d5-20020a2eb045000000b002b6e618b597mr16008167ljl.28.1689108468011;
        Tue, 11 Jul 2023 13:47:48 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id p19-20020a2e9ad3000000b002b6e9e4d5c7sm617752ljj.35.2023.07.11.13.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:47:47 -0700 (PDT)
Date:   Tue, 11 Jul 2023 23:47:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Message-ID: <4dik7u3sk42itkmp3o7e5r4fx5ziquo6j6f67dq4s3qtp6kzxq@ji2ss2c2n7zh>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-10-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-10-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:41:55PM +0900, Yoshihiro Shimoda wrote:
> Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
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

This is implied by the Suggested-by tag. I'd drop it.

Anyway. The change looks good to me. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 7b720bad7656..44150d34720a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -730,7 +730,8 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  {
> -	u32 lwsc, plc;
> +	u32 lnkcap, lwsc, plc;
> +	u8 cap;
>  
>  	if (!num_lanes)
>  		return;
> @@ -766,6 +767,12 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
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
