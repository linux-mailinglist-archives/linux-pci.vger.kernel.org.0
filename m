Return-Path: <linux-pci+bounces-29319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16400AD355B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42807A7246
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B8229B0E;
	Tue, 10 Jun 2025 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfcfegyw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB3226170;
	Tue, 10 Jun 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556566; cv=none; b=TDqLmEEHSexXgEm462rRAjf/ZeQp290vZjsFqUpb+wEBh1cO1RC89bmjHSjvaJM5AQBGlaXddTKg+qTY3+NGOOTu9zwJSMEws7sOLjwXZeer7AxVOUVZLsoTpSBHQ230CLMKXLZZPSQ7DCNIbIwKjPnfOYSPq0ph5QtFlYL0J1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556566; c=relaxed/simple;
	bh=kF35YuumCAOOlSxyUic3qGn/Tp0TbpMuTJpI1D4h1u8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r1tP2hsobkT2X9FRcd4/bNkpceH64VUe69WosWhebaaQ4olC/JqQpx7oBlm4qTW+SpZABwQqQP/04Dot53Py/ujxhMBKPehV/OIKhO8DlIJly8s1vdXtI6gPNS/e3aGAbl42WoFd+4eZXdxvvtUmwaVemWbmLMFwZ+JwMDCvU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfcfegyw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749556564; x=1781092564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kF35YuumCAOOlSxyUic3qGn/Tp0TbpMuTJpI1D4h1u8=;
  b=bfcfegywr8b4nDx0W+wOiu/44OXVQMxZ9cbMcwEEY25e/hFya/eiiDsx
   6bAJqczocKHIyIDktkG/aagKv7UJ5IPGP+sNQX0tAtKcwnkBlAWeTK9Ft
   f/WtmP6NeUImVzigb4SnH+10KSSZ1TKbbKoFp+3NL56PxfnlRYCoee4Mp
   NW17YmPFJi5w20dEzOMVYI/ES2Xb1JUE96uTNLibdJAohB/9oMDABkSny
   V/RxlgIEiC2TLEgQd7O8byfHBl9XX0CuwH0yS0Jj8+u8StKH6wu912WQ1
   amb/gOXvm+CIHRf0dS++lZQbZi8iKNTRAESjskfBzgzsMDgQ1/+gIYYN7
   w==;
X-CSE-ConnectionGUID: DO8noWLJS32yk8NEoZglNQ==
X-CSE-MsgGUID: 6tdevFNlQO6amhmJvf7l5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51539594"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51539594"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:55:45 -0700
X-CSE-ConnectionGUID: kvvumaLWTIOYtdkvKwroeQ==
X-CSE-MsgGUID: CFv12QXwTn6Q9fAP0xHthQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147388557"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 04:55:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Fix secondary bus wait return value when D3cold delay = 0
Date: Tue, 10 Jun 2025 14:55:31 +0300
Message-Id: <20250610115532.7591-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If D3cold delay is zero, pci_bridge_wait_for_secondary_bus()
immediately returns 0 which is inconsistent with the rest of the
function.

When D3cold delay is 0, infer the return value like in the other cases.
With link_active_reporting, use Data Link Layer Link Active (PCIe spec
r6.2 sec. 7.5.3.8) and otherwise call pci_dev_wait() with zero delay.

Fixes: ad9001f2f411 ("PCI/PM: Add missing link delays required by the PCIe spec")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I've not seen this to cause issue anywhere, it's just the inconsistency
that caught my eye while trying to figure an entirely unrelated issue.

 drivers/pci/pci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113b..a6182261b433 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4848,6 +4848,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 {
 	struct pci_dev *child __free(pci_dev_put) = NULL;
 	int delay;
+	u16 status;
 
 	if (pci_dev_is_disconnected(dev))
 		return 0;
@@ -4870,15 +4871,19 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 
 	/* Take d3cold_delay requirements into account */
 	delay = pci_bus_max_d3cold_delay(dev->subordinate);
-	if (!delay) {
-		up_read(&pci_bus_sem);
-		return 0;
-	}
 
 	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
 					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
+	if (!delay) {
+		if (dev->link_active_reporting) {
+			pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
+			return status & PCI_EXP_LNKSTA_DLLLA ? 0 : -ENOTTY;
+		}
+		return pci_dev_wait(child, reset_type, 0);
+	}
+
 	/*
 	 * Conventional PCI and PCI-X we need to wait Tpvrh + Trhfa before
 	 * accessing the device after reset (that is 1000 ms + 100 ms).
@@ -4908,8 +4913,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		u16 status;
-
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
 

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.39.5


