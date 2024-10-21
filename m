Return-Path: <linux-pci+bounces-14941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E933B9A6CAB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 16:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA6E1C21CC2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D851F940B;
	Mon, 21 Oct 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQNSlTxN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328C18C36;
	Mon, 21 Oct 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522154; cv=none; b=Ts8UBl5ZJUTmkL6nJ1VDicikfLT5aH0KG+jHgJjFZPc0HTUm0NjLdvjWkNtn5I0MJNVX+r/5b3YuAg/zSk+QCrmeV0IRtlIK6Mg99vWbpUD+en5MrEe3OqmIxIbj3GrO70GslYF0zXmsGoF78TTmbVMP5immFN3mYZQJKElQvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522154; c=relaxed/simple;
	bh=ThQKbnhwyaZ9JOppntHuNBOMJTIU2nFzLYi8fnpCZMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fD05AkH+oWzHxYXyJI7GinjgoJ34pMNm0qAX24K5JEhrwwYgZgutn60UEAmsI3mFkWLDUh/srQFs4HYIsnaqyeDPQ5VsLcgkDiu3m6SYwKrJV7iDXLRaZbm14+JNoiiYrchK2iOwQB4Y4ZF5sOgA+v58oPdSWiEEyeRKbQ4m7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQNSlTxN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729522152; x=1761058152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ThQKbnhwyaZ9JOppntHuNBOMJTIU2nFzLYi8fnpCZMc=;
  b=NQNSlTxNwK5yGpkJPjhAaS0IiEeQl0utwtY1CIeimSReqUDgZBUnXUm8
   8H7rbo7QFMug9LM0mSOZ7+p9v71nWSSZnNHd1l89YFC4NKqe3hembeAg+
   i76W/9CnNy7JU0ezpRnNC5UTm59Cpo9al2bf/GWkQm+xjC0xiH5/j9Z2d
   xHJpfGQI4blDhICoxx9vbAb1Ae9dBdiCGcW6yU55mTLEAxCs+A5IBUlqv
   XQBaRhKMruDlbOtZZnI+z23VothyWXbyyR85LhCV7ZlgIBw/cWwlpHRU9
   hHr04lnljXJNQeoZBqMyLKjaYZTTsR1RAN814pkYlQsdURfbN9EKI8fYk
   A==;
X-CSE-ConnectionGUID: ReSbRZhsTAGeTt/VsYkZjQ==
X-CSE-MsgGUID: Hk0RbwgITdW0BSa+n3q9lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46475745"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46475745"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:49:12 -0700
X-CSE-ConnectionGUID: 0HD6dPEqQX+GL68JPdBwKQ==
X-CSE-MsgGUID: 97muYvKKRKqhu2eMwsjdnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79138239"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
  by fmviesa006.fm.intel.com with ESMTP; 21 Oct 2024 07:49:09 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2 1/2] PCI: Add PCI_VDEVICE_SUB helper macro
Date: Mon, 21 Oct 2024 16:46:54 +0200
Message-ID: <20241021144654.5453-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI_VDEVICE_SUB generates the pci_device_id struct layout for
the specific PCI device/subdevice. Private data may follow the
output.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 include/linux/pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4..7d1359e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1050,6 +1050,20 @@ struct pci_driver {
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
2.43.0


