Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C2252FA6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Aug 2020 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgHZN02 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Aug 2020 09:26:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730243AbgHZN01 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2020 09:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598448385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MkzQ6QG6I3q9nGpvzTY0xeeHjgqsvGJlxwUyvGFDZ+4=;
        b=jHR/Meiv8Rm4hKdg8QrYkRsvA6hMxciWBY/ljjYhzoPG0Qu8TBnzdedMcjt7/8ocXFLrlD
        G9tiX9lXvlhDV0W9W9jGhUn751xhOcWVpMAYl8RxsS0Sf/bEJQebDskOdDhRcsmBryrc0C
        Hd3NNRYCs0FslBH5FpSyFsdOiBhInKA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-eC32FfN8MouahRxj_pB7Kw-1; Wed, 26 Aug 2020 09:26:21 -0400
X-MC-Unique: eC32FfN8MouahRxj_pB7Kw-1
Received: by mail-wm1-f71.google.com with SMTP id k12so877921wmj.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2020 06:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MkzQ6QG6I3q9nGpvzTY0xeeHjgqsvGJlxwUyvGFDZ+4=;
        b=beiQximH6QbJsXG7OpQQtVKhng9Mo0SonSwu3glqiveFcpFM4Pwx/h35fKGIZDunG3
         b1gRoC6+HQFZEOS/ZuHENz4GwlQg0CygswiHp9lrHVVQ9MSLU0CpVoRT8U6oxXCo1oGW
         LplJA+kcU5FzxNzzjZ4RCVwgOZg9Vf62suk+hLgzKiMG8AZabcjq1264qf829ySOGOm0
         ULEzqIVkiMCJJY1FsMnqMAAVdgSttLZk/dfVKR2IPsgIpXKuwA8i6X7xhE9XlfBO15qm
         EUmnjqa8DmM9mF2wOxH+fA1qmLS2ZRRhX7KlMQYz4PtZkGBviZVz3u82AWAlcaHyCdOM
         NGrw==
X-Gm-Message-State: AOAM530bBgl+Er/Zuicj7WrFG4ZoLKMSxWvGcVZ4D841A1F6TEo0t+D0
        cqMJd6lLf00G9TUijVu6JBO5F5vzhRnT+1iNszI2PclF0lTSpg75gZReQDe1WSlPFvOwIQX/p74
        Le6n3W3XEjT1Jo45WYo+1
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr7456511wmh.31.1598448379685;
        Wed, 26 Aug 2020 06:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi9aZpSBzDPZ4YhRao8GK4t0yYAUzHdvj2YCsqb1ChjyiMN53z1cQZmWVo7qm7qMPKOLNWDA==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr7456493wmh.31.1598448379478;
        Wed, 26 Aug 2020 06:26:19 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id v7sm8462813wma.1.2020.08.26.06.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:26:18 -0700 (PDT)
Date:   Wed, 26 Aug 2020 09:26:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        kevin.tian@intel.com, sebastien.boeuf@intel.com,
        bhelgaas@google.com, jasowang@redhat.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200826092542-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
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

OK should I park this in next now? Seems appropriate ...

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
> -- 
> 2.28.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

