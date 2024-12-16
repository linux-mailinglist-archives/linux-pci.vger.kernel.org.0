Return-Path: <linux-pci+bounces-18548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174399F384D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889AD167CFE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F52820E321;
	Mon, 16 Dec 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Le+c/Gek"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8C20E038;
	Mon, 16 Dec 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371918; cv=none; b=nd/Qa3jjBMbSizANTOf2UXLACuo/ObSqBNPFyhXXNA21KbWA0cDiC68AMkk4+bCq6/JUNHydChxXw9p25zV+55XagW4dkiFpR7x1DFPdZeB0WCv22SEYfpGySm7D0l5nMfb/7wgy4w2boGhXJFvy/Tsv7FWNfqU+SLClr4N5Utk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371918; c=relaxed/simple;
	bh=vm6XgHjYOHoP+wOWdHcRPtAguPDJoFo34GGUVlmf8vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lewU0urBxVvuBItgbg2hGK2fxxMr/AO0nFXg0AIuaFYU0uacV7uXwQCZ31x0AYbgeOCV7WVPeP4MYHqJFyX76uFH0U46ox7BEZKH4+oOcawspAW/+pHw2qbxzqe+FtxR3OSIMo9ETC3DPs+rtlc03bkfYsD5mFY2eNFXMsZgCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le+c/Gek; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371917; x=1765907917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vm6XgHjYOHoP+wOWdHcRPtAguPDJoFo34GGUVlmf8vo=;
  b=Le+c/Gek/+M388X/p7PI5GsYUu0YOPMosoT7+f4Lrl/fqNzM54yydh1J
   ItjKDbA9QyDLaVS/Aj5CHVeyG1qwbzLfTlfudrfcVxQrO+UGzgz0+UkZ6
   Q15gOJbmC6FWlYrQjKd6kWcUj7poLToqTAmBSaUxc5ysTNuAFczDyEdpl
   9z19urzZgYjuj4pCbwYBuYJTLrZFsJWrvvOWCZqmESMGd8S4D74IeYuBI
   NdkkeL1+5IhO4Zp1AWJFLtpS//DCcEzD9ShFK5XrT2l6daVnYv4L+GWAI
   ph/VB637ssuXjQiiRk01ALnrsmdqrY6BVs+19pIefroWkHu08xS5ROrcM
   Q==;
X-CSE-ConnectionGUID: J/qYGVe8QWGVsOcoAdAg7w==
X-CSE-MsgGUID: Mw+oUBeTQpqnb2OPzMl7Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57250957"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57250957"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:32 -0800
X-CSE-ConnectionGUID: 8kKD6bYpRAOJQYki8BnUGg==
X-CSE-MsgGUID: c1zu1P8bQN+FbuQI+eoxcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101419065"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 13/25] PCI: Refactor pdev_sort_resources() & __dev_sort_resources()
Date: Mon, 16 Dec 2024 19:56:20 +0200
Message-Id: <20241216175632.4175-14-ilpo.jarvinen@linux.intel.com>
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

Reduce level of call nesting by calling pdev_sort_resources() directly
and by moving the tests done inside __dev_sort_resources() into
pdev_resources_assignable() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 44 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ad7bc6166b23..ba935a050be3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -127,12 +127,33 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	return dev_res ? dev_res->min_align : 0;
 }
 
+static bool pdev_resources_assignable(struct pci_dev *dev)
+{
+	u16 class = dev->class >> 8, command;
+
+	/* Don't touch classless devices or host bridges or IOAPICs */
+	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
+		return false;
+
+	/* Don't touch IOAPIC devices already enabled by firmware */
+	if (class == PCI_CLASS_SYSTEM_PIC) {
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		if (command & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
+			return false;
+	}
+
+	return true;
+}
+
 /* Sort resources by alignment */
 static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 {
 	struct resource *r;
 	int i;
 
+	if (!pdev_resources_assignable(dev))
+		return;
+
 	pci_dev_for_each_resource(dev, r, i) {
 		const char *r_name = pci_resource_name(dev, i);
 		struct pci_dev_resource *dev_res, *tmp;
@@ -176,25 +197,6 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	}
 }
 
-static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
-{
-	u16 class = dev->class >> 8;
-
-	/* Don't touch classless devices or host bridges or IOAPICs */
-	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
-		return;
-
-	/* Don't touch IOAPIC devices already enabled by firmware */
-	if (class == PCI_CLASS_SYSTEM_PIC) {
-		u16 command;
-		pci_read_config_word(dev, PCI_COMMAND, &command);
-		if (command & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
-			return;
-	}
-
-	pdev_sort_resources(dev, head);
-}
-
 static inline void reset_resource(struct resource *res)
 {
 	res->start = 0;
@@ -498,7 +500,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 {
 	LIST_HEAD(head);
 
-	__dev_sort_resources(dev, &head);
+	pdev_sort_resources(dev, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
 }
@@ -511,7 +513,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	LIST_HEAD(head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, &head);
+		pdev_sort_resources(dev, &head);
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
2.39.5


