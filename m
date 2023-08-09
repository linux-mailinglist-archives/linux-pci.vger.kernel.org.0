Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293D2776C90
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjHIXFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHIXFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 19:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA6E75;
        Wed,  9 Aug 2023 16:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68AE3646B1;
        Wed,  9 Aug 2023 23:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13FAC433C9;
        Wed,  9 Aug 2023 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691622320;
        bh=YHx+lf+dtplJr3oAdqzBjUhkDbSNun/kjg6ucBP6Y9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B85PEc4XOIQJLVeEYGrVbEEGEnX0kQVAY9OWcv82s0BpuQ7vkLyKItDkHVK4N1aor
         bBa3NcV7L5X6lu6CVbTDN3Sn9T3ufADd6hCf8XHet6IshzunXqy7rzhl9uTbapwqNd
         EzLnf50EZmcmVoJ6kQeW4AghThn1TAC3BF81vooC/O7pVGRcForhclTwGoszbfXN99
         YNpIlcUoijPrSOwVlPTXYjyuqvNyG5uCPMT9QI3XSZKxB3/FK51VXBd8J2aSh3tzjZ
         Tyby4ap2GwBA6PmPpXRmb7unLUHGVu+9RMwi7oqOnnsrJ8EkM1SX3dCE6OjYovoAwj
         DwmBulKcGAAUg==
Date:   Wed, 9 Aug 2023 18:05:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     lukas@wunner.de, sdonthineni@nvidia.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wllenyj@linux.alibaba.com, wutu.xq2@linux.alibaba.com,
        gerry@linux.alibaba.com
Subject: Re: [PATCH] PCI: Mark NVIDIA T4 GPUs to avoid bus reset
Message-ID: <20230809230518.GA12130@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dcebea53a6eb9bd212ec6d8974af2e5e0333ef6.1681129861.git.wuzongyong@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 10, 2023 at 08:34:11PM +0800, Wu Zongyong wrote:
> NVIDIA T4 GPUs do not work with SBR. This problem is found when the T4
> card is direct attached to a Root Port only. So avoid bus reset by
> marking T4 GPUs PCI_DEV_FLAGS_NO_BUS_RESET.
> 
> Fixes: 4c207e7121fa ("PCI: Mark some NVIDIA GPUs to avoid bus reset")
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Applied to pci/virtualization for v6.6, thanks!

> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf95..be86b93b9e38 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3618,7 +3618,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
>   */
>  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
>  {
> -	if ((dev->device & 0xffc0) == 0x2340)
> +	if ((dev->device & 0xffc0) == 0x2340 || dev->device == 0x1eb8)
>  		quirk_no_bus_reset(dev);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> -- 
> 2.34.3
> 
