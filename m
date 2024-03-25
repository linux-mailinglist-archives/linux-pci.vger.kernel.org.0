Return-Path: <linux-pci+bounces-5137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B8188B5B0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 00:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0276B1C37BAE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 23:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298285934;
	Mon, 25 Mar 2024 23:59:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6184D2A;
	Mon, 25 Mar 2024 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411160; cv=none; b=rU3z4vWvewahWP1O2iL9UDmrlrHkd31JG91PEEKR0ZEBrWtqzu4s46Sqn5NuJpTqlQ8FmeNTLezZ9y2rvQoIrSIDMsdk2j3pg9jP00Yed5oiHZaK5aOULwa5jZMjvA5H9t5d0PzvMglUQoXmaJMSdQbtz6PQ0rEO91BnIlAyH/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411160; c=relaxed/simple;
	bh=xAxMCxwjjX9S/PqJDyq6Rp0PSzq3bF+f+gEjXcKqCEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd8wWk8Fpr/nN8jlx0PDmeAH4HK1VduJzqkV5KsKM/rrh17TCmuTDXQ1oWyJkbkziIGzCOygAXdN6Ci6wk/r0L32hVYywgOa8ooRMgOLwkw37ouBly3ieJGi/565UTRMQHboLiLNFIO1ZM359c4U9ka7Jp2fgSr/Zev+L13Qzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1096C433F1;
	Mon, 25 Mar 2024 23:59:19 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	bhelgaas@google.com,
	lukas@wunner.de
Subject: [PATCH v2 3/3] cxl: Add post reset warning if reset is detected as Secondary Bus Reset (SBR)
Date: Mon, 25 Mar 2024 16:58:03 -0700
Message-ID: <20240325235914.1897647-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325235914.1897647-1-dave.jiang@intel.com>
References: <20240325235914.1897647-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SBR is equivalent to a device been hot removed and inserted again. Doing a
SBR on a CXL type 3 device is problematic if the exported device memory is
part of system memory that cannot be offlined. The event is equivalent to
violently ripping out that range of memory from the kernel. While the
hardware requires the "Unmask SBR" bit set in the Port Control Extensions
register and the kernel currently does not unmask it, user can unmask
this bit via setpci or similar tool.

The driver does not have a way to detect whether a reset coming from the
PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
detect is to note if a decoder is marked as enabled in software but the
decoder control register indicates it's not committed.

A helper function is added to find discrepancy between the decoder
software state versus the hardware register state.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fix typo in commit log
---
 drivers/cxl/core/port.c | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/pci.c       | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2b0cab556072..e33d047f992b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2222,6 +2222,36 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_perf_coordinates, CXL);
 
+static int decoder_hw_mismatch(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port = data;
+	struct cxl_decoder *cxld;
+	struct cxl_hdm *cxlhdm;
+	void __iomem *hdm;
+	u32 ctrl;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
+		return 0;
+
+	cxld = &cxled->cxld;
+	cxlhdm = dev_get_drvdata(&port->dev);
+	hdm = cxlhdm->regs.hdm_decoder;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+}
+
+bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
+{
+	return device_for_each_child(&port->dev, port, decoder_hw_mismatch);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
+
 /* for user tooling to ensure port disable work has completed */
 static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 534e25e2f0a4..e3c237c50b59 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -895,6 +895,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c1,
 			     struct access_coordinate *c2);
 
+bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 13450e75f5eb..78457542aeec 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -957,11 +957,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
 		 dev->driver ? "successful" : "failed");
 }
 
+static void cxl_reset_done(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &pdev->dev;
+
+	/*
+	 * FLR does not expect to touch the HDM decoders and related registers.
+	 * SBR however will wipe all device configurations.
+	 * Issue warning if there was active decoder before reset that no
+	 * longer exists.
+	 */
+	if (cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
+		dev_warn(dev, "SBR happened without memory regions removal.\n");
+		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");
+	}
+}
+
 static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.cor_error_detected	= cxl_cor_error_detected,
+	.reset_done	= cxl_reset_done,
 };
 
 static struct pci_driver cxl_pci_driver = {
-- 
2.44.0


