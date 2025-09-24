Return-Path: <linux-pci+bounces-36857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C1B9A13F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4FA1B23996
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF12DFA3B;
	Wed, 24 Sep 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4a1W90o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F42DC773;
	Wed, 24 Sep 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721373; cv=none; b=YLiDfRWsJpZXs/L9Ui/Jx7DDpjFgAu8l1ghKiqYJQsDOwkveLeZsbdFXtT1evg94mwdofZX+OnlUe6Exof9xM5PkYThMJDLvR0CQKn9dhGT5gVI8kMDZYPolRT3Q0BBk1TaIHOFIRfBpte1R4iYjLn92T/YwdfHbcUf/sZtWlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721373; c=relaxed/simple;
	bh=gHh8ZmtXsh6MeRMXmjs/KSv7aeUMyRm8SCGi9ozzCRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0ECmXQScwms1dgp1xOrqf8oWBMSU5jtgog0YIZa1J+MNK0EZyQbLzkB96EDyLK4/VvqQuLuoPPwQn1xSABAsJNNCFWR3AyVRF94c6zIoINpzPr/Okz8fJVNh3bZrH/5rfT4q3gKjCMlcQiNU/NKm9iRvSsbrimYxwcBLiCpPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4a1W90o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758721371; x=1790257371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gHh8ZmtXsh6MeRMXmjs/KSv7aeUMyRm8SCGi9ozzCRo=;
  b=T4a1W90onCLxKWg4Zk0Doo43hfCDDk6A3V6J9/NcpHaMTwvOSzl+jFjc
   lWtS9jvtc6terhuhPSEB9VLWtGAcZFInu8abNS77Q8Giz0/BO6ZD0NWGB
   sxGaTy1pYQWczfxlKHvX98iuk3Uu2sIqUynzGvhCm6u2fVZStGTqsW8i9
   tke86PL8vJmHLJhJuf1fFvCAXHdvMDtaOsRwsuiNAr4ZqFumnT5K+GNiQ
   tsDNu0qT5FG9aTmUs3JtN3NAsu4evJKg3R29UAOUupDMRcjkN846ekUHc
   p59wVgOTbsxq3gQycbDbNqA0Xs4CqmZh6NSe/DEldzfph8QTxD7gtZw9m
   Q==;
X-CSE-ConnectionGUID: qSQc2gj2TKaNM9jHSK/jzQ==
X-CSE-MsgGUID: 9icXB3RhRACTfeQM+IZrTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64854836"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="64854836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:42:50 -0700
X-CSE-ConnectionGUID: nf0yMCeeSIiwcgTRa9v2Qw==
X-CSE-MsgGUID: IFc2PQIpRnGKfWjnA14k7A==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:42:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] PCI: Setup bridge resources earlier
Date: Wed, 24 Sep 2025 16:42:27 +0300
Message-Id: <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bridge windows are read twice from PCI Config Space, the first read is
made from pci_read_bridge_windows() which does not setup the device's
resources. It causes problems down the road as child resources of the
bridge cannot check whether they reside within the bridge window or
not.

Setup the bridge windows already in pci_read_bridge_windows().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I'm not entirely sure what is the reason why the bridge resources were
not set up by pci_read_bridge_windows(). So far I'm yet to run into any
issues because of that but perhaps there's some good reason for that
I'm not aware of?

This patch likely allows also removing pci_bridge_check_ranges() but I'm
yet to confirm that.

 drivers/pci/probe.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca7..7f9da8c41620 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -524,10 +524,14 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 	}
 	if (io) {
 		bridge->io_window = 1;
-		pci_read_bridge_io(bridge, &res, true);
+		pci_read_bridge_io(bridge,
+				   pci_resource_n(bridge, PCI_BRIDGE_IO_WINDOW),
+				   true);
 	}
 
-	pci_read_bridge_mmio(bridge, &res, true);
+	pci_read_bridge_mmio(bridge,
+			     pci_resource_n(bridge, PCI_BRIDGE_MEM_WINDOW),
+			     true);
 
 	/*
 	 * DECchip 21050 pass 2 errata: the bridge may miss an address
@@ -565,7 +569,10 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 			bridge->pref_64_window = 1;
 	}
 
-	pci_read_bridge_mmio_pref(bridge, &res, true);
+	pci_read_bridge_mmio_pref(bridge,
+				  pci_resource_n(bridge,
+						 PCI_BRIDGE_PREF_MEM_WINDOW),
+				  true);
 }
 
 void pci_read_bridge_bases(struct pci_bus *child)
-- 
2.39.5


