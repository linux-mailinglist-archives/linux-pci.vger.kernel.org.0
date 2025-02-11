Return-Path: <linux-pci+bounces-21135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52191A302F6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 06:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180983A715A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 05:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11102175D50;
	Tue, 11 Feb 2025 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPFfmJLH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101C1E3DE3;
	Tue, 11 Feb 2025 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739252437; cv=none; b=t2i3mSlsQNhS5JDs9005IlqSncTgqCSAMCMA7OsVMs3a6uxK8FXKbOny/EcZdJg9IkZMf2Zr7HgzXN63k0478SJSMPdzrqy+Kg59jyLJtbCW/NWfzIoCYowNvEfdnscH8TZr2u9ETgbPx421YzROUheVYyjuK5RjKtjdR+MhH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739252437; c=relaxed/simple;
	bh=c8+ckSUvQXLwAoq8ykRNNN44zqYBMhIqQSqUq/M0HUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7CovT8h3Vi7e95rj/kMbDm4PZ46ViTzT8UlI/4rS0IqzV7EWvVVFgLb3hjSCNiyxg49nEd/o0gMyrlhMPR78DfPO2GIeb6twToLp4tFYGbXwWZS+02bwQmFtLk2XOi0uFp0ea6O/D2OZfSAelrFHamyzNpB7Sj9JaxPVMXcCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPFfmJLH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739252436; x=1770788436;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c8+ckSUvQXLwAoq8ykRNNN44zqYBMhIqQSqUq/M0HUE=;
  b=GPFfmJLHCUaS+Pob/HZQJdeH44DT/7Qqf+16ubF1lvZU0MX6893l/ssG
   JCFAy1n8cdqK9YqptKgtM9BusVu6vgH06FDDHX81kpCf4H7hgB7tUvrkH
   92Vanaj8emSgz/aGMX457LKWDRGGbRb9e2oRfI0kFQs8TGqoNVshGHFRY
   21ejAyTiytJmSNvVUo3G8nfQXjnPiLUgWQUh2n6GYisaeZ5HDvLXXM+ZY
   pUYsJXKg1FqGgvmkYNnJz1K6SAfkEjOrR09x659fk4z2CTjhbvUb4c+CN
   OpuijU2W/DY3NzyjJgFfMN3RPcpI/lU1+9S1MPoESloj6oKTMroFi1+4S
   Q==;
X-CSE-ConnectionGUID: ZecMz/TtRtCMpefF+7TuLQ==
X-CSE-MsgGUID: g5uhO9RMSI+5k6B2Pe9t+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50492922"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="50492922"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 21:40:34 -0800
X-CSE-ConnectionGUID: 1S4crYqBRre37LxdSnMxtA==
X-CSE-MsgGUID: KrtMxJ+VQs6zaB40G6VVJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117023568"
Received: from unknown (HELO BSINU234.iind.intel.com) ([10.66.226.146])
  by fmviesa005.fm.intel.com with ESMTP; 10 Feb 2025 21:40:31 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Support BT remote wake.
Date: Tue, 11 Feb 2025 13:26:19 +0200
Message-Id: <20250211112619.1901277-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes to add hdev->wakeup call to support wake on BT feature.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v1:
    - support for BT remote wake.

 drivers/bluetooth/btintel_pcie.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index b8b241a92bf9..e0633fab55a0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1509,6 +1509,13 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 	return err;
 }
 
+static bool btintel_pcie_wakeup(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+
+	return device_may_wakeup(&data->pdev->dev);
+}
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
 	int err;
@@ -1533,6 +1540,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->hw_error = btintel_hw_error;
 	hdev->set_diag = btintel_set_diag;
 	hdev->set_bdaddr = btintel_set_bdaddr;
+	hdev->wakeup = btintel_pcie_wakeup;
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
-- 
2.34.1


