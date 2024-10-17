Return-Path: <linux-pci+bounces-14776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A379A2372
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045FD1C2600A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD01DE2C9;
	Thu, 17 Oct 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAVah3m/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE631DE2D6;
	Thu, 17 Oct 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171015; cv=none; b=msSRETc8mH0cu3gXAAxmV8CkmQgLGCPcOZWY/BAHmNUguGiAF86IotH+gQ6Ww5WZ3YHmdOqj76XnBoVNXK2Pg9FHWLUs/K3aH9QauWUuBribyYivxIyNUWKU9xbQlCJ/LCMMMa9+r3aKtXqkUA0F0vR3cLZoqCUutZBFRH9znro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171015; c=relaxed/simple;
	bh=Qmc9et5egLokLVZtqGU9Qa5U3lkdY/PRXCZKtUwOPg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abgzzRFpVbGrBU3WN1zmbRN3SK42pYs9Tz4gguiOI+oz1s8rUqSki6rxs0tBSQogsQexHpmFDBpxsM+azoWHg2x/n7wxC7pFVIzGAZ/6fz5vQmGjbDWenINEeF67M28cqbQWW3DqPo3Lbrap5ZcZbH3xPVJHUsARsxayqmOezmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAVah3m/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729171014; x=1760707014;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qmc9et5egLokLVZtqGU9Qa5U3lkdY/PRXCZKtUwOPg4=;
  b=VAVah3m/4Yl7i6LaHAmHqOOu7OxqZVuYmK42+duiPsSm5yZ1NBURPw+Q
   73W/p4BGDNNbJNrmcG/LgCIhcJxpVXprKdAYuW1RXb3recpK6jvuN52Jl
   FHdkcLA8aXOlysMqoLHT448vLb0fJJqK8T59mKDYcGmFD/3L7TgStJ/Zo
   u2WqySlKlir+pItEtKRptB2IDgYp+R2AGvhgWEtbEdig0/VxK4Xgl+qMv
   aq2zWM5F1dAYRCoCOI1+On0i2j5onqlyZKgtyEtZ6AinqLTTqNLITn5p/
   dzfw2kubKe/eQsAu71hwyaGNSAbSRbvxvkLjCvoRRRbnZj3iPkims/BaX
   w==;
X-CSE-ConnectionGUID: 0g5JIiOVQhWoi13/80CB3Q==
X-CSE-MsgGUID: uzmbKc6PSbWotACQgy6GBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28607901"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28607901"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:16:54 -0700
X-CSE-ConnectionGUID: Af1d6G19SuO/4SUJBJjTLA==
X-CSE-MsgGUID: ZgUqYChbTOSHm5mM+0Cn+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83189557"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
  by fmviesa004.fm.intel.com with ESMTP; 17 Oct 2024 06:16:51 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 1/2] PCI: Add PCI_VDEVICE_SUB helper macro
Date: Thu, 17 Oct 2024 15:16:47 +0200
Message-ID: <20241017131647.4255-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI_VDEVICE_SUB generates the pci_device_id struct layout for
the specific PCI device/subdevice. The subvendor field is set
to PCI_ANY_ID. Private data may follow the output.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 include/linux/pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

This patch is a part of the series from netdev.

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4..2b6b2c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1050,6 +1050,20 @@ struct pci_driver {
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
+/**
+ * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
+ * @vend: the vendor name
+ * @dev: the 16 bit PCI Device ID
+ * @subdev: the 16 bit PCI Subdevice ID
+ *
+ * Generate the pci_device_id struct layout for the specific PCI
+ * device/subdevice. The subvendor field is set to PCI_ANY_ID. Private data
+ * may follow the output.
+ */
+#define PCI_VDEVICE_SUB(vend, dev, subdev) \
+	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = subdev, 0, 0
+
 /**
  * PCI_DEVICE_DATA - macro used to describe a specific PCI device in very short form
  * @vend: the vendor name (without PCI_VENDOR_ID_ prefix)
-- 
2.43.0


