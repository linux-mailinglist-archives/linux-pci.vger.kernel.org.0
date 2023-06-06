Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15678724BAC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbjFFSqH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbjFFSqG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 14:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F9E42;
        Tue,  6 Jun 2023 11:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84DDD61238;
        Tue,  6 Jun 2023 18:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54C3C433D2;
        Tue,  6 Jun 2023 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686077163;
        bh=T0RyLdGfc21xsWDQUnUoisT3w5J4nNOMhqlDCeQuh7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E591/OdISbdE1NHpAYxY5WLKXZb76PLRy9Ojh09XQYnEQwN0Pijnrzn1Hi7ddsnD5
         lf6xZUqAfZiODNpODDSnm8Oy64o2V+tD9IuDQN0+Lkz04KLEsjIsWpTICXrIszqhvl
         F/06y2r1mxj8K8KhHuNpxw3O2deSGOpTJ51IFvcZdxFNDb/FpJKyuyL3uL6erHRsNe
         ekTWkWjDD88sXM7SZQLJWdtUcrGgnzuPQphC1vMa79H1Yvk18wHDQ6LxGmPslXJ7X3
         Jf5HQwhygRIqiudSRQTFkrz9XyPdc+x84rYa/RhZlRm6TFRmCo0k4XNbvU7oDeDzNf
         DfdnIwoDxJoWg==
Date:   Tue, 6 Jun 2023 13:46:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
Message-ID: <20230606184602.GA1134277@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd2409ed-dac2-30b5-783d-8d84e38ad5c9@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 01:48:38AM +0800, Sui Jingfeng wrote:
> On 2023/6/7 00:13, Bjorn Helgaas wrote:
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
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > I applied this to pci/misc for v6.5, with commit log as below.
> > 
> > But I suspect that it might make your life easier if you include it
> > with your etnaviv series.  You may be able to avoid adding the
> > CONFIG_DRM_ETNAVIV_PCI_DRIVER symbol.
> > 
> > If so, feel free to include this patch in that series with my ack:
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I do want add this tag to my all  of the patches in the drm/etnaviv series,
> thanks.
> 
> and I really love you this idea.

Just to be clear, my ack only applies to the addition of the
pci_clear_master() stub in pci.h.  It does not apply to the patches in
the drm/etnaviv series at
https://lore.kernel.org/r/20230603105943.3042766-1-15330273260@189.cn

> > If you do include it in your series, please use the commit log below
> > and let me know so I can drop it from my queue.
> 
> No, please keep this patch merged by you.
> 
> Because this patch belong to drivers/pci, Its belong to you domain.
> 
> 
> I might choose to  remove the CONFIG_DRM_ETNAVIV_PCI_DRIVER option at next
> version
> 
> of my drm/etnaviv patch If it arrived to drm/tip branch.
> 
> 
> But I guess some reviewers may still prefer a CONFIG_DRM_ETNAVIV_PCI_DRIVER
> option,
> 
> depend on the attitude of etnaviv folks.

The purpose of my ack is to enable you to merge the patch along with
the series that uses it.  This is a normal way of handling things that
cross subsystem boundaries, so you don't need to feel uncomfortable
about it.

It is much more difficult to remove config options than it is to add
them, because you must ensure that the removal doesn't break old
.config files.

I will keep this patch in my queue unless you tell me to drop it.

Bjorn

> >    Author: Sui Jingfeng <suijingfeng@loongson.cn>
> >    Date:   Wed May 31 18:27:44 2023 +0800
> > 
> >      PCI: Add pci_clear_master() stub for non-CONFIG_PCI
> >      Add a pci_clear_master() stub when CONFIG_PCI is not set so drivers that
> >      support both PCI and platform devices don't need #ifdefs or extra Kconfig
> >      symbols for the PCI parts.
> >      [bhelgaas: commit log]
> >      Fixes: 6a479079c072 ("PCI: Add pci_clear_master() as opposite of pci_set_master()")
> >      Link: https://lore.kernel.org/r/20230531102744.2354313-1-suijingfeng@loongson.cn
> >      Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >      Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >      Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > > ---
> > >   include/linux/pci.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index d0c19ff0c958..71c85380676c 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1904,6 +1904,7 @@ static inline int pci_dev_present(const struct pci_device_id *ids)
> > >   #define pci_dev_put(dev)	do { } while (0)
> > >   static inline void pci_set_master(struct pci_dev *dev) { }
> > > +static inline void pci_clear_master(struct pci_dev *dev) { }
> > >   static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
> > >   static inline void pci_disable_device(struct pci_dev *dev) { }
> > >   static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
> > > -- 
> > > 2.25.1
> > > 
> -- 
> Jingfeng
> 
