Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5C13FB8F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 22:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbgAPVbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 16:31:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37794 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389270AbgAPVbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 16:31:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so8903781plz.4
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2020 13:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnVcYi/hHjaeb2++zB3QNjZWrPcPugEoKb4FEoIY0uc=;
        b=e1Q+9nwivpUZ2eoLhWvQW1m6CVAfa3aaBK6UccLFGY6wRgCQaM0k2UwuA/r4xW72Fz
         Cpa8tRIYCmLrOJczdtutg3hQgF5DQ/LN0HphoQosDw7iwLUx78p/zHtm31mmcOujIme5
         IVDzoihrY9213l6cwwUw0YMFuljdl3ONuQPx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnVcYi/hHjaeb2++zB3QNjZWrPcPugEoKb4FEoIY0uc=;
        b=rFlar3gcLdu0havx7aN7Eu0Nupf6ie9+g1dzr2T6a7b7+Hw0XwGEraBBfUzq8b39GU
         cFLTPEzQyEydIr4GF244WbXIdzBUxSRedlxnNOsb0IVW9rCUoTzRe1zjYnNDhnVUUHyQ
         1n1tCwwaakVbcuOVCTiZOTHP/j2AWTbC0rncOk5GUtPt8jZDy0vVDbWamOBNUVbNjq9z
         SSmdIWzD/aI3xpUpI36ld0PQdUxo6V82Eq6z3dkAF4fVUKuLNJCAbAZ1rVLYtEvO+1gS
         2il6zs/XTLSsaNnRbeuAQtnfMd0UOzfb71/N9KIgcrxJUuewIRqnSJPmrc73yv/m1BY1
         HCBg==
X-Gm-Message-State: APjAAAWE3o348AVpnQIvUcIZAya2fcFwr9BBnyr+NQxKrhbtaH/YIrCc
        OiwePo/gvDqE/RuHuPHMRFIS8E6ab/4=
X-Google-Smtp-Source: APXvYqxRm1Ch7JZUpuIlMAl3bHLM9JzmakZgQeA31Fg9jI5zsQYCQR2YD2ZlLu+lzl5fVGUJRQtt3A==
X-Received: by 2002:a17:902:8202:: with SMTP id x2mr32885787pln.314.1579210302728;
        Thu, 16 Jan 2020 13:31:42 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id g19sm26782723pfh.134.2020.01.16.13.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 13:31:42 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Evan Green <evgreen@chromium.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
Date:   Thu, 16 Jan 2020 13:31:28 -0800
Message-Id: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

__pci_write_msi_msg() updates three registers in the device: address
high, address low, and data. On x86 systems, address low contains
CPU targeting info, and data contains the vector. The order of writes
is address, then data.

This is problematic if an interrupt comes in after address has
been written, but before data is updated, and the SMP affinity of
the interrupt is changing. In this case, the interrupt targets the
wrong vector on the new CPU.

This case is pretty easy to stumble into using xhci and CPU hotplugging.
Create a script that targets interrupts at a set of cores and then
offlines those cores. Put some stress on USB, and then watch xhci lose
an interrupt and die.

Avoid this by disabling MSIs during the update.

Signed-off-by: Evan Green <evgreen@chromium.org>
---


Bjorn,
I was unsure whether disabling MSIs temporarily is actually an okay
thing to do. I considered using the mask bit, but got the impression
that not all devices support the mask bit. Let me know if this going to
cause problems or there's a better way. I can include the repro
script I used to cause mayhem if needed.

---
 drivers/pci/msi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6b43a5455c7af..97856ef862d68 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -328,7 +328,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		u16 msgctl;
 
 		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
-		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
+		msgctl &= ~(PCI_MSI_FLAGS_QSIZE | PCI_MSI_FLAGS_ENABLE);
 		msgctl |= entry->msi_attrib.multiple << 4;
 		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 
@@ -343,6 +343,9 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
 					      msg->data);
 		}
+
+		msgctl |= PCI_MSI_FLAGS_ENABLE;
+		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 	}
 
 skip:
-- 
2.24.1

