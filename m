Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0B525DFBD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIDQYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 12:24:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44197 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725984AbgIDQYZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 12:24:25 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-GkkRB8BMPW6-a29cxkLlZA-1; Fri, 04 Sep 2020 12:24:20 -0400
X-MC-Unique: GkkRB8BMPW6-a29cxkLlZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E057F801AB7;
        Fri,  4 Sep 2020 16:24:18 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76CB07E161;
        Fri,  4 Sep 2020 16:24:13 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
Date:   Fri, 4 Sep 2020 18:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/21/20 3:15 PM, Jean-Philippe Brucker wrote:
> Add a topology description to the virtio-iommu driver and enable x86
> platforms.
> 
> Since [v2] we have made some progress on adding ACPI support for
> virtio-iommu, which is the preferred boot method on x86. It will be a
> new vendor-agnostic table describing para-virtual topologies in a
> minimal format. However some platforms don't use either ACPI or DT for
> booting (for example microvm), and will need the alternative topology
> description method proposed here. In addition, since the process to get
> a new ACPI table will take a long time, this provides a boot method even
> to ACPI-based platforms, if only temporarily for testing and
> development.
> 
> v3:
> * Add patch 1 that moves virtio-iommu to a subfolder.
> * Split the rest:
>   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
>     support.
>   * Patch 4 adds definitions.
>   * Patch 5 adds parser in topology.c.
> * Address other comments.
> 
> Linux and QEMU patches available at:
> https://jpbrucker.net/git/linux virtio-iommu/devel
> https://jpbrucker.net/git/qemu virtio-iommu/devel
I have tested that series with above QEMU branch on ARM with virtio-net
and virtio-blk translated devices in non DT mode.

It works for me:
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> 
> [spec] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.html
> [v2] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> [v1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
> [rfc] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> 
> Jean-Philippe Brucker (6):
>   iommu/virtio: Move to drivers/iommu/virtio/
>   iommu/virtio: Add topology helpers
>   PCI: Add DMA configuration for virtual platforms
>   iommu/virtio: Add topology definitions
>   iommu/virtio: Support topology description in config space
>   iommu/virtio: Enable x86 support
> 
>  drivers/iommu/Kconfig                     |  18 +-
>  drivers/iommu/Makefile                    |   3 +-
>  drivers/iommu/virtio/Makefile             |   4 +
>  drivers/iommu/virtio/topology-helpers.h   |  50 +++++
>  include/linux/virt_iommu.h                |  15 ++
>  include/uapi/linux/virtio_iommu.h         |  44 ++++
>  drivers/iommu/virtio/topology-helpers.c   | 196 ++++++++++++++++
>  drivers/iommu/virtio/topology.c           | 259 ++++++++++++++++++++++
>  drivers/iommu/{ => virtio}/virtio-iommu.c |   4 +
>  drivers/pci/pci-driver.c                  |   5 +
>  MAINTAINERS                               |   3 +-
>  11 files changed, 597 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/iommu/virtio/Makefile
>  create mode 100644 drivers/iommu/virtio/topology-helpers.h
>  create mode 100644 include/linux/virt_iommu.h
>  create mode 100644 drivers/iommu/virtio/topology-helpers.c
>  create mode 100644 drivers/iommu/virtio/topology.c
>  rename drivers/iommu/{ => virtio}/virtio-iommu.c (99%)
> 

