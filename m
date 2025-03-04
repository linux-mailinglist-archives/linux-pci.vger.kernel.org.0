Return-Path: <linux-pci+bounces-22821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C9FA4D4B9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E5E3B0A41
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC31FC7CA;
	Tue,  4 Mar 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2LiSHOV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE841D88B4
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072520; cv=none; b=ReH0oaIDZ9zyT8NARMLFMHtyZAKMn0KbFm7F/PGiPp0Acb0MMLOs0Zjyt7hU/Qwa6aR9Qt2Ak1nVcZl8cChbD5mYYuWddEFpUipvyohfFmgCk4Ncu0Mutz/vJQQaexz8yMFTCKwm8HXVDY8/DfU7jEYU+4eXD7QrcwKxY8dSrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072520; c=relaxed/simple;
	bh=FXjZ31r+HctdlgoJ7qDKW2CKWvFsSSritfdTM7tD5Nk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrDIW6NHto3vGtYmrd1N8msshYg0zDrPfcgIK83GQSxYD+sgmMzZapbZaZ3Jzpayo4EymClUiyELQvmgwGmOdiQDYVj2QkM9YaA+FLFsoLb7LrI5z05hNlAuQ21C8/1zXctkzxQ/9lZbVpcQSCa2jw3Q/y0S4WVJ6pS0fXQsmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2LiSHOV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741072519; x=1772608519;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXjZ31r+HctdlgoJ7qDKW2CKWvFsSSritfdTM7tD5Nk=;
  b=i2LiSHOVAoXFhTKEZif8+fRWMqVKJt8QAMc/+yH8Qcx9ffJc4aKt7BEp
   lX8/tTHkpvcXobQieXBfXH/btmwD11edmT0oykiuKRHQ87ELfhjrP7Iki
   H50FH2YxcJagZNe1DXboCXDjZChYG+sam+3bnxfzGqJoUhtLxUW1FVrKs
   qpIbXXXlLhbTylgqhEbemfqEPdby3vsOtCK61Byfv4XJ53/Dl1dw9802c
   mVzaJpN7G71d84esVmgSkjCSEYQZOSG5VfpLo+uEFw19a2yWFexFgW8r3
   KOu6yNkmBgDSy3vfy41azdjMizJwH0buZpeihk5vNjYst7vemKnE23nDr
   w==;
X-CSE-ConnectionGUID: RhwGtJ2OSIuNTE3ATcdJYw==
X-CSE-MsgGUID: 1AuolIM/TkGIJmjpKdu0lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52181353"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52181353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:15:19 -0800
X-CSE-ConnectionGUID: 86zNqVLhT0K5qN7cWXARXQ==
X-CSE-MsgGUID: fhAaXa5DTLutFzWKIIBzTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123497962"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:15:18 -0800
Subject: [PATCH v2 11/11] samples/devsec: Add sample IDE establishment
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, aik@amd.com, lukas@wunner.de
Date: Mon, 03 Mar 2025 23:15:17 -0800
Message-ID: <174107251788.1288555.15627462362017774594.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Exercise common setup and teardown flows for a sample platform TSM
driver that implements the TSM 'connect' and 'disconnect' flows.

This is both a template for platform specific implementations and a
simple integration test for the PCI core infrastructure + ABI.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/bus.c |    6 ++++
 samples/devsec/tsm.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
index 69117db10897..b78c04b21eb9 100644
--- a/samples/devsec/bus.c
+++ b/samples/devsec/bus.c
@@ -15,6 +15,7 @@
 
 #define NR_DEVSEC_BUSES 1
 #define NR_DEVSEC_ROOT_PORTS 1
+#define NR_PLATFORM_STREAMS 4
 #define NR_PORT_STREAMS 1
 #define NR_ADDR_ASSOC 1
 #define NR_DEVSEC_DEVS 1
@@ -589,6 +590,7 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
 	struct devsec *devsec;
 	struct pci_sysdata *sd;
 	u64 mmio_size = SZ_64G;
+	struct pci_host_bridge *hb;
 	struct device *dev = &pdev->dev;
 	u64 mmio_start = iomem_resource.end + 1 - SZ_64G;
 
@@ -649,6 +651,9 @@ static int __init devsec_bus_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	hb = pci_find_host_bridge(devsec->bus);
+	pci_ide_init_nr_streams(hb, NR_PLATFORM_STREAMS);
+
 	pci_scan_child_bus(devsec->bus);
 
 	return 0;
@@ -688,5 +693,6 @@ static void __exit devsec_bus_exit(void)
 }
 module_exit(devsec_bus_exit);
 
+MODULE_IMPORT_NS("PCI_IDE");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Device Security Sample Infrastructure: TDISP Device Emulation");
diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
index 7698df2b4e29..9c033662c1b4 100644
--- a/samples/devsec/tsm.c
+++ b/samples/devsec/tsm.c
@@ -4,6 +4,7 @@
 #define dev_fmt(fmt) "devsec: " fmt
 #include <linux/platform_device.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/tsm.h>
@@ -50,13 +51,83 @@ static void devsec_tsm_pci_remove(struct pci_tsm *tsm)
 	kfree(devsec_tsm);
 }
 
+/* protected by tsm_ops lock */
+static DECLARE_BITMAP(devsec_stream_ids, NR_TSM_STREAMS);
+static struct pci_ide *devsec_streams[NR_TSM_STREAMS];
+
 static int devsec_tsm_connect(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_ide *ide;
+	int rc, stream_id;
+
+	stream_id =
+		find_first_zero_bit(devsec_stream_ids, NR_TSM_STREAMS);
+	if (stream_id == NR_TSM_STREAMS)
+		return -EBUSY;
+	set_bit(stream_id, devsec_stream_ids);
+
+	ide = pci_ide_stream_alloc(pdev);
+	if (!ide) {
+		rc = -ENOMEM;
+		goto err_stream_alloc;
+	}
+
+	ide->stream_id = stream_id;
+	rc = pci_ide_stream_register(ide);
+	if (rc)
+		goto err_stream;
+
+	pci_ide_stream_setup(pdev, ide);
+	pci_ide_stream_setup(rp, ide);
+
+	rc = tsm_ide_stream_register(pdev, ide);
+	if (rc)
+		goto err_tsm;
+
+	/*
+	 * Model a TSM that handled enabling the stream at
+	 * tsm_ide_stream_register() time
+	 */
+	pci_ide_stream_enable(pdev, ide);
+	devsec_streams[stream_id] = ide;
+
+	return 0;
+
+err_tsm:
+	pci_ide_stream_teardown(rp, ide);
+	pci_ide_stream_teardown(pdev, ide);
+	pci_ide_stream_unregister(ide);
+err_stream:
+	pci_ide_stream_free(ide);
+err_stream_alloc:
+	clear_bit(stream_id, devsec_stream_ids);
+
+	return rc;
 }
 
 static void devsec_tsm_disconnect(struct pci_dev *pdev)
 {
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_ide *ide;
+	int i;
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
+	pci_ide_stream_disable(pdev, ide);
+	tsm_ide_stream_unregister(ide);
+	pci_ide_stream_teardown(rp, ide);
+	pci_ide_stream_teardown(pdev, ide);
+	pci_ide_stream_unregister(ide);
+	pci_ide_stream_free(ide);
+	clear_bit(i, devsec_stream_ids);
 }
 
 static const struct pci_tsm_ops devsec_pci_ops = {


