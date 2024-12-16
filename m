Return-Path: <linux-pci+bounces-18553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A426B9F3860
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E83D16CE33
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F582207DE6;
	Mon, 16 Dec 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIO0COi/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AAF208984;
	Mon, 16 Dec 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371952; cv=none; b=WZIiV064DXEgEeHg1YCCadcnP/BL0R/xbiJNCdBwahMHrdwfjTJuETa1peJi364PID07srFrlvzzcLTFSXv7t56F0HMRaaLRN70vjd65ifiW0254T41WE+cFteWNgaTaQTC1PYXFJT2MEvG8uSZ4t5YsLnwB+TscTFSDuP3S7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371952; c=relaxed/simple;
	bh=eQtWuXJHJ9eWQ0mMHPPcvoBKYqVq+l+21AkCILaf4gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N72+wm0bcL/Sn+C6DaeHnbkJDyQBFFALDYDomk1QUh5yyI7JcO94AEYIhN1c9sBW8c10i+tH3fr8fdTK6W+x87W7lidKjF5YfPFX86RHgEEhJNEPrQHI8DlSbb6wogn0Uiw8XA8HrmxsSQuP7c/kUt99h5hZsWs3SoxrzWY82J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIO0COi/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371952; x=1765907952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQtWuXJHJ9eWQ0mMHPPcvoBKYqVq+l+21AkCILaf4gg=;
  b=ZIO0COi/eGaU1jBE1ComSJgVbVJJZ6l3uvq2F/E68CcqaposGfzhfuDz
   paANuk7EFR5empEuPgjwNONsCvIGjXJQu3W5elxCsfIvplXIQZpnqmrhf
   7KJ/z1kc+9vZ5ci1IzzdbY8KXU8CU8bFhxG/nbuFQCXRt9qiovSBLvKRm
   ygpXPwozAxTSPkwDjIjlULw2BmHp8Mt4v3CoKGo3pDg8Wx12yMqIZozbu
   cnyGjGQ2PS2EuCOJH82o6NBihcmQLPD7Mkbvc3WY+QR4ngrUYliXDret0
   xGuwtqO9vHakNHJPvKUYC02z0z6yA4A2bvi0jQIQeY8paxrHwAn0ZykcL
   g==;
X-CSE-ConnectionGUID: oa1GA7zCTsShKkUM54xqGQ==
X-CSE-MsgGUID: I+aHWgxKTZ+arsdZlCpmJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52183777"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52183777"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:11 -0800
X-CSE-ConnectionGUID: pDCigzt4SMO0KYjQODDeIg==
X-CSE-MsgGUID: 7sisdlSYRAa1YEbFeO1IQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="128075865"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:59:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 18/25] PCI: Add restore_dev_resource()
Date: Mon, 16 Dec 2024 19:56:25 +0200
Message-Id: <20241216175632.4175-19-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resource fitting needs to restore the saved dev resources in a few
places. Add a restore_dev_resource() helper for that.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7e5985543734..d30e8a5a0311 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -127,6 +127,15 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	return dev_res ? dev_res->min_align : 0;
 }
 
+static void restore_dev_resource(struct pci_dev_resource *dev_res)
+{
+	struct resource *res = dev_res->res;
+
+	res->start = dev_res->start;
+	res->end = dev_res->end;
+	res->flags = dev_res->flags;
+}
+
 static bool pdev_resources_assignable(struct pci_dev *dev)
 {
 	u16 class = dev->class >> 8, command;
@@ -473,13 +482,8 @@ static void __assign_resources_sorted(struct list_head *head,
 			release_resource(res);
 	}
 	/* Restore start/end/flags from saved list */
-	list_for_each_entry(save_res, &save_head, list) {
-		res = save_res->res;
-
-		res->start = save_res->start;
-		res->end = save_res->end;
-		res->flags = save_res->flags;
-	}
+	list_for_each_entry(save_res, &save_head, list)
+		restore_dev_resource(save_res);
 	free_list(&save_head);
 
 requested_and_reassign:
@@ -2159,9 +2163,7 @@ static void pci_prepare_next_assign_round(struct list_head *fail_head,
 		struct pci_dev *dev = fail_res->dev;
 		int idx = pci_resource_num(dev, res);
 
-		res->start = fail_res->start;
-		res->end = fail_res->end;
-		res->flags = fail_res->flags;
+		restore_dev_resource(fail_res);
 
 		if (!pci_is_bridge(dev))
 			continue;
@@ -2378,13 +2380,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 
 cleanup:
 	/* Restore size and flags */
-	list_for_each_entry(dev_res, &failed, list) {
-		struct resource *res = dev_res->res;
-
-		res->start = dev_res->start;
-		res->end = dev_res->end;
-		res->flags = dev_res->flags;
-	}
+	list_for_each_entry(dev_res, &failed, list)
+		restore_dev_resource(dev_res);
 	free_list(&failed);
 
 	/* Revert to the old configuration */
@@ -2394,9 +2391,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		bridge = dev_res->dev;
 		i = pci_resource_num(bridge, res);
 
-		res->start = dev_res->start;
-		res->end = dev_res->end;
-		res->flags = dev_res->flags;
+		restore_dev_resource(dev_res);
 
 		pci_claim_resource(bridge, i);
 		pci_setup_bridge(bridge->subordinate);
-- 
2.39.5


