Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1BF788E7A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHYSSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHYSSe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 14:18:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415212705;
        Fri, 25 Aug 2023 11:18:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ff9b389677so1802652e87.3;
        Fri, 25 Aug 2023 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692987489; x=1693592289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0X3UqX4m99dG470vbFBA7W9C4W7OMNMtr/Z96kDhMs=;
        b=iG1qbLOX8d+NuaIbJ1xmEQqMRolLCEzoM5JPoNp4iFH96pIGlbFXSx3BPClrUVQ3Ww
         aJR2GTNgSqQF14VR9Z1s6WpqC+Wlzj2cRqXSgE3dxMa5yAiWa+1/Pg8itG21Dh15LxX4
         jJLUEBk9+734O8LnUnHHG41pof4Lky1VZ2P00M5sIVETXcLIxlX+ONjDKQEO/nHTL0AL
         YRfPpwglkvCncq6rREgHMTxi95gliBR8Zyl+kEKkwyQJ/Oi74KZ6JoJIDThPTP8+3K98
         oBKAu6alXubNJqGEZELyDs+lHXilgYHGjIctLNBOqX/9HKyoWvzm6eio4C6qSy0kojHT
         R+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987489; x=1693592289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0X3UqX4m99dG470vbFBA7W9C4W7OMNMtr/Z96kDhMs=;
        b=f6fo1apF0qC5iuCLIIc4hfZSQBOgdaU4Qya4wSbVPPxcfcexjkxrNzv7idftrKqpUz
         tBaQ0vUU5uwpdovZv9bZR890Mh0wyiANlC149KEmxkzc1l9FRyZjZBXqBXa1tb7DZD68
         Bbbb4ozes5aVNsmUOAEqSCtpCqkOz412VmmfgUazX0OMdrpJz9kBn/iwT4uILVZHqq00
         uCE5xMz2QBcsudhHP/eVCXONJO1SkjdXmsGIPlBNwr3rwTVSp+2T6ZGpEONuzQM3I3TC
         hANEDK8tbZRVF2hyXsiJYe7i3CVkRrc7SJNqdz2ZdJOMbXtnz1O2UGOn98DdVFUGbAGY
         Xc8Q==
X-Gm-Message-State: AOJu0Yym4bBLFdi4il09eaRHhSwhkdDp0u2+n5go3yuNcUpm39Ia4f0Q
        xnwSkGz8SpX737qXc3gN780=
X-Google-Smtp-Source: AGHT+IH5d+Nt32DIwba3HQHbsK6SbVRgHFZWL8JySCUSi7WSepToNY476wR1fVaKgms6PZG7slXPqg==
X-Received: by 2002:ac2:4285:0:b0:500:9977:bdce with SMTP id m5-20020ac24285000000b005009977bdcemr5509455lfh.62.1692987489262;
        Fri, 25 Aug 2023 11:18:09 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i22-20020ac25236000000b004ff981955cesm376054lfl.228.2023.08.25.11.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:18:08 -0700 (PDT)
Date:   Fri, 25 Aug 2023 21:18:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 11/19] PCI: dwc: Expose dw_pcie_write_dbi2() to module
Message-ID: <bc26tzeh5bcqtuz6opfb4pxp7avtmqlzm6xszmqvmjalwi7yhi@iy6ogi4beqpi>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <20230825093219.2685912-12-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-12-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 06:32:11PM +0900, Yoshihiro Shimoda wrote:
> Since no PCIe controller drivers call this, this change is not required
> for now. But, Renesas R-Car Gen4 PCIe controller driver will call this
> and if the controller driver is built as a kernel module, the following
> build error happens. So, expose dw_pcie_write_dbi2() for it.
> 
> ERROR: modpost: "dw_pcie_write_dbi2" [drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.ko] undefined!
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4812ce040f1e..0251fa1357f9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -365,6 +365,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
>  	if (ret)
>  		dev_err(pci->dev, "write DBI address failed\n");
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_write_dbi2);
>  
>  static inline void __iomem *dw_pcie_select_atu(struct dw_pcie *pci, u32 dir,
>  					       u32 index)
> -- 
> 2.25.1
> 
