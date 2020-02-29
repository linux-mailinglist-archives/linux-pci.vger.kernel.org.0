Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3201744A7
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 04:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB2DHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 22:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB2DHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 22:07:31 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D36562467B;
        Sat, 29 Feb 2020 03:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582945651;
        bh=k5NwHrWEieKFCAahxQ2mBl7JL9RU365PWXXzYz13YOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EULNDcdg9sbHLQaqKGYG09Hu5EGIYjUMHTJPINjkx4LuEFtnFgHbsJL42xsNPoLyz
         LBmlQhkOweecLBzxq8SEsAHJM/tW6ZZ5oR9f5NDF1fgv9l8CT9AXwIaIDIx6/2K7lk
         0Hrjhn5w2yzP+0G9mfZHFGx+MGIW1KKvbzDOwOHM=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jay Fang <f.fangjian@huawei.com>, huangdaode@huawei.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 4/4] PCI: Add PCIE_LNKCAP2_SLS2SPEED() macro
Date:   Fri, 28 Feb 2020 21:07:06 -0600
Message-Id: <20200229030706.17835-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200229030706.17835-1-helgaas@kernel.org>
References: <20200229030706.17835-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Add PCIE_LNKCAP2_SLS2SPEED macro for transforming raw Link Capabilities 2
values to the pci_bus_speed. This is next to PCIE_SPEED2MBS_ENC() to make
it easier to update both places when adding support for new speeds.

Link: https://lore.kernel.org/r/1581937984-40353-10-git-send-email-yangyicong@hisilicon.com
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 17 ++++-------------
 drivers/pci/pci.h |  9 +++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 421587badecf..e79cccbbdd39 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5784,19 +5784,10 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
-	if (lnkcap2) { /* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB)
-			return PCIE_SPEED_32_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
-			return PCIE_SPEED_16_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
-			return PCIE_SPEED_8_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
-			return PCIE_SPEED_5_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
-			return PCIE_SPEED_2_5GT;
-		return PCI_SPEED_UNKNOWN;
-	}
+
+	/* PCIe r3.0-compliant */
+	if (lnkcap2)
+		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01f5d7f449a5..75d027ecfbcd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -292,6 +292,15 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
 
+/* PCIe link information from Link Capabilities 2 */
+#define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
+	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_5_0GB ? PCIE_SPEED_5_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_2_5GB ? PCIE_SPEED_2_5GT : \
+	 PCI_SPEED_UNKNOWN)
+
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
 	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
-- 
2.25.0.265.gbab2e86ba0-goog

