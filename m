Return-Path: <linux-pci+bounces-8937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F57C90DFBD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603821C225D5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE4178CCD;
	Tue, 18 Jun 2024 23:17:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E113A418;
	Tue, 18 Jun 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752654; cv=none; b=Cu0Ttrx/y0IolKyCOumtOAdkq/oaz8nXK6MHXb5D32glJyoWSq7VVuCCxqIytEmv02E32McL6Q9M3GOwMDz5m+TKaNeugRvS0b1npIy8u24Htl+RDjElwTCoRycIqb3sOwKpHRIGsghKprJmO30befhDOI1aGEyE52xNxVYBw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752654; c=relaxed/simple;
	bh=LWD4iZOUqQFvh0k1pR6nDI8pFCINP6Ql2GK0ulC2XqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uee6CTLv/DQLFTORNk1ALqedjyUF72HzZJNVNjg+TAd33TmV6zKqShW7ypDhKVCxfWdmkVubltZYe3+8E4knK+JB0M2f0OebQV5URAernPhvlcQPYXl91F+VMZToArSXxUbLsZZ8do7AnfWE0g2eGlwg3bN8UM9JPyef8S4UNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDDCC3277B;
	Tue, 18 Jun 2024 23:17:34 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v5 1/2] cxl: Preserve the CDAT access_coordinate for an endpoint
Date: Tue, 18 Jun 2024 16:16:40 -0700
Message-ID: <20240618231730.2533819-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618231730.2533819-1-dave.jiang@intel.com>
References: <20240618231730.2533819-1-dave.jiang@intel.com>
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


