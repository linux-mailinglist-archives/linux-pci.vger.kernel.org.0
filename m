Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666D96D1917
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCaHzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCaHzi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 03:55:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E0F210D;
        Fri, 31 Mar 2023 00:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F347B82C86;
        Fri, 31 Mar 2023 07:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48275C433EF;
        Fri, 31 Mar 2023 07:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680249335;
        bh=56tCHTmfZ4Dl+rN8BVNsQISShX6kyMqKc5AH+7Uj+7g=;
        h=From:To:Cc:Subject:Date:From;
        b=d8pzU7fa4a0MPZNqdYvhn1SagoTH0CwCH7N8LJtri3bFQikdL7Vvu9xx2rrXkUE8K
         vU0x4c3bYnhwVYAYv83Mof1cNZnA06zAQDz5Em2fw6YWEX/nrWWIDgdRNUNEsWoLsV
         9vZWuM0OQf8J7YOEk76ygBfPhdg28jf1uIVMWKrWqLDGLw6dGf8e/dQfU1g4MxVoyI
         3vqWXTp9oOXcCnf36dprPxkCSO/EnKpfgxqdbns6EDqx1ix2qubNpUI/IxnDmhh2S9
         NejpCa24KedXER0ZZ8uKhdwK7kV00+Tqa3MKAUzhdxqs4jri4QTBBNG2bqMJPHRBQq
         PPDj4R1NemEDg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Shay Drory <shayd@nvidia.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Eli Cohen <elic@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/MSI: provide dummy pci_msix_can_alloc_dyn() helper
Date:   Fri, 31 Mar 2023 09:55:04 +0200
Message-Id: <20230331075528.1300270-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A change in mlx5 caused a build failure when PCI_MSI is disabled:

drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function 'irq_release':
drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:148:31: error: implicit declaration of function 'pci_msix_can_alloc_dyn' [-Werror=implicit-function-declaration]
  148 |         if (irq->map.index && pci_msix_can_alloc_dyn(pool->dev->pdev))
      |                               ^~~~~~~~~~~~~~~~~~~~~~

All the related functions already have a dummy version that does nothing
in this configuration, but pci_msix_can_alloc_dyn() does not, so add one.

Fixes: fb0a6a268dcd ("net/mlx5: Provide external API for allocating vectors")
Fixes: 34026364df8e ("PCI/MSI: Provide post-enable dynamic allocation interfaces for MSI-X")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/pci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index b50e5c79f7e3..f69f7939331e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1624,6 +1624,11 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      flags, NULL);
 }
 
+static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
+{
+	return false;
+}
+
 static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
 						   const struct irq_affinity_desc *affdesc)
 {
-- 
2.39.2

