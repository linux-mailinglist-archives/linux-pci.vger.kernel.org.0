Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BB276C90
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 11:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIXJBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 05:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbgIXJBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 05:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600938059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUGrf6sKN5n1jpxMEY27z8eDMfPfaHEAHvK9zipmPr8=;
        b=P+4UJpA264hDwgzOefM2E9aDdt6eNLLgo2Cj4XS50JmaWc55kl3lseR509v80UFA/o2d+o
        nngxrhIEctH/m+FnqgjAtyuhi8y4nv5Yt6aE4fHx0ECgjzl/L8YTEsuySDphnSi8FpxNS6
        xb/BZAzOdWcUPtUevrA99Bu+/Vqf6qE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-qGDn8b22MgOZE7gtre1TtA-1; Thu, 24 Sep 2020 05:00:41 -0400
X-MC-Unique: qGDn8b22MgOZE7gtre1TtA-1
Received: by mail-wr1-f71.google.com with SMTP id b7so978743wrn.6
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 02:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GUGrf6sKN5n1jpxMEY27z8eDMfPfaHEAHvK9zipmPr8=;
        b=suMvYXWgVrkY32zBHSvru03z4dpGT9HssmdViHIpxwWviI7aIdl1ymD5H8mM3n8oLz
         8Ry5Qm/hG/P6c5UK+F7fq1o0w0W6lLYRAG+C2/VnuouQ2f0MW/j7AIffzFdBji4ZSqs5
         FfXOjRYiiDoI7zULDRESrWkTiX0Cvb9tqmbKxGfo1xGtqjJ0fkwpOpqkcdsh9sfK2Urd
         /98VyoMWMQZuMfEfUs6unYPrws1RBnQFIbq409fRm7mKrAyitFrrD0ERMq0R/eDJPYWV
         dDV0fFjlj0LV7AqfLvyJHz79DpiRVnsqjmacgszHVoJPbXBv48hukmV7a2XZmAT/9ZXA
         oAZQ==
X-Gm-Message-State: AOAM530uOkxyD9NzQQlBZ/5aDMq4tLt0OMzyqGp8uqKfGhz4aOcPcV7S
        Jak8CKrh+ktK5CGw/GLCCbuGh3eruFcBSe2S8rvD7dKu0d+q+rwz5SSAFW8+wEwKjXHbmHjfMC0
        sj1UqSj5BOvEYaRDyPKf4
X-Received: by 2002:adf:fe42:: with SMTP id m2mr3827872wrs.367.1600938040405;
        Thu, 24 Sep 2020 02:00:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM6amM8onmWtTQ2m03dl19rxCsYdxhcLJwZMHlUC1IovGw8tlcX+SAAylK/ze3a948rFpahg==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr3827842wrs.367.1600938040173;
        Thu, 24 Sep 2020 02:00:40 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
        by smtp.gmail.com with ESMTPSA id h16sm3001574wre.87.2020.09.24.02.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:00:39 -0700 (PDT)
Date:   Thu, 24 Sep 2020 05:00:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, jasowang@redhat.com,
        kevin.tian@intel.com, sebastien.boeuf@intel.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924045958-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 06:24:12PM +0200, Auger Eric wrote:
> Hi,
> 
> On 8/21/20 3:15 PM, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> > 
> > v3:
> > * Add patch 1 that moves virtio-iommu to a subfolder.
> > * Split the rest:
> >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> >     support.
> >   * Patch 4 adds definitions.
> >   * Patch 5 adds parser in topology.c.
> > * Address other comments.
> > 
> > Linux and QEMU patches available at:
> > https://jpbrucker.net/git/linux virtio-iommu/devel
> > https://jpbrucker.net/git/qemu virtio-iommu/devel
> I have tested that series with above QEMU branch on ARM with virtio-net
> and virtio-blk translated devices in non DT mode.
> 
> It works for me:
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric

OK so this looks good. Can you pls repost with the minor tweak
suggested and all acks included, and I will queue this?

Thanks!

> > 
> > [spec] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.html
> > [v2] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> > [v1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
> > [rfc] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> > 
> > Jean-Philippe Brucker (6):
> >   iommu/virtio: Move to drivers/iommu/virtio/
> >   iommu/virtio: Add topology helpers
> >   PCI: Add DMA configuration for virtual platforms
> >   iommu/virtio: Add topology definitions
> >   iommu/virtio: Support topology description in config space
> >   iommu/virtio: Enable x86 support
> > 
> >  drivers/iommu/Kconfig                     |  18 +-
> >  drivers/iommu/Makefile                    |   3 +-
> >  drivers/iommu/virtio/Makefile             |   4 +
> >  drivers/iommu/virtio/topology-helpers.h   |  50 +++++
> >  include/linux/virt_iommu.h                |  15 ++
> >  include/uapi/linux/virtio_iommu.h         |  44 ++++
> >  drivers/iommu/virtio/topology-helpers.c   | 196 ++++++++++++++++
> >  drivers/iommu/virtio/topology.c           | 259 ++++++++++++++++++++++
> >  drivers/iommu/{ => virtio}/virtio-iommu.c |   4 +
> >  drivers/pci/pci-driver.c                  |   5 +
> >  MAINTAINERS                               |   3 +-
> >  11 files changed, 597 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/iommu/virtio/Makefile
> >  create mode 100644 drivers/iommu/virtio/topology-helpers.h
> >  create mode 100644 include/linux/virt_iommu.h
> >  create mode 100644 drivers/iommu/virtio/topology-helpers.c
> >  create mode 100644 drivers/iommu/virtio/topology.c
> >  rename drivers/iommu/{ => virtio}/virtio-iommu.c (99%)
> > 

