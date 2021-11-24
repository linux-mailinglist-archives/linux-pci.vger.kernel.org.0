Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B2C45C96C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 17:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbhKXQDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 11:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347900AbhKXQD1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB22061039;
        Wed, 24 Nov 2021 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637769617;
        bh=PS8BXmc0apnAT5WQtcrX/oVZ1nWh8ZdCVi4swSkcJE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbuwDsEZTEdbOU48GX/bA2wovK54HP7wJyrDotI96cZvBJyHTKsMrO4ovR1Q8ESj/
         c6J/5qW8ePrPgon5n0aMcQ6misKpBcXBXvpE4TFhnnHZtJYhnWeVsylYjlWf88wT4A
         XMwyqiNPdn2xQSxZ71E+CShhjJuHqkrmlNt87Jaj0xdZg5Xi+OgybrhJTAVJS5O1PI
         GthfD3DeWhNJWmk0/wl3LQlqDrsQf1ZzB/7oQ05iZc4K9urW+fBb7jEJjPGAiizE5y
         1PpmTZJedF/JI34abTUZnlo8DJv/WZp/UhB+9OsxqS6b6UrFAp/Bdnl4sol4J/++Fh
         W8/3P+H0LHC7w==
Received: by pali.im (Postfix)
        id 8CD0256D; Wed, 24 Nov 2021 17:00:17 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
Date:   Wed, 24 Nov 2021 16:59:44 +0100
Message-Id: <20211124155944.1290-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124155944.1290-1-pali@kernel.org>
References: <20211124155944.1290-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since all PCI Express device Functions are required to implement the PCI
Express Capability structure, Capabilities List bit in PCI Status Register
must be hardwired to 1b. Capabilities Pointer register (which is already
set by pci-bride-emul.c driver) is valid only when Capabilities List is set
to 1b.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Cc: stable@vger.kernel.org
---
 drivers/pci/pci-bridge-emul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 6c75dc296984..d11633999df5 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -339,6 +339,7 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 
 	if (bridge->has_pcie) {
 		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
+		bridge->conf.status |= cpu_to_le16(PCI_STATUS_CAP_LIST);
 		bridge->pcie_conf.cap_id = PCI_CAP_ID_EXP;
 		bridge->pcie_conf.cap |= cpu_to_le16(PCI_EXP_TYPE_ROOT_PORT << 4);
 		bridge->pcie_cap_regs_behavior =
-- 
2.20.1

