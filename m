Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAFD72248D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 13:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjFEL2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 07:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjFEL2t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 07:28:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470CCB8;
        Mon,  5 Jun 2023 04:28:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso5225074e87.0;
        Mon, 05 Jun 2023 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685964526; x=1688556526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28LV0R6aDTC+rdDirYQF7rKwUft/W2ivVNFJzscM3tQ=;
        b=TDsOnRr72izZWk/x3U9c/aoZtG3tcKaiHCJ4OydNZC8AqBzAHs8bmVLxNWIZA1NHvE
         qrb3e8bYS8qED/OXFHs4t2WNmUpp35iFh2LXPNVI7figBr73meu8Xp11TcUAH/ayEj0O
         P/tjJqu/uWgjRcMnCoClAm45Je9fqwscsho2aEpHKZQIiiVX58h8x/wKRf2BcL+qQ0uM
         Wa93gHspjXS9paBzY90pgC8Xj5RIZIdJARqiHOuMWcVgDFrK8Qvdljwt75wu462iEDVV
         Yytth2IB6ii5XFfWQyMysyiIgxzgn5Wpzn9RyFYg8CAsrgx3Hc2s3R7ES4XiZ2yq4Vgf
         giiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964526; x=1688556526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28LV0R6aDTC+rdDirYQF7rKwUft/W2ivVNFJzscM3tQ=;
        b=cx9naDVDwOoFCeTkeivZKEPpUFsHiw8vhtCWz3jbxzwcF25WLTmku//JmzBjlJ6lAz
         GQOSPGVQ1PVnxXYdyUz/T+AT/kILVTxDyZPWR3Gu+y4SOEOIgkQnasQx1r2EJ8UkSvvc
         hCP+uFNGtPvV7CakzBJiYbSBRZoMexM8lsUIfInGp9V6VRBl749fBuAqzEUnWvWf/m8n
         89Lp1LI7ke86jsBkWriLGkAxPIJOe0iOIFyWWAXoviq4GfZzYvlKJOlgBEiDfGBc9iOX
         O0vFxLq3Lq1K8QGMlT8HYbRESSqIMS4uvtep1MThzQ8qXg0x55iotz4Z3buvQiPahYf4
         BDcg==
X-Gm-Message-State: AC+VfDyOlRb70o58HnPOUBgmiczatgFFsbds7ABXUGSRK14eaLctHw+E
        eOS3pwUmtOSETgg2YrmH8IA=
X-Google-Smtp-Source: ACHHUZ5o8YrlM2e8p1tEZ3Ut6pPauKciDDlu+Jyl4qKj71Ixxr24SccAISmW/lLJZ7tG85++/Nz6Kw==
X-Received: by 2002:a05:6512:3402:b0:4f1:21a2:9006 with SMTP id i2-20020a056512340200b004f121a29006mr3001070lfr.18.1685964526368;
        Mon, 05 Jun 2023 04:28:46 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id f14-20020a19ae0e000000b004f27cecb68asm1080986lfc.166.2023.06.05.04.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:28:45 -0700 (PDT)
Date:   Mon, 5 Jun 2023 14:28:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 14/22] PCI: dwc: Expose dw_pcie_ep_exit() to module
Message-ID: <20230605112843.2duqfuzzp4mz72wp@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-15-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-15-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:26PM +0900, Yoshihiro Shimoda wrote:
> Since no PCIe controller drivers call this, this change is not required
> for now. But, Renesas R-Car Gen4 PCIe controller driver will call this
> and if the controller driver is built as a kernel module, the following
> build error happens. So, expose dw_pcie_ep_exit() for it.
> 
> ERROR: modpost: "dw_pcie_ep_exit" [drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.ko] undefined!
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Looks good. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0abc0073b1cf..023938468b5d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -676,6 +676,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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
