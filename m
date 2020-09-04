Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4F25DDBF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgIDPaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 11:30:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25369 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725984AbgIDPaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 11:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599233404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRdDsTplpUOo4libxw8O1Q2NtW0tDZkh0RhwSXPBuqI=;
        b=h4uK8vB8r2OBiuDcGNgnsUsFeRV13e9MUfm807ZZpZuYsmMeeW30wOvxXVuQe4+0BI+Q0S
        zvrwoGSLsnCUCsRbb/x6oUIFset/78qhDgvUbSDY2WW0PUMRS1Z3fCHNVaGGfP2VtxfPbc
        1FYeD+8iYGfgBTdcdqIz5oGXo6uxqKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-ubmidy7jMGOZc6NNGDjlUQ-1; Fri, 04 Sep 2020 11:30:00 -0400
X-MC-Unique: ubmidy7jMGOZc6NNGDjlUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C90A01029D25;
        Fri,  4 Sep 2020 15:29:58 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECD235C1D0;
        Fri,  4 Sep 2020 15:29:55 +0000 (UTC)
Subject: Re: [PATCH v3 1/6] iommu/virtio: Move to drivers/iommu/virtio/
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-2-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <894aa803-644b-b6f2-2a28-73c388430ac6@redhat.com>
Date:   Fri, 4 Sep 2020 17:29:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200821131540.2801801-2-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 8/21/20 3:15 PM, Jean-Philippe Brucker wrote:
> Before adding new files to the virtio-iommu driver, move it to its own
> subfolder, similarly to other IOMMU drivers.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/Makefile                    | 3 +--
>  drivers/iommu/virtio/Makefile             | 2 ++
>  drivers/iommu/{ => virtio}/virtio-iommu.c | 0
>  MAINTAINERS                               | 2 +-
>  4 files changed, 4 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iommu/virtio/Makefile
>  rename drivers/iommu/{ => virtio}/virtio-iommu.c (100%)
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 11f1771104f3..fc7523042512 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y += amd/ intel/ arm/
> +obj-y += amd/ intel/ arm/ virtio/
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> @@ -26,4 +26,3 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> -obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
> new file mode 100644
> index 000000000000..279368fcc074
> --- /dev/null
> +++ b/drivers/iommu/virtio/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio/virtio-iommu.c
> similarity index 100%
> rename from drivers/iommu/virtio-iommu.c
> rename to drivers/iommu/virtio/virtio-iommu.c
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..3602b223c9b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18451,7 +18451,7 @@ VIRTIO IOMMU DRIVER
>  M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Maintained
> -F:	drivers/iommu/virtio-iommu.c
> +F:	drivers/iommu/virtio/
>  F:	include/uapi/linux/virtio_iommu.h
not related to this patch but you may add an entry for
Documentation/devicetree/bindings/virtio/iommu.txt

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>  
>  VIRTIO MEM DRIVER
> 

