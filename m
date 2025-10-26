Return-Path: <linux-pci+bounces-39346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5748C0AE65
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 18:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58D4134997D
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E802A8F7D;
	Sun, 26 Oct 2025 17:07:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5C2264CF
	for <linux-pci@vger.kernel.org>; Sun, 26 Oct 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498447; cv=none; b=PftOcH/7DJzXgaWu5/7qMTIFC8OR231XMkCqOpGqu1jcZOAnm1uuWtuih2zvnBZTCHCEZ3fKNJ52VRnRMaDf3TW5vRSq7H5GSiF8jswcR8KQHTSOqppFMGY99YU0nl4fpJGkadhJlD+mDBJqoroxyKf2JNXnC73RrdaP58Qosqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498447; c=relaxed/simple;
	bh=jVgPgrbNgEgOrAMbf4WTVKoiFccA0XsF1ccNteuOcc8=;
	h=Message-ID:From:Date:Subject:To:Cc; b=Es2OEAc0+jNXdaUrCH7ynYuf+UiuAe6H2//KuwZbNXWWA5FNDkOiXoh7VQM/OKzOOdDRdopMnams62rQlPw/l9vFxsFE3oRjYOC6afSrT4K7IoHi9IVXnRdvfqoTyFc3HoJFXDUu41MXfH88nMYwSmLtYC+TeMAJpawrE7KHPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id A0A6817A4C;
	Sun, 26 Oct 2025 17:57:56 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 6E345603E03F;
	Sun, 26 Oct 2025 17:57:56 +0100 (CET)
X-Mailbox-Line: From 39f87c99f6c44be3c0371c79e454e6fde7be0d4d Mon Sep 17 00:00:00 2001
Message-ID: <39f87c99f6c44be3c0371c79e454e6fde7be0d4d.1761497583.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 26 Oct 2025 17:57:57 +0100
Subject: [PATCH] PCI/PME: Replace RMW of Root Status register with direct
 write
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

As of PCIe r7.0, the Root Status register contains a single writeable bit
(PME Status, type RW1C) and otherwise just read-only bits and RsvdZ bits
(which software must write as zero, PCIe r7.0 sec 7.4).

Thus, when clearing the PME Status bit, there's no need to perform a
read-modify-write of the register.  Instead, the bit can be written
directly.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..411a0b88841e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2285,7 +2285,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
  */
 void pcie_clear_root_pme_status(struct pci_dev *dev)
 {
-	pcie_capability_set_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
+	pcie_capability_write_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
 }
 
 /**
-- 
2.51.0


