Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2C445932
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 19:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhKDSEP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234037AbhKDSEP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 14:04:15 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7016120D;
        Thu,  4 Nov 2021 18:01:37 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mih3P-003WTf-70; Thu, 04 Nov 2021 18:01:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rui Salvaterra <rsalvaterra@gmail.com>, kernel-team@android.com
Subject: [PATCH 2/2] PCI: Add MSI masking quirk for Nvidia ION AHCI
Date:   Thu,  4 Nov 2021 18:01:30 +0000
Message-Id: <20211104180130.3825416-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211104180130.3825416-1-maz@kernel.org>
References: <20211104180130.3825416-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de, rsalvaterra@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ION AHCI device pretends that MSI masking isn't a thing,
while it actually implements it and needs MSIs to be unmasked
to work. Add a quirk to that effect.

Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com
---
 drivers/pci/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4537d1ea14fd..89c7c99cd1bb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5795,3 +5795,9 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
-- 
2.30.2

