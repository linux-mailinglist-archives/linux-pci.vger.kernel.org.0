Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111FB1A66DD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgDMNWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 09:22:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40201 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbgDMNWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 09:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586784151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0PdiEszlmuGkdCTdCPanAdeTLpgTEN2jG8uLZ7FuSm8=;
        b=OB9G5zwfUkrvKw7QetefY+RBGBumvO8A6zeDVZtb3WBnTflokyncUDVpsOqIrGhy1EGtZ1
        bj4yMygNJUZ4I4LynPccS8Ii9woMXQyn/6D+9uYYr0bLNaA3bnKneSh0CR6q91dxV8Hqwn
        57USOHu1bf5Zuf/mxY2uZOe2NixZjL0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-EeILSOpNPEmIzLlGjanCHg-1; Mon, 13 Apr 2020 09:22:30 -0400
X-MC-Unique: EeILSOpNPEmIzLlGjanCHg-1
Received: by mail-wr1-f70.google.com with SMTP id 11so359884wrc.3
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2020 06:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0PdiEszlmuGkdCTdCPanAdeTLpgTEN2jG8uLZ7FuSm8=;
        b=SBwq6+9ecO9pxRMNzR4U8uEWV2Rm7uC/esVPkZaXSKXmUaUe+Jp+OrwrwaJ8sOWKoJ
         ecFiKiU8EzEpayRiALhzQ7x93VJuBgGLwMF2tSdA1qN0DeE69NF/9/vUO4MVwF+q9E8e
         75K0P6oUGU2g1VwpZ5zaQRWVxo4JtVwUzBb6PXSl0PA0PqWYCGFfr+HyU26y+lsbgKPh
         QYEFef/C+vFXG7NXQFzkbZS5UFw4P8ZOxdw9CvABP1KYJuRvlf/BDdY6ovBtQMghISwd
         C1zyL4MI9Sf61h2+ZfOKnxA87sQl93Ou6hIva2M5/eoZcXnuKyZnjDRfzowdJlxSgM+V
         7Fyw==
X-Gm-Message-State: AGi0PuaWCJt5MmvpRI4nASQsBxSqB4s8sQE7lFWISrBlXh1H9g7Uwdwp
        gUNcoSCsWNC+rsRzhOP6z6gstEOo8fTRdCWRaeKG4GyZnFTwdAawzFbqHxPVcz0A0eCs1pBVpI1
        zB02OOv0GpgSbc7ZPEqDe
X-Received: by 2002:adf:f343:: with SMTP id e3mr10209303wrp.51.1586784149266;
        Mon, 13 Apr 2020 06:22:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJEAGSwrzL3vQ67rkOtqT1/sfEwf7eMuRq2HTHdDqkOFbKnqIPy+fW8j5vivRuXTGBlXzeIlQ==
X-Received: by 2002:adf:f343:: with SMTP id e3mr10209287wrp.51.1586784149081;
        Mon, 13 Apr 2020 06:22:29 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
        by smtp.gmail.com with ESMTPSA id b82sm15672990wme.25.2020.04.13.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:22:28 -0700 (PDT)
Date:   Mon, 13 Apr 2020 09:22:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, joro@8bytes.org, bhelgaas@google.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200413091355-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228172537.377327-2-jean-philippe@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..ec57d215086a 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -16,6 +16,7 @@
>  #define VIRTIO_IOMMU_F_BYPASS			3
>  #define VIRTIO_IOMMU_F_PROBE			4
>  #define VIRTIO_IOMMU_F_MMIO			5
> +#define VIRTIO_IOMMU_F_TOPOLOGY			6
>  
>  struct virtio_iommu_range_64 {
>  	__le64					start;
> @@ -27,6 +28,12 @@ struct virtio_iommu_range_32 {
>  	__le32					end;
>  };
>  
> +struct virtio_iommu_topo_config {
> +	__le32					offset;

Any restrictions on offset? E.g. alignment?

> +	__le32					num_items;
> +	__le32					item_length;
> +};
> +
>  struct virtio_iommu_config {
>  	/* Supported page sizes */
>  	__le64					page_size_mask;
> @@ -36,6 +43,25 @@ struct virtio_iommu_config {
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
>  	__le32					probe_size;
> +	struct virtio_iommu_topo_config		topo_config;
> +};
> +
> +#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x1
> +#define VIRTIO_IOMMU_TOPO_ENDPOINT		0x2
> +
> +struct virtio_iommu_topo_pci_range {
> +	__le16					type;
> +	__le16					hierarchy;
> +	__le16					requester_start;
> +	__le16					requester_end;
> +	__le32					endpoint_start;
> +};
> +
> +struct virtio_iommu_topo_endpoint {
> +	__le16					type;
> +	__le16					reserved;
> +	__le32					endpoint;
> +	__le64					address;
>  };
>  
>  /* Request types */

As any UAPI change, this needs to be copied to virtio TC.

I believe an old version of QEMU patches was published there
but I don't think it was the latest one you tested against.

Description should preferably be added to spec too.

In partucular please add comments (in this header, too)
documenting the new fields, values and structures.

> -- 
> 2.25.0

