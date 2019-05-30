Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347AB30099
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 19:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfE3RMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 13:12:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfE3RMg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 13:12:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F071341;
        Thu, 30 May 2019 10:12:35 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 365663F5AF;
        Thu, 30 May 2019 10:12:32 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org, mst@redhat.com
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        bauerman@linux.ibm.com
Subject: [PATCH v8 0/7] Add virtio-iommu driver
Date:   Thu, 30 May 2019 18:09:22 +0100
Message-Id: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the virtio-iommu driver, following specification v0.12 [1].
Since last version [2] we've worked on improving the specification,
which resulted in the following changes to the interface:
* Remove the EXEC flag.
* Add feature bit for the MMIO flag.
* Change domain_bits to domain_range.

Given that there were small changes to patch 5/7, I removed the review
and test tags. Please find the code at [3].

[1] Virtio-iommu specification v0.12, sources and pdf
    git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.12
    http://jpbrucker.net/virtio-iommu/spec/v0.12/virtio-iommu-v0.12.pdf
    http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-dev-diff-v0.11-v0.12.pdf

[2] [PATCH v7 0/7] Add virtio-iommu driver
    https://lore.kernel.org/linux-pci/0ba215f5-e856-bf31-8dd9-a85710714a7a@arm.com/T/

[3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.12
    git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.12

Jean-Philippe Brucker (7):
  dt-bindings: virtio-mmio: Add IOMMU description
  dt-bindings: virtio: Add virtio-pci-iommu node
  of: Allow the iommu-map property to omit untranslated devices
  PCI: OF: Initialize dev->fwnode appropriately
  iommu: Add virtio-iommu driver
  iommu/virtio: Add probe request
  iommu/virtio: Add event queue

 .../devicetree/bindings/virtio/iommu.txt      |   66 +
 .../devicetree/bindings/virtio/mmio.txt       |   30 +
 MAINTAINERS                                   |    7 +
 drivers/iommu/Kconfig                         |   11 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/virtio-iommu.c                  | 1176 +++++++++++++++++
 drivers/of/base.c                             |   10 +-
 drivers/pci/of.c                              |    6 +
 include/uapi/linux/virtio_ids.h               |    1 +
 include/uapi/linux/virtio_iommu.h             |  165 +++
 10 files changed, 1470 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 drivers/iommu/virtio-iommu.c
 create mode 100644 include/uapi/linux/virtio_iommu.h

-- 
2.21.0

