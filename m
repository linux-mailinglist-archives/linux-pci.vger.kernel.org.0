Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD2A604DFE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJSRAI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 13:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiJSRAF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 13:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3070F14139B;
        Wed, 19 Oct 2022 09:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4377861950;
        Wed, 19 Oct 2022 16:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F91C433D6;
        Wed, 19 Oct 2022 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666198789;
        bh=Qfgel5eqKPaG66KxU7z+dOargyR/X6ykmUftY2mN8Gs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CkIZdFGuuckTzAnS9JQObYT71o+q1NR+YTGo7enOKETgUnqypBbCMhVpPNfLz+7EC
         El5ZIGbJIuIoX/BVL4x8dyeG2LevMjgTM7AsyHMOZE0DGc8B8DX6E658wo7ayoAIbn
         nGfCJMvRUCMUZ9HAFhBKSMvd/dWf72yLtaU0Spl6F2V8D8z53lez6AzFuqArwC1aOQ
         7QTKrGZpVtwWW/psymcIhjhd6B+8IJMMzc+0jlk17fjd6bHt4KuB3zYPkye5ZQfIDO
         pxZKCrabWG/BlX7VjGjsG+/WvoZtNm61YdzQ2Gb9MbelLs61xTflvPiru2eRlRwxpv
         +MKQpfBYqm1fg==
Date:   Wed, 19 Oct 2022 11:59:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS: Add Vignesh Raghavendra as maintainer of
 TI DRA7XX/J721E PCI driver
Message-ID: <20221019165947.GA24393@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928093105.23073-1-kishon@ti.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 03:01:05PM +0530, Kishon Vijay Abraham I wrote:
> Add Vignesh Raghavendra as maintainer of TI DRA7XX/J721E PCI driver.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Applied to for-linus for v6.1, thanks!

> ---
> Change from v1:
> Added "PCI" in the subject and commit log.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aef4632f4e87..ffad3f1dfe9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15667,7 +15667,7 @@ F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
>  F:	drivers/pci/controller/dwc/*designware*
>  
>  PCI DRIVER FOR TI DRA7XX/J721E
> -M:	Kishon Vijay Abraham I <kishon@ti.com>
> +M:	Vignesh Raghavendra <vigneshr@ti.com>
>  L:	linux-omap@vger.kernel.org
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
