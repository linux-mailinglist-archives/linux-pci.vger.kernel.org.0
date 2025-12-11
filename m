Return-Path: <linux-pci+bounces-42953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176EACB5E54
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52B4830019D8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B8B30FC1C;
	Thu, 11 Dec 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y1zdOYMd"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-100.ptr.blmpb.com (sg-1-100.ptr.blmpb.com [118.26.132.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39242D77EA
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456695; cv=none; b=Wm16RmR/smGqEY6xPxUUUCU4STezIrj29eL/+btlSoXcXQCiiK7YWmYMtSeWNj4GIlzb3T8FW6VTOBTHHwFnghC4876C8ml4R6vdKHtYl70BifL1+qFUuyqsGNw74sCGBL4wGMR+gXuuO+G4TFgC9ggz4wVVxtU4mH07FOLykSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456695; c=relaxed/simple;
	bh=TwavrvwCpUkrQKPWik/OjaMSy6o5WMohj1hJc6u3FYE=;
	h=Cc:Message-Id:Mime-Version:Content-Type:To:Subject:Date:From; b=CsTqyvOl9Yvg7kOejSo/6J8nUwIBTlow933Z1ZMdFOeBROmqhrutkHAquG6UIrDBj0PeNvjvXoyx3jpcxAyiRRwuicDvUM1nuKLs/lb5XvtEZ1xrnk2/C9+1CcI34GC3HASyhhVvkfbTS644k5wspAkeAjddf1rS59tEv7JbbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y1zdOYMd; arc=none smtp.client-ip=118.26.132.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765456680; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=U0kmftBYFXHIoReqJuzrYqBPPEvLTkdwDn62vqNYTec=;
 b=Y1zdOYMddifj3NTX8JwlsBFNe1Iyn2AkXhtqP3cjaBxyVtAKBE684NghQ9Gpsy32N/yx6p
 ao4PVtVf8ceQLXVUURn5M20Ush3hR91KnIymJ3bUJbRZ47OgVcX1kjxHzZgOJgrOqRjcaZ
 5Nf1poDuZmK+dl9onk2PgHnHFY2JfH99hy7CyfVuvTuMRpEJgulM71iFfoIG4LeC2YGMXF
 Vmdq+RQoReZoemgrAxABNto4ITMeMPdFXWH1S05IQX5VwIPLrrE+tIf03K65KEgh2Z/ceU
 RJcboXj4EqEp1Z3WqinLEmXJe8CfgNdmlpuWOWTAb1UCGP1ziLgGvK9RdhkduQ==
Cc: <guojinhui.liam@bytedance.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Message-Id: <20251211123635.2215-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2693abb25+f15074+vger.kernel.org+guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
To: <bhelgaas@google.com>, <kbusch@kernel.org>, <dave.jiang@intel.com>, 
	<dan.j.williams@intel.com>
Subject: [PATCH] PCI: Remove redundant pci_dev_unlock() in pci_slot_trylock()
Date: Thu, 11 Dec 2025 20:36:35 +0800
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>

Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
delegates the bridge device's pci_dev_trylock() to pci_bus_trylock()
in pci_slot_trylock(), but it leaves a redundant pci_dev_unlock() when
pci_bus_trylock() fails.

Remove the redundant bridge-device pci_dev_unlock() in pci_slot_trylock(),
since that lock is no longer taken there.

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..75a98819db6f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5347,7 +5347,6 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
 				goto unlock;
 			}
 		} else if (!pci_dev_trylock(dev))
-- 
2.20.1

