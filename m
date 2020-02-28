Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4BA173E7D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 18:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1R26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 12:28:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33652 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1R26 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 12:28:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id x7so3911240wrr.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2020 09:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EDWWoTJbUPJSVCIJnNm6Wi0YGdvuuWr/P/xyLJLCk5U=;
        b=H4pQ634+yQ7qGjgO8zR+xD8XcI9Di0PGvk0yGoDGT/LnLSteh5D+LF/aOTxvzyQKqL
         wszmDWK64moeyGZUDZGlntRAS/3Y5WyC9fSUFaK6YwNKzO0aHVq3gFzj6Tp4s4eQBwDV
         PcjhDt7clUVl21EiBFvydMX2zCpceyfoCxUSJHV0EpihzC1vEMdlCG27jIe5Rd/YLkof
         s9OvcH+UyBHP7odt6xKjYB1uMyZOvdSuwM6V1GHHOxb7sydbeai6HuPgxYNgKZ77SeQk
         MRoh/GxNqF47ccfCarTJ4OXZYk3y1qywuHrCBI9DRP9uo3IQxW3c9m1ycnZWqQ6MXxbw
         3LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EDWWoTJbUPJSVCIJnNm6Wi0YGdvuuWr/P/xyLJLCk5U=;
        b=iOfpS7lwdwBL7kJdF3VEWKQQPbv+Ps8dC6GiucuVuMOoZdTGCDmdxyromBii/1kBIr
         yTlEwwHFeZ+YEpxF64KmbWaDbk6zkxdfbFsR8w122c9ZPJoMjOwhEBJZSGyehuY3okcD
         BB7xawCQIqcjji/OLKr7JkJReoyxJdhxXAqwo+h+WCqXMDjtsIbS81hS1aeeaGVkMAUv
         sdmqIXYJFzfG3oj/FNcHQjRqZhL6Yde3UmJtolWZifY6C/ci46B+BAqMo0+Q9l+9oY9x
         XetvEMuTq2Q6uaNzRR+ouWXXCwMVC+wZWJDJHC+oE3RSa7TFnhbrQjaNna0x38pidHcI
         RYyQ==
X-Gm-Message-State: APjAAAVuzFkc9z7h5gQixsnFCK/XttO7Tu2IJhyG3mdCMy3LF00qKyY+
        uT9PjJ97W6fPWUai/dExOiPMDw==
X-Google-Smtp-Source: APXvYqydXuly5JQHJ1HEed03Ol9Dp7NV7BSYwLykhnt9GR9cgCgCDHMep13CruAx/WMAigTJ+22vnQ==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr5682702wrj.196.1582910935615;
        Fri, 28 Feb 2020 09:28:55 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m125sm3004795wmf.8.2020.02.28.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 09:28:55 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, robin.murphy@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 0/3] virtio-iommu on x86 and non-devicetree platforms
Date:   Fri, 28 Feb 2020 18:25:35 +0100
Message-Id: <20200228172537.377327-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a topology description to the virtio-iommu driver and enable x86
platforms.

Two minor changes since v1 [1]:
* Don't setup DMA twice in patch 1
* Clarify the CONFIG_IOMMU_DMA selection in patch 3

And rebased on top of "iommu/virtio: Build virtio-iommu as a module"
which Joerg picked up for v5.7.

--- Copy-paste from v1:
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
---

[1] https://lore.kernel.org/linux-iommu/20200214160413.1475396-1-jean-philippe@linaro.org/
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

