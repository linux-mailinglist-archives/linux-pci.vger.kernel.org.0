Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6AE42A9C5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJLQoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhJLQoD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:44:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2425661050;
        Tue, 12 Oct 2021 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056922;
        bh=BfB4Eyv4w7WVLqCssx7tl6Wbemp0+DEE9PVBGtT/asg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6o4ZN9sSZBtSIxP73/qLJL7yCng1XyRyj5SlpJD26KU0T/I/avEZ0rH71vlRgJG5
         ry/POhlvodxI0Rth/eivjxD56/d8jByPMmxT21/I4K8HmQKCXbzcTR/nhevzYvbIxc
         Kvd+GqbEz0v32kLS7i2xZ8ALsRz4OZ2wHkzvRymAkQsXmhqRwuqjQ6HaY5t4smVAUb
         Qin17YzhNAbpMQTYPcIE6/bLuwfqwkWj7gmxXz6uj2I1pvIBMGZieC+bjMgTNDd1Oc
         pL8SJq2MvTCDxEyJipHFpKpZ6mTWTm2jWn9jl3rbuVVgXYipuVqr0k4MSg31CDafHx
         7AsZV5G15FW5g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Date:   Tue, 12 Oct 2021 18:41:41 +0200
Message-Id: <20211012164145.14126-11-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
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
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b703b271c6b1..337b61508799 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1274,7 +1274,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 
 	msi_di = &pcie->msi_domain_info;
 	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI;
+			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
 	msi_di->chip = msi_ic;
 
 	pcie->msi_inner_domain =
-- 
2.32.0

