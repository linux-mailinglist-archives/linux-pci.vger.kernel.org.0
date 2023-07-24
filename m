Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8075F436
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjGXLEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 07:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjGXLD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 07:03:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7090
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:03:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99b78fda9a8so400615666b.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690196636; x=1690801436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwgNTpeLiJmhaS6FZfkTg6RI3k2tfz3sXEYSaSjuNRE=;
        b=NmLGeygU9VwCTGioM/ca+zHRZok3Qy7BVptJHVoZk6QkKq1esGXbrQMijZi27bC0eZ
         mAW+ZAfau0HADac6gPihZ0gcWtpqcyDdGfsOqjuX0kzM1CLdWiJ44tppYEQgxA5WANc+
         AUGFWG46FlFbM88xF0JMnnnhuKQnoZn4wZRiJUzB4NdRGPIR2qtOcFw0Srg4SLwdKM22
         p/N245PYKXi1usF9kwfwAIkmWJFAxq482DOz9l1obPHOjl1OCjepvHTyz/FP9Nl+KPa8
         4f6pys/fKbKbhiBlNw82mnL72C9GLVhywjTHbXn6ZUTBQsEJ5luXtypQRlluADRbmB+2
         Lodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196636; x=1690801436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwgNTpeLiJmhaS6FZfkTg6RI3k2tfz3sXEYSaSjuNRE=;
        b=mCnwV/18MrUdQFy/HMii+6W0pFAzNWnQlC9tzE4sXrSeb4PVBwbDn0uQlywSMjtkaJ
         WlUZptY+pwSKWo56mBX6nG8I0hbyJyingmMLdXueVyXWda99VqB0bM6/bOA/sBH/aIaZ
         NmjFv9SEgeJlrDsIDvMhM1eTjgqAj7rcmls2ReLvUF+0Kha+vMt/gpcbxKy1A/MB+Cew
         heJ6OR+mIPNxwyTsOWcbUXr/1qF2zn3fr9sCWEhdJmzqmA/+k+ccw0lOn5WKbwP5sC39
         Ruaa9NpBTPNTRyp1VnWciFEdCJphQ6Mz6isWEnEdLfUfYRSGpP/J8ADcl3c0Y4HQsRub
         Tr1A==
X-Gm-Message-State: ABy/qLZymY3RORe0hRuawlyt2mLk5NKuEr2EuIFdtxd4u1uzLlkM/hJo
        Y6Apts9roBujh0bXB6GCZr8L
X-Google-Smtp-Source: APBJJlHGl8UyNC1QTi3xRTHHNd/GFgVF+TRzS3jBXfWUnzxhvZFaPiMRMnfgyy0T5Uwuat/0kjsv5w==
X-Received: by 2002:a17:906:15b:b0:992:528:abe with SMTP id 27-20020a170906015b00b0099205280abemr9709815ejh.53.1690196636448;
        Mon, 24 Jul 2023 04:03:56 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id xa23-20020a170907b9d700b00992e265a22dsm6518784ejc.136.2023.07.24.04.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:03:56 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:33:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Message-ID: <20230724110344.GH6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-10-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-10-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject should contain the word "missing". Like, "Add missing PCI_EXP_LNKCAP_MLW
handling".

On Fri, Jul 21, 2023 at 04:44:41PM +0900, Yoshihiro Shimoda wrote:
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
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>

Add Reported-by also?

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This looks like a potential bug fix to me. So please move this change before the
previous patch that introduces dw_pcie_link_set_max_link_width(), tag fixes and
CC stable list for backporting.

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 5cca34140d2a..c4998194fe74 100644
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

-- 
மணிவண்ணன் சதாசிவம்
