Return-Path: <linux-pci+bounces-29186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48591AD16A3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0415E168C17
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7631FC3;
	Mon,  9 Jun 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/XOrh9S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793441624DF
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749434733; cv=none; b=YmG1mZtaK8+MvY6d1rPtcLAZC/0+FMLhBIkOnp60hxem4aXEuaX0K1wGHMyZC7gLSAEzXd8jgOqMS2hxfKiW93VWA3F1WS1MSrBhg6cwbIwl5V3VlOuDAS45JZ06VGlV6m5gKhhmLgkkESq0oQmaxl7vW2PTHEAPhwfAdsqX2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749434733; c=relaxed/simple;
	bh=SWQT8sENw4NwT9lDBHuUxJ8UaAXCQ1R60yGTayrXJwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txPmD1bt2iMD6mD4M8IvW4gsC7qmHMmBoCgHiP56Cp3HHc26/yOlo5CirHij6KNwPT19PJCj8DmHP39W+kwCk3sZFd+w6xSPcaCPeM2WHWXHtSixc59wZRIdAlbZsSYjudqnxgc5WmktamH3xBYPnzwIsgmZEDk2p1IdHMUdCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/XOrh9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ECCC4CEF2;
	Mon,  9 Jun 2025 02:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749434732;
	bh=SWQT8sENw4NwT9lDBHuUxJ8UaAXCQ1R60yGTayrXJwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/XOrh9SHcIiG0yELowmGUZ8ijMU4aU40kTi45jbekPylyiriBvsGQ+CTC+Tslq7s
	 dhLQeru98aVSbiwZlssldKHNQlZzCl6LVMFctWrHPM0XOSIGujfdqOs5StAbd/JOqK
	 sFKbhoX1kloNi2zp+91Bnj8g5JcKq+jiMdlBubkqwBc1JU2eQn1FbgFn2o7wKz3uVA
	 IB52d6zp5zuRf0JzOYzipOrc1BI/eSx5IxJ7O/cZ+EC9kIyykWOUoGi3rYBtiD8WQI
	 w6Heo71h6UdNEc3d5C7yksrN119KNzxaYfOG8kwCm7axUf7mhRAe2B9U8GaClZUHCL
	 sqDr22wzf8/Gg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/4] usb: xhci: Avoid showing warnings for dying controller
Date: Sun,  8 Jun 2025 21:05:18 -0500
Message-ID: <20250609020518.289812-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609020518.289812-1-superm1@kernel.org>
References: <20250609020518.289812-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When a USB4 dock is unplugged from a system it won't respond to ring
events. The PCI core handles the surprise removal event and notifies
all PCI drivers. The XHCI PCI driver sets a flag that the device is
being removed, and when the device stops responding a flag is also
added to indicate it's dying.

When that flag is set don't bother to show warnings about a missing
controller.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 4e6dbd2375c3f..86d4bcc5faaf0 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -144,7 +144,8 @@ int xhci_halt(struct xhci_hcd *xhci)
 	ret = xhci_handshake(&xhci->op_regs->status,
 			STS_HALT, STS_HALT, XHCI_MAX_HALT_USEC);
 	if (ret) {
-		xhci_warn(xhci, "Host halt failed, %d\n", ret);
+		if (!(xhci->xhc_state & XHCI_STATE_DYING))
+			xhci_warn(xhci, "Host halt failed, %d\n", ret);
 		return ret;
 	}
 
@@ -203,7 +204,8 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 	state = readl(&xhci->op_regs->status);
 
 	if (state == ~(u32)0) {
-		xhci_warn(xhci, "Host not accessible, reset failed.\n");
+		if (!(xhci->xhc_state & XHCI_STATE_DYING))
+			xhci_warn(xhci, "Host not accessible, reset failed.\n");
 		return -ENODEV;
 	}
 
-- 
2.43.0


