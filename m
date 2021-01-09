Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322BC2EFED7
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jan 2021 10:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbhAIJyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jan 2021 04:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbhAIJyi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Jan 2021 04:54:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0638021D7A;
        Sat,  9 Jan 2021 09:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610186038;
        bh=f7RcMZZ43vfPCNmsio3Fnk2tSW6CM7+hDzQHp0sNSCc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZVmy0gFy0VZoSjHilruZZwk4EIWo/eBDQ0dsx6HZe9/GXdeACFDCM3aMPBj0HbwRI
         toP3mTKOO1qXkC6lrQqb2W/ur9JDBrlszdBInoNk/rHLrlty1LM1hTg+KbRe9TrhjM
         RIJ0mCFUmgHbrvVW2TjUM/1Nk0T0573iO7RPKBnH/WwZP3scdJTpgi8ELQqL0HiRpO
         o0V0Qxh2JDKOOKiclBYuQ1cmQ2pWHOsRLjrQFIsO+tFlbt91q2gEGTLy3I9LCkwRgK
         fIb3xRjGf9t+l3Edt7NNqhs7DQDgCuB/32YQSdk+QEsh17iTu81obvw2HIWnJi+dx1
         KXMAkpJbc3ZHg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, benh@kernel.crashing.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] PCI: decline to resize resources if boot config must be preserved
Date:   Sat,  9 Jan 2021 10:53:53 +0100
Message-Id: <20210109095353.13417-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The _DSM #5 method in the ACPI host bridge object tells us whether the
OS is permitted to deviate from the resource assignment configured by
the firmware. If this is not the case, we should not permit drivers to
resize BARs on the fly. So make pci_resize_resource() take this into
account.

Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/pci/setup-res.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 43eda101fcf4..3b38be081e93 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -410,10 +410,16 @@ EXPORT_SYMBOL(pci_release_resource);
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 {
 	struct resource *res = dev->resource + resno;
+	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
 	u16 cmd;
 
+	/* Check if we must preserve the firmware's resource assignment */
+	host = pci_find_host_bridge(dev->bus);
+	if (host->preserve_config)
+		return -ENOTSUPP;
+
 	/* Make sure the resource isn't assigned before resizing it. */
 	if (!(res->flags & IORESOURCE_UNSET))
 		return -EBUSY;
-- 
2.17.1

