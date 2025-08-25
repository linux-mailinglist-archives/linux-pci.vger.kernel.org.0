Return-Path: <linux-pci+bounces-34673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A9B34927
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 19:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32054189D7DB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D47308F12;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI4d5GlT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93648303CB2;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143890; cv=none; b=CyEkENJc2gUAS804p9A1X0YoDk5lbRvJuqHFF7zY4FHfP+KkOs0e3wZ+ykzXYePFDKnxhvv41xWacTTNywPGsued9iutL7HT5vhpl/ZQ8OH9iAQowTU+V918lXpzAIjxPswCwJucJMJ7CCfQqNnb4cUUse5zhpTSzjEebhDrw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143890; c=relaxed/simple;
	bh=ZvlrhCwbVGHwCszHJQ3ZLQ8iRWvKvHB5cHlEHKo+skg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a208tEq0My+wLaB1C5SHfcHkYQWOJNmGvwklMqQX+bTuSmdituNZVpiIkkZJ/+IdQdhxqQ3Y2lL3nPW11dlhntsUjEcBEfkdcji73m/fbVcMW6bffkyChegR8s2nOraspxWDkBWpZdlbcKdGY/qRx6lWh8IipIsmiv1i+Zi7E9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI4d5GlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3734DC4CEF1;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143890;
	bh=ZvlrhCwbVGHwCszHJQ3ZLQ8iRWvKvHB5cHlEHKo+skg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SI4d5GlTfUmUduk6M3iXd6lBcDw4xX3b6BB7cMez1lj1aJ651eKSOyt21rEj4Iu+2
	 BdLpWZu0k083HqMKobSfxXBLUAkNcSVJ9VPY4Qoy6jAybr+IKrrlkOC5L0Ik1KnNf7
	 wxujP0hXqAoHGoEXO4OTKl3Zc5HpKl65az32oobXSsKEv3w5APwxqP3466KtJ+v0fn
	 ZYaIih0Cbwtq6Lg3v6/swE2VZWsW+0ZYxx4aMnHrebwi6ezSxFi2eVtywbeGoYvYbw
	 XVHsUlBaSWrehrnIj7Wt8/6pzsxZAzzCT5GexV5eGDY5QMolZPTMQZ3+PHHo7IPWWx
	 NEvXDgv6TcJJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26322CA0EFA;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 25 Aug 2025 23:14:37 +0530
Subject: [PATCH v2 2/8] PCI/ASPM: Fix the behavior of
 pci_enable_link_state*() APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250825-ath-aspm-fix-v2-2-61b2f2db7d89@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
In-Reply-To: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
 ath10k@lists.infradead.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4956;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZbX/P/Tjf8pjL7HPByaCkE9n8aYYv5gDRWCzS63i5A4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorKEOxJ6aeOqgKi7d2p8e9E6vSn9QgBCPg7H7l
 AlQQ0hzDaiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKyhDgAKCRBVnxHm/pHO
 9drpB/0XOkzdkNiuiw9s73/6BgGYyTjbWx1OWr9LvaBjBd3ShgAqfHQaoj3hN1DZihUNBW2HXOn
 tkoQqt2NTgsPPoZ/QNHanSCE30ox/iW/ZWPmC6PPJHcg5kQBw1Iwu4PLVsnNWjBmNbxGTK/oEbM
 Bj/XCvyaVteO1torMSTAyehBeNLhpvmD8Mn5nM4QF0nFuWIYD9Cfr7w5WJ0Lkhr8D8IehD1lAG2
 FonxTNhKNwLS61BZPUUAePAuN0lMqRJFSoiOptS6BwCgyuZbZl4/wyq+hPO8z3nEFFOc2HR4rzm
 pe+yzOBTli2HXIkl3O8qe26rdBDVsVr3ppSoX9xV0WyYhXAn
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

pci_enable_link_state() and pci_enable_link_state_locked() APIs are
supposed to be symmectric with pci_disable_link_state() and
pci_disable_link_state_locked() APIs.

But unfortunately, they are not symmetric. This behavior was mentioned in
the kernel-doc of these APIs:

" Clear and set the default device link state..."

and

"Also note that this does not enable states disabled by
pci_disable_link_state()"

These APIs won't enable all the states specified by the 'state' parameter,
but only enable the ones not previously disabled by the
pci_disable_link_state*() APIs. But this behavior doesn't align with the
naming of these APIs, as they give the impression that these APIs will
enable all the specified states.

To resolve this ambiguity, allow these APIs to enable the specified states,
regardeless of whether they were previously disabled or not. This is
accomplished by clearing the previously disabled states from the
'link::aspm_disable' parameter in __pci_enable_link_state() helper. Also,
reword the kernel-doc to reflect this behavior.

The current callers of pci_enable_link_state_locked() APIs (vmd and
pcie-qcom) did not disable the ASPM states before calling this API. So it
is evident that they do not depend on the previous behavior of this API and
intend to enable all the specified states.

And the other API, pci_enable_link_state() doesn't have a caller for now,
but will be used by the 'atheros' WLAN drivers in the subsequent commits.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index be9bd272057c3472f3e31dc9568340b19d52012a..fac46113a90c7fac6c97125e6a7e385045780005 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1459,6 +1459,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	link->aspm_default = pci_calc_aspm_enable_mask(state);
+	link->aspm_disable &= ~state;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
@@ -1471,17 +1472,18 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 }
 
 /**
- * pci_enable_link_state - Clear and set the default device link state so that
- * the link may be allowed to enter the specified states. Note that if the
- * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
- * touch the LNKCTL register. Also note that this does not enable states
- * disabled by pci_disable_link_state(). Return 0 or a negative errno.
+ * pci_enable_link_state - Enable device's link state
+ * @pdev: PCI device
+ * @state: Mask of ASPM link states to enable
+ *
+ * Enable device's link state, so the link will enter the specified states.
+ * Note that if the BIOS didn't grant ASPM control to the OS, this does
+ * nothing because we can't touch the LNKCTL register.
  *
  * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
  * PCIe r6.0, sec 5.5.4.
  *
- * @pdev: PCI device
- * @state: Mask of ASPM link states to enable
+ * Return: 0 on success, a negative errno otherwise.
  */
 int pci_enable_link_state(struct pci_dev *pdev, int state)
 {
@@ -1490,19 +1492,20 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
 EXPORT_SYMBOL(pci_enable_link_state);
 
 /**
- * pci_enable_link_state_locked - Clear and set the default device link state
- * so that the link may be allowed to enter the specified states. Note that if
- * the BIOS didn't grant ASPM control to the OS, this does nothing because we
- * can't touch the LNKCTL register. Also note that this does not enable states
- * disabled by pci_disable_link_state(). Return 0 or a negative errno.
+ * pci_enable_link_state_locked - Enable device's link state
+ * @pdev: PCI device
+ * @state: Mask of ASPM link states to enable
+ *
+ * Enable device's link state, so the link will enter the specified states.
+ * Note that if the BIOS didn't grant ASPM control to the OS, this does
+ * nothing because we can't touch the LNKCTL register.
  *
  * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
  * PCIe r6.0, sec 5.5.4.
  *
- * @pdev: PCI device
- * @state: Mask of ASPM link states to enable
- *
  * Context: Caller holds pci_bus_sem read lock.
+ *
+ * Return: 0 on success, a negative errno otherwise.
  */
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 {

-- 
2.45.2



