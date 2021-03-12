Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DE33951A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 18:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCLRgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 12:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhCLRgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 12:36:43 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48810C061574;
        Fri, 12 Mar 2021 09:36:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so3565099pjb.0;
        Fri, 12 Mar 2021 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Y1htRxzwe4GvUrmVHitMsRW0eXRp0985GL3PMPoywk=;
        b=muJS2aQvJm8TGBVf+gd2klUHo+uSGPPcfJqaL5x4H3vCYH7Flj+nwMOW46CrNsbOrd
         WZamp5cG5ueUQHjZ29mg6ZJVWPxAyujQtCjRVBlsIbQ00VBrd202qEMJ1/gB1IckHPor
         DjQ9XOfBGUKgOhtPE7ZE4jgrgAxnWrmRVK9oMo2L8/DyL7rXkEImFKKXrHe45laFWB2v
         673SzVhjP5zLNgFRo2VudrKafHffYysaCSQ1/aqAicyLINRHTiBZKagC8u8OG8nEDi0q
         Q/ZvIyk4gg5JgCJDyu1E0hx8Ul3V/IKuYiw/l32hMybAMr/JP2jvGxLyEYYIIkyBwMit
         FjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Y1htRxzwe4GvUrmVHitMsRW0eXRp0985GL3PMPoywk=;
        b=NiNy0DZSnee0qdngdJ+UT+NiYe9RKwF3HzYN5uz9ljYSn5N4Cyg6cmUxM65mXhq+tF
         kFnm7GWcSbD/8aWb4d+z/v6xg5o+C7VeXJSJZ0DUFewmr/y3Ey1HITHxsa3koM/PqE7Z
         hlOcEoQLeXMibIY+P8B0FJAx8r7PMfBtsooSsvvSnahjE8tUQ7bCHM+NjWQdyPuywdu+
         Ohp+MMsEO4FwdNAunKPZwBGVF09+YLz0QBjR/Yd+pXimUTJJ9Sph9Yfo4Di4ejT3Hzzm
         K+1dIkUIrOGDKN4tpJAquQoKbZ5t//9ILDxNQTpyqlSF5R8G6d2mMBk+OOCUDFWR84Qg
         zJTA==
X-Gm-Message-State: AOAM531VWCok/r50XMcHNn3iA/87qCPHzzAxd9dAAx9ofpmPVsMjkY1z
        gYx3DumLNfuN2mzD3De7VQo=
X-Google-Smtp-Source: ABdhPJx8X5eUIY/Vv5eoDYuqyxS3392B2yM95G9bKH2hNncfLaySXC76EoqAeai8I6aVWzeJxKw/6g==
X-Received: by 2002:a17:90b:4008:: with SMTP id ie8mr15775538pjb.231.1615570602851;
        Fri, 12 Mar 2021 09:36:42 -0800 (PST)
Received: from localhost.localdomain ([103.248.31.144])
        by smtp.googlemail.com with ESMTPSA id l10sm180045pfc.125.2021.03.12.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:36:42 -0800 (PST)
From:   ameynarkhede03@gmail.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH 1/4] PCI: Refactor pcie_flr to follow calling convention of other reset methods
Date:   Fri, 12 Mar 2021 23:04:49 +0530
Message-Id: <20210312173452.3855-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312173452.3855-1-ameynarkhede03@gmail.com>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Currently there is separate function pcie_has_flr to probe
whether pcie flr is supported or not by the device which does
not match the calling convention followed by all other reset
methods which use second function argument to decide whether
to probe or not. Refactor pcie_flr to follow calling convention
of reset methods and remove superfluous pcie_has_flr function.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

 drivers/crypto/cavium/nitrox/nitrox_main.c    |  4 +-
 drivers/crypto/qat/qat_common/adf_aer.c       |  2 +-
 drivers/infiniband/hw/hfi1/chip.c             |  4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
 .../ethernet/cavium/liquidio/octeon_mailbox.c |  2 +-
 drivers/net/ethernet/freescale/enetc/enetc.c  |  2 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +-
 drivers/pci/pci.c                             | 65 ++++++++++---------
 drivers/pci/pcie/aer.c                        | 12 ++--
 drivers/pci/quirks.c                          | 15 ++---
 include/linux/pci.h                           |  4 +-
 13 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index facc8e6bc..dbf9499f4 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
 		return -ENOMEM;
 	}

-	/* check flr support */
-	if (pcie_has_flr(pdev))
-		pcie_flr(pdev);
+	pcie_flr(pdev, 0);

 	pci_restore_state(pdev);

diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index d2ae293d0..7716a6b8b 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(adf_reset_sbr);

 void adf_reset_flr(struct adf_accel_dev *accel_dev)
 {
-	pcie_flr(accel_to_pci_dev(accel_dev));
+	pcie_flr(accel_to_pci_dev(accel_dev), 0);
 }
 EXPORT_SYMBOL_GPL(adf_reset_flr);

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 993cbf37e..b2cc0dd9b 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -14099,7 +14099,7 @@ static int init_chip(struct hfi1_devdata *dd)
 		dd_dev_info(dd, "Resetting CSRs with FLR\n");

 		/* do the FLR, the DC reset will remain */
-		pcie_flr(dd->pcidev);
+		pcie_flr(dd->pcidev, 0);

 		/* restore command and BARs */
 		ret = restore_pci_variables(dd);
@@ -14111,7 +14111,7 @@ static int init_chip(struct hfi1_devdata *dd)

 		if (is_ax(dd)) {
 			dd_dev_info(dd, "Resetting CSRs with FLR\n");
-			pcie_flr(dd->pcidev);
+			pcie_flr(dd->pcidev, 0);
 			ret = restore_pci_variables(dd);
 			if (ret) {
 				dd_dev_err(dd, "%s: Could not restore PCI variables\n",
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a680fd9c6..dd2b539c7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12750,7 +12750,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	if (is_kdump_kernel()) {
 		pci_clear_master(pdev);
-		pcie_flr(pdev);
+		pcie_flr(pdev, 0);
 	}

 	max_irqs = bnxt_get_max_irq(pdev);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 516f166ce..9b9d305c6 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -429,7 +429,7 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);

-	pcie_flr(oct->pci_dev);
+	pcie_flr(oct->pci_dev, 0);

 	pci_cfg_access_unlock(oct->pci_dev);

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
index ad685f5d0..ed9e68a4b 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
@@ -260,7 +260,7 @@ static int octeon_mbox_process_cmd(struct octeon_mbox *mbox,
 		dev_info(&oct->pci_dev->dev,
 			 "got a request for FLR from VF that owns DPI ring %u\n",
 			 mbox->q_no);
-		pcie_flr(oct->sriov_info.dpiring_to_vfpcidev_lut[mbox->q_no]);
+		pcie_flr(oct->sriov_info.dpiring_to_vfpcidev_lut[mbox->q_no], 0);
 		break;

 	case OCTEON_PF_CHANGED_VF_MACADDR:
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c78d12229..8fb11c63c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1895,7 +1895,7 @@ int enetc_pci_probe(struct pci_dev *pdev, const char *name, int sizeof_priv)
 	size_t alloc_size;
 	int err, len;

-	pcie_flr(pdev);
+	pcie_flr(pdev, 0);
 	err = pci_enable_device_mem(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "device enable failed\n");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 15f37c5b8..7cd6bf124 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -47,7 +47,7 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));

-	pcie_flr(pdev);
+	pcie_flr(pdev, 0);
 	err = pci_enable_device_mem(pdev);
 	if (err) {
 		dev_err(dev, "device enable failed\n");
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fae84202d..c638fb650 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7624,7 +7624,7 @@ static void ixgbe_check_for_bad_vf(struct ixgbe_adapter *adapter)
 		pci_read_config_word(vfdev, PCI_STATUS, &status_reg);
 		if (status_reg != IXGBE_FAILED_READ_CFG_WORD &&
 		    status_reg & PCI_STATUS_REC_MASTER_ABORT)
-			pcie_flr(vfdev);
+			pcie_flr(vfdev, 0);
 	}
 }

@@ -11241,7 +11241,7 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 		 * VFLR.  Just clean up the AER in that case.
 		 */
 		if (vfdev) {
-			pcie_flr(vfdev);
+			pcie_flr(vfdev, 0);
 			/* Free device reference count */
 			pci_dev_put(vfdev);
 		}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f..4a7c084a3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4574,33 +4574,13 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);

 /**
- * pcie_has_flr - check if a device supports function level resets
- * @dev: device to check
- *
- * Returns true if the device advertises support for PCIe function level
- * resets.
- */
-bool pcie_has_flr(struct pci_dev *dev)
-{
-	u32 cap;
-
-	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
-		return false;
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
-}
-EXPORT_SYMBOL_GPL(pcie_has_flr);
-
-/**
- * pcie_flr - initiate a PCIe function level reset
+ * pcie_reset_flr - initiate a PCIe function level reset
  * @dev: device to reset
  *
- * Initiate a function level reset on @dev.  The caller should ensure the
- * device supports FLR before calling this function, e.g. by using the
- * pcie_has_flr() helper.
+ * Initiate a function level reset unconditionally on @dev without
+ * checking any flags and DEVCAP
  */
-int pcie_flr(struct pci_dev *dev)
+int pcie_reset_flr(struct pci_dev *dev)
 {
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
@@ -4619,6 +4599,30 @@ int pcie_flr(struct pci_dev *dev)

 	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 }
+
+/**
+ * pcie_flr - initiate a PCIe function level reset
+ * @dev: device to reset
+ * @probe: If set, only check if the device can be reset this way.
+ *
+ * Initiate a function level reset on @dev.
+ */
+int pcie_flr(struct pci_dev *dev, int probe)
+{
+	u32 cap;
+
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
+	if (!(cap & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return pcie_reset_flr(dev);
+}
 EXPORT_SYMBOL_GPL(pcie_flr);

 static int pci_af_flr(struct pci_dev *dev, int probe)
@@ -5091,11 +5095,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	rc = pci_dev_specific_reset(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
-	if (pcie_has_flr(dev)) {
-		rc = pcie_flr(dev);
-		if (rc != -ENOTTY)
-			return rc;
-	}
+	rc = pcie_flr(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
 	rc = pci_af_flr(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
@@ -5129,8 +5131,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
 	rc = pci_dev_specific_reset(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
-	if (pcie_has_flr(dev))
-		return 0;
+	rc = pcie_flr(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
 	rc = pci_af_flr(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ba2238834..57a8806a9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1405,13 +1405,11 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	}

 	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
-		if (pcie_has_flr(dev)) {
-			rc = pcie_flr(dev);
-			pci_info(dev, "has been reset (%d)\n", rc);
-		} else {
-			pci_info(dev, "not reset (no FLR support)\n");
-			rc = -ENOTTY;
-		}
+		rc = pcie_flr(dev, 0);
+		if (!rc)
+			pci_info(dev, "has been reset\n");
+		else
+			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
 	} else {
 		rc = pci_bus_error_reset(dev);
 		pci_info(dev, "%s Port link has been reset (%d)\n",
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3b..0a3df84c9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3692,7 +3692,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 	 * supported.
 	 */
 	if (!probe)
-		pcie_flr(dev);
+		pcie_reset_flr(dev);
 	return 0;
 }

@@ -3795,7 +3795,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 				      PCI_MSIX_FLAGS_ENABLE |
 				      PCI_MSIX_FLAGS_MASKALL);

-	pcie_flr(dev);
+	pcie_flr(dev, 0);

 	/*
 	 * Restore the configuration information (BAR values, etc.) including
@@ -3831,7 +3831,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
 	u32 cfg;

 	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
-	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
+	    pcie_flr(dev, 1) || !pci_resource_start(dev, 0))
 		return -ENOTTY;

 	if (probe)
@@ -3887,7 +3887,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)

 	pci_iounmap(dev, bar);

-	pcie_flr(dev);
+	pcie_flr(dev, 0);

 	return 0;
 }
@@ -3900,13 +3900,10 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 {
-	if (!pcie_has_flr(dev))
-		return -ENOTTY;
+	int ret = pcie_flr(dev, probe);

 	if (probe)
-		return 0;
-
-	pcie_flr(dev);
+		return ret;

 	msleep(250);

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97..621ff5224 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1217,8 +1217,8 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
-bool pcie_has_flr(struct pci_dev *dev);
-int pcie_flr(struct pci_dev *dev);
+int pcie_reset_flr(struct pci_dev *dev);
+int pcie_flr(struct pci_dev *dev, int probe);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
--
2.30.2
