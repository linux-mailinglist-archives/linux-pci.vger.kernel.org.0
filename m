Return-Path: <linux-pci+bounces-7284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F59B8C0CDB
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 10:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A4E1C218EC
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554814A4C3;
	Thu,  9 May 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PM+A05IU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC85127E1F;
	Thu,  9 May 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244701; cv=none; b=tOdpsjh/S2bZMQQAsGpkQ8JOf67JYc9rk7q1BnMRHBpjk0xus5AD+naXsUosMyMwT83cH0nBdTQjDbQulr+XM0qbMNK4e1/XUG+vsVZnKBatT8XhIrK9KFjdjZXkbgj4nWgs7ex4flVNXAt4p8Vb0KyWQXkIRRewNYBGOZN3wek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244701; c=relaxed/simple;
	bh=x4dIzXYEipKi3Isu0hz9w8cL6pi9eY1H3hezd3SqTJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzmXskxTleW7mLamfikXv3GGkwZd2VGJ0PFJ/kJtx2fr0DK4bNpjYkOV0x0mXv/SdSBv8/qVIO9TVh7uTya5m72iXRsKpXphHARTD0rI1n93TBvLL8skeGr8ZRmnz21xynLIbd9c+VptqLUedFYq7rz/k6RH3GaWXCXHb1zFMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PM+A05IU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715244699; x=1746780699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x4dIzXYEipKi3Isu0hz9w8cL6pi9eY1H3hezd3SqTJA=;
  b=PM+A05IUxb3ELSZIDfu9MnvduH8Ru/7LTbcKTOWXgp11RJFQETCxuyv6
   ktFwACsvohx98otuM9Q3GpDKWLYu+03a8RfUYN+Jy1ffvzvtuDchheHI7
   4taGwmLtyJsc0Y/+ZsFMGNdlAZtrb7N8YGsDDqmGKo9jZExYGOwsTsfEM
   DVMBtP7p/zYMbZF0/P6mytA6rpLlk9C63RkMUEF7oTHp7BOkAmsIcQUjY
   JsKEsYGJXKelCBrYEIVAvK3iDx3qSRgfztt8OyOy+umRf7Ky2hylUeuY7
   D9hl9g1mnyvnRs3Mp9IciEp9yOPVK8Z6WHL9JvDqKkkMlrfqBgX+XHxpp
   g==;
X-CSE-ConnectionGUID: 0kuOoYGlRFSIwat5+wKfXg==
X-CSE-MsgGUID: 5vuShKEIRV6dsly5nyvOZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14103977"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="14103977"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 01:51:38 -0700
X-CSE-ConnectionGUID: LmVUfqKhRPKjkUX+lp2Ygw==
X-CSE-MsgGUID: YpL0sfrtSUGqENeVH4941g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="29060917"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 01:51:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
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
	bhelgaas@google.com,
	helgaas@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
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
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 2/3] PCI/AER: Print UNCOR_STATUS bits that might be ANFE
Date: Thu,  9 May 2024 16:48:32 +0800
Message-Id: <20240509084833.2147767-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
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
     [18] TLP

Tested-by: Yudong Wang <yudong.wang@intel.com>
Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/pci/pcie/aer.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f2839b51321a..ed435f09ac27 100644
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


