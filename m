Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E863F3684
	for <lists+linux-pci@lfdr.de>; Sat, 21 Aug 2021 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhHTWiz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 18:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHTWiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 18:38:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F55C061575;
        Fri, 20 Aug 2021 15:38:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 7so9859809pfl.10;
        Fri, 20 Aug 2021 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQcz+2FzjEqJW3y7S5p5YhpDCjJxSJUiIhM3qvCMviE=;
        b=e5SwyfWmDgQqvOhIB1NJqTEl+jkLbrX47VrxWT0ZEj7PPUzgE736gYyXRsX2I2kdxV
         XfRKeaBnUejM8V9AinNP4BPvpYdmiNEyruUryRbOiHGUbsMbtKObfGlipaJGwLx8oQ9W
         P4xilj+Xt9pSZ1Q68gafi8UqcXfZGexRV4D03T3wNpT6JQmlX/1zHRxYOF31rQJXC8QK
         e4aq1khd+I5HnmtT+fpT5cvZtMSdLSkxWGf96CTtObG4fc5wclTpnthrY9/dKaezDd8e
         U+K6b5oZcv3DeeVaM92rIn/U9ThokliBt4MR7UsYP51/wa14aVxeKHz7Viw4R5cBQAUH
         h7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQcz+2FzjEqJW3y7S5p5YhpDCjJxSJUiIhM3qvCMviE=;
        b=ZcNQnPuST9D7e/Qt48sjeV39x5euOB9jUW10hCCmLbS1q0Y9hyiZaIzn7DUMn2J/Ro
         A4JH7pvV87LhqkVp6ixM2LozNpJK7DKgARXVExCZCeU6Q/5IzAKzizwf+xUFZLtGhtJ6
         ovr+Z3LqLGVBkcZqU4Wk4u5gwtRS+NXXOk4/EfvnJMkddD8ZgIpwOljkNmiolyAMz9gC
         rh+pQHURMHvTz/AlrpJfn5kZm+qUeQyYlyFQubi2CKQvGTeNkpSkFXdGcDjv5QDxklES
         U7tn+7i7UUbIKOQipdNNc1Nuq5kIAWwj7c8UmFXMsaTlvp216LVCgShfOd90OhKgLHmr
         n9Jw==
X-Gm-Message-State: AOAM5312sXmE4hOLvV3GwTjxGC+9MRdzBKKvnhWWW2pI1XJbTQ9B0gVH
        DGPIQCboLhCK6gJCumiQ2dc=
X-Google-Smtp-Source: ABdhPJxoNC9VXLIks0r+12kDS37RPW2GhvgFAxOLZ1+G/lgTHHxc32/q2tGJJNj5/fh0ZwrY+mHfKg==
X-Received: by 2002:aa7:9dce:0:b0:3e1:3c5d:640d with SMTP id g14-20020aa79dce000000b003e13c5d640dmr21513004pfq.25.1629499096196;
        Fri, 20 Aug 2021 15:38:16 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:a761:e8b4:dc09:1a0e])
        by smtp.gmail.com with ESMTPSA id y12sm8807619pgl.65.2021.08.20.15.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:38:15 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     21cnbao@gmail.com, bhelgaas@google.com, corbet@lwn.net
Cc:     Jonathan.Cameron@huawei.com, bilbao@vt.edu,
        gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        song.bao.hua@hisilicon.com
Subject: [PATCH v2 1/2] PCI/MSI: Fix the confusing IRQ sysfs ABI for MSI-X
Date:   Sat, 21 Aug 2021 10:37:43 +1200
Message-Id: <20210820223744.8439-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820223744.8439-1-21cnbao@gmail.com>
References: <20210820223744.8439-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

/sys/bus/pci/devices/.../irq sysfs ABI is very confusing at this
moment especially for MSI-X cases. While MSI sets IRQ to the first
number in the vector, MSI-X does nothing for this though it saves
default_irq in msix_setup_entries(). Weird the saved default_irq
for MSI-X is never used in pci_msix_shutdown(), which is quite
different with pci_msi_shutdown(). Thus, this patch moves to show
the first IRQ number which is from the first msi_entry for MSI-X.
Hopefully, this can make IRQ ABI more clear and more consistent.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/pci/msi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9232255..6bbf81b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -771,6 +771,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	int ret;
 	u16 control;
 	void __iomem *base;
+	struct msi_desc *desc;
 
 	/* Ensure MSI-X is disabled while it is set up */
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
@@ -814,6 +815,10 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
+
+	desc = first_pci_msi_entry(dev);
+	dev->irq = desc->irq;
+
 	return 0;
 
 out_avail:
@@ -1024,6 +1029,7 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msix_enabled = 0;
+	dev->irq = entry->msi_attrib.default_irq;
 	pcibios_alloc_irq(dev);
 }
 
-- 
1.8.3.1

