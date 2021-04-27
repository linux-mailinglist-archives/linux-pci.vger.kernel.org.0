Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D327D36C47D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 12:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhD0K4t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 06:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235803AbhD0K4t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 06:56:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C19613B0;
        Tue, 27 Apr 2021 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619520966;
        bh=P3sk/jdvdGbo8a4NLyXLQdNK5bliTYyVm9EmJOM7/24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0GiYa98NeCaeYsF0ydEe3dQhBgPRtgLHlolscO/xEhE49EQ2kv2PdJ8mHsfBRdTO
         6N0FFeHx4cfei6d7+taD1dW04B2Y/ywNRhbiSp6UY75t2djMTFQaIpRQHjZekmt99m
         vqsFPpYGO+1bjiaaXN6BRNsjio9pBIa52KVSdkcP/+ED2rux4NCyvm+NtWqdCwKve0
         9WFE5WqGe0O+1ZavAWrnvquqkRI67G4zadr63rYt7u5PCBsoRvm3OELGOph/7RPpQ4
         8SWXoSpRiseMimkHG2Rm/Sm02X3ELfzY3TfLbEjPSCAbdbnLMyVahsvUXsUrE8hKz0
         Jk5Fw/Ec50GbA==
Received: by pali.im (Postfix)
        id D2C3B791; Tue, 27 Apr 2021 12:56:00 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Disallow retraining link for Atheros chips on non-Gen1 PCIe bridges
Date:   Tue, 27 Apr 2021 12:55:25 +0200
Message-Id: <20210427105525.23277-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326124326.21163-1-pali@kernel.org>
References: <20210326124326.21163-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Atheros AR9xxx and QCA98xx chips do not behave not only after a bus reset
but also after doing retrain link when PCIe bridge is not in GEN1 mode at
2.5 GT/s speed.

QCA9880 and QCA9890 chips throw a Link Down event and completely disappear
from the bus and their config space is not accessible again.

AR9390 chip throws a Link Down event followed by Link Up event, config
space is accessible again, but contains nonsense values. PCI device ID is
0xABCD which indicates HW bug that chip itself was not able to read values
from internal EEPROM/OTP.

AR9287 chip throws also Link Down and Link Up events, also has accessible
config space and moreover its config space contains correct values. But
ath9k driver cannot initialize card from this state as it is unable to
access HW registers. This also indicates that chip iself was not able to
read values from internal EEPROM/OTP.

This issue related to PCI device ID 0xABCD and reading internal EEPROM/OTP
was previously discussed at ath9k-devel mailing list in following thread:

https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html

After experiments we come up with workaround that Retrain link can be
called only when using GEN1 PCIe bridge or when PCIe bridge has forced link
speed to 2.5 GT/s via PCI_EXP_LNKCTL2 register.

This issue was reproduced with more cards: Compex WLE900VX (QCA9880 based /
device ID 0x003c), Compex WLE200NX (AR9287 based / device ID 0x002e),
"noname" card (QCA9890 based / device ID 0x003c) and Wistron NKR-DNXAH1
(AR9390 based / device ID 0x0030) on Armada 385 with pci-mvebu.c driver and
also on Armada 3720 with pci-aardvark.c driver.

To workaround this issue, this change introduces a new PCI quirk called
PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1 which is enabled for all
Atheros chips with PCI_DEV_FLAGS_NO_BUS_RESET quirk, plus also for Atheros
chip AR9287.

When this quirk is set then kernel disallows triggering PCI_EXP_LNKCTL_RL
bit in config space of PCIe Bridge in case PCIe Bridge is capable of higher
speed than 2.5 GT/s and higher speed is already allowed. When PCIe Bridge
has accessible LNKCTL2 register then kernel tries to force target link
speed via PCI_EXP_LNKCTL2_TLS* bits to 2.5 GT/s. After this change it is
possible to trigger PCI_EXP_LNKCTL_RL bit without causing issues on
problematic Atheros cards.

Currently only PCIe ASPM kernel code triggers this PCI_EXP_LNKCTL_RL bit,
so quirk check is added only into pcie/aspm.c file.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Marek Behún <kabel@kernel.org>
BugLink: https://lore.kernel.org/linux-pci/87h7l8axqp.fsf@toke.dk/
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=84821
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=192441
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209833
Cc: stable@vger.kernel.org # c80851f6ce63a ("PCI: Add PCI_EXP_LNKCTL2_TLS* macros")

---
Changes since v1:
* Move whole quirk code into pcie_downgrade_link_to_gen1() function
* Reformat to 80 chars per line where possible
* Add quirk also for cards with AR9287 chip (PCI ID 0x002e)
* Extend commit message description and add information about 0xABCD
---
 drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c    | 37 ++++++++++++++++++++++++++--------
 include/linux/pci.h     |  2 ++
 3 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ac0557a305af..729b0389562b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -192,12 +192,56 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
+static int pcie_downgrade_link_to_gen1(struct pci_dev *parent)
+{
+	u16 reg16;
+	u32 reg32;
+	int ret;
+
+	/* Check if link is capable of higher speed than 2.5 GT/s */
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &reg32);
+	if ((reg32 & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
+		return 0;
+
+	/* Check if link speed can be downgraded to 2.5 GT/s */
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
+	if (!ret) {
+		/* Verify that new value was really set */
+		pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &reg16);
+		if ((reg16 & PCI_EXP_LNKCTL2_TLS) != PCI_EXP_LNKCTL2_TLS_2_5GT)
+			ret = -EINVAL;
+	}
+
+	if (ret) {
+		pci_err(parent, "ASPM: Changing Target Link Speed to 2.5 GT/s failed: %d\n", ret);
+		return ret;
+	}
+
+	pci_info(parent, "ASPM: Target Link Speed changed to 2.5 GT/s due to quirk\n");
+	return 0;
+}
+
 static bool pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
 	unsigned long end_jiffies;
 	u16 reg16;
 
+	if ((link->downstream->dev_flags & PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1) &&
+	    pcie_downgrade_link_to_gen1(parent)) {
+		pci_err(parent, "ASPM: Retrain Link at higher speed is disallowed by quirk\n");
+		return false;
+	}
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..68c5e8f4ff8c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3553,23 +3553,44 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
 			mellanox_check_broken_intx_masking);
 
-static void quirk_no_bus_reset(struct pci_dev *dev)
+static void quirk_no_bus_reset_and_no_retrain_link(struct pci_dev *dev)
 {
-	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
+	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET |
+			  PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1;
 }
 
 /*
- * Some Atheros AR9xxx and QCA988x chips do not behave after a bus reset.
+ * Atheros AR9xxx and QCA98xx chips do not behave after a bus reset and also
+ * after retrain link when PCIe bridge is not in GEN1 mode at 2.5 GT/s speed.
  * The device will throw a Link Down error on AER-capable systems and
  * regardless of AER, config space of the device is never accessible again
  * and typically causes the system to hang or reset when access is attempted.
+ * Or if config space is accessible again then it contains only dummy values
+ * like fixed PCI device ID 0xABCD or values not initialized at all.
+ * Retrain link can be called only when using GEN1 PCIe bridge or when
+ * PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 register.
+ * To reset these cards it is required to do PCIe Warm Reset via PERST# pin.
  * https://lore.kernel.org/r/20140923210318.498dacbd@dualc.maya.org/
+ * https://lore.kernel.org/r/87h7l8axqp.fsf@toke.dk/
+ * https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
  */
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x002e,
+			 quirk_no_bus_reset_and_no_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030,
+			 quirk_no_bus_reset_and_no_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032,
+			 quirk_no_bus_reset_and_no_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033,
+			 quirk_no_bus_reset_and_no_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034,
+			 quirk_no_bus_reset_and_no_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c,
+			 quirk_no_bus_reset_and_no_retrain_link);
+
+static void quirk_no_bus_reset(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
+}
 
 /*
  * Root port on some Cavium CN8xxx chips do not successfully complete a bus
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

