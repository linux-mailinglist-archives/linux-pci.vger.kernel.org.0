Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA590410885
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 22:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhIRUTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhIRUT3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 16:19:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CEC061574;
        Sat, 18 Sep 2021 13:18:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so9832432pjb.5;
        Sat, 18 Sep 2021 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Rz+Q9TyMwNKKp3Zp/SmxkDCYSutReaKArS9DPZj1vGU=;
        b=Vyqf0lTIGrmhvmmZbrcMnYNEUwfBUKo4E2Ov3rvEGvdmi1SIrO0nJJrSOzROA68kwH
         BO8d+xe+rBxBX1PfC68J4fL+6Y9NQvh9ibo9dRpcw8wmygRB4SmO1r/GI+RMfOKKJjZV
         xYCtLqT/SUI56+T9T1WO1doYn6BZ1l4b+GJ/vMAjSE9dSqxaEm2sKmFD8ABhAgVEKE+W
         ZWMk+nSpBjsbLa+gX+4bxc3d7wqep5MRmmHlxtkv+u+8jdSoIwVLGo/HWv5Jw+NfJVAK
         HbtGMbCv0odqj8Zi24s5AEMyXJcY0xqizA8wcXSX1QZJHTrS8RZUXxPS9EjwgcPZk2Yw
         /Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Rz+Q9TyMwNKKp3Zp/SmxkDCYSutReaKArS9DPZj1vGU=;
        b=0lmkRJuWOVX+MCv+FcXknOj/OKZdnimg0n48ix1eUis9onNzIGHPdY9MFULKSgWXhd
         jAveJTZXugnmgOWzm6TO0+ENRISv9xh3gFiad6osgmCJZD9WwCerLqDkqy4WsVvQkC6l
         PbvcoFdomWV+2uYx0elRI5ncG27kGgaNSPAjJ8iFHik8uztl9pZxJhmSlB5S1c3tnKUp
         hLN7iWhrhUJSiUSmC01+KSiLJ/cB8Eg/VIbpCR6qjQbbm9V+kEaXnthSO4yOSu0tUreK
         y8KUw167QhL6gvOGiXaM8kigGhwi4O5/QmJLvfrj/P2nOrwTMfwum3D+CQ2iangqomx9
         2KLg==
X-Gm-Message-State: AOAM532BkPlBOyqecoVevWCdENZYAh/F5lXjkJqAH7venA9bS4qOBNsw
        YinI65OrtZgRvQ3yxJeI5bp9MlFftL8=
X-Google-Smtp-Source: ABdhPJzSq2utTH0VPA7Dkd+SyWYQFPaB8HjoaVstGsD0PWEELSZCeHQHDlSQBMDOwX83XtxK05I2Fw==
X-Received: by 2002:a17:90a:b288:: with SMTP id c8mr4690410pjr.67.1631996285001;
        Sat, 18 Sep 2021 13:18:05 -0700 (PDT)
Received: from pranay-desktop (2603-8001-9300-332c-0000-0000-0000-092b.res6.spectrum.com. [2603:8001:9300:332c::92b])
        by smtp.gmail.com with ESMTPSA id qe17sm8973154pjb.39.2021.09.18.13.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 13:18:04 -0700 (PDT)
Date:   Sat, 18 Sep 2021 13:18:02 -0700
From:   Pranay Sanghai <pranaysanghai@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/pci/setup-irq.c: Fix up comments.
Message-ID: <YUZJenW2UCA4Qu0O@pranay-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make comments follow multi-line comment conventions. No functional change intended.

Signed-off-by: Pranay Sanghai <pranaysanghai@gmail.com>

---
 drivers/pci/setup-irq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 7129494754dd..ed628771250b 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -28,12 +28,13 @@ void pci_assign_irq(struct pci_dev *dev)
 		return;
 	}
 
-	/* If this device is not on the primary bus, we need to figure out
-	   which interrupt pin it will come in on.   We know which slot it
-	   will come in on 'cos that slot is where the bridge is.   Each
-	   time the interrupt line passes through a PCI-PCI bridge we must
-	   apply the swizzle function.  */
-
+	/*
+	 * If this device is not on the primary bus, we need to figure out
+	 * which interrupt pin it will come in on. We know which slot it
+	 * will come in on 'cos that slot is where the bridge is. Each
+	 * time the interrupt line passes through a PCI-PCI bridge we must
+	 * apply the swizzle function.
+	 */
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	/* Cope with illegal. */
 	if (pin > 4)
@@ -56,7 +57,9 @@ void pci_assign_irq(struct pci_dev *dev)
 
 	pci_dbg(dev, "assign IRQ: got %d\n", dev->irq);
 
-	/* Always tell the device, so the driver knows what is
-	   the real IRQ to use; the device does not use it. */
+	/*
+	 * Always tell the device, so the driver knows what is
+	 * the real IRQ to use; the device does not use it.
+	 */
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
-- 
2.33.0

