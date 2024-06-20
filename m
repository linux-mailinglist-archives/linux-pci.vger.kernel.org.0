Return-Path: <linux-pci+bounces-9004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528B90FB7B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 05:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655EA1C20E66
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78281E535;
	Thu, 20 Jun 2024 03:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wr4sFejV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749542B9DB;
	Thu, 20 Jun 2024 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852533; cv=none; b=PzZCVpoLdeIs7jtxPhIKoKwaBYc0LxKJPh4fcSW7r191YonPohuMpZIivNm1O8jQeKah/b7iqtZzLRXHcZrVmJFTgJwlqhS2+4H262Zox1vAOVdio6e0qAsjRf3J2o1idVTn+Xu4aerlB20u/ZsXGymgkfIY0MUc0XOzEXkufQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852533; c=relaxed/simple;
	bh=pX6yLIgJt2iX60Vu88UyxHydot/8e2sqBVfmTWy6BT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXmMqvp82PZkk6wM384Bt21xN9e1fieleESzi8yAHvk5E5xcW0iuuFOQnH24I2JHrBF4DkI63Z3RpEJEksGfQ2IGgXLIqDhCu6fj/Eq5tSrNjUrQvEt4pF7oEaEriqKqgXrX1+BuA5mtql4RHaeuNJkrOfteQWmHKOQ3OjUhWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wr4sFejV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718852532; x=1750388532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pX6yLIgJt2iX60Vu88UyxHydot/8e2sqBVfmTWy6BT4=;
  b=Wr4sFejVYlP0t1DHHBj/PbK8gePKtDO635zRioNUU5R+L4Ufchn2/TzE
   8mmhphaV9sbqFkIq8rWR0WvLyiojbRA46jgvvXAQaGyndAn7eOzyTKUHN
   /Jm3n/KBhWdxlSD8XOaRBreuL0WJ7L4YGZP0/TArdL1cLmoQa5qdre9c3
   aDrNMavhX9ok/wUBO7y42o+QRlPOgHH5vVNcMAoZxC4MJniHjPC1IVeIf
   LIGh296nIB9jRqwS7zLduQ6hwtMpwHnEoPB7OtuU+LiWluk6YVIbNBRsv
   f5QIMs/3BddNBL9veNtIBg1w+1XOk8yme68zobmp1Prff8VtCAku4bJXJ
   g==;
X-CSE-ConnectionGUID: 36RjLfgdQyuiPSkc5OIbUQ==
X-CSE-MsgGUID: I5VrkIJ2R86ff1FcEhzaPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26444266"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="26444266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:02:09 -0700
X-CSE-ConnectionGUID: j3RjqRmeQfitApUR7+ovhg==
X-CSE-MsgGUID: 91FXVXzXSP+7S/ROgY8EIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42049454"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:02:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	helgaas@kernel.org,
	linmiaohe@huawei.com,
	shiju.jose@huawei.com,
	adam.c.preble@intel.com,
	lukas@wunner.de,
	Smita.KoralahalliChannabasappa@amd.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	erwin.tsaur@intel.com,
	sathyanarayanan.kuppuswamy@intel.com,
	dan.j.williams@intel.com,
	feiting.wanyan@intel.com,
	yudong.wang@intel.com,
	chao.p.peng@intel.com,
	qingshun.wang@linux.intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v5 2/2] PCI/AER: Print UNCOR_STATUS bits that might be ANFE
Date: Thu, 20 Jun 2024 10:58:57 +0800
Message-Id: <20240620025857.206647-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620025857.206647-1-zhenzhong.duan@intel.com>
References: <20240620025857.206647-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an Advisory Non-Fatal error(ANFE) triggers, both correctable error(CE)
status and ANFE related uncorrectable error(UE) status will be printed:

  AER: Correctable error message received from 0000:b7:02.0
  PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr
    Uncorrectable errors that may cause Advisory Non-Fatal:
     [12] TLP

Tested-by: Yudong Wang <yudong.wang@intel.com>
Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3dcfa0191169..ba3a54092f2c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -681,6 +681,7 @@ static void __aer_print_error(struct pci_dev *dev,
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
+	unsigned long anfe_status = info->anfe_status;
 	const char *level, *errmsg;
 	int i;
 
@@ -701,6 +702,20 @@ static void __aer_print_error(struct pci_dev *dev,
 				info->first_error == i ? " (First)" : "");
 	}
 	pci_dev_aer_stats_incr(dev, info);
+
+	if (!anfe_status)
+		return;
+
+	strings = aer_uncorrectable_error_string;
+	pci_printk(level, dev, "Uncorrectable errors that may cause Advisory Non-Fatal:\n");
+
+	for_each_set_bit(i, &anfe_status, 32) {
+		errmsg = strings[i];
+		if (!errmsg)
+			errmsg = "Unknown Error Bit";
+
+		pci_printk(level, dev, "   [%2d] %s\n", i, errmsg);
+	}
 }
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
-- 
2.34.1


