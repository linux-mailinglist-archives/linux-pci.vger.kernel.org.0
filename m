Return-Path: <linux-pci+bounces-4733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73E87899E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 21:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE0E1F20EF4
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD356B9C;
	Mon, 11 Mar 2024 20:42:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493E56B99;
	Mon, 11 Mar 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189721; cv=none; b=d7PW8CXWeNaG/7WNDlpUZSwEehM1OOZdZk5L/FPS8B1I0EsdmIM0fT6WlmJqvdBaaq396XaQby82i4+nLcY/O/ey6nn++ZgXQnt2uHA5x+fxlcdB4lGZJo0DO9BONo888hb+ZBR+YsPziGEh/nByBtOwuhfbo8hKkr5d6RiXkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189721; c=relaxed/simple;
	bh=J/wONLAEvHRU9lD1btd5BUHl4+vel/eLMs5RxCUEL6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNfwgdFMlNJEE/rL4tGqsaqR/+IBY+Znnr9H64ItE3m+ASf9qcVWZ4JMZHgecSdUeMI5HCW/w49C/Qz+9oDeuBRheQP7XInSGupP+2AeyFkSu13NJSSZ8Vn2hEePAO4HVcNDXPBzwzVne9UCkRRxxeCQc/Z3gNCksBDMUcJwPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAD9C433F1;
	Mon, 11 Mar 2024 20:41:59 +0000 (UTC)
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
Subject: [PATCH 3/3] cxl: Add post reset warning if reset is detected as Secondary Bus Reset (SBR)
Date: Mon, 11 Mar 2024 13:39:55 -0700
Message-ID: <20240311204132.62757-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311204132.62757-1-dave.jiang@intel.com>
References: <20240311204132.62757-1-dave.jiang@intel.com>
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

A helper function is added to find discrepency between the decoder
software state versus the hardware register state.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Check decoder flags vs decoder registers for discrepency. (Dan)
---
 drivers/cxl/core/port.c | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/pci.c       | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..4de0013f9cc7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2170,6 +2170,36 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
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
index 003feebab79b..e42b1f3f9288 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -882,6 +882,8 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 
 void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
 
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


