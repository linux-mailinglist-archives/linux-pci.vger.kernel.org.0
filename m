Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EAA20C8EC
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jun 2020 18:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgF1QMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jun 2020 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgF1QMn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jun 2020 12:12:43 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9622C03E979;
        Sun, 28 Jun 2020 09:12:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e15so10873998edr.2;
        Sun, 28 Jun 2020 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1F7JWHNRjXcZRtV7z9OVYJGj2urAfZ5UH6WmF8uZBM=;
        b=c6tg0D5MkO+mxhv368yTn7ZJ5RBnpp0ufgUHTnMidNgyuVHrHs1eov39Nx/ENFnGR4
         x9oKb7nwvxV3BS9+yerknZdAxAmNXAg0Lkg6JJUhmQhOq1SBBWv/bNja0V/aL0NHVq3T
         xif8e0rM1NT2C+tWbL1b11cMwfKNoRKdaF/Zbcwlq4y3TH/gIH3a1oHUEYFcnnBvHwBV
         iBSNkB2U6FJZmyNWEf+x8B8DGq4q4+nxFSPCF4Sjd4jDBG6LvLClUJkRg5mxE//56sQ0
         NBs9u0cuDTxw40p+DDGZMTosiCmcjpYm0lil1geT618I555eey+lNZwhe4cFfEDxFclE
         3asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1F7JWHNRjXcZRtV7z9OVYJGj2urAfZ5UH6WmF8uZBM=;
        b=L+VN6RxddyX+L9L7bYPI8cpMz7HurtgQvv2JNmWQAUY7eYQyt74BaBfig/pqez5yCd
         AYSsI+CcnJfX48YUtQn2AhqxFTFCP+MkVLOTWGoGhNerj6ETILxw5vW2MBWXSyMnPDox
         IFcXhwZEU+EpzDyNMrtFVXVm+Jh0b6FsIo4PuJV+AI1C+eU+2r2BF+np27/stOPOGvvT
         edSHmP//ihd7q5pinWKEzg4LswNXS3MW86wDKmzpCcWL3BKIF1SmcqvT+Zgyca25FZoR
         Zkyjf/cz/a0nSz+3x6fxXY4QPuVjSbINxJ+vPMIlSiiLSUlzX4l4UX3LWSVMw+k2l+yq
         ws3A==
X-Gm-Message-State: AOAM533AzOiXkbuNWKIeFV9k1K3tcFzZ+iVJnBK9YLqinb9VMRLaXwVw
        4Lpqn9e64701WbxUTdlVLj8=
X-Google-Smtp-Source: ABdhPJxG2xEX+k708eu6BvTB2oL2bl4Fk6JNvGfu7a/J9ib9OFLXmxpoin7lsp56IvSl+RoasQNB1w==
X-Received: by 2002:a05:6402:203a:: with SMTP id ay26mr2858964edb.276.1593360761256;
        Sun, 28 Jun 2020 09:12:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:d97d:e095:b4fd:d5ca])
        by smtp.gmail.com with ESMTPSA id c9sm19104336edv.8.2020.06.28.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 09:12:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] pci: consolidate typing of pci_error_handlers::error_detected()
Date:   Sun, 28 Jun 2020 18:12:33 +0200
Message-Id: <20200628161233.73079-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The method struct pci_error_handlers::error_detected() is defined and
documented as taking an 'enum pci_channel_state' for the second
argument but most drivers use 'pci_channel_state_t' instead.
This 'pci_channel_state_t' is not a typedef for the enum but a typedef
for a bitwise type in order to have better/stricter typechecking.

So, consolidate everything by using the restricted type in the
method's definition, in the documentation and in the drivers not
using 'pci_channel_state_t'.

Note: Currently, from a typechecking point of view this patch change
      nothing because only the constants defined by the enum
      are bitwise, not the enum itself (sparse doesn't have
      the notion of 'bitwise enum'). This may change in some
      not too far future, hence the patch.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/PCI/pci-error-recovery.rst    | 2 +-
 drivers/block/rsxx/core.c                   | 2 +-
 drivers/dma/ioat/init.c                     | 2 +-
 drivers/media/pci/ngene/ngene-cards.c       | 2 +-
 drivers/misc/genwqe/card_base.c             | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 4 ++--
 drivers/net/ethernet/sfc/efx.c              | 2 +-
 drivers/net/ethernet/sfc/falcon/efx.c       | 2 +-
 drivers/pci/pcie/portdrv_pci.c              | 2 +-
 drivers/scsi/aacraid/linit.c                | 2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c         | 2 +-
 drivers/staging/qlge/qlge_main.c            | 2 +-
 include/linux/pci.h                         | 2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 13beee23cb04..23d7f571cee9 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -79,7 +79,7 @@ This structure has the form::
 
 	struct pci_error_handlers
 	{
-		int (*error_detected)(struct pci_dev *dev, enum pci_channel_state);
+		int (*error_detected)(struct pci_dev *dev, pci_channel_state_t);
 		int (*mmio_enabled)(struct pci_dev *dev);
 		int (*slot_reset)(struct pci_dev *dev);
 		void (*resume)(struct pci_dev *dev);
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 10f6368117d8..34e937dd6bca 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -625,7 +625,7 @@ static int rsxx_eeh_fifo_flush_poll(struct rsxx_cardinfo *card)
 }
 
 static pci_ers_result_t rsxx_error_detected(struct pci_dev *dev,
-					    enum pci_channel_state error)
+					    pci_channel_state_t error)
 {
 	int st;
 
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 58d13564f88b..089893f2bbb8 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1267,7 +1267,7 @@ static void ioat_resume(struct ioatdma_device *ioat_dma)
 #define DRV_NAME "ioatdma"
 
 static pci_ers_result_t ioat_pcie_error_detected(struct pci_dev *pdev,
-						 enum pci_channel_state error)
+						 pci_channel_state_t error)
 {
 	dev_dbg(&pdev->dev, "%s: PCIe AER error %d\n", DRV_NAME, error);
 
diff --git a/drivers/media/pci/ngene/ngene-cards.c b/drivers/media/pci/ngene/ngene-cards.c
index 6185806a00e0..8bfb3d8ea610 100644
--- a/drivers/media/pci/ngene/ngene-cards.c
+++ b/drivers/media/pci/ngene/ngene-cards.c
@@ -1186,7 +1186,7 @@ MODULE_DEVICE_TABLE(pci, ngene_id_tbl);
 /****************************************************************************/
 
 static pci_ers_result_t ngene_error_detected(struct pci_dev *dev,
-					     enum pci_channel_state state)
+					     pci_channel_state_t state)
 {
 	dev_err(&dev->dev, "PCI error\n");
 	if (state == pci_channel_io_perm_failure)
diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 1dc6c7c5cbce..97b8ecc42383 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1240,7 +1240,7 @@ static void genwqe_remove(struct pci_dev *pci_dev)
  * error is detected.
  */
 static pci_ers_result_t genwqe_err_error_detected(struct pci_dev *pci_dev,
-						 enum pci_channel_state state)
+						 pci_channel_state_t state)
 {
 	struct genwqe_dev *cd;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5d807c8004f8..f0de2d1842b4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15465,7 +15465,7 @@ static void i40e_remove(struct pci_dev *pdev)
  * remediation.
  **/
 static pci_ers_result_t i40e_pci_error_detected(struct pci_dev *pdev,
-						enum pci_channel_state error)
+						pci_channel_state_t error)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 
diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index b64e91ea3465..00db4b5863b1 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -82,7 +82,7 @@ static int ixgb_vlan_rx_kill_vid(struct net_device *netdev,
 static void ixgb_restore_vlan(struct ixgb_adapter *adapter);
 
 static pci_ers_result_t ixgb_io_error_detected (struct pci_dev *pdev,
-                             enum pci_channel_state state);
+                             pci_channel_state_t state);
 static pci_ers_result_t ixgb_io_slot_reset (struct pci_dev *pdev);
 static void ixgb_io_resume (struct pci_dev *pdev);
 
@@ -2194,7 +2194,7 @@ ixgb_restore_vlan(struct ixgb_adapter *adapter)
  * a PCI bus error is detected.
  */
 static pci_ers_result_t ixgb_io_error_detected(struct pci_dev *pdev,
-                                               enum pci_channel_state state)
+                                               pci_channel_state_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct ixgb_adapter *adapter = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 256807c28ff7..ed627aff7b36 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1519,7 +1519,7 @@ static const struct dev_pm_ops efx_pm_ops = {
  * Stop the software path and request a slot reset.
  */
 static pci_ers_result_t efx_io_error_detected(struct pci_dev *pdev,
-					      enum pci_channel_state state)
+					      pci_channel_state_t state)
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
 	struct efx_nic *efx = pci_get_drvdata(pdev);
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 42bcd34fc508..f8979991970e 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -3118,7 +3118,7 @@ static const struct dev_pm_ops ef4_pm_ops = {
  * Stop the software path and request a slot reset.
  */
 static pci_ers_result_t ef4_io_error_detected(struct pci_dev *pdev,
-					      enum pci_channel_state state)
+					      pci_channel_state_t state)
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
 	struct ef4_nic *efx = pci_get_drvdata(pdev);
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3acf151ae015..3a3ce40ae1ab 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -146,7 +146,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
-					enum pci_channel_state error)
+					pci_channel_state_t error)
 {
 	/* Root Port has no impact. Always recovers. */
 	return PCI_ERS_RESULT_CAN_RECOVER;
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index a308e86a97f1..37f65602b0ec 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -2002,7 +2002,7 @@ static void aac_remove_one(struct pci_dev *pdev)
 }
 
 static pci_ers_result_t aac_pci_error_detected(struct pci_dev *pdev,
-					enum pci_channel_state error)
+					pci_channel_state_t error)
 {
 	struct Scsi_Host *shost = pci_get_drvdata(pdev);
 	struct aac_dev *aac = shost_priv(shost);
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index 2ca018ce796f..f455243bdb9b 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -1743,7 +1743,7 @@ static void sym2_remove(struct pci_dev *pdev)
  * @state: current state of the PCI slot
  */
 static pci_ers_result_t sym2_io_error_detected(struct pci_dev *pdev,
-                                         enum pci_channel_state state)
+                                         pci_channel_state_t state)
 {
 	/* If slot is permanently frozen, turn everything off */
 	if (state == pci_channel_io_perm_failure) {
diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 402edaeffe12..ac30aefe49a1 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -4678,7 +4678,7 @@ static void ql_eeh_close(struct net_device *ndev)
  * a PCI bus error is detected.
  */
 static pci_ers_result_t qlge_io_error_detected(struct pci_dev *pdev,
-					       enum pci_channel_state state)
+					       pci_channel_state_t state)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
 	struct ql_adapter *qdev = netdev_priv(ndev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c79d83304e52..7ee85e89e8ed 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -785,7 +785,7 @@ enum pci_ers_result {
 struct pci_error_handlers {
 	/* PCI bus error detected on this device */
 	pci_ers_result_t (*error_detected)(struct pci_dev *dev,
-					   enum pci_channel_state error);
+					   pci_channel_state_t error);
 
 	/* MMIO has been re-enabled, but not DMA */
 	pci_ers_result_t (*mmio_enabled)(struct pci_dev *dev);

base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
-- 
2.27.0

