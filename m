Return-Path: <linux-pci+bounces-7019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF38B9F1C
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 18:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DF91F238C8
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BFD16FF33;
	Thu,  2 May 2024 16:58:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB916FF4E;
	Thu,  2 May 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669139; cv=none; b=GWjqRCjlStpnjwExKdRDmEf3+xhDpOneXnXWPaxdW8viy/cphZZwiPI0Aq6H397XY0ra6Jux42p0krDSmhbZ1s1ziu+bXN7fEnXzdW0ifrHnMCI+mzzDQbo2cSb0Re6IDVM/FjtABiediDMqvAAjOEr7RfsCE5dlVGpn0l1YslA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669139; c=relaxed/simple;
	bh=bKVW0zAlC/I6CSUrA7QG6wc9a6veievHXR8yN1d6gUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFpHZf5ccQsIs+u4XrfE4Ry891jMgQHLuJvSrEZ0DyRrfNxGTaRppHAcljaAe9rDmm5+YGenbav5XRl+FW+eIiOWxJ2RNaod1feGexh6YmcyA3ciUJFZKq2JzOaD40V20UEofMIkprDEKHRcuRlF0wq9UQ406nQrx/MNe4c/R9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26446C113CC;
	Thu,  2 May 2024 16:58:59 +0000 (UTC)
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
Subject: [PATCH v6 5/5] cxl: Add post reset warning if reset results in loss of previously committed HDM decoders
Date: Thu,  2 May 2024 09:57:34 -0700
Message-ID: <20240502165851.1948523-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502165851.1948523-1-dave.jiang@intel.com>
References: <20240502165851.1948523-1-dave.jiang@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 29 +++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/pci.c      | 22 ++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c496a9710d62..8567dd11eaac 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1045,3 +1045,32 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
 
 	return cxl_flit_size(pdev) * MEGA / bw;
 }
+
+static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
+{
+	struct cxl_port *port = data;
+	struct cxl_decoder *cxld;
+	struct cxl_hdm *cxlhdm;
+	void __iomem *hdm;
+	u32 ctrl;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
+		return 0;
+
+	cxlhdm = dev_get_drvdata(&port->dev);
+	hdm = cxlhdm->regs.hdm_decoder;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+}
+
+bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
+{
+	return device_for_each_child(&port->dev, port,
+				     __cxl_endpoint_decoder_reset_detected);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 036d17db68e0..72fa47740768 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -891,6 +891,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c1,
 			     struct access_coordinate *c2);
 
+bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 110478573296..dccd71840c5b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -957,11 +957,33 @@ static void cxl_error_resume(struct pci_dev *pdev)
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
+	guard(device)(&cxlmd->dev);
+	if (cxlmd->endpoint &&
+	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
+		dev_crit(dev, "SBR happened without memory regions removal.\n");
+		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
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


