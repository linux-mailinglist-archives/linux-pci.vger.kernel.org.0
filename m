Return-Path: <linux-pci+bounces-14796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A79A2515
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBCF1C228CC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084E1DEFC4;
	Thu, 17 Oct 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIBWdmVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF81DE88D;
	Thu, 17 Oct 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175533; cv=none; b=opschQBU6vNlRf5w4fq5oTnMJgbm9tjkZQ1Sjbc34hHGMjJCvb8VZUCAaaLLACLKQ+BwLWw/pa7NUboyuvYLrlg9gLyV9iIuF7BIsUNnkTmgmHmUpea5qmw8bmjnbXGdvwEeCZiQa0YKeAjTmNdmnD4/6jGG1ikJ3Ju7zCJcsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175533; c=relaxed/simple;
	bh=ek+R+U8VO4E/Sgt5FTehDYdQ2ms51/dkMmaYOVVDiKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUFZ23qmuKyVFo094skZ1JK1DaQ0N3WzrI+ApDtVziRloJR3Q+Fa+Eqq/EeKB6Zb3XGPbpi8KhgHbIcsRAugGNnDlxMKoto1fqhM5+EE4zlRcf/PdQi+Bis0oj5vDYUMBvEn4zONE7nadWJwktXVG9ltdp37yQJbVSW6oKYnPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIBWdmVC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729175530; x=1760711530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ek+R+U8VO4E/Sgt5FTehDYdQ2ms51/dkMmaYOVVDiKM=;
  b=TIBWdmVCcddFSgAqTPdEDzgwGtzWLIWKBORhBLXzgGuA9g1EWvr2eZE+
   WRoGtIx/CN5IzVU462Ar957zixKd5PjvZ5KyFIK0w3jyuYWAwEtXUnqFD
   o+fKF8EDy44dVT8z1TCYtlnIzRctDOYa8ADSbuCghtxXRXRj3+SS1LjnV
   3/NCn/uU511+Bv0lHqSVGS+Jdkmm6kSMHDUMWqGEqbCFk7OPcWv21g/yq
   loIyXjPITceCF9ncmAFebwmFM4qcNIOMDiteZEzrG/eYFriBcbgsWY8hI
   gggAmw8YtfDriQIBRJS+Z+JtDgRQT1pvozFAtESIYyY2OAzVfiaqqnohU
   Q==;
X-CSE-ConnectionGUID: W8dtjCWIRqy1HcClGWirdA==
X-CSE-MsgGUID: pLeHy81PQDyfaNK0oBYsJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32592367"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="32592367"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:32:10 -0700
X-CSE-ConnectionGUID: H8p+7t3WRmiH57TL8mSEpg==
X-CSE-MsgGUID: mCHfRscMSf2i/PNoBVgcEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="116002570"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:32:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/4] PCI: cpqphp: Simplify PCI_ScanBusForNonBridge()
Date: Thu, 17 Oct 2024 17:31:31 +0300
Message-Id: <20241017143131.46163-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241017143131.46163-1-ilpo.jarvinen@linux.intel.com>
References: <20241017143131.46163-1-ilpo.jarvinen@linux.intel.com>
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

Leave only a simple comment about the missing recursion for the
unlikely case that somebody comes across the lack of functionality. In
any case, search whether an endpoint exists downstream of a bridge
sounds generic enough to belong to core so if the functionality is to
be extended it should probably be moved into PCI core.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 558866c15e03..b2efc4a90864 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -190,8 +190,7 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 {
 	u16 tdevice;
 	u32 work;
-	int ret;
-	u8 tbus;
+	int ret = -1;
 
 	ctrl->pci_bus->number = bus_num;
 
@@ -208,26 +207,19 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
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
 		}
 	}
 
-	return -1;
+
+	return ret;
 }
 
 
-- 
2.39.5


