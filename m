Return-Path: <linux-pci+bounces-34671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F2B3491D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 19:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C53A2C83
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC936305E33;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDKkY/D5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4871EFF9B;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143890; cv=none; b=u0tdjV1IQ/PJc+akc56/YtQGW5Tfs/CScHThN21/KHvidZHAds9Z/71EwoSCk2dtNep51czMZOId0XdLRkKJBd8odwlhERcTji5j8rtEQbNkAfwTGAYU6fgsFsFFEjSE9WrDlXEAa+eqWLqbWldhFgRNPXnQukRHaNKpSdcXxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143890; c=relaxed/simple;
	bh=u+j1MWZrVDMnA0nN2hd703dpVLMQhCSZUL4OYJmX1Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWq0Tt9ffDsz5yUJxC9qZ8PppQBEo/oyHHTjjOej5S+2cbMcLS9kTg4ZvnNtKoqy2hXULZSoo+S26VcEnNs+awKSe/ueoRrQmwiwfmhpSqZltdQSQLOq7BrlgxMS9osyHJF7lVg6oC7uglT1StZ96S5WAv6o4WDMYoaEhT9TwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDKkY/D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26246C113D0;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143890;
	bh=u+j1MWZrVDMnA0nN2hd703dpVLMQhCSZUL4OYJmX1Iw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JDKkY/D5iZoD0kVKUsBTL0e8MYxmuawMMJvAeqNP7YhOQN3wTellFdvhGjMRrI5l5
	 VN9F09nL7C9t6pODn1tZS5Xc+qAHuVl+iRRnFSXIzuDPLB2CmaawMvpyinbWXQIG9g
	 VMpCFUNfMMishrwV2EF4W4YkL5Jm8C3JJxhcUmSlHvqUo9FFR1n8f/Niqo2fMwAxgZ
	 uAd4GNql8Jhn1Z6THTI2FCQcvtFlMWwSAX1Opawak3KxvDPCkUqdnbMZCuu7wOYFg7
	 zbbwSGjqDuWGs+7hzMk7pCMaNNsBB1hbpTGIHGD4HvYAQk6JzUbSxH/nuNgtjRqiV7
	 dR/o39cctmCjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1481FCA0FE7;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 25 Aug 2025 23:14:36 +0530
Subject: [PATCH v2 1/8] PCI/ASPM: Always disable ASPM when driver requests
 it
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250825-ath-aspm-fix-v2-1-61b2f2db7d89@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4409;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=XteWgzQLE4FB1d7fUUtWPfDxXr3Zn7uGZ3PNAO/OJ1o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorKEOInbYm5tl5KOPLP0FAuBz7q4CEGOPyc+H8
 JnnTv9G2EeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKyhDgAKCRBVnxHm/pHO
 9ZWBB/4v7fVw7cQpZhIlei/tgmZsW671sNE/em0HNodv96mg1pNd6NIEv76mCwcqsQW9WXZzu1P
 A1Rfn/XV4mJI7DIrfGI80bYvM8hFz5iWdD93TpVpfS9KKTf9BveX3sBJ7CBy7dCdqDqWtMBtxd9
 RGoFOQB5Zr5yNNBnUfZ1kP4F3Q2lAvzzOaOqUiTwf1Rb66K3OJidg5WrDX2XVgAxXlbh+s3dqgx
 rKa605QyAAvQHUpIZTxVYoqBxXpFE1Y0B5sW2TdcGODrN9aR4kT1GoBkuj5pgOyT6bZnXvj9Q09
 iUHx/0rrCwBlMdlO4njgBUYwkx4sySg5EXZNY6rLq3wPz9UT
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

PCI core/ASPM service driver allows controlling ASPM state through
pci_disable_link_state() API. It was decided earlier (see the Link
below), to not allow ASPM changes when OS does not have control over it
but only log a warning about the problem 'commit 2add0ec14c25 ("PCI/ASPM:
Warn when driver asks to disable ASPM, but we can't do it")'.

A number of drivers have added workarounds to force ASPM off with own
writes into the Link Control Register (some even with comments
explaining why PCI core does not disable it under some circumstances).
According to the comments, some drivers require ASPM to be off for
reliable operation.

Having custom ASPM handling in drivers is problematic because the state
kept in the ASPM service driver is not updated by the changes made
outside the link state management API.

As the first step to address this issue, make pci_disable_link_state()
to unconditionally disable ASPM so the motivation for drivers to come
up with custom ASPM handling code is eliminated.

To fully take advantage of the ASPM handling core provides, the drivers
that need to quirk ASPM have to be altered depend on PCIEASPM and the
custom ASPM code is removed. This is to be done separately. As PCIEASPM
is already behind EXPERT, it should be no problem to limit disabling it
for configurations that do not require touching ASPM.

Make pci_disable_link_state() function comment to comply kerneldoc
formatting while changing the description.

Link: https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com/
Link: https://lore.kernel.org/all/20230511131441.45704-1-ilpo.jarvinen@linux.intel.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[mani: commit message fixup]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 919a05b9764791c3cc469c9ada62ba5b2c405118..be9bd272057c3472f3e31dc9568340b19d52012a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1381,16 +1381,23 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 		return -EINVAL;
 	/*
 	 * A driver requested that ASPM be disabled on this device, but
-	 * if we don't have permission to manage ASPM (e.g., on ACPI
+	 * if we might not have permission to manage ASPM (e.g., on ACPI
 	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
-	 * the _OSC method), we can't honor that request.  Windows has
-	 * a similar mechanism using "PciASPMOptOut", which is also
-	 * ignored in this situation.
+	 * the _OSC method), previously we chose to not honor disable
+	 * request in that case. Windows has a similar mechanism using
+	 * "PciASPMOptOut", which is also ignored in this situation.
+	 *
+	 * Not honoring the requests to disable ASPM, however, led to
+	 * drivers forcing ASPM off on their own. As such changes of ASPM
+	 * state are not tracked by this service driver, the state kept here
+	 * became out of sync.
+	 *
+	 * Therefore, honor ASPM disable requests even when OS does not have
+	 * ASPM control. Plain disable for ASPM is assumed to be slightly
+	 * safer than fully managing it.
 	 */
-	if (aspm_disabled) {
-		pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n");
-		return -EPERM;
-	}
+	if (aspm_disabled)
+		pci_warn(pdev, "OS doesn't have ASPM control, disabling ASPM anyway\n");
 
 	if (!locked)
 		down_read(&pci_bus_sem);
@@ -1417,13 +1424,13 @@ int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 EXPORT_SYMBOL(pci_disable_link_state_locked);
 
 /**
- * pci_disable_link_state - Disable device's link state, so the link will
- * never enter specific states.  Note that if the BIOS didn't grant ASPM
- * control to the OS, this does nothing because we can't touch the LNKCTL
- * register. Returns 0 or a negative errno.
- *
+ * pci_disable_link_state - Disable device's link state
  * @pdev: PCI device
  * @state: ASPM link state to disable
+ *
+ * Disable device's link state so the link will never enter specific states.
+ *
+ * Return: 0 or a negative errno
  */
 int pci_disable_link_state(struct pci_dev *pdev, int state)
 {

-- 
2.45.2



