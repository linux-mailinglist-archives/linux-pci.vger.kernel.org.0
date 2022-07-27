Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2C9582531
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiG0LMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG0LMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 07:12:52 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74D801029;
        Wed, 27 Jul 2022 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=5Tvabu9CtsXjB9pzwn
        0XkLYAULeXtsC4hzOO0MxSFQ4=; b=JTFTnhvvjEKojMqLcWl8oyCZpzrLToPGbF
        KN06QpT2TeVQ8vWvs0WSg5LLQ0OiSgjU35jlYpBMM1lWPNBLsDX54mvDypTOc8rj
        o91vJYtrqzsiJksQ1/yqsthl/gD/Q+PDutD3DL6c7dY/c09NtKddjKy78Tqk1IMf
        eYUsiLcHc=
Received: from os-l3a203-yehs1-dev01.localdomain (unknown [103.244.59.5])
        by smtp4 (Coremail) with SMTP id HNxpCgD3+dmmHeFil8G0RA--.1842S2;
        Wed, 27 Jul 2022 19:12:39 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH v1] PCI/DPC: Skip EDR init when BIOS disable OS native DPC
Date:   Wed, 27 Jul 2022 19:05:57 +0800
Message-Id: <1658919957-53006-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: HNxpCgD3+dmmHeFil8G0RA--.1842S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1kZr1rGr1Uur48Wr43Awb_yoW8GFykpa
        y5ZrWFkF48GFnrZa1avF4FvF15GFZ7ZrZ7Ga97u3srZa1fA3W8Was7Ka4FyF1rJrZ7X343
        JF45tr1UWF4UJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyUDAUUUUU=
X-Originating-IP: [103.244.59.5]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/xtbBZwhLQFet8PYEeAABsl
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

ACPI BIOS may disable OS native AER and DPC support to notify OS
that our platform doesn't support AER and DPC via the _OSC method.
BIOS also might leave the containment be accomplished purely in HW.
When firmware is set to non-aware OS DPC, we skip to install
EDR handler to an ACPI device.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 drivers/pci/pcie/edr.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index a6b9b47..97a680b 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -19,6 +19,17 @@
 #define EDR_OST_SUCCESS			0x80
 #define EDR_OST_FAILED			0x81
 
+static int pcie_dpc_is_native(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+
+	if (!dev->dpc_cap)
+		return 0;
+
+	return pcie_ports_dpc_native || host->native_dpc;
+}
+
+
 /*
  * _DSM wrapper function to enable/disable DPC
  * @pdev   : PCI device structure
@@ -212,6 +223,11 @@ void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
 		return;
 	}
 
+	if (!pcie_dpc_is_native(pdev) && !pcie_aer_is_native(pdev)) {
+		pci_dbg(pdev, "OS doesn't control DPC, skipping EDR init\n");
+		return;
+	}
+
 	status = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
 					     edr_handle_event, pdev);
 	if (ACPI_FAILURE(status)) {
-- 
1.8.3.1

