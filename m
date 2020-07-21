Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F22D227A7D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGUITN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 04:19:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51344 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726734AbgGUITN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 04:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595319551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xkmaD14CWjK3N3gJunf7XsZs5bmLEiFw/ANQQtol7cc=;
        b=fiHvxlf8GbbFqpYs0MJOxG/EzzdP1i7dJh8iqDX7dU0/24Sj3FLVJbw2znymHy6m/Pemei
        4I1JrXy8iVt1TB1UEPvMtW8QpCuIOTQM+5cUmsoze9jlQfaNmvM8wPSZJetNEx0Gi2Ku6L
        SB44HOoamguevQyJfPkqHaVsodrJTLA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-D-lkHzyHN2aw6L-BPyh5IQ-1; Tue, 21 Jul 2020 04:18:57 -0400
X-MC-Unique: D-lkHzyHN2aw6L-BPyh5IQ-1
Received: by mail-wm1-f70.google.com with SMTP id l5so945809wml.7
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2020 01:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkmaD14CWjK3N3gJunf7XsZs5bmLEiFw/ANQQtol7cc=;
        b=d/DjCqlXvtnggkntto3m82mq511tJKExACBEVxTTXoJ1rCIsTY6YVODUYchmNhWaNa
         brC3LphHQ56Etw/79fH9XzaOt+2L0qbXZ0XsQSaUP/wZixomhsvISxo4sd4x+tNhJdt0
         ZAWMSGaeAMa7O5OhCfr06RHyl2orXOWet8buPceuUZheGdOA4QrObLIXIF8rHCkwMXC+
         Rmim2g+2oK+VHESAdR4QWTQuCtSRiSVlSg3ur583n2WR8zDWSJbDFRxztbSuDzd9fp/2
         ZKGyVaQFl6Avp42RdV5/Xp8/KKhg7Qwc+CVA9XkNUzxor3wlYLd4G9wpaqzuNveFffL/
         K4zQ==
X-Gm-Message-State: AOAM531jnB+Ah9yqPsFIZ/S48GESJ+ofLRiRCja02c/7o5/g5cHjv87F
        AjJmzhAwmgaIwchbOJtorhx4vriuHZrvHHJbABVSBpi0q0aTaMczGEdtV/S+/2eBgIewA/zFtnu
        e4D99j0XdUpe8w2nr9MnZ
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr3064959wml.142.1595319536581;
        Tue, 21 Jul 2020 01:18:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu53zATBiX8oH83PTvYrZiOs3LjcaWchQEItZ2BS8OgcP26ZDsNqGDj/whi2FZO5AjbvS6KA==
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr3064931wml.142.1595319536353;
        Tue, 21 Jul 2020 01:18:56 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
        by smtp.gmail.com with ESMTPSA id k14sm35429226wrn.76.2020.07.21.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:18:55 -0700 (PDT)
Date:   Tue, 21 Jul 2020 04:18:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v2] virtio_ring: use alloc_pages_node for NUMA-aware
 allocation
Message-ID: <20200721041550-mutt-send-email-mst@kernel.org>
References: <20200721070013.62894-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721070013.62894-1-shile.zhang@linux.alibaba.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 03:00:13PM +0800, Shile Zhang wrote:
> Use alloc_pages_node() allocate memory for vring queue with proper
> NUMA affinity.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Jiang Liu <liuj97@gmail.com>
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>

Do you observe any performance gains from this patch?

I also wonder why isn't the probe code run on the correct numa node?
That would fix a wide class of issues like this without need to tweak
drivers.

Bjorn, what do you think? Was this considered?

> ---
> Changelog
> v1 -> v2:
> - fixed compile warning reported by LKP.
> ---
>  drivers/virtio/virtio_ring.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58b96baa8d48..d38fd6872c8c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -276,9 +276,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  		return dma_alloc_coherent(vdev->dev.parent, size,
>  					  dma_handle, flag);
>  	} else {
> -		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> -
> -		if (queue) {
> +		void *queue = NULL;
> +		struct page *page = alloc_pages_node(dev_to_node(vdev->dev.parent),
> +						     flag, get_order(size));
> +		if (page) {
> +			queue = page_address(page);
>  			phys_addr_t phys_addr = virt_to_phys(queue);
>  			*dma_handle = (dma_addr_t)phys_addr;
>  
> @@ -308,7 +310,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
>  	if (vring_use_dma_api(vdev))
>  		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
>  	else
> -		free_pages_exact(queue, PAGE_ALIGN(size));
> +		free_pages((unsigned long)queue, get_order(size));
>  }
>  
>  /*
> -- 
> 2.24.0.rc2

