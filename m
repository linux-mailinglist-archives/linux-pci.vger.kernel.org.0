Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B93236E981
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 13:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhD2LYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 07:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhD2LYK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 07:24:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC198C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 04:23:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y124-20020a1c32820000b029010c93864955so11084586wmy.5
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MME77P409e6L4Lqp73Kfmz6ovDpO6MGhxVXUEs9x2GA=;
        b=ahhaL+yBd0njOg+bQZjElRymwkzm8hHU02kfzW8LytUqS7m68FUGGoYOU4SEPUDR2s
         SUx2pOe7BG1rD6v390gGVVJkzinfZQ9DDfx8Huzv9pbUOrNVovt6xSEoz5tZv70H1Gw6
         7VvsOKKpktPWLgVZIR97cUTvI/cNF6i0vFmMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MME77P409e6L4Lqp73Kfmz6ovDpO6MGhxVXUEs9x2GA=;
        b=ZEj0qPTFgIZ74hLTtACa/gAmFoVGG2cAhKzF85mp2fDh4hEwKXVgZ6C5CcpxtOo98C
         1zRc5OfP/VtJIxHCQbcBsnNTiL7lpt6rJOeka/cBcVbOu3LX4PXwRJT5SmDPZ6kO2bbZ
         sy0ESHjdc7CHBKD6YnPCeFIB2qehZcxFZ39QU59lfIDS9rCoJ0QgCF22dZIrbNdZgqEk
         4sCHAl/kWyahA/gX6Po4BYYdslUSzVaBTBzMbnyrRjXEXdEYmW/5HC4tYRg2M/ueB5Gj
         yQ4AxlubZduR9oczX7cgfJsReNyr3Y+ixJls+GM/sDwKl/JWQa947Q0Kc00AKPZzJ0yd
         lLiQ==
X-Gm-Message-State: AOAM531iQmq4MmbEtr9fboxDlv286VRkGD9MdzAQuTP1+igxsYWkPGGv
        NfWpNRb8o5eOBmAS5Pi0m4X2oQ==
X-Google-Smtp-Source: ABdhPJzSKV9BRDc/LcwLGozOyN6YQSr+Q/Ou/T5wmRppbd31xUIBnqsxvhkYwtV7GT5Rw+cgU/XCAA==
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr2054224wmd.76.1619695401701;
        Thu, 29 Apr 2021 04:23:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m15sm4282056wrx.32.2021.04.29.04.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 04:23:20 -0700 (PDT)
Date:   Thu, 29 Apr 2021 13:23:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com,
        ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs  with
 drm_dev_enter/exit
Message-ID: <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local>
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 11:12:00AM -0400, Andrey Grodzovsky wrote:
> With this calling drm_dev_unplug will flush and block
> all in flight IOCTLs
> 
> Also, add feature such that if device supports graceful unplug
> we enclose entire IOCTL in SRCU critical section.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Nope.

The idea of drm_dev_enter/exit is to mark up hw access. Not entire ioctl.

Especially not with an opt-in flag so that it could be shrugged of as a
driver hack. Most of these ioctls should have absolutely no problem
working after hotunplug.

Also, doing this defeats the point since it pretty much guarantees
userspace will die in assert()s and stuff. E.g. on i915 the rough contract
is that only execbuf (and even that only when userspace has indicated
support for non-recoverable hw ctx) is allowed to fail. Anything else
might crash userspace.

You probably need similar (and very precisely defined) rules for amdgpu.
And those must definitely exclude any shard ioctls from randomly failing
with EIO, because that just kills the box and defeats the point of trying
to gracefully handling hotunplug and making sure userspace has a chance of
survival. E.g. for atomic everything should continue, including flip
completion, but we set all outputs to "disconnected" and send out the
uevent. Maybe crtc enabling can fail too, but that can also be handled
through the async status we're using to signal DP link failures to
userspace.

I guess we should clarify this in the hotunplug doc?

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_ioctl.c | 15 +++++++++++++--
>  include/drm/drm_drv.h       |  6 ++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index d273d1a8603a..5882ef2183bb 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -815,7 +815,7 @@ long drm_ioctl(struct file *filp,
>  	const struct drm_ioctl_desc *ioctl = NULL;
>  	drm_ioctl_t *func;
>  	unsigned int nr = DRM_IOCTL_NR(cmd);
> -	int retcode = -EINVAL;
> +	int idx, retcode = -EINVAL;
>  	char stack_kdata[128];
>  	char *kdata = NULL;
>  	unsigned int in_size, out_size, drv_size, ksize;
> @@ -884,7 +884,18 @@ long drm_ioctl(struct file *filp,
>  	if (ksize > in_size)
>  		memset(kdata + in_size, 0, ksize - in_size);
>  
> -	retcode = drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
> +	if (drm_core_check_feature(dev, DRIVER_HOTUNPLUG_SUPPORT)) {
> +		if (drm_dev_enter(dev, &idx)) {
> +			retcode = drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
> +			drm_dev_exit(idx);
> +		} else {
> +			retcode = -ENODEV;
> +			goto err_i1;
> +		}
> +	} else {
> +		retcode = drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
> +	}
> +
>  	if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
>  		retcode = -EFAULT;
>  
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index b439ae1921b8..63e05cec46c1 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -94,6 +94,12 @@ enum drm_driver_feature {
>  	 * synchronization of command submission.
>  	 */
>  	DRIVER_SYNCOBJ_TIMELINE         = BIT(6),
> +	/**
> +	 * @DRIVER_NO_HOTUNPLUG_SUPPORT:
> +	 *
> +	 * Driver support gracefull remove.
> +	 */
> +	DRIVER_HOTUNPLUG_SUPPORT         = BIT(7),
>  
>  	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
