Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB6215EDB9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 18:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbgBNQFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 11:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390220AbgBNQFo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D108217F4;
        Fri, 14 Feb 2020 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696344;
        bh=J8OSz6X/3CfAu5lvqon5+DI7TzDJwMi7/bF87DT5l6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtAUQJo691gQaqWErPe1/30diaoUzllrSTSctq61EsvXo910xU3SUauykuj5M9GxO
         L7VGrDcrxhZiOGQXQbbkxozKidxjqTzrccBfyzPBvIq4NUAtoQBEp/4FhiYA0QhbNg
         R8zkfNbrJq88D2nfVvnqUQv1wsgwh6GBvcHd6mNU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 179/459] PCI: Add generic quirk for increasing D3hot delay
Date:   Fri, 14 Feb 2020 10:57:09 -0500
Message-Id: <20200214160149.11681-179-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

[ Upstream commit 62fe23df067715a21c4aef44068efe7ceaa8f627 ]

Separate the D3 delay increase functionality out of quirk_radeon_pm() into
its own function so that it can be shared with other quirks, including the
AMD Ryzen XHCI quirk that will be introduced in a followup commit.

Tweak the function name and message to indicate more clearly that the delay
relates to a D3hot-to-D0 transition.

Link: https://lore.kernel.org/r/20191127053836.31624-1-drake@endlessm.com
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7afbce082d83e..5c863af9452ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1871,16 +1871,21 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2609, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
 
+static void quirk_d3hot_delay(struct pci_dev *dev, unsigned int delay)
+{
+	if (dev->d3_delay >= delay)
+		return;
+
+	dev->d3_delay = delay;
+	pci_info(dev, "extending delay after power-on from D3hot to %d msec\n",
+		 dev->d3_delay);
+}
+
 static void quirk_radeon_pm(struct pci_dev *dev)
 {
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
-	    dev->subsystem_device == 0x00e2) {
-		if (dev->d3_delay < 20) {
-			dev->d3_delay = 20;
-			pci_info(dev, "extending delay after power-on from D3 to %d msec\n",
-				 dev->d3_delay);
-		}
-	}
+	    dev->subsystem_device == 0x00e2)
+		quirk_d3hot_delay(dev, 20);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
 
-- 
2.20.1

