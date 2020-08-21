Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839E724D5EB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgHUNQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgHUNQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 09:16:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F4C061385
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so1558468ejz.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/asOEQ7I5lK9SCfOrPxX9Ij7ThPhJXGbgb9Vg60QdU=;
        b=EYBouRuvx7C7M1g4+Ts8UzFEMdS8ULDwuOJEs1eOkgISO70lUT/4Bvu/b1h1GvERCl
         rKI7LPJD38AhqdjZ/lSpOArHlbNCvqLuAHOWkeu+OWoua5ljvoIl8M1kqX/r2VxoBq//
         SOrSe/51+7gXMFValJMarQpshl2SpMbFVAkyEvvD59ixQdldOvOWlq7nETtEXla4XPyN
         AOPoYkrkNhg9tMEXekpD3atg/nxtUf5yS1cQz2fuBJq10wwAV6IE3DZy7UnG8q5Z3oJ/
         3TWv1ugObjE4oa7EDAXgTv8M7m8QyMKkjXIbXeNK8e3KaTGVDHRHUbJcfn9TlVH9F4AV
         YDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/asOEQ7I5lK9SCfOrPxX9Ij7ThPhJXGbgb9Vg60QdU=;
        b=nrTqiFnFt7u1ooahROo0GgEg2PORr1AcdbquTB/rtwqTDRP93a0lKqqgg12HqMtJ93
         zkHnDXB8X1CZtUvVAuS6ar1+X1xF89RxoXyExzHDld6iHUfXWX+w66DnR5nPjFjuDz+2
         F+VYpdqeLYnJjbbz8M6u5coUio5HmtLCCETjDD/+P7QzeNbRT3gXe5RmFiknQ4UJ5XuD
         jEe9LCTTqeNJ+K9VuvupwjPRV1ioRc9GgPOOUZ5RsSwWQm+qHbP89K47jXh3stQcdSQw
         Bh+CIbvMqCij5aqyBP3Jdn3SolA/urisDzhmw4dBXmPFI8eLtBMu4dPJEKfXklQPob6f
         swhg==
X-Gm-Message-State: AOAM531k3bBs6zzt1bdWimBCIvi3oG9ytfYrcnV6xIWi3YWPjQ1i8gf0
        yiz650xl8DbifuwhHXDpYZ7Wgg==
X-Google-Smtp-Source: ABdhPJwOy/5jkRbdPAXN7lLeuSinZ0dNBsa/xxJXp4vx3NLHlrjucaVJpRbbUOOksUhqw9JvR5D63A==
X-Received: by 2002:a17:906:dbd2:: with SMTP id yc18mr2371358ejb.394.1598015767083;
        Fri, 21 Aug 2020 06:16:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:16:06 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 0/6] Add virtio-iommu built-in topology
Date:   Fri, 21 Aug 2020 15:15:34 +0200
Message-Id: <20200821131540.2801801-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a topology description to the virtio-iommu driver and enable x86
platforms.

Since [v2] we have made some progress on adding ACPI support for
virtio-iommu, which is the preferred boot method on x86. It will be a
new vendor-agnostic table describing para-virtual topologies in a
minimal format. However some platforms don't use either ACPI or DT for
booting (for example microvm), and will need the alternative topology
description method proposed here. In addition, since the process to get
a new ACPI table will take a long time, this provides a boot method even
to ACPI-based platforms, if only temporarily for testing and
development.

v3:
* Add patch 1 that moves virtio-iommu to a subfolder.
* Split the rest:
  * Patch 2 adds topology-helper.c, which will be shared with the ACPI
    support.
  * Patch 4 adds definitions.
  * Patch 5 adds parser in topology.c.
* Address other comments.

Linux and QEMU patches available at:
https://jpbrucker.net/git/linux virtio-iommu/devel
https://jpbrucker.net/git/qemu virtio-iommu/devel

[spec] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.html
[v2] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
[v1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
[rfc] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (6):
  iommu/virtio: Move to drivers/iommu/virtio/
  iommu/virtio: Add topology helpers
  PCI: Add DMA configuration for virtual platforms
  iommu/virtio: Add topology definitions
  iommu/virtio: Support topology description in config space
  iommu/virtio: Enable x86 support

 drivers/iommu/Kconfig                     |  18 +-
 drivers/iommu/Makefile                    |   3 +-
 drivers/iommu/virtio/Makefile             |   4 +
 drivers/iommu/virtio/topology-helpers.h   |  50 +++++
 include/linux/virt_iommu.h                |  15 ++
 include/uapi/linux/virtio_iommu.h         |  44 ++++
 drivers/iommu/virtio/topology-helpers.c   | 196 ++++++++++++++++
 drivers/iommu/virtio/topology.c           | 259 ++++++++++++++++++++++
 drivers/iommu/{ => virtio}/virtio-iommu.c |   4 +
 drivers/pci/pci-driver.c                  |   5 +
 MAINTAINERS                               |   3 +-
 11 files changed, 597 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/virtio/Makefile
 create mode 100644 drivers/iommu/virtio/topology-helpers.h
 create mode 100644 include/linux/virt_iommu.h
 create mode 100644 drivers/iommu/virtio/topology-helpers.c
 create mode 100644 drivers/iommu/virtio/topology.c
 rename drivers/iommu/{ => virtio}/virtio-iommu.c (99%)

-- 
2.28.0

