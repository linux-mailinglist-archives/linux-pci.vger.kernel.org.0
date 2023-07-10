Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602E274E22B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGJXVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGJXVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 19:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A589E;
        Mon, 10 Jul 2023 16:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BD936120F;
        Mon, 10 Jul 2023 23:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC17DC433C7;
        Mon, 10 Jul 2023 23:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689031305;
        bh=Y2j5rRb6xpdmsTT+BzTtvIQsL3CFQd80YIp40kH6XWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbFXuy5Vv0hBg5idN4znCuGKIsX8jEd36bONo9ZEG5NX3lRVvAmZRJcvEJX7yzj2m
         fFysozuWhwBfcgcnVAgdxH+w7zAJmB89l2samqZD85Ulc65L5S3EYNRdBiub1jSBw1
         a/Q5ixAAlOG7wRgt9sldqkfPeDfrL3TDKPr4atKjXZmlydnZtyK0FV+HIZss+qddoN
         PbUlsV22ayeXv7cg3P9vFUr7j6c7lFrlT1RidI64R0VACca3dIrvYbnGVKPN33vXY4
         c2pyJvns5KNNZWvDvQKfuxU+HwzFMIDwW8Lx0NOBLMW4x+N58p7/iWwFJu8gaUyqFl
         UfI6ldbMzv/xA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI/AER: Drop unused pci_disable_pcie_error_reporting()
Date:   Mon, 10 Jul 2023 18:21:35 -0500
Message-Id: <20230710232136.233034-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710232136.233034-1-helgaas@kernel.org>
References: <20230710232136.233034-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_disable_pcie_error_reporting() has no callers.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 12 ------------
 include/linux/aer.h    |  5 -----
 2 files changed, 17 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..d4c948b7c449 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -242,18 +242,6 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
-int pci_disable_pcie_error_reporting(struct pci_dev *dev)
-{
-	int rc;
-
-	if (!pcie_aer_is_native(dev))
-		return -EIO;
-
-	rc = pcie_capability_clear_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
-	return pcibios_err_to_errno(rc);
-}
-EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
-
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 3a3ab05e13fd..aadc9242cb20 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -43,17 +43,12 @@ struct aer_capability_regs {
 #if defined(CONFIG_PCIEAER)
 /* PCIe port driver needs this function to enable AER */
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
-int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 #else
 static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
-static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
-{
-	return -EINVAL;
-}
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
-- 
2.34.1

