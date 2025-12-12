Return-Path: <linux-pci+bounces-42998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FBCCB8E83
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 14:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C1C306CA13
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC8624A051;
	Fri, 12 Dec 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="nT6tt5Br"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE0C24DCE3
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765546698; cv=none; b=g5qubpjJzuHw4jfx52Nur3BgbxltT2RKnvOhN04rkY8JMHUGQZutK1DVoiSLgflVHzVa/jy08UawhtCWn0HbW2ta1zqMNKUe3sYF6TF3doBYjxk+IFh2OTMSRLJkylzB8sMt0EbgHFvOKidM+24yR95MP2gmgRhHAqBvGxTtzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765546698; c=relaxed/simple;
	bh=rJ+wUJ0ZQN5cf9uHHw+LRHss2EaA0VXJDDempjZpzs0=;
	h=Message-Id:Cc:From:Date:Subject:Mime-Version:Content-Type:To; b=ZP67Wn1V7JirHLPnKoupOSAPkWIaqYr6/bPyA2t+mKGS/3XVXXDp8cvpAJi6zTU1GHY4LM3RK7+YGvTNf1x6j3l+pAq9ji5h4Fh5PD1A0IH5VxlXo2REYMTbgdvYxfRl8QKVFjtAoB/9QCvmfQzXQR98U/FIDTsgsw72UhbvPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=nT6tt5Br; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765546681; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=oAjUxi/jSH9JUSsh/4RDgmel17P3oiVwVjj9KTXKORU=;
 b=nT6tt5BrlC5mTGI54U9tnypyNlrJHKEflWitx2yTR9DnfzlcZQx3Lbb3nZ+HkiaTHBeyBS
 kXL9qZ7C3S4XRdRXWIlh+JJJOeiJncmmOfy4Yh7rT3EZzz+zKoRsYhohH8GtevJOW2T1d7
 ssR+eJ4sZyJ1P3Ms8lXVWVubpWrYBuDOVlOcawhIu/REQj1t0y4bE/JNCK6FjgXd4rujfu
 iOF1pnotYkHyzi/92+oSzWYMocppAWkb6uKSPWKYH/r6mSyuHaERfq1CaXNKY80+4jgJ6H
 pOkMYxCvOftOQim0yJCzOG+v7qbTk5JBlRFp+WeeA4FYQ0ILNHDDhOQsB6Rh0A==
Message-Id: <20251212133737.2367-1-guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.17.1
Cc: <guojinhui.liam@bytedance.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Fri, 12 Dec 2025 21:37:37 +0800
Subject: [PATCH v2] PCI: Fix incorrect unlocking in pci_slot_trylock()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2693c1ab7+86af41+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <bhelgaas@google.com>, <kbusch@kernel.org>, <dave.jiang@intel.com>, 
	<dan.j.williams@intel.com>, <ilpo.jarvinen@linux.intel.com>

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
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
---

Hi, all

v1: https://lore.kernel.org/all/20251211123635.2215-1-guojinhui.liam@byteda=
nce.com/

Changelog in v1 -> v2
 - The v1 commit message was too brief, so I=E2=80=99ve sent v2 with more d=
etail.
 - Remove the braces from the if (!pci_bus_trylock(dev->subordinate)) state=
ment.

Sorry for the noise.

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

