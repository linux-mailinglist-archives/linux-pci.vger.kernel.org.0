Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB717248B7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbjFFQOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbjFFQOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 12:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94A19A6;
        Tue,  6 Jun 2023 09:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 229F2634D8;
        Tue,  6 Jun 2023 16:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5333FC433D2;
        Tue,  6 Jun 2023 16:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686068028;
        bh=ghZ+tnxDosTZrXGYSxg541zgJK7ETaxCTSN08O1niI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r7Jz8JwumHZdRSf4R/A0MYzdMmH3cqxqEgk0rAu2kybQlS7SAz3YABYMPpiOsf66y
         nT5FVEurwHcBce4ARRCQwXGdsZeCcYoeuXZZFXchx2ugsJkfOcOPL1DKCzmML8ka9S
         mIxR+BwNiaoAYYOEQagnu72TsHZhrCNESeUAjw3kUtUvLGFaIDmBn+DDp6+b3UWgjo
         itczrt7fShrlNWo8T1qCiBP9eQyJ7hz2eyST0MBpRE0smaMr171B9J7ebv6xeWsUlr
         Yljgc7VHQcO8+Uv1d0QG8KeRdWbWD4d5M3ZR5BtmXTGbhomCt/Bs5JBhh88N0USffx
         Y28iaH08wRwMQ==
Date:   Tue, 6 Jun 2023 11:13:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
Message-ID: <20230606161346.GA1127246@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530101655.2275731-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 06:16:55PM +0800, Sui Jingfeng wrote:
> As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
> call pci_clear_master() without config_pci guard can not built.
> 
>    drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:
>    In function 'etnaviv_gpu_pci_fini':
> >> drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9:
>    error: implicit declaration of function 'pci_clear_master';
>    did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
>       32 |         pci_clear_master(pdev);
>          |         ^~~~~~~~~~~~~~~~
>          |         pci_set_master
>    cc1: some warnings being treated as errors
> 
> [1] https://patchwork.freedesktop.org/patch/539977/?series=118522&rev=1
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

I applied this to pci/misc for v6.5, with commit log as below.

But I suspect that it might make your life easier if you include it
with your etnaviv series.  You may be able to avoid adding the
CONFIG_DRM_ETNAVIV_PCI_DRIVER symbol.

If so, feel free to include this patch in that series with my ack:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If you do include it in your series, please use the commit log below
and let me know so I can drop it from my queue.

Bjorn


  Author: Sui Jingfeng <suijingfeng@loongson.cn>
  Date:   Wed May 31 18:27:44 2023 +0800

    PCI: Add pci_clear_master() stub for non-CONFIG_PCI
    
    Add a pci_clear_master() stub when CONFIG_PCI is not set so drivers that
    support both PCI and platform devices don't need #ifdefs or extra Kconfig
    symbols for the PCI parts.
    
    [bhelgaas: commit log]
    Fixes: 6a479079c072 ("PCI: Add pci_clear_master() as opposite of pci_set_master()")
    Link: https://lore.kernel.org/r/20230531102744.2354313-1-suijingfeng@loongson.cn
    Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
    Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d0c19ff0c958..71c85380676c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1904,6 +1904,7 @@ static inline int pci_dev_present(const struct pci_device_id *ids)
>  #define pci_dev_put(dev)	do { } while (0)
>  
>  static inline void pci_set_master(struct pci_dev *dev) { }
> +static inline void pci_clear_master(struct pci_dev *dev) { }
>  static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
>  static inline void pci_disable_device(struct pci_dev *dev) { }
>  static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
> -- 
> 2.25.1
> 
