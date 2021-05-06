Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7D375768
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhEFPfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235733AbhEFPd4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6239A616EB;
        Thu,  6 May 2021 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315175;
        bh=OfK0Hzd2grREpBUN2tgkKBXXxq0n8pt4CmtN6wgcHqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxvXQjeGDG52+9/+e+/YCQVhh/+CyB4udA90afhFAk4JgSh0rlqlReB/76rR29MGv
         vBDOcLPuyYji99nUxMGs8MAQUs/CfjqBrFQOGlyZhzlOYCbPzRbIry4N7MjK2vm/EA
         JDVDfKK2dnc+LAB+qDx1EgUc5Nu5xKxITmadGS5S3KfVwke50Ng+RcNJ76OIlu8ng+
         bsDkyoCFMHt7GefKFLcuvZFd2rL7DeKWVGppdOPLgzBioxhdc3kvTAHwnh/ixTsL+q
         mlNpCgHwVaJ/7x95QkS4aPN7lMjXKeOqXlDAdoi1F2WtQB8TMYpLxd4lC2R4msPxx8
         cfmoxHdbeaqRA==
Received: by pali.im (Postfix)
        id 1AC5E89A; Thu,  6 May 2021 17:32:55 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 37/42] PCI: aardvark: Replace custom PCIE_CORE_INT_* macros by linux PCI_INTERRUPT_* values
Date:   Thu,  6 May 2021 17:31:48 +0200
Message-Id: <20210506153153.30454-38-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Header file linux/pci.h defines enum pci_interrupt_pin with corresponding
interrupt PCI_INTERRUPT_* values.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d99462d99ed8..2258b9ae1084 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -34,10 +34,7 @@
 #define PCIE_CORE_DEV_REV_REG					0x8
 #define PCIE_CORE_PCIEXP_CAP					0xc0
 #define PCIE_CORE_PCIERR_CAP					0x100
-#define     PCIE_CORE_INT_A_ASSERT_ENABLE			1
-#define     PCIE_CORE_INT_B_ASSERT_ENABLE			2
-#define     PCIE_CORE_INT_C_ASSERT_ENABLE			3
-#define     PCIE_CORE_INT_D_ASSERT_ENABLE			4
+
 /* PIO registers base address and register offsets */
 #define PIO_BASE_ADDR				0x4000
 #define PIO_CTRL				(PIO_BASE_ADDR + 0x0)
@@ -706,7 +703,7 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
 
 	/* Support interrupt A for MSI feature */
-	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
+	bridge->conf.intpin = PCI_INTERRUPT_INTA;
 
 	bridge->has_pcie = true;
 	bridge->data = pcie;
-- 
2.20.1

