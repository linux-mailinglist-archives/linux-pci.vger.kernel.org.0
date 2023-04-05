Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B16D7B4A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjDEL2o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjDEL2i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 07:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2211701
        for <linux-pci@vger.kernel.org>; Wed,  5 Apr 2023 04:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680694068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQAzVcvbALN+4zchowqIgolmdBCfNGbq9PZTSMW02q4=;
        b=Wpg2x95F/tb2ztPVU8vyZqQXsZJCza21u/nTsLBlxhOh5LoY+rdhqemG7+HtCYip9F/xJh
        EIB9Q46IAyCVTDJIVgKaCq4pQoy+GVP4nY2/S4hOSbvYUfjGP6fG9lYTVe+8sr734DIlK+
        nsZy9EjUrNJ/awhKWXEDtnuGi0AXguI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-P_wANecUPAqFgH2PCEOOKw-1; Wed, 05 Apr 2023 07:27:47 -0400
X-MC-Unique: P_wANecUPAqFgH2PCEOOKw-1
Received: by mail-wr1-f69.google.com with SMTP id o13-20020adfa10d000000b002d34203df59so4308973wro.9
        for <linux-pci@vger.kernel.org>; Wed, 05 Apr 2023 04:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694066;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQAzVcvbALN+4zchowqIgolmdBCfNGbq9PZTSMW02q4=;
        b=vN7lWsZ10yDsCuPi8QKtr5SwxO8FjqQtCyfGRN6mVlX9NzZxPgLvI3rGCJN3yZHepj
         O4s1P/d7F6rSNMpGzBqFd1LWEy+MhwFnvv/Y9Rj3795UY6o1LigBuVIx6yb5ZVE0woUJ
         w/MKPRi7BYTM114j/sAO5k+Ecuzk7zLMNqxhznRnCibujLWp96YPT+fx/xgMDdCKF7sl
         1MlHKol4Yn537dM8gA1URCEOF16kYTj4ZAai+v65einfrvgBuA76PGy0GCfKNeJHduzS
         +/CSPIDeLwE13vGFVOnXBD3Nm/MZHnbhLB3a4Gge7h6teJiW4Kr0hk+YDUIXVvvrHsSp
         o4Fw==
X-Gm-Message-State: AAQBX9fZSShFe5hE6INrr4O+AOec/lYGW5OJsLswhEjdfTaOUX0EIgLh
        JFVRuXsfGd0oz81JUksLotVMEmDueJ3jYol/bEEGJQNuh9+rOv8RAvpjaA/ahNPiCgiu8x07Vtd
        ZRjLUWWUd4Tc2md+vcNyg
X-Received: by 2002:a05:600c:21a:b0:3f0:46cd:c9d2 with SMTP id 26-20020a05600c021a00b003f046cdc9d2mr4444094wmi.16.1680694066172;
        Wed, 05 Apr 2023 04:27:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZzTSpH0dlIR9VSJkSVxYJXQwsT62p5V7VWpSKXwUL+Qge1Vw8p6lDnbGeqjb+SWtxtq6KLIw==
X-Received: by 2002:a05:600c:21a:b0:3f0:46cd:c9d2 with SMTP id 26-20020a05600c021a00b003f046cdc9d2mr4444082wmi.16.1680694065839;
        Wed, 05 Apr 2023 04:27:45 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b003ef7058ea02sm1929216wmq.29.2023.04.05.04.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:27:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] video/aperture: use generic code to figure out the
 vga default device
In-Reply-To: <20230404201842.567344-2-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
 <20230404201842.567344-2-daniel.vetter@ffwll.ch>
Date:   Wed, 05 Apr 2023 13:27:44 +0200
Message-ID: <874jpud0wf.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> Since vgaarb has been promoted to be a core piece of the pci subsystem
> we don't have to open code random guesses anymore, we actually know
> this in a platform agnostic way, and there's no need for an x86
> specific hack. See also 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to
> drivers/pci")
>
> This should not result in any functional change, and the non-x86
> multi-gpu pci systems are probably rare enough to not matter (I don't
> know of any tbh). But it's a nice cleanup, so let's do it.
>
> There's been a few questions on previous iterations on dri-devel and
> irc:
>
> - fb_is_primary_device() seems to be yet another implementation of
>   this theme, and at least on x86 it checks for both
>   vga_default_device OR rom shadowing. There shouldn't ever be a case
>   where rom shadowing gives any additional hints about the boot vga
>   device, but if there is then the default vga selection in vgaarb
>   should probably be fixed. And not special-case checks replicated all
>   over.
>

Agreed and if there are regressions reported then could be added there.

> - Thomas also brought up that on most !x86 systems
>   fb_is_primary_device() returns 0, except on sparc/parisc. But these
>   2 special cases are about platform specific devices and not pci, so
>   shouldn't have any interactions.
>
> - Furthermore fb_is_primary_device() is a bit a red herring since it's
>   only used to select the right fbdev driver for fbcon, and not for
>   the fw handover dance which the aperture helpers handle. At least
>   for x86 we might want to look into unifying them, but that's a
>   separate thing.
>
> v2: Extend commit message trying to summarize various discussions.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/video/aperture.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
> index b009468ffdff..8835d3bc39bf 100644
> --- a/drivers/video/aperture.c
> +++ b/drivers/video/aperture.c
> @@ -324,13 +324,11 @@ EXPORT_SYMBOL(aperture_remove_conflicting_devices);
>   */
>  int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name)
>  {
> -	bool primary = false;
> +	bool primary;
>  	resource_size_t base, size;
>  	int bar, ret;
>  
> -#ifdef CONFIG_X86
> -	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
> -#endif
> +	primary = pdev == vga_default_device();
>

Maybe enclose the check in parenthesis to make it easier to read ?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

