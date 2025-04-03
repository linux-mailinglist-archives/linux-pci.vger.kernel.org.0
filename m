Return-Path: <linux-pci+bounces-25262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA878A7AF79
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 22:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8693BBEB6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1708261392;
	Thu,  3 Apr 2025 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKGFXrX5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE11261389;
	Thu,  3 Apr 2025 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708026; cv=none; b=F1IECPST8KkDwM+FASiZ9a4lhwDcNeQsLm8vn6I54/t9yXhr5ubmFb3Ur75D4FRCttMru4yqK7JJJ1d8EwcMaggwjviT5WT3g1UWj1arERtKxGoJSynajqConW8xucHM6oMaoOpsQCV+fc7GbCNVdUUisx/M6nWEZK2FSar9FXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708026; c=relaxed/simple;
	bh=+tBY6UKWekhQJduG+EZZK0/ueq1BweiGDOAn9x+7Voc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOBZKjooave54BVL6vJb0/ngHe4yExx92tKpHCGDHUZAT8QI1YQrseFAJ20i8UbSfvhAFUQF43YYaiCxa4ZAd/HC1320X8ATffzYtD7abcuwhdA+X09HZ5J4iLA/VgcJX2DafLMTT9uegLlt0+BGwryYRN24cMXXugm1qjEDppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKGFXrX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A06C4CEE3;
	Thu,  3 Apr 2025 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708026;
	bh=+tBY6UKWekhQJduG+EZZK0/ueq1BweiGDOAn9x+7Voc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKGFXrX5IScWLvIhJdMq2MyM6SZlZu+a64frc1CPQtfTD8epdfG9P0qTkxgqE5p9i
	 xJ5eUrN02SWjwzvoy1um2g8OnyxaKnsSzlfDWvqB/JnMQsK4cb4dAVxlLKoFdlhMMR
	 hp6/w1rSUpajDxyu04BgJfHD2/HDctLxm7hicLEl1cCvw5zR9PMakjFKg5Ul1S8xkH
	 W9huzk+3xtZoifrMufrm7MKK5jPdCf4CB2MWtFOf5vJgv3095wNjP+07l8WvFYfsZ4
	 qmGt8dxIS374wV8LpEkeVwYmAi1iHkjUiZwb/tLy07jWVNacUtxuTSP5pxrRntaKWm
	 6w4RvXK7ycq+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ryo Takakura <ryotkkr98@gmail.com>,
	"Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	nirmal.patel@linux.intel.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 10/12] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type
Date: Thu,  3 Apr 2025 15:19:59 -0400
Message-Id: <20250403192001.2682149-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192001.2682149-1-sashal@kernel.org>
References: <20250403192001.2682149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <ryotkkr98@gmail.com>

[ Upstream commit 18056a48669a040bef491e63b25896561ee14d90 ]

The access to the PCI config space via pci_ops::read and pci_ops::write is
a low-level hardware access. The functions can be accessed with disabled
interrupts even on PREEMPT_RT. The pci_lock is a raw_spinlock_t for this
purpose.

A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
acquired with disabled interrupts. The vmd_dev::cfg_lock is accessed in
the same context as the pci_lock.

Make vmd_dev::cfg_lock a raw_spinlock_t type so it can be used with
interrupts disabled.

This was reported as:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  Call Trace:
   rt_spin_lock+0x4e/0x130
   vmd_pci_read+0x8d/0x100 [vmd]
   pci_user_read_config_byte+0x6f/0xe0
   pci_read_config+0xfe/0x290
   sysfs_kf_bin_read+0x68/0x90

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Acked-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
[bigeasy: reword commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/r/20250218080830.ufw3IgyX@linutronix.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
[bhelgaas: add back report info from
https://lore.kernel.org/lkml/20241218115951.83062-1-ryotkkr98@gmail.com/]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 10a078ef4799d..1195c570599c0 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -108,7 +108,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -386,7 +386,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -401,7 +401,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -421,7 +421,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -439,7 +439,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -850,7 +850,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
-- 
2.39.5


