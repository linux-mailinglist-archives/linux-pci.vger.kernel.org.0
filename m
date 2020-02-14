Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E50A15ED13
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 18:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391957AbgBNRbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 12:31:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33949 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390157AbgBNQGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2020 11:06:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so9557922wrm.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2020 08:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZOdeYob0unxBnNaicbQBgm32/JrXg0BrJwyt1f7elc=;
        b=hE7o6GpoP5twPWF3gKHH23ktUStiNlbQBAVgFayAEV72YEEKY6SRWo90uFcpbYe+kC
         6RbWy5ms1zZkbB9VCUseGI/evxbiBmVjK1QmpgMOT+917SK1z6TAn3nnyk/AwiiXXhMb
         Ju3cC7ma+PzAfxt782ZNHMdnCRZYvBKtwMc6IbgNhA8YAav7wgLvKExz4tY6lpGOyNXg
         ePOuQprWiaTOVQG/W0G4gN1qfmLIx8OsjSLs/uXTWDCSko91iQGGnY7iwrfJAAR1PA0s
         BOEM/+H0YT1ukQw7u5irxo8Zi8P0BvZjomyaiZRRIBGjUY9IBtq+ZKIqq3H00OEErZmF
         tquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZOdeYob0unxBnNaicbQBgm32/JrXg0BrJwyt1f7elc=;
        b=DGsK+8wgEvSXUb4galcSTwIJV+6MycyHADekjZgs30rRFNIVVPs2qvoXVe8eKHhPre
         qdNfi3TORH/IbgQHu94N4VTSxISq897OVU+lFc44L38Yvi3wbK8m685caKXubgkTX8vP
         EAuHtnPB63lBPAlunp+vHHHzmSMWsALeOjCGbl0bmSBFLILq0TQ7O5p1R5RPTLschhgm
         nKIkeXRj2pFXy31vfGPNkwurtHMH7Yl/hg3dApmhM5C2D+c0/TjNEK3tUAw3t2IcQyUn
         RIZCVeSw/OpdI1VWjfsU06vOJx1FTKcj1xAQ2aT7MI57zGgbGpuPRlBJD6t/HomonilB
         nc0A==
X-Gm-Message-State: APjAAAXJBoNAp4MlVD01xNV9l89uxzzCVQTg2RX3TGnBseFjL7tULUfs
        J6kJXx5KMe5ghVOTfoAyca3M4g==
X-Google-Smtp-Source: APXvYqztazK/xQKzvZjH67m157XVvrLPuUSe39hdz1bzjgRY06ZpdyvXZn13dt99dLDQvA9pCyj3tw==
X-Received: by 2002:adf:f382:: with SMTP id m2mr4668894wro.163.1581696412999;
        Fri, 14 Feb 2020 08:06:52 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s139sm8133213wme.35.2020.02.14.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 08:06:51 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com
Subject: [PATCH 0/3] virtio-iommu on non-devicetree platforms
Date:   Fri, 14 Feb 2020 17:04:10 +0100
Message-Id: <20200214160413.1475396-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add topology description to the virtio-iommu driver and enable x86
platforms. Since the RFC [1] I've mostly given up on ACPI tables, since
the internal discussions seem to have reached a dead end. The built-in
topology description presented here isn't ideal, but it is simple to
implement and doesn't impose a dependency on ACPI or device-tree, which
can be beneficial to lightweight hypervisors.

The built-in description is an array in the virtio config space. The
driver parses the config space early and postpones endpoint probe until
the virtio-iommu device is ready. Each element in the array describes
either a PCI range or a single MMIO endpoint, and their associated
endpoint IDs:

struct virtio_iommu_topo_pci_range {
	__le16 type;			/* 1: PCI range */
	__le16 hierarchy;		/* PCI domain number */
	__le16 requester_start;		/* First BDF */
	__le16 requester_end;		/* Last BDF */
	__le32 endpoint_start;		/* First endpoint ID */
};

struct virtio_iommu_topo_endpoint {
	__le16 type;			/* 2: Endpoint */
	__le16 reserved;		/* 0 */
	__le32 endpoint;		/* Endpoint ID */
	__le64 address;			/* First MMIO address */
};

You can find the QEMU patches based on Eric's latest device on my
virtio-iommu/devel branch [2]. I test on both x86 q35, and aarch64 virt
machine with edk2.

[1] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
[2] https://jpbrucker.net/git/qemu virtio-iommu/devel

Jean-Philippe Brucker (3):
  iommu/virtio: Add topology description to virtio-iommu config space
  PCI: Add DMA configuration for virtual platforms
  iommu/virtio: Enable x86 support

 MAINTAINERS                           |   2 +
 drivers/iommu/Kconfig                 |  13 +-
 drivers/iommu/Makefile                |   1 +
 drivers/iommu/virtio-iommu-topology.c | 343 ++++++++++++++++++++++++++
 drivers/iommu/virtio-iommu.c          |   3 +
 drivers/pci/pci-driver.c              |   5 +
 include/linux/virt_iommu.h            |  19 ++
 include/uapi/linux/virtio_iommu.h     |  26 ++
 8 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/virtio-iommu-topology.c
 create mode 100644 include/linux/virt_iommu.h

-- 
2.25.0

