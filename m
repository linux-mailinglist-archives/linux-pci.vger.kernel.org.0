Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D923B6E6DE7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjDRVOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjDRVOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 17:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6AD55AC;
        Tue, 18 Apr 2023 14:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D29E61527;
        Tue, 18 Apr 2023 21:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC45BC433D2;
        Tue, 18 Apr 2023 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681852445;
        bh=JBNOFe/Q4uIY9BiQEuafN7tvTwnDWbyxZ0gk7Y620+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fby3qz/OFcuKHyHBQn+0w4kcO7mwke+dsb6RnUgR+c5iZjjqMTZ9jwYowkD+2ujmz
         lLj3WQEavcRi/aq2Y/X4NVRxFuXlu3Av4iCp8dUmsgjUH1H2BA4aJF9wJAt+fEdSzC
         S8K4FCciilRXX1Cso+nwhIYTmKCKn9ClVMRr9EJY13ffQathK3Z6tJXX2uVipeJrft
         S8j3J9YVGWuWbORQsjYZ0v60ALdW3NHuiRC6duNt3RjaaX739yCY4jYFjsnEqH14kf
         Ve3Jln9z/RDVvJ+Y70qj/3WVn9mVNF5ybqIVe+pisZxfU76ZriBjaI9DboxKJqqWvi
         BurvZCIAMgJ/A==
Date:   Tue, 18 Apr 2023 16:14:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Patrick McLean <chutzpah@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] gpu: Move ASPEED vendor ID definition to pci_ids.h
Message-ID: <20230418211403.GA160979@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418011720.3900090-2-chutzpah@gentoo.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Most subject lines for pci_ids.h look like this:

  PCI: Add ASPEED vendor ID

On Mon, Apr 17, 2023 at 06:17:19PM -0700, Patrick McLean wrote:
> Currently the ASPEED PCI vendor ID is defined in drivers/gpu/drm/ast/ast_drv.c,
> move that to include/linux/pci_ids.h with all the rest of the PCI vendor ID
> definitions. Rename the definition to follow the format that the other
> definitions follow.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>

Given the subject line and file placement (below) updates,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
> index 45c3d62e616d..6634741aea80 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -815,6 +815,8 @@
>  #define PCI_VENDOR_ID_ASUSTEK		0x1043
>  #define PCI_DEVICE_ID_ASUSTEK_0675	0x0675
>  
> +#define PCI_VENDOR_ID_ASPEED		0x1a03

This looks like a random placement.  Please keep sorted by numeric
vendor ID.  I'll make the comment at the top a little more specific.

>  #define PCI_VENDOR_ID_DPT		0x1044
>  #define PCI_DEVICE_ID_DPT		0xa400
>  
> -- 
> 2.40.0
> 
