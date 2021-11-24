Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7B45C966
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347843AbhKXQDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 11:03:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347753AbhKXQDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 825DB60FE8;
        Wed, 24 Nov 2021 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637769613;
        bh=VXSfT/cANOiXuUEMFLXHx6/U4GCMwDVVgwNHrmLGdt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s67aemG2pnX4YkUi0il3IPyVIwQAPHI1LBKN07N9yi9XsvodW6blAQZcKI6bm1s9G
         tYePBBQPapOdmBnZwMVOjAyjgGic5usokjRWjyByIrJUpPxaycHxpScf45SSuqH5r8
         eURUzqBn5AzXIZixx1Ja6AfVPNJjHmfLCs0npt+J0APNrFoHCQNAwjbtCh78uezjZ3
         x/WpRaENz20QzevtG1dSi4wS5Ufe+Zok9pgf0mJw1/J5U0LvHKptHH5ZlkD62kHxLl
         5UN/Dg8glFSKz70q4/sFcuUVUo6vCfbbKYDCl6k53Jx+1wSADok1e30SCNS5rwdBQZ
         qLBoB57KSo9YQ==
Received: by pali.im (Postfix)
        id B1036AFB; Wed, 24 Nov 2021 17:00:11 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] PCI: pci-bridge-emul: Make expansion ROM Base Address register read-only
Date:   Wed, 24 Nov 2021 16:59:39 +0100
Message-Id: <20211124155944.1290-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124155944.1290-1-pali@kernel.org>
References: <20211124155944.1290-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If expansion ROM is unsupported (which is the case of pci-bridge-emul.c
driver) then ROM Base Address register must be implemented as read-only
register that return 0 when read, same as for unused Base Address
registers.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Cc: stable@vger.kernel.org
---
 drivers/pci/pci-bridge-emul.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index db97cddfc85e..5de8b8dde209 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -139,8 +139,13 @@ struct pci_bridge_reg_behavior pci_regs_behavior[PCI_STD_HEADER_SIZEOF / 4] = {
 		.ro = GENMASK(7, 0),
 	},
 
+	/*
+	 * If expansion ROM is unsupported then ROM Base Address register must
+	 * be implemented as read-only register that return 0 when read, same
+	 * as for unused Base Address registers.
+	 */
 	[PCI_ROM_ADDRESS1 / 4] = {
-		.rw = GENMASK(31, 11) | BIT(0),
+		.ro = ~0,
 	},
 
 	/*
-- 
2.20.1

