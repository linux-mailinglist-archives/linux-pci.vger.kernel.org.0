Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6C9718872
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 19:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEaR2L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEaR2K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 13:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B53BE;
        Wed, 31 May 2023 10:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B94261199;
        Wed, 31 May 2023 17:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF8DC433EF;
        Wed, 31 May 2023 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685554086;
        bh=QUys/yTxIdSYTpQugTpVBvBDboSkoG+k/FTxlWRW0II=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OmJ1ssTzhjT6CCXPr0dF/pbWm9TbHyxrH7iMFETRLmMIJZSDRpmCETKbi+hba0C2b
         dm9pVYYD6SmaWnkWw5LP9lbH0qS8UfWA6av3tKFTO0PLeoaPW907E335Cwn2rMgFLT
         GyuorTUazfiqACcAdF3OOoYOeCqdUHxrI3J1zmBXSRkglmr3kToLgIna8DzC3Vo1O4
         0hac1ipWWdsgPqZRCxsW7GOxnUr4URhdidQh0JNcy63x8T8LZrGixjOTRfP2z/raAj
         GCMf8clZ8F2nCj9zcEBdlmjLocOeYW6mqMIZ3+vstSTOgJKc4NQkyqTz03Hs6WhfdK
         +euCGNig9Eufw==
Date:   Wed, 31 May 2023 12:28:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <bhutchings@solarflare.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        kernel test robot <lkp@intel.com>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add dummy implement for pci_clear_master()
 function
Message-ID: <ZHeDpbtM3FFOPn6d@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531102744.2354313-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 06:27:44PM +0800, Sui Jingfeng wrote:
> As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
> call pci_clear_master() without config_pci guard can not pass compile test.
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
> V2:
> 	* Adjust commit log style to meet the convention and add Fixes tag
> 
> Fixes: 6a479079c072 ("PCI: Add pci_clear_master() as opposite of pci_set_master()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Applied to pci/misc for v6.5 as follows:

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
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
