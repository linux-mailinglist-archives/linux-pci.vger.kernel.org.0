Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728B041DC89
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 16:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351020AbhI3Om7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 10:42:59 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34655 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349769AbhI3Om7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 10:42:59 -0400
Received: by mail-wr1-f53.google.com with SMTP id t8so10535661wri.1;
        Thu, 30 Sep 2021 07:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlV2IW6KgwSMkQiI/3nalledS1TzOJSnAsynrV1hvmI=;
        b=KwWesWBcLF3Ao3oUBSagd1ExtrAdhcu2b+z1qu591O+PcUi1MCjqxIdu/ZDRSJPeEU
         s40rHYCh8/x50xuisAnr5FEmvxjqn82CQ+4Aex7NUfmNpIp0TikVFm+1HsfnrLZ0taJk
         b4m9UKxVmFHZPFJLu0kLMt0OuuEq/WtWaLdKKkMw7jP6dTvfc5RhdRsizCHdqz9ivs9z
         bS5s+m44BdpWhJzwujvkJucZuvPKoFPdMCKJe38RsRCl54/Isdv7KE0UiWEoB9ufd9Xr
         //M2gTCuUQwtbp7T90CwQaMVxcwynHSxpPx9mxDhxpaUbVnrFxI+n0F3ThI6+VPoRw8E
         TEPg==
X-Gm-Message-State: AOAM5311RD6+ZhN6zDIeDd70SOG0QYjs4518LksIKV0ocfSYnMnt54Hd
        ygbVj3uaOoMNkCNVPxJG6NY=
X-Google-Smtp-Source: ABdhPJx3RvTS+7z6fNKyJlCKUV3HdqEwws93IzNsqEtqImu8jolUAHMDRkGFp/DD2fiEWjcc3NMKfw==
X-Received: by 2002:a5d:64a7:: with SMTP id m7mr6752049wrp.171.1633012875349;
        Thu, 30 Sep 2021 07:41:15 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n26sm4999946wmi.43.2021.09.30.07.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:41:14 -0700 (PDT)
Date:   Thu, 30 Sep 2021 16:41:13 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, stefanha@redhat.com, oren@nvidia.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] driver core: use NUMA_NO_NODE during
 device_initialize
Message-ID: <YVXMifT1hdIci1cp@rocinante>
References: <20210930142556.9999-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930142556.9999-1-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Max,

> Don't use (-1) constant for setting initial device node. Instead, use
> the generic NUMA_NO_NODE definition to indicate that "no node id
> specified".
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e65dd803a453..2b4b46f6c676 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2838,7 +2838,7 @@ void device_initialize(struct device *dev)
>  	spin_lock_init(&dev->devres_lock);
>  	INIT_LIST_HEAD(&dev->devres_head);
>  	device_pm_init(dev);
> -	set_dev_node(dev, -1);
> +	set_dev_node(dev, NUMA_NO_NODE);

We might have one of these to fix in the PCI tree, as per:

  https://elixir.bootlin.com/linux/v5.15-rc3/source/drivers/pci/pci-sysfs.c#L84

Would this be of interest to you for a potential v2?

	Krzysztof
