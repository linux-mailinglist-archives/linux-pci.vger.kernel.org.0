Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05F1366D86
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbhDUOEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 10:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243236AbhDUOEN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Apr 2021 10:04:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9399C6144B;
        Wed, 21 Apr 2021 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013820;
        bh=JecW3OWOa/52Dy6/jTvDzbnxIVJGN4rSAt7UZvBojxg=;
        h=From:To:Cc:Subject:Date:From;
        b=LjZ0xP/zaAXt7qtNqHNBh1eEgA3HKE6JCW5HZI0nT83VAQeoLypsrlm9rNcjjgBgR
         6IfUlQ+JKY2KHb2LZFiN2GHqSflzwAYgSMuWozwAd+CzfbSvvQgDcU+03SzsgS2JRP
         mR4TgMKitfIGTwW7P64BZEJyhUtq4fKnvSqBvDTTCYj858HQGJiS2Gd7QIwnSkTWRE
         wMogR7uQq4Phj1qq87v/8UZddeEtqyRelGbt3NdwQhp5MaCUgzMj7smLbbAA8bZ46f
         fRglqtaxL9nYUXV5gIKQBOgpHMq98pJ8qY/y/g8VYTVuH7IyKe06jkz6KpFk/AJJMF
         7enzmUMhfPXeQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/VPD: fix unused pci_vpd_set_size function warning
Date:   Wed, 21 Apr 2021 16:03:27 +0200
Message-Id: <20210421140334.3847155-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only user of this function is now in an #ifdef, causing
a warning when that symbol is not defined:

drivers/pci/vpd.c:289:13: error: 'pci_vpd_set_size' defined but not used [-Werror=unused-function]
  289 | static void pci_vpd_set_size(struct pci_dev *dev, size_t len)

Move the function into that #ifdef block.

Fixes: f349223f076e ("PCI/VPD: Remove pci_set_vpd_size()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/vpd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 6909253bb13c..ee8c41a88548 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -286,17 +286,6 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 	return ret ? ret : count;
 }
 
-static void pci_vpd_set_size(struct pci_dev *dev, size_t len)
-{
-	struct pci_vpd *vpd = dev->vpd;
-
-	if (!vpd || len == 0 || len > PCI_VPD_MAX_SIZE)
-		return;
-
-	vpd->valid = 1;
-	vpd->len = len;
-}
-
 static const struct pci_vpd_ops pci_vpd_ops = {
 	.read = pci_vpd_read,
 	.write = pci_vpd_write,
@@ -482,6 +471,17 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
 
+static void pci_vpd_set_size(struct pci_dev *dev, size_t len)
+{
+	struct pci_vpd *vpd = dev->vpd;
+
+	if (!vpd || len == 0 || len > PCI_VPD_MAX_SIZE)
+		return;
+
+	vpd->valid = 1;
+	vpd->len = len;
+}
+
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
 	int chip = (dev->device & 0xf000) >> 12;
-- 
2.29.2

