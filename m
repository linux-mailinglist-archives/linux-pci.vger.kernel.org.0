Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D40E7BBFC0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 21:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjJFTgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 15:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFTgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 15:36:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D883;
        Fri,  6 Oct 2023 12:36:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F44C433C8;
        Fri,  6 Oct 2023 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696620971;
        bh=uU75gGc/mU2MCCDeRgAfU3mJXITt7ggSvRzVht76IfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dbHBJVTnWMzuLnfLpNAK2A3NvbD7TavxkiRkgAsQAvHTm/4Zbsw2ufdUY1AXLXFuO
         rPi2DqPwtEzjKKZXJUNRjK/ZFmgXmTl3MEmw7BL8oSn/ObKAQAu4DH9/uGZMpRZkXp
         iYhBjokPm17RMpMzAN4UtCeBE9k05cM7wJvYUvLkU46y/ZkbosMa0qU76PGXVMnYgL
         6XDKbnxquLyXq9goeyjcik0ISO0VKkwSODUjVYpZ7Y3UIGT7hbe16GKI2UKpVoLcpQ
         ly6Jl5HCUxu1bgSqrLcibepDc7MIEHz1mE7SYbq9ouOMoyP5nhnQg++Do/Fz/ffsIE
         HUfEuELeoGfFA==
Date:   Fri, 6 Oct 2023 14:36:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] PCI: eliminate abnormal characters when reads help
 information of "PCI_P2PDMA" under menuconfig
Message-ID: <20231006193609.GA865463@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1658301723-111283-1-git-send-email-liusong@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 20, 2022 at 03:22:03PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Read the help information of PCI_P2PDMA through make menuconfig,
> "Enables" is partially displayed as garbled characters, so fix it.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>

I think I derailed this by suggesting that we fix other Kconfig files
at the same time, which ended up with a cross-subsystem patch that
nobody picked up.  My fault, sorry.

So I applied this now to pci/misc for v6.7, thank you!

Uwe just posted an identical patch, so I updated the commit log to
mention his patch as well:

  PCI: Replace unnecessary UTF-8 in Kconfig

  The CONFIG_PCI_P2PDMA Kconfig help text contains a Cyrillic small "Dze"
  (ѕ).  When menuconfig renders it, it looks like "Enable ~U drivers" instead
  of "Enables drivers".

  Replace it by a plain "s" so the help text is displayed correctly by
  menuconfig.

  Uwe Kleine-König <u.kleine-koenig@pengutronix.de> later posted the same
  patch at
  https://lore.kernel.org/r/20231006150209.87666-1-u.kleine-koenig@pengutronix.de

> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 133c732..8102b78 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -166,7 +166,7 @@ config PCI_P2PDMA
>  	depends on ZONE_DEVICE
>  	select GENERIC_ALLOCATOR
>  	help
> -	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> +	  Enables drivers to do PCI peer-to-peer transactions to and from
>  	  BARs that are exposed in other devices that are the part of
>  	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
>  	  specification to work (ie. anything below a single PCI bridge).
> -- 
> 1.8.3.1
> 
