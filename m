Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4576974234
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfGXXj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33924 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388079AbfGXXjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:25 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so93374083iot.1;
        Wed, 24 Jul 2019 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jv+5h9zsvocG3vmZUV+laGAVtUTGR/TP9VTvdDmoTz8=;
        b=EDBKGPEY8gNRIm6GLz7eEQXiloyjwA5nE4eDL//MPGFDqxgacSpuOhKqx1np8mzPjs
         hGPgyPBtOiMtQbL89K8Ug1fDzeYWb0PHZKX1ElGv6Yn8GHj1pudjK7I4EOojcsumedxh
         SuqZBv4w1zbhY1SWJDXbMk7HhlML90c3SitDL/ZpvuKOQjsPtC2n4cfr0ydXVadI23Wf
         /Dge/VY8EnTjx0YhHHkygpYLKooF/AXfLEwN30Y90ibKxoXliOAYZPBU/rsKoaARWmmX
         MYaEtzx/s7ztxFTmAGHbGQrzvwvDladSnJ8Qd2GjLgdqTAvDV/qyCiIjKxvRkJJWu98s
         Nttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jv+5h9zsvocG3vmZUV+laGAVtUTGR/TP9VTvdDmoTz8=;
        b=YhrxyMMY/kmXf27tnuxnNkMtoIm89yv43KlLfbDgJatLk4Nt5saNgDZS4eOqljZoCd
         uYum3BLHA9WlglhgnE09DQ5qr0kAqGAnGofJMvlAjwdVKXifyvRwI9XZAkMg8Ousa85x
         1P1IwKslH1884xnKaDrCAb6U+4M+EHR6qVzWRAHBiXrZi2H33Sm5gWNQVSu5JEsQ1nsb
         CvXxdre05hkkp4xxe0uZq14zVMtgJxqwzicmTAenlI73zWhZLZ3DUv2jFkD96Uf7gBrm
         3lhTU3ZSlY5sXLnCQD8jbYSvKC+hbCmoHxviQt/gdJYdoMqtob4P16UHvzirxbf3YRum
         Y/8g==
X-Gm-Message-State: APjAAAU88ONLtZv2BeyLBbTEJFfZ9EY+BFCKbn13wW1B73FK8OZCzIEs
        ioxIZXqBk/TVrjTmTRf/AC8Ki7u2c+hKSw==
X-Google-Smtp-Source: APXvYqzL6oW/Clg2J47PQR1aH5O41FAHwJVYA5fEhLrRB3MVj8DyKnXYMYiW7k2oON2cgNcwRQyxjg==
X-Received: by 2002:a6b:3102:: with SMTP id j2mr13169207ioa.5.1564011564997;
        Wed, 24 Jul 2019 16:39:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:24 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 04/11] PCI: Move PCI Virtual Channel declarations to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:41 -0600
Message-Id: <20190724233848.73327-5-skunberg.kelsey@gmail.com>
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

PCI Virtual Channel declarations are only called within drivers/pci/.
Since declarations do not need to be visible to the rest of the kernel,
move to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 5 +++++
 include/linux/pci.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f41dde136648..0eb0fb7ad353 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -133,6 +133,11 @@ void pci_vpd_release(struct pci_dev *dev);
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
index cd49427e198e..d1944e3e7eb2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1239,11 +1239,6 @@ bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
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

