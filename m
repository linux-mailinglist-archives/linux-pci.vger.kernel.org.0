Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82D46E8150
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjDSShJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDSShI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 14:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C8E122;
        Wed, 19 Apr 2023 11:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4021363692;
        Wed, 19 Apr 2023 18:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773D3C433D2;
        Wed, 19 Apr 2023 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681929426;
        bh=WvcAdd5nlPqNohhCXFOiHzOhi+SADKfXYzqWqMwWQd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JXb4yB4h47ZW7wioaGqGMN/Ao/YndkMiYDh+rtEnrAkp1JNAk1ONzho3pRYp2fG87
         2Vc77F/r17AMejNcnnqJ1o0LaJXoc8QmZPwUsqVW96l5MmW1Lp/WG2ZQtm+1R7Wd1k
         nHZN5v7V74AUhzW2MROTboAjQYEUaX/pmAAI1TlHvLXgsvH29ZWv8SiIxlWAtLKrWH
         ewNnXzO8yA3z60e4zUlTJZy+Exdzg5EGwKDVhz01//gWVhLvfvwt79eBpXHq2YQVny
         md+hoNq98GvLGN244rd0vwb3t76uO0Io2JpsbnYCvYFplrTmkuWUS0uAgQsLGcFNCB
         j8vux79kQVkmg==
Date:   Wed, 19 Apr 2023 13:37:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Patrick McLean <chutzpah@gentoo.org>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:DRM DRIVER FOR AST SERVER GRAPHICS CHIPS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add ASPEED vendor ID
Message-ID: <20230419183704.GA216848@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1f776e1-8489-010f-a500-ba68b45ad3a3@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 19, 2023 at 09:00:15AM +0200, Thomas Zimmermann wrote:
> Am 19.04.23 um 00:57 schrieb Patrick McLean:
> > Currently the ASPEED PCI vendor ID is defined in
> > drivers/gpu/drm/ast/ast_drv.c, move that to include/linux/pci_ids.h
> > with all the rest of the PCI vendor ID definitions. Rename the definition
> > to follow the format that the other definitions follow.
> 
> Thanks a lot. Can you please also move and rename the PCI device ids? [1]

Generally we move things to pci_ids.h only when they are shared
between multiple drivers.  This is mostly to make backports easier.

PCI_VENDOR_ID_ASPEED is (or will be) used in both ast_drv.c and
libata-core.c, so it qualifies.

It doesn't look like PCI_CHIP_AST2000 and PCI_CHIP_AST2100 would
qualify since they're only used in ast_drv.c and ast_main.c, which are
part of the same driver.

> [1] https://elixir.bootlin.com/linux/v6.2/source/drivers/gpu/drm/ast/ast_drv.h#L52
> 
> > 
> > Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
> > ---
> >   drivers/gpu/drm/ast/ast_drv.c | 4 +---
> >   include/linux/pci_ids.h       | 2 ++
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> > index d78852c7cf5b..232e797793b6 100644
> > --- a/drivers/gpu/drm/ast/ast_drv.c
> > +++ b/drivers/gpu/drm/ast/ast_drv.c
> > @@ -70,12 +70,10 @@ static const struct drm_driver ast_driver = {
> >    * PCI driver
> >    */
> > -#define PCI_VENDOR_ASPEED 0x1a03
> > -
> >   #define AST_VGA_DEVICE(id, info) {		\
> >   	.class = PCI_BASE_CLASS_DISPLAY << 16,	\
> >   	.class_mask = 0xff0000,			\
> > -	.vendor = PCI_VENDOR_ASPEED,			\
> > +	.vendor = PCI_VENDOR_ID_ASPEED,			\
> >   	.device = id,				\
> >   	.subvendor = PCI_ANY_ID,		\
> >   	.subdevice = PCI_ANY_ID,		\
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 45c3d62e616d..40e04e88ca5a 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2553,6 +2553,8 @@
> >   #define PCI_DEVICE_ID_NETRONOME_NFP3800_VF	0x3803
> >   #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
> > +#define PCI_VENDOR_ID_ASPEED		0x1a03
> > +
> >   #define PCI_VENDOR_ID_QMI		0x1a32
> >   #define PCI_VENDOR_ID_AZWAVE		0x1a3b
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev



