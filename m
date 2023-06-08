Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3EF72862B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjFHRTi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbjFHRTh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 13:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62072727;
        Thu,  8 Jun 2023 10:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51AF864FAE;
        Thu,  8 Jun 2023 17:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DCAC433D2;
        Thu,  8 Jun 2023 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686244773;
        bh=6ad4Ze1/w0HwSx4VHiAz44pNtRELAkpuEtOfWAJU1Eo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YdfcfRKqLJ40FuDdoTSVmRM59ViFQ9d62OUiQnwXIXPAteXBAEXPSS1RwfI34G5Q/
         IXT7FFgFG83agNDw1g2EZmqgIuAXoBm5Y2tnLegxMyp4PhZsYj+N4eHL+kq8pr2CC7
         crFZoqJyfoVY6ZKzBAsac8uLYJvnSMaaXYhuGhUkZlno6X9sN4zviMFHrKEFNm8cW7
         xzvDsHK2w/T1vIdlTZfAjlvk6uxU9Cs6UOjLU+j7K4/jtix0t5hdaNiGHVC4oEwhRq
         pMYw3WUhTeuRw1Cwha0qtfFWslBtasx/UMavhic7exuLXedpc+q6J+WE7wAz1k6i+c
         9jhxtxE3aMKSA==
Date:   Thu, 8 Jun 2023 12:19:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        hch@infradead.org, stable@vger.kernel.org,
        Jason Adriaanse <jason_a69@yahoo.co.uk>
Subject: Re: [PATCH RESEND] PCI: Add function 1 DMA alias quirk for Marvell
 88SE9235
Message-ID: <20230608171932.GA1206912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731507e05d70239aec96fcbfab6e65d8ce00edd2.1686157165.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 06:18:47PM +0100, Robin Murphy wrote:
> Marvell's own product brief implies the 92xx series are a closely
> related family, and sure enough it turns out that 9235 seems to need the
> same quirk as the other three, although possibly only when certain ports
> are used.
> 
> CC: stable@vger.kernel.org
> Reported-by: Jason Adriaanse <jason_a69@yahoo.co.uk>
> Link: https://lore.kernel.org/linux-iommu/2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk/
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied with Christoph's reviewed-by to pci/virtualization for v6.5,
thanks!

> ---
> 
> Note that the actual regression which started the thread is a different
> matter, wherein a particular combination of parameters which used to put
> intel-iommu into passthrough mode now enables full translation instead.
> 
> Take #2, hopefully not royally screwing up my email alises this time.
> Sorry about that...
> 
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f4e2a88729fd..3186f2c84eab 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4174,6 +4174,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
>  			 quirk_dma_func1_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
> +			 quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
>  			 quirk_dma_func1_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
