Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D2FF21A0
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 23:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbfKFWZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 17:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbfKFWZm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 17:25:42 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341A721848;
        Wed,  6 Nov 2019 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573079142;
        bh=4oc5GVAOqhLsNNVeJWSPpy36QsbUzSTu6fOqxyLp4JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvKkJE/UwWIz+zJYb40wq8kiXbuHCTCDp5pi7pYSQC1w5SGmmkaUI96tOquwIfCAN
         REidiPtmivEBNh8otNI4SZmh2723ZCdElWtT+xUT0OtWvW9jD77EpWmgbf12cmChCi
         xGOBBKue83py/1v7lqzBSXpw/Yt1SsRVtMYzE/v0=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/5] PCI: Allow building PCIe things without PCIEPORTBUS
Date:   Wed,  6 Nov 2019 16:24:21 -0600
Message-Id: <20191106222420.10216-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106222420.10216-1-helgaas@kernel.org>
References: <20191106222420.10216-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Some things in drivers/pci/pcie (aspm.c and ptm.c) do not depend on the
PCIe portdrv, so we should be able to build them even if PCIEPORTBUS is not
selected.  Remove the PCIEPORTBUS guard from building pcie/.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 28cdd8c0213a..522d2b974e91 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
 				   setup-bus.o vc.o mmap.o setup-irq.o
 
+obj-$(CONFIG_PCI)		+= pcie/
+
 ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= slot.o
@@ -15,7 +17,6 @@ endif
 
 obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
-obj-$(CONFIG_PCIEPORTBUS)	+= pcie/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_PCI_ATS)		+= ats.o
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

