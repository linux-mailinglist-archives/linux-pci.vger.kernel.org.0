Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0B3EB572
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhHMM1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHMM1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 08:27:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3988FC061756;
        Fri, 13 Aug 2021 05:27:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l11so11736593plk.6;
        Fri, 13 Aug 2021 05:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJxkE2wkJq+QgJn112ZtChVb7MaeOYwvtc3bN2p1tTg=;
        b=rsM63gA8Ke+q7OOmBS5bZp/+xQPASbpbS2dehshnFn+vjWgOcu8yP5YcfLQE3aq7n5
         pbwlwoIIWZ05Pmk91JkBLx9S3Bw80wDFlOF5pnecDofoWJBORuuoC3zeGKX/q5KNsX8S
         0AuqQCm7EnhCAlzJ5pIw6geleL4JXw7wmf0smSK9zQLEI4L62zK1+lGd6BxLYEKnEFPt
         VYhfWUUzcC448IDgIenx9/Ph6sAfJKy2VrdpTtFhjH6NbJSjOgc1M7Rw2OhWjmn6IbQw
         Ni46Lc0hjA9aDNOeSdl1znTp/aNhGN1xBJPQ6MEKPj2V7mBkDPr4gKkemJFKm9ryQAZ3
         iX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJxkE2wkJq+QgJn112ZtChVb7MaeOYwvtc3bN2p1tTg=;
        b=HCHgV3EVh3+lHRPot/M5iRQRzDfC3UeWVypveLf2dvfKMXjcVBj8mdblBIjLduX6FK
         4EqQUQ3/hFQtqQxQ8d/9B8iBjIbbonKfBsSRJIi6quI6tGsa0jbHyeJ+f82ixrLK0KhT
         6OMgmvBci1nvZHJTpKBvm8RYTVqsahRme1k4CywX1NNFp7X8QpBoaLw9lyACmfSxFkLx
         8TgDi+A7KlMeLd9NNXftgA5Z9VDG5dfLLQ7jTQIvmDGDoBwqfWFbRTLFfZL7sNve+bWj
         C8TrN732fo+3UrmgYfCPGKq/f+xOixOz/VyDiDsoKhjIMKNHk4moormGNJN5N6EcE6RO
         gvQw==
X-Gm-Message-State: AOAM531eHFgfS2grf3gu3ikc0XTY45IpKXy6+BW+R9Nx3XiPJ6nKIqbk
        szRL1QVTyC3x4dUvwfTqFoU=
X-Google-Smtp-Source: ABdhPJzr9deUC5KetbUoge6dxu/lJuhGJtQDTpk8G4TR7fvnQj/s7kpkntZWUGZGM0AgSqKq2fVZhA==
X-Received: by 2002:a17:90a:4285:: with SMTP id p5mr2409655pjg.162.1628857626705;
        Fri, 13 Aug 2021 05:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:f39c:9aee:21bf:36f5])
        by smtp.gmail.com with ESMTPSA id b10sm2218293pfi.122.2021.08.13.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 05:27:06 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, leon@kernel.org,
        schnelle@linux.ibm.com, bilbao@vt.edu, luzmaximilian@gmail.com,
        linuxarm@huawei.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] PCI/MSI: Clarify the irq sysfs ABI for PCI devices
Date:   Sat, 14 Aug 2021 00:26:50 +1200
Message-Id: <20210813122650.25764-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

/sys/bus/pci/devices/.../irq has been there for many years but it has never
been documented. This patch is trying to document it. Plus, irq ABI is very
confusing at this moment especially for MSI and MSI-x cases. MSI sets irq
to the first number in the vector, but MSI-X does nothing for this though
it saves default_irq in msix_setup_entries(). Weird the saved default_irq
for MSI-X is never used in pci_msix_shutdown(), which is quite different
with pci_msi_shutdown(). Thus, this patch also moves to show the first IRQ
number which is from the first msi_entry for MSI-X. Hopefully, this can
make irq ABI more clear and more consistent.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 8 ++++++++
 drivers/pci/msi.c                       | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 793cbb7..8d42385 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -96,6 +96,14 @@ Description:
 		This attribute indicates the mode that the irq vector named by
 		the file is in (msi vs. msix)
 
+What:		/sys/bus/pci/devices/.../irq
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		Historically this attribute represent the IRQ line which runs
+		from the PCI device to the Interrupt controller. With MSI and
+		MSI-X, this attribute is the first IRQ number of IRQ vectors.
+
 What:		/sys/bus/pci/devices/.../remove
 Date:		January 2009
 Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
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

