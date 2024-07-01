Return-Path: <linux-pci+bounces-9544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807091EA7C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63C71F21955
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A4A17166C;
	Mon,  1 Jul 2024 21:50:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B32C1BA;
	Mon,  1 Jul 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719870624; cv=none; b=dbJFM9z+DlsT2qRv9kyBPsLmD+0GRDUMwO9KCZSI8PL2PsR86/FjSzkHKQkuKOQGkks3HlR/3HLpYITJBJ1DXB9IdhZwXH0JX+SuqSv4mc8JuKGQl5pUvqLtd/Cmhqi79os62L0T04NGDsixXhvAR99K6yQkrAJbkmj7V7h0NYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719870624; c=relaxed/simple;
	bh=fT0/sRkHm7fPK0p/6rwPu145uLQiojgEPidU3/dHWoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKNst1hZOYYiZNx7Tsj0gMzOGiZrVC8+tU3HqxTjr1jw7o+H51iYI5AqdwIsw02OAjp9esLC2W9QsOSFuelzvot5ZMrNYvlzT18MM9XXYzW1NLFVUZx13kPed9TdOms/Cf+nIIJP+2Rfk49M4YMpYCvOb8MFKMQH+Dw7PGatq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF1EC116B1;
	Mon,  1 Jul 2024 21:50:24 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v6 1/2] cxl: Preserve the CDAT access_coordinate for an endpoint
Date: Mon,  1 Jul 2024 14:49:14 -0700
Message-ID: <20240701215020.3813275-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240701215020.3813275-1-dave.jiang@intel.com>
References: <20240701215020.3813275-1-dave.jiang@intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Update kdoc (Ira)
---
 drivers/cxl/core/cdat.c | 10 ++++++----
 drivers/cxl/cxlmem.h    |  4 +++-
 2 files changed, 9 insertions(+), 5 deletions(-)

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
index 19aba81cdf13..a9c4af4ca78b 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -396,12 +396,14 @@ enum cxl_devtype {
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range - range for DPA address
- * @coord - QoS performance data (i.e. latency, bandwidth)
+ * @coord - calculated QoS performance data (i.e. latency, bandwidth)
+ * @cdat_coord - raw QoS performance data from CDAT
  * @qos_class - QoS Class cookies
  */
 struct cxl_dpa_perf {
 	struct range dpa_range;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int qos_class;
 };
 
-- 
2.45.1


