Return-Path: <linux-pci+bounces-36508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97957B89E36
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A51B623126
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492E313D65;
	Fri, 19 Sep 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLO/AhKM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC7310635
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291776; cv=none; b=cQxPZr91523vCgJDOavqSgLZ9z0CL+UfjryIEI39pNun0ltaJKXhj6OWcm9Y5ogF0l6mYZ5n7+cBr3WMqYTDrOr+70Pqu6XkX+SJLSIdiOOmZJHqKeD5IwKCk9SF5c1GYyUn/t9cBM6GlrlBrt4uSNmq6ck5fwwyTLo/UFasY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291776; c=relaxed/simple;
	bh=DCXAAAawAfgafMCswTubFriMc9sUfXJi6LE8G5oPqMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDM6frAQ4LPMnzX26xerLJJxuCptKDLj/LJQxsYrFRH8gboa8Qx26R+Nbt82YPsGzYfM7T8RtBk8P3ZxlxvbK6fQPdVpBPY0U+STbJFLlHU2NTb/SS2fXSPorTpjxVulmMdagl1JGjudH/vThYUaYxXfAqhxQH8Uu+Kr+TKWGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLO/AhKM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291774; x=1789827774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DCXAAAawAfgafMCswTubFriMc9sUfXJi6LE8G5oPqMI=;
  b=BLO/AhKMk551LOg6gymxnWZeULkz2tZqgO+EeLg8hXf1E3VtvghsCIFo
   mdst+RcEzFw8hA0Jr+/BuWJOi56z5XARsSX23yWXzE9+nncqF7OktJq2j
   z/IYA0k2vKxugN9RmLubeQNAGCI8hD9qC/jpecAWO/gL5JgUD7bmyIb0I
   NYbSoaor+mC3P59ubgjoS5H9fKJwbya72Y71g/sCtdXs3fy67F87jP0Sa
   tYpNzAHZM2QbXARvyGkXBDHwMbCOm/xNCunjD8j+mEgaW2yrrNaKYMeCv
   qNBWYrhdROYoZF7QSSKnAqSo9TXWfGoHnokk2l4bE6Nn9fbfnCvxB+c8x
   w==;
X-CSE-ConnectionGUID: IrU3M3C5RF2zBY2yUc/tmw==
X-CSE-MsgGUID: 6+a38KhaSe+Why8l2+UTOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750587"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750587"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:42 -0700
X-CSE-ConnectionGUID: D9Em7AQdQaqDWSC4mT+RGQ==
X-CSE-MsgGUID: bG60RQ1/Rr2ZgK44d66YEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655074"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 27/27] coco/tdx-host: Implement IDE stream setup/teardown
Date: Fri, 19 Sep 2025 07:22:36 -0700
Message-ID: <20250919142237.418648-28-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@linux.intel.com>

Implementation for a most straightforward Selective IDE stream setup.
Hard code all parameters for Stream Control Register. And no IDE Key
Refresh support.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/tdx-host/tdx-host.c | 271 +++++++++++++++++++++++++-
 1 file changed, 270 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 258539cf0cdf..7f156d219cee 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -12,6 +12,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/pci-ide.h>
 #include <linux/pci-tsm.h>
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
@@ -65,6 +66,10 @@ struct tdx_link {
 	struct tdx_page_array *spdm_mt;
 	unsigned int dev_info_size;
 	void *dev_info_data;
+
+	struct pci_ide *ide;
+	struct tdx_page_array *stream_mt;
+	unsigned int stream_id;
 };
 
 static struct tdx_link *to_tdx_link(struct pci_tsm *tsm)
@@ -345,13 +350,277 @@ static int tdx_spdm_session_setup(struct tdx_link *tlink)
 	return 0;
 }
 
+enum tdx_ide_stream_km_op {
+	TDX_IDE_STREAM_KM_SETUP = 0,
+	TDX_IDE_STREAM_KM_REFRESH = 1,
+	TDX_IDE_STREAM_KM_STOP = 2,
+};
+
+static int tdx_ide_stream_km(struct tdx_link *tlink,
+			     enum tdx_ide_stream_km_op op)
+{
+	u64 r, out_msg_sz;
+	int ret;
+
+	do {
+		r = tdh_ide_stream_km(tlink->spdm_id, tlink->stream_id, op,
+				      tlink->in_msg, tlink->out_msg,
+				      &out_msg_sz);
+		ret = tdx_link_event_handler(tlink, r, out_msg_sz);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
+static int tdx_ide_stream_key_program(struct tdx_link *tlink)
+{
+	return tdx_ide_stream_km(tlink, TDX_IDE_STREAM_KM_SETUP);
+}
+
+static void tdx_ide_stream_key_stop(struct tdx_link *tlink)
+{
+	tdx_ide_stream_km(tlink, TDX_IDE_STREAM_KM_STOP);
+}
+
+static void add_pdev_to_addr_range(struct pci_dev *pdev,
+				   resource_size_t *start, resource_size_t *end)
+{
+	resource_size_t s = ULLONG_MAX, e = 0;
+	int i;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
+			continue;
+
+		/* Skip low MMIO BAR */
+		if (pci_resource_start(pdev, i) <= U32_MAX)
+			continue;
+
+		if (!pci_resource_len(pdev, i))
+			continue;
+
+		s = min_t(resource_size_t, s, pci_resource_start(pdev, i));
+		e = max_t(resource_size_t, e, pci_resource_end(pdev, i));
+	}
+
+	*start = min_t(resource_size_t, s, *start);
+	*end = max_t(resource_size_t, e, *end);
+}
+
+static int match_pci_dev_by_devid(struct device *dev, const void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (*(const unsigned int *)data == pci_dev_id(pdev))
+		return 1;
+
+	return 0;
+}
+
+/* OPEN: Should we add general address range support in pci/ide.c ? */
+static void setup_addr_range(struct pci_dev *pdev,
+			     resource_size_t *start, resource_size_t *end)
+{
+	struct device *dev;
+	u32 devid;
+	int i;
+
+	add_pdev_to_addr_range(pdev, start, end);
+
+	for (i = 0; i < pci_num_vf(pdev); i++) {
+		devid = PCI_DEVID(pci_iov_virtfn_bus(pdev, i),
+				  pci_iov_virtfn_devfn(pdev, i));
+
+		dev = bus_find_device(&pci_bus_type, NULL, &devid,
+				      match_pci_dev_by_devid);
+		if (dev) {
+			add_pdev_to_addr_range(to_pci_dev(dev), start, end);
+			put_device(dev);
+		}
+	}
+}
+
+static void sel_stream_block_setup(struct pci_dev *pdev, struct pci_ide *ide,
+				   u64 *rid_assoc1, u64 *rid_assoc2,
+				   u64 *addr_assoc1, u64 *addr_assoc2,
+				   u64 *addr_assoc3)
+{
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_ide_partner *setting = pci_ide_to_settings(rp, ide);
+	resource_size_t start = ULLONG_MAX, end = 0;
+
+	*rid_assoc1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, setting->rid_end);
+	*rid_assoc2 = PREP_PCI_IDE_SEL_RID_2(setting->rid_start, pci_ide_domain(pdev));
+
+	/* Only one address association register block */
+	setup_addr_range(pdev, &start, &end);
+
+	*addr_assoc1 = PREP_PCI_IDE_SEL_ADDR1(start, end);
+	*addr_assoc2 = FIELD_GET(SEL_ADDR_UPPER, end);
+	*addr_assoc3 = FIELD_GET(SEL_ADDR_UPPER, start);
+}
+
+#define STREAM_INFO_RP_DEVFN		GENMASK_ULL(7, 0)
+#define STREAM_INFO_TYPE		BIT_ULL(8)
+#define  STREAM_INFO_TYPE_LINK		0
+#define  STREAM_INFO_TYPE_SEL		1
+
+static int tdx_ide_stream_create(struct tdx_link *tlink, struct pci_ide *ide)
+{
+	u64 stream_info, stream_ctrl, rid_assoc1, rid_assoc2;
+	u64 addr_assoc1, addr_assoc2, addr_assoc3;
+	u64 stream_id, rp_ide_id;
+	unsigned int nr_pages = tdx_sysinfo->connect.ide_mt_page_count;
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	u64 r;
+
+	struct tdx_page_array *stream_mt __free(tdx_page_array_free) =
+		tdx_page_array_create(nr_pages, true);
+	if (!stream_mt)
+		return -ENOMEM;
+
+	stream_info = FIELD_PREP(STREAM_INFO_RP_DEVFN, rp->devfn);
+	stream_info |= FIELD_PREP(STREAM_INFO_TYPE, STREAM_INFO_TYPE_SEL);
+
+	/*
+	 * For Selective IDE stream, below values must be 0:
+	 *   NPR_AGG/PR_AGG/CPL_AGG/CONF_REQ/ALGO/DEFAULT/STREAM_ID
+	 *
+	 * below values are configurable but now hardcode to 0:
+	 *   PCRC/TC
+	 */
+	stream_ctrl = FIELD_PREP(PCI_IDE_SEL_CTL_EN, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_TX_AGGR_NPR, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_TX_AGGR_PR, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_TX_AGGR_CPL, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_PCRC_EN, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_ALG, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_TC, 0) |
+		      FIELD_PREP(PCI_IDE_SEL_CTL_ID, 0);
+
+	sel_stream_block_setup(pdev, ide, &rid_assoc1, &rid_assoc2,
+			       &addr_assoc1, &addr_assoc2, &addr_assoc3);
+
+	r = tdh_ide_stream_create(stream_info, tlink->spdm_id,
+				  stream_mt, stream_ctrl,
+				  rid_assoc1, rid_assoc2, addr_assoc1,
+				  addr_assoc2, addr_assoc3,
+				  &stream_id, &rp_ide_id);
+	if (r)
+		return -EFAULT;
+
+	tlink->stream_id = stream_id;
+	tlink->stream_mt = no_free_ptr(stream_mt);
+
+	pci_dbg(pdev, "%s stream id 0x%x rp ide_id 0x%llx\n", __func__,
+		tlink->stream_id, rp_ide_id);
+	return 0;
+}
+
+static void tdx_ide_stream_delete(struct tdx_link *tlink)
+{
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	unsigned int nr_released;
+	u64 released_hpa, r;
+
+	r = tdh_ide_stream_block(tlink->spdm_id, tlink->stream_id);
+	if (r) {
+		pci_err(pdev, "ide stream block fail %llx\n", r);
+		goto leak;
+	}
+
+	r = tdh_ide_stream_delete(tlink->spdm_id, tlink->stream_id,
+				  tlink->stream_mt, &nr_released,
+				  &released_hpa);
+	if (r) {
+		pci_err(pdev, "ide stream delete fail %llx\n", r);
+		goto leak;
+	}
+
+	if (tdx_page_array_ctrl_release(tlink->stream_mt, nr_released,
+					released_hpa)) {
+		pci_err(pdev, "fail to release IDE stream metadata pages\n");
+		goto leak;
+	}
+
+	goto out;
+
+leak:
+	tdx_page_array_ctrl_leak(tlink->stream_mt);
+out:
+	tlink->stream_mt = NULL;
+}
+
 static void tdx_ide_stream_teardown(struct tdx_link *tlink)
 {
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	struct pci_ide *ide = tlink->ide;
+
+	if (!ide)
+		return;
+
+	pci_ide_stream_disable(pdev, ide);
+	tsm_ide_stream_unregister(ide);
+	tdx_ide_stream_key_stop(tlink);
+	pci_ide_stream_teardown(pdev, ide);
+	pci_ide_stream_unregister(ide);
+	tdx_ide_stream_delete(tlink);
+	pci_ide_stream_free(tlink->ide);
+	tlink->ide = NULL;
 }
 
 static int tdx_ide_stream_setup(struct tdx_link *tlink)
 {
-	return -EOPNOTSUPP;
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	struct pci_ide *ide;
+	int ret;
+
+	ide = pci_ide_stream_alloc(pdev);
+	if (!ide)
+		return -ENOMEM;
+
+	/* Configure IDE capability for RP & get stream_id */
+	ret = tdx_ide_stream_create(tlink, ide);
+	if (ret)
+		goto stream_free;
+
+	ide->stream_id = tlink->stream_id;
+	ret = pci_ide_stream_register(ide);
+	if (ret)
+		goto tdx_stream_delete;
+
+	/* Configure IDE capability for target device */
+	pci_ide_stream_setup(pdev, ide);
+
+	/* Key Programming for RP & target device, enable IDE stream for RP */
+	ret = tdx_ide_stream_key_program(tlink);
+	if (ret)
+		goto stream_teardown;
+
+	ret = tsm_ide_stream_register(ide);
+	if (ret)
+		goto tdx_key_stop;
+
+	/* Enable IDE stream for target device */
+	pci_ide_stream_enable(pdev, ide);
+
+	tlink->ide = ide;
+
+	return 0;
+
+tdx_key_stop:
+	tdx_ide_stream_key_stop(tlink);
+stream_teardown:
+	pci_ide_stream_teardown(pdev, ide);
+	pci_ide_stream_unregister(ide);
+tdx_stream_delete:
+	tdx_ide_stream_delete(tlink);
+stream_free:
+	pci_ide_stream_free(tlink->ide);
+	tlink->ide = NULL;
+	return ret;
 }
 
 static void __tdx_link_disconnect(struct tdx_link *tlink)
-- 
2.51.0


