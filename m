Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E65FE59B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 00:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJMWyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 18:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJMWyw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 18:54:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5356321E0F;
        Thu, 13 Oct 2022 15:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FAB1B820BB;
        Thu, 13 Oct 2022 22:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B3DC433D6;
        Thu, 13 Oct 2022 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665701687;
        bh=wY5aP2fq2o1Ri1eqe3JUjMm0lwpYU44WlaPlKlU03BM=;
        h=From:To:Cc:Subject:Date:From;
        b=aLOPDkrIBZygrHleN4/P+l/SirzmF+Vu7b7D+uGGVT0rc6M9o38pUOl0goEX871FM
         byrxvc8Is0qWR6yQpd7sgzOe740c3PvzlpUhwJeErE9r1BpH1G+2nRQSFw+9nduiBX
         kKB7k2GQMlT5EuGi4RrxGApu4gbXZiiDV6KnKAy+btBgO6hFysPYCXLeSklKQo4hgb
         aPkyDY/HKrYmN2+S5yp8nnpTjPXHpuQP45dt1oHn5ScIprJbtSLw/N8LKWQNxj3zTq
         gXbcUL54ybkRjQRVO0U1DUILqPlofbohnc4XD5PDotalYAX3U9qukOU1yg0QOyppmG
         Eo1xieoxRARuA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Rename PCI_DEVICE_ID_RD890_IOMMU to PCI_DEVICE_ID_ATI_RD890_IOMMU
Date:   Thu, 13 Oct 2022 17:54:40 -0500
Message-Id: <20221013225440.3336168-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCI_DEVICE_ID_RD890_IOMMU is a device ID in the ATI vendor ID namespace.
Rename it accordingly and move it to the list of ATI device IDs.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 include/linux/pci_ids.h       | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c160a332ce33..61749d52ba05 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -82,7 +82,7 @@ extern int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 static inline bool is_rd890_iommu(struct pci_dev *pdev)
 {
 	return (pdev->vendor == PCI_VENDOR_ID_ATI) &&
-	       (pdev->device == PCI_DEVICE_ID_RD890_IOMMU);
+	       (pdev->device == PCI_DEVICE_ID_ATI_RD890_IOMMU);
 }
 
 static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..be2910028e27 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -382,6 +382,8 @@
 #define PCI_DEVICE_ID_ATI_RS350_133     0x7831
 #define PCI_DEVICE_ID_ATI_RS350_166     0x7832
 #define PCI_DEVICE_ID_ATI_RS350_200     0x7833
+/* AMD RD890 Chipset */
+#define PCI_DEVICE_ID_ATI_RD890_IOMMU	0x5a23
 #define PCI_DEVICE_ID_ATI_RS400_100     0x5a30
 #define PCI_DEVICE_ID_ATI_RS400_133     0x5a31
 #define PCI_DEVICE_ID_ATI_RS400_166     0x5a32
@@ -416,9 +418,6 @@
 #define PCI_DEVICE_ID_VLSI_82C147	0x0105
 #define PCI_DEVICE_ID_VLSI_VAS96011	0x0702
 
-/* AMD RD890 Chipset */
-#define PCI_DEVICE_ID_RD890_IOMMU	0x5a23
-
 #define PCI_VENDOR_ID_ADL		0x1005
 #define PCI_DEVICE_ID_ADL_2301		0x2301
 
-- 
2.25.1

