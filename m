Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD57CBCE5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjJQH4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQH4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:56:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E6A95
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 00:56:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c603e2354fso81646366b.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697529380; x=1698134180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsSM8SX3Q3YGiEvE1D2/zJCcEqUjRy7AoXeuAvvxBqw=;
        b=BfwoK6ApEAAsKDgGel5OkTzhxBbCjlNEbaAaJKz+p+T/hhjEmDmHVubw0KhTzzJvWa
         G8B3UDZy57vDTAEKZj3zRKnmM2B2pJKQkixwwXMODUJ/Jyic1vRep9e9yffbVy0+zD3M
         qtIB/DP8XMEK3juY1B2wO2ydTxDpeE399xfaql2tQeGhHzF8jpTX5eLphfjBU60fn7PT
         WFPIvACqspUq7NkbmJmLjGYvgFJrKG6XE1PO6vW+GmOlXKShpBGcKxLTCsdI1ATgG9KC
         zPNoEkR6ZIyDkHkU4CMwwAQhi2GUm5fGC7nwxSE8/cvH9wnwQPGjLKap8AlnDYI16OQJ
         tmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529380; x=1698134180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsSM8SX3Q3YGiEvE1D2/zJCcEqUjRy7AoXeuAvvxBqw=;
        b=DeMSWowCK+IgJA6gEJ8lCl9yboc+pAGuAtAkxNxc7Jphz3wItNYgo8zN5EZOPfBle4
         +tu2BtSGpDhriq/vok56zFgImoCe1zvJlUNOXNuM+0v5CLUe6ZT7LumS75BtPNX0aJjB
         mfPUag6NT6CyO0kpex5GCd8j0T6A+JRtgK189O3kde7NPpyxPxNijS4g71guQJANWCyu
         r5vu9VQlSQUMbfJoKJiD5BtsjgpZYyOIKPk4lEntEGBCuQ6gv49uXSRkurIlwqFELS4t
         5MZGeeCWh836QofO/5CWsawR4+dQccgO33BgjEcO4yGMfncE/75lCdZ6CJm/xInUW634
         qyDA==
X-Gm-Message-State: AOJu0Yy2wRAbb08+q5TP7fkVlSs5sQfjviA/p/zpSNeKWvHKx8gtWbi/
        +iiR88VC0jm784WC0cyloMgdNA==
X-Google-Smtp-Source: AGHT+IE2NSiHOm2w5hVHzyGMIDgtFBv4rPQWMb07/aFI6Pxbr/IfZOEOFP31EUDY1Pt2+OM1rUHjKg==
X-Received: by 2002:a17:907:2d11:b0:9ae:659f:4d2f with SMTP id gs17-20020a1709072d1100b009ae659f4d2fmr1150548ejc.26.1697529380086;
        Tue, 17 Oct 2023 00:56:20 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709065f8900b00988f168811bsm741722eju.135.2023.10.17.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:56:19 -0700 (PDT)
Date:   Tue, 17 Oct 2023 09:56:18 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de, petrm@nvidia.com,
        jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 02/12] devlink: Hold a reference on parent
 device
Message-ID: <ZS4+InoncFqPVW72@nanopsycho>
References: <20231017074257.3389177-1-idosch@nvidia.com>
 <20231017074257.3389177-3-idosch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017074257.3389177-3-idosch@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tue, Oct 17, 2023 at 09:42:47AM CEST, idosch@nvidia.com wrote:
>Each devlink instance is associated with a parent device and a pointer
>to this device is stored in the devlink structure, but devlink does not
>hold a reference on this device.
>
>This is going to be a problem in the next patch where - among other
>things - devlink will acquire the device lock during netns dismantle,
>before the reload operation. Since netns dismantle is performed
>asynchronously and since a reference is not held on the parent device,
>it will be possible to hit a use-after-free.
>
>Prepare for the upcoming change by holding a reference on the parent
>device.
>

Just a note, I'm currently pushing the same patch as a part
of my patchset:
https://lore.kernel.org/all/20231013121029.353351-4-jiri@resnulli.us/


>Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>---
> net/devlink/core.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/devlink/core.c b/net/devlink/core.c
>index bcbbb952569f..5b8b692b8c76 100644
>--- a/net/devlink/core.c
>+++ b/net/devlink/core.c
>@@ -4,6 +4,7 @@
>  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
>  */
> 
>+#include <linux/device.h>
> #include <net/genetlink.h>
> #define CREATE_TRACE_POINTS
> #include <trace/events/devlink.h>
>@@ -310,6 +311,7 @@ static void devlink_release(struct work_struct *work)
> 
> 	mutex_destroy(&devlink->lock);
> 	lockdep_unregister_key(&devlink->lock_key);
>+	put_device(devlink->dev);
> 	kfree(devlink);
> }
> 
>@@ -425,6 +427,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
> 	if (ret < 0)
> 		goto err_xa_alloc;
> 
>+	get_device(dev);
> 	devlink->dev = dev;

Nit:
	devlink->dev = get_device(dev);


> 	devlink->ops = ops;
> 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
>-- 
>2.40.1
>
>
