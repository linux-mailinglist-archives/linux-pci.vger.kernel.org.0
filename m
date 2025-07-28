Return-Path: <linux-pci+bounces-33014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 925C4B13679
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082BC189A146
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B125C706;
	Mon, 28 Jul 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ror61mKj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386725BEF4;
	Mon, 28 Jul 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691096; cv=none; b=EN/aqVAA9Cx0B1/DZRp79p+btBAKc6+h40EUbr8UT/WTv/cwZ37uaHlbzydqRuPMPu+7RZFdKKFTcUqEIoOMa8FJ83099UNniytVy76cLCOR7KErppF8F4Zt8wByJmqEBn5I7642A21fjQxjFD5gI2k0NRcrmPSg0ZwTGRCVan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691096; c=relaxed/simple;
	bh=ntoNAe91hdDCVcAE2wDcbgw/KJoIhDh1uXZzqA+NeMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOPmqLQdxw7jEH4qo5reY3pqS08hNSdpkAG0F8OtT7je/SBmNZfdeY/dIMdENZ1e74z9TCxuKEw356KZFUfhUAI1LO5bJYjWBDunWQADNQygk8F+Z+RFKvgZ1SbmreLb3xG222MXvB+kFSi6D0uwdhQiNRy6kju3qZgnYEqYTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ror61mKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B6BC4CEFA;
	Mon, 28 Jul 2025 08:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691096;
	bh=ntoNAe91hdDCVcAE2wDcbgw/KJoIhDh1uXZzqA+NeMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ror61mKjJFeOIwGzExpoggoeiQwwGVlnKKtMP1sgpNCIAnEc+Um4F6zkie2s+8OhU
	 L/wL+JvolmD/g5yDhv0DqEYrR78iWKnhj6BLpjf+q7/FIgaw07+BRILphTquaSmggv
	 M6ylcG08B/uRcY/aGH04yb5KWARNOtksQ1EPQzP9M/nOC8h8v72cc0FLXx1ue8uINM
	 pxPVb/UVnHNLvi6lQJ5MYxeqYJ4TCVUbXvaBFSczB5uwvyK5rfafs3QTfbIEVQOadq
	 MVrMcHWz7VAQIA59TOeMIceieXH6VwLHgQcoSJfqBGVcAwfvl+CSBFGpaQDEj9eqC0
	 B6fobIGlwKmaA==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:44 -0700
Subject: [PATCH RFC 14/25] PCI/LUO: Restore power state of a PCI device
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-14-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

From: Jason Miu <jasonmiu@google.com>

From the liveupdate saved PCI device state, restore the device power
state.

The `pci_dev->current_state` is a cached power state. If the device
driver calls `pci_enable_device()`, this value can be modified from
reading the PMCSR register (see `pci_enable_device_flags()`). In the
future patches when a driver tries to enable the PCI device after
liveupdate, we should check the device power state at that moment with
the saved value.

Tested: QEMU liveupdate boot test. Trigger the liveupdate to the
        `finish` phase.
Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/pci.h   | 6 ++++++
 drivers/pci/probe.c | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2ef12745ee05960878d8d3fe0cdf136f69c8d408..a8acc986a5aac808ec64395d7d946ee036270f5b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1182,9 +1182,15 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 	 PCI_CONF1_EXT_REG(reg))
 
 #ifdef CONFIG_LIVEUPDATE
+#define PCI_SER_GET(__pci_dev, __var, __def)			\
+	(__pci_dev->dev.lu.dev_state) ?				\
+	((struct pci_dev_ser *)__pci_dev->dev.lu.dev_state)->__var : __def
+
 void pci_liveupdate_restore(struct pci_dev *dev);
 void pci_liveupdate_override_driver(struct pci_dev *dev);
 #else
+#define PCI_SER_GET(__dev, __var, __def) __def
+
 static inline void pci_liveupdate_restore(struct pci_dev *dev) {}
 static inline void pci_liveupdate_override_driver(struct pci_dev *dev) {}
 #endif
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e41a1bef2083aa9184fd1c894d5de964f19d5c01..7dd2cf9f9e110636f8998df22a333638cce25e6b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2030,8 +2030,12 @@ int pci_setup_device(struct pci_dev *dev)
 	if (pci_is_pcie(dev))
 		dev->supported_speeds = pcie_get_supported_speeds(dev);
 
-	/* "Unknown power state" */
-	dev->current_state = PCI_UNKNOWN;
+	/*
+	 * Restore the power state from liveupdate saved state.
+	 * If we are not booted from liveupdate, default
+	 * "Unknown power state".
+	 */
+	dev->current_state = PCI_SER_GET(dev, current_state, PCI_UNKNOWN);
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);

-- 
2.50.1.487.gc89ff58d15-goog


