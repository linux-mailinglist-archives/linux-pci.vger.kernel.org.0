Return-Path: <linux-pci+bounces-32265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5C0B07669
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631681AA6E2E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822862F5332;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCZIZVf9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4052F50B7;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670585; cv=none; b=sa2ayH7W8eQTX+qBR2NHoQfVMAF48gTXBCgNqNOOsQbGz+MvP6ph26TOUfg5qulBQjJjmIm+ZbkTMlNTHHDnBQb4R6g2Miba9ECkIqFzmcXf5BBCvDLsW4TPQe4GwAJ17ZvCZzC0iAEw1EX1O1X+nPegWc/dwdc/5OsxM/Bd6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670585; c=relaxed/simple;
	bh=49se/cV6QgtAokglmFcczz9Ifzd3nxCW5Sn2n0Qc8cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4TXKC2KoaM0c1XFG/IMa2JUVt62alk0ZR5jvurPwuQWQllM7cTsqL75rUqxjeDUNXDa8NZNlCPRFGNbPrVk/zD3YJKCJ+/njhKp7UtDejPynp7kr/19M7Pj0SSAMriZhd36H9aaP0U4tQ9SJmTDYBpcuxjO61XP7J1JShXqLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCZIZVf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D10E7C4CEFB;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670584;
	bh=49se/cV6QgtAokglmFcczz9Ifzd3nxCW5Sn2n0Qc8cA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XCZIZVf9F9mujtGMeE7PtbcRfjU3tQrNiCDSFTczH7hroWYYGmokqZT92ngb+i1q/
	 v/gj4zheOcphI+6GAjWkUFZHt2l8OaOzHClZI9Uyj4+NDipP2PiIOsC8mw3of7zCyZ
	 jLY7+KTVkTZPYpiDiHoRfCevypNUMudP9kGu41K2DqN3jY9Nd/w2Ah1vMGVPctv4QQ
	 Eykmv7NtmyPVV9GE5rmeVoO3UBQcGg/WpS0eI205XYhBPWUoveJiz/HsCko/CGkiY/
	 r/a/B4mzF/atrEBsylPH9ZbgX5EkkcjKf4/wKwoDrLYj7el3/UMu6/UTyspnMUIXg0
	 dMvv9ef/AW8kA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F4C83F27;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 16 Jul 2025 18:26:22 +0530
Subject: [PATCH 3/6] PCI/ASPM: Improve the kernel-doc for
 pci_disable_link_state*() APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-ath-aspm-fix-v1-3-dd3e62c1b692@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
In-Reply-To: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
 ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>, 
 ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=B9VKKJAdfTeTxxxIgX26hLbY56JMsQhRCw6qWnhJsGw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBod6F2mMxYhWLaZfeExPfHrvfJGSkYizEHM7CpQ
 8Qti9q+oi6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHehdgAKCRBVnxHm/pHO
 9WPGB/9BzzL32x5gdgQQgBO1xt+px2X1J3TuNhPv4s4j0uknjpnIrinkONw0yAA8jblKNU1MM4J
 9GO0/n2fXQk42/YjhSyhLrEXhZvnzVqcEj307CJY721C0rbc5QYClC5tNFRRdqlbyanBAXO3a52
 mJ0CbY7KO5Wz8pxKZTFN08Hg/YML4Vhbi/1nYriFINdR+J0LJZqrZGkYjx7cYk7rhUpfHMyvfTr
 1chKJsI1XoU/K2Z2KOVLGnPe6XWeuRhyds9pEYB+zXYNHntdF4wHgVXfb7dyk/rKrOKx5tU9qDA
 wlI+s6LmIGwxhla/AZ4BtKrhp/GBffKLWArRkvZhVKCzBB7z
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add kernel-doc for pci_disable_link_state_locked() API and fix the
kernel-doc for pci_disable_link_state() API.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c56553de953c158cf9e8bf54c6b358a9a81a2691..4d30e894198c40a168fc03626270b361d5124b67 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1409,6 +1409,19 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 	return 0;
 }
 
+/**
+ * pci_disable_link_state_locked - Disable device's link state
+ * @pdev: PCI device
+ * @state: ASPM link state to disable
+ *
+ * Disable device's link state, so the link will never enter specific states.
+ * Note that if the BIOS didn't grant ASPM control to the OS, this does nothing
+ * because we can't touch the LNKCTL register.
+ *
+ * Context: Caller holds pci_bus_sem read lock.
+ *
+ * Return: 0 on success, a negative errno otherwise.
+ */
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
 	lockdep_assert_held_read(&pci_bus_sem);
@@ -1418,13 +1431,15 @@ int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
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
+ * Disable device's link state, so the link will never enter specific states.
+ * Note that if the BIOS didn't grant ASPM control to the OS, this does nothing
+ * because we can't touch the LNKCTL register.
+ *
+ * Return: 0 on success, a negative errno otherwise.
  */
 int pci_disable_link_state(struct pci_dev *pdev, int state)
 {

-- 
2.45.2



