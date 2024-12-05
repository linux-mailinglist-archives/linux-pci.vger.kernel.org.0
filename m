Return-Path: <linux-pci+bounces-17811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA19E6080
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 23:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40C8284280
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E031BBBF1;
	Thu,  5 Dec 2024 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUg8qA5k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3001CCEEC
	for <linux-pci@vger.kernel.org>; Thu,  5 Dec 2024 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437461; cv=none; b=ayCh+m7tiMcnlyr6NVHczAFIMSfoPelCoXHjVGOMZol89nBPNR3/5jTYzp86SjAyhU1aPznjjuWMGvNBR8bcd5f0H6YKXsCRhRn1TwVjI2GBdzayhA5B7J0A4PtO0FqETLKU2Wn/fQ5S/LM7MvnenhylnZRkvG5wwKraaUurztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437461; c=relaxed/simple;
	bh=gQOPxSvG6K0KKylaZFce0IsL6P4x72QlIrlyr/E/AtA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtQwjs9lb91JH1JEI0z4+h+ijFpYTMqHoFFX1EsUuxtrAevWG6j76NirE9DwGCBz+Q09b2kr0vVlwfueOTt+X0YQNSmriQS+mBKyxWig+m79Tp89ic6F34H6PRxw/a5dSgBgOM8u6G62NeHM+o250epBpnRA+0Dq8KvL3rdKfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUg8qA5k; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733437460; x=1764973460;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gQOPxSvG6K0KKylaZFce0IsL6P4x72QlIrlyr/E/AtA=;
  b=ZUg8qA5kJAgEK4GL3FD3NsG+HI7MdtRUbTU8beKfCr73w0rLg5Hg2RkE
   fHLsKr8yyfuqfSMf7iOQpnKvZ+5Oo4MQaXXyhXojWKkNLHoumoBg/Oj96
   R9DvZQCjazRKtbNsj4pdpeVf2XAF/d05lQ7VXfn4Iop+ngE1CPJ1kZMFc
   RI8OFdLn/9HjUDTrq402i3mPA36f0jGWB5Jkgk3HE9504vOdT289qQ4ST
   OBRXNZUPJJMhukowFor7b45IIrmZ5IN/TuUi5jX+6iw3mZmIMBtZTEIxP
   8W6wKc7OGyqE29RuMDRqaXF11kI5QzOIYRebwyJlWGR6QLXBZs2Uoh01p
   A==;
X-CSE-ConnectionGUID: zyvA6taGQeyfz/4JnMdRjg==
X-CSE-MsgGUID: PWWZCo1+RXadTIANZVgCng==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44802885"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44802885"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:24:20 -0800
X-CSE-ConnectionGUID: plCRWCV5RVSWYRLX6YFPQQ==
X-CSE-MsgGUID: cx9p9UcfTZK2EePkk5h3ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99301902"
Received: from kcaccard-desk.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.178])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 14:24:20 -0800
Subject: [PATCH 11/11] samples/devsec: Add sample IDE establishment
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
Date: Thu, 05 Dec 2024 14:24:19 -0800
Message-ID: <173343745958.1074769.12896997365766327404.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
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

This is both a template for platform specific implementations and a test
case for the shared infrastructure.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/tsm.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
index d446ab8879d8..a8894d08f323 100644
--- a/samples/devsec/tsm.c
+++ b/samples/devsec/tsm.c
@@ -4,11 +4,14 @@
 #define dev_fmt(fmt) "devsec: " fmt
 #include <linux/platform_device.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/tsm.h>
 #include "devsec.h"
 
+#define DEVSEC_NR_IDE_STREAMS 4
+
 struct devsec_dsm {
 	struct pci_dsm pci;
 };
@@ -42,13 +45,60 @@ static void devsec_tsm_pci_remove(struct pci_dsm *dsm)
 	kfree(devsec_dsm);
 }
 
+/* protected by tsm_ops lock */
+static DECLARE_BITMAP(devsec_stream_ids, DEVSEC_NR_IDE_STREAMS);
+static struct devsec_stream_info {
+	struct pci_dev *pdev;
+	struct pci_ide ide;
+} devsec_streams[DEVSEC_NR_IDE_STREAMS];
+
 static int devsec_tsm_connect(struct pci_dev *pdev)
 {
-	return -ENXIO;
+	struct pci_ide *ide;
+	int rc, stream_id;
+
+	stream_id =
+		find_first_zero_bit(devsec_stream_ids, DEVSEC_NR_IDE_STREAMS);
+	if (stream_id == DEVSEC_NR_IDE_STREAMS)
+		return -EBUSY;
+	set_bit(stream_id, devsec_stream_ids);
+	ide = &devsec_streams[stream_id].ide;
+	pci_ide_stream_probe(pdev, ide);
+
+	ide->stream_id = stream_id;
+	rc = pci_ide_stream_setup(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
+	if (rc)
+		return rc;
+	rc = tsm_register_ide_stream(pdev, ide);
+	if (rc)
+		goto err;
+
+	devsec_streams[stream_id].pdev = pdev;
+	pci_ide_enable_stream(pdev, ide);
+	return 0;
+err:
+	pci_ide_stream_teardown(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
+	return rc;
 }
 
 static void devsec_tsm_disconnect(struct pci_dev *pdev)
 {
+	struct pci_ide *ide;
+	int i;
+
+	for_each_set_bit(i, devsec_stream_ids, DEVSEC_NR_IDE_STREAMS)
+		if (devsec_streams[i].pdev == pdev)
+			break;
+
+	if (i >= DEVSEC_NR_IDE_STREAMS)
+		return;
+
+	ide = &devsec_streams[i].ide;
+	pci_ide_disable_stream(pdev, ide);
+	tsm_unregister_ide_stream(ide);
+	pci_ide_stream_teardown(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
+	devsec_streams[i].pdev = NULL;
+	clear_bit(i, devsec_stream_ids);
 }
 
 static const struct pci_tsm_ops devsec_pci_ops = {
@@ -63,16 +113,44 @@ static void devsec_tsm_remove(void *tsm)
 	tsm_unregister(tsm);
 }
 
+static void set_nr_ide_streams(int nr)
+{
+	struct pci_dev *pdev = NULL;
+
+	for_each_pci_dev(pdev) {
+		struct pci_host_bridge *hb;
+
+		if (pdev->sysdata != devsec_sysdata)
+			continue;
+		hb = pci_find_host_bridge(pdev->bus);
+		if (hb->nr_ide_streams >= 0)
+			continue;
+		pci_set_nr_ide_streams(hb, nr);
+	}
+}
+
+static void devsec_tsm_ide_teardown(void *data)
+{
+	set_nr_ide_streams(-1);
+}
+
 static int devsec_tsm_probe(struct platform_device *pdev)
 {
 	struct tsm_subsys *tsm;
+	int rc;
 
 	tsm = tsm_register(&pdev->dev, NULL, &devsec_pci_ops);
 	if (IS_ERR(tsm))
 		return PTR_ERR(tsm);
 
-	return devm_add_action_or_reset(&pdev->dev, devsec_tsm_remove,
-					tsm);
+	rc = devm_add_action_or_reset(&pdev->dev, devsec_tsm_remove, tsm);
+	if (rc)
+		return rc;
+
+	set_nr_ide_streams(DEVSEC_NR_IDE_STREAMS);
+
+	return devm_add_action_or_reset(&pdev->dev, devsec_tsm_ide_teardown,
+					NULL);
 }
 
 static struct platform_driver devsec_tsm_driver = {
@@ -109,5 +187,6 @@ static void __exit devsec_tsm_exit(void)
 }
 module_exit(devsec_tsm_exit);
 
+MODULE_IMPORT_NS(PCI_IDE);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Device Security Sample Infrastructure: Platform TSM Driver");


