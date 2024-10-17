Return-Path: <linux-pci+bounces-14794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 443549A250D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E148BB265C1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072621DED48;
	Thu, 17 Oct 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTD9PVm2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA111DE8A9;
	Thu, 17 Oct 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175520; cv=none; b=HInV0uaKIAfJWT5qKDwnsmG/Q9fJUSi7hpVBh1u8dGRzgjPSPP8gZuHhAy6zfzpX/OVXtIWLItKcD6ydq2NAtnKwt9pX6gm9nUjoydrkAjHA2/SeE6pBGcjCbPHi7bcMOEKFXG5pcA7gidgl3IhH467zfoADhz6r0xOT10uFjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175520; c=relaxed/simple;
	bh=4LJ4d3l78k86ZkaKlk3S4ZkJk0tpxXAt6ZTjN54rH+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tI9HvuVUzFFifP+EXAF7z6V9fI8Tvz2GdWmc2cb5g5jfr2CPk4EkIUsDLkkO8qoGMO/nTOhVSS0+FS6nL+hUp0A7Qs8CZVMDIgT4AvsXHtReWRw3cZmUeIlWu7JsZXZcs0sdnPVMmtTnFj7X5dVya7RS5kkqaNve4HvlQoXt0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTD9PVm2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729175515; x=1760711515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4LJ4d3l78k86ZkaKlk3S4ZkJk0tpxXAt6ZTjN54rH+w=;
  b=lTD9PVm2V4B8+xZwKeUzFdXrkIVr5QtEAbCxRD458y/zAVUFvly9e/IO
   0YNQDyuSOSxqMm0YdBwoISiAr3w0Oya4sW9Tec6x71gSh6c7lek065PvS
   ECwF+lbYeaCCDFlDD/qf06vhHCNOex//vicxvFYezGggqgtSzMS6PFlwf
   dvgZIfpYZdk0XTl8W0CEA/wa7F4daEpwYSMVOt6jHw5VL7EzpypD1TifZ
   AflsAq/P6eYytPdOLrKNPtdpi/mleo9Gm50X8+GAsVRJwUcmDb7fSKDMr
   gdWoXpg7/lVR5FJJwfU54SMoxMZLg7c2i6HU+7vEnx0MqoTBxcYhbguL7
   Q==;
X-CSE-ConnectionGUID: od2GbC7wRdqqwULIeqTcEA==
X-CSE-MsgGUID: 0879va+zTBGdD0blJHyM8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32592298"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="32592298"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:31:55 -0700
X-CSE-ConnectionGUID: bjZP1sdQS0CUVrrtEClglw==
X-CSE-MsgGUID: IxDPdO0cRGuGkljaDjroFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="116002544"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:31:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/4] PCI: cpqphp: Use pci_bus_read_dev_vendor_id() to detect presence
Date: Thu, 17 Oct 2024 17:31:29 +0300
Message-Id: <20241017143131.46163-3-ilpo.jarvinen@linux.intel.com>
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

The intent of the first part in PCI_RefinedAccessConfig() is to
read Vendor ID register and detect presense of the device that way.

Remove PCI_RefinedAccessConfig() (which was not named very helpfully to
begin with) and replace the call with pci_bus_read_dev_vendor_id() +
read config because it makes the logic more obvious at the caller side.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 974c7db3265b..7844007dbc86 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -132,20 +132,6 @@ int cpqhp_unconfigure_device(struct pci_func *func)
 	return 0;
 }
 
-static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 offset, u32 *value)
-{
-	u32 vendID = 0;
-	int ret;
-
-	ret = pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID);
-	if (ret != PCIBIOS_SUCCESSFUL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (PCI_POSSIBLE_ERROR(vendID))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	return pci_bus_read_config_dword(bus, devfn, offset, value);
-}
-
-
 /*
  * cpqhp_set_irq
  *
@@ -211,7 +197,9 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 
 	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		/* Scan for access first */
-		ret = PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work);
+		if (!pci_bus_read_dev_vendor_id(ctrl->pci_bus, tdevice, &work, 0))
+			continue;
+		ret = pci_bus_read_config_dword(ctrl->pci_bus, tdevice, 0x08, &work);
 		if (ret)
 			continue;
 		dbg("Looking for nonbridge bus_num %d dev_num %d\n", bus_num, tdevice);
@@ -224,7 +212,9 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 	}
 	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		/* Scan for access first */
-		ret = PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work);
+		if (!pci_bus_read_dev_vendor_id(ctrl->pci_bus, tdevice, &work, 0))
+			continue;
+		ret = pci_bus_read_config_dword(ctrl->pci_bus, tdevice, 0x08, &work);
 		if (ret)
 			continue;
 		dbg("Looking for bridge bus_num %d dev_num %d\n", bus_num, tdevice);
-- 
2.39.5


