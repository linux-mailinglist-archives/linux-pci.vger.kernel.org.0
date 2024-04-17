Return-Path: <linux-pci+bounces-6340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AA8A7C39
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 08:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCF31F2356B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 06:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30355A4CA;
	Wed, 17 Apr 2024 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZqOGcod"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617D65E02;
	Wed, 17 Apr 2024 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334632; cv=none; b=UtClXVG0KLln0Zb0Ywn0DZ4TWNFsL5eIZXyTz3VbfGDbruWwxvmHNaMJDSSdt0OQeP9ipCNHEBLVfYL5pqcT2UiI8Twf5wD/1yPLKDaEXODrn7FLgg8gu7FyZLXeo3xmXNbObTuUP+c0aiENA6p3+b0CZYQLIDkNuzye9CM+kvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334632; c=relaxed/simple;
	bh=NFuVsgVJfZaAOKFxHZp//9+GJ3/IPPtO5nxnrAmlirg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bo7CFjT9eZUODPPC987phEe4QHtqFb8B6CeHqzd4Unii2FGc5mM/7+vz/4umFym/YulFr8k+v8V+dloekhs+6Hb6b1qIusAWh6HeH6tjlvaJUkuU80nHV9FUo8+E24zRnq3X35OUptCJi5dxJXbc5GicmG9XpMUmvJOLk4JN9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZqOGcod; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713334631; x=1744870631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NFuVsgVJfZaAOKFxHZp//9+GJ3/IPPtO5nxnrAmlirg=;
  b=QZqOGcod0JIxF3PzDW5Gi9WmFD3cBjGLpU9eJxgDu1O0L2nu8NMY5l1P
   qVLFqoGDvr60qrVbm6C0m2HFJKYCBR+R/RZm7qfN3SqpT9m54VzjZxsC0
   r6kcx91LzI2CZm6KcdXsL75WsKSzB40sBrL+PeZKL7zs9+Q61J32ODbx/
   i5l3Nboq4QudruL9nL7FJM+nwAUczTphat5fIlv5lw8JfXlQi6vPfX/p7
   WSvMjDLGyUTXZObdKYXbOEePx+3qTf7FMmQnkFcaZnule/nKknLMOhbjk
   8ITTyEcKUWSE2FhS6vOOvaiEXVpAHBynfxd0OAHf6Mu6J8kPKH5ILP5RX
   w==;
X-CSE-ConnectionGUID: F9tpuU7eR+CfYOmG4z/83Q==
X-CSE-MsgGUID: IaUAebC8SvGtLeENUWpdJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="11750849"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="11750849"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 23:17:10 -0700
X-CSE-ConnectionGUID: j57zaDkGTVClbWw+FTtrHA==
X-CSE-MsgGUID: qsmEAh3gSmqncLDcL9tXNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="23109086"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 23:17:02 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
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
	bhelgaas@google.com,
	helgaas@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linmiaohe@huawei.com,
	shiju.jose@huawei.com,
	adam.c.preble@intel.com,
	leoyang.li@nxp.com,
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
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 3/3] PCI/AER: Clear UNCOR_STATUS bits that might be ANFE
Date: Wed, 17 Apr 2024 14:14:07 +0800
Message-Id: <20240417061407.1491361-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417061407.1491361-1-zhenzhong.duan@intel.com>
References: <20240417061407.1491361-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing an ANFE, ideally both correctable error(CE) status and
uncorrectable error(UE) status should be cleared. However, there is no
way to fully identify the UE associated with ANFE. Even worse, a Fatal
Error(FE) or Non-Fatal Error(NFE) may set the same UE status bit as
ANFE. Treating an ANFE as NFE will reproduce above mentioned issue,
i.e., breaking softwore probing; treating NFE as ANFE will make us
ignoring some UEs which need active recover operation. To avoid clearing
UEs that are not ANFE by accident, the most conservative route is taken
here: If any of the FE/NFE Detected bits is set in Device Status, do not
touch UE status, they should be cleared later by the UE handler. Otherwise,
a specific set of UEs that may be raised as ANFE according to the PCIe
specification will be cleared if their corresponding severity is Non-Fatal.

For instance, previously when kernel receives an ANFE with Poisoned TLP
in OS native AER mode, only status of CE will be reported and cleared:

  AER: Correctable error message received from 0000:b7:02.0
  PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr

If the kernel receives a Malformed TLP after that, two UEs will be
reported, which is unexpected. Malformed TLP Header is lost since
the previous ANFE gated the TLP header logs:

  PCIe Bus Error: severity="Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00041000/00180020
     [12] TLP                    (First)
     [18] MalfTLP

Now, for the same scenario, both CE status and related UE status will be
reported and cleared after ANFE:

  AER: Correctable error message received from 0000:b7:02.0
  PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr
    Uncorrectable errors that may cause Advisory Non-Fatal:
     [18] TLP

Tested-by: Yudong Wang <yudong.wang@intel.com>
Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/pci/pcie/aer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 870e1d1a5159..6ebe320eb0f7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1115,9 +1115,14 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
 		 */
-		if (aer)
+		if (aer) {
 			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 					info->status);
+			if (info->anfe_status)
+				pci_write_config_dword(dev,
+						       aer + PCI_ERR_UNCOR_STATUS,
+						       info->anfe_status);
+		}
 		if (pcie_aer_is_native(dev)) {
 			struct pci_driver *pdrv = dev->driver;
 
-- 
2.34.1


