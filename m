Return-Path: <linux-pci+bounces-29183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09010AD169D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B81686B6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4982F3E;
	Mon,  9 Jun 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2OOrq6E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84C17C21C
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749434549; cv=none; b=ev1mBMSl/26akUWZpzWdOFRIjQuvVCrN/gVZQH0E9aXDKk8AxlzdiIJFfZsLL4fJlmC6p8z/QvdXC61+INa2YVMsRKpa4/uJ8szieMR33e9yBtB8uDaWKHnXv7mGjrWabfiPx3fOvQzhFvy2Cxd/IDdT+UiAwYOTPAG+SXY843M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749434549; c=relaxed/simple;
	bh=7WVuodyZ5BrXapq7IQkpFS6XgDOSKnupdzqrB1floYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMn9cn9Et8NSqVk7Fc79V8MPU5zs3Tu/woDR4EI3CjodVdGT3R6lbfcwT2hexaPp6rgRq6d4SsInQKgBlZF6SFE4Cpcxih6KN/dBO9CJ6a2FKbDeZBE6VYSoeoDAaDDixeP4ucQUzMwUpJ2bVAqofYU4fyZ9sMkWpmGeur0a48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2OOrq6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA26C4CEF0;
	Mon,  9 Jun 2025 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749434548;
	bh=7WVuodyZ5BrXapq7IQkpFS6XgDOSKnupdzqrB1floYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2OOrq6EoeF9szL6CTwOyiu9vUPn0WquBvuRC9CVrDOSDGPxYa5BQJ/oalmVwaq4s
	 h87QLzTNTlNPqDb/e6DhIiv5zf5GIxR//rAlj+kwaxdhR4cR9SBWFKF3KWV5l3ZwSz
	 zYsrhKuvmTSFAhx6p4ruLOfrlsRf7DRvudkHFHRMYlDIImaXuZi9v9edHTbuzhifKS
	 rUgwLVJIHGTY6H51SymwFt7dvBLF0ATuhGojdvC54JFGvdLGqIB/DKo5vPwY+Av/Nr
	 OpqaeB2AotGyIhbFM677shREctOYaNsNP5gM6GbrXPeID6m3pNGxY2aTqJ/j7MCZIj
	 V9AHAQGDPiKZQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI: Don't show errors on inaccessible PCI devices
Date: Sun,  8 Jun 2025 20:58:01 -0500
Message-ID: <20250609020223.269407-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609020223.269407-1-superm1@kernel.org>
References: <20250609020223.269407-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When a USB4 dock is unplugged the PCIe bridge it's connected to will
remove issue a "Link Down" and "Card not detected event". The PCI core
will treat this as a surprise hotplug event and unconfigure all downstream
devices. This involves setting the device error state to
`pci_channel_io_perm_failure`.

As the device is already gone and the PCI core is cleaning up there isn't
really any reason to show error messages to the user about failing to
change power states. Detect the error state and skip the messaging.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113bd..7b0b4087da4d3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1376,8 +1376,9 @@ int pci_power_up(struct pci_dev *dev)
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
-		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
-			pci_power_name(dev->current_state));
+		if (dev->error_state != pci_channel_io_perm_failure)
+			pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
+				pci_power_name(dev->current_state));
 		dev->current_state = PCI_D3cold;
 		return -EIO;
 	}
-- 
2.43.0


