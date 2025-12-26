Return-Path: <linux-pci+bounces-43721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41BCDE580
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 06:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17AE30088AA
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00524241CA2;
	Fri, 26 Dec 2025 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IYrtT/aM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m32116.qiye.163.com (mail-m32116.qiye.163.com [220.197.32.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DA2417F2;
	Fri, 26 Dec 2025 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766726101; cv=none; b=rnM60QG0h8RXYt1RspUmo9y9zJQXKMkkzecfXXPKxFj66kVcNsEzwyTNbhKHb2hXNSrzP4KLZRgzCEHcZ2O3n3lrheYdh7uWSTAB7xVIPGmNJEsea43Ax6EP+C/HBxCp0UG2cKS2+J8/bApDTlN2RxDLexQm/KDwUKnfl3FdzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766726101; c=relaxed/simple;
	bh=mfXfxaKgCYw6qoxlrZsUW3J8KjeqDxuHUi7gTw1kqnU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ShigB0Vg+jqD6GGiY5b+lGQl344ybS8IOAt+uKTbBgPth2k4Zdr/EyzHLN9vxI1gpsLz1J44gdegRO80JR3EKq6mK9/po979Y0y2rvSTrecQ8cz4nZ4WVHYxDpsh45xpHVdpaEpPxKtwpjEkrJM6oDbpGN7WdjPOAO/wO+nreG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IYrtT/aM; arc=none smtp.client-ip=220.197.32.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e9a89ae4;
	Fri, 26 Dec 2025 09:45:35 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] Documentation: PCI: Fix typos in msi-howto.rst
Date: Fri, 26 Dec 2025 09:45:28 +0800
Message-Id: <1766713528-173281-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b58552ba009cckunm31c4f13342403
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlOGlZOGU8aTxoYSx5KSx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IYrtT/aMUiSUyux9X4vpZoI8eep4bwFwFg7jefAm0s4iVPKdYddg0Nc3He/5RSVhwGoFxfSkljxkes7vINl2kwtOt+HJ6JOUXYStxuZNZ7VqjoDo7hYXVVxnmEbA+FrGXDFCrxgDYtBplha2FMZmfZJUV5yKU6T57sjuULs14lU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=+DZC92+bjqJ2ll3eiWRaOZBWxu8Gx0vvt2BNRAllEa0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Fix subjject-verb agreement for "has a requirements" as well as
"neither...or" conjunction mistake. And convert "Message Signalled
Interrupts" to "Message Signaled Interrupts" to match the PCIe spec.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 Documentation/PCI/msi-howto.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index 0692c9a..667ebe2 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -98,7 +98,7 @@ function::
 
 which allocates up to max_vecs interrupt vectors for a PCI device.  It
 returns the number of vectors allocated or a negative error.  If the device
-has a requirements for a minimum number of vectors the driver can pass a
+has a requirement for a minimum number of vectors the driver can pass a
 min_vecs argument set to this limit, and the PCI core will return -ENOSPC
 if it can't meet the minimum number of vectors.
 
@@ -127,7 +127,7 @@ not be able to allocate as many vectors for MSI as it could for MSI-X.  On
 some platforms, MSI interrupts must all be targeted at the same set of CPUs
 whereas MSI-X interrupts can all be targeted at different CPUs.
 
-If a device supports neither MSI-X or MSI it will fall back to a single
+If a device supports neither MSI-X nor MSI it will fall back to a single
 legacy IRQ vector.
 
 The typical usage of MSI or MSI-X interrupts is to allocate as many vectors
@@ -203,7 +203,7 @@ How to tell whether MSI/MSI-X is enabled on a device
 ----------------------------------------------------
 
 Using 'lspci -v' (as root) may show some devices with "MSI", "Message
-Signalled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
+Signaled Interrupts" or "MSI-X" capabilities.  Each of these capabilities
 has an 'Enable' flag which is followed with either "+" (enabled)
 or "-" (disabled).
 
-- 
2.7.4


