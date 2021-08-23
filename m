Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293E03F4E98
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhHWQlr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 12:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhHWQlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 12:41:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5356613CD;
        Mon, 23 Aug 2021 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629736864;
        bh=5HNjyxwbp2jWfyQHnbfEn3lq/+lQ4qFD7jbtEyHitV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hv6v1BKEgvaUGaswp1pQqZB1BxWaljsjLf+e8DLYgnfJxKdhm9Pdf8cgZKgqNUEC5
         WlHitgS+lF5HmPvE5DKbXie1c2f8fs94VzoIKhvNUS++OiecuVd9GQ6Hc+mPzYP3uK
         ztluzf4T72jYOLTd3jZv5erMdl68WmSmgV9AfaYaXCHvvJkEPMGooI5nT3HLwQGxcv
         4ngXq4XlDNmT/nzs9EIbwFGY+tXvar/LMINGEc92zh/Cs7DIuJx1tANzIia7GKAUMW
         JGXWa2qhE0k/d7I1EUkYfOyxXdLVMUL5a0WDhIXhTFrGwK/5mfnBgT4vfFKniS/+Aa
         L971zI4g2QKbA==
Received: by pali.im (Postfix)
        id A83FCFC2; Mon, 23 Aug 2021 18:41:03 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: aardvark: Enable MSI-X support
Date:   Mon, 23 Aug 2021 18:40:33 +0200
Message-Id: <20210823164033.27491-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210823164033.27491-1-pali@kernel.org>
References: <20210815103624.19528-1-pali@kernel.org>
 <20210823164033.27491-1-pali@kernel.org>
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
index 0e81d7f37465..2c944a04fba8 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1200,7 +1200,7 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 
 	msi_di = &pcie->msi_domain_info;
 	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI;
+			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX;
 	msi_di->chip = msi_ic;
 
 	pcie->msi_inner_domain =
-- 
2.20.1

