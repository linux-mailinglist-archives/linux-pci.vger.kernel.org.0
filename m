Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2154A071
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348358AbiFMUzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352273AbiFMUyU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:54:20 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3E2A964;
        Mon, 13 Jun 2022 13:22:38 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1014b2752c1so2900174fac.11;
        Mon, 13 Jun 2022 13:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lFaHexaRdxVPNQFCPy8/FvVmE4l1eLWQzNnchldgYbs=;
        b=YrLbkqCztE6TLX90V79SP4M5jh1HZQ/n6pvDDWGOVtG4x6dfN2jEfSbdDF25pnmZJS
         RZVCHYRABbOVFFtEDKrdiyPvy7+aN9X7kmxrHx8fgaX72uiZTbLQpgjDw2uek94Wv4vy
         3HXduWawg3awJUQmcCy+/YF/EPH5iRlwze6fL0fK4MAVaKdbTVklj51SDau+ssMUk/fC
         9pD3SN99ncxSf1TUOraSK3PV30cIcOUFjQK4MzlmQQIDpH/U0KprTyOBTbgyNxZWH7FG
         AkpCbVQ6zzXEXcVFfKl4dDZWw8xGNqH+fPArAgz7G60tkwCm9dO+rl/gxMZ1ST2V9M4w
         tlbA==
X-Gm-Message-State: AJIora/oxIeouRsg7fB1mmv8cUZNFNt34KTuKT6LXkEb1M0I9yqhPPO/
        AjwhmaJf+dqQeH7KnbSEMA==
X-Google-Smtp-Source: AGRyM1upkueqH09VtqepikgMZaTQKtGBzRMHbpoNwtgDrb4vQTSM5Zs42JumHg1Omehfdv/EuZ8a8A==
X-Received: by 2002:a05:6870:471f:b0:f3:43f9:720c with SMTP id b31-20020a056870471f00b000f343f9720cmr334687oaq.106.1655151758117;
        Mon, 13 Jun 2022 13:22:38 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id s27-20020a056808209b00b0032eafcbd294sm3675433oiw.16.2022.06.13.13.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:22:37 -0700 (PDT)
Received: (nullmailer pid 4189918 invoked by uid 1000);
        Mon, 13 Jun 2022 20:07:51 -0000
Date:   Mon, 13 Jun 2022 14:07:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Shradha Todi <shradha.t@samsung.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/18] PCI: dwc: Set INCREASE_REGION_SIZE flag based
 on limit address
Message-ID: <20220613200751.GA4188875-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-5-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 11:25:20AM +0300, Serge Semin wrote:
> It was wrong to use the region size parameter in order to determine
> whether the INCREASE_REGION_SIZE flag needs to be set for the outbound
> iATU entry because in general there are cases when combining a region base
> address and size together produces the out of bounds upper range limit
> while upper_32_bits(size) still returns zero. So having a region size
> within the permitted values doesn't mean the region limit address will fit
> to the corresponding CSR. Here is the way iATU calculates the in- and
> outbound untranslated regions if the INCREASE_REGION_SIZE flag is cleared
> [1]:
> 
>   Start address:                      End address:
> 63              31              0   63              31              0
> +---------------+---------------+   +---------------+---------------+
> |               |         |  0s |   |               |         |  Fs |
> +---------------+---------------+   +---------------+---------------+
>    upper base   |   lower base       !upper! base   | limit address
>      address          address           address
> 
> So the region start address is determined by the iATU lower and upper base
> address registers, while the region upper boundary is calculated based on
> the 32-bits limit address register and the upper part of the base address.
> In accordance with that logic for instance the range
> 0xf0000000 @ 0x20000000 does have the size smaller than 4GB, but the
> actual limit address turns to be invalid forming the untranslated address
> map as [0xf0000000; 0x1000FFFF], which isn't what the original range was.
> In order to fix that we need to check whether the size after being added
> to the lower part of the base address causes the 4GB range overflow. If it
> does then we need to set the INCREASE_REGION_SIZE flag thus activating the
> extended limit address by means of an additional iATU CSR (upper limit
> address register) [2]:
> 
>   Start address:                      End address:
> 63              31              0   63      x       31              0
> +---------------+---------------+   +---------------+---------------+
> |               |         |  0s |   |       |       |         |  Fs |
> +---------------+---------------+   +---------------+---------------+
>    upper base   |  lower base         upper | upper | limit address
>      address         address          base  | limit |
>                                      address|address|
> 
> Otherwise there is enough room in the 32-bits wide limit address register,
> and the flag can be left unset.
> 
> Note the case when the size-based flag setting approach is correct implies
> requiring to have the size-aligned base addresses only. But that
> constraint isn't relevant to the PCIe ranges accepted by the kernel.
> There is also no point in implementing it either seeing the problem can be
> easily fixed by checking the whole limit address instead of the region
> size.
> 
> [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     v5.40a, March 2019, fig.3-36, p.175
> [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     v5.40a, March 2019, fig.3-37, p.176
> 
> Fixes: 5b4cf0f65324 ("PCI: dwc: Add upper limit address for outbound iATU")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> ---
> 
> Changelog v2:
> - Fix the end address in the example of the patch log. It should be
>   0x1000FFFF and not 0x0000FFFF (@Manivannan).
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
