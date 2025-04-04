Return-Path: <linux-pci+bounces-25270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73222A7B6DF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 06:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF38177510
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 04:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3821632E6;
	Fri,  4 Apr 2025 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="NJ2WDg/F"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E0613B797;
	Fri,  4 Apr 2025 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743740801; cv=none; b=Vi3B58V0aEuPyKaJ2qOglPRO1EKPSXob/6Mu/zs+6x2fzFAviCoitqoN2UgqT3ZI7Et1G1tGWd7+W/ZPVtw8NOrOV/QeBh+2SIRVdv3f1Peu81IXDpHNAL84iiKEVojljUy7D4QpIhFpbEUoig6gdtOJAk2mfeYf2iVQfqemK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743740801; c=relaxed/simple;
	bh=GD4PbrRWARoVxmIZIO0RTWV/Z6qA8xZnFttWFtGyuwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9r/7HL/brGDs9XSrp48CRVg5H3X0Dbc11Wb2JAa4DktJDF01sn8zlhMfR/bG1oP3iqTB0j8LetvGCnc6yUJFoAxzC37vQ3uuoFe6bjN4cs6oqygPzBX2+Tn+JEZpp6LJwsE7woL8L0Za0q/DwQH/r6KKk1L8ldWv3Fl7QMNNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=NJ2WDg/F; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4A9C18287DC7;
	Thu,  3 Apr 2025 23:18:16 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id y0x95OhCHdpj; Thu,  3 Apr 2025 23:18:15 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 5125A82888D4;
	Thu,  3 Apr 2025 23:18:15 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 5125A82888D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1743740295; bh=g8RNqE7aPiU1zvwocf1geGsqM6oe9JplNEQakBf0Reg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=NJ2WDg/FTHCCC6jFgYkZlr24HYP+QOKD2ftg3UT+clr+55Mx+4dkhbO6XW1PFMw85
	 kD67hZYiQ0jWO3dcGWqL9fYMPsZ19bSMXZH6fABD0/bCFLyOOwJl5bkUmIFGW0Z5T9
	 kEarqQZJELs45FV7AKLy+5XuXmFBbNHDUgwcNFJ4=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bl4Uh3ydGZaJ; Thu,  3 Apr 2025 23:18:15 -0500 (CDT)
Received: from raptor-ewks-026.lan (5.edge.rptsys.com [23.155.224.38])
	by mail.rptsys.com (Postfix) with ESMTPSA id BAF458287D01;
	Thu,  3 Apr 2025 23:18:14 -0500 (CDT)
From: Shawn Anastasio <sanastasio@raptorengineering.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tpearson@raptorengineering.com,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH 3/3] pci/hotplug/pnv_php: Fix refcount underflow on hot unplug
Date: Thu,  3 Apr 2025 23:18:10 -0500
Message-Id: <20250404041810.245984-4-sanastasio@raptorengineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250404041810.245984-1-sanastasio@raptorengineering.com>
References: <20250404041810.245984-1-sanastasio@raptorengineering.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

When hot unplugging a slot containing a PCIe switch on a PowerNV system,
the reference count of the device_node corresponding to the root will
underflow. This is due to improper handling of the device_nodes'
refcounts in pnv_php_detach_device nodes that occurs on each unplug
event.

When iterating through children nodes, pnv_php_detach_nodes first
recursively detach each child's children, then it would decrement the
child's refcount and finally call of_detach_node on it, which in turn
would decrement the refcount further and result in an underflow. Fix
this by dropping the explicit of_put call and by moving the final
of_detach_node call after the loop.

The underflow that occurs without this patch produces the following
backtrace on unplug events:

  refcount_t: underflow; use-after-free.
  WARNING: CPU: 4 PID: 669 at lib/refcount.c:28 refcount_warn_saturate+0x214/0x224
  Call Trace:
   refcount_warn_saturate+0x210/0x224 (unreliable)
   kobject_put+0x154/0x2d4
   of_node_put+0x2c/0x40
   of_get_next_child+0x74/0xd0
   pnv_php_detach_device_nodes+0x2a4/0x30c
   pnv_php_set_slot_power_state+0x20c/0x500
   pnv_php_disable_slot+0xb8/0xdc
   power_write_file+0xf8/0x18c
   pci_slot_attr_store+0x40/0x5c
   sysfs_kf_write+0x64/0x78
   kernfs_fop_write_iter+0x1b4/0x2a4
   vfs_write+0x3bc/0x50c
   ksys_write+0x84/0x140
   system_call_exception+0x124/0x230
   system_call_vectored_common+0x15c/0x2ec

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
---
 drivers/pci/hotplug/pnv_php.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 1a734adb5b10..a3fa44f7bf1a 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -156,11 +156,12 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
 	struct device_node *dn;
 
 	for_each_child_of_node(parent, dn) {
+		/* Detach any children of the parent node first */
 		pnv_php_detach_device_nodes(dn);
-
-		of_node_put(dn);
-		of_detach_node(dn);
 	}
+
+	/* Finally, detach the parent */
+	of_detach_node(parent);
 }
 
 static void pnv_php_rmv_devtree(struct pnv_php_slot *php_slot)
-- 
2.30.2


