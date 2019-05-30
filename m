Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C2300A5
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfE3RMp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 13:12:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40176 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfE3RMp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 13:12:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D1B11684;
        Thu, 30 May 2019 10:12:45 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 454813F5AF;
        Thu, 30 May 2019 10:12:42 -0700 (PDT)
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
Subject: [PATCH v8 3/7] of: Allow the iommu-map property to omit untranslated devices
Date:   Thu, 30 May 2019 18:09:25 +0100
Message-Id: <20190530170929.19366-4-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In PCI root complex nodes, the iommu-map property describes the IOMMU that
translates each endpoint. On some platforms, the IOMMU itself is presented
as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). This isn't supported
by the current OF driver, which expects all endpoints to have an IOMMU.
Allow the iommu-map property to have gaps.

Relaxing of_map_rid() also allows the msi-map property to have gaps, which
is invalid since MSIs always reach an MSI controller. In that case
pci_msi_setup_msi_irqs() will return an error when attempting to find the
device's MSI domain.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/of/base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20e0e7ee4edf..55e7f5bb0549 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2294,8 +2294,12 @@ int of_map_rid(struct device_node *np, u32 rid,
 		return 0;
 	}
 
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
+	pr_info("%pOF: no %s translation for rid 0x%x on %pOF\n", np, map_name,
+		rid, target && *target ? *target : NULL);
+
+	/* Bypasses translation */
+	if (id_out)
+		*id_out = rid;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_rid);
-- 
2.21.0

