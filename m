Return-Path: <linux-pci+bounces-32261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB5BB07659
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55E61AA6E97
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090922F5084;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6f37LOL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A838F80;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670584; cv=none; b=bH4HjSRjXJrEH0KAEAo1BrJwT527LS6d/1nwe6ojbNTQPe7hRfnhq8vADg4m9HJeC+2iSlElmAUv3wNGQzPNro4J5eBhFZnmtPGhVMGszYdjvy9tbwQB+oaLtTUXsml+lonkANSM15eLPPIJAtI53xE7pU8rL4nf3aJDA7M616g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670584; c=relaxed/simple;
	bh=XJHu0BU6B2oAYGh4zlJhKIwWPQugh47Z5AJ6yeiT7Z4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zg6bZErzJe22O+nJ2h/gEZauXNezbJyWNrF4SQQBxZ46bvyeCf7W9NDxPtvyfOQ3kaKqjZzQSaocAB8RRICCJpdutw+QfxB4LBTidFq9gXjYkRChHunw/BgvRgDofkRe7hIP47o7wTzyiX8ZbXHqKmRS+cyHf8afC466eVZ4pcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6f37LOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A128EC4CEF4;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670584;
	bh=XJHu0BU6B2oAYGh4zlJhKIwWPQugh47Z5AJ6yeiT7Z4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=T6f37LOL55CAf6De29GNzmhzCyVDSGnGtukns/GoO03iBooiZmthuBpMqVQlRYK9C
	 W46IF4PieyurJp8WQmqlUCMT2R/HP6hJfdJljwXpZ1UaRYu33EAm/kZFPgYEfpJUuW
	 enp5lezsZOWEYssn+Ykp98f5p6itslJv5lBa8x5x0hyIV56ZXdA69YxkboqlMNFG4+
	 VeXyb2H3+7qXz6eugC8jNqjNHjrgn9lcgl416dpT0qFLHF9mYZnCj1LKUG5k/yQJoT
	 5VID/Ks5gM3fZ1K1sQROXTiWOPRZ4dP4ZjlA5AqshFYzpkw74x8v1X4JrHxn5wUQ3r
	 DLMdbaHUJmXNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C6C83F22;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/6] PCI/ASPM: Fix pci_enable_link_state*() APIs behavior
Date: Wed, 16 Jul 2025 18:26:19 +0530
Message-Id: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOhd2gC/x2MQQqAMAzAviI9W7BjMvQr4qFodT04ZRURxL87P
 CaQPGCSVQz66oEsl5ruqQDVFUyR0yqoc2FwjWubQIR8RmQ7Nlz0xomC945b7ligJEeWov/dML7
 vBxDLtA5eAAAA
X-Change-ID: 20250711-ath-aspm-fix-c17442a5a9ae
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2631;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=XJHu0BU6B2oAYGh4zlJhKIwWPQugh47Z5AJ6yeiT7Z4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBod6F2iDbObtlH1SjC+CqMAksFgzOriAQ1Avz7v
 IVgkpT7eMSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHehdgAKCRBVnxHm/pHO
 9YnKB/wIw+Evh74fkz1+e3zKFQWHQKJJSazZGHS5g4sICCMPZ/4M93vTf+iLF4Blp3veDJhLy1B
 BGe8V3AJq+xqMdOOWmaPj/fEy7ukevvMlLZHnS5yHIrebv9ehwe60fjePHZ+kkwke2JXgh5SMn2
 aoNSydN026Nm+C+XW0IVVbZqMpsq3pFyN5MLTUVKM9zREWmmg/RAd75jPZ0oWkNiqzEj2C4XoVV
 M3swsNxSU7uFYHGzLxGFSLk3zf3Sm1Tl48owufc1zv9xTnXYeobMvQIsx4hvQSBACG7gwFxjUmc
 4epgfpo4UEHaA5y6LDHB/oAZex/9Q6hTaG0SGH/st9KFUCxN
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

First 3 patches fixes and cleans up the ASPM code and the last 3 patches
modifies the atheros drivers to use the pci{enable/disable}_link_state() APIs
instead of modifying the LNKCTL register directly for enabling ASPM.

NOTE: The current callers of the pci_enable_link_state_locked() APIs (vmd and
pcie-qcom) drivers doesn't look like depending on the old behavior of the API. I
can atleast assure that for pcie-qcom. For VMD, it would be great if VMD folks
CCed could provide their review tags for patch 1/6.

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
for 6.17 and atheros patches can wait for 6.18.

- Mani

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (6):
      PCI/ASPM: Fix the behavior of pci_enable_link_state*() APIs
      PCI/ASPM: Transition the device to D0 (if required) inside pci_enable_link_state_locked() API
      PCI/ASPM: Improve the kernel-doc for pci_disable_link_state*() APIs
      wifi: ath12k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
      wifi: ath11k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
      wifi: ath10k: Use pci_{enable/disable}_link_state() APIs to enable/disable ASPM states

 drivers/net/wireless/ath/ath.h         | 14 ++++++
 drivers/net/wireless/ath/ath10k/pci.c  |  7 +--
 drivers/net/wireless/ath/ath11k/pci.c  | 10 ++---
 drivers/net/wireless/ath/ath12k/pci.c  | 10 ++---
 drivers/pci/controller/dwc/pcie-qcom.c |  5 ---
 drivers/pci/controller/vmd.c           |  5 ---
 drivers/pci/pcie/aspm.c                | 78 ++++++++++++++++++++++++----------
 7 files changed, 79 insertions(+), 50 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250711-ath-aspm-fix-c17442a5a9ae

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



