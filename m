Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CDA3F7331
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbhHYK2X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbhHYK2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 06:28:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C3C0612A7;
        Wed, 25 Aug 2021 03:27:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j1so16219021pjv.3;
        Wed, 25 Aug 2021 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Hqnln3HdL0WChaMVZJV3NfQHnyWbPcdyPecsMvr5Us=;
        b=fOILSbqp+awgPaL++axkQEnUahaAtyLCDiX4urN0z2R+EBI/Xfjm7BfwaYI8ko/xhc
         BViZ+JAunCMhIGCV136n0JrrlSuHYIiSPTQRdPOYugQYHmB1mmgyEPTvHlBO2Fy94MnG
         3LK4urvh6THaKPpoQMPtONHXg5uJu5iCkIDiubmIMLTpIJPtr00iSi4TK1Og4hM+pcZr
         R1O5UkGKZU9pqlfCJdTP6KrwjZn2yy2dj+1Z67KmUi3k2GdiuiPnugIKp8Ym2NaF85zb
         LwIXAZ6GNxQM1ePUEhLP5YcV7gmZE2KImrYUwbtt0sjWWTfFyK7M8hpJEABOiFCVAM3H
         PeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Hqnln3HdL0WChaMVZJV3NfQHnyWbPcdyPecsMvr5Us=;
        b=mTqpy8L/izcGLgk/5HAfer6lovyfP0ddr58hufLQY7XS0nMlhG3WuzGN51XhTSzANS
         Vj3iQ6WcGayu/K3ixDyQV7+iaW5TLcnRNalkB+MrjLsiapp74ULu/YIWGFywEzVVXVra
         Zlqsve5BZTWdAUfd6cffRyMh9FE7VVtdtSFdkdj1zHpuBHI6M03+9AjQv+YXqOfDs2Zi
         X1YxKfa2s+ouwdEmqPxAcZNfSKJwi8GHNWIwELJUlrLY0J/4Y/ZdpRUJn69fNspUP7S5
         uu9K4UB8WvkD5gEvhv4/5JRfN3pfW32bsNj3dSNd4RXyQwdykKX6oEYtOS6J93UnNE39
         haBA==
X-Gm-Message-State: AOAM5300+svPL4XTNvJBUsiY5bFMLAIbL+JQCH+SSe0uR+sYIwNDwFpZ
        8dfTf7/1kluM8fqRC+fyqgw=
X-Google-Smtp-Source: ABdhPJyXguS1J/c/czIWiobBg3C1WJe0NJ4d50A3Pyb+FXU2dT8FSoGhw/YqB+/uPfL+mAMZ9M1OYg==
X-Received: by 2002:a17:90a:b785:: with SMTP id m5mr9976134pjr.213.1629887231933;
        Wed, 25 Aug 2021 03:27:11 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id f23sm1786403pfa.94.2021.08.25.03.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:27:11 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bhelgaas@google.com, maz@kernel.org, tglx@linutronix.de
Cc:     Jonathan.Cameron@huawei.com, bilbao@vt.edu, corbet@lwn.net,
        gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v3 2/3] PCI/sysfs: Don't depend on pci_dev.irq for IRQ entry
Date:   Wed, 25 Aug 2021 18:26:35 +0800
Message-Id: <20210825102636.52757-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825102636.52757-1-21cnbao@gmail.com>
References: <20210825102636.52757-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

Explicitly use IRQ number from MSI list for IRQ sysfs entry. Then sysfs
will decouple with the odd implementation depending on pci_dev.irq.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/pci/pci-sysfs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7bbf2673..f5a06b9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
 #include <linux/pm_runtime.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include "pci.h"
 
@@ -49,7 +50,27 @@ static DEVICE_ATTR_RO(field)
 pci_config_attr(subsystem_device, "0x%04x\n");
 pci_config_attr(revision, "0x%02x\n");
 pci_config_attr(class, "0x%06x\n");
-pci_config_attr(irq, "%u\n");
+
+static ssize_t irq_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+#ifdef CONFIG_PCI_MSI
+	/*
+	 * For MSI, return the 1st IRQ in IRQ vector; for all other cases
+	 * including MSI-X, return legacy INTx
+	 */
+	if (pdev->msi_enabled) {
+		struct msi_desc *desc = first_pci_msi_entry(pdev);
+
+		return sysfs_emit(buf, "%u\n", desc->irq);
+	}
+#endif
+
+	return sysfs_emit(buf, "%u\n", pdev->irq);
+}
+static DEVICE_ATTR_RO(irq);
 
 static ssize_t broken_parity_status_show(struct device *dev,
 					 struct device_attribute *attr,
-- 
1.8.3.1

