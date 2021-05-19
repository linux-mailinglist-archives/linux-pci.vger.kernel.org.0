Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1038965D
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhESTQN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 15:16:13 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38750 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhESTQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 15:16:13 -0400
Received: by mail-ot1-f46.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so1546940otk.5;
        Wed, 19 May 2021 12:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=izYVo1pODY59TvGRJ6tr5HWEWAw6nNqCoxBw5MFLCwg=;
        b=YOrQ7IsW2jrS+QQRREwD4S2IhTgK8UBHRo9p4/ucyuETFcigaZ5sQmczersT/nPYWK
         r3O2mKDxmWii3FiB5I30MSm26EKCp1++iwrtDsut2YhsnbyeEk/UjKCNKgMjej+d3cZ+
         H0QdzhgXvKJ9aFxjQFBrNazcOhlTGR12cidx8i4ukVPcnUbve59FgGuq0wds2v1+THEM
         giGXUMXRyOoRJEcgbFgGcZEfTlMdb9/mc+1vK2d7JMnRzHQ/mLYSs0oAKPuGgXt6iWi9
         WIRpgevcXV00PjcufzyMkJY/sL6U0MJ5TvYp2onQCp/ZjvJ/LqNqyJUxM6Ng9FGuHZFx
         vvBg==
X-Gm-Message-State: AOAM532YGueJfQtegwdPcqKkEqmFsw/KKhaJP+XfFKoh1Wg/O2M373jX
        0hC0RMR8ktFb6eLkTEp8Cg==
X-Google-Smtp-Source: ABdhPJzJMP2S9PPrAcuHOCF1RfGVRc+VX3tuXr42FGFEFyyuPTnPSurDFrey1rgenAPAQXKp9XlYaw==
X-Received: by 2002:a9d:7f1a:: with SMTP id j26mr810672otq.244.1621451692875;
        Wed, 19 May 2021 12:14:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h9sm53703oor.16.2021.05.19.12.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:14:51 -0700 (PDT)
Received: (nullmailer pid 3479665 invoked by uid 1000);
        Wed, 19 May 2021 19:14:50 -0000
Date:   Wed, 19 May 2021 14:14:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wang Xingang <wangxingang5@huawei.com>
Cc:     will@kernel.org, joro@8bytes.org, frowand.list@gmail.com,
        helgaas@kernel.org, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        xieyingtai@huawei.com
Subject: Re: [PATCH v2] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
Message-ID: <20210519191450.GA3469078@robh.at.kernel.org>
References: <1621257425-37856-1-git-send-email-wangxingang5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621257425-37856-1-git-send-email-wangxingang5@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 01:17:05PM +0000, Wang Xingang wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
> 
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. This patch add check for IOMMU in of_core_init(), and call
> pci_request_acs() when iommu is detected, making sure that the ACS will
> be enabled.
> 
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> ---
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/of/base.c        | 9 ++++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> Change log:
> v1->v2:
>  - remove pci_request_acs() in of_iommu_configure
>  - check and call pci_request_acs() in of_core_init()
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a9d2df001149..54a14da242cc 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  			.np = master_np,
>  		};
>  
> -		pci_request_acs();
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     of_pci_iommu_init, &info);
>  	} else {
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 48e941f99558..95cd8f0e5435 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
> +#include <linux/pci.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -166,7 +167,7 @@ void __of_phandle_cache_inv_entry(phandle handle)
>  void __init of_core_init(void)
>  {
>  	struct device_node *np;
> -
> +	bool of_iommu_detect = false;
>  
>  	/* Create the kset, and register existing nodes */
>  	mutex_lock(&of_mutex);
> @@ -180,6 +181,12 @@ void __init of_core_init(void)
>  		__of_attach_node_sysfs(np);
>  		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
>  			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
> +
> +		/* Detect IOMMU and make sure ACS will be enabled */
> +		if (!of_iommu_detect && of_get_property(np, "iommu-map", NULL)) {
> +			of_iommu_detect = true;
> +			pci_request_acs();
> +		}

Private DT internal init code doesn't seem like the right place for 
this. If this needs to be ordered WRT PCI device enumeration, then 
somewhere in the PCI host bridge or bus init code seems like the right 
place to me.

Also, shouldn't this be conditional on 'iommu-map' being in the host 
bridge or a parent or ??? rather than just any iommu-map anywhere in the 
DT.

>  	}
>  	mutex_unlock(&of_mutex);
>  
> -- 
> 2.19.1
> 
