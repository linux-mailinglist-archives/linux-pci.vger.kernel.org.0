Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76D74E22D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjGJXVv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGJXVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 19:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2497C1B2;
        Mon, 10 Jul 2023 16:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD74861261;
        Mon, 10 Jul 2023 23:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E15C433C8;
        Mon, 10 Jul 2023 23:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689031307;
        bh=2JtYW2FAXLQ8IiaHZeQqlEM207zTV5RiNltF8zVSvU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O03pMjvFDkEjJ3HPx3J+xO4wSgoopx28xH9hy2035xQf5My4oVQDFXaYb2xclrUPz
         v/+ZifdXxQwENMyRcnRqXpV1IlgXe0cumqQkJowQs1dM0kuymbNurQ7pPHAKtCxDIK
         W8WZuurCq482vy7OehgQki2u7+HybImsKEds+PV1D0oBF5LHZWsnr0Nz4XkLyHPL3Q
         V9BtS6YhfFpbrVgZPoCKdvsjHkqR7e7AO+cVW2B0AB3/5ulC3dlhCkR06RhRnk3tyg
         fhK/ln78tFhL4mp7ecpVedBD5U7r4XoQNuM4wRZyLHy399MLBN3I+BzRIgRTShMSRb
         xwnYPJyNh7ObQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI/AER: Unexport pci_enable_pcie_error_reporting()
Date:   Mon, 10 Jul 2023 18:21:36 -0500
Message-Id: <20230710232136.233034-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710232136.233034-1-helgaas@kernel.org>
References: <20230710232136.233034-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_enable_pcie_error_reporting() is used only inside aer.c.  Stop exposing
it outside the file.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 3 +--
 include/linux/aer.h    | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d4c948b7c449..645149608054 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -230,7 +230,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
 	return pcie_ports_native || host->native_aer;
 }
 
-int pci_enable_pcie_error_reporting(struct pci_dev *dev)
+static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
 	int rc;
 
@@ -240,7 +240,6 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 	return pcibios_err_to_errno(rc);
 }
-EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index aadc9242cb20..2dd175f5debd 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -41,14 +41,8 @@ struct aer_capability_regs {
 };
 
 #if defined(CONFIG_PCIEAER)
-/* PCIe port driver needs this function to enable AER */
-int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 #else
-static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
-{
-	return -EINVAL;
-}
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
-- 
2.34.1

