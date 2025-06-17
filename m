Return-Path: <linux-pci+bounces-29989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58027ADDFD5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 01:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D797189C54A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C78220F47;
	Tue, 17 Jun 2025 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfzlVpr6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6382F5312;
	Tue, 17 Jun 2025 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750204660; cv=none; b=N8t3Cp3KN6UpQ28ic9k1n4vAgfGRcyiWPKJ0YNBbfSaa8A8cNmdQQ4fRGJk6Zo/MyIGcWxYBzqyOkAs5h/2UCVTScxUywVFzPJPFSo56Weqzv2zngMVYbZ5CZ8aBSrH8zKaPmKOe4cxVR3WGY8orJdqh62dLH0u8z16w9d4YYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750204660; c=relaxed/simple;
	bh=scUHfot7Urf3pMJzkPdyX1/x6V3Q2LIjJGHqK4v9r/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eQbUglEO+XrgQTEBgwKERRdz1t4CJyuXefgvyXrKC//A6PgqpyVENsNPyGHpKeZNXw42Aufcejqv2k3ts2Gk+LOYPwqc/01xk/CPfkfbXkBd2R3qqjqk6eCirVMKeOgNjXfFprT051LOH9h0rQitYSbbvP8JkwX1RR8k/SHmr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfzlVpr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92944C4CEE3;
	Tue, 17 Jun 2025 23:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750204659;
	bh=scUHfot7Urf3pMJzkPdyX1/x6V3Q2LIjJGHqK4v9r/E=;
	h=From:Date:Subject:To:Cc:From;
	b=jfzlVpr6aMZr+RrQ3q5TaInCXlxIRlM/a7+t3AQaJHS1SY31+29ua9ZAvCZrYxDaa
	 ytKI1qdyuNakdDYXbeFdONTjMfZ7SCLDZeHJYXB23V5ic16gbkcQWu7C41ZFL/+gxj
	 jVlMGnssZMY3giSJFxbxtbkL4BAfZD8mwBpPfYXZIb3HGVN1Og7tj5jmyvRdVMny6C
	 dUNjFF3RK42WOGgbaF1CtKtl3Z4D2XdlBoP386MzANi/Hq6qIHm+A2cLhf+W6nZ5op
	 LXzkJPb8LcNSshl3uIg7Msxm6+X5YI8nVKDZkNYrMse4gorJDB6XX+SLPsfRPoBQ0L
	 tqr4iPppg+pkQ==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 17 Jun 2025 16:57:30 -0700
Subject: [PATCH] PCI/MSI: Remove duplicated to_pci_dev() conversion
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-pci-msi-avoid-dup-pcidev-v1-1-ed75b0419023@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOkAUmgC/x2MywqAIBAAfyX23ILZ034lOohutYdKlCSQ/j3rO
 AMzCQJ5pgBjkcBT5MDnkaEqCzCbPlZCtplBCtmKrurRGcY9MOp4skV7uc9YimjUoJqapNKDgJw
 7Twvf/3qan+cFkaX6oWoAAAA=
X-Change-ID: 20250617-pci-msi-avoid-dup-pcidev-c98943e29a80
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.14.2

In the pci_msi_update_mask() function, "lock = &to_pci_dev()" does the
"to_pci_dev()" lookup, and there's another one buried inside
"msi_desc_to_pci_dev()"

Introduce a local variable to remove that duplication.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/msi/msi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6ede55a7c5e652c80b51b10e58f0290eb6556430..78bed2def9d870d645751436793238ef2bc8b3ed 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -113,7 +113,8 @@ static int pci_setup_msi_context(struct pci_dev *dev)
 
 void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
-	raw_spinlock_t *lock = &to_pci_dev(desc->dev)->msi_lock;
+	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
+	raw_spinlock_t *lock = &dev->msi_lock;
 	unsigned long flags;
 
 	if (!desc->pci.msi_attrib.can_mask)
@@ -122,8 +123,7 @@ void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 	raw_spin_lock_irqsave(lock, flags);
 	desc->pci.msi_mask &= ~clear;
 	desc->pci.msi_mask |= set;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
-			       desc->pci.msi_mask);
+	pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
 

---
base-commit: 66ff9b2a9d55fecc8f0f940fe0cfe190a56c6a9c
change-id: 20250617-pci-msi-avoid-dup-pcidev-c98943e29a80

Best regards,
-- 
Chris Li <chrisl@kernel.org>


