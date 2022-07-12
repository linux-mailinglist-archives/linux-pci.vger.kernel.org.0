Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0DC57269A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiGLTto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiGLTsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 15:48:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A620BD6A0;
        Tue, 12 Jul 2022 12:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 032E1B81BD0;
        Tue, 12 Jul 2022 19:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F76CC3411E;
        Tue, 12 Jul 2022 19:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657654883;
        bh=A8IHI6uBF4PEsAf4qntIS6Lk50a5/zGqa5XnyLKFtf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sB1J0NLa0XjUbBeirYQ2QSsa5I6dnLPfNBFn334MLKmsYwlD564iE2yVRni0ms8UW
         l2t5IQ50TlaS7YUTftiL/z6Cd0hTSSlLKPt1A//m8zBolHVpnw78D+la5BFMq0zK8/
         ZRYtfHH5VrTnK7dMrvwRnMLfDwWT2yn5bBqIdmtuJJ2McEU+YTvKOu89phZO1LSFXZ
         odQqanGVuU4U4QeH99Hya3FT/dyDczK701un2lMRWRFmcGjX4WNr/WCOEZZlc2+DEb
         TkZ83VdIylNl82C19AwwPIx2khtnvDbfBDtcno+Wvb8M9rWqWmCJEULpCR+baqMHyZ
         NZ2v0FFLZ86yg==
Date:   Tue, 12 Jul 2022 14:41:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] PCI: dwc: Use the bitmap API to allocate bitmaps
Message-ID: <20220712194121.GA789611@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6586a603abc0db7d4531308b698fbe7a6d7083.1657375829.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Serge]

On Sat, Jul 09, 2022 at 04:10:52PM +0200, Christophe JAILLET wrote:
> Use devm_bitmap_zalloc() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to pci/ctrl/dwc for v5.20, thanks!

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index fb887495f53e..ad54aaa71a02 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -721,17 +721,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> -	ep->ib_window_map = devm_kcalloc(dev,
> -					 BITS_TO_LONGS(pci->num_ib_windows),
> -					 sizeof(long),
> -					 GFP_KERNEL);
> +	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
> +					       GFP_KERNEL);
>  	if (!ep->ib_window_map)
>  		return -ENOMEM;
>  
> -	ep->ob_window_map = devm_kcalloc(dev,
> -					 BITS_TO_LONGS(pci->num_ob_windows),
> -					 sizeof(long),
> -					 GFP_KERNEL);
> +	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
> +					       GFP_KERNEL);
>  	if (!ep->ob_window_map)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1
> 
