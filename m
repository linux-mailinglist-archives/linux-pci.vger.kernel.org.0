Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7736E8154
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 20:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDSSj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 14:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDSSjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 14:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13178A0;
        Wed, 19 Apr 2023 11:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B50640CB;
        Wed, 19 Apr 2023 18:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C49C433EF;
        Wed, 19 Apr 2023 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681929563;
        bh=LfkZq5zJCyG0QdfnBfgE2MosMbCsWHxc+Ri9mlO/Gew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n5zzGj/+CjiVmFvj2sj6vi23KmZFrrV/tmQWbtjZtk1CLNNdebAPdCHzlAN4lIwkB
         mLzUSPwKeDaWtr9T86QE9odOmGx7obfMr3WeZR9Wcibvo2BJFWWWP7aRPeVQ9kthD9
         Ku/cYuoi1LARgMBY86HCBI1o/JzjcT9xc5TfbU98YnTrEXBcowESwemsdMrPddQVuV
         wVL2MAfv5KWF4yKXChaPNBxFjCsnBRCF20mrlA3jnXQ1JcmMhsPQ8RFzp1LUVgWaR/
         LsbFBUk0K2RqMmy0ZkWjxvzc1r8ynR+9wsIGy9qJNdbm4H7e3YNgBK3WwHiuk527Sg
         ijtaSACGMXXog==
Date:   Wed, 19 Apr 2023 13:39:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Patrick McLean <chutzpah@gentoo.org>
Cc:     Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:DRM DRIVER FOR AST SERVER GRAPHICS CHIPS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add ASPEED vendor ID
Message-ID: <20230419183920.GA217365@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418225757.1361301-1-chutzpah@gentoo.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 03:57:57PM -0700, Patrick McLean wrote:
> Currently the ASPEED PCI vendor ID is defined in
> drivers/gpu/drm/ast/ast_drv.c, move that to include/linux/pci_ids.h
> with all the rest of the PCI vendor ID definitions. Rename the definition
> to follow the format that the other definitions follow.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But please include this patch in the series that adds the use in
libata-core, as in your original posting, so we can see *why* we're
moving this to pci_ids.h.  That also makes it easier to make sure
those patches go together.

> ---
>  drivers/gpu/drm/ast/ast_drv.c | 4 +---
>  include/linux/pci_ids.h       | 2 ++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> index d78852c7cf5b..232e797793b6 100644
> --- a/drivers/gpu/drm/ast/ast_drv.c
> +++ b/drivers/gpu/drm/ast/ast_drv.c
> @@ -70,12 +70,10 @@ static const struct drm_driver ast_driver = {
>   * PCI driver
>   */
>  
> -#define PCI_VENDOR_ASPEED 0x1a03
> -
>  #define AST_VGA_DEVICE(id, info) {		\
>  	.class = PCI_BASE_CLASS_DISPLAY << 16,	\
>  	.class_mask = 0xff0000,			\
> -	.vendor = PCI_VENDOR_ASPEED,			\
> +	.vendor = PCI_VENDOR_ID_ASPEED,			\
>  	.device = id,				\
>  	.subvendor = PCI_ANY_ID,		\
>  	.subdevice = PCI_ANY_ID,		\
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 45c3d62e616d..40e04e88ca5a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2553,6 +2553,8 @@
>  #define PCI_DEVICE_ID_NETRONOME_NFP3800_VF	0x3803
>  #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
>  
> +#define PCI_VENDOR_ID_ASPEED		0x1a03
> +
>  #define PCI_VENDOR_ID_QMI		0x1a32
>  
>  #define PCI_VENDOR_ID_AZWAVE		0x1a3b
> -- 
> 2.40.0
> 
