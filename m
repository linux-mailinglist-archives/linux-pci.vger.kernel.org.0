Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3879707A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 05:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfHUDo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 23:44:27 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42809 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHUDo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 23:44:26 -0400
Received: by mail-yb1-f195.google.com with SMTP id h8so449588ybq.9;
        Tue, 20 Aug 2019 20:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YcggR1HawStyBJ3k10IaNabkt2WXu5RxAJT3QmaxLtw=;
        b=m+FIr9uSKbH7TJMP0Ahdc94aI/pr99eGNU/kAzDAh3MaNrzNOSjlxvzpVn/OD4oYo9
         30CgE+tg7iQR8wpq2gXKpSPiquntA3zhWCInmr2+VmkvEhQ1EPddJZwb5XzY++l7lSCK
         9SZ3kXmyo8j5dWUGmKz1vnQ2Q3XtA9ZrNW9t7KvpigmIN+qkS3EiWT9CaKQgVIFEvMXq
         yKWtUHLdZMB0x7KHUYm5DSGOCdg+99V5JLnE83AjeuU6YshOqYt4T7uE8If7o/HZT3g5
         CCjjAk+6Gr2iQET1ri5jFUIYRauRglzfdTaJd2mzfa60ITU5dyp5oZuOJyMuys4fiAuP
         LOMg==
X-Gm-Message-State: APjAAAXQu5R41qYXKFrKgv8zbfJbSFGUTuFaZhb+jV/iUxhlZ95lLsMn
        oYIMsCsv7WcULCZVGzvbrB8=
X-Google-Smtp-Source: APXvYqzD5ET7RLLtceKCPwcALRHEUhK2tgGJTNOyhKZAwigWcvAuQ9Tfc2ujNrO3jyeGZsInKdTieQ==
X-Received: by 2002:a25:dc87:: with SMTP id y129mr13167422ybe.424.1566359065921;
        Tue, 20 Aug 2019 20:44:25 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id q65sm4017227ywc.11.2019.08.20.20.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Aug 2019 20:44:25 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ACPI / PCI: fix acpi_pci_irq_enable() memory leak
Date:   Tue, 20 Aug 2019 22:44:19 -0500
Message-Id: <1566359059-4844-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In acpi_pci_irq_enable(), 'entry' is allocated by kzalloc() in
acpi_pci_irq_check_entry() (invoked from acpi_pci_irq_lookup()). However,
it is not deallocated if acpi_pci_irq_valid() returns false, leading to a
memory leak. To fix this issue, free 'entry' before returning 0.

Fixes: e237a5518425 ("x86/ACPI/PCI: Recognize that Interrupt Line 255 means
"not connected"")

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

