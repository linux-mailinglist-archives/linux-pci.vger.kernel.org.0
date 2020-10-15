Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3328F90E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbgJOTCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388725AbgJOTCf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 15:02:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE7C061755;
        Thu, 15 Oct 2020 12:02:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g16so122821pjv.3;
        Thu, 15 Oct 2020 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ull4EM60WYNgXyvm3l6tM0BtabvXbBKAjGopj21NCHE=;
        b=WaDJwV09AKfvnZ7lrTg36nfcevHMIE7t2PuVtCQJVHvmYcxgnKvlrbN5Gs+90Hd4yl
         sqQAwYxUTCXBcRg4KTSMpEaeeSSWQVdYoINjzWNKe1zPWKgrwOxzGonTioR9gANuMe75
         fnkjslTniNfspieZGrBbUUcu61yzGQ+YKAmhpkPMIrd0QvJ/7R4NRzYq/4KbKttsb7Zh
         VQhqKdRM5hGM9u3BJ1v63MQSD2xJFuEw4nQpJCzgXc+yPfUUdcZVaBTwOxNu1vraRGIU
         xdjdfMMjIb+yWVXkKjdt4L6CZHl/TdiHhKM2dhJlGhrUatAwXgw6U+RKXURO0mnCFMLT
         BrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ull4EM60WYNgXyvm3l6tM0BtabvXbBKAjGopj21NCHE=;
        b=ueeLlXWUnNG9yV17NZw7YjpUxDTEP14mrP8/nTHL8UwWN1udJ7/OyRHbVLUH7jJWTG
         hTTqcghtlWkcjvsFxsXMMI9slqL2psrEHaaHzdZy0fhlNe6wRQ5a1g7KJy5ZKefjdx57
         vlOquSe+qfAl4r8wTkEL7Zy93lx+zFfO3vBQvnat0s0vHp08tavuWLhSvv6zHOm9N5DP
         btLj/lPRx5Th0p7I0aWSjQ24EAh0aTR9yLZtncXYMmFAXfJIiZj61xGjpZctfGkIzHi0
         hZBFEak6BElILoaHISTOkEiUT6NYn8QBXzf51SvOZETPzbokJ3vDKonpGKKnQcWenaYv
         bIBA==
X-Gm-Message-State: AOAM530fcRzlVl98xZnZbt/rGJ7uL9IP5PR7spwK/CJEGsuadgtP4Sr/
        /r7ncqCUVH4rZIcLqgyE1IM=
X-Google-Smtp-Source: ABdhPJwExSI8dCEsM8BrjJlsRtlQyDe21dsZsLVD2TdmUGgmKsN3E6o843x1a9McxC+O4wYtoef3RQ==
X-Received: by 2002:a17:902:c143:b029:d3:f20c:ed84 with SMTP id 3-20020a170902c143b02900d3f20ced84mr149549plj.76.1602788553075;
        Thu, 15 Oct 2020 12:02:33 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id i1sm14404pjh.52.2020.10.15.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 12:02:32 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com, okaya@kernel.org, hch@infradead.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v7 1/2] PCI/ERR: Call pci_bus_reset() before calling ->slot_reset() callback
Date:   Thu, 15 Oct 2020 12:02:23 -0700
Message-Id: <546d346644654915877365b19ea534378db0894d.1602788209.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 Changes since v6:
  * None.

 Changes since v5:
  * Added Ashok's Reviewed-by tag.

 Changes since v4:
  * Added check for pci_reset_bus() return value.

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

