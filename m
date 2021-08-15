Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90973EC89D
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbhHOKhj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 06:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237633AbhHOKhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 06:37:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92DF160232;
        Sun, 15 Aug 2021 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629023813;
        bh=rPiIwRm+CKYXp9gDBxDxt2hBbr7OjSe6cRjprH/7pm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reyiEFHb2J6TMiFRcNBH7pIrgi3sJxRocTjHBrObZv8g9zv2Iue3KP9n2mVak1j9A
         3g/L3+eqPUU5T8nk731A5Qw+i7wFyTaW52FoaQS6FudNt7VUDAsZ/SAGyc8d7g2XL/
         sqMXvJU/t/xi01jULpzggXrRGb9DwhbaBaIlMKLwzS97xI88oMlluprr1IByk4SUi4
         JQ95HbqFjtVQu14n2l03J3/6f6ag69BSCDvHsylwEsmWA6S5jcMq8gYN0pc2tn713X
         sINA0zUrTIrfGqWpZrX6Ar0SKEeL7iMRdLWQsIl5p0y1F0ijh9BvV+RTpUSb7QawbW
         d4MyQM7xD4Rag==
Received: by pali.im (Postfix)
        id 555F298C; Sun, 15 Aug 2021 12:36:53 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: aardvark: Enable MSI-X support
Date:   Sun, 15 Aug 2021 12:36:24 +0200
Message-Id: <20210815103624.19528-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210815103624.19528-1-pali@kernel.org>
References: <20210815103624.19528-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCI 3.0 specification, sending both MSI and MSI-X interrupts
is done by DWORD memory write operation to doorbell message address. The
write operation for MSI has zero upper 16 bits and the MSI interrupt number
in the lower 16 bits. The write operation for MSI-X contains a 32-bit value
from MSI-X table.

As driver supports and assigns only interrupt numbers from range 0..31,
enable also MSI-X support.

Testing proved that kernel can correctly receive MSI-X interrupts from PCIe
cards which supports both MSI and MSI-X interrupts.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 96580e1e4539..279b2884c545 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1161,7 +1161,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 
 	msi_di = &pcie->msi_domain_info;
 	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI;
+			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
 	msi_di->chip = msi_ic;
 
 	pcie->msi_inner_domain =
-- 
2.20.1

