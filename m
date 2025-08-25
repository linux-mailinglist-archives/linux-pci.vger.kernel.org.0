Return-Path: <linux-pci+bounces-34670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636FB34920
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 19:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A107D18940B2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB43305E3B;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaVFuumN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54B301014;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143890; cv=none; b=Iz65409iAQwGCwS8RWnqDZZnfC6WTOHAyc/hkiDPqWFxC8SfOQ665iuGr/iIbfhSYPefODRn4c0Mwryv954jSZsg+8c0TIEo/PzlQ7ZUGVUcO8t2BiVnXFZaFvfX823d1gSddM8B5x91I6V1/NLI9+fu0vXbLv12TNihkyy1ix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143890; c=relaxed/simple;
	bh=ScdUxidEQcv0lLc6SYd7NOOa4CGgpMbRHWOtssqifAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H6q6VAidaYB6lulqoK6DGe47Lq68wQX1I9SxFh+R7LnP8P437uLI51AVbgn3SgcIMwskuC+mDQ/FHcQscxiLEdOEx5D9ukmWTr+dRbcQOwWwWd0krA9z8KQVO7YWD+F5WeL3IRbULW+MmF8gJBcUUo7A9jl4KORqrSu6xH2pwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaVFuumN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16D90C4CEED;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143890;
	bh=ScdUxidEQcv0lLc6SYd7NOOa4CGgpMbRHWOtssqifAA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aaVFuumNcS8ldf8vllqWbA17oLQDhY0ipMOSpVs7yPZCRxiMvvDw6e6krzhqP8DzG
	 nJaa787//XLeZvA6iZJ9hJ0fNbk1OEdp7qYj6231w5MSvqfx4X16bjoBIU4ybXBVpO
	 9L0850LPcsWcJvDOiffrINoWfzWNrahO42CKPTq3ml59Ip+rgb9GnYQMxZ7zot3Wex
	 sJaXubIsFS0fc+SmYrC/d0j1/WMB9xu1jVTSWXA1t4wuRABU2KCCJEZu7uXlYMiNcy
	 RejhlNj/T1nwiRJR0+RmBMwSbJ6o96l7fKe/jFoSCAQ1H3eoPCAcCsdkGDNccvvWk3
	 0ZNob9Grxfniw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0380BCA0EED;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/8] PCI/ASPM: Fix pci_enable_link_state*() APIs
 behavior
Date: Mon, 25 Aug 2025 23:14:35 +0530
Message-Id: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAOhrGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNT3cSSDN3E4oJc3bTMCl1TC4s0Q2PTZMu0JEsloJaColSgMNi46Nj
 aWgCyZBHJXgAAAA==
X-Change-ID: 20250825-ath-aspm-fix-588f135c9fb9
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3844;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ScdUxidEQcv0lLc6SYd7NOOa4CGgpMbRHWOtssqifAA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorKEOm8o854j5OzwtUCAtHgkO4SxNcFD6l/mTW
 yDz9WsMo+mJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKyhDgAKCRBVnxHm/pHO
 9cICCACoyDcpWLciZ9mGj6v2OKCXgoebAq/c+dWKacvurO+u8zkaubUrk5WvEDHZGBa/tgGuKb3
 eMt1nbQflaBPVZoMw7ozg/NEmw0k9MMPUYBGhQEllopS6NL2aUAXq74QB086EkRHiHlXmneANPV
 GyrAXimgn2Vu+0aLWPqfMIVgRvELuqudksg4B9epcrkSwctK/IBBi+cCDCD2txW6qglb/My28ty
 v3avopLz4kbih4mKNBYeGyM0ZefuNeQJYgN+6Tpfw+aCep01fzpTcd0VlxseIxks0ZOk7Cxjkmx
 aDV7BjvfbnjMxah3VTmJk6tRKwyTIfddLgWrCA8XYUh6KRF8
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series fixes the behavior of the pci_enable_link_state() and
pci_enable_link_state_locked() APIs to be in symmetry with
pci_disable_link_state*() couterparts.

First 5 patches fixes and cleans up the ASPM code and the last 3 patches
modifies the atheros drivers to use the pci{enable/disable}_link_state() APIs
instead of modifying the LNKCTL register directly for enabling ASPM.

NOTE: The current callers of the pci_enable_link_state_locked() APIs (vmd and
pcie-qcom) drivers doesn't look like depending on the old behavior of the API. I
can atleast assure that for pcie-qcom. For VMD, it would be great if VMD folks
CCed could provide their review tags for patch 2/6.

Also in this version, I've included a patch from Ilpo (patch 1) that disables
ASPM forcefully even if BIOS/ACPI didn't grant us permission. More details are
in the patch description. I think this patch is needed anyway since the device
drivers are forcefully disabling it even if PCI core was skipping ASPM disable
previously.

Testing
=======

I've tested this series on Lenovo Thinkpad T14s with WCN7850 chipset (so that's
just ath12k driver). Rest of the drivers are compile tested only.

Merging Strategy
================

Even though there is no build dependency between PCI core and atheros patches,
there is a functional dependency. So I'd recommend creating an immutable branch
with PCI patches and merging that branch into both PCI and linux-wireless trees
and finally merging the atheros patches into linux-wireless tree.

If immutable branch seems like a hassle, then PCI core patches could get merged
for 6.18 and atheros patches can wait for 6.19.

- Mani

Changes in v2:

* Reworked the pcie_aspm_enabled() API to return the enabled states instead of
  bool and used it to save/restore the ASPM states in ath drivers.
* Added a patch from Ilpo to disable ASPM even if BIOS didn't grant permission
* Added the CONFIG_PCIEASPM dependency to ath{10/11/12}k drivers as they now
  depend on the ASPM APIs for stable operation.
* Rebased on top of v6.17-rc1

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Ilpo Järvinen (1):
      PCI/ASPM: Always disable ASPM when driver requests it

Manivannan Sadhasivam (7):
      PCI/ASPM: Fix the behavior of pci_enable_link_state*() APIs
      PCI/ASPM: Transition the device to D0 (if required) inside pci_enable_link_state_locked() API
      PCI/ASPM: Improve the kernel-doc for pci_disable_link_state*() APIs
      PCI/ASPM: Return enabled ASPM states from pcie_aspm_enabled() API
      wifi: ath12k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
      wifi: ath11k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
      wifi: ath10k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states

 drivers/net/wireless/ath/ath10k/Kconfig |   2 +-
 drivers/net/wireless/ath/ath10k/pci.c   |  11 ++--
 drivers/net/wireless/ath/ath10k/pci.h   |   5 +-
 drivers/net/wireless/ath/ath11k/Kconfig |   2 +-
 drivers/net/wireless/ath/ath11k/pci.c   |  19 +-----
 drivers/net/wireless/ath/ath11k/pci.h   |   3 +-
 drivers/net/wireless/ath/ath12k/Kconfig |   2 +-
 drivers/net/wireless/ath/ath12k/pci.c   |  19 +-----
 drivers/net/wireless/ath/ath12k/pci.h   |   4 +-
 drivers/pci/controller/dwc/pcie-qcom.c  |   5 --
 drivers/pci/controller/vmd.c            |   5 --
 drivers/pci/pcie/aspm.c                 | 103 ++++++++++++++++++++++----------
 include/linux/pci.h                     |   4 +-
 13 files changed, 92 insertions(+), 92 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250825-ath-aspm-fix-588f135c9fb9

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



