Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91081716E64
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 22:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjE3ULI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 16:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjE3ULH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 16:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258DEF9;
        Tue, 30 May 2023 13:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9FAC62B4D;
        Tue, 30 May 2023 20:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68E8C4339B;
        Tue, 30 May 2023 20:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685477465;
        bh=rzTSFWP7EGhI75f20uvSZ1KlSZQvqYicerFpFWGj7LA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CrqJrNf15J8HEy6u8b6SKublH4XlrkC2j1/c2WHHKu9UCqsuHbBqK40rd29XYDNmc
         fg0K17IRRdFwDTywyiNpmlrE3qW0cBq2TW2Q5z9Y17QmFRiqYbmHCfKy6oyRSf787/
         1at8CgZmPRHHk3IMGaSTrl8WmCJSMh4/28uoB3zCJ99yicByuuuzRqSR7/LdAFlZdV
         HV8/A1Ur8/4BhuBauvN6rRAPY06Me1tNxF+ntI+MHYlmsMhLiJNNWPu7LCW0Lejw3t
         C7Fg/5z3yZtpKIvYYg7JBnmp7hj7y4tmjnEwt2nwz4EgbmhqCHXqYpEqUkO3VApzQG
         qOgRZ1rXswaNw==
Date:   Tue, 30 May 2023 15:11:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
Message-ID: <ZHZYVyqsJjiSNNsP@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530101655.2275731-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

I don't mind adding a stub if it's needed, but I don't understand why
it's needed here.  The caller is in etnaviv_pci_drv.c, and if I
understand the patch at [1], etnaviv_pci_drv.c is only compiled when
CONFIG_PCI=y.

Bjorn

[1] https://lore.kernel.org/all/20230530160643.2344551-6-suijingfeng@loongson.cn/

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
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
