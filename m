Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E749174245
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfGXXj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37733 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388510AbfGXXja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:30 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so93286711iog.4;
        Wed, 24 Jul 2019 16:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAcPMfe4yfghI1KUSCC11QjOq9mL6eRC3i1HmLX64SA=;
        b=kjwyg+lUAIuMA/MRerzz3UX88Xahmp53ZcoCO6siikOWTAdnn1reZAx4HKYmgMwY5I
         t6iX1bPY2ITZ3qxMpey8uDrfMkq7LqtaufDZ4tWjLw9q8PXxdENVHtJtjTu7/CU/xZEb
         8X55RBwHdpdm6W6JSwE8s/VmKQKUgKcn9MarMYMbn4T/nNnKDKzfnGUylxGuZSy3UIRV
         0t8FZS6FZ2p3+AHanLHUHEErA1KG1POu38u402UXP7y9kstBcadh4DujqkgpjLjj6VEp
         bGENI79zF4Mg5EYJYCI4WS1J7oon6qJUElTBcw1MPjBwgMU6ITYyi16j2b/wAjjtI3qC
         2thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAcPMfe4yfghI1KUSCC11QjOq9mL6eRC3i1HmLX64SA=;
        b=User/U6XVi8AXkJ+Ldr58QUuN1T7Awhp0I61s8d3O4ry++TlHVetk/HhirR4VoIEk7
         Keaq6nn0kPQuRV2g1GBGWL0eLVbUpMs0vimjTx9OGgzXKlesmlHL0LGIBHyTZ1oKW1kL
         VHo1DEIr1DZlKDD9XPq1S8G0/I3PKLj96Ob54Ihgkdlo1mNJwNWMaGVpNQZT+KgXFI3B
         ySj1WWq/nIoRgv39fm759DUgI4iaihJ52mohlna36wLMlsTkwYDp9gWA1lgAqzCBZjxV
         WuDGMXuZ2kb/8uQnA3PboeGODsNL3EnGZDLej0Sf1WLQ7bkg+Szzo3SdenA4Sx/xx7aW
         uH2g==
X-Gm-Message-State: APjAAAXCHBIxqQqHX6rxwmOLUUidRFC51gqZ0X2csGwwzBikRr6N2xiH
        +8LWPjqywYLBoB3A1C7uGe8=
X-Google-Smtp-Source: APXvYqy8SNFjSICh1nq0Hw7XzdxkbUHtNbwwrjOlx+kGCNmsqIjRuGCmBHFzww4v/WfzCjlkn/Ut2Q==
X-Received: by 2002:a6b:4107:: with SMTP id n7mr10472279ioa.12.1564011569971;
        Wed, 24 Jul 2019 16:39:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:29 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 07/11] PCI: Move pcie_update_link_speed() to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:44 -0600
Message-Id: <20190724233848.73327-8-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_update_line_speed() is only called within drivers/pci/. Since
declaration does not need to be visible to the rest of the kernel, move to
drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 1 +
 include/linux/pci.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3e9dfca4b661..feec29853a44 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -299,6 +299,7 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 			   enum pcie_link_width *width);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
+void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index af59ecf8ccff..c6a25c32a49a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -987,7 +987,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
-void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
 struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 				 const char *name,
 				 struct hotplug_slot *hotplug);
-- 
2.20.1

