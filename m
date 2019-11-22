Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24A106F9A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfKVKuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:50:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfKVKuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:50:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so8087342wrr.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVZC8O5GuUsgdVDCzcN2CqTy4L8wnnx0IKWd5NiFgCs=;
        b=Q3aBSYS6L0keHFMg9s3YF/O/MS0ZbpfYzXYluOwOpxXbstgAIVmQmrUo3jmGNcrDMZ
         RRPRqees28PfvdT26W0bPHIpTF934vMZ1mdXqlDToqWtyVfmuX00leXURFV5dfkQ02NJ
         g8MLLi84nyK+BFemsn5DmX+bFGOhLRD0eyOqDxu7lLUZ9cyS3bFHai1Fg75a75rR5dmc
         HAtSQb2nq4jX33aT5hVPbjbJphW0npRYuRLSvtGKiec4rx5bJjM/h3+QM3a2GsLsz6Wf
         aE1lZ/Wt3JEJzcp0sPuMjwjNU7ZJsgm+knGVpf9Ib7BC1bjVvZmANR5bEwTu8vWj9Clx
         OrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVZC8O5GuUsgdVDCzcN2CqTy4L8wnnx0IKWd5NiFgCs=;
        b=CjILqmj8UeRebkEc9+FKIK88cFJz5wx7yoc+evaq5Nvplx30xUskRC1xkZPjOmShU5
         3e6oi6oaFdDamJRH1UdRFLn+SxIc6SzK1Gjli0DNeBp48fyxr8YQVNB3d5yzfAf1w9pL
         pZxoY7Wt2hSXCVXnyUBTvEuqetPG4iG6aqPtDJF5jON3+OSr2tKIqg+tIBGWr9LIs4jO
         cQ0w97NtctlwyP81ewVl7ZnC00lqQNkjB0df3rgzQGhCV+vWJrQkFe8BRS1O1JKOPPmB
         aLN7l0CwXNsk8jgiWxBj+s4PNOZbOTdKXN0bteG02WTvqQRX0XrO8c/fQWgyyxsYZ2jJ
         8Mtg==
X-Gm-Message-State: APjAAAV6npQ0jlq2LhOqc29nsMl8OBD4Rf42i0EIgKKiqllldR6mgEmi
        XFciuESGo8u3LOhSM2/ZtjOvIw==
X-Google-Smtp-Source: APXvYqwBWCyLPkUhZBo6K0fMA3vA5VrmhXM4U/1z4Br0F1oFeGiiIWprIEctPIwsTs5r8FDOo3DDYA==
X-Received: by 2002:adf:f688:: with SMTP id v8mr174600wrp.147.1574419850990;
        Fri, 22 Nov 2019 02:50:50 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id o133sm2088197wmb.4.2019.11.22.02.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:50:50 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: [RFC 00/13] virtio-iommu on non-devicetree platforms
Date:   Fri, 22 Nov 2019 11:49:47 +0100
Message-Id: <20191122105000.800410-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm seeking feedback on multi-platform support for virtio-iommu. At the
moment only devicetree (DT) is supported and we don't have a pleasant
solution for other platforms. Once we figure out the topology
description, x86 support is trivial.

Since the IOMMU manages memory accesses from other devices, the guest
kernel needs to initialize the IOMMU before endpoints start issuing DMA.
It's a solved problem: firmware or hypervisor describes through DT or
ACPI tables the device dependencies, and probe of endpoints is deferred
until the IOMMU is probed. But:

(1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD and IORT
    for Arm). From my point of view IORT is easier to extend, since we
    just need to introduce a new node type. There are no dependencies to
    Arm in the Linux IORT driver, so it works well with CONFIG_X86.

    However, there are concerns about other OS vendors feeling obligated
    to implement this new node, so Arm proposed introducing another ACPI
    table, that can wrap any of DMAR, IVRS and IORT to extend it with
    new virtual nodes. A draft of this VIOT table specification is
    available at http://jpbrucker.net/virtio-iommu/viot/viot-v5.pdf

    I'm afraid this could increase fragmentation as guests would need to
    implement or modify their support for all of DMAR, IVRS and IORT. If
    we end up doing VIOT, I suggest limiting it to IORT.

(2) In addition, there are some concerns about having virtio depend on
    ACPI or DT. Some hypervisors (Firecracker, QEMU microvm, kvmtool x86
    [1]) don't currently implement those methods.

    It was suggested to embed the topology description into the device.
    It can work, as demonstrated at the end of this RFC, with the
    following limitations:

    - The topology description must be read before any endpoint managed
      by the IOMMU is probed, and even before the virtio module is
      loaded. This RFC uses a PCI quirk to manually parse the virtio
      configuration. It assumes that all endpoints managed by the IOMMU
      are under this same PCI host.

    - I don't have a solution for the virtio-mmio transport at the
      moment, because I haven't had time to modify a host to test it. I
      think it could either use a notifier on the platform bus, or
      better, a new 'iommu' command-line argument to the virtio-mmio
      driver. So the current prototype doesn't work for firecracker and
      microvm, which rely on virtio-mmio.

    - For Arm, if the platform has an ITS, the hypervisor needs IORT or
      DT to describe it anyway. More generally, not using either ACPI or
      DT might prevent from supporting other features as well. I suspect
      the above users will have to implement a standard method sooner or
      later.

    - Even when reusing as much existing code as possible, guest support
      is still going to be around a few hundred lines since we can't
      rely on the normal virtio infrastructure to be loaded at that
      point. As you can see below, the diffstat for the incomplete
      topology implementation is already bigger than the exhaustive IORT
      support, even when jumping through the VIOT hoop.

    So it's a lightweight solution for very specific use-cases, and we
    should still support ACPI for the general case. Multi-platform
    guests such as Linux will then need to support three topology
    descriptions instead of two.

In this RFC I present both solutions, but I'd rather not keep all of it.
Please see the individual patches for details:

(1) Patches 1, 3-10 add support for virtio-iommu to the Linux IORT
    driver and patches 2, 11 add the VIOT glue.

(2) Patch 12 adds the built-in topology description to the virtio-iommu
    specification. Patch 13 is a partial implementation for the Linux
    virtio-iommu driver. It only supports PCI, not platform devices.

You can find Linux and QEMU code on my virtio-iommu/devel branches at
http://jpbrucker.net/git/linux and http://jpbrucker.net/git/qemu


I split the diffstat since there are two independent features. The first
one is for patches 1-11, and the second one for patch 13.

Jean-Philippe Brucker (11):
  ACPI/IORT: Move IORT to the ACPI folder
  ACPI: Add VIOT definitions
  ACPI/IORT: Allow registration of external tables
  ACPI/IORT: Add node categories
  ACPI/IORT: Support VIOT virtio-mmio node
  ACPI/IORT: Support VIOT virtio-pci node
  ACPI/IORT: Defer probe until virtio-iommu-pci has registered a fwnode
  ACPI/IORT: Add callback to update a device's fwnode
  iommu/virtio: Create fwnode if necessary
  iommu/virtio: Update IORT fwnode
  ACPI: Add VIOT table

 MAINTAINERS                     |   9 +
 drivers/acpi/Kconfig            |   7 +
 drivers/acpi/Makefile           |   2 +
 drivers/acpi/arm64/Kconfig      |   3 -
 drivers/acpi/arm64/Makefile     |   1 -
 drivers/acpi/bus.c              |   2 +
 drivers/acpi/{arm64 => }/iort.c | 317 ++++++++++++++++++++++++++------
 drivers/acpi/tables.c           |   2 +-
 drivers/acpi/viot.c             |  44 +++++
 drivers/iommu/Kconfig           |   1 +
 drivers/iommu/virtio-iommu.c    |  61 +++++-
 include/acpi/actbl2.h           |  31 ++++
 include/linux/acpi_iort.h       |  14 ++
 include/linux/acpi_viot.h       |  20 ++
 14 files changed, 448 insertions(+), 66 deletions(-)
 rename drivers/acpi/{arm64 => }/iort.c (86%)
 create mode 100644 drivers/acpi/viot.c
 create mode 100644 include/linux/acpi_viot.h

Jean-Philippe Brucker (1):
  iommu/virtio: Add topology description to virtio-iommu config space

 drivers/base/platform.c               |   3 +
 drivers/iommu/Kconfig                 |   9 +
 drivers/iommu/Makefile                |   1 +
 drivers/iommu/virtio-iommu-topology.c | 410 ++++++++++++++++++++++++++
 drivers/iommu/virtio-iommu.c          |   3 +
 drivers/pci/pci-driver.c              |   3 +
 include/linux/virtio_iommu.h          |  18 ++
 include/uapi/linux/virtio_iommu.h     |  26 ++
 8 files changed, 473 insertions(+)
 create mode 100644 drivers/iommu/virtio-iommu-topology.c
 create mode 100644 include/linux/virtio_iommu.h


[1] firecracker: https://github.com/firecracker-microvm/firecracker
    microvm: https://github.com/qemu/qemu/blob/master/docs/microvm.rst
    kvmtool: https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git/
-- 
2.24.0

