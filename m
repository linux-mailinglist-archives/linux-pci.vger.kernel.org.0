Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB45F75F53E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjGXLgw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjGXLgv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 07:36:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F91B1BC
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:36:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso300177a91.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690198609; x=1690803409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OTTO3SuefGHXFKOC7d9wUAk5B36x3nPdZybKoY8w/RA=;
        b=I0yJQHOg9bG3JbzeT8b0UCspH7hw8DYNtxCCur48lOHUBpd3Yu2JwUykNq0bGSybsw
         6g/eJrbyjNYJLHTXQtgSWg/1xO11TDHwBXUR/7i8Pb75+aHqKC9wkmkty15GvhmKHDwF
         tO6JsW7FmoZbSy4w/pgHKf6KlwlYzNMSiRBlPlmVsNin5sDFguGNK9j2C48+kksXSmWK
         IUuo0EXgHL4mr0Zw+jUgGPQCnFy3MCJVJUg+I+ZCxTH/ICdHuZa1eGdiyHQDIU0XbEQi
         zw26xjz93NRkUWYrTKhN/Z1qQ+t9fCHCFLcwDAHyFBHwfWkn33+32vGVxqeKJJdg4pq2
         rH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198609; x=1690803409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTTO3SuefGHXFKOC7d9wUAk5B36x3nPdZybKoY8w/RA=;
        b=E9bBs5IS9/UOBkEPnHuv7JDbxgpMwbJrvgTrudIaYFWvZgDspsh7ZLKuj8WKjm922+
         wYrqsy8glVAFkXIwqxSfeTqpR2qGfeX1HPKO89/hGJRJPfq3IpJwk7nGwz8przAsvGTG
         WhuQsyXo2AaGIo1u2cCY7X2y7iKun2lQMGLRKCOWW4qDOtn03AYSqCWyrHQYE7RfTWdF
         ronpdOt8IK3wI9+gPg5CVpFzxnsPMR89Mp0+VOAy4xvP9GD6Ucd6AS7+pzlGECfcG+2v
         T2tfJ4E/G5xiJG0Gb389ph+riSeNb4tquVFzdzBlr5NjiDjLhtaDCQX+chyXm2B1lGGO
         DMCg==
X-Gm-Message-State: ABy/qLYk4C1uzOC3JWA+9dcranOgyyu7nu1aSoTR+kjeixNEzdwcxrNn
        NjSUVzZN/8dQNjReekM+DWzI
X-Google-Smtp-Source: APBJJlFt6vBWIk6eu6n72lQIAIYxA/NfGYO0MpQrgJEd+5NqR8NAaJ272WrHr5nKC7B4Jw7Ffak32A==
X-Received: by 2002:a17:90a:fc85:b0:267:f329:947d with SMTP id ci5-20020a17090afc8500b00267f329947dmr3234191pjb.33.1690198609593;
        Mon, 24 Jul 2023 04:36:49 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id mj8-20020a17090b368800b00268136571fasm1917619pjb.27.2023.07.24.04.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:36:49 -0700 (PDT)
Date:   Mon, 24 Jul 2023 17:06:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 12/20] PCI: dwc: Expose dw_pcie_ep_exit() to module
Message-ID: <20230724113642.GK6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-13-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-13-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:44PM +0900, Yoshihiro Shimoda wrote:
> Since no PCIe controller drivers call this, this change is not required
> for now. But, Renesas R-Car Gen4 PCIe controller driver will call this
> and if the controller driver is built as a kernel module, the following
> build error happens. So, expose dw_pcie_ep_exit() for it.
> 
> ERROR: modpost: "dw_pcie_ep_exit" [drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.ko] undefined!
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index bd57516d5313..14c641395c3b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -695,6 +695,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  
>  	pci_epc_mem_exit(epc);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_exit);
>  
>  static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>  {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
