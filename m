Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960AE37573D
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhEFPdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235342AbhEFPdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA553613F0;
        Thu,  6 May 2021 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315167;
        bh=32yCzHDa56snda7ATUWNvJbqe/MsTwnPQCq/ie/OGr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErP9yH2LeaLujgtbGKxp68ZDWKMB5jm3IzZKTGPGq57lXpdi1Uz9yB3tuNZI7xzOi
         3HWxx5zBi6YrfRWBq2q+lnsOk7FmJJUNqtIYsFivu3f8+CpUdBwfuRgzAb16/QdLbo
         QLeTQLBUW9dv6MKE8rWczzA8sLjOtSoIYdyCnYmOyruViTgGcqyfr3pVDm00V83Wd+
         ZL3xWLWFQFTfcGU+2khFew7h2SITYsJQ9e0FVAhegAkCbD9UDNLn5wiy429Npgzri/
         65iQ5ppEaKjSPwHD4O9goaqCvT1egTE07zyD5v70Esz3kOGhZwBUcC2DqPZsVXARgS
         NyhFTU5ue79gw==
Received: by pali.im (Postfix)
        id 6A68010CD; Thu,  6 May 2021 17:32:45 +0200 (CEST)
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
Subject: [PATCH 05/42] PCI: pci-bridge-emul: Add PCIe Root Capabilities Register
Date:   Thu,  6 May 2021 17:31:16 +0200
Message-Id: <20210506153153.30454-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is 16-bit register at offset 0x1E. Rename current 'rsvd' struct member
to 'rootcap'.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Cc: stable@vger.kernel.org # e0d9d30b7354 ("PCI: pci-bridge-emul: Fix big-endian support")
---
 drivers/pci/pci-bridge-emul.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
index b31883022a8e..49bbd37ee318 100644
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -54,7 +54,7 @@ struct pci_bridge_emul_pcie_conf {
 	__le16 slotctl;
 	__le16 slotsta;
 	__le16 rootctl;
-	__le16 rsvd;
+	__le16 rootcap;
 	__le32 rootsta;
 	__le32 devcap2;
 	__le16 devctl2;
-- 
2.20.1

