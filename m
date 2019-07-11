Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E53661AB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfGKW0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44715 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfGKW0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:17 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so16086039iob.11;
        Thu, 11 Jul 2019 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tB5J2/wqtRLqVSXhsqanry6b574nX1t8eRYt7w0aqcw=;
        b=bTJr5fSTVteg1zkn9u+Bj/u8lEeQk6RpJCfWjePP9aNRHpTxIk+U2JwkRP2cn70jza
         TCoMKWc8E66ErT/8863dThZ8ZOW+nxYKKHHvlQuDrUuRLmJpbYZMVJaN4cLv4UF4rEqO
         QerNts7ijEyvSeYNgyRt76IKf0++sQuzCIzwJZWWBRYTlQ2IjVa4v/vmQkn9HC9K54hN
         gl7qavNetJA+utE9STOVQdNnDaKP5GxJQukzoXiYjshghaIl+JqghCjkolYmxv/449O6
         lKBDrleIKB/ImyiMiGv5hD3l4XQEetk3Ftw6gme7ira/xtMIjJVx0oUrW4CRr8AFco7W
         wG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tB5J2/wqtRLqVSXhsqanry6b574nX1t8eRYt7w0aqcw=;
        b=ATLi5L7t45H8wVpgrG9fo6OWsyjCUQd4a8X1Qi0SU47SnZbS833q7r2Jvfey2bkB8R
         wwiGxgMxgUZHsjW/Qq3ffR/LvaXikX9ugW1B1wdifrj21FB8Y84Izj2ipccK5rHztRD1
         7S9uhHEHUoFu8eoBA9dQVMmhv5NEouRgLh4OL/08cdUXKs3WK2E/h19XapVUxlapzAs5
         wWFIrfIamM3IKdqzSR4t+SCyLjeNJxSvzFIWGPo6/cE9OBUaCkz3i2W2I/CrV3tMkHeN
         hK/Q5iKqnxBszSfG0VS1IhR61NBjKA8TJtSXsDWZ65AFgFBSI6krPfTTE0TaVuWxEAAg
         au6w==
X-Gm-Message-State: APjAAAVpklT3glcCmgl+yfpGEe5Rze/JtP1hYlkbil5f3hfgBG0aGfUh
        d3SQJAqfVJhwqoPmGRtGuqEgjtjtzObBOg==
X-Google-Smtp-Source: APXvYqzvttkYZYuof6PBH2+QH6WG8r1tQqxM9JEk4AGtZ1qFXB0pldv5f93GKqTbY4DGleOgjkNSvw==
X-Received: by 2002:a02:c615:: with SMTP id i21mr7123006jan.135.1562883976159;
        Thu, 11 Jul 2019 15:26:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:15 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 04/11] PCI: Move PCI Virtual Channel declarations to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:34 -0600
Message-Id: <20190711222341.111556-5-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI Virtual Channel declarations are only called within drivers/pci/.
Since declarations do not need to be visible to the rest of the kernel,
move to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 5 +++++
 include/linux/pci.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f2ba33613c21..6ba790a77be4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -128,6 +128,11 @@ void pci_vpd_release(struct pci_dev *dev);
 void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
 void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev);
 
+/* PCI Virtual Channel */
+int pci_save_vc_state(struct pci_dev *dev);
+void pci_restore_vc_state(struct pci_dev *dev);
+void pci_allocate_vc_save_buffers(struct pci_dev *dev);
+
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 int pci_proc_attach_device(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 39e609ea316e..2c5609b5782e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1190,11 +1190,6 @@ bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
 void pci_wakeup_bus(struct pci_bus *bus);
 void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
 
-/* PCI Virtual Channel */
-int pci_save_vc_state(struct pci_dev *dev);
-void pci_restore_vc_state(struct pci_dev *dev);
-void pci_allocate_vc_save_buffers(struct pci_dev *dev);
-
 /* For use by arch with custom probe code */
 void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);
-- 
2.20.1

