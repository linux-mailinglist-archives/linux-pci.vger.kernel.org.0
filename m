Return-Path: <linux-pci+bounces-8678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F579905A4C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01C41F23A48
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0885E1822FF;
	Wed, 12 Jun 2024 18:00:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD01822FC;
	Wed, 12 Jun 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215250; cv=none; b=VB6VOH0k5pgjl7NZJOO9lKExuuFsqB04h/z8TFOVFwwdFKLeceHFcrnwUMWFwdyn9F4O0FT+w2pgamc7DXM5IvvHKnvQIwIW8QH/+hYWgDdvkg1xrcll0QL9KWJ44kh0aaMI2664iRFDuGcgU78lE+zWybtp/QL0g2a3cFrXjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215250; c=relaxed/simple;
	bh=LWD4iZOUqQFvh0k1pR6nDI8pFCINP6Ql2GK0ulC2XqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXIJVqvZRiSt7d5DvzzVhJKs+x9NEnIxW0X/0N9h/DcTlXSTQ54ICzdOz55Mft8pdM8azzptnEXaOhC1NXIo/1u88hJu20cy64hohRWYosred76gbI8md62rZMA9Be4Tl9IdPqD4JPP89sm002WQ5dr9LKjzNtSRka0l5PIRi64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD90C116B1;
	Wed, 12 Jun 2024 18:00:50 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v4 1/2] cxl: Preserve the CDAT access_coordinate for an endpoint
Date: Wed, 12 Jun 2024 10:59:48 -0700
Message-ID: <20240612180046.1810907-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612180046.1810907-1-dave.jiang@intel.com>
References: <20240612180046.1810907-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the access_coordinate from the CDAT tables for region perf
calculations. The region perf calculation requires all participating
endpoints to have arrived in order to determine if there are limitations
of bandwidth data due to shared uplink.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 10 ++++++----
 drivers/cxl/cxlmem.h    |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bb83867d9fec..fea214340d4b 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -15,7 +15,7 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
-
+	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int entries;
 	int qos_class;
 };
@@ -163,7 +163,7 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 	val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
 			     dslbis->data_type);
 
-	cxl_access_coordinate_set(dent->coord, dslbis->data_type, val);
+	cxl_access_coordinate_set(dent->cdat_coord, dslbis->data_type, val);
 
 	return 0;
 }
@@ -220,7 +220,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	xa_for_each(dsmas_xa, index, dent) {
 		int qos_class;
 
-		cxl_coordinates_combine(dent->coord, dent->coord, ep_c);
+		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
 		dent->entries = 1;
 		rc = cxl_root->ops->qos_class(cxl_root,
 					      &dent->coord[ACCESS_COORDINATE_CPU],
@@ -241,8 +241,10 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 			      struct cxl_dpa_perf *dpa_perf)
 {
-	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		dpa_perf->coord[i] = dent->coord[i];
+		dpa_perf->cdat_coord[i] = dent->cdat_coord[i];
+	}
 	dpa_perf->dpa_range = dent->dpa_range;
 	dpa_perf->qos_class = dent->qos_class;
 	dev_dbg(dev,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 19aba81cdf13..fb365453f996 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -402,6 +402,7 @@ enum cxl_devtype {
 struct cxl_dpa_perf {
 	struct range dpa_range;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int qos_class;
 };
 
-- 
2.45.1


