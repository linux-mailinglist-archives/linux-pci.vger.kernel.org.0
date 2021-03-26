Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7309934A780
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 13:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhCZMoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 08:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhCZMoG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 08:44:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89CB961934;
        Fri, 26 Mar 2021 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616762645;
        bh=epXzz5EdeBcKJtt84doD3MjxaFxXg0K4xpUlN/qscHs=;
        h=From:To:Cc:Subject:Date:From;
        b=rX5b3yfyxL/cY8ut0THFRwMvU0Zbu85FAL7Vt/r9rFv5K7Z/D4NBIictd77rd33mh
         zy5h+xoShLSeDNqLnHPw8VTKrrhj+GKRGdMhjwkFP9t+VsXH9A35MDgrFEvz1NbKIo
         vMBFw8YbQFPNLFApqUX/v1HNB6OE2e5JAE0fOwAnRz8Qu/rm1UnyYnhioysj/YP2de
         fclAzFyVOsfXA+ISJoUZGheB2p/hHWp9I4pGwIJW6QVb3zyh0sZAzqC5yXiulCpD/9
         fK8eB2It4m8jlLxxtZAWBk7VGTbI+KtMURyl63Ye6/EILpQiGO5qxFgDRM/HWkYGn1
         1anMHOZ519kMQ==
Received: by pali.im (Postfix)
        id E316B842; Fri, 26 Mar 2021 13:44:02 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Disallow retraining link for Atheros QCA98xx chips on non-Gen1 PCIe bridges
Date:   Fri, 26 Mar 2021 13:43:26 +0100
Message-Id: <20210326124326.21163-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Atheros QCA9880 and QCA9890 chips do not behave after a bus reset and also
after retrain link when PCIe bridge is not in GEN1 mode at 2.5 GT/s speed.
The device will throw a Link Down error and config space is not accessible
again. Retrain link can be called only when using GEN1 PCIe bridge or when
PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 register.

This issue was reproduced with more Compex WLE900VX cards (QCA9880 based)
on Armada 385 with pci-mvebu.c driver and also on Armada 3720 with
pci-aardvark.c driver. Also this issue was reproduced with some "noname"
card with QCA9890 WiFi chip on Armada 3720. All problematic cards with
these QCA chips have PCI device id 0x003c.

Tests showed that other WiFi cards based on AR93xx (PCI device id 0x0030)
and AR9287 (PCI device id 0x002e) chips do not have these problems.

To workaround this issue, this change introduces a new PCI quirk called
PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1 for PCI device id 0x003c.

When this quirk is set then kernel disallows triggering PCI_EXP_LNKCTL_RL
bit in config space of PCIe Bridge in case PCIe Bridge is capable of higher
speed than 2.5 GT/s and higher speed is already allowed. When PCIe Bridge
has accessible LNKCTL2 register then kernel tries to force target link
speed via PCI_EXP_LNKCTL2_TLS* bits to 2.5 GT/s. After this change it is
possible to trigger PCI_EXP_LNKCTL_RL bit without causing issues on
problematic Atheros QCA98xx cards.

Currently only PCIe ASPM kernel code triggers this PCI_EXP_LNKCTL_RL bit,
so quirk check is added only into pcie/aspm.c file.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Marek Behún <kabel@kernel.org>
Link: https://lore.kernel.org/linux-pci/87h7l8axqp.fsf@toke.dk/
Cc: stable@vger.kernel.org # c80851f6ce63a ("PCI: Add PCI_EXP_LNKCTL2_TLS* macros")
---
 drivers/pci/pcie/aspm.c | 43 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c    | 15 +++++++++++++-
 include/linux/pci.h     |  2 ++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..ea5bdf6107f6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -192,11 +192,54 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
+static int pcie_change_tls_to_gen1(struct pci_dev *parent)
+{
+	u16 reg16;
+	u32 reg32;
+	int ret;
+
+	/* Check if link speed can be forced to 2.5 GT/s */
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &reg32);
+	if (!(reg32 & PCI_EXP_LNKCAP2_SLS_2_5GB)) {
+		pci_err(parent, "ASPM: Bridge does not support changing Link Speed to 2.5 GT/s\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Force link speed to 2.5 GT/s */
+	ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_TLS,
+						 PCI_EXP_LNKCTL2_TLS_2_5GT);
+	if (ret == 0) {
+		/* Verify that new value was really set */
+		pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &reg16);
+		if ((reg16 & PCI_EXP_LNKCTL2_TLS) != PCI_EXP_LNKCTL2_TLS_2_5GT)
+			ret = -EINVAL;
+	}
+
+	if (ret != 0)
+		pci_err(parent, "ASPM: Changing Target Link Speed to 2.5 GT/s failed: %d\n", ret);
+
+	return ret;
+}
+
 static bool pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
 	unsigned long end_jiffies;
 	u16 reg16;
+	u32 reg32;
+
+	if (link->downstream->dev_flags & PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1) {
+		/* Check if link is capable of higher speed than 2.5 GT/s and needs quirk */
+		pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &reg32);
+		if ((reg32 & PCI_EXP_LNKCAP_SLS) > PCI_EXP_LNKCAP_SLS_2_5GB) {
+			if (pcie_change_tls_to_gen1(parent) != 0) {
+				pci_err(parent, "ASPM: Retrain Link at higher speed is disallowed by quirk\n");
+				return false;
+			}
+			pci_info(parent, "ASPM: Target Link Speed changed to 2.5 GT/s due to quirk\n");
+		}
+	}
 
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..8ff690c7679d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3558,6 +3558,11 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
 }
 
+static void quirk_no_bus_reset_and_no_retrain_link(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET | PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1;
+}
+
 /*
  * Some Atheros AR9xxx and QCA988x chips do not behave after a bus reset.
  * The device will throw a Link Down error on AER-capable systems and
@@ -3567,10 +3572,18 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
 
+/*
+ * Atheros QCA9880 and QCA9890 chips do not behave after a bus reset and also
+ * after retrain link when PCIe bridge is not in GEN1 mode at 2.5 GT/s speed.
+ * The device will throw a Link Down error and config space is not accessible
+ * again. Retrain link can be called only when using GEN1 PCIe bridge or when
+ * PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 register.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset_and_no_retrain_link);
+
 /*
  * Root port on some Cavium CN8xxx chips do not successfully complete a bus
  * reset when used with certain child devices.  After the reset, config
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..fdbf7254e4ab 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -227,6 +227,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	/* Don't Retrain Link for device when bridge is not in GEN1 mode */
+	PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1 = (__force pci_dev_flags_t) (1 << 12),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.20.1

