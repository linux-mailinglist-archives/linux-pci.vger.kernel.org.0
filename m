Return-Path: <linux-pci+bounces-10903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F193E825
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E517F282D22
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA50416B725;
	Sun, 28 Jul 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6XvUNaW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C616B39D;
	Sun, 28 Jul 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182931; cv=none; b=I+MvNdElXxnGvY9+BvzUIT1AdaC0CMEvjcRyhKm3izFQIxaOtFLUM7l9C+5jvMrPC/99vsfhRVM8V3qOSItLkUUaE4FJqBMs1HigVhGe8sp6AunqzkOFOOzFtyGIfH9/U5pnZHjaZUrzmQgMeWR+QFPeFlOziNm7/nZRh31+A/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182931; c=relaxed/simple;
	bh=Vc8P3zYTl2C2WE+GSxfutyVUzhWT+oYurl7BvKyecuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpJBcxZCAh3b4IHtFptI3U0hML2IjgMq6nXjnqo4TTYKqEkQPSMaZYU2peVOLYNInfCctpQVqD6p5tdvhJE2ogoeGYEk7pRsv7350HiFSNk8Ts/nBVx2MlzqvfFBtN1Aqd/M5s6CJmPIujn9d+cI+RSPfUKnD3rSyTCX/JtAgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6XvUNaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17525C4AF0E;
	Sun, 28 Jul 2024 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182931;
	bh=Vc8P3zYTl2C2WE+GSxfutyVUzhWT+oYurl7BvKyecuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6XvUNaWa9IkAOoei27AYpuIGAnDFAmbjrNWFPvmRTNgkzqY4/aGfBfRMPAkd0HCw
	 yoeN6uey81xk7/tMkKKARVQzJHDFw1hzt7n+0HtRBWnARCWCmidXVID/fBpB4kHRcD
	 itFHM4R/0xBHDZG9HLWeq95DXls4IBfEwWgMiQ3Ix6WC4ADi60PcLqVBqbbbxYQkYg
	 cfITyx0W9RWTnAgNbQflfSqgibSY1Gta5Rgp86AkixTqRB/YXBsZzgnxIgCmIVNewX
	 Lhu87+b24i4y08H42GyScD6WJH2Yj7RRosZEHIMQtZUtIZNu/e0tipDr73tT7LJmOU
	 IrCIqsGRVhYvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/15] PCI: Add missing bridge lock to pci_bus_lock()
Date: Sun, 28 Jul 2024 12:07:58 -0400
Message-ID: <20240728160813.2053107-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit a4e772898f8bf2e7e1cf661a12c60a5612c4afab ]

One of the true positives that the cfg_access_lock lockdep effort
identified is this sequence:

  WARNING: CPU: 14 PID: 1 at drivers/pci/pci.c:4886 pci_bridge_secondary_bus_reset+0x5d/0x70
  RIP: 0010:pci_bridge_secondary_bus_reset+0x5d/0x70
  Call Trace:
   <TASK>
   ? __warn+0x8c/0x190
   ? pci_bridge_secondary_bus_reset+0x5d/0x70
   ? report_bug+0x1f8/0x200
   ? handle_bug+0x3c/0x70
   ? exc_invalid_op+0x18/0x70
   ? asm_exc_invalid_op+0x1a/0x20
   ? pci_bridge_secondary_bus_reset+0x5d/0x70
   pci_reset_bus+0x1d8/0x270
   vmd_probe+0x778/0xa10
   pci_device_probe+0x95/0x120

Where pci_reset_bus() users are triggering unlocked secondary bus resets.
Ironically pci_bus_reset(), several calls down from pci_reset_bus(), uses
pci_bus_lock() before issuing the reset which locks everything *but* the
bridge itself.

For the same motivation as adding:

  bridge = pci_upstream_bridge(dev);
  if (bridge)
    pci_dev_lock(bridge);

to pci_reset_function() for the "bus" and "cxl_bus" reset cases, add
pci_dev_lock() for @bus->self to pci_bus_lock().

Link: https://lore.kernel.org/r/171711747501.1628941.15217746952476635316.stgit@dwillia2-xfh.jf.intel.com
Reported-by: Imre Deak <imre.deak@intel.com>
Closes: http://lore.kernel.org/r/6657833b3b5ae_14984b29437@dwillia2-xfh.jf.intel.com.notmuch
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[bhelgaas: squash in recursive locking deadlock fix from Keith Busch:
https://lore.kernel.org/r/20240711193650.701834-1-kbusch@meta.com]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Kalle Valo <kvalo@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0399204941dbe..f23b9158edc3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5584,10 +5584,12 @@ static void pci_bus_lock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
 
@@ -5599,8 +5601,10 @@ static void pci_bus_unlock(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
@@ -5608,15 +5612,15 @@ static int pci_bus_trylock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	if (!pci_dev_trylock(bus->self))
+		return 0;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
 
@@ -5624,8 +5628,10 @@ static int pci_bus_trylock(struct pci_bus *bus)
 	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 	return 0;
 }
 
@@ -5657,9 +5663,10 @@ static void pci_slot_lock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
 
@@ -5685,14 +5692,13 @@ static int pci_slot_trylock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate)) {
 				pci_dev_unlock(dev);
 				goto unlock;
 			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
 
@@ -5703,7 +5709,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	return 0;
 }
-- 
2.43.0


