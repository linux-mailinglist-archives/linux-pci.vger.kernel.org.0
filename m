Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0506721295B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGBQ16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgGBQ15 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 12:27:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72219C08C5DD;
        Thu,  2 Jul 2020 09:27:57 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a1so30464639ejg.12;
        Thu, 02 Jul 2020 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8zRxsZ03W4MZ/W4O2Fq3y+CKd8g6LKB6bomOI5V1KI=;
        b=Rg0c5QkyFVVC3hpcP6JfDUACrpZLiFiQFYV/Inkf5rRWpxMXI4CzrO58NXYwFOkb3Q
         9B8IUSvsCNoNhi6NcnM3wGIIRZ7OYJ4KmU5d8nDjZIZr50G4L37oYf/7lRv4OknQFawf
         t9+Fe/Ysnenkv1RcH1bMN19b7MpgWUsH33jXSLk2ictGENmr1sBCkUtuJKvcCuXV3ADg
         VaLEKPG0bTGBR7TFyyQX3vTqTKVMorYDGnqfgHCinudGlgDnp4ycL2bDPObmP0BSfeSY
         +LOno+NzlzkH/YFrsoBMn6B3069mTIibJXL1XElJsl236HWks4VxXFa4gHATDIT3+kRi
         09Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8zRxsZ03W4MZ/W4O2Fq3y+CKd8g6LKB6bomOI5V1KI=;
        b=kQAbFoES7bmwdF9C/dGYFVcDo2SqCx+nnZNJMQIsGwWqWD4Cs07IM0MV6IYLS+n4Qz
         NqOup20pbgLLTkJhqbgl4NpkGk/g2fTKx3wrg1z9N7oMaWbNX1VV/MnvX8r8MLZVxPT2
         kWkSsdOUM+ueB7OGfsHYozTTObPbwcNor2wjzmspkYzn+R2XxbSdcDZmCY2mqPCU6mP+
         2I9/zIz0r1Pyivg0FCjqYFr7Jz9cVCqY9oRVmFMreBEg6kollJKsvudkG0m5jXzZg5fZ
         fiCD6oJPhY7iDGLePZbmBlEOBT6C2KHziQGcHOO4GYO8R880m/0gQx3tZ1lnB8qhB3WI
         mVUg==
X-Gm-Message-State: AOAM533E85F6BTB79y978U8DS6LUE9Ig9eJJ7q1CSD1CnCaNLAvgIm0d
        BImK4cMDaWqpL/V0qpuhnVAtmnlY
X-Google-Smtp-Source: ABdhPJwOb2b1vWM+l4Zdz7nA5b92Roq+WXWivgniKCvDR4klbZpErABvdTdOKYkU0m0iput7Luc9WA==
X-Received: by 2002:a17:906:3c42:: with SMTP id i2mr30104959ejg.14.1593707276042;
        Thu, 02 Jul 2020 09:27:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:4932:71ef:3c73:a14f])
        by smtp.gmail.com with ESMTPSA id gu15sm7375188ejb.111.2020.07.02.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 09:27:55 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/3] pci: use 'pci_channel_state_t' instead of 'enum pci_channel_state'
Date:   Thu,  2 Jul 2020 18:26:49 +0200
Message-Id: <20200702162651.49526-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162651.49526-1-luc.vanoostenryck@gmail.com>
References: <20200702162651.49526-1-luc.vanoostenryck@gmail.com>
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

So, consolidate everything by using 'pci_channel_state_t' in the
method's definition, in the related helpers and in the drivers.

Note: Currently, from a typechecking point of view this patch change
      nothing because only the constants defined by the enum
      are bitwise, not the enum itself (sparse doesn't have
      the notion of 'bitwise enum'). This may change in some
      not too far future, hence the patch.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/PCI/pci-error-recovery.rst    | 4 ++--
 arch/powerpc/kernel/eeh_driver.c            | 2 +-
 drivers/block/rsxx/core.c                   | 2 +-
 drivers/dma/ioat/init.c                     | 2 +-
 drivers/media/pci/ngene/ngene-cards.c       | 2 +-
 drivers/misc/genwqe/card_base.c             | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c   | 2 +-
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 4 ++--
 drivers/net/ethernet/sfc/efx.c              | 2 +-
 drivers/net/ethernet/sfc/falcon/efx.c       | 2 +-
 drivers/pci/pci.h                           | 2 +-
 drivers/pci/pcie/err.c                      | 4 ++--
 drivers/pci/pcie/portdrv_pci.c              | 2 +-
 drivers/scsi/aacraid/linit.c                | 2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c         | 2 +-
 drivers/staging/qlge/qlge_main.c            | 2 +-
 include/linux/pci.h                         | 2 +-
 18 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 13beee23cb04..c055deec8c56 100644
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
@@ -348,7 +348,7 @@ STEP 6: Permanent Failure
 -------------------------
 A "permanent failure" has occurred, and the platform cannot recover
 the device.  The platform will call error_detected() with a
-pci_channel_state value of pci_channel_io_perm_failure.
+pci_channel_state_t value of pci_channel_io_perm_failure.
 
 The device driver should, at this point, assume the worst. It should
 cancel all pending I/O, refuse all new I/O, returning -EIO to
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7b048cee767c..ab8806d2e03e 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -214,7 +214,7 @@ static void eeh_dev_save_state(struct eeh_dev *edev, void *userdata)
 	pci_save_state(pdev);
 }
 
-static void eeh_set_channel_state(struct eeh_pe *root, enum pci_channel_state s)
+static void eeh_set_channel_state(struct eeh_pe *root, pci_channel_state_t s)
 {
 	struct eeh_pe *pe;
 	struct eeh_dev *edev, *tmp;
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
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 082825e3cb39..4dd9226a12df 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3586,7 +3586,7 @@ static void ice_remove(struct pci_dev *pdev)
  * is in progress.  Allows the driver to gracefully prepare/handle PCI errors.
  */
 static pci_ers_result_t
-ice_pci_err_detected(struct pci_dev *pdev, enum pci_channel_state err)
+ice_pci_err_detected(struct pci_dev *pdev, pci_channel_state_t err)
 {
 	struct ice_pf *pf = pci_get_drvdata(pdev);
 
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
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f75867106..c6c0c455f59f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -555,7 +555,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
-			enum pci_channel_state state,
+			pci_channel_state_t state,
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..467686ee2d8b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -46,7 +46,7 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig,
 }
 
 static int report_error_detected(struct pci_dev *dev,
-				 enum pci_channel_state state,
+				 pci_channel_state_t state,
 				 enum pci_ers_result *result)
 {
 	pci_ers_result_t vote;
@@ -147,7 +147,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 }
 
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
-			enum pci_channel_state state,
+			pci_channel_state_t state,
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
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
-- 
2.27.0

