Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32328605174
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 22:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiJSUlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 16:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiJSUln (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 16:41:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17B169CED;
        Wed, 19 Oct 2022 13:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FC5DB825E4;
        Wed, 19 Oct 2022 20:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F592C433D7;
        Wed, 19 Oct 2022 20:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666212098;
        bh=PJnRqTU+uLahKAeRgjkoETGDStPF8ENfLDUsX7IDEoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBRWCM1h8BdKM5rnViHBCrVACCi2t58X7AekhrKjfzfKd1hGX1Pla7vrUHTgZc6Vd
         wtGKZk79eBV+qBsOCp5YzvQjyONj/uR56oKoFru4QkhetRU1TwGFWK/+nYEFjhpMBe
         Gg8RKUFIrRV/gY/9krRw3DN88nj9WpjTVsvYMZy4cWB/rbXczD3H74Ya7Cb/Klvfri
         F8d4ml6S839SWM8GD/EdFzVf7ZR6sAqHrLz626+aKuvHE0xM7UKC51wOadkUI/5h3S
         O61RqmP3UrNcnsfb0w0M9LJ/CuZ9AWd97WS7nm+qGtnMLJb5xAg0DTmau11PcwWIba
         xnVeP34Hr6ikQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Stefan Roese <sr@denx.de>, Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] PCI/portdrv: Move private things to portdrv.c
Date:   Wed, 19 Oct 2022 15:41:26 -0500
Message-Id: <20221019204127.44463-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019204127.44463-1-helgaas@kernel.org>
References: <20221019204127.44463-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously several things used by portdrv_core.c and portdrv_pci.c were
shared by defining them in portdrv.h.  Now that portdrv_core.c and
portdrv_pci.c have been squashed, move things that can be private into
portdrv.c.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.c | 9 +++++++++
 drivers/pci/pcie/portdrv.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 0b4a1f9c2a6b..ae8da5b2e922 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -21,6 +21,15 @@
 #include "../pci.h"
 #include "portdrv.h"
 
+/*
+ * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
+ * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
+ * supports a maximum of 32 vectors per function.
+ */
+#define PCIE_PORT_MAX_MSI_ENTRIES	32
+
+#define get_descriptor_id(type, service) (((type - 4) << 8) | service)
+
 struct portdrv_service_data {
 	struct pcie_port_service_driver *drv;
 	struct device *dev;
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index bf380bcea6a5..58a2b1a1cae4 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -98,15 +98,6 @@ struct pcie_port_service_driver {
 int pcie_port_service_register(struct pcie_port_service_driver *new);
 void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 
-/*
- * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
- * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
- * supports a maximum of 32 vectors per function.
- */
-#define PCIE_PORT_MAX_MSI_ENTRIES	32
-
-#define get_descriptor_id(type, service) (((type - 4) << 8) | service)
-
 extern struct bus_type pcie_port_bus_type;
 
 struct pci_dev;
-- 
2.25.1

