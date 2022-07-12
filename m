Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D16571317
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiGLH2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLH2X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 03:28:23 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD989966D;
        Tue, 12 Jul 2022 00:28:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E90473F1B5;
        Tue, 12 Jul 2022 07:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657610900;
        bh=UyZK7Orb0Bim2JnAzw9A1mIijTKG4S9P8UhKOOskABQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=BDSK0hlx0zUeIkBsU12L5qlRho8wJ8vXEXtk6gjoA08jT1FsiM7CO7FWpfGofhA2w
         F9qJ8zu3LlgtEkI1GY3jbt7waHGTFkf+mbZeHvjpkEidVpQki1ZpEFOPZX1zuUXmir
         /EzKZ5fOn2sIVx8SBG1CHPWWxCDwrPmxPkhi2N4FySQl6UIpnCV4w9cIuL7EQ6yUqo
         SpFbYV8V0TRgAbq7feKuYpMX7xgrFEng7Ic4xWahK70MndbI4BO4mRS9Q0pJ4Jrmr5
         Iv3YG4MrX2TjL4wWpLLJESHZCQSCJN+oyfTTln/IgTdFrRoNv5gDUFdIT6ZeUKxxuR
         Ny3zaf8uR6cLA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/MSI: Clear MSI/MSI-X on resume if it's not enabled
Date:   Tue, 12 Jul 2022 15:24:48 +0800
Message-Id: <20220712072455.148512-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI/MSI-X can have garbage data after system resume.

Before suspend:
Capabilities: [a0] MSI: Enable- Count=1/4 Maskable- 64bit+
	Address: 0000000000000000  Data: 0000
Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
	Vector table: BAR=5 offset=00042000
	PBA: BAR=5 offset=00043000

After resume:
Capabilities: [a0] MSI: Enable+ Count=128/4 Maskable- 64bit+
	Address: fffffffffffffffc  Data: ffff
Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
	Vector table: BAR=5 offset=00042000
	PBA: BAR=5 offset=00043000

So clear the MSI/MSI-X config on resume to ensure it's not enabled
unintentionally.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216242
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/msi/msi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 9037a7827eca7..cf8374a877f3f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -263,8 +263,12 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	struct msi_desc *entry;
 	u16 control;
 
-	if (!dev->msi_enabled)
+	if (!dev->msi_enabled) {
+		if (dev->msi_cap)
+			pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, 0);
+
 		return;
+	}
 
 	entry = irq_get_msi_desc(dev->irq);
 
@@ -295,8 +299,12 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 	struct msi_desc *entry;
 	bool write_msg;
 
-	if (!dev->msix_enabled)
+	if (!dev->msix_enabled) {
+		if (dev->msix_cap)
+			pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, 0);
+
 		return;
+	}
 
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
-- 
2.36.1

