Return-Path: <linux-pci+bounces-25289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B00A7BCDF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C4E7A8507
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D2E18EFD4;
	Fri,  4 Apr 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjeY+OBD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06391DA53;
	Fri,  4 Apr 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743770759; cv=none; b=KScOFDC/A/o8ZGEj+V9MegFRYFc0c6tgDAuoLFnh90GMyuBf711jzds9xn/Q7YSWOIVuyDdHUvINA354Rr+FjoaTywWN2z7xzjDhpc7hpRZ/8swAsggn3SUHIt6FFMaFnetvJkkro7PKsmm/zShMkKkJHJUD0kPgabjCxakVlhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743770759; c=relaxed/simple;
	bh=OwkZP4Kvea55R20rav/AJzdeiy1uMo+XKDTPci+yc7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I6PCdcJfCF48qRb80a5BGPx0D7BzhgyBJfXBdEw8yTbcw3OvJj3lMKEoqWR2+dpMj/vevkvLphFLHUnDb62n8T+6E4sJxzFrp7JtIrhMYWrr7n3swRsiNhElAnATZWEv9iwW5X5I/8G5gvWAEHX7AIQc9fq1jDmRJ8+/nNY9ba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjeY+OBD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743770758; x=1775306758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OwkZP4Kvea55R20rav/AJzdeiy1uMo+XKDTPci+yc7o=;
  b=fjeY+OBDIqb2x5B7WhHGkGtuc9ShP1wkVHqddHophmL4Xoqk3Ex5HdSQ
   Dnm1m/GtwBXC6uLq5NFu1wn5x73kUrqaM4IIPWE4vAypNPx0ROcb3UKvW
   ZuktGjgDaSnIJ48qYiDXK92x2/4sgxuosB6Z14MJVN3IbU13U+z8cppoP
   USA/NoZrgIyjYcrKLWArQuOIZPzD+c/IaPFgvWsQsUaK7GQTL+VfGhNXc
   HoMbYR44V+bsj2K/sCzbvdjUNTynR3Eshn1NZcl07+6ylt8E+/MR1/6Nx
   UjBbGcwEd0lpRzXUn93WLzvrlMx40YhepH0BqfQBSS6jVzK4fF/i44DVM
   g==;
X-CSE-ConnectionGUID: LjAAp6ROQkivwRt/wdllQg==
X-CSE-MsgGUID: l4MR0n6/SyuqTKEaWQT+fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="55872690"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="55872690"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 05:45:57 -0700
X-CSE-ConnectionGUID: NjkaL768QlOg5yFFf60F6g==
X-CSE-MsgGUID: jFM4pnOSR/2oSluuLfo7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132157881"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.54])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 05:45:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Unnecessary linesplit in __pci_setup_bridge()
Date: Fri,  4 Apr 2025 15:45:47 +0300
Message-Id: <20250404124547.51185-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

No need to split the line in __pci_setup_bridge() as it is way shorter
than the limit.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 54d6f4fa3ce1..45bf0ddff118 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -772,8 +772,7 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 {
 	struct pci_dev *bridge = bus->self;
 
-	pci_info(bridge, "PCI bridge to %pR\n",
-		 &bus->busn_res);
+	pci_info(bridge, "PCI bridge to %pR\n", &bus->busn_res);
 
 	if (type & IORESOURCE_IO)
 		pci_setup_bridge_io(bridge);

base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
-- 
2.39.5


