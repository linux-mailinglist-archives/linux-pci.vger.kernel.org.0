Return-Path: <linux-pci+bounces-35969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC4CB53F5B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 01:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A53A05BF2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 23:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C7B2E6CA4;
	Thu, 11 Sep 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQC1OH0Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F142EA74C
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635019; cv=none; b=nUsUuItN947Xjy7IxuF/nSVN07PDSwG8TqWWYaOZHGR3ByJIUcW/C7DA20dTsGavcPIkBkp6WPhpoRlFOTxcDan2RzHxNp2Oi0H0quoiAPzUyeqNws9MieqDXhZ58/KqEijfeOgjUJKLvAmJ1eLxCUsvdODLs6k/iCABGqHHl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635019; c=relaxed/simple;
	bh=YkjIlEMhUN9AsGfOne8hSGlUXNDtZeZu7Aid8icO8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHRePCufQxnwuneLxZMyYTBGEzON49xP71a9cPaGx/mpIwFjmuZypnlFPQxsHz29+cfH0DkPDYoJfn/khtXRDhX7NVzg4tHtdBlJiYhlGUTxUgT8vBKF743NsldtDXeAXE0fy8T7MezfWT/MrFnWNVWsXggFxe6XoaAiDVQspvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQC1OH0Z; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757635018; x=1789171018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YkjIlEMhUN9AsGfOne8hSGlUXNDtZeZu7Aid8icO8FY=;
  b=RQC1OH0ZlFjE81WePCg3SEmdkiczTJcq0NmAfLbCL3D2AOxk+oI1jFc/
   FREy3xVBK1HQFIwNHS2e7REqE7TMOPfsHkr0W6JN7sXBQGT2M2nQETpU1
   MO+5fJV74BQ3iqfbAf3s6L0AbpX5WrI9OkbrHFvjRPM62dW/DuBYmIXwm
   SOmFIG/AUFk24OZ0q71LGjNKY+jIGbUdg0JMiVQZstLuszWmyeaVaGr5g
   qScpu3guACHSB+MJNGnETbvqAPfJuyk//OV97SRQ9NyqNmzimpoGfBUKM
   It+x+PnAL7iKZhU7Mg2sTHPJ8v1N5MIWqReUt1kOG2VM60d+FoWKxfb7J
   g==;
X-CSE-ConnectionGUID: me3tS2tSTkqnGTdjLBryoA==
X-CSE-MsgGUID: KJsjIZetT+Wb6SA+08mpLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70598770"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="70598770"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:56:53 -0700
X-CSE-ConnectionGUID: mI59DrZjRMKPqsQ+Ic6yTA==
X-CSE-MsgGUID: PSqT1behRuuNxioASAyiBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="173393550"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa007.fm.intel.com with ESMTP; 11 Sep 2025 16:56:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: [PATCH resend v6 10/10] samples/devsec: Add sample IDE establishment
Date: Thu, 11 Sep 2025 16:56:47 -0700
Message-ID: <20250911235647.3248419-11-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911235647.3248419-1-dan.j.williams@intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise common setup and teardown flows for a sample platform TSM
driver that implements the TSM 'connect' and 'disconnect' flows.

This is both a template for platform specific implementations and a
simple integration test for the PCI core infrastructure + ABI.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/bus.c      |  3 ++
 samples/devsec/link_tsm.c | 70 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
index 07cf4ce82ceb..37a62c1cbba4 100644
--- a/samples/devsec/bus.c
+++ b/samples/devsec/bus.c
@@ -13,6 +13,7 @@
 #include "devsec.h"
 
 #define NR_DEVSEC_BUSES 1
+#define NR_PLATFORM_STREAMS 4
 #define NR_PORT_STREAMS 1
 #define NR_ADDR_ASSOC 1
 
@@ -693,6 +694,7 @@ static int __init devsec_bus_probe(struct faux_device *fdev)
 	hb->dev.parent = dev;
 	hb->sysdata = sd;
 	hb->ops = &devsec_ops;
+	pci_ide_init_nr_streams(hb, NR_PLATFORM_STREAMS);
 
 	rc = pci_scan_root_bus_bridge(hb);
 	if (rc)
@@ -730,5 +732,6 @@ static void __exit devsec_bus_exit(void)
 }
 module_exit(devsec_bus_exit);
 
+MODULE_IMPORT_NS("PCI_IDE");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Device Security Sample Infrastructure: TDISP Device Emulation");
diff --git a/samples/devsec/link_tsm.c b/samples/devsec/link_tsm.c
index 2faee8b41ede..c7a62e52f387 100644
--- a/samples/devsec/link_tsm.c
+++ b/samples/devsec/link_tsm.c
@@ -4,6 +4,7 @@
 #define dev_fmt(fmt) "devsec: " fmt
 #include <linux/device/faux.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/tsm.h>
@@ -93,6 +94,23 @@ static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
 	}
 }
 
+/* protected by tsm_ops lock */
+static DECLARE_BITMAP(devsec_stream_ids, NR_TSM_STREAMS);
+static struct pci_ide *devsec_streams[NR_TSM_STREAMS];
+
+static unsigned long *alloc_devsec_stream_id(unsigned long *stream_id)
+{
+	unsigned long id;
+
+	id = find_first_zero_bit(devsec_stream_ids, NR_TSM_STREAMS);
+	if (id == NR_TSM_STREAMS)
+		return NULL;
+	set_bit(id, devsec_stream_ids);
+	*stream_id = id;
+	return stream_id;
+}
+DEFINE_FREE(free_devsec_stream, unsigned long *, if (_T) clear_bit(*_T, devsec_stream_ids))
+
 /*
  * Reference consumer for a TSM driver "connect" operation callback. The
  * low-level TSM driver understands details about the platform the PCI
@@ -117,11 +135,61 @@ static void devsec_link_tsm_pci_remove(struct pci_tsm *tsm)
  */
 static int devsec_link_tsm_connect(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	unsigned long __stream_id;
+	int rc;
+
+	unsigned long *stream_id __free(free_devsec_stream) =
+		alloc_devsec_stream_id(&__stream_id);
+	if (!stream_id)
+		return -EBUSY;
+
+	struct pci_ide *ide __free(pci_ide_stream_release) =
+		pci_ide_stream_alloc(pdev);
+	if (!ide)
+		return -ENOMEM;
+
+	ide->stream_id = *stream_id;
+	rc = pci_ide_stream_register(ide);
+	if (rc)
+		return rc;
+
+	pci_ide_stream_setup(pdev, ide);
+	pci_ide_stream_setup(rp, ide);
+
+	rc = tsm_ide_stream_register(ide);
+	if (rc)
+		return rc;
+
+	/*
+	 * Model a TSM that handled enabling the stream at
+	 * tsm_ide_stream_register() time
+	 */
+	rc = pci_ide_stream_enable(pdev, ide);
+	if (rc)
+		return rc;
+
+	devsec_streams[*no_free_ptr(stream_id)] = no_free_ptr(ide);
+
+	return 0;
 }
 
 static void devsec_link_tsm_disconnect(struct pci_dev *pdev)
 {
+	struct pci_ide *ide;
+	unsigned long i;
+
+	for_each_set_bit(i, devsec_stream_ids, NR_TSM_STREAMS)
+		if (devsec_streams[i]->pdev == pdev)
+			break;
+
+	if (i >= NR_TSM_STREAMS)
+		return;
+
+	ide = devsec_streams[i];
+	devsec_streams[i] = NULL;
+	pci_ide_stream_release(ide);
+	clear_bit(i, devsec_stream_ids);
 }
 
 static struct pci_tsm_ops devsec_link_pci_ops = {
-- 
2.51.0


