Return-Path: <linux-pci+bounces-14992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7379A9E12
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AFC1F26833
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DA1198E61;
	Tue, 22 Oct 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLVBPyNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DF146019;
	Tue, 22 Oct 2024 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588337; cv=none; b=CgmCRb3enf0Kf8TndDNy3ke6Yht07lbx+gtb3tML8qtnq2lzN6J9nFsg+RviuoNtXqbTR/1+ViXufomGodg97FLAAHjwJ8mqyj32RX9kyECxiQ6ozpp9FKOaHPqddh+jgWR952CyHQiPayFShxxfcAGetRqqO1Lg+HPHcWyzazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588337; c=relaxed/simple;
	bh=KGDP7VI1pQb1iUfsRT1pBSqOi6/saODSeKZUhCGUWUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONfekVAElQYaJkcv50wShNxHOOwuMe+nbgGqS128APCh+XrTYrnlQQdhuNP62DIfgVCqeZtlmKWYwdb7jC2QwztG0xJptRf1Zf+3JZvu0ZHtRus+6POZdJTQ9d0xw2X2TOq9H+36QIR4aM8sFKba8Vj+emBIxEqXFPCxLfT2YZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLVBPyNg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729588336; x=1761124336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KGDP7VI1pQb1iUfsRT1pBSqOi6/saODSeKZUhCGUWUY=;
  b=CLVBPyNgJI442KtR8fbUcoY/3XMFpadekFQ5zls2IYngL4N/MX4CYNHk
   NmGLyVojs3dCAit+ULJtKpNfDGQ94TpbosGa3EbA5yWrq7MuAwxOET4WH
   f13FWNEQzZ1DEZJtFo9Z+lzBJu5/i0c73k7vVslS+LuHaybTDlNB3HBso
   iIkvMu/AGIPK4/NpZJYVks0UPk0qOQXqWgAdvbzr3Hn22XFz+VmCgoRMi
   6KrC9B2vmsCS1M+AAzkMhyL6xhiv2Tmp/hunkTHu9tVnbO6WdtKaNRZaK
   ws5OF8Q1jVnozzQyuXdM6YSklM0y0SrLHRse1BCsOBTYJrbVedCmcmw52
   w==;
X-CSE-ConnectionGUID: XFo7W0mtSvKkr2k8XgtCvA==
X-CSE-MsgGUID: SIxHC8zzRnaZP9j7blJJHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28885737"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28885737"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:12:16 -0700
X-CSE-ConnectionGUID: YPi8VKT4SB26aWdABwwMRw==
X-CSE-MsgGUID: XDZ8z7AeQ5iq18dNhKmDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80158002"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:12:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/4] PCI: cpqphp: Simplify PCI_ScanBusForNonBridge()
Date: Tue, 22 Oct 2024 12:11:40 +0300
Message-Id: <20241022091140.3504-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022091140.3504-1-ilpo.jarvinen@linux.intel.com>
References: <20241022091140.3504-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI_ScanBusForNonBridge() has two loops, first searching for
non-bridges and second that looks for bridges. The second loop has
hints in a debug print it should do recursion for buses underneath the
bridge but no recursion is attempted.

Since the second loop is quite useless in its current form, just
eliminate it. This code hasn't been touched for very long time so
either it's unused or the missing parts are not important enough for
anyone to attempt to add them.

Leave only a warning print and comment about the missing recursion
for the unlikely case that somebody comes across the lack of
functionality. In any case, search whether an endpoint exists
downstream of a bridge sounds generic enough to belong to core so if
the functionality is to be extended it should probably be moved into
PCI core.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 34 ++++++++++++++------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 558866c15e03..ef7534a3ca40 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -12,8 +12,11 @@
  *
  */
 
+#define pr_fmt(fmt) "cpqphp: " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/printk.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
@@ -190,8 +193,7 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 {
 	u16 tdevice;
 	u32 work;
-	int ret;
-	u8 tbus;
+	int ret = -1;
 
 	ctrl->pci_bus->number = bus_num;
 
@@ -208,26 +210,20 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 			*dev_num = tdevice;
 			dbg("found it !\n");
 			return 0;
-		}
-	}
-	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
-		/* Scan for access first */
-		if (!pci_bus_read_dev_vendor_id(ctrl->pci_bus, tdevice, &work, 0))
-			continue;
-		ret = pci_bus_read_config_dword(ctrl->pci_bus, tdevice, PCI_CLASS_REVISION, &work);
-		if (ret)
-			continue;
-		dbg("Looking for bridge bus_num %d dev_num %d\n", bus_num, tdevice);
-		/* Yep we got one. bridge ? */
-		if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
-			pci_bus_read_config_byte(ctrl->pci_bus, PCI_DEVFN(tdevice, 0), PCI_SECONDARY_BUS, &tbus);
-			/* XXX: no recursion, wtf? */
-			dbg("Recurse on bus_num %d tdevice %d\n", tbus, tdevice);
-			return 0;
+		} else {
+			/*
+			 * XXX: Code whose debug printout indicated
+			 * recursion to buses underneath bridges might be
+			 * necessary was removed because it never did
+			 * any recursion.
+			 */
+			ret = 0;
+			pr_warn("missing feature: bridge scan recursion not implemented\n");
 		}
 	}
 
-	return -1;
+
+	return ret;
 }
 
 
-- 
2.39.5


