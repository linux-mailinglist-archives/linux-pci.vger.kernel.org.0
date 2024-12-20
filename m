Return-Path: <linux-pci+bounces-18919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3419F9B0B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 21:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BC47A2379
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF222913F;
	Fri, 20 Dec 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZsY3/XS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53705228C9E;
	Fri, 20 Dec 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725769; cv=none; b=GXGTriXd3vXBmqtPlUgHsTHOs7cg8hzqR/kq1nRZopjoCLxC9/tEHTOzkw/aEOJlEkmVYFQxd2w6nd6k++SbCOCfDB+UG//1zwVYVHaggDeuEwvzX25xS9E4Q+VHrk1QQgXn5gHHUWflPXQjugU7MGm4HsB9sgXI2h75K38rcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725769; c=relaxed/simple;
	bh=uDAamA6Evk2wLXY1JrK3Smjks4G7bCMXoRNbm+Rtqk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYK9XB0wi3tGwPQ6PntBGMMlCc/Mg1lRIMdDrA5TYTMnMZ8gTFBJlp3aMBgatr68tsXCn+3P7JyNseAagTrxALpsz+OoSFAiS2FcKbJ59nJwSxs1GbtaiwgEaU+fwcxalh8yOoN3yuC4ufjel4UDaPJIREvp9D7Hk4H9nZsqhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZsY3/XS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734725768; x=1766261768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uDAamA6Evk2wLXY1JrK3Smjks4G7bCMXoRNbm+Rtqk4=;
  b=RZsY3/XS7yeFm1lssoFsgMeSQ40arK9013urSdxVNhvkbFYeiWvhxyDU
   PgK4CaZHsJoaYTqlnybwDrS97ro1MjQgjSLnkkBA+R+v+TxCCH4EUaeFy
   08Q3MlZxKTTeWbQAV5AbYy4Tyl8GRMvMibqhHrtpnXZR7Lu8DpLRP8Gx0
   Bf2TgGOMPCCrsqGJPLumKer2AVwZCRZdMHYhY1XI/iVaRmWjMSoIMfr7l
   UbGXW1aCY2PjPpo0t+X/NW5C4IN73qqxh574nL92QjEoGCGQKJ8myuvqT
   HSH9RXNrcfZpN2oI31DZOubumKoXD7V9BFBYQo2TeZfESwymril/Zyucz
   A==;
X-CSE-ConnectionGUID: agBVZfusSSug8c8e+7GnfA==
X-CSE-MsgGUID: mGfcLPn1RYSn5r0giySHZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46292426"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46292426"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:16:04 -0800
X-CSE-ConnectionGUID: bomnfGhKStSMeA/aKEM5pw==
X-CSE-MsgGUID: el7Z0ROiR5a6OoNreNeldg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102717116"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 12:16:04 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 09/10] PCI: Add PCI_VDEVICE_SUB helper macro
Date: Fri, 20 Dec 2024 12:15:14 -0800
Message-ID: <20241220201521.3363985-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
References: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

PCI_VDEVICE_SUB generates the pci_device_id struct layout for
the specific PCI device/subdevice. Private data may follow the
output.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eef..414ee5fff66b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1046,6 +1046,20 @@ struct pci_driver {
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
+/**
+ * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
+ * @vend: the vendor name
+ * @dev: the 16 bit PCI Device ID
+ * @subvend: the 16 bit PCI Subvendor ID
+ * @subdev: the 16 bit PCI Subdevice ID
+ *
+ * Generate the pci_device_id struct layout for the specific PCI
+ * device/subdevice. Private data may follow the output.
+ */
+#define PCI_VDEVICE_SUB(vend, dev, subvend, subdev) \
+	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
+	.subvendor = (subvend), .subdevice = (subdev), 0, 0
+
 /**
  * PCI_DEVICE_DATA - macro used to describe a specific PCI device in very short form
  * @vend: the vendor name (without PCI_VENDOR_ID_ prefix)
-- 
2.47.1


