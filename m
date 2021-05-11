Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198E837EE1C
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 00:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhELVJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 17:09:52 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:34606 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385216AbhELUHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 16:07:12 -0400
Received: by mail-oi1-f179.google.com with SMTP id u11so2261174oiv.1;
        Wed, 12 May 2021 13:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9pvaNQbaZ0JgyvODdWZwavQBDW4Sq1V27DHy5plA08=;
        b=Bs+MIWocyI6eQydWD4C0OQCCfID6fufGGPAfbhu9w9OvT1tDCUkz3tT9rZ54egg/Xj
         ELzlObqWDfHmBWg+OjHucVuHamjG/dTbPXiiH/t0bs0mc1UCLCuOYKGS399smWwWYci7
         V8v5YgjrJTc/6uFPQA6XL8YMkn8uYbewQuxzNYBu6LSVORSOfKTHN83KAUOcqoKdef/h
         hR3CDGA2e/akTbph33P6doO5QRgVZYWYwxihjkYn2C+Yw7IwdEaDjvMmLlEA2Pruae+8
         BqQg+khZFy6xsg3Y/MjKE35tgOYdOpj4qLqR5aDzIm5HMzd5Q0E6g1qLiUI6Yh0o4o4S
         gmxg==
X-Gm-Message-State: AOAM5337pXHMBW5w5RMfadLYHWfOdihsJ9zce99g6a8uBtl90ejX/Vzb
        GD1R8QZmJnpZoMGCDOaqkA==
X-Google-Smtp-Source: ABdhPJy6CnmLDiQrFvHadXJPsKWobYjYr5uPBTivUVuM8Ii+QPrAaP0BQzUEzuvT3qM4jwe9xME6fg==
X-Received: by 2002:aca:a9c4:: with SMTP id s187mr27541244oie.47.1620849962949;
        Wed, 12 May 2021 13:06:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w15sm201059oiw.34.2021.05.12.13.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:06:02 -0700 (PDT)
Received: (nullmailer pid 2513722 invoked by uid 1000);
        Tue, 11 May 2021 20:03:52 -0000
Date:   Tue, 11 May 2021 15:03:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH 2/7] PCI: imx6: Initialize ATU unroll offset
Message-ID: <20210511200352.GA2503503@robh.at.kernel.org>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
 <20210510141509.929120-2-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510141509.929120-2-l.stach@pengutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 04:15:04PM +0200, Lucas Stach wrote:
> This gets rid of a warning printed when the common code tries to get
> this address via non-existent DT reg region, before falling back to
> the default offset.

I guess I caused this... If this is a problem for i.MX, then isn't it a 
problem for everyone without a separate 'atu' region? I think the right 
fix is having an optional variant like we do with other resources.

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 46b5f070939e..922c14361cd3 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1063,6 +1063,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
>  
> +		pci->atu_base =  pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> +
>  		fallthrough;
>  	case IMX7D:
>  		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
> -- 
> 2.29.2
> 
