Return-Path: <linux-pci+bounces-29312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E4AD3435
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121EA1890763
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0528CF59;
	Tue, 10 Jun 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJ6JmatJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5228CF4A;
	Tue, 10 Jun 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553124; cv=none; b=fsXAkMXdvh4crWD7Xjw1GINvgXwJB7oNOVi8YysD8LEMrQc9zGFuhqgCGC+GzaYvvFHclU7+arjADDgXmqyOfbCu4WGcvK4q4cxONTFiy3uPQOe3p64mmpa2IS1Hj0DZw7gaxbyYK1GqsS/rZAkcQrecJS8jIepkP2ND2B4wPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553124; c=relaxed/simple;
	bh=qKB1qh3SAFF2YqX1L3i/Zu3nUHW2K2Hh8MGDHZ/OLPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJA6pu+Z7cp1LyZx4Dpo+P4ceQxmzXMNbisYQOVpa8y0k+XWTtOLNE/aCPQgKhIANi5+hZyDCmabULt5YN1FfbxSIInPLNUwcU4eM0CQvz6lYszFnuNDBoO5VBw80SOdvwm3Ec1COCBDNI0DqI3bGEljQBR0S+fxt0ef23/ZPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJ6JmatJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749553123; x=1781089123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qKB1qh3SAFF2YqX1L3i/Zu3nUHW2K2Hh8MGDHZ/OLPE=;
  b=nJ6JmatJle1sy0TRWLF602aXaExu4F0rHboSOuNBFL1IujJc+sJPDtx7
   NzsOmTN4vc1OzEqo0Z98moAVAteDcXDjk3l3e+yskJcP6mAmY6nXS5e0Z
   z2CLs1d9EMQ+xM4/eexOhdkUDG24kpg7e1HxwWiDCYnRMMyeFwVbAA6CQ
   FacdXPyvspTv7C53JWkRav0ti3D87iVP2GY2F9zcw+DXrcLcjVeqf3fx3
   qncg2RdX1bJsbbva6Y5TAqQ/hYnXClXiEvJk4+UEpmVDr3osB2mSXEv+A
   UsR63rPlHeHJhogOLi5CCgtqXCmiXZNLqFtqRzW1U9SyEZGxakX+OOIfI
   Q==;
X-CSE-ConnectionGUID: WuRFDaJSSuiJBUKHunFIDA==
X-CSE-MsgGUID: g4cVaSPeQ+KFpDzq8IJwQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="50764340"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="50764340"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:58:42 -0700
X-CSE-ConnectionGUID: FASxslGtRUq3NCHNddBfRQ==
X-CSE-MsgGUID: Rqpnd7mYSROy/KlLXWg6tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="169979651"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:58:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] PCI: Cleanup pci_scan_child_bus_extend() loop
Date: Tue, 10 Jun 2025 13:58:20 +0300
Message-Id: <20250610105820.7126-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
References: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_scan_child_bus_extend() open-codes device number iteration in the
for loop. Convert to use PCI_DEVFN() and add PCI_MAX_NR_DEVS (there
seems to be no pre-existing defines for this purpose).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   | 1 +
 drivers/pci/probe.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..caa6e02a9aea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -8,6 +8,7 @@ struct pcie_tlp_log;
 
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
+#define PCI_MAX_NR_DEVS	32
 
 #define MAX_NR_LANES 16
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f08e754c404b..963cab481327 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3029,14 +3029,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 {
 	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
 	unsigned int start = bus->busn_res.start;
-	unsigned int devfn, cmax, max = start;
+	unsigned int devnr, cmax, max = start;
 	struct pci_dev *dev;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
 
 	/* Go find them, Rover! */
-	for (devfn = 0; devfn < 256; devfn += 8)
-		pci_scan_slot(bus, devfn);
+	for (devnr = 0; devnr < PCI_MAX_NR_DEVS; devnr++)
+		pci_scan_slot(bus, PCI_DEVFN(devnr, 0));
 
 	/* Reserve buses for SR-IOV capability */
 	used_buses = pci_iov_bus_range(bus);
-- 
2.39.5


