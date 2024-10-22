Return-Path: <linux-pci+bounces-14990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C39A9E06
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C3285EA4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B096196DA2;
	Tue, 22 Oct 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG0YlhqD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C3196D98;
	Tue, 22 Oct 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588324; cv=none; b=h5dCogyjiwE+LGpcjGXDGNNlmgMWYZRVhMjTG3as1RTIt8byKi3OMYXq27LzgiV8camfOe3HIiDdURFLqCB/vQQWrxHafpU7icQNgnEq8efhJ4Mrgg2AtPcCavnQt6w6d3GJVCeC4TW7cuy0DtQHpZVPDHJZUfps1zIu/0O/EFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588324; c=relaxed/simple;
	bh=4LJ4d3l78k86ZkaKlk3S4ZkJk0tpxXAt6ZTjN54rH+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rx84JrH8O1FjhYJ1yz/2M9/nicEfsqQ2y5YHj8PH4FLmXsv3b0CoxiR+TcRu3RWJMSI8xPxeGLkN0BQXdcELzWumditDICNfC9GIek560/pCB4MXdzt9+Se9N+IVCcoDrY0YxpEYQs21g20Lrw5Z/ftdx1FlGv8JfKVz1dPrMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG0YlhqD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729588323; x=1761124323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4LJ4d3l78k86ZkaKlk3S4ZkJk0tpxXAt6ZTjN54rH+w=;
  b=XG0YlhqDKucTpnZms48P0ZE+L8kslzATwoZr+MnDnhYJvMLPoNZNfzA2
   6CcptsIIthP4gnvca6IotObKJ4I04xU2Ms5CEt6ixnco+LA/kaFL0k9MA
   p5F+72xTziph785+p+2fD/0iI3snj6/opED0HzgKaRCm9MDGyBCoA9Si6
   OVk/RkdCs/7xhOPsaw21t0fkLgesLcsCG0HuneJN2eG3vE9lreP6O1Aki
   H7Xjw0zpqL8Y0BeLigyeaCYEF6kYIt9hri47Ro99Lo7tVelHkUAvdBQc2
   PZcITInOpyKqiynohawy0U0afur2RojCRDPoGmtp11R6pfXzhlwxYReJ/
   w==;
X-CSE-ConnectionGUID: l0I5O1TOQYu+sWQpP6L3xA==
X-CSE-MsgGUID: HDMNQgKjSFeLztBllhw0xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28885684"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28885684"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:12:03 -0700
X-CSE-ConnectionGUID: Gf5h3P3WSROESeXFGBTCQA==
X-CSE-MsgGUID: jVfLFbSLSy2pE5zjQJbgLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80157962"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:12:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/4] PCI: cpqphp: Use pci_bus_read_dev_vendor_id() to detect presence
Date: Tue, 22 Oct 2024 12:11:38 +0300
Message-Id: <20241022091140.3504-3-ilpo.jarvinen@linux.intel.com>
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


