Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7627E488E46
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiAJBvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:51:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59410 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbiAJBuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D9A660EC8
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11354C36AEF;
        Mon, 10 Jan 2022 01:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779448;
        bh=kenahD9QHhI1ZQq8ramyEU8rD91TP+pCdQ2TzwL2+08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjVn1l3RG6FujezCoqPcY6xIbm2QfHQOlsxanIaMWlkGvg5FNTiRdNb6b3N9foyH1
         sIfGQoWNOrXqmS4Ppoj1WRPXGiFLapIcqD+kfKEGjD84TNtX5CSbdNU/oHyLx4DYg1
         JUm3pBafCtWLdR6+QZq8PNOifwao2Gi+BE2gRlKcMnte2CNYvv9CxnY1Crh97WWfWf
         Axu9Qw4qavXzadNtJt2yXTnZ5fDIqlJjUOPuaUqVRwOoHrAmUaM1UbAe0GQJmQ0/JN
         rE1fM/kaniTOULXhfQPfYOOc3xH7ts9REdwNKSMyMyH3jl8and5V291sRtPHqeHyzc
         5Rjf2nUeNQl4Q==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 12/23] PCI: aardvark: Enable MSI-X support
Date:   Mon, 10 Jan 2022 02:50:07 +0100
Message-Id: <20220110015018.26359-13-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

According to PCI 3.0 specification, sending both MSI and MSI-X interrupts
is done by DWORD memory write operation to doorbell message address. The
write operation for MSI has zero upper 16 bits and the MSI interrupt number
in the lower 16 bits, while the write operation for MSI-X contains a 32-bit
value from MSI-X table.

Since the driver only uses interrupt numbers from range 0..31, the upper
16 bits of the DWORD memory write operation to doorbell message address
are zero even for MSI-X interrupts. Thus we can enable MSI-X interrupts.

Testing proves that kernel can correctly receive MSI-X interrupts from PCIe
cards which supports both MSI and MSI-X interrupts.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 79102704d82f..a892f22510da 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1344,7 +1344,7 @@ static struct irq_chip advk_msi_irq_chip = {
 
 static struct msi_domain_info advk_msi_domain_info = {
 	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI,
+		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
 	.chip	= &advk_msi_irq_chip,
 };
 
-- 
2.34.1

