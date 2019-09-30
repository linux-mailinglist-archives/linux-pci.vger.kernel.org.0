Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7697C1A1B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 04:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfI3CJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Sep 2019 22:09:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38441 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfI3CJI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Sep 2019 22:09:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so2819266plq.5
        for <linux-pci@vger.kernel.org>; Sun, 29 Sep 2019 19:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MQ9C5D2pIjxtgzo4yVQfpILkEUvZWmVx5Oo69HXIq8=;
        b=Tf6eIchYTJJ6HB8+pDvWoFPPKt6DXO80N10eIjs++8R+5WcAvRpfNxZjm6StUBipWj
         7R/Qw9qhqeoUuxUAZTpFKrhuVjFsGyJuPhWPlkX1tGIf6TRudciGXsxHaaPtjjRSIdyO
         7Pkr3T/dUl37GYzU8sLMP2NCEQnqGPk3zBHc22vSOykwQSUNIujJeBORffA/cR2Tdbna
         g5z6Xow/QI72KxWBMs6eNkdLh2oRCcAw62mcwYj/LtTP6UqldwjUgo7thmHXTIfoRoiA
         SFeEeXM/qOQshMdJbkfCuvBmTFEx6yK1wmHAlWzXige09TX3iucC4P5nY1WfFnyDatg6
         fkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MQ9C5D2pIjxtgzo4yVQfpILkEUvZWmVx5Oo69HXIq8=;
        b=sn8OBw+Swt5JDNaB8UQRaLDcrrlamPXeQkd5NVxdZszQaa/cfaRkMClwabRo7t6zLs
         0LkL/+1ZK++KdlI/H1jj2kOhSDeCGiCPK0tocOxlNCF7bHmR0z65blAvbRW40cbcvzy1
         d7a7ZOegwBcZMpMFL6iAkM5OBsygpqM0tMnPCAeEfM3Q0Zk++NSkNONwowB6obhwjZiG
         mGa34KqcAex9lBint7f51f3TQmiABCQr5EJ3+yMqL4isSfhywbQj5UQfvNZbErkdlazr
         WRlboddHmFfrQ8tlonrA5B8Z2mP4bpjHNAS8vqeVK58XaNj03paoUXYJyELZzFCh4/UF
         McZA==
X-Gm-Message-State: APjAAAVJMyFUCkPLZH0dBBWhq2W9edq2SSeiVUQbAHIwyGe27MQbX9Bj
        aX1av4v7j0/cN8xIysrAtWcep/ir
X-Google-Smtp-Source: APXvYqyE9QwN95Qw7WOIU+JPp5GuMXB6QLQNlk86LK1sujLh/uxthmQzCx6Dwxoc0VVF61UdtdkwUQ==
X-Received: by 2002:a17:902:b789:: with SMTP id e9mr18178242pls.88.1569809347711;
        Sun, 29 Sep 2019 19:09:07 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id x72sm11450733pfc.89.2019.09.29.19.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 19:09:07 -0700 (PDT)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     aik@ozlabs.ru, shawn@anastas.io, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] powerpc/pci: Fix pcibios_setup_device() ordering
Date:   Mon, 30 Sep 2019 12:08:47 +1000
Message-Id: <20190930020848.25767-3-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930020848.25767-1-oohall@gmail.com>
References: <20190930020848.25767-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shawn Anastasio <shawn@anastas.io>

Move PCI device setup from pcibios_add_device() and pcibios_fixup_bus() to
pcibios_bus_add_device(). This ensures that platform-specific DMA and IOMMU
setup occurs after the device has been registered in sysfs, which is a
requirement for IOMMU group assignment to work

This fixes IOMMU group assignment for hotplugged devices on pseries, where
the existing behavior results in IOMMU assignment before registration.

Thanks to Lukas Wunner <lukas@wunner.de> for the suggestion.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/kernel/pci-common.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 1c448cf..b89925ed 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -261,12 +261,6 @@ int pcibios_sriov_disable(struct pci_dev *pdev)
 
 #endif /* CONFIG_PCI_IOV */
 
-void pcibios_bus_add_device(struct pci_dev *pdev)
-{
-	if (ppc_md.pcibios_bus_add_device)
-		ppc_md.pcibios_bus_add_device(pdev);
-}
-
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
@@ -987,15 +981,17 @@ static void pcibios_setup_device(struct pci_dev *dev)
 		ppc_md.pci_irq_fixup(dev);
 }
 
-int pcibios_add_device(struct pci_dev *dev)
+void pcibios_bus_add_device(struct pci_dev *pdev)
 {
-	/*
-	 * We can only call pcibios_setup_device() after bus setup is complete,
-	 * since some of the platform specific DMA setup code depends on it.
-	 */
-	if (dev->bus->is_added)
-		pcibios_setup_device(dev);
+	/* Perform platform-specific device setup */
+	pcibios_setup_device(pdev);
+
+	if (ppc_md.pcibios_bus_add_device)
+		ppc_md.pcibios_bus_add_device(pdev);
+}
 
+int pcibios_add_device(struct pci_dev *dev)
+{
 #ifdef CONFIG_PCI_IOV
 	if (ppc_md.pcibios_fixup_sriov)
 		ppc_md.pcibios_fixup_sriov(dev);
@@ -1037,9 +1033,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 
 	/* Now fixup the bus bus */
 	pcibios_setup_bus_self(bus);
-
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-- 
2.9.5

