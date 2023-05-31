Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B69718847
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEaRQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 13:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEaRQ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 13:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C327F93;
        Wed, 31 May 2023 10:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 591D96322E;
        Wed, 31 May 2023 17:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8480FC433EF;
        Wed, 31 May 2023 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685553386;
        bh=VJqQcp3n+G+rWqql9EApr1dc7y/WVGonSko98BF47wY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ramX8vf+I4JfzlO8bI69EzuqbuQ7VH3INCsZr5FAiAewTXWtFpy6RFIkS9OQ/N4hj
         deLWbWBiXaAIjydpVKYNyOhOuyXyvpDDU1LPqxbWeNI0VJJ6Ljd660SKyT/vSu/Pg8
         llhpF++v4bs5E+Wpo9m4eXG6KUHW1QPolpAJHxH5eDHMxwfCq06ndiLD8E/w8oh2M6
         D1uzkx+qMDb28RGj5x0gQbKqk3bKl7y8F1HP8+Yk4AKGRgSymU1maD04hIcyL9UpdG
         1Zorhslu40dcvYF3BbDCNEo3k4C4IyFpsGCOn4TUOtsUDWZsk6Xfmd71yydNb6PWez
         /ZqkUWLVlX5Uw==
Date:   Wed, 31 May 2023 12:16:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
Message-ID: <ZHeA6eB5FocARdwl@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c88cab1-e175-ddcf-b323-437890cc2eec@loongson.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 12:25:10PM +0800, Sui Jingfeng wrote:
> On 2023/5/31 04:11, Bjorn Helgaas wrote:
> > On Tue, May 30, 2023 at 06:16:55PM +0800, Sui Jingfeng wrote:
> > > As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
> > > call pci_clear_master() without config_pci guard can not built.
> > > 
> > >     drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:
> > >     In function 'etnaviv_gpu_pci_fini':
> > > > > drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9:
> > >     error: implicit declaration of function 'pci_clear_master';
> > >     did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
> > >        32 |         pci_clear_master(pdev);
> > >           |         ^~~~~~~~~~~~~~~~
> > >           |         pci_set_master
> > >     cc1: some warnings being treated as errors
> > > 
> > > [1] https://patchwork.freedesktop.org/patch/539977/?series=118522&rev=1
> > I don't mind adding a stub if it's needed, but I don't understand why
> > it's needed here.
> 
> For a single driver that supports both platform devices and PCI devices,
> 
> Sometimes there is no way to separate the PCI driver part and the platform
> driver part cleanly and clearly.
> 
> For example, the module_init() and module_exit() functions,
> 
> where we have to register PCI drivers and platform drivers there.
> 
> We can't simply let the entire driver depend on PCI in Kconfig,
> 
> This will make this driver unable to compile, which it's originally could.
> 
> The PCI core could do such a thing for us, and
> 
> There is no need to introduce a driver-specific guard then.
> 
> 
> There is already a dummy stub for pci_set_master().
> 
> Therefore, pci_clear_master() should also have a counterpart.
> 
> They should emerge in pairs.
> 
> This could probably eliminate pain for PCI driver writers,
> 
> This patch is still useful.
> 
> 
> >   The caller is in etnaviv_pci_drv.c, and if I
> > understand the patch at [1], etnaviv_pci_drv.c is only compiled when
> > CONFIG_PCI=y.
> 
> Yes, you are right. This is the right thing to do for the driver, though.
> 
> Pure PCI device driver does not need to worry about this.
> 
> Like drm/ast, drm/amdgpu, drm/radeon, etc.
> 
> But drm/etnaviv is special; it's a platform driver that could pass the
> compile test originally.
> 
> 
> When patching it (Etnaviv) with PCI device driver support,
> 
> This forces the PCI driver writer to add another config option.
> 
> (which depends on the PCI config option.) in the Kconfig.
> 
> For my case, it's theDRM_ETNAVIV_PCI_DRIVER config option.

So if I understand correctly, you would prefer not to add the
DRM_ETNAVIV_PCI_DRIVER config option, and if we add this stub, you
won't need to add it?

That's a good reason to add this patch.

Bjorn
