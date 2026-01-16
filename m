Return-Path: <linux-pci+bounces-45042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB556D31686
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51BFA3085589
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C6225A38;
	Fri, 16 Jan 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HK7m9FsA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D122217723;
	Fri, 16 Jan 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568281; cv=none; b=JTjuv9UyA/AI86OOU0dBYELQT48OfA2bYfouazuS8ZVMbYjso59v18YibJwhgPWQiwK4zxsIpkhO2Dbafz5C7vfYdQfcFDaL1SSc+rkuzeWAAnED/Ilic5iDaYl6A0q6eDxFsd+ymU2wiDVJ0rJIVVVdVifYXnAK1c8X2iAbyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568281; c=relaxed/simple;
	bh=JPavpiMWH9fnbCMhydtcUUmZ9VS9PmQhmFdCqXKHAyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8YChqsC/aLUhWygiCPkOzpEdW5QkWx9r3iLhwWiCMF6PgBNCatx70uk6AsLaqAeXE4cJJifFh6ggmeeITLCH/04IhhIJooJCaV9ODN+bqmKAR/P5w66xLk5zCBH2bl+RYafGyjch7Lu5fcdt+Chcm9rLPZLYKCqlvTT3cVbt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HK7m9FsA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768568280; x=1800104280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JPavpiMWH9fnbCMhydtcUUmZ9VS9PmQhmFdCqXKHAyc=;
  b=HK7m9FsAjQthmqvfT40Zs+nl73Ao1nLIQSrMONEk3FRz0eN74SfJUlqo
   O+xNyUXV6X3iGv0WkidkhFUci9VqHqXE8TtnDmPSbZEN06KQCQHDK8/9y
   Bcqz+4Co+QAakClEGy2hp0Y+Th5+1p5HToIVFr5AhrTALlMleueNhlziq
   ITfCQRKdRn8L63qQ4Au0GP+XvpsWZ1B4lJqUddD4BXPT+JSLi2za1Lm2u
   igrgsTiw5KY9N7Vdrk1ONSG0D/i/rhEFqJjbprkqN5Y7LMZccds4AmGGt
   jkRC23IQQ8B/WoxvhPSnsYTkXDaWP/v6Rwh2Y3SBTt/sUTkPP1LaXRKmO
   g==;
X-CSE-ConnectionGUID: N4y/8DjTSFGEV31soKCqBQ==
X-CSE-MsgGUID: eCWR9NRUSiKwiYD4zI//lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="80603128"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="80603128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:58:00 -0800
X-CSE-ConnectionGUID: bG/S2c3zSNWOsFkxRWoCWw==
X-CSE-MsgGUID: gqTCZmLfQVSTCPQGhnDxBg==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:57:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>,
	Keith Busch <kbusch@kernel.org>,
	"Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>,
	Alex Williamson <alex@shazbot.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI: Use lockdep_assert_held(pci_bus_sem) to verify lock is held
Date: Fri, 16 Jan 2026 14:57:40 +0200
Message-Id: <20260116125742.1890-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
References: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The function comment for pci_bus_max_d3cold_delay() declares
pci_bus_sem must be held while calling the function which can be
automatically checked. Add lockdep_assert_held(pci_bus_sem) to
confirm pci_bus_sem is held.

Also mark the comment line with Context prefix.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 75a98819db6f..29a365e2dd57 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
+#include <linux/lockdep.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/pci.h>
@@ -4622,7 +4623,7 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
  * spec says 100 ms, but firmware can lower it and we allow drivers to
  * increase it as well.
  *
- * Called with @pci_bus_sem locked for reading.
+ * Context: Called with @pci_bus_sem locked for reading.
  */
 static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
 {
@@ -4630,6 +4631,8 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
 	int min_delay = 100;
 	int max_delay = 0;
 
+	lockdep_assert_held(&pci_bus_sem);
+
 	list_for_each_entry(pdev, &bus->devices, bus_list) {
 		if (pdev->d3cold_delay < min_delay)
 			min_delay = pdev->d3cold_delay;
-- 
2.39.5


