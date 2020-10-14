Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84E028DAF7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgJNISc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 04:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNISb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 04:18:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1095AC051110;
        Wed, 14 Oct 2020 01:18:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so1196393pjr.3;
        Wed, 14 Oct 2020 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MsmwDeBwbMhZ+wEja7HHQKA9CZMajw1I+xNpemJZSMc=;
        b=si/FJSTLT0kQv5FMreJXGtioyykblBOgCn3QLdGtt+CkOd4AGdXsrdei0X5PBOVfxX
         kNvmjJzAJRbe+tCQ8a6oe+IDKBn2CogANSaLsaO0F+3ACu9WVn49VkvPzOeEJiIYbD00
         ikol/t9jfa+YsgY/i4hTfcXsELOdBV2kdNkIiwntrIbSrtWc6IAk7OCAzFyiN7CUTUOZ
         mmGehVjiAHccvduj0NsA6Hggaj1fP8uMn8iYSzxqJu3vgrfCHk+xzsfI75TkrxEKMdZq
         DRIrZoOFbfcRtWVPQHpEtiaHZUMIoJWzS0kM06iBOw9F65JhmVmLFOzZTz10xF9rpaRh
         Ep2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MsmwDeBwbMhZ+wEja7HHQKA9CZMajw1I+xNpemJZSMc=;
        b=TtbmBQRWXrXoFT5VrM82M8iAtJnpoBUY7keyp7RZcebUF4uOVmF/dG13aOkSv8/Aps
         0ko3frtiFkhRlJX6aiAqWaW6qqQE5uYXK/kMJbenqfDCgtTdp1cZYM5AWSMRcdDlgOAt
         HOuUkSj/8LSM8uRx1hJgQeL5rMPLVLPTLlmFM0okop9KOzjCE+3T593D7i+IEvEBlTH6
         hko+Z0IZMMENHAKHbgx4pMDIUZMfWRfGrH0bjQ5IhUA/C/PyQPe2z8KUgu+eel8WGMgW
         MIITdEoSE8ZXJwydHmOnQF3iZlvZzeDlyjKkK+keH0ocW9eXKxAcMgwX4596Qt/cgG1X
         Wpew==
X-Gm-Message-State: AOAM531drIoxsBXrXYE9Zq8Yng+7tkcMCYuyco7qEJIF+/YCFJpjWBGq
        eiL3Y0Qx/M+Y5jfm4zHm9xI=
X-Google-Smtp-Source: ABdhPJxcQE4xzP9IpieXKBv5cWzfN1OF9ZYvYE0+NBUjTlXwdwviDPdcskxJsxeDgLcvziAstflQmw==
X-Received: by 2002:a17:90b:3849:: with SMTP id nl9mr2491651pjb.54.1602663513512;
        Wed, 14 Oct 2020 01:18:33 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id t6sm2356594pgn.26.2020.10.14.01.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 01:18:32 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com, okaya@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 1/2] PCI/ERR: Call pci_bus_reset() before calling ->slot_reset() callback
Date:   Wed, 14 Oct 2020 01:18:27 -0700
Message-Id: <546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently if report_error_detected() or report_mmio_enabled()
functions requests PCI_ERS_RESULT_NEED_RESET, current
pcie_do_recovery() implementation does not do the requested
explicit device reset, but instead just calls the
report_slot_reset() on all affected devices. Notifying about the
reset via report_slot_reset() without doing the actual device
reset is incorrect. So call pci_bus_reset() before triggering
->slot_reset() callback.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 Changes since v4:
  * Added check for pci_reset_bus() return value.

 Changes since v5:
  * Added Ashok's Reviewed-by tag.

 drivers/pci/pcie/err.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..315a4d559c4c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -152,6 +152,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
+	int ret;
 
 	/*
 	 * Error recovery runs on all subordinates of the first downstream port.
@@ -181,11 +182,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
+		ret = pci_reset_bus(dev);
+		if (ret < 0) {
+			pci_err(dev, "Failed to reset %d\n", ret);
+			status = PCI_ERS_RESULT_DISCONNECT;
+			goto failed;
+		}
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
 		pci_walk_bus(bus, report_slot_reset, &status);
-- 
2.17.1

