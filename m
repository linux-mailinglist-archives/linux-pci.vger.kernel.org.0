Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3891F28DD83
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 11:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgJNJZC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 05:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgJNJUB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 05:20:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DA7C08EBB0;
        Tue, 13 Oct 2020 16:45:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so827140pfa.10;
        Tue, 13 Oct 2020 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m+Z/XvjZu06KL0G8enGFCvQ7cV3DU0ERkocEYKyzM7U=;
        b=rQvfSxBGOM6CHmHfoaTdbh6Vl2S9t794cBtfQQhTytpjfLarTPZUbRO2Yy0eP19+A3
         hoB8qSzpkfIhFqqye6qZFNkdeagvl6i6osh8gG8OlC+Gpk06Vj8AmqyNg9gO74Qn2npl
         5+rZ+/V2W5UouEn/xccwtWNt/+BsNVoaZylBBbZloCoqAlJGS2ZEWJKDBvd+Eov9TcDW
         1kbS7Wi5cq78oxbCV1DPTE7M6ZvIf5s+bVc6wzLeBmsb462EyFRXUtKugQxyX8kdVS1h
         3XsoKA56H8dmRyDP8IyFRHh3kWpxIZvLs2SryX2LbFKFtJ7EU5VptunO/fMZLzTzwrVl
         myhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m+Z/XvjZu06KL0G8enGFCvQ7cV3DU0ERkocEYKyzM7U=;
        b=BpCPRjZVQYNpaAAQviMC4z0J192f7poum8KizVa+SFamMx/buNMQ5AN596BrNIjXET
         Yq8y07YwqolKsKVZgDZVN1Vuz5/5g1+3O2zRtU7sIfSVpiykDYAxM9n/tKk927eNJEm4
         RVFMzLUKcLHt28gZ2MT7DPyWDHlkQKt1WfIZKc2JbwslhldpitpdkW1Si6lxLEzttusI
         1RZYKjkvXdn43hI+6+PkIASJeQs5UmhK3NZ+u1F8w8snQ4zU9qYtoNP8rBIBGt3z77M5
         /32jzybRB+4PQrTXlwd/HBf1RSnXo/yRoYiTnf9M2DaqBSShzFDe2vLXjz4Vc/U2JV9I
         DiuA==
X-Gm-Message-State: AOAM532S9BV8wbK8Dns2szfINsAtJs35TfGKmadr8DboiCLM2mygXvZq
        8uY3CFRSuoZv8hDuYtobFQI=
X-Google-Smtp-Source: ABdhPJyl9ZxXs3+HdWdnTEbiuqY5P9MzdGFczlYnuExEFAlJeCOa1VKNE+5YwJJmXVnNP2JEv69ArA==
X-Received: by 2002:a05:6a00:2d5:b029:152:197a:a23a with SMTP id b21-20020a056a0002d5b0290152197aa23amr1911152pft.66.1602632713660;
        Tue, 13 Oct 2020 16:45:13 -0700 (PDT)
Received: from skuppusw-mobl5.amr.corp.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id s6sm786171pfd.157.2020.10.13.16.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:45:12 -0700 (PDT)
From:   Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
X-Google-Original-From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com, okaya@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 1/2] PCI/ERR: Call pci_bus_reset() before calling ->slot_reset() callback
Date:   Tue, 13 Oct 2020 16:45:01 -0700
Message-Id: <162495c76c391de6e021919e2b69c5cd2dbbc22a.1602632140.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
---
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

