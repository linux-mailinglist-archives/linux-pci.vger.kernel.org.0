Return-Path: <linux-pci+bounces-13829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8394099074F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4463F285D1E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52741158214;
	Fri,  4 Oct 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7LxE/XT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A71D9A65;
	Fri,  4 Oct 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055394; cv=none; b=Mn2grAmHhilpREtUHSQLpoxvqzBX0Pa2nVu8weyjOBTUpRpfrpNiPspuS4er36qv9vVCSfxtca/vxzQoCLxjD/J0WltJ6+I9NWWNv7m7i/+wPHWmj9Yi/K8C1Qvu/mvwofjqhWp5osFUKnUDH9V4mvMvY4kYWSTFYQZUrb1lRmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055394; c=relaxed/simple;
	bh=gB0lccy7osxLIluMlYyLJbXzP5wnHbf05pD8Z31ateg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YQWLDrQwjPI5Z2kG18u8WOGGmdpU5jdfThSMXe+1YU0faA6LRSF2YvzaTa3sG+gkhwEVzB0UgzcDrT4wYSF7XT21hfeFubH9O8tAiUzaENnUQbgOPFV3W7n92VBP3JYb7h+0RkI49wNcW0x0uSPxkEUBjrkxfP1In6gpiESvnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7LxE/XT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728055393; x=1759591393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gB0lccy7osxLIluMlYyLJbXzP5wnHbf05pD8Z31ateg=;
  b=I7LxE/XT8x59YcfSMk9oQb4Dyrc/Fnn4NmrOp3X2+5VoyZ+lbB8FXdId
   P2w15fezUzT6tPVsT+t27NMoSu3ijlp8TspBbu3CRB0/d+0m/iMjUx2OK
   HaNrwhHy11rGCJ+oaiRCZ3+aUEeufPQjQGxCB7zhM00nePt3xsnOlWHdV
   BFb4iSRzR3pzfow5d0WM77enNbd3h0FHdNRyy9xhBkbcnBRejzLPHbjGi
   D7nkwImV+KLtJp5VzO3aU1783vghruK4F/qRTpw/Pa9J4Kt5sgWpm303X
   L/9JAIL6unCjPYxNBajTPyi/shXbWK8hASgxBtCQHPmhbY4BLeYYR2Nzn
   A==;
X-CSE-ConnectionGUID: HJo4rwpIQ4G57zeKSDGtTw==
X-CSE-MsgGUID: AwBLi4k6RQaWEHbivOed3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27411425"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27411425"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 08:23:12 -0700
X-CSE-ConnectionGUID: mhsfSZS2Sb+NlcD7qTdMFQ==
X-CSE-MsgGUID: w8c1Px62TSmCZ4yZPMIxZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="105476429"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 08:23:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Cleanup convoluted logic in pci_create_slot()
Date: Fri,  4 Oct 2024 18:22:40 +0300
Message-Id: <20241004152240.7926-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_create_slot() has an if () which can be made simpler by splitting
it into two parts. In order to not duplicate error handling, add a new
label too to handle kobj put.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/slot.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 0f87cade10f7..9ac5a4f26794 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -244,12 +244,13 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot = get_slot(parent, slot_nr);
 	if (slot) {
 		if (hotplug) {
-			if ((err = slot->hotplug ? -EBUSY : 0)
-			     || (err = rename_slot(slot, name))) {
-				kobject_put(&slot->kobj);
-				slot = NULL;
-				goto err;
+			if (slot->hotplug) {
+				err = -EBUSY;
+				goto put_slot;
 			}
+			err = rename_slot(slot, name);
+			if (err)
+				goto put_slot;
 		}
 		goto out;
 	}
@@ -278,10 +279,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	err = kobject_init_and_add(&slot->kobj, &pci_slot_ktype, NULL,
 				   "%s", slot_name);
-	if (err) {
-		kobject_put(&slot->kobj);
-		goto err;
-	}
+	if (err)
+		goto put_slot;
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
@@ -296,6 +295,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	kfree(slot_name);
 	mutex_unlock(&pci_slot_mutex);
 	return slot;
+
+put_slot:
+	kobject_put(&slot->kobj);
 err:
 	slot = ERR_PTR(err);
 	goto out;
-- 
2.39.5


