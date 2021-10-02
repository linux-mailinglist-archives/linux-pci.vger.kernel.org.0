Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE541F8D7
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 02:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhJBA4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 20:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhJBA4S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 20:56:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D936C0613E4
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 17:54:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so44535830lfu.2
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 17:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2wsRq/ajxwUJkBE+PhgJg+DVvYk3pVsO7j0TG7nuEIw=;
        b=A07vTvrETFdwuckhChSe786ddI2HgpmdTOmIYnNQ3kQS/fERxiBkggvWKMVlv9aucI
         lzwuLVSfCHosI/wgApmulGin5m9plQozeVdeDUAfhAfDXdF5Mx2qFIOgAByebv1zLYLC
         Y5DSLyrm/THBSZgn2/Yx+CypIIzjR9JbGyxvJ7n7tD3sqIVXam7MyR2IuAyQ7AsTTPYB
         2ygKXG7BMdsh9mY1JNJ3prMaGO3Akoa/+UhV5voBOYY7j4OG0yiiyZDusrDsWIi4LtH5
         keXlm+5JsVAx04FgF8FhywRAlHVrJvMXlZNBuOL7b62M8HyeVRzpwpx3egTKWlxYGWfy
         DjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2wsRq/ajxwUJkBE+PhgJg+DVvYk3pVsO7j0TG7nuEIw=;
        b=FTayDdJNlSsfEzrX0cxZSKl73qnivU15K7geG2bmw5m2vtTo/EsLsFYIAjZCnQvQKr
         05M/t8wycFTz9DEAe5JCVcVyjLVto6WCGsGEYnEGj4Q+TgdpKgxmdpyqhxtVFqtGRK6Z
         c/ywIULvnkqA4nqf0+ofJ4OwZAoHcSrWVbo5NGOJTzFZoyUQaaxo6O1oeZavj4WA1+tF
         ZltHX35xKw6N39HyQGTlTI598YiAdUkJMplvyI0xE1gtba6ROGtz7+6Q3GmbgSSQU5NN
         JVWfULpRKKbutviS/M7oGS6FMRXgJN1H1ez/Ogrr7R1tQCUKTOyXDiMLiS4IsPNGb62d
         kUjQ==
X-Gm-Message-State: AOAM532W3EtekAdUenaAc6xF0syZFF9pqbmRwcEv2lqiI7ADo+mtkTGN
        dtefx7hTg8dRlWR1dLSiPDTX/O5vhXY15p9i
X-Google-Smtp-Source: ABdhPJwLTnEgVGnvm84laUxgvNcto0UDXBfNgUyZmS94AiFtHZJBO3j6blFVn8v7liMgetjRUGP/Gw==
X-Received: by 2002:a2e:a688:: with SMTP id q8mr997155lje.7.1633136071561;
        Fri, 01 Oct 2021 17:54:31 -0700 (PDT)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id w4sm974355lfr.150.2021.10.01.17.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 17:54:31 -0700 (PDT)
Date:   Sat, 2 Oct 2021 02:54:30 +0200
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
Subject: Re: [PATCH] PCI: rcar: pcie-rcar-host: Remove unneeded includes
Message-ID: <YVetxthvPMF5HC+f@oden.dyn.berto.se>
References: <54bed9a0e6991490ddb2b07e5abfaf40a7a62928.1633090577.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54bed9a0e6991490ddb2b07e5abfaf40a7a62928.1633090577.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2021-10-01 14:16:43 +0200, Geert Uytterhoeven wrote:
> Remove includes that are not needed, to speed up (re)compilation.
> 
> Most of these are relics from splitting the driver in a host and a
> common part.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/pci/controller/pcie-rcar-host.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 8f3131844e7778cf..e12c2d8be05a34e2 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -24,13 +24,11 @@
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/slab.h>
>  
>  #include "pcie-rcar.h"
>  
> -- 
> 2.25.1
> 

-- 
Regards,
Niklas Söderlund
