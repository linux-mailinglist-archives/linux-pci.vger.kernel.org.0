Return-Path: <linux-pci+bounces-5578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D6D896067
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 01:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02C51F2311E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 23:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD3415B118;
	Tue,  2 Apr 2024 23:48:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040A58ACC;
	Tue,  2 Apr 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101734; cv=none; b=VVXoKM+AuX5l87ySjvGF++yTc3DPxLwGtzDvT9lrUtxmmm28BBS92bquldk/mHGeXfHPfOhoJ2y6hlscuN6jrqSIJ44SZHoVKSUmERcTEwTiUg4tTqbTs7dlnV30kcfrqYrcxo54Z/tOfiKRILH7mv6ww+TpPPXw1AtvejLYEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101734; c=relaxed/simple;
	bh=tMRvNyT4x4cA66RyK/U0A8pa9XddkuGKAVgpj/Rrx70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkWu7LUl2Fn9095Pgvx+GltmlDB02VgpRw1FIPXw39Eh3TqII3pLhvQKK2C+kEM221PovEEedIwAksQvQJXHud0rb+qY4hnIc1GPJk9htapG0QHOKws32qlPAwvKuGgCVUus8PkxN2ArAzSiKiGwONfrBIsVixmqpybA4M34Ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF53C433C7;
	Tue,  2 Apr 2024 23:48:54 +0000 (UTC)
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
Subject: [PATCH v3 4/4] cxl: Add post reset warning if reset is detected as Secondary Bus Reset (SBR)
Date: Tue,  2 Apr 2024 16:45:32 -0700
Message-ID: <20240402234848.3287160-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402234848.3287160-1-dave.jiang@intel.com>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
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
v3:
- Rename decocer_hw_mismatch() to __cxl_endpoint_decoder_reset_detected(). (Dan)
- Move register accessing function to core/pci.c. (Dan)
- Add kernel taint to decoder reset. (Dan)
---
 drivers/cxl/core/pci.c | 31 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/pci.c      | 20 ++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c496a9710d62..597221f7f19b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1045,3 +1045,34 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
 
 	return cxl_flit_size(pdev) * MEGA / bw;
 }
+
+static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
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
+	return device_for_each_child(&port->dev, port,
+				     __cxl_endpoint_decoder_reset_detected);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
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
index 110478573296..5dc1f28a031d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -957,11 +957,31 @@ static void cxl_error_resume(struct pci_dev *pdev)
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
+		add_taint(TAINT_USER, LOCKDEP_NOW_UNRELIABLE);
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


