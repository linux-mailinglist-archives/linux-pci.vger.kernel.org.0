Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75B22C803E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 09:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgK3Ipb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 03:45:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbgK3Ipb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 03:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606725844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ey1C0d9PZ+jC1SeRokoRwtQYfI7PDl+5m30mISh+nx8=;
        b=H6pThWSefJwCShdlBzZQCVSBiPVPY/SVaLtp081yHea4W2E36QRBYVuxQlQPAtwBDJPabz
        JVAyBNz3VTrKRpKJbuKEL1nS5tYvJr7fO7XrgUfICM3kDL4mMKgBaOwXLjpHu9k6f2h/UQ
        3KiCSAXOvYok8cUgAwEvg6VFw95EGVE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-Si6iPO4jPWKEMjvmLNcWsQ-1; Mon, 30 Nov 2020 03:44:01 -0500
X-MC-Unique: Si6iPO4jPWKEMjvmLNcWsQ-1
Received: by mail-ed1-f71.google.com with SMTP id g1so6371730edk.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Nov 2020 00:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ey1C0d9PZ+jC1SeRokoRwtQYfI7PDl+5m30mISh+nx8=;
        b=pWusUZgw3E6TgosWYQQtdgAqlHRxqnzFaXmiTRXnIJirOiom2OsSc2okCIkT1BcGQz
         CFPBhfsnrVYbp9+QUFTQ5UyZbLXiV5lTPRPeolxhdf4VqLzJKWNuG4x1nRXskuAOBd1w
         EQM6hu2mOrKoFLRLPO3PXk9LzscQYzoxBv0MELZ1A+RG+Uvj1VrIlo4l6pMDykqIFm+9
         tSEF9wRvz5collBSJh2cVgNMdBSWNURhhY3ZP9oV0TxSMWGurIApVWdI1sBYRu52/JcA
         aXat5IeqaOci7o/vM8Aip2v0ChC7C9VZZ9PrZ6On0wmS+t0uRXiIcfpf+YI7+vPcMn4x
         p4Iw==
X-Gm-Message-State: AOAM532njn2BtcUWUV+4IGP/5I8GEHWE3BXwWq7FSkQYjgwm4DTKLsOB
        Mkzd2tIDft2i00tSsRZNTnEWyUTrCFDhYNORny2x3x+mo67Qi0peslgiYmt/tg2+MlUQM9Xzcsy
        YQsuDw9kRNx1FOlZXbJdh
X-Received: by 2002:a17:906:aac1:: with SMTP id kt1mr567769ejb.329.1606725840171;
        Mon, 30 Nov 2020 00:44:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxs3ln5Efn41CjmIOtYUTR38V2LHcxx3XUgPY7qefkj2/Jh8zpB5MhDtTGr1Nse7RBqGNLFPA==
X-Received: by 2002:a17:906:aac1:: with SMTP id kt1mr567760ejb.329.1606725840030;
        Mon, 30 Nov 2020 00:44:00 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d10sm7897462ejc.39.2020.11.30.00.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 00:43:59 -0800 (PST)
Subject: Re: 5.10 regression caused by: "uas: fix sdev->host->dma_dev": many
 XHCI swiotlb buffer is full / DMAR: Device bounce map failed errors on
 thunderbolt connected XHCI controller
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tom Yan <tom.ty89@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com>
 <be031d15-201f-0e5c-8b0f-be030077141f@redhat.com>
 <20201124102715.GA16983@lst.de>
 <fde7e11f-5dfc-8348-c134-a21cb1116285@redhat.com>
 <8a52e868-0ca1-55b7-5ad2-ddb0cbb5e45d@redhat.com>
 <20201127161900.GA10986@lst.de>
 <fded04e2-f2e9-de92-ab1f-5aa088904e90@redhat.com>
 <20201128171500.GA3550@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a84974a8-514b-690b-480b-c82c0617fec0@redhat.com>
Date:   Mon, 30 Nov 2020 09:43:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128171500.GA3550@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/28/20 6:15 PM, Christoph Hellwig wrote:
> Can you give this one-liner a spin?
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c6622011d4938c..e889111b55c71d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4007,6 +4007,7 @@ static const struct dma_map_ops bounce_dma_ops = {
>  	.alloc_pages		= dma_common_alloc_pages,
>  	.free_pages		= dma_common_free_pages,
>  	.dma_supported		= dma_direct_supported,
> +	.max_mapping_size	= swiotlb_max_mapping_size,
>  };
>  
>  static inline int iommu_domain_cache_init(void)
> 

I'm afraid that this does not help.

Also I still find it somewhat wrong that the use of scsi_add_host_with_dma()
in uas.c, which then passed the XHCI controller as dma-dev is causing changes
to the DMA settings of the XHCI controller, impacting *other* USB devices
and these changes also are permanent, they stay around even after unbinding
the uas driver.

This just feels wrong on many levels. If some changes to the XHCI controllers
DMA settings are necessary for better uas performance then these changes
really should be made inside the XHCI driver, so that they always apply and
not have this weirdness going on where binding one USB driver permanently
changes the behavior of the entire USB bus (until rebooted).

Querying the DMA settings of the XHCI controller in the uas driver is fine,
but changing them seems like a big nono to me.

Regards,

Hans

