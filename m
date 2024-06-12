Return-Path: <linux-pci+bounces-8679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889D905A4D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F162840DB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC91822FC;
	Wed, 12 Jun 2024 18:00:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4A1822D5;
	Wed, 12 Jun 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215252; cv=none; b=Bf4xlDvR/+zfNiezMpPHN7vqDQ0gmp9owfmHLXjZqug7ui/8FPymMkAPVRUy8XElPfZ8M0QR0354hyA+RrHC4a5+heczzSiO5zoRrNjM8qnYB5aOdEZ0yEHM2orOah6zeVj6zQW477PYpucZZj1BCwsrQXv1k28oS2Tgc5DQlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215252; c=relaxed/simple;
	bh=jv9tWjWF9B1ePQJlPJcY4zaSL7tfgVK7qNO7sJFDMts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ke8ogP8M/cZ8q/L2XJBkEpP9UCTKaI20n5zrdncoqf4cKj1M0nzNsaF3JUe4R7Pb5dIcMov/TtqHFFhFHy0Ar0KY4gg2Fn0YcKL3ZPrnUnHcbtPSWoLtW+nqRLKC4kZu0Ywp5S7ndElaB92CH8OJicR8Y3i6hYDFjQe5WlJQFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E10C116B1;
	Wed, 12 Jun 2024 18:00:51 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v4 2/2] cxl: Calculate region bandwidth of targets with shared upstream link
Date: Wed, 12 Jun 2024 10:59:49 -0700
Message-ID: <20240612180046.1810907-3-dave.jiang@intel.com>
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

The current bandwidth calculation aggregates all the targets. This simple
method does not take into account where multiple targets sharing under
a switch where the aggregated bandwidth can be less or greater than the
upstream link of the switch.

To accurately account for the shared upstream uplink cases, a new update
function is introduced by walking from the leaves to the root of the
hierarchy and adjust the bandwidth in the process. This process is done
when all the targets for a region are present but before the final values
are send to the HMAT handling code cached access_coordinate targets.

The original perf calculation path was kept to calculate the configurations
without switches and also keep the latency data as that does not require
special calculation. The shared upstream link calculation is done as a
second pass when all the endpoints have arrived.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Deal with case of multiple RPs under same HB. (Jonathan)
  Change also pass no switch case through the same code path.
- Update layout graph with ACPI0016 (Alison)
- Fix over indentation (Jonathan)
- Move allocated context variable to scope. (Jonathan)
- Remove unnecessary casting. (Jonathan)
- Fixup in code comments. (Jonathan)
---
 drivers/cxl/core/cdat.c   | 452 ++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/core.h   |   4 +-
 drivers/cxl/core/pci.c    |  23 ++
 drivers/cxl/core/port.c   |  22 +-
 drivers/cxl/core/region.c |   4 +
 drivers/cxl/cxl.h         |   1 +
 6 files changed, 487 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index fea214340d4b..5bbea2b3c17b 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -548,32 +548,450 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 MODULE_IMPORT_NS(CXL);
 
-void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
-				    struct cxl_endpoint_decoder *cxled)
+static void cxl_bandwidth_add(struct access_coordinate *coord,
+			      struct access_coordinate *c1,
+			      struct access_coordinate *c2)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct range dpa = {
-			.start = cxled->dpa_res->start,
-			.end = cxled->dpa_res->end,
-	};
-	struct cxl_dpa_perf *perf;
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		coord[i].read_bandwidth = c1[i].read_bandwidth +
+					  c2[i].read_bandwidth;
+		coord[i].write_bandwidth = c1[i].write_bandwidth +
+					   c2[i].write_bandwidth;
+	}
+}
 
-	switch (cxlr->mode) {
+struct cxl_perf_ctx {
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	int active_rps;
+};
+
+static struct cxl_dpa_perf *cxl_memdev_get_dpa_perf(struct cxl_memdev_state *mds,
+						    enum cxl_decoder_mode mode)
+{
+	switch (mode) {
 	case CXL_DECODER_RAM:
-		perf = &mds->ram_perf;
-		break;
+		return &mds->ram_perf;
 	case CXL_DECODER_PMEM:
-		perf = &mds->pmem_perf;
-		break;
+		return &mds->pmem_perf;
 	default:
-		return;
+		break;
 	}
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	return ERR_PTR(-EINVAL);
+}
+
+static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
+			      struct resource *dpa_res)
+{
+	struct range dpa = {
+		.start = dpa_res->start,
+		.end = dpa_res->end,
+	};
 
 	if (!range_contains(&perf->dpa_range, &dpa))
+		return false;
+
+	return true;
+}
+
+static int cxl_endpoint_gather_coordinates(struct cxl_region *cxlr,
+					   struct cxl_endpoint_decoder *cxled,
+					   struct xarray *usp_xa)
+{
+	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
+	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct cxl_port *parent_port, *gp_port;
+	struct cxl_perf_ctx *perf_ctx;
+	struct cxl_dpa_perf *perf;
+	bool gp_is_root;
+	unsigned long index;
+	void *ptr;
+	int rc;
+
+	if (cxlds->rcd)
+		return -ENODEV;
+
+	parent_port = to_cxl_port(endpoint->dev.parent);
+	gp_port = to_cxl_port(parent_port->dev.parent);
+	if (is_cxl_root(gp_port))
+		gp_is_root = true;
+
+	perf = cxl_memdev_get_dpa_perf(mds, cxlr->mode);
+	if (IS_ERR(perf))
+		return PTR_ERR(perf);
+
+	if (!dpa_perf_contains(perf, cxled->dpa_res))
+		return -EINVAL;
+
+	/*
+	 * The index for the xarray is the upstream port device of the upstream
+	 * CXL switch.
+	 */
+	index = (unsigned long)parent_port->uport_dev;
+	perf_ctx = xa_load(usp_xa, index);
+	if (!perf_ctx) {
+		struct cxl_perf_ctx *c __free(kfree) =
+			kzalloc(sizeof(*perf_ctx), GFP_KERNEL);
+
+		if (!c)
+			return -ENOMEM;
+		ptr = xa_store(usp_xa, index, c, GFP_KERNEL);
+		if (xa_is_err(ptr))
+			return xa_err(ptr);
+		perf_ctx = no_free_ptr(c);
+	}
+
+	/* Direct upstream link from EP bandwidth */
+	rc = cxl_pci_get_bandwidth(pdev, pci_coord);
+	if (rc < 0)
+		return rc;
+
+	/*
+	 * Min of upstream link bandwidth and Endpoint CDAT bandwidth from
+	 * DSLBIS.
+	 */
+	cxl_coordinates_combine(ep_coord, pci_coord, perf->cdat_coord);
+
+	/*
+	 * If grandparent port is root, then there's no switch involved and
+	 * the endpoint is connected to a root port.
+	 */
+	if (!gp_is_root) {
+		/*
+		 * Retrieve the switch SSLBIS for switch downstream port
+		 * associated with the endpoint bandwidth.
+		 */
+		rc = cxl_port_get_switch_dport_bandwidth(endpoint, sw_coord);
+		if (rc)
+			return rc;
+
+		/*
+		 * Min of the earlier coordinates with the switch SSLBIS
+		 * bandwidth
+		 */
+		cxl_coordinates_combine(ep_coord, ep_coord, sw_coord);
+	}
+
+	/*
+	 * Aggregate the computed bandwidth with the current aggregated bandwidth
+	 * of the endpoints with the same switch upstream port.
+	 */
+	cxl_bandwidth_add(perf_ctx->coord, perf_ctx->coord, ep_coord);
+	perf_ctx->port = parent_port;
+	perf_ctx->dport = parent_port->parent_dport;
+
+	/* Count the active RPs */
+	if (gp_is_root)
+		perf_ctx->active_rps++;
+
+	return 0;
+}
+
+static int count_rootport(struct device *dev, void *data)
+{
+	struct pci_dev *pdev;
+	int *total = data;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
+		(*total)++;
+
+	return 0;
+}
+
+static struct xarray *cxl_switch_iterate_coordinates(struct xarray *input_xa,
+						     bool *parent_is_root)
+{
+	struct xarray *res_xa __free(kfree) = kzalloc(sizeof(*res_xa), GFP_KERNEL);
+	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
+	struct cxl_perf_ctx *ctx, *us_ctx;
+	unsigned long index, us_index;
+	void *ptr;
+	int rc;
+
+	if (!res_xa)
+		return ERR_PTR(-ENOMEM);
+	xa_init(res_xa);
+
+	*parent_is_root = false;
+	xa_for_each(input_xa, index, ctx) {
+		struct cxl_port *parent_port, *port, *gp_port;
+		struct device *dev = (struct device *)index;
+		struct cxl_dport *dport;
+		struct pci_dev *pdev;
+		bool gp_is_root;
+
+		gp_is_root = false;
+		port = ctx->port;
+		parent_port = to_cxl_port(port->dev.parent);
+		if (is_cxl_root(parent_port)) {
+			*parent_is_root = true;
+		} else {
+			gp_port = to_cxl_port(parent_port->dev.parent);
+			gp_is_root = is_cxl_root(gp_port);
+		}
+
+		dport = port->parent_dport;
+
+		/*
+		 * Create an xarray entry with the key of the upstream
+		 * port of the upstream switch.
+		 */
+		us_index = (unsigned long)parent_port->uport_dev;
+		us_ctx = xa_load(res_xa, us_index);
+		if (!us_ctx) {
+			struct cxl_perf_ctx *n __free(kfree) =
+				kzalloc(sizeof(*n), GFP_KERNEL);
+
+			if (!n)
+				return ERR_PTR(-ENOMEM);
+
+			ptr = xa_store(res_xa, us_index, n, GFP_KERNEL);
+			if (xa_is_err(ptr))
+				return ERR_PTR(xa_err(ptr));
+			us_ctx = no_free_ptr(n);
+		}
+
+		/* Count the active RPs */
+		if (gp_is_root)
+			us_ctx->active_rps++;
+
+		us_ctx->port = parent_port;
+		us_ctx->dport = parent_port->parent_dport;
+
+		if (*parent_is_root) {
+			int total_rps = 0;
+
+			/* Figure out how many RPs are under the host bridge */
+			device_for_each_child(dport->dport_dev, &total_rps,
+					      count_rootport);
+
+			if (!total_rps || total_rps < ctx->active_rps)
+				return ERR_PTR(-EINVAL);
+
+			/*
+			 * Determine the actual upstream link bandwidth by the
+			 * total RPs * active under the HB of the region.
+			 */
+			for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+				us_ctx->coord[i].read_bandwidth =
+					us_ctx->coord[i].read_bandwidth +
+					min(dport->coord[i].read_bandwidth /
+					    total_rps * ctx->active_rps,
+					    ctx->coord[i].read_bandwidth);
+				us_ctx->coord[i].write_bandwidth =
+					us_ctx->coord[i].read_bandwidth +
+					min(dport->coord[i].write_bandwidth /
+					    total_rps * ctx->active_rps,
+					    ctx->coord[i].write_bandwidth);
+			}
+
+			continue;
+		}
+
+		/* Below is the calculation for another switch upstream */
+
+		/*
+		 * If the device isn't an upstream PCIe port, there's something
+		 * wrong with the topology.
+		 */
+		if (!dev_is_pci(dev))
+			return ERR_PTR(-EINVAL);
+
+		/* Retrieve the upstream link bandwidth */
+		pdev = to_pci_dev(dev);
+		rc = cxl_pci_get_bandwidth(pdev, coords);
+		if (rc)
+			return ERR_PTR(-ENXIO);
+
+		/*
+		 * Take the min of downstream bandwidth and the upstream link
+		 * bandwidth.
+		 */
+		cxl_coordinates_combine(coords, coords, ctx->coord);
+		/*
+		 * Take the min of the calculated bandwdith and the upstream
+		 * switch SSLBIS bandwidth.
+		 */
+		cxl_coordinates_combine(coords, coords, dport->coord);
+
+		/*
+		 * Aggregate the bandwidth based on the upstream switch.
+		 */
+		cxl_bandwidth_add(us_ctx->coord, us_ctx->coord, coords);
+	}
+
+	return_ptr(res_xa);
+}
+
+static void cxl_region_update_access_coordinate(struct cxl_region *cxlr,
+						struct xarray *input_xa)
+{
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct cxl_perf_ctx *ctx;
+	unsigned long index;
+
+	memset(coord, 0, sizeof(coord));
+	xa_for_each(input_xa, index, ctx)
+		cxl_bandwidth_add(coord, coord, ctx->coord);
+
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		cxlr->coord[i].read_bandwidth = coord[i].read_bandwidth;
+		cxlr->coord[i].write_bandwidth = coord[i].write_bandwidth;
+	}
+}
+
+static void free_perf_xa(struct xarray *xa)
+{
+	struct cxl_perf_ctx *ctx;
+	unsigned long index;
+
+	if (!xa)
+		return;
+
+	xa_for_each(xa, index, ctx)
+		kfree(ctx);
+	xa_destroy(xa);
+	kfree(xa);
+}
+
+/*
+ * cxl_region_shared_upstream_perf_update - Recalculate the access coordinates
+ * @cxl_region: the cxl region to recalculate
+ *
+ * For certain region construction with endpoints behind CXL switches,
+ * there is the possibility of the total bandwdith for all the endpoints
+ * behind a switch being less or more than the switch upstream link. The
+ * algorithm assumes the configuration is a symmetric topology as that
+ * maximizes performance.
+ *
+ * There can be multiple switches under a RP. There can be multiple RPs under
+ * a HB.
+ *
+ * An example hierarchy:
+ *
+ *                 CFMWS 0
+ *                   |
+ *          _________|_________
+ *         |                   |
+ *     ACPI0017-0          ACPI0017-1
+ *  GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
+ *     |          |        |           |
+ *    RP0        RP1      RP2         RP3
+ *     |          |        |           |
+ *   SW 0       SW 1     SW 2        SW 3
+ *   |   |      |   |    |   |       |   |
+ *  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
+ *
+ * Computation for the example hierarchy:
+ *
+ * Min (GP0 to CPU BW / total RPs * active RPs,
+ *      Min(SW 0 Upstream Link to RP0 BW,
+ *          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
+ *          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
+ *      Min(SW 1 Upstream Link to RP1 BW,
+ *          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
+ *          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
+ * Min (GP1 to CPU BW / total RPs * active RPs,
+ *      Min(SW 2 Upstream Link to RP2 BW,
+ *          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
+ *          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
+ *      Min(SW 3 Upstream Link to RP3 BW,
+ *          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
+ *          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))
+ */
+void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr)
+{
+	struct xarray *usp_xa, *iter_xa, *working_xa;
+	bool is_root;
+	int rc;
+
+	lockdep_assert_held(&cxl_dpa_rwsem);
+
+	usp_xa = kzalloc(sizeof(*usp_xa), GFP_KERNEL);
+	if (!usp_xa)
+		return;
+
+	xa_init(usp_xa);
+
+	/*
+	 * Collect aggregated endpoint bandwidth and store the bandwidth in
+	 * an xarray indexed by the upstream port of the switch or RP. The
+	 * bandwidth is aggregated per switch. Each endpoint consists of the
+	 * minimum of bandwidth from DSLBIS from the endpoint CDAT, the endpoint
+	 * upstream link bandwidth, and the bandwidth from the SSLBIS of the
+	 * switch CDAT for the switch upstream port to the downstream port that's
+	 * associated with the endpoint. If the device is directly connected to
+	 * a RP, then no SSLBIS is involved.
+	 */
+	for (int i = 0; i < cxlr->params.nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = cxlr->params.targets[i];
+
+		rc = cxl_endpoint_gather_coordinates(cxlr, cxled, usp_xa);
+		if (rc) {
+			free_perf_xa(usp_xa);
+			return;
+		}
+	}
+
+	iter_xa = usp_xa;
+	usp_xa = NULL;
+	/*
+	 * Iterate through the components in the xarray and aggregate any
+	 * component that share the same upstream link from the switch.
+	 * The iteration takes consideration of multi-level switch
+	 * hierarchy.
+	 *
+	 * When cxl_switch_iterate_coordinates() detect the grandparent
+	 * upstream is a root port, it updates the bandwidth in the
+	 * xarray by taking the min of the provided bandwidth and
+	 * the bandwidth from the generic port (divided by the total
+	 * RPs and multiplied by the number of involved RPs). is_root
+	 * is set if the parent port is the cxl root.
+	 */
+	do {
+		working_xa = cxl_switch_iterate_coordinates(iter_xa, &is_root);
+		if (IS_ERR(working_xa))
+			goto out;
+		free_perf_xa(iter_xa);
+		iter_xa = working_xa;
+	} while (!is_root);
+
+	/*
+	 * Aggregate the bandwidths in the xarray (for all the HBs) and update
+	 * the region bandwidths with the newly calculated bandwidths.
+	 */
+	cxl_region_update_access_coordinate(cxlr, iter_xa);
+
+out:
+	free_perf_xa(iter_xa);
+}
+
+void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
+				    struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_dpa_perf *perf;
+
+	perf = cxl_memdev_get_dpa_perf(mds, cxlr->mode);
+	if (IS_ERR(perf))
+		return;
+
+	lockdep_assert_held(&cxl_dpa_rwsem);
+
+	if (!dpa_perf_contains(perf, cxled->dpa_res))
 		return;
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 625394486459..c72a7b9f5e21 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -103,9 +103,11 @@ enum cxl_poison_trace_type {
 };
 
 long cxl_pci_get_latency(struct pci_dev *pdev);
-
+int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
 bool cxl_need_node_perf_attrs_update(int nid);
+int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
+					struct access_coordinate *c);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8567dd11eaac..d5cca493bb20 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1074,3 +1074,26 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 				     __cxl_endpoint_decoder_reset_detected);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
+
+int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
+{
+	int speed, bw;
+	u16 lnksta;
+	u32 width;
+
+	speed = pcie_link_speed_mbps(pdev);
+	if (speed < 0)
+		return -ENXIO;
+	speed /= BITS_PER_BYTE;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+	bw = speed * width;
+
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		c[i].read_bandwidth = bw;
+		c[i].write_bandwidth = bw;
+	}
+
+	return 0;
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 887ed6e358fb..2d55843e63bf 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2196,7 +2196,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		},
 	};
 	struct cxl_port *iter = port;
-	struct cxl_dport *dport;
+	struct cxl_dport *dport = port->parent_dport;
 	struct pci_dev *pdev;
 	struct device *dev;
 	unsigned int bw;
@@ -2259,6 +2259,26 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_perf_coordinates, CXL);
 
+int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
+					struct access_coordinate *c)
+{
+	struct cxl_dport *dport = port->parent_dport;
+
+	/* Check this port is connected to a switch DSP and not an RP */
+	if (parent_port_is_cxl_root(to_cxl_port(port->dev.parent)))
+		return -ENODEV;
+
+	if (!coordinates_valid(dport->coord))
+		return -EINVAL;
+
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		c[i].read_bandwidth = dport->coord[i].read_bandwidth;
+		c[i].write_bandwidth = dport->coord[i].write_bandwidth;
+	}
+
+	return 0;
+}
+
 /* for user tooling to ensure port disable work has completed */
 static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
 {
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c2b6144be23..e8b8635ae8ce 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3281,6 +3281,10 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
+	down_read(&cxl_dpa_rwsem);
+	cxl_region_shared_upstream_perf_update(cxlr);
+	up_read(&cxl_dpa_rwsem);
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 603c0120cff8..34e83a6c55a1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -891,6 +891,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
 void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 				    struct cxl_endpoint_decoder *cxled);
+void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr);
 
 void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
 
-- 
2.45.1


