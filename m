Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E7B45C963
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 17:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbhKXQDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 11:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347727AbhKXQDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2303260FDC;
        Wed, 24 Nov 2021 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637769613;
        bh=+klZEg8cA08uh4bc6ofaYAGc0ZPqBd8yxdNwlPu5IKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJiT6o6H4QoTBfDR2Xr/fIopg/TKMlabqKMGnVWeCb7h/vY0RKLupGU7s+KukptEA
         E/KbN0pxgSKMzX176vS7EyiV3Nx0taKDIao81y6A6keujFwzXjXneNsmPzwaYSg6N7
         WJujyEip+bhWFgaWxpGIp0pF+LHjpjU3KEecTz7OxhsqwAb8UrNJoLinW0CigTEwan
         DBarQ+f9ifoevObpN0MYzHB2X/ISCnKJ9WBApf4IKyXR0dNWIwMglLWyTXoZb7pADG
         HZRclH8StiwutidwRcZgNqAK/J4bsArjsANVw+xx/TFwKHQGN2VuxBlREzGWozCd6s
         plgdSDcQjcSJw==
Received: by pali.im (Postfix)
        id D64B056D; Wed, 24 Nov 2021 17:00:12 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config space
Date:   Wed, 24 Nov 2021 16:59:40 +0100
Message-Id: <20211124155944.1290-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124155944.1290-1-pali@kernel.org>
References: <20211124155944.1290-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some bits in PCI config space are reserved when device is PCIe. Properly
define behavior of PCI registers for PCIe emulated bridge and ensure that
it would not be possible change these reserved bits.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Cc: stable@vger.kernel.org
---
 drivers/pci/pci-bridge-emul.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 5de8b8dde209..0cbb4e3ca827 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -295,6 +295,27 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 			kfree(bridge->pci_regs_behavior);
 			return -ENOMEM;
 		}
+		/* These bits are applicable only for PCI and reserved on PCIe */
+		bridge->pci_regs_behavior[PCI_CACHE_LINE_SIZE / 4].ro &=
+			~GENMASK(15, 8);
+		bridge->pci_regs_behavior[PCI_COMMAND / 4].ro &=
+			~((PCI_COMMAND_SPECIAL | PCI_COMMAND_INVALIDATE |
+			   PCI_COMMAND_VGA_PALETTE | PCI_COMMAND_WAIT |
+			   PCI_COMMAND_FAST_BACK) |
+			  (PCI_STATUS_66MHZ | PCI_STATUS_FAST_BACK |
+			   PCI_STATUS_DEVSEL_MASK) << 16);
+		bridge->pci_regs_behavior[PCI_PRIMARY_BUS / 4].ro &=
+			~GENMASK(31, 24);
+		bridge->pci_regs_behavior[PCI_IO_BASE / 4].ro &=
+			~((PCI_STATUS_66MHZ | PCI_STATUS_FAST_BACK |
+			   PCI_STATUS_DEVSEL_MASK) << 16);
+		bridge->pci_regs_behavior[PCI_INTERRUPT_LINE / 4].rw &=
+			~((PCI_BRIDGE_CTL_MASTER_ABORT |
+			   BIT(8) | BIT(9) | BIT(11)) << 16);
+		bridge->pci_regs_behavior[PCI_INTERRUPT_LINE / 4].ro &=
+			~((PCI_BRIDGE_CTL_FAST_BACK) << 16);
+		bridge->pci_regs_behavior[PCI_INTERRUPT_LINE / 4].w1c &=
+			~(BIT(10) << 16);
 	}
 
 	if (flags & PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR) {
-- 
2.20.1

