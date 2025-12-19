Return-Path: <linux-pci+bounces-43434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980AECD13D6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 432A130B7C26
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB234845C;
	Fri, 19 Dec 2025 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkKBrnlL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80028346E44;
	Fri, 19 Dec 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166210; cv=none; b=pbCuoXOk+Ka+B2p+5wxZ0qwBhjRDfPfmRl1zgk+3cXPALIcekgJIMnOOjEiZgxVMZj9dIY54ZX6GQFNOddVes2AMMFS3pOikG2OHhmK7cfB9grM9bl/APX2kboRmcKXYwWOyWDXri5VkqvhEptx5L+Qpwkx/ugiRTN2wS484fhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166210; c=relaxed/simple;
	bh=TjgZ9GoPlDYwPaiklMqRtH0SVX2Ueo4AQ9Ylb+5Zvuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Um7HofT4fkSfZQurcXjHbt/+MR06mMrSPboGXMks7VH3JtvyMZybHHyy2UzpPiZghe+mcMaoM8EzoUQSu1yjHOpEPFFaHGpB2BZ4WGxGkRe6I3+eliJoZfaTA2Pylgi9r8uor7You3ECIo//yQvDui7OlaKOnJ2b6K07luuf1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkKBrnlL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166208; x=1797702208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TjgZ9GoPlDYwPaiklMqRtH0SVX2Ueo4AQ9Ylb+5Zvuw=;
  b=bkKBrnlLXz0P9S1/i03BXV5Iom3eyPE2PhAUF5tlgXdeo2p3RTy8pz51
   OImd0BO8jK8Vwo2Co+3YL7jfTQMosbgc9qT/KjOqhOx8O/SMTcvCwWx5F
   BmqLylzycX8Y13ds3mTUuRcMlTZS3xDSJd0x6k3vBfNJmEcf4mEZN0z4K
   /Q0TT1/zxpuP3ZKJaW9XAmyyMiL9Ts6qGJvkopQ2WSrHyx5GEMXj/5ei8
   dHZi0dFbI9e6ZXyQEWSsZfMsUrtcLj05BDNjEfYoD5cAN09WUOUvwmxTN
   +CE/+ePFKfNPGvGowoevFsgaC//avcNTmnsnPh+NMODmdfc5cuxsKeVio
   A==;
X-CSE-ConnectionGUID: GEWshZSCSAWm5BYWxq3txg==
X-CSE-MsgGUID: TP4f8aD4Q5mVmSKUuURTsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78764461"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="78764461"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:26 -0800
X-CSE-ConnectionGUID: wnpqMUtcQtevZwT1v63keg==
X-CSE-MsgGUID: cN1QY9FmSaiRqFYsWXVP3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198066198"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 19/23] PCI: Use scnprintf() instead of sprintf()
Date: Fri, 19 Dec 2025 19:40:32 +0200
Message-Id: <20251219174036.16738-20-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Using sprintf() is deprecated as it does not do proper size checks.
While the code in pci_scan_bridge_extend() is safe wrt. overwriting the
destination buffer, use scnprintf() to not promote use of a deprecated
sprint() (and allow eventually removing it from the kernel).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..5d8ce6381dff 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
+#include <linux/sprintf.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/aer.h>
@@ -1573,9 +1574,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
 	}
 
-	sprintf(child->name,
-		(is_cardbus ? "PCI CardBus %04x:%02x" : "PCI Bus %04x:%02x"),
-		pci_domain_nr(bus), child->number);
+	scnprintf(child->name, sizeof(child->name),
+		  (is_cardbus ? "PCI CardBus %04x:%02x" : "PCI Bus %04x:%02x"),
+		  pci_domain_nr(bus), child->number);
 
 	/* Check that all devices are accessible */
 	while (bus->parent) {
-- 
2.39.5


