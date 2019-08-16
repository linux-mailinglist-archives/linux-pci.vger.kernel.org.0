Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754178F9EA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 06:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfHPEd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 00:33:28 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35389 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPEd2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 00:33:28 -0400
Received: by mail-yb1-f194.google.com with SMTP id c9so1571789ybq.2;
        Thu, 15 Aug 2019 21:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+OcQru066Drv5pXc9VyqHlEO+MqaTlu7JFvqJcPm4qE=;
        b=b5dGDIWwLnSWLqM6ejb103JzIptXSxmVuqBYi33hr+eoyPLI3iGa9qTI87D+2Jc6zO
         Qa96vhLk3Z67HT3PGONjCz9s0sAfSQeEMswWg14Pm8gdxAY2Yf3xlXBb06mEGiMeYebl
         wVTxasEQff8X2ngS4HtmOh+zKQulCLE5dz3bhnBPEeCARoB2NCFMoseHwiJ/d2LVlEPn
         ONa0GuqV7Xj92i1NtPkcQwe8apTRB1CT/CqfGGoTDVJ9TbeNe24Y2VX3bY3Ux5y9OLnk
         AHkV4r+2ruHTbjY1nrwWG3ffuNGQdss72X/WHfeMRBW4at9uZOMePKrvdan1PLKk1DUt
         m4Fg==
X-Gm-Message-State: APjAAAWX4sI/uvwxqU6yAmC/V/8bu9laNvVoK82KnsqerSXRJiw5ovts
        YnsvhoH/sf09Ylhb+J1VoxI=
X-Google-Smtp-Source: APXvYqyh6ougJ494mKCHFiF9wyPs3iXIGyRydgh81VwPzZSlneeqQJvp+VLVr7WfTM1xoGoj0pPm/g==
X-Received: by 2002:a25:208b:: with SMTP id g133mr6034984ybg.304.1565930007532;
        Thu, 15 Aug 2019 21:33:27 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id b64sm1024042ywe.43.2019.08.15.21.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 21:33:26 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI / PCI: fix a memory leak bug
Date:   Thu, 15 Aug 2019 23:33:22 -0500
Message-Id: <1565930002-5524-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In acpi_pci_irq_enable(), 'entry' is allocated by invoking
acpi_pci_irq_lookup(). However, it is not deallocated if
acpi_pci_irq_valid() returns false, leading to a memory leak. To fix this
issue, free 'entry' before returning 0.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/acpi/pci_irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index d2549ae..dea8a60 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -449,8 +449,10 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		 * No IRQ known to the ACPI subsystem - maybe the BIOS /
 		 * driver reported one, then use it. Exit in any case.
 		 */
-		if (!acpi_pci_irq_valid(dev, pin))
+		if (!acpi_pci_irq_valid(dev, pin)) {
+			kfree(entry);
 			return 0;
+		}
 
 		if (acpi_isa_register_gsi(dev))
 			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
-- 
2.7.4

