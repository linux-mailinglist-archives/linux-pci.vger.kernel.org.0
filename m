Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD87878C0
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243299AbjHXTiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbjHXThy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E191BE9;
        Thu, 24 Aug 2023 12:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB6562F30;
        Thu, 24 Aug 2023 19:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E599EC433C7;
        Thu, 24 Aug 2023 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905867;
        bh=J/aTIjNQeuZtCn8nhUdmbHU05pDV7p5wWpmFOvs9Vzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6CULp0fjNqgXRHE5AGDF6k9TujyZGgM96bWPy9fq0Qg26ONJtyhTeBOklwMduj/M
         JyxBIoixB2rLMIlJ8GEgGVqXcusBFuFase3lxw4mvwNuhMptH3ZtvbaOy0eVkBjjLK
         up3t33waUVqeXKFEAp8r7QdjUEiN9bN2rqgjPV8nhgGXAwq1gBBAiRfz6+KSjYv91M
         OU9O3C4Me9jvhhY3frRyPSUlMzjJBo/XW/pEdpOAmY1lovaBx6OfzZY6+MEIaeRxCh
         W0FWsocijnNv/7BIm/xERpKcOcyDls/mbMpUb8hoqp/X9Ay9jorttdS4bL4UzVS9v7
         Yb4ZyQkjGiwWg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 11/12] PCI: Fix code formatting inconsistencies
Date:   Thu, 24 Aug 2023 14:37:11 -0500
Message-Id: <20230824193712.542167-12-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824193712.542167-1-helgaas@kernel.org>
References: <20230824193712.542167-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove unnecessary "return;" in void functions and format consistently.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c397434057..096fa6834f3b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -147,8 +147,8 @@ int pci_hp_add_bridge(struct pci_dev *dev);
 void pci_create_legacy_files(struct pci_bus *bus);
 void pci_remove_legacy_files(struct pci_bus *bus);
 #else
-static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
-static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
+static inline void pci_create_legacy_files(struct pci_bus *bus) { }
+static inline void pci_remove_legacy_files(struct pci_bus *bus) { }
 #endif
 
 /* Lock for read/write access to pci device and bus lists */
@@ -422,9 +422,9 @@ void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 #else
-static inline void pci_save_dpc_state(struct pci_dev *dev) {}
-static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
-static inline void pci_dpc_init(struct pci_dev *pdev) {}
+static inline void pci_save_dpc_state(struct pci_dev *dev) { }
+static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
+static inline void pci_dpc_init(struct pci_dev *pdev) { }
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 #endif
 
@@ -436,12 +436,12 @@ void pcie_walk_rcec(struct pci_dev *rcec,
 		    int (*cb)(struct pci_dev *, void *),
 		    void *userdata);
 #else
-static inline void pci_rcec_init(struct pci_dev *dev) {}
-static inline void pci_rcec_exit(struct pci_dev *dev) {}
-static inline void pcie_link_rcec(struct pci_dev *rcec) {}
+static inline void pci_rcec_init(struct pci_dev *dev) { }
+static inline void pci_rcec_exit(struct pci_dev *dev) { }
+static inline void pcie_link_rcec(struct pci_dev *rcec) { }
 static inline void pcie_walk_rcec(struct pci_dev *rcec,
 				  int (*cb)(struct pci_dev *, void *),
-				  void *userdata) {}
+				  void *userdata) { }
 #endif
 
 #ifdef CONFIG_PCI_ATS
@@ -484,16 +484,9 @@ static inline int pci_iov_init(struct pci_dev *dev)
 {
 	return -ENODEV;
 }
-static inline void pci_iov_release(struct pci_dev *dev)
-
-{
-}
-static inline void pci_iov_remove(struct pci_dev *dev)
-{
-}
-static inline void pci_restore_iov_state(struct pci_dev *dev)
-{
-}
+static inline void pci_iov_release(struct pci_dev *dev) { }
+static inline void pci_iov_remove(struct pci_dev *dev) { }
+static inline void pci_restore_iov_state(struct pci_dev *dev) { }
 static inline int pci_iov_bus_range(struct pci_bus *bus)
 {
 	return 0;
@@ -718,7 +711,7 @@ static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	return -ENOTTY;
 }
-static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
+static inline void pci_set_acpi_fwnode(struct pci_dev *dev) { }
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
@@ -739,7 +732,7 @@ static inline pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
 {
 	return PCI_UNKNOWN;
 }
-static inline void acpi_pci_refresh_power_state(struct pci_dev *dev) {}
+static inline void acpi_pci_refresh_power_state(struct pci_dev *dev) { }
 static inline int acpi_pci_wakeup(struct pci_dev *dev, bool enable)
 {
 	return -ENODEV;
-- 
2.34.1

