Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4025DDC1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgIDPbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 11:31:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725984AbgIDPbE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 11:31:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-nYjy5zslPtSMcl84myYsjQ-1; Fri, 04 Sep 2020 11:30:59 -0400
X-MC-Unique: nYjy5zslPtSMcl84myYsjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CF3A100748B;
        Fri,  4 Sep 2020 15:30:57 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 552DB7093C;
        Fri,  4 Sep 2020 15:30:49 +0000 (UTC)
Subject: Re: [PATCH v3 4/6] iommu/virtio: Add topology definitions
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-5-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <a9f99946-cdfc-a0f5-b742-2b89a6bd9569@redhat.com>
Date:   Fri, 4 Sep 2020 17:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200821131540.2801801-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 8/21/20 3:15 PM, Jean-Philippe Brucker wrote:
> Add struct definitions for describing endpoints managed by the
> virtio-iommu. When VIRTIO_IOMMU_F_TOPOLOGY is offered, an array of
> virtio_iommu_topo_* structures in config space describes the endpoints,
> identified either by their PCI BDF or their physical MMIO address.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  include/uapi/linux/virtio_iommu.h | 44 +++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..70cba30644d5 100644
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
> @@ -27,6 +28,17 @@ struct virtio_iommu_range_32 {
>  	__le32					end;
>  };
>  
> +struct virtio_iommu_topo_config {
> +	/* Number of topology description structures */
> +	__le16					count;
> +	/*
> +	 * Offset to the first topology description structure
> +	 * (virtio_iommu_topo_*) from the start of the virtio_iommu config
> +	 * space. Aligned on 8 bytes.
> +	 */
> +	__le16					offset;
> +};
> +
>  struct virtio_iommu_config {
>  	/* Supported page sizes */
>  	__le64					page_size_mask;
> @@ -36,6 +48,38 @@ struct virtio_iommu_config {
>  	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
>  	__le32					probe_size;
> +	struct virtio_iommu_topo_config		topo_config;
> +};
> +
> +#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x1
> +#define VIRTIO_IOMMU_TOPO_MMIO			0x2
> +
> +struct virtio_iommu_topo_pci_range {
> +	/* VIRTIO_IOMMU_TOPO_PCI_RANGE */
> +	__u8					type;
> +	__u8					reserved;
> +	/* Length of this structure */
> +	__le16					length;
> +	/* First endpoint ID in the range */
> +	__le32					endpoint_start;
> +	/* PCI domain number */
> +	__le16					segment;
> +	/* PCI Bus:Device.Function range */
> +	__le16					bdf_start;
> +	__le16					bdf_end;
> +	__le16					padding;
> +};
> +
> +struct virtio_iommu_topo_mmio {
> +	/* VIRTIO_IOMMU_TOPO_MMIO */
> +	__u8					type;
> +	__u8					reserved;
> +	/* Length of this structure */
> +	__le16					length;
> +	/* Endpoint ID */
> +	__le32					endpoint;
> +	/* Address of the first MMIO region */
> +	__le64					address;
>  };
>  
>  /* Request types */
> 

