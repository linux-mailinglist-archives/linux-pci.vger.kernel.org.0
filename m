Return-Path: <linux-pci+bounces-43001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6486ACB9045
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 15:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61E7C3007E4D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207F284881;
	Fri, 12 Dec 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jOfOv/0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD22848A4
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551403; cv=none; b=WTgGL6Z3o3XVDxA03mjm9lhLbMOoDAyMWm2vr6I4RQ1yB1TY+83JYVRd2o3yj7YR/X2jBZyrfBKcDjqfudy7MnkfdT3mxYEz7UiWRKWqXbJ/pNtn6KvX/G0gp+x5Q0CahKpLSJdhrZ9PzkCe/scXieG803kitSypP7vE2rDibiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551403; c=relaxed/simple;
	bh=R3+VFqiY9OxXKrkggbvgi4CpQ3sg8fOv5hi3AHppWCM=;
	h=To:References:Cc:Message-Id:Content-Type:From:Date:In-Reply-To:
	 Subject:Mime-Version; b=ZQ+fQXsLNN0XHPScG37JASCDv7xLY4W4jb6IavClmCl3zhJ9s4gpJyD7aGvRxxu5RvwVLE9vu08QSK3ZobURX59l55W5v2Jj1WBZ5G0pkwTn/8Tt1rEp8gA2AB5urEbSSTR0sUq10sKU6hBPPz9O7+49CzY3h7/R7SmFsr5iRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jOfOv/0+; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765551388; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=I9fko49rlyRQO9najQQGMXmxO0V3/iBIPIKXkCh1tPc=;
 b=jOfOv/0+iSc061JoBaq804yldZdcCbmRKiOX6i+MQ6L92sl4arMt1PviqZ2pf17THMiVNo
 qDqCfvriKSARO4x0QqDj7SY1DiXvoNr6K/qiDvI0++cMZdf+095hy5qnyQqlljARs3v8X8
 unDlkCsJgp9RWfEXyXe3rFWiZcd8jWf0A5s7XiSFB/0OvsRK3JkTvfYRvTkNMIgUydVqTJ
 Zh/R6nIaOxFrRfVmS0bGO0Sg9MG+5gDiOfxS/MCVilW+PyBdByQcS0uDWZAom/UvyV/LtS
 f4HxMwXOSGftfnvGU/Sm2kNSAENLIFKZo4D32BKpYqtohJJ9HIydVkxwhjBr0Q==
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, 
	<dave.jiang@intel.com>, <ilpo.jarvinen@linux.intel.com>, 
	<kbusch@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20251212133737.2367-1-guojinhui.liam@bytedance.com>
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>, <stable@vger.kernel.org>
Message-Id: <20251212145528.2555-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Fri, 12 Dec 2025 22:55:28 +0800
In-Reply-To: <20251212133737.2367-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
X-Lms-Return-Path: <lba+2693c2d1b+d434ae+vger.kernel.org+guojinhui.liam@bytedance.com>
Subject: [RESEND PATCH v2] PCI: Fix incorrect unlocking in pci_slot_trylock()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
delegates the bridge device's pci_dev_trylock() to pci_bus_trylock() in
pci_slot_trylock(), but it forgets to remove the corresponding
pci_dev_unlock() when pci_bus_trylock() fails.

Before the commit, the code did:

  if (!pci_dev_trylock(dev)) /* <- lock bridge device */
    goto unlock;
  if (dev->subordinate) {
    if (!pci_bus_trylock(dev->subordinate)) {
      pci_dev_unlock(dev);   /* <- unlock bridge device */
      goto unlock;
    }
  }

After the commit the bridge-device lock is no longer taken, but the
pci_dev_unlock(dev) on the failure path was left in place, leading to
the bug.

This yields one of two errors:
1. A warning that the lock is being unlocked when no one holds it.
2. An incorrect unlock of a lock that belongs to another thread.

Fix it by removing the now-redundant pci_dev_unlock(dev) on the failure
path.

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---

Hi, all

Resent v2 to drop the Acked-by tag; no code changes. Sorry for the noise ag=
ain.

v1: https://lore.kernel.org/all/20251211123635.2215-1-guojinhui.liam@byteda=
nce.com/

Changelog in v1 -> v2
 - The v1 commit message was too brief, so I=E2=80=99ve sent v2 with more d=
etail.
 - Remove the braces from the if (!pci_bus_trylock(dev->subordinate)) state=
ment.

Best Regards,
Jinhui

 drivers/pci/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..59319e08fca6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5346,10 +5346,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		if (!dev->slot || dev->slot !=3D slot)
 			continue;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
 		} else if (!pci_dev_trylock(dev))
 			goto unlock;
 	}
--=20
2.20.1

