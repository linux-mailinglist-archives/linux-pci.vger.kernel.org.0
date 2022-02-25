Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CB64C4D7F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiBYSUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 13:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiBYSUH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 13:20:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011F1F83D8;
        Fri, 25 Feb 2022 10:19:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1A2BB83305;
        Fri, 25 Feb 2022 18:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77C5C340E7;
        Fri, 25 Feb 2022 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645813169;
        bh=ugERf94N2IdiBUmTRyIsLIilviLAnk5eqI1h3HNhzNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W0Ah+BUTDsfviaizpT/D1Q9Eg7lb5OE7YTwndHm9X78XKaAa+NRBCwkPaV4wefjNQ
         z2FlJMpQF4FDvS7GVtakLHQYlwfokQKOqVeqnmFYdpHAa8TxIDCELF2Dw54fWTt8+6
         mTtLA8B00aPCCtrg1qfNBnD/9F2EGLcbwOMpZdyg7AwozQAF4jyOCO+/RiqkyOr/MB
         yxTYdCTD3O1zvSUyb2MFAe5Koj5cvtC4V9gQuFsB78HGdwRe45iVdAST6zCpI14suj
         1er6pl3Y0pdGdl5OD4hbH5B24CQJVAwM0f0jfvf5QOjr+Vi/PmBvlaQ5FyLT6y6qw3
         9jXg5skFMujnQ==
Date:   Fri, 25 Feb 2022 12:19:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        tiwai@suse.com, perex@perex.cz, alex.bou9@gmail.com,
        mporter@kernel.crashing.org, logang@deltatee.com,
        kurt.schwemmer@microsemi.com, bhelgaas@google.com, kw@linux.com,
        robh@kernel.org, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev, nirmal.patel@linux.intel.com
Subject: Re: [PATCH] Removed some usages of the deprecated "pci-dma-compat.h"
 KPI
Message-ID: <20220225181927.GA368545@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223051545.572235-1-yusisamerican@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 09:15:45PM -0800, Yusuf Khan wrote:
> The inspiration for this commit comes from Christophe
> JAILLET in [1], you can find reasons for why this was removed
> linked there. This removes the use of the KPI in some pci
> components and rapidio(whatever that is) devices.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux
> -next.git/patch/?id=ada3caabaf6135150077c3f729bb06e8f3b5b8f6

Commit log may include references, but should be self-contained.  It
should be complete in itself, even without reading the subject.  The
subject line is like an article title; it's not the first sentence of
the article.  It's OK to repeat the subject line in the commit log.

If you do include links like the above, make sure they aren't split
across lines.

Explain why this patch is useful.  Expand "KPI".  Use imperative mood. 
Capitalize "PCI" and other acronyms in commit logs and comments.
Remove "(whatever that is)"; it doesn't help justify the patch.

Subject claims to remove usages of "pci-dma-compat.h", but I don't see
any mention of pci-dma-compat.h in the patch.

More tips:
https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

Bjorn

> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> ---
>  drivers/pci/controller/vmd.c     | 1 +
>  drivers/pci/switch/switchtec.c   | 1 +
>  drivers/rapidio/devices/tsi721.c | 8 ++++----
>  sound/pci/asihpi/hpios.c         | 1 +
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cc166c683638..244dc0f2f71e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -17,6 +17,7 @@
>  #include <linux/srcu.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <linux/dma-mapping.h>

Explain in commit log why this is important, since this patch doesn't
add any new use of things from dma-mapping.h, and it doesn't remove
any interfaces from other header files.

>  #include <asm/irqdomain.h>
>  
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index c36c1238c604..05a876ec1463 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -15,6 +15,7 @@
>  #include <linux/wait.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/nospec.h>
> +#include <linux/dma-mapping.h>
>  
>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
>  MODULE_VERSION("0.1");
> diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
> index 4dd31dd9feea..b3134744fb55 100644
> --- a/drivers/rapidio/devices/tsi721.c
> +++ b/drivers/rapidio/devices/tsi721.c
> @@ -2836,17 +2836,17 @@ static int tsi721_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Configure DMA attributes. */
> -	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
> -		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
> +		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>  		if (err) {
>  			tsi_err(&pdev->dev, "Unable to set DMA mask");
>  			goto err_unmap_bars;
>  		}
>  
> -		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)))
> +		if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)))
>  			tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
>  	} else {
> -		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> +		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
>  		if (err)
>  			tsi_info(&pdev->dev, "Unable to set consistent DMA mask");
>  	}
> diff --git a/sound/pci/asihpi/hpios.c b/sound/pci/asihpi/hpios.c
> index 6fe60d13e24b..08757c92aee5 100644
> --- a/sound/pci/asihpi/hpios.c
> +++ b/sound/pci/asihpi/hpios.c
> @@ -10,6 +10,7 @@ HPI Operating System function implementation for Linux
>  (C) Copyright AudioScience Inc. 1997-2003
>  ******************************************************************************/
>  #define SOURCEFILE_NAME "hpios.c"
> +#include <linux/dma-mapping.h>
>  #include "hpi_internal.h"
>  #include "hpidebug.h"
>  #include <linux/delay.h>
> -- 
> 2.25.1
> 
