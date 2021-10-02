Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C371541F8D2
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 02:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhJBAzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 20:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhJBAzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 20:55:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA125C061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 17:53:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g41so44745125lfv.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 17:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WcEn+xDwdE6ANwPheEYJ3oKi+dkCUQOxoB+aEfMXDQU=;
        b=UKNNFxLkOmXxEm8PTFodJLrnzuOX+eFVXK0edxl3dV9nbczyMakfr78HdxNzh+O8RL
         fBdNDqOUPR5wSsgUcthGQWYNF5R9JerTXPAW5eUn1gxXzdioqsHzdTPfeSAxDJwUcD04
         NrtjxyT0p0u5jXOW80e7pBw4BUIgfB+smAtL0pliuSNZN+8V7jzXMFLN6zHm7DZlBlEc
         m0rm3ZVk44rPuHUjG1SGUpGrX6fFSM0eUATpkySn+VfvWYz9A+RnLILipUZM6/luanDo
         1SzsbAhEmcVfyLL2uhK+ZNJ6mwfOZN0JgIBP5C1IizNk/yxnpUyfNoVD1btWDG8iecm8
         ZH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WcEn+xDwdE6ANwPheEYJ3oKi+dkCUQOxoB+aEfMXDQU=;
        b=dOdztUzspdk4wFbClqu47wDU3d08TgRIzWqdJv8jLFMAYzrrI1f8c361djfroMRBvu
         8I8DMHdDG+6IwltfegfDxuVVhpCKwFLPEqz3Y+Unszm5fSMWEiJwWqtVNTr86LY04fGa
         tWAnWsrFPIqXw4zn8JnkiopXJ1chqXDIrHoi+RQI5f1+UjsByHwIan8bogGZbwCCcAGq
         h2rQ5rkyDCsslOCKW6N5nXZt65cXlANQMAQHuMgfdf/1hyum5sfjtHEDISfS/nD3s/8T
         A+BrXXoo0mahaYlVKRhguHXEZh643WMOFNVMR4qo3Z3j98Ry3trykwliEfeG2TP40elr
         SSmA==
X-Gm-Message-State: AOAM5301cr6rODW8RopUcORtk1lTkqPeLEPGm7JirssNZ0dKf8+5wIhd
        V8i8dJnx3pU24GO4gss73un1Zg==
X-Google-Smtp-Source: ABdhPJyU2hgzqqtbWAN8CVVV8cWykNdLr8xwwLnsgGOXHHoAdg8EPMNwGiTmPmrsU++Qnr8ibfpurg==
X-Received: by 2002:a2e:a596:: with SMTP id m22mr1118720ljp.262.1633136016474;
        Fri, 01 Oct 2021 17:53:36 -0700 (PDT)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id j16sm564960lfh.119.2021.10.01.17.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 17:53:35 -0700 (PDT)
Date:   Sat, 2 Oct 2021 02:53:34 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: pcie-rcar-ep: Remove unneeded includes
Message-ID: <YVetjjnDTuMrEVrB@oden.dyn.berto.se>
References: <7c708841a2bf84f85b14a963271c3e99c8ba38a5.1633090444.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c708841a2bf84f85b14a963271c3e99c8ba38a5.1633090444.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Geert,

Thanks for your work.

On 2021-10-01 14:16:09 +0200, Geert Uytterhoeven wrote:
> Remove includes that are not needed, to speed up (re)compilation.
> Include <linux/pm_runtime.h>, which is needed, and was included
> implicitly through <linux/phy/phy.h> before.
> 
> Most of these are relics from splitting the driver in a host and a
> common part, and adding endpoint support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/pci/controller/pcie-rcar-ep.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index aa1cf24a5a723d5f..f9682df1da61929b 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -6,16 +6,13 @@
>   * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>   */
>  
> -#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/of_address.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/pci-epc.h>
> -#include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "pcie-rcar.h"
>  
> -- 
> 2.25.1
> 

-- 
Regards,
Niklas Söderlund
