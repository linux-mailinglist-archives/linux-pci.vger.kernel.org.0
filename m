Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E783567826
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 22:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiGEUDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 16:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGEUDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 16:03:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DEA5FF3;
        Tue,  5 Jul 2022 13:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C5F61B91;
        Tue,  5 Jul 2022 20:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01E8C341C7;
        Tue,  5 Jul 2022 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657051422;
        bh=z+VSOPZHJdUGcIPzt3HH3vim1AKYQpXZNPySuOqur1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CzGjJ6s+WAWlKor2phjuf7ooM/Vupuguc09eReuXWoPLeN4ANOmN38Bt7+GaaUuuY
         vTjkp+Xl37VN2DXwTigD++pVNzozDZpHfGrUKdyNlDX4hC61PaETI31VPXle93gjsH
         vQPEuY9y4aLonw3G560bNngRJ6YdG5lWcIvyndrf7zBKWh+he8dRq7YVEjuABE1Qy8
         gHw6zKb1OS6jec1P+yxCglegfhkHdNwQlF8MrQgSeEt0DlTvR7gdVVsatUM6yJ9V4C
         VL194AOgBWCYMj+V+9uFVBKj6y8Mf0uY9XNScPbx7sYdQaRatOoesNGbI9dq2rzXXQ
         tjTFuxtNwEZMQ==
Date:   Tue, 5 Jul 2022 15:03:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: iproc: Use the bitmap API to allocate bitmaps
Message-ID: <20220705200341.GA80171@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d839a951358ceb447226dc776590a2a38f3e3f9d.1656940469.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 03:15:03PM +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied with Ray's ack to pci/ctrl/iproc for v5.20, thanks!

> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 757b7fbcdc59..fee036b07cd4 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -589,8 +589,8 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
>  		msi->has_inten_reg = true;
>  
>  	msi->nr_msi_vecs = msi->nr_irqs * EQ_LEN;
> -	msi->bitmap = devm_kcalloc(pcie->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
> -				   sizeof(*msi->bitmap), GFP_KERNEL);
> +	msi->bitmap = devm_bitmap_zalloc(pcie->dev, msi->nr_msi_vecs,
> +					 GFP_KERNEL);
>  	if (!msi->bitmap)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
